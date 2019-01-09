Received: from eggs.gnu.org ([209.51.188.92]:39774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghEtG-0001FH-Nw
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghEtF-0002Nc-9B
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:31:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghEtF-0002NQ-0r
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:31:29 -0500
Date: Wed, 9 Jan 2019 14:31:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109143122.GR3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547043869-10520-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547043869-10520-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] configure: Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>

On Wed, Jan 09, 2019 at 03:24:29PM +0100, Thomas Huth wrote:
> Different versions of GCC and Clang use different versions of the C sta=
ndard.
> This repeatedly caused problems already, e.g. with duplicated typedefs:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
>=20
> or with for-loop variable initializers:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
>=20
> To avoid these problems, we should enforce the C language version to th=
e
> same level for all compilers. Since our minimum compiler versions is
> GCC v4.8, our best option is "gnu99" right now ("gnu17" is not availabl=
e
> there yet, and "gnu11" is marked as "experimental").
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use gnu99 instead of gnu11
>=20
>  configure | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/configure b/configure
> index b9f34af..721ade7 100755
> --- a/configure
> +++ b/configure
> @@ -105,7 +105,8 @@ update_cxxflags() {
>      for arg in $QEMU_CFLAGS; do
>          case $arg in
>              -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|=
\
> -            -Wold-style-declaration|-Wold-style-definition|-Wredundant=
-decls)
> +            -Wold-style-declaration|-Wold-style-definition|-Wredundant=
-decls|\
> +            -std=3Dgnu99)

IIUC this is to  drop  -std=3Dgnu99 from CXXFLAGS, so C++ code (only the
guest-agent on Win32 IIUC) will use the compiler default still. No worse
than what we have today.

We could consider also setting a suitable -std for CXXFLAGS too in future
though...

>                  ;;
>              *)
>                  QEMU_CXXFLAGS=3D${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
> @@ -585,7 +586,7 @@ ARFLAGS=3D"${ARFLAGS-rv}"
>  # left shift of signed integers is well defined and has the expected
>  # 2s-complement style results. (Both clang and gcc agree that it
>  # provides these semantics.)
> -QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
> +QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99 $=
QEMU_CFLAGS"
>  QEMU_CFLAGS=3D"-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEM=
U_CFLAGS"
>  QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
>  QEMU_CFLAGS=3D"-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOU=
RCE $QEMU_CFLAGS"

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
