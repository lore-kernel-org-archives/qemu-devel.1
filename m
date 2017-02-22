Received: from eggs.gnu.org ([2001:4830:134:3::10]:45877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgUaX-0007DG-Qm
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgUaS-00072e-W5
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:56:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54082
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgUaS-00072M-P7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:55:56 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MArobL098311
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:55:55 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s6y0wwvv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:55:55 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 16:25:52 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <6ab5f39d-af42-8f03-01fe-002fdd04d51d@twiddle.net>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<6ab5f39d-af42-8f03-01fe-002fdd04d51d@twiddle.net>
Date: Wed, 22 Feb 2017 16:25:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f4ibiku.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v2 03/11] target/ppc: support for 32-bit
 carry and overflow
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

> On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
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
>> +        env->xer = xer & ~((1ul << XER_SO) |
>> +                           (1ul << XER_OV) | (1ul << XER_CA) |
>> +                           (1ul << XER_OV32) | (1ul << XER_CA32));
>> +    } else {
>> +        env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
>> +    }
>>  }
>
> Do cpus before power9 really save all of the bits you write to it?
> I.e. if you write -1 to XER, do you read -1 back?

I did a quick test on power8, and it doesn't read back -1 after a write(-1).

int main(void)
{
  long res;
  asm volatile ("mtxer %1; mfxer %0;" : "=r"(res) : "r"(-1));
  printf("xer %lx\n", res);
}

$ ./a.out 
xer e00fffff
$

> If so, then I suppose I'll have to revise my previous advice; there's no point 
> in NOT storing bit 19 in env->ov32, because we can always read it back out.

Regards
Nikunj
