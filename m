Received: from eggs.gnu.org ([209.51.188.92]:57238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2Q7Q-0007jb-Dh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2Q7P-0006sZ-NJ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:45:40 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <906cb044-a5ef-21a2-3ccc-2b7492c2301c@amsat.org>
Date: Sat, 9 Mar 2019 01:45:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190307144126.31847-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 9/9] target/arm: Simplify BFXIL
 expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, david@redhat.com

On 3/7/19 3:41 PM, Richard Henderson wrote:
> The mask implied by the extract is redundant with the one
> implied by the deposit.  Also, fix spelling of BFXIL.

This spelling fix also help understanding the context!

> 
> Cc: qemu-arm@nongnu.org 
> Cc: Peter Maydell <peter.maydell@linaro.org> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 54fe94c436..39e0512d21 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -4043,8 +4043,8 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
>              tcg_gen_extract_i64(tcg_rd, tcg_tmp, ri, len);
>              return;
>          }
> -        /* opc == 1, BXFIL fall through to deposit */
> -        tcg_gen_extract_i64(tcg_tmp, tcg_tmp, ri, len);
> +        /* opc == 1, BFXIL fall through to deposit */
> +        tcg_gen_shri_i64(tcg_tmp, tcg_tmp, ri);
>          pos = 0;
>      } else {
>          /* Handle the ri > si case with a deposit
> @@ -4062,7 +4062,7 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
>          len = ri;
>      }
>  
> -    if (opc == 1) { /* BFM, BXFIL */
> +    if (opc == 1) { /* BFM, BFXIL */
>          tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);

Fall through and use deposit of len indeed. So the previous SHRI is enough.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

This function uses hardcore optimizations btw, un chef d'oeuvre :)

>      } else {
>          /* SBFM or UBFM: We start with zero, and we haven't modified
> 
