Received: from eggs.gnu.org ([2001:4830:134:3::10]:35036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9yod-0006aa-P8
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9yoZ-0006Lv-O3
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:36:43 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:43519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9yoZ-0006LH-KO
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:36:39 -0400
Received: by mail-qk0-x241.google.com with SMTP id w134so4124954qkb.0
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 12:36:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <81734112-f8f6-bd49-f43d-77dbdfc34c46@amsat.org>
Date: Wed, 1 Nov 2017 16:36:36 -0300
MIME-Version: 1.0
In-Reply-To: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] configure: do CC check before verifying
 host CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com

Maybe "configure: check $CC available before verifying host CPU" ?

On 11/01/2017 04:31 PM, Daniel Henrique Barboza wrote:
> When executing 'configure' in a fresh QEMU clone, in a fresh
> OS install running in a ppc64le host, this is the error
> shown:
> 
> -----
> 
> ../configure --enable-trace-backend=simple --enable-debug
>     --target-list=ppc64-softmmu
> 
> ERROR: Unsupported CPU = ppc64le, try --enable-tcg-interpreter
> 
> -----
> 
> This isn't true, ppc64le host CPU is supported. This happens because,
> in a fresh install, we don't have a C compiler to autodetect
> the $cpu variable to "ppc64".
> 
> Since we need a C compiler to properly get the value of $cpu
> in this and other cases, this patch changes the location of the C
> compiler check right after setting the preferred CC.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  configure | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/configure b/configure
> index 285d123dbf..a641bf18b6 100755
> --- a/configure
> +++ b/configure
> @@ -467,6 +467,23 @@ else
>    cc="${CC-${cross_prefix}gcc}"
>  fi
>  
> +write_c_skeleton() {
> +    cat > $TMPC <<EOF
> +int main(void) { return 0; }
> +EOF
> +}
> +
> +# check that the C compiler works.
> +write_c_skeleton;
> +if compile_object ; then
> +  : C compiler works ok
> +else
> +    error_exit "\"$cc\" either does not exist or does not work"
> +fi
> +if ! compile_prog ; then
> +    error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
> +fi
> +
>  if test -z "${CXX}${cross_prefix}"; then
>    cxx="c++"
>  else
> @@ -537,12 +554,6 @@ EOF
>    compile_object
>  }
>  
> -write_c_skeleton() {
> -    cat > $TMPC <<EOF
> -int main(void) { return 0; }
> -EOF
> -}
> -
>  if check_define __linux__ ; then
>    targetos="Linux"
>  elif check_define _WIN32 ; then
> @@ -1593,17 +1604,6 @@ if test -z "$werror" ; then
>      fi
>  fi
>  
> -# check that the C compiler works.
> -write_c_skeleton;
> -if compile_object ; then
> -  : C compiler works ok
> -else
> -    error_exit "\"$cc\" either does not exist or does not work"
> -fi
> -if ! compile_prog ; then
> -    error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
> -fi
> -
>  if test "$bogus_os" = "yes"; then
>      # Now that we know that we're not printing the help and that
>      # the compiler works (so the results of the check_defines we used
> 
