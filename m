Received: from eggs.gnu.org ([2001:4830:134:3::10]:54936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dGnYc-0000o1-3G
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dGnYX-0006pu-7m
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:28:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dGnYX-0006pX-1z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:28:01 -0400
References: <20170601101438.28732-1-david@redhat.com>
	<20170601192011.crq6igwuln4hyjw5@aurel32.net>
	<714c789a-a8e9-b1d4-07ca-b7f36b657984@redhat.com>
	<20170602140448.r4e2evvpm76kcshe@aurel32.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8c461a07-d1e0-87b0-1374-b328dc1d1d75@redhat.com>
Date: Fri, 2 Jun 2017 16:27:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170602140448.r4e2evvpm76kcshe@aurel32.net>
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

On 02.06.2017 16:04, Aurelien Jarno wrote:
> On 2017-06-02 12:52, David Hildenbrand wrote:
>>
>>>> +
>>>> +#ifndef CONFIG_USER_ONLY
>>>> +void HELPER(stidp)(CPUS390XState *env, uint64_t addr)
>>>> +{
>>>> +    S390CPU *cpu = s390_env_get_cpu(env);
>>>> +    uint64_t cpuid = s390_cpuid_from_cpu_model(cpu->model);
>>>> +
>>>> +    if (addr & 0x7) {
>>>> +        program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* basic mode, write the cpu address into the first 4 bit of the ID */
>>>> +    cpuid |= ((uint64_t)env->cpu_num & 0xf) << 54;
>>>> +    cpu_stq_data(env, addr, cpuid);
>>>> +}
>>>> +#endif
>>>
>>> I don't really see the point of using an helper instead of just updating
>>> the existing code. From what I understand the cpuid does not change at
>>> runtime, so the s390_cpuid_from_cpu_model function can also be called 
>>> from translate.c.
>>>
>>> Aurelien
>>>
>>
>> From what I can see, conditional exceptions are more complicated to
>> implement without helpers (involves generating compares, jumps and so
> 
> In that case you don't need to do any compare an jump. It's a standard
> load/store alignement check, you can just specify the MO_ALIGN flag to
> the tcg_gen_qemu_st_i64 function.
> 

Thanks for the hint, will look into that. And also add low-address
protection checks.

-- 

Thanks,

David
