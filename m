Received: from eggs.gnu.org ([2001:4830:134:3::10]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gRcie-0004ZR-Cn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gRcib-0003qA-3I
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:44:00 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:51356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gRcia-0003op-MV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:43:57 -0500
Date: Tue, 27 Nov 2018 15:43:52 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20181127124352.ll6quqc5xedvdqht@MacBook-Pro-Roman.local>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-42-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181025172057.20414-42-cota@braap.org>
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@gmail.com>

On Thu, Oct 25, 2018 at 01:20:50PM -0400, Emilio G. Cota wrote:
> For now only add it for ELF platforms, since we rely on the linker's
> --dynamic-list flag to pass a list of symbols to be exported to the
> executable. An alternative would be to use -rdynamic, but that would
> expose all of QEMU's objects to plugins.
> 
> I have no experience with non-ELF systems but I suspect adding support
> for those should be pretty easy.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  configure | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/configure b/configure
> index 03bf719ca7..78e86098e5 100755
> --- a/configure
> +++ b/configure
> @@ -30,6 +30,7 @@ TMPO="${TMPDIR1}/${TMPB}.o"
>  TMPCXX="${TMPDIR1}/${TMPB}.cxx"
>  TMPE="${TMPDIR1}/${TMPB}.exe"
>  TMPMO="${TMPDIR1}/${TMPB}.mo"
> +TMPTXT="${TMPDIR1}/${TMPB}.txt"
>  
>  rm -f config.log
>  
> @@ -477,6 +478,7 @@ libxml2=""
>  docker="no"
>  debug_mutex="no"
>  libpmem=""
> +plugins="no"
>  
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
>  cross_cc_aarch64="aarch64-linux-gnu-gcc"
> @@ -1443,6 +1445,10 @@ for opt do
>    ;;
>    --disable-libpmem) libpmem=no
>    ;;
> +  --enable-plugins) plugins="yes"
> +  ;;
> +  --disable-plugins) plugins="no"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1633,6 +1639,8 @@ Advanced options (experts only):
>                             xen pv domain builder
>    --enable-debug-stack-usage
>                             track the maximum stack usage of stacks created by qemu_alloc_stack
> +  --enable-plugins
> +                           enable plugins via shared library loading
>  
>  Optional features, enabled with --enable-FEATURE and
>  disabled with --disable-FEATURE, default is enabled if available:
> @@ -5204,6 +5212,42 @@ if compile_prog "" "" ; then
>    atomic64=yes
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
> +if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
> +  ld_dynamic_list="yes"
> +else
> +  if test "$plugins" = "yes" ; then
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
>  if test "$sdl_too_old" = "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
> @@ -6849,6 +6894,12 @@ if test "$libpmem" = "yes" ; then
>    echo "CONFIG_LIBPMEM=y" >> $config_host_mak
>  fi
>  
> +if test "$plugins" = "yes" ; then
> +    echo "CONFIG_PLUGINS=y" >> $config_host_mak
> +    LIBS="-ldl $LIBS"
> +    LDFLAGS="-Wl,--dynamic-list=\$(SRC_PATH)/qemu-plugins.symbols $LDFLAGS"
> +fi
> +
>  if test "$tcg_interpreter" = "yes"; then
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
>  elif test "$ARCH" = "sparc64" ; then
> -- 
> 2.17.1
> 
> 

ld64 on macOS has similar -exported_symbols_list option. Here's the reference:

     -exported_symbols_list filename
	The specified filename contains a list of global symbol names
	that will remain as global symbols in the output file.  All other
	global symbols will be treated as if they were marked as
	__private_extern__ (aka visibility=hidden) and will not be global in
	the output file. The symbol names listed in filename must be one per
	line.  Leading and trailing white space are not part of the symbol
	name.  Lines starting with # are ignored, as are lines with only white
	space.  Some wildcards (similar to shell file matching) are supported.
	The * matches zero or more characters.  The ?  matches one character.
	[abc] matches one character which must be an 'a', 'b', or 'c'.
	[a-z] matches any single lower case letter from 'a' to 'z'.


I can try your branch if you add support of the linker flag or send required
changes via GitHub.

Best regards,
Roman
