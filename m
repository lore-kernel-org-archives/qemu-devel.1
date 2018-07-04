Received: from eggs.gnu.org ([2001:4830:134:3::10]:46493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fahF3-0008Tc-0N
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fahF1-0000s6-Ob
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:50:41 -0400
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<1530602398-16127-6-git-send-email-eric.auger@redhat.com>
	<8495014b-5811-4f4f-5af3-d065cd6561b7@redhat.com>
	<2513e4a9-8980-6274-b933-a5e107b32da5@redhat.com>
	<401ccabc-584a-8754-bcb6-b4fdea6fe836@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <96e207c4-96e2-5d86-f27f-9dfb80577a9b@redhat.com>
Date: Wed, 4 Jul 2018 14:50:28 +0200
MIME-Version: 1.0
In-Reply-To: <401ccabc-584a-8754-bcb6-b4fdea6fe836@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 05/15] hw/arm/virt: handle
 max_vm_phys_shift conflicts on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com
Cc: wei@redhat.com, agraf@suse.de, drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

Hi David,
On 07/04/2018 01:53 PM, David Hildenbrand wrote:
> On 03.07.2018 21:32, Auger Eric wrote:
>> Hi David,
>> On 07/03/2018 08:41 PM, David Hildenbrand wrote:
>>> On 03.07.2018 09:19, Eric Auger wrote:
>>>> When migrating a VM, we must make sure the destination host
>>>> supports as many IPA bits as the source. Otherwise the migration
>>>> must fail.
>>>>
>>>> We add a VMState infrastructure to machvirt. On pre_save(),
>>>> the current source max_vm_phys_shift is saved.
>>>>
>>>> On destination, we cannot use this information when creating the
>>>> VM. The VM is created using the max value reported by the
>>>> destination host - or the kvm_type inherited value -. However on
>>>> post_load() we can check that this value is compatible with the
>>>> source saved value.
>>>
>>> Just wondering, how exactly is the guest able to detect the 42b (e.g. vs
>>> 42b) configuration?
>>
>> the source IPA size is saved in the VMState. When restoring it on
>> post_load we check against the current IPA size (corresponding to the
>> max the destination KVM does support). The destination IPA size is
>> chosen before creating the destination VM. If the destination IPA size
>> is less than the source IPA size, we fail the migration.
>>
>> Hope this helps
> 
> No, I asked if the *guest* is able to distinguish e.g. 43 from 44 or if
> the device memory setup is sufficient.
> 
> Once you create the machine, you setup device memory (using the maxmem
> parameter).
> 
> From that, you directly know how big the largest guest physical address
> will be (e.g. 2TB + (maxram_size - ram_size)). You can check that
> against max_vm_phys_shift and error out.

Ah OK I didn't catch your question. Yes indeed you method is simpler. At
the moment I don't think the guest can make any difference. But the
guest sees the CPU PARange which is fixed currently, as far as I
understand it; also the guest is GPA limited at compilation time with a
given CONFIG_ARM64_PA_BITS_=X config.

So we come back to Dave's remark, if we make CPU PARange match the
max_vm_phys_shift and make the former dynamic, then the guest can see it.

Thanks

Eric
> 
> During migration, source and destination have to have the same qemu
> cmdline, especially same maxmem parameter. So you would catch an invalid
> setup on the destination, without manually migrating and checking
> max_vm_phys_shift.
> 
> However (that's why I am asking) if the guest can spot the difference
> between e.g. 43 and 44, then you should migrate and check. If it is
> implicitly handled by device memory position and size, you should not
> migrate it.
> 
>>
>> Thanks
>>
>> Eric
>>
>>>
> 
> 
