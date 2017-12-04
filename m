Received: from eggs.gnu.org ([2001:4830:134:3::10]:43461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLuWQ-0006lO-4k
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLuWM-0005DN-V7
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:27:14 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-3-david@redhat.com>
	<20171204182033.7e700dec.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bc52da4c-3122-2040-baec-ac50ede5da90@redhat.com>
Date: Mon, 4 Dec 2017 18:27:06 +0100
MIME-Version: 1.0
In-Reply-To: <20171204182033.7e700dec.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 2/5] s390x/tcg: fix and cleanup
 mcck injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 04.12.2017 18:20, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 13:55:02 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> The architecture mode indication wasn't stored. The split of certain
>> 64bit fields was unnecessary. Also, the complete clock comparator, not
>> just bit 0-55 (starting at byte 1) was stored.
>>
>> We now generate a proper MCIC via the same helper we use for KVM.
>>
>> While at it, also get rid of two local variables. There is be more to
>> clean up, but we will change the other parts later on either way.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/excp_helper.c | 18 ++++++++----------
>>  target/s390x/internal.h    |  6 +++---
>>  2 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
>> index d831537544..840cf7641a 100644
>> --- a/target/s390x/excp_helper.c
>> +++ b/target/s390x/excp_helper.c
>> @@ -369,7 +369,6 @@ static void do_io_interrupt(CPUS390XState *env)
>>  static void do_mchk_interrupt(CPUS390XState *env)
>>  {
>>      S390CPU *cpu = s390_env_get_cpu(env);
>> -    uint64_t mask, addr;
>>      LowCore *lowcore;
>>      MchkQueue *q;
>>      int i;
> 
> [BTW, there's also a CR 14 check in here that probably could use the
> new #define.]

Yes, will be gone with my floating IRQ rework, that's why I am not
touching it here. (We will no longer track machine checks in a list but
per cr14 sublcass - initially only crw).

> 
>> @@ -395,6 +394,9 @@ static void do_mchk_interrupt(CPUS390XState *env)
>>  
>>      lowcore = cpu_map_lowcore(env);
>>  
>> +    /* we are always in z/Architecture mode */
>> +    lowcore->ar_access_id = 1;
>> +
>>      for (i = 0; i < 16; i++) {
>>          lowcore->floating_pt_save_area[i] = cpu_to_be64(get_freg(env, i)->ll);
>>          lowcore->gpregs_save_area[i] = cpu_to_be64(env->regs[i]);
>> @@ -404,17 +406,12 @@ static void do_mchk_interrupt(CPUS390XState *env)
>>      lowcore->prefixreg_save_area = cpu_to_be32(env->psa);
>>      lowcore->fpt_creg_save_area = cpu_to_be32(env->fpc);
>>      lowcore->tod_progreg_save_area = cpu_to_be32(env->todpr);
>> -    lowcore->cpu_timer_save_area[0] = cpu_to_be32(env->cputm >> 32);
>> -    lowcore->cpu_timer_save_area[1] = cpu_to_be32((uint32_t)env->cputm);
>> -    lowcore->clock_comp_save_area[0] = cpu_to_be32(env->ckc >> 32);
>> -    lowcore->clock_comp_save_area[1] = cpu_to_be32((uint32_t)env->ckc);
>> +    lowcore->cpu_timer_save_area = cpu_to_be64(env->cputm);
>> +    lowcore->clock_comp_save_area = cpu_to_be64(env->ckc >> 8);
>>  
>> -    lowcore->mcck_interruption_code[0] = cpu_to_be32(0x00400f1d);
>> -    lowcore->mcck_interruption_code[1] = cpu_to_be32(0x40330000);
>> +    lowcore->mcic = cpu_to_be64(s390_build_validity_mcic() | MCIC_SC_CP);
> 
> Hm... I'm not sure that is a good idea (the nature of the helper, not
> that you remove the magic values).
> 
> This function is called do_mchk_interrupt(), which sounds like a more
> generic thing. Maybe we need to enhance the machine check code to save
> the mcic etc. somewhere (after it has been generated) and just inject
> it here? Similar to what the kernel does.
> 
> If you want to avoid rework, just add a TODO here?

Will also be gone with my floating IRQ rework ;) I can add a TODO if
that helps, but 99.99996% it will be gone within 2-4 weeks.

> 
>>      lowcore->mcck_old_psw.mask = cpu_to_be64(get_psw_mask(env));
>>      lowcore->mcck_old_psw.addr = cpu_to_be64(env->psw.addr);
>> -    mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
>> -    addr = be64_to_cpu(lowcore->mcck_new_psw.addr);
>>  
>>      cpu_unmap_lowcore(lowcore);
>>  


-- 

Thanks,

David / dhildenb
