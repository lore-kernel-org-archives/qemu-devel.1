Received: from eggs.gnu.org ([2001:4830:134:3::10]:37428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7wau-0005Cg-T3
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 01:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7waq-0007DI-MB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 01:22:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f7waq-0007D7-I7
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 01:22:20 -0400
References: <20180415230522.24404-1-f4bug@amsat.org>
	<20180415230522.24404-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2bbdc92c-6834-07ea-0cf1-90e7507358d1@redhat.com>
Date: Mon, 16 Apr 2018 07:22:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180415230522.24404-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12? 1/4] configure: Really use local
 libfdt if the system one is too old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, YunQiang Su <syq@debian.org>, David Gibson <david@gibson.dropbear.id.au>

On 16.04.2018 01:05, Philippe Mathieu-Daud=C3=A9 wrote:
> QEMU requires libfdt version >=3D 1.4.2.
> If the host has an older libfdt installed, the configure script will us=
e
> a (git cloned) local version.
>=20
> Example with Debian 8:
>     $ dpkg-query --showformat=3D'${Version}\n' --show libfdt-dev
>     1.4.0+dfsg-1
>     $ ./configure
>     [...]
>     fdt support       yes          # from git submodule 'dtc'
>=20
> If this case occurs, the linker will have 2 different libfdt available =
in
> the library search path. The default behavior is to search the system p=
ath
> first, then the local path.
>=20
> Even if the configure script noticed the libfdt is too old and clone a =
more
> recent locally, when linking the system library is selected first, and =
the
> link process eventually fails:
>=20
>       LINK    mips64el-softmmu/qemu-system-mips64el
>     ../hw/core/loader-fit.o: In function `load_fit':
>     /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:278: undefine=
d reference to `fdt_first_subnode'
>     /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:286: undefine=
d reference to `fdt_next_subnode'
>     /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:277: undefine=
d reference to `fdt_first_subnode'
>     collect2: error: ld returned 1 exit status
>     Makefile:201: recipe for target 'qemu-system-mips64el' failed
>     make[1]: *** [qemu-system-mips64el] Error 1
>=20
> QEMU already uses a kludge to enforce local CFLAGS before system ones f=
or
> libpixman and libfdt, add a similar kludge for the LDFLAGS to enforce u=
sing
> the local libfdt.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 6 +++++-
>  rules.mak | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/configure b/configure
> index 0a19b033bc..162e804b49 100755
> --- a/configure
> +++ b/configure
> @@ -3773,7 +3773,8 @@ EOF
>                symlink "$source_path/dtc/scripts" "dtc/scripts"
>            fi
>            fdt_cflags=3D"-I\$(SRC_PATH)/dtc/libfdt"
> -          fdt_libs=3D"-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
> +          fdt_ldflags=3D"-L\$(BUILD_DIR)/dtc/libfdt"
> +          fdt_libs=3D"$fdt_libs"
>        elif test "$fdt" =3D "yes" ; then
>            # Not a git build & no libfdt found, prompt for system insta=
ll
>            error_exit "DTC (libfdt) version >=3D 1.4.2 not present." \
> @@ -5715,6 +5716,7 @@ echo_version() {
> =20
>  # prepend pixman and ftd flags after all config tests are done
>  QEMU_CFLAGS=3D"$pixman_cflags $fdt_cflags $QEMU_CFLAGS"
> +QEMU_LDFLAGS=3D"$fdt_ldflags $QEMU_LDFLAGS"
>  libs_softmmu=3D"$pixman_libs $libs_softmmu"

I think the pixman lines could be removed now that we do not have an
internal pixman version anymore (but that's something for a separate patc=
h)

>  echo "Install prefix    $prefix"
> @@ -5745,6 +5747,7 @@ echo "ARFLAGS           $ARFLAGS"
>  echo "CFLAGS            $CFLAGS"
>  echo "QEMU_CFLAGS       $QEMU_CFLAGS"
>  echo "LDFLAGS           $LDFLAGS"
> +echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
>  echo "make              $make"
>  echo "install           $install"
>  echo "python            $python"
> @@ -6679,6 +6682,7 @@ else
>  fi
>  echo "LDFLAGS=3D$LDFLAGS" >> $config_host_mak
>  echo "LDFLAGS_NOPIE=3D$LDFLAGS_NOPIE" >> $config_host_mak
> +echo "QEMU_LDFLAGS=3D$QEMU_LDFLAGS" >> $config_host_mak
>  echo "LD_REL_FLAGS=3D$LD_REL_FLAGS" >> $config_host_mak
>  echo "LD_I386_EMULATION=3D$ld_i386_emulation" >> $config_host_mak
>  echo "LIBS+=3D$LIBS" >> $config_host_mak
> diff --git a/rules.mak b/rules.mak
> index 93a07027b0..04c7f74d07 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -73,7 +73,7 @@ expand-objs =3D $(strip $(sort $(filter %.o,$1)) \
>  # must link with the C++ compiler, not the plain C compiler.
>  LINKPROG =3D $(or $(CXX),$(CC))
> =20
> -LINK =3D $(call quiet-command, $(LINKPROG) $(QEMU_CFLAGS) $(CFLAGS) $(=
LDFLAGS) -o $@ \
> +LINK =3D $(call quiet-command, $(LINKPROG) $(QEMU_LDFLAGS) $(QEMU_CFLA=
GS) $(CFLAGS) $(LDFLAGS) -o $@ \
>         $(call process-archive-undefs, $1) \
>         $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARG=
ET_DIR)$@")

Looks reasonable.

Reviewed-by: Thomas Huth <thuth@redhat.com>
