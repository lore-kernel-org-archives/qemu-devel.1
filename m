Received: from eggs.gnu.org ([2001:4830:134:3::10]:36159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dyzgq-0003UP-NE
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dyzgp-0001MN-K0
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:19:16 -0400
Received: from mail-yw0-x22b.google.com ([2607:f8b0:4002:c05::22b]:52121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dyzgp-0001Ld-FI
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:19:15 -0400
Received: by mail-yw0-x22b.google.com with SMTP id p10so3497939ywh.8
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 05:19:14 -0700 (PDT)
References: <20170930113610.28608-1-sandipan@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db510034-c358-eda5-63df-19ff1341792d@linaro.org>
Date: Mon, 2 Oct 2017 08:19:10 -0400
MIME-Version: 1.0
In-Reply-To: <20170930113610.28608-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix carry flag setting for
 shift algebraic instructions
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>, david@gibson.dropbear.id.au, agraf@suse.de
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com
List-ID: <qemu-devel.nongnu.org>

On 09/30/2017 07:36 AM, Sandipan Das wrote:
> For POWER ISA v3.0, the XER bit CA32 needs to be set by the shift
> right algebraic instructions whenever the CA bit is to be set. This
> change affects the following instructions:
>   * Shift Right Algebraic Word (sraw[.])
>   * Shift Right Algebraic Word Immediate (srawi[.])
>   * Shift Right Algebraic Doubleword (srad[.])
>   * Shift Right Algebraic Doubleword Immediate (sradi[.])
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  target/ppc/helper.h     |  4 ++--
>  target/ppc/int_helper.c | 10 ++++++++--
>  target/ppc/translate.c  | 16 ++++++++++++++--
>  3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index bb6a94a8b3..069d65ad7b 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -40,12 +40,12 @@ DEF_HELPER_4(divwe, tl, env, tl, tl, i32)
>  
>  DEF_HELPER_FLAGS_1(popcntb, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_2(cmpb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> -DEF_HELPER_3(sraw, tl, env, tl, tl)
> +DEF_HELPER_4(sraw, tl, env, tl, tl, tl)
>  #if defined(TARGET_PPC64)
>  DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
>  DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> -DEF_HELPER_3(srad, tl, env, tl, tl)
> +DEF_HELPER_4(srad, tl, env, tl, tl, tl)
>  DEF_HELPER_0(darn32, tl)
>  DEF_HELPER_0(darn64, tl)
>  #endif
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index da4e1a62c9..4f270eb49d 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -210,7 +210,7 @@ target_ulong helper_cmpb(target_ulong rs, target_ulong rb)
>  
>  /* shift right arithmetic helper */
>  target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
> -                         target_ulong shift)
> +                         target_ulong shift, target_ulong is_isa300)
>  {
>      int32_t ret;
>  
> @@ -231,12 +231,15 @@ target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
>          ret = (int32_t)value >> 31;
>          env->ca = (ret != 0);
>      }
> +    if (is_isa300) {
> +        env->ca32 = env->ca;
> +    }

You do not need to pass a new parameter, because ca32 does not exist prior to
ISA 3.00, and thus any code running ISA 2.x does not care about its value.

You only need set ca32 when ca is set.  Move those assignments adjacent.


r~
