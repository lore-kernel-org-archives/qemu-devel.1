Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cglfG-0000qe-Sd
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cglfB-0005N8-UC
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:10:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58583
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cglfB-0005My-Mr
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:09:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N58cFm050028
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 00:09:56 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28sr62j8yq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 00:09:56 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 23 Feb 2017 10:39:53 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170223032118.GD12577@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170223032118.GD12577@umbus.fritz.box>
Date: Thu, 23 Feb 2017 10:39:47 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1e9trvo.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
>> index de3004b..89c1ccb 100644
>> --- a/target/ppc/cpu.c
>> +++ b/target/ppc/cpu.c
>> @@ -23,8 +23,15 @@
>>  
>>  target_ulong cpu_read_xer(CPUPPCState *env)
>>  {
>> -    return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
>> +    target_ulong xer;
>> +
>> +    xer = env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
>>          (env->ca << XER_CA);
>> +
>> +    if (is_isa300(env)) {
>> +        xer |= (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
>> +    }
>> +    return xer;
>>  }
>>  
>>  void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>> @@ -32,5 +39,13 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>>      env->so = (xer >> XER_SO) & 1;
>>      env->ov = (xer >> XER_OV) & 1;
>>      env->ca = (xer >> XER_CA) & 1;
>> -    env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
>> +    if (is_isa300(env)) {
>> +        env->ov32 = (xer >> XER_OV32) & 1;
>> +        env->ca32 = (xer >> XER_CA32) & 1;
>
> I think these might as well be unconditional - as long as the read_xer
> doesn't read the bits back, the guest won't care that we track them in
> internal state.

Sure.


> I'm also wondering if it might be worth adding a xer_mask to the env,
> instead of explicitly checking isa300 all over the place.

Let me try that out.

Can we also update ov32/ca32 in all the arithmetic operations as if its
supported. And as you suggested, whenever there is a read attempted,
only give relevant bits back(xer_mask). This would save lot of
conditions in translations (couple of more tcg-ops for non-isa300)

>
>> +        env->xer = xer & ~((1ul << XER_SO) |
>> +                           (1ul << XER_OV) | (1ul << XER_CA) |
>> +                           (1ul << XER_OV32) | (1ul << XER_CA32));
>> +    } else {
>> +        env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
>> +    }
>
> And you can definitely use the stricer mask for both archs.  If it's
> ISA300, you've stashed them elsewhere, if it's not those bits are
> invalid anyway,
>
> (Incidentally given the modern balance between the cost of
> instructions and cachelines, I wonder if all these split out bits of
> the XER are a good idea in any case, but that would be a big change
> out  of scope for what you're attempting here)

Will have a look at this after finishing isa300. I have faced issues
with RISU wrt having the state stashed in different tcg variables.

Regards
Nikunj
