Received: from eggs.gnu.org ([2001:4830:134:3::10]:39018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgags-0003Lz-El
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgagp-0004P0-Bv
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:26:58 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-7-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <945770e2-dff8-1344-d445-85deaa15e8f0@twiddle.net>
Date: Thu, 23 Feb 2017 04:26:45 +1100
MIME-Version: 1.0
In-Reply-To: <1487763883-4877-7-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/10] target/ppc: update overflow flags
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

On 02/22/2017 10:44 PM, Nikunj A Dadhania wrote:
> * SO and OV reflects overflow of the 64-bit result in 64-bit mode and
>   overflow of the low-order 32-bit result in 32-bit mode
>
> * OV32 reflects overflow of the low-order 32-bit independent of the mode
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f3f92aa..43366e7 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -809,10 +809,19 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
>          tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
>      }
>      tcg_temp_free(t0);
> -    if (NARROW_MODE(ctx)) {
> -        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
> +    if (is_isa300(ctx)) {
> +        tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
> +        if (NARROW_MODE(ctx)) {
> +            tcg_gen_mov_tl(cpu_ov, cpu_ov32);
> +        } else {
> +            tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
> +        }
> +    } else {
> +        if (NARROW_MODE(ctx)) {
> +            tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
> +        }
> +        tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
>      }
> -    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);

We're computing this two different ways for no reason.  How about

   if (NARROW_MODE(ctx)) {
     tcg_gen_extract_tl(cpu_ov, cpu_ov, 31, 1);
     if (is_isa300(ctx)) {
         tcg_gen_mov_tl(cpu_ov32, cpu_ov);
     }
   } else {
     if (is_isa300(ctx)) {
         tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
     }
     tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
   }


r~
