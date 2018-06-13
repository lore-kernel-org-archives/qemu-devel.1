Received: from eggs.gnu.org ([2001:4830:134:3::10]:42302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT6Uq-0003wO-W1
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT6Uo-0001ZI-4Y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:11:36 -0400
References: <20180611121655.19616-1-david@redhat.com>
	<20180613153454.3e0a07a3@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <11ae5790-03c8-d81c-1074-dcc1e054fedc@redhat.com>
Date: Wed, 13 Jun 2018 16:11:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180613153454.3e0a07a3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/11] pc-dimm: next bunch of cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 13.06.2018 15:34, Igor Mammedov wrote:
> On Mon, 11 Jun 2018 14:16:44 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> This is another set of cleanups as the result from
>>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
>> And is based on the two series
>>     [PATCH v1 0/2] memory: fix alignment checks/asserts
>>     [PATCH v2 0/6] spapr: machine hotplug handler cleanups
>>
>> These cleanup are the last step before factoring out the
>> pre_plug, plug and unplug logic of memory devices completely, to make it
>> more independent from pc-dimm.
> patches 1-4 are fine,
> the rest starting from 5/11 is based on wrong assumptions so should
> be reworked or dropped.

@Paolo can you pick up patch 1-4, so we have them out of the way (while
I potentially create new and more patches?)

> 
>> But these patches will already try to make an important point: Assigning
>> physical addresses of memory devices will not be done in pre_plug but
>> during plug. Other properties, like the "slot" property, however can be
>> handled during pre_plug and is done in this patch series, because they
>> don't realy on the device to be realized.
>>
>> Igor proposed to move all property checks + assigmnets to the pre_plug
>> stage. Hovewer for determining a physical address of a memory device, we
>> need to know the exact size and the alignment of the underlying memory
>> region.
>>
>> This region might not be available and initialized before the device has
>> been realized (e.g. for NVDIMM). So my point is: Accessing derived
>> "properties" ("memory region" set up based on "memdev" property and maybe
>> others e.g. for NVDIMM) via device class functions should not be done
>> before the device has been realized. These functions should not be
>> called during pre_plug.
> It's impl. issue/bug of NVDIMM where it does initialization late, which
> leads to access to uninitialized region in several places and we should fix.
> 
> There is nothing fundamental that prevents accessing size/memory of
> backend that was linked to dimm device at pre_plug() time,
> since all user specified properties are already set and it's time
> for machine to check if properties are correct from machine's pov
> and set its own values before proceeding to device.realize() and
> plug() handler. That includes setting default GPA property. 
> 
> Hence I'm not willing to agree going backwards or adding more
> code/refactoring based on broken behavior.
> 
>>
>> Enforcing this, already leads to sime nice cleanup numbers in pc-dimm
>> code.
>>
>> David Hildenbrand (11):
>>   pc-dimm: remove leftover "struct pc_dimms_capacity"
>>   nvdimm: no need to overwrite get_vmstate_memory_region()
>>   pc: factor out pc-dimm checks into pc_dimm_pre_plug()
>>   hostmem: drop error variable from host_memory_backend_get_memory()
>>   spapr: move memory hotplug size check into plug code
>>   pc-dimm: don't allow to access "size" before the device was realized
>>   pc-dimm: get_memory_region() can never fail
>>   pc-dimm: get_memory_region() will never return a NULL pointer
>>   pc-dimm: remove pc_dimm_get_vmstate_memory_region()
>>   pc-dimm: introduce and use pc_dimm_memory_pre_plug()
>>   pc-dimm: assign and verify the "slot" property during pre_plug
>>
>>  backends/hostmem.c       |  3 +-
>>  hw/i386/pc.c             | 53 ++++++++++++++------------
>>  hw/mem/nvdimm.c          | 12 ++----
>>  hw/mem/pc-dimm.c         | 82 +++++++++++++++-------------------------
>>  hw/misc/ivshmem.c        |  3 +-
>>  hw/ppc/spapr.c           | 36 +++++-------------
>>  include/hw/mem/pc-dimm.h |  6 ++-
>>  include/sysemu/hostmem.h |  3 +-
>>  numa.c                   |  3 +-
>>  9 files changed, 81 insertions(+), 120 deletions(-)
>>
> 


-- 

Thanks,

David / dhildenb
