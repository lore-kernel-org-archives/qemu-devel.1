Received: from eggs.gnu.org ([2001:4830:134:3::10]:37408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9yu2-0000nV-DA
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9yu1-0002Bg-Jo
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:42:18 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:57212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9yu1-0002An-CU
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 15:42:17 -0400
Received: by mail-wm0-x242.google.com with SMTP id z3so6925451wme.5
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 12:42:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
References: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Nov 2017 19:41:55 +0000
Message-ID: <CAFEAcA9TD+imsuD+0zmZ5FGH7cVCw5+ZiKdPS1uBjqj=ujKiQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 1 November 2017 at 19:31, Daniel Henrique Barboza
<danielhb@linux.vnet.ibm.com> wrote:
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

I think that currently we try to make "--help" work
even if you don't have a working C compiler. Does this
break that?

thanks
-- PMM
