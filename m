Received: from eggs.gnu.org ([2001:4830:134:3::10]:48386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOUl8-0008Bw-7A
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 15:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOUl4-0005aa-VA
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 15:33:06 -0500
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-10-david@redhat.com>
	<20171211190145.4f3e2be5.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <208bf94f-6913-5f80-5df0-9859375e522d@redhat.com>
Date: Mon, 11 Dec 2017 21:32:58 +0100
MIME-Version: 1.0
In-Reply-To: <20171211190145.4f3e2be5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 09/15] s390x/tcg: implement
 TEST PENDING INTERRUPTION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On 11.12.2017 19:01, Cornelia Huck wrote:
> On Mon, 11 Dec 2017 14:47:34 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Use s390_cpu_virt_mem_write() so we can actually revert what we did
>> (re-inject the dequeued IO interrupt).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h      |  1 +
>>  target/s390x/insn-data.def |  1 +
>>  target/s390x/misc_helper.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>>  target/s390x/translate.c   |  8 +++++++
>>  4 files changed, 63 insertions(+)
>>
> 
>> +uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
>> +{
>> +    const uintptr_t ra = GETPC();
>> +    S390CPU *cpu = s390_env_get_cpu(env);
>> +    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
>> +    QEMUS390FlicIO *io = NULL;
>> +    LowCore *lowcore;
>> +
>> +    if (addr & 0x3) {
>> +        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
>> +    }
>> +
>> +    qemu_mutex_lock_iothread();
>> +    io = qemu_s390_flic_dequeue_io(flic, env->cregs[6]);
>> +    if (!io) {
>> +        qemu_mutex_unlock_iothread();
>> +        return 0;
>> +    }
>> +
>> +    if (addr) {
>> +        struct {
>> +            uint16_t id;
>> +            uint16_t nr;
>> +            uint32_t parm;
>> +        } tmp = {
>> +            .id = cpu_to_be16(io->id),
>> +            .nr = cpu_to_be16(io->nr),
>> +            .parm = cpu_to_be32(io->parm),
>> +        };
> 
> That's a two-word interruption code; can you call this something better
> than 'tmp'?

IMHO from the context we have here it should be pretty clear what is
happening. I mean we are defining and initializing the temporary data
structure.

But I can change the name if you can come up with a catchy variable name. :)

Thanks!

> 
>> +
>> +        if (s390_cpu_virt_mem_write(cpu, addr, 0, &tmp, sizeof(tmp))) {
>> +            /* writing failed, reinject and properly clean up */
>> +            s390_io_interrupt(io->id, io->nr, io->parm, io->word);
>> +            qemu_mutex_unlock_iothread();
>> +            g_free(io);
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +            return 0;
>> +        }
>> +    } else {
>> +        /* no protection applies */
>> +        lowcore = cpu_map_lowcore(env);
>> +        lowcore->subchannel_id = cpu_to_be16(io->id);
>> +        lowcore->subchannel_nr = cpu_to_be16(io->nr);
>> +        lowcore->io_int_parm = cpu_to_be32(io->parm);
>> +        lowcore->io_int_word = cpu_to_be32(io->word);
>> +        cpu_unmap_lowcore(lowcore);
>> +    }
>> +
>> +    g_free(io);
>> +    qemu_mutex_unlock_iothread();
>> +    return 1;
>> +}
>> +
>>  void HELPER(tsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
>>  {
>>      S390CPU *cpu = s390_env_get_cpu(env);


-- 

Thanks,

David / dhildenb
