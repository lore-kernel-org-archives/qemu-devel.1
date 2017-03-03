Received: from eggs.gnu.org ([2001:4830:134:3::10]:45817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjdwd-0004pu-2V
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjdwa-0003Tv-0z
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:31:51 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1488463829-26839-1-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <18786e9b-277c-2a66-1662-55a9325a9d2c@twiddle.net>
Date: Fri, 3 Mar 2017 14:31:38 +1100
MIME-Version: 1.0
In-Reply-To: <1488463829-26839-1-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: rewrite f[n]m[add,
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

On 03/03/2017 01:10 AM, Nikunj A Dadhania wrote:
> +static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
> +                                        float64 arg2, float64 arg3,
> +                                        unsigned int madd_flags)
>  {
> +    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
> +                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
>          /* Multiplication of zero by infinity */
> +        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
> +    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
> +                        float64_is_signaling_nan(arg2, &env->fp_status) ||
> +                        float64_is_signaling_nan(arg3, &env->fp_status))) {
> +        /* sNaN operation */
> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);

Are you sure you shouldn't be testing for NaN first?
Do you really get VXIMZ if arg3 (the addend) is (S)NaN?

You should probably eliminate QNaN as well, before the other checks.


r~
