Received: from eggs.gnu.org ([2001:4830:134:3::10]:51915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eEdj1-00069d-4g
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eEdiv-00017l-9q
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:06:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eEdiv-000132-4i
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:06:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAEG1YiV121310
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 11:05:58 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e83042an5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 11:05:58 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 09:05:57 -0700
References: <20171027165814.29122-1-richard.henderson@linaro.org>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 14:05:51 -0200
MIME-Version: 1.0
In-Reply-To: <20171027165814.29122-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <1db5dc85-1af4-8935-fae8-a71ca5b79887@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] target/ppc: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au



On 10/27/2017 02:58 PM, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> Rebased and updated for changes to tcg_gen_lookup_and_goto_ptr.
>
> ---

I am experiencing a remarkable performance boost running a simple scenario
up to SLOF prompt with this patch. It takes 50 seconds on average to get 
to SLOF
prompt as is now on my Lenovo laptop, upstream qemu and default pseries
machine. With this patch it takes 21 seconds average.


Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

>   target/ppc/translate.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 998fbed848..4075fc8589 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3419,7 +3419,7 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
>   }
>
>   /***                                Branch                                 ***/
> -static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
>   {
>       if (NARROW_MODE(ctx)) {
>           dest = (uint32_t) dest;
> @@ -3441,7 +3441,7 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
>                   gen_debug_exception(ctx);
>               }
>           }
> -        tcg_gen_exit_tb(0);
> +        tcg_gen_lookup_and_goto_ptr();
>       }
>   }
>
> @@ -3479,7 +3479,7 @@ static void gen_b(DisasContext *ctx)
>   #define BCOND_CTR 2
>   #define BCOND_TAR 3
>
> -static inline void gen_bcond(DisasContext *ctx, int type)
> +static void gen_bcond(DisasContext *ctx, int type)
>   {
>       uint32_t bo = BO(ctx->opcode);
>       TCGLabel *l1;
> @@ -3543,26 +3543,19 @@ static inline void gen_bcond(DisasContext *ctx, int type)
>           } else {
>               gen_goto_tb(ctx, 0, li);
>           }
> -        if ((bo & 0x14) != 0x14) {
> -            gen_set_label(l1);
> -            gen_goto_tb(ctx, 1, ctx->nip);
> -        }
>       } else {
>           if (NARROW_MODE(ctx)) {
>               tcg_gen_andi_tl(cpu_nip, target, (uint32_t)~3);
>           } else {
>               tcg_gen_andi_tl(cpu_nip, target, ~3);
>           }
> -        tcg_gen_exit_tb(0);
> -        if ((bo & 0x14) != 0x14) {
> -            gen_set_label(l1);
> -            gen_update_nip(ctx, ctx->nip);
> -            tcg_gen_exit_tb(0);
> -        }
> -    }
> -    if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
> +        tcg_gen_lookup_and_goto_ptr();
>           tcg_temp_free(target);
>       }
> +    if ((bo & 0x14) != 0x14) {
> +        gen_set_label(l1);
> +        gen_goto_tb(ctx, 1, ctx->nip);
> +    }
>   }
>
>   static void gen_bc(DisasContext *ctx)
