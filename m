Received: from eggs.gnu.org ([2001:4830:134:3::10]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjseZ-00087n-N1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjseW-0004YQ-FH
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:14:11 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1488524289-5305-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1488524289-5305-2-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c776c8cc-b75e-a5a9-f88a-c127b168eef0@twiddle.net>
Date: Sat, 4 Mar 2017 06:14:00 +1100
MIME-Version: 1.0
In-Reply-To: <1488524289-5305-2-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc: fmadd check for excp
 independently
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

On 03/03/2017 05:58 PM, Nikunj A Dadhania wrote:
> Current order of checking does not confirm with the spec
> (ISA 3.0: MultiplyAddDP page-469). Change the order and make them
> independent of each other.
>
> For example: a = infinity, b = zero, c = SNaN, this should set both
> VXIMZ and VXNAN
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/fpu_helper.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 0535ad0..a547f58 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -747,17 +747,21 @@ static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
>                                          float64 arg2, float64 arg3,
>                                          unsigned int madd_flags)
>  {
> +    if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
> +                 float64_is_signaling_nan(arg2, &env->fp_status) ||
> +                 float64_is_signaling_nan(arg3, &env->fp_status))) {
> +        /* sNaN operation */
> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> +    }
> +
>      if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
>                   (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
>          /* Multiplication of zero by infinity */
> -        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
> -    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
> -                        float64_is_signaling_nan(arg2, &env->fp_status) ||
> -                        float64_is_signaling_nan(arg3, &env->fp_status))) {
> -        /* sNaN operation */
> -        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> -    } else if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
> -               float64_is_infinity(arg3)) {
> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
> +    }
> +

While these two bits should be both be set if the inputs demand, it won't 
happen if the exception enable bit is set, since the first call will longjmp. 
I'm not sure what to do about that; perhaps just ignore it for now.

More importantly, it will longjmp with the wrong source location.  Note that 
float_invalid_op_excp is attempting to use __always_inline__ to grab a correct 
value for GETPC.  Which, as one can predict, is doomed to failure.  As here we 
are, in another function which is not __always_inline__, producing the wrong value.

We need to drop all of the __always_inline__ nonsense, and properly pass down a 
value for GETPC from the top-level helper, so that we always think about it.


r~
