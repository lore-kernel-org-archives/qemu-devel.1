Received: from eggs.gnu.org ([2001:4830:134:3::10]:42546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRcDM-0001f3-05
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRcDI-0002MV-QY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:11:39 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRcDI-0002LU-KH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:11:36 -0500
Received: by mail-wr1-x443.google.com with SMTP id c14so16802600wrr.0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 04:11:36 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-42-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-42-cota@braap.org>
Date: Tue, 27 Nov 2018 12:11:32 +0000
Message-ID: <87h8g24t57.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 41/48] configure: add --enable-plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> For now only add it for ELF platforms, since we rely on the linker's
> --dynamic-list flag to pass a list of symbols to be exported to the
> executable. An alternative would be to use -rdynamic, but that would
> expose all of QEMU's objects to plugins.
>
> I have no experience with non-ELF systems but I suspect adding support
> for those should be pretty easy.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

As far as the configure logic is concerned:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I'm not quite following what is so special about the dynamic-list
symbols compared to the rest of the symbols in the binary. when I do
readelf -s they are all specified as GLOBAL DEFAULT.

Perhaps this will become clearer to me once I get to the implementation
of the plugins later in the series?


> ---
>  configure | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/configure b/configure
> index 03bf719ca7..78e86098e5 100755
> --- a/configure
> +++ b/configure
> @@ -30,6 +30,7 @@ TMPO=3D"${TMPDIR1}/${TMPB}.o"
>  TMPCXX=3D"${TMPDIR1}/${TMPB}.cxx"
>  TMPE=3D"${TMPDIR1}/${TMPB}.exe"
>  TMPMO=3D"${TMPDIR1}/${TMPB}.mo"
> +TMPTXT=3D"${TMPDIR1}/${TMPB}.txt"
>
>  rm -f config.log
>
> @@ -477,6 +478,7 @@ libxml2=3D""
>  docker=3D"no"
>  debug_mutex=3D"no"
>  libpmem=3D""
> +plugins=3D"no"
>
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
>  cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
> @@ -1443,6 +1445,10 @@ for opt do
>    ;;
>    --disable-libpmem) libpmem=3Dno
>    ;;
> +  --enable-plugins) plugins=3D"yes"
> +  ;;
> +  --disable-plugins) plugins=3D"no"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1633,6 +1639,8 @@ Advanced options (experts only):
>                             xen pv domain builder
>    --enable-debug-stack-usage
>                             track the maximum stack usage of stacks creat=
ed by qemu_alloc_stack
> +  --enable-plugins
> +                           enable plugins via shared library loading
>
>  Optional features, enabled with --enable-FEATURE and
>  disabled with --disable-FEATURE, default is enabled if available:
> @@ -5204,6 +5212,42 @@ if compile_prog "" "" ; then
>    atomic64=3Dyes
>  fi
>
> +#########################################
> +# See if --dynamic-list is supported by the linker
> +
> +cat > $TMPTXT <<EOF
> +{
> +  foo;
> +};
> +EOF
> +
> +cat > $TMPC <<EOF
> +#include <stdio.h>
> +void foo(void);
> +
> +void foo(void)
> +{
> +  printf("foo\n");
> +}
> +
> +int main(void)
> +{
> +  foo();
> +  return 0;
> +}
> +EOF
> +
> +if compile_prog "" "-Wl,--dynamic-list=3D$TMPTXT" ; then
> +  ld_dynamic_list=3D"yes"
> +else
> +  if test "$plugins" =3D "yes" ; then
> +    error_exit \
> +        "Plugin support requires specifying a set of symbols that " \
> +        "are exported to plugins. Unfortunately your linker doesn't " \
> +        "support the flag (--dynamic-list) used for this purpose."
> +  fi
> +fi
> +
>  ########################################
>  # See if 16-byte vector operations are supported.
>  # Even without a vector unit the compiler may expand these.
> @@ -6091,6 +6135,7 @@ echo "VxHS block device $vxhs"
>  echo "capstone          $capstone"
>  echo "docker            $docker"
>  echo "libpmem support   $libpmem"
> +echo "plugin support    $plugins"
>
>  if test "$sdl_too_old" =3D "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL suppor=
t"
> @@ -6849,6 +6894,12 @@ if test "$libpmem" =3D "yes" ; then
>    echo "CONFIG_LIBPMEM=3Dy" >> $config_host_mak
>  fi
>
> +if test "$plugins" =3D "yes" ; then
> +    echo "CONFIG_PLUGINS=3Dy" >> $config_host_mak
> +    LIBS=3D"-ldl $LIBS"
> +    LDFLAGS=3D"-Wl,--dynamic-list=3D\$(SRC_PATH)/qemu-plugins.symbols $L=
DFLAGS"
> +fi
> +
>  if test "$tcg_interpreter" =3D "yes"; then
>    QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
>  elif test "$ARCH" =3D "sparc64" ; then


--
Alex Benn=C3=A9e
