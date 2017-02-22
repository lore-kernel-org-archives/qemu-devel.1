Received: from eggs.gnu.org ([2001:4830:134:3::10]:42139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgUIe-0002b2-6Z
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgUIb-0001fD-3X
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:37:32 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-7-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7d08191a-b509-758a-fba3-f49b6606f512@twiddle.net>
Date: Wed, 22 Feb 2017 21:37:19 +1100
MIME-Version: 1.0
In-Reply-To: <1487755788-16415-7-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/11] target/ppc: update overflow flags
 for add/sub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
> * SO and OV reflects overflow of the 64-bit result in 64-bit mode and
>   overflow of the low-order 32-bit result in 32-bit mode
>
> * OV32 reflects overflow of the low-order 32-bit independent of the mode
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 184d10f..74185ba 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -809,10 +809,18 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
>          tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
>      }
>      tcg_temp_free(t0);
> -    if (NARROW_MODE(ctx)) {
> -        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
> +    if (is_isa300(ctx)) {
> +        tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
> +        tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
> +        if (NARROW_MODE(ctx)) {
> +            tcg_gen_mov_tl(cpu_ov, cpu_ov32);
> +        }

Again, you're computing cpu_ov twice.

> +    } else {
> +        if (NARROW_MODE(ctx)) {
> +            tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
> +        }
> +        tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
>      }
> -    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
>      tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>  }
>
>
