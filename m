Received: from eggs.gnu.org ([2001:4830:134:3::10]:51865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK7YD-0006jZ-DF
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK7Y8-00058e-JM
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:57:41 -0500
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-15-david@redhat.com>
	<5b0cb24c-a92e-1109-8b3c-de76389f93dd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2383f680-4930-9437-9397-a5ee63ed79d1@redhat.com>
Date: Wed, 29 Nov 2017 19:57:33 +0100
MIME-Version: 1.0
In-Reply-To: <5b0cb24c-a92e-1109-8b3c-de76389f93dd@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 14/15] s390x/tcg: drop
 program_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 29.11.2017 19:18, Richard Henderson wrote:
> On 11/28/2017 08:33 PM, David Hildenbrand wrote:
>> -void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
>> +void program_interrupt_ra(CPUS390XState *env, uint32_t code, int ilen,
>> +                          uintptr_t ra)
>>  {
>>      S390CPU *cpu = s390_env_get_cpu(env);
>>  
>>      qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
>>                    env->psw.addr);
>>  
>> +#ifdef CONFIG_TCG
>> +    if (tcg_enabled() && ra) {
>> +        cpu_restore_state(CPU(cpu), ra);
>> +    }
>> +#endif
> 
> Please move this into tcg_s390_program_interrupt by using cpu_loop_exit_restore
> there.
> 

Indeed, good idea, thanks!

> 
> r~
> 


-- 

Thanks,

David / dhildenb
