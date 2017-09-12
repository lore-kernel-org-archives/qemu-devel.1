Received: from eggs.gnu.org ([2001:4830:134:3::10]:56679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drlmZ-0007nu-9j
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drlmT-0003ga-B1
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drlmT-0003gO-4V
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:03:13 -0400
References: <20170911152150.12535-1-david@redhat.com>
	<20170911152150.12535-19-david@redhat.com>
	<20170912154313.3616c2bf@nial.brq.redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9e1ea879-6c89-23bc-b775-062343d782af@redhat.com>
Date: Tue, 12 Sep 2017 16:03:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170912154313.3616c2bf@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 18/21] s390x: implement
 query-hotpluggable-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On 12.09.2017 15:43, Igor Mammedov wrote:
> On Mon, 11 Sep 2017 17:21:47 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> CPU hotplug is only possible on a per core basis on s390x.
>>
>> As we now have ms->possible_cpus, we can get rid of the global variable
>> cpu_states.
>>
>> While rewriting s390_cpu_addr2state() completely to be based on
>> possible_cpus, move it to cpu.c, as it is independent of the virtio-ccw
>> machine.
> I'd split patch on
>  1) introduce possible cpus 
>  2) rewrite s390_cpu_addr2state() using #2

Than I have to keep the global variable + setting it for one patch.
Might not be worth the trouble. Will have a look.

[...]
>>  
>> +static CPUArchId *s390_find_cpu_slot(MachineState *ms, uint32_t core_id,
>> +                                     int *idx)
>> +{
>> +    if (core_id >= ms->possible_cpus->len) {
>> +        return NULL;
>> +    }
>> +    /* core_id corresponds to the index */
>> +    if (idx) {
>> +        *idx = core_id;
>> +    }
>> +    return &ms->possible_cpus->cpus[core_id];
>> +}
> it looks like cpu_index == core_id == idx in possible_cpus,
> is this helper really necessary?
> (we have it in x86 because of possible not 1:1 mapping)
> 
> I'd drop it and just access array directly

Just kept this because the other architectures also have this. I can of
course drop it. The nice thing about this helper is the comment :)

[...]
>>  }
>> +
>> +S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>> +{
> target/cpu.c and cpu itself preferably shouldn't pull in
> or depend on machine, so I'd keep s390_cpu_addr2state() where it's now
> or somewhere in board related files

Thomas requested this. I actually don't care., but it looks like a
generic "get_cpu_by_arch_id" function. But I don't really want to go
that additional path now. And also I don't want to move this back and forth.

Thomas, what's your opinion?

Thanks!


-- 

Thanks,

David
