Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e05UU-0005kl-5y
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e05UT-000091-H4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:43:02 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:50782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e05UT-00008W-BT
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:43:01 -0400
Received: by mail-qt0-x22e.google.com with SMTP id f15so25025263qtf.7
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 05:43:01 -0700 (PDT)
References: <20171003062310.9919-1-sandipan@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6c84dd7f-4441-0624-d6a4-bffe837eea49@linaro.org>
Date: Thu, 5 Oct 2017 08:42:56 -0400
MIME-Version: 1.0
In-Reply-To: <20171003062310.9919-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] target/ppc: Fix carry flag setting for
 shift algebraic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, david@gibson.dropbear.id.au, agraf@suse.de
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com

On 10/03/2017 02:23 AM, Sandipan Das wrote:
> @@ -231,6 +231,10 @@ target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
>          ret = (int32_t)value >> 31;
>          env->ca = (ret != 0);
>      }
> +
> +    /* update CA32 for ISA v3.0 */
> +    env->ca32 = env->ca;

As I said before, modify ca32 only when ca is modified.
E.g.

  env->ca32 = env->ca = (ret != 0);

> @@ -257,6 +261,10 @@ target_ulong helper_srad(CPUPPCState *env, target_ulong value,
>          ret = (int64_t)value >> 63;
>          env->ca = (ret != 0);
>      }
> +
> +    /* update CA32 for ISA v3.0 */
> +    env->ca32 = env->ca;

Likewise.

> @@ -2192,6 +2192,10 @@ static void gen_srawi(DisasContext *ctx)
>          tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
>          tcg_gen_sari_tl(dst, dst, sh);
>      }
> +
> +    /* update CA32 for ISA v3.0 */
> +    tcg_gen_mov_tl(cpu_ca32, cpu_ca);

Likewise.

> @@ -2269,6 +2273,10 @@ static inline void gen_sradi(DisasContext *ctx, int n)
>          tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
>          tcg_gen_sari_tl(dst, src, sh);
>      }
> +
> +    /* update CA32 for ISA v3.0 */
> +    tcg_gen_mov_tl(cpu_ca32, cpu_ca);

Likewise.


r~
