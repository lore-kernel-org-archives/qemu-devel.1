Received: from eggs.gnu.org ([2001:4830:134:3::10]:55266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjekd-0003VL-Tw
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjeka-0005Ey-Ot
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:23:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cjeka-0005Ef-Fo
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:23:28 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v234ImrG042317
	for <qemu-devel@nongnu.org>; Thu, 2 Mar 2017 23:23:27 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8e3eup-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 23:23:26 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 3 Mar 2017 14:23:24 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170303035216.GQ4067@umbus.fritz.box>
References: <1488463829-26839-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<18786e9b-277c-2a66-1662-55a9325a9d2c@twiddle.net>
	<20170303035216.GQ4067@umbus.fritz.box>
Date: Fri, 03 Mar 2017 09:52:27 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shmv2dmk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
To: David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Fri, Mar 03, 2017 at 02:31:38PM +1100, Richard Henderson wrote:
>> On 03/03/2017 01:10 AM, Nikunj A Dadhania wrote:
>> > +static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
>> > +                                        float64 arg2, float64 arg3,
>> > +                                        unsigned int madd_flags)
>> >  {
>> > +    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
>> > +                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
>> >          /* Multiplication of zero by infinity */
>> > +        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
>> > +    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
>> > +                        float64_is_signaling_nan(arg2, &env->fp_status) ||
>> > +                        float64_is_signaling_nan(arg3, &env->fp_status))) {
>> > +        /* sNaN operation */
>> > +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
>> 
>> Are you sure you shouldn't be testing for NaN first?
>> Do you really get VXIMZ if arg3 (the addend) is (S)NaN?
>> 
>> You should probably eliminate QNaN as well, before the other checks.
>
> Oh.. I've already merged and pull requested this.

The behaviour has not changed as compared to previous version.

> I'm afraid any further corrections will have to be done as followup
> patches.

I will send a follow-up with fixing other multiply-add versions as well.

Regards
Nikunj
