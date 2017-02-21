Received: from eggs.gnu.org ([2001:4830:134:3::10]:36650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cg2L0-0001UD-NG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cg2Kx-0005fY-KO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:46:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cg2Kx-0005fC-Ai
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:46:03 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1L4hpD5000813
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 23:46:01 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28r2sjtcuk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 23:46:00 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 21 Feb 2017 10:15:57 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <3d0d83c5-0588-649d-5ed0-202a82031a1e@twiddle.net>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-2-git-send-email-nikunj@linux.vnet.ibm.com>
	<3d0d83c5-0588-649d-5ed0-202a82031a1e@twiddle.net>
Date: Tue, 21 Feb 2017 10:15:46 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmtwkv7p.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 01/10] target/ppc: support for 32-bit
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

> On 02/20/2017 09:11 PM, Nikunj A Dadhania wrote:
>> +#ifndef TARGET_PPC64
>>  static inline target_ulong cpu_read_xer(CPUPPCState *env)
>>  {
>>      return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) | (env->ca << XER_CA);
>>  }
>> +#else
>> +static inline target_ulong cpu_read_xer(CPUPPCState *env)
>> +{
>> +    return env->xer | (env->so << XER_SO) |
>> +        (env->ov << XER_OV) | (env->ca << XER_CA) |
>> +        (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
>> +}
>> +#endif
>>
>> +#ifndef TARGET_PPC64
>>  static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>>  {
>>      env->so = (xer >> XER_SO) & 1;
>> @@ -2355,6 +2371,20 @@ static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>>      env->ca = (xer >> XER_CA) & 1;
>>      env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
>>  }
>> +#else
>> +static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>> +{
>> +    env->so = (xer >> XER_SO) & 1;
>> +    env->ov = (xer >> XER_OV) & 1;
>> +    env->ca = (xer >> XER_CA) & 1;
>> +    env->ov32 = (xer >> XER_OV32) & 1;
>> +    env->ca32 = (xer >> XER_CA32) & 1;
>> +    env->xer = xer & ~((1ul << XER_SO) |
>> +                       (1ul << XER_OV) | (1ul << XER_CA) |
>> +                       (1ul << XER_OV32) | (1ul << XER_CA32));
>> +}
>> +#endif
>
> You should probably move both of these out of line now (perhaps cpu.c).

Sure.


> You probably don't want to set ov32/ca32 unless the cpu is power9.  I assume 
> that if you attempt to set these bits for power8 they are 
> read-as-zero/write-ignore?

Sure, will make it CPU specific.

>> @@ -3715,6 +3719,12 @@ static void gen_read_xer(TCGv dst)
>>      tcg_gen_or_tl(t0, t0, t1);
>>      tcg_gen_or_tl(dst, dst, t2);
>>      tcg_gen_or_tl(dst, dst, t0);
>> +#ifdef TARGET_PPC64
>> +    tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
>> +    tcg_gen_or_tl(dst, dst, t0);
>> +    tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
>> +    tcg_gen_or_tl(dst, dst, t0);
>> +#endif
>>      tcg_temp_free(t0);
>>      tcg_temp_free(t1);
>>      tcg_temp_free(t2);
>> @@ -3727,9 +3737,14 @@ static void gen_write_xer(TCGv src)
>>      tcg_gen_shri_tl(cpu_so, src, XER_SO);
>>      tcg_gen_shri_tl(cpu_ov, src, XER_OV);
>>      tcg_gen_shri_tl(cpu_ca, src, XER_CA);
>> +    tcg_gen_shri_tl(cpu_ov32, src, XER_OV32);
>> +    tcg_gen_shri_tl(cpu_ca32, src, XER_CA32);
>>      tcg_gen_andi_tl(cpu_so, cpu_so, 1);
>>      tcg_gen_andi_tl(cpu_ov, cpu_ov, 1);
>>      tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
>> +    tcg_gen_andi_tl(cpu_ov32, cpu_ov32, 1);
>> +    tcg_gen_andi_tl(cpu_ca32, cpu_ca32, 1);
>> +
>>  }
>
> Watch the blank lines.  No ifdef here on the write side?

Right, will add.

Regards
Nikunj
