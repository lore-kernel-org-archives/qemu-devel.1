Received: from eggs.gnu.org ([2001:4830:134:3::10]:42964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgULs-00051w-Ck
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgULr-0002zC-Cn
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:40:52 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-11-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <317de684-1015-e3c6-56e8-2bf3b741b74a@twiddle.net>
Date: Wed, 22 Feb 2017 21:40:42 +1100
MIME-Version: 1.0
In-Reply-To: <1487755788-16415-11-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/11] target/ppc: add ov32 flag in
 divide operations
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
> Add helper_div_compute_ov() in the int_helper for updating the overflow
> flags.
>
> For Divide Word:
> SO, OV, and OV32 bits reflects overflow of the 32-bit result
>
> For Divide DoubleWord:
> SO, OV, and OV32 bits reflects overflow of the 64-bit result
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/ppc/int_helper.c | 49 ++++++++++++++++---------------------------------
>  target/ppc/translate.c  |  6 ++++--
>  2 files changed, 20 insertions(+), 35 deletions(-)
>
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index dd0a892..34b54e1 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -28,6 +28,18 @@
>  /*****************************************************************************/
>  /* Fixed point operations helpers */
>
> +static inline void helper_div_compute_ov(CPUPPCState *env, uint32_t oe,
> +                                         int overflow)
> +{
> +    if (oe) {
> +        if (unlikely(overflow)) {
> +            env->so = env->ov = env->ov32 = 1;
> +        } else {
> +            env->ov = env->ov32 = 0;
> +        }
> +    }
> +}
> +
>  target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
>                             uint32_t oe)
>  {
> @@ -48,14 +60,7 @@ target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
>          rt = 0; /* Undefined */
>      }
>
> -    if (oe) {
> -        if (unlikely(overflow)) {
> -            env->so = env->ov = 1;
> -        } else {
> -            env->ov = 0;
> -        }
> -    }
> -
> +    helper_div_compute_ov(env, oe, overflow);
>      return (target_ulong)rt;
>  }
>
> @@ -80,14 +85,7 @@ target_ulong helper_divwe(CPUPPCState *env, target_ulong ra, target_ulong rb,
>          rt = 0; /* Undefined */
>      }
>
> -    if (oe) {
> -        if (unlikely(overflow)) {
> -            env->so = env->ov = 1;
> -        } else {
> -            env->ov = 0;
> -        }
> -    }
> -
> +    helper_div_compute_ov(env, oe, overflow);
>      return (target_ulong)rt;
>  }
>
> @@ -104,14 +102,7 @@ uint64_t helper_divdeu(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
>          rt = 0; /* Undefined */
>      }
>
> -    if (oe) {
> -        if (unlikely(overflow)) {
> -            env->so = env->ov = 1;
> -        } else {
> -            env->ov = 0;
> -        }
> -    }
> -
> +    helper_div_compute_ov(env, oe, overflow);
>      return rt;
>  }
>
> @@ -126,15 +117,7 @@ uint64_t helper_divde(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
>          rt = 0; /* Undefined */
>      }
>
> -    if (oe) {
> -
> -        if (unlikely(overflow)) {
> -            env->so = env->ov = 1;
> -        } else {
> -            env->ov = 0;
> -        }
> -    }
> -
> +    helper_div_compute_ov(env, oe, overflow);
>      return rt;
>  }
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index d676863..1423ebd 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1024,6 +1024,7 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
>      }
>      if (compute_ov) {
>          tcg_gen_extu_i32_tl(cpu_ov, t2);
> +        tcg_gen_extu_i32_tl(cpu_ov32, t2);
>          tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>      }
>      tcg_temp_free_i32(t0);
> @@ -1095,6 +1096,7 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
>      }
>      if (compute_ov) {
>          tcg_gen_mov_tl(cpu_ov, t2);
> +        tcg_gen_mov_tl(cpu_ov32, t2);
>          tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);

isa300 checks?


r~

>      }
>      tcg_temp_free_i64(t0);
> @@ -1113,10 +1115,10 @@ static void glue(gen_, name)(DisasContext *ctx)
>                        cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],     \
>                        sign, compute_ov);                                      \
>  }
> -/* divwu  divwu.  divwuo  divwuo.   */
> +/* divdu  divdu.  divduo  divduo.   */
>  GEN_INT_ARITH_DIVD(divdu, 0x0E, 0, 0);
>  GEN_INT_ARITH_DIVD(divduo, 0x1E, 0, 1);
> -/* divw  divw.  divwo  divwo.   */
> +/* divd  divd.  divdo  divdo.   */
>  GEN_INT_ARITH_DIVD(divd, 0x0F, 1, 0);
>  GEN_INT_ARITH_DIVD(divdo, 0x1F, 1, 1);
>
>
