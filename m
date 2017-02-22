Received: from eggs.gnu.org ([2001:4830:134:3::10]:37757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgU59-0008JQ-Mj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgU56-0005B3-Id
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:23:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgU56-00059u-89
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:23:32 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MANUEO004180
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:23:30 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s5ks7f1v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:23:30 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 15:53:22 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <77aa30af-6e2e-4a44-f293-05ab00d05c8e@twiddle.net>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-8-git-send-email-nikunj@linux.vnet.ibm.com>
	<165844eb-e94c-1955-2fe3-59f0a3931094@twiddle.net>
	<878tozdhe4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<e2a02836-77d9-18f2-d8df-21856a6da0a8@twiddle.net>
	<87r32q7uei.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<77aa30af-6e2e-4a44-f293-05ab00d05c8e@twiddle.net>
Date: Wed, 22 Feb 2017 15:53:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fuj6bk31.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 07/10] target/ppc: update ov/ov32 for
 nego
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

> On 02/22/2017 02:53 PM, Nikunj A Dadhania wrote:
>> Richard Henderson <rth@twiddle.net> writes:
>>
>>> On 02/21/2017 08:26 PM, Nikunj A Dadhania wrote:
>>>> Richard Henderson <rth@twiddle.net> writes:
>>>>
>>>>> On 02/20/2017 09:11 PM, Nikunj A Dadhania wrote:
>>>>>> For 64-bit mode if the register RA contains 0x8000_0000_0000_0000, OV
>>>>>> and OV32 are set to 1.
>>>>>>
>>>>>> For 32-bit mode if the register RA contains 0x8000_0000, OV and OV32 are
>>>>>> set to 1.
>>>>>>
>>>>>> Use the tcg-ops for negation (neg_tl) and drop gen_op_arith_neg() as
>>>>>> nego was the last user.
>>>>>>
>>>>>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>>>> @@ -1488,7 +1480,20 @@ static void gen_neg(DisasContext *ctx)
>>>>>>
>>>>>>  static void gen_nego(DisasContext *ctx)
>>>>>>  {
>>>>>> -    gen_op_arith_neg(ctx, 1);
>>>>>> +    TCGv t0 = tcg_temp_new();
>>>>>> +    TCGv zero = tcg_const_tl(0);
>>>>>> +
>>>>>> +    if (NARROW_MODE(ctx)) {
>>>>>> +        tcg_gen_xori_tl(t0, cpu_gpr[rA(ctx->opcode)], INT32_MIN);
>>>>>> +    } else {
>>>>>> +        tcg_gen_xori_tl(t0, cpu_gpr[rA(ctx->opcode)], (target_ulong)INT64_MIN);
>>>>>> +    }
>>>>>> +
>>>>>> +    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_ov, t0, zero);
>>>>>> +    tcg_gen_mov_tl(cpu_ov32, cpu_ov);
>>>>>> +    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
>>>>>> +    tcg_temp_free(t0);
>>>>>> +    tcg_temp_free(zero);
>>>>>>  }
>>>>>
>>>>> Again, you're forgetting "nego.".  Don't try to simplify from gen_op_arith_subf
>>>>> by hand.
>>>>
>>>> The reason of the simplification was the interpretation of ov and ov32.
>>>> I will add a code to compute the Rc.
>>>
>>> Why do you believe that the computation for overflow is different between neg
>>> and subf?
>>
>> For example in 64-bit mode, if we negate INT64_MIN(nego[.]), both OV and
>> OV32 has to be set to 1 according to ISA 3.0. If I use subf, only OV is
>> set to 1.
>
> What an odd corner case for OV32 wrt nego.  But you're right that's what the 
> manual says.  I wonder why the hardware folk designed the chip that way.  It 
> seems broken.
>
> You might want to confirm with the hardware folk that this isn't a bug in the 
> manual.

Sure, moreover I figured out that the hardware simulator isnt following
the ISA3.0 behaviour (setting OV and OV32 both)

Regards
Nikunj
