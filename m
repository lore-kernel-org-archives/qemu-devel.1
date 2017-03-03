Received: from eggs.gnu.org ([2001:4830:134:3::10]:51965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjeQm-0007iC-Rb
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjeQi-00074i-Tk
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:03:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36868
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cjeQi-00074W-NZ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:02:56 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v233rhuC061581
	for <qemu-devel@nongnu.org>; Thu, 2 Mar 2017 23:02:55 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xssthetv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 23:02:55 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 3 Mar 2017 14:02:51 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <18786e9b-277c-2a66-1662-55a9325a9d2c@twiddle.net>
References: <1488463829-26839-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<18786e9b-277c-2a66-1662-55a9325a9d2c@twiddle.net>
Date: Fri, 03 Mar 2017 09:31:52 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87varr2ekv.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:
> On 03/03/2017 01:10 AM, Nikunj A Dadhania wrote:
>> +static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
>> +                                        float64 arg2, float64 arg3,
>> +                                        unsigned int madd_flags)
>>  {
>> +    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
>> +                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
>>          /* Multiplication of zero by infinity */
>> +        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
>> +    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
>> +                        float64_is_signaling_nan(arg2, &env->fp_status) ||
>> +                        float64_is_signaling_nan(arg3, &env->fp_status))) {
>> +        /* sNaN operation */
>> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
>
> Are you sure you shouldn't be testing for NaN first?

I have tried to retain the old order of checking. While when I see
MultiplyAddDP(x,y,z) in ISA, following is the order:

    * If x, y or z is an SNaN, vxsnan_flag is set to 1.
    * If x is a Zero and y, is an Infinity or x is an Infinity and y is
      an Zero, vximz_flag is set to 1.
    * If the product of x and y is an Infinity and z is an Infinity of
      the opposite sign, vxisi_flag is set to 1.

In that case, I need to get rid of nested if-else and make each of them
independent checks.
    
> Do you really get VXIMZ if arg3 (the addend) is (S)NaN?

Yes, with the above logic yes. 

> You should probably eliminate QNaN as well, before the other checks.

MultiplyAddDP does not eliminate QNaN. But then, there is detailed spec
on what should be returned in various cases(Page 469 ISA 3.0)

Regards
Nikunj
