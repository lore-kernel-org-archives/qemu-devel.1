Received: from eggs.gnu.org ([2001:4830:134:3::10]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dGkBn-0006Mh-La
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dGkBj-0000kG-PL
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:52:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dGkBj-0000jU-Ii
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:52:15 -0400
References: <20170601101438.28732-1-david@redhat.com>
	<20170601192011.crq6igwuln4hyjw5@aurel32.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <714c789a-a8e9-b1d4-07ca-b7f36b657984@redhat.com>
Date: Fri, 2 Jun 2017 12:52:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170601192011.crq6igwuln4hyjw5@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpumodel: wire up cpu type + id
 for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com


>> +
>> +#ifndef CONFIG_USER_ONLY
>> +void HELPER(stidp)(CPUS390XState *env, uint64_t addr)
>> +{
>> +    S390CPU *cpu = s390_env_get_cpu(env);
>> +    uint64_t cpuid = s390_cpuid_from_cpu_model(cpu->model);
>> +
>> +    if (addr & 0x7) {
>> +        program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);
>> +        return;
>> +    }
>> +
>> +    /* basic mode, write the cpu address into the first 4 bit of the ID */
>> +    cpuid |= ((uint64_t)env->cpu_num & 0xf) << 54;
>> +    cpu_stq_data(env, addr, cpuid);
>> +}
>> +#endif
> 
> I don't really see the point of using an helper instead of just updating
> the existing code. From what I understand the cpuid does not change at
> runtime, so the s390_cpuid_from_cpu_model function can also be called 
> from translate.c.
> 
> Aurelien
> 

>From what I can see, conditional exceptions are more complicated to
implement without helpers (involves generating compares, jumps and so
on). As this function is not expected to be executed on hot paths, I
think moving it into a helper is the right thing to do.

-- 

Thanks,

David
