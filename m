Received: from eggs.gnu.org ([209.51.188.92]:46209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1goULl-0003cR-4t
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1goULU-0006iw-Ih
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:26:51 -0500
MIME-Version: 1.0
References: <20190129140411.682-1-peter.maydell@linaro.org>
	<20190129140411.682-3-peter.maydell@linaro.org>
In-Reply-To: <20190129140411.682-3-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 29 Jan 2019 15:25:54 +0100
Message-ID: <CABoDooMVGMsOvHiMZVQ_pBr4ZUrw4JndMtYyG=HmaPu2hZyksg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm/translate-a64: Fix
 mishandling of size in FCMLA decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Tue, Jan 29, 2019 at 3:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In disas_simd_indexed(), for the case of "complex fp", each indexable
> element is a complex pair, so the total size is twice that indicated
> in the 'size' field in the encoding. We were trying to do this
> "double the size" operation with a left shift by 1, but this is
> incorrect because the 'size' field is a MO_8/MO_16/MO_32/MO_64
> value, and doubling the size should be done by a simple increment.
>
> This meant we were mishandling FCMLA (by element) of values where
> the real and imaginary parts are 32-bit floats, and would incorrectly
> UNDEF this encoding. (No other insns take this code path, and for
> 16-bit floats it happens that 1 << 1 and 1 + 1 are both the same).
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index a7b999d2b5a..06418f0ac3c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -12680,7 +12680,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>
>      case 2: /* complex fp */
>          /* Each indexable element is a complex pair.  */
> -        size <<= 1;
> +        size += 1;
>          switch (size) {
>          case MO_32:
>              if (h && !is_q) {
> --
> 2.20.1
>
