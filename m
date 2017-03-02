Received: from eggs.gnu.org ([2001:4830:134:3::10]:47003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjGbw-0004ot-V8
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjGbr-0003jg-VC
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:36:57 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1488381854-7275-1-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <820beb1e-20e9-9588-f39d-a7f20ee8af4a@twiddle.net>
Date: Thu, 2 Mar 2017 13:36:44 +1100
MIME-Version: 1.0
In-Reply-To: <1488381854-7275-1-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
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

On 03/02/2017 02:24 AM, Nikunj A Dadhania wrote:
> +static void float64_madd_set_vxisi(CPUPPCState *env, float64 a, float64 b,
> +                                   float64 c, unsigned int flags)
>  {
> +    float64 f = float64_mul(a, b, &env->fp_status);

What is the point of this multiply?
>
> +    /* a*b = ∞ and c = ∞, find ∞ - ∞ case and set VXISI */
> +    if (float64_is_infinity(f) && float64_is_infinity(c)) {
> +        if ((f ^ c) == 0) {
> +            /* Both negative/positive inifinity and substraction*/
> +            if (flags & MSUB_FLGS) {

I would really prefer you use the float_muladd_* names.

> +uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
> +                     uint64_t arg2, uint64_t arg3)                      \
> +{                                                                       \
> +    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) || \
> +                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) { \
> +        /* Multiplication of zero by infinity */                        \
> +        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);     \
> +    } else {                                                            \
> +        if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) || \
> +                     float64_is_signaling_nan(arg2, &env->fp_status) || \
> +                     float64_is_signaling_nan(arg3, &env->fp_status))) { \
> +            /* sNaN operation */                                        \
> +            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);      \
> +        }                                                               \
> +                                                                        \
> +        float64_madd_set_vxisi(env, arg1, arg2, arg3, madd_flags);      \
> +        arg1 = float64_muladd(arg1, arg2, arg3, madd_flags,             \
> +                              &env->fp_status);                         \
> +        float_check_status(env);                                        \

I know this is the layout of the bulk of the ppc target, but it's inefficient. 
Let's do this one correctly, akin to target/tricore:

   result = float64_muladd(args...);
   flags = get_float_exception_flags(&env->fp_status);
   if (flags) {
       if (flags & float_flag_invalid) {
           // examine inputs to see why we return NaN
       }
       float_check_status(env);
   }


r~
