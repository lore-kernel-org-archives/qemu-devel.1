Received: from eggs.gnu.org ([2001:4830:134:3::10]:54560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1enozp-0006dC-Sz
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1enozn-0006ek-4m
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:12:57 -0500
References: <20180219143341.4290-1-david@redhat.com>
	<20180219180831.2f36ec1e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3cac8c6e-725c-bce9-f9cd-fcadbf5639c3@redhat.com>
Date: Mon, 19 Feb 2018 18:12:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180219180831.2f36ec1e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] s390x/sclp: remove memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>


>> As migration support is not working, this change cannot really break
>> migration. As the memory hotplug device was always created, we can
>> simply continue faking support for SCLP_FC_ASSIGN_ATTACH_READ_STOR and
>> expose the same information just as if no maxmem and slots parameter was
>> given on the command line (to not break migration of ordinary guests).
> 
> I'm a bit worried here, though. Doesn't that imply a guest-visible
> change?

See below.

> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/sclp.c         | 261 ++++--------------------------------------------
>>  include/hw/s390x/sclp.h |  19 ----
>>  target/s390x/cpu.h      |   2 -
>>  3 files changed, 18 insertions(+), 264 deletions(-)
> 
> Nice diffstat :)
> 
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 276972b59f..0a2114e592 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -15,9 +15,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "cpu.h"
>> -#include "exec/memory.h"
>>  #include "sysemu/sysemu.h"
>> -#include "exec/address-spaces.h"
>>  #include "hw/boards.h"
>>  #include "hw/s390x/sclp.h"
>>  #include "hw/s390x/event-facility.h"
>> @@ -57,10 +55,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>>      ReadInfo *read_info = (ReadInfo *) sccb;
>>      MachineState *machine = MACHINE(qdev_get_machine());
>> -    sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
>>      int cpu_count;
>>      int rnsize, rnmax;
>> -    int slots = MIN(machine->ram_slots, s390_get_memslot_count());
>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>>  
>>      /* CPU information */
>> @@ -78,38 +74,9 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>                           read_info->conf_char_ext);
>>  
>>      read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
>> -                                        SCLP_HAS_IOA_RECONFIG);
>> -
>> -    /* Memory Hotplug is only supported for the ccw machine type */
>> -    if (mhd) {
>> -        mhd->standby_subregion_size = MEM_SECTION_SIZE;
>> -        /* Deduct the memory slot already used for core */
>> -        if (slots > 0) {
>> -            while ((mhd->standby_subregion_size * (slots - 1)
>> -                    < mhd->standby_mem_size)) {
>> -                mhd->standby_subregion_size = mhd->standby_subregion_size << 1;
>> -            }
>> -        }
>> -        /*
>> -         * Initialize mapping of guest standby memory sections indicating which
>> -         * are and are not online. Assume all standby memory begins offline.
>> -         */
>> -        if (mhd->standby_state_map == 0) {
>> -            if (mhd->standby_mem_size % mhd->standby_subregion_size) {
>> -                mhd->standby_state_map = g_malloc0((mhd->standby_mem_size /
>> -                                             mhd->standby_subregion_size + 1) *
>> -                                             (mhd->standby_subregion_size /
>> -                                             MEM_SECTION_SIZE));
>> -            } else {
>> -                mhd->standby_state_map = g_malloc0(mhd->standby_mem_size /
>> -                                                   MEM_SECTION_SIZE);
>> -            }
>> -        }
>> -        mhd->padded_ram_size = ram_size + mhd->pad_size;
>> -        mhd->rzm = 1 << mhd->increment_size;
>> +                                        SCLP_HAS_IOA_RECONFIG |
>> +                                        SCLP_FC_ASSIGN_ATTACH_READ_STOR);
>>  
>> -        read_info->facilities |= cpu_to_be64(SCLP_FC_ASSIGN_ATTACH_READ_STOR);
>> -    }
> 
> Previously we only indicated this facility if we actually had standby
> mem, didn't we?

Indeed. I missed that init_sclp_memory_hotplug_dev() was called
conditionally (blindly deleting stuff). This way we can remove even more.

> 
> (...)
> 
>>  static void assign_storage(SCLPDevice *sclp, SCCB *sccb)
>>  {
>> -    MemoryRegion *mr = NULL;
>> -    uint64_t this_subregion_size;
>> -    AssignStorage *assign_info = (AssignStorage *) sccb;
>> -    sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
>> -    ram_addr_t assign_addr;
>> -    MemoryRegion *sysmem = get_system_memory();
>> -
>> -    if (!mhd) {
>> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>> -        return;
>> -    }
>> -    assign_addr = (be16_to_cpu(assign_info->rn) - 1) * mhd->rzm;
>> -
>> -    if ((assign_addr % MEM_SECTION_SIZE == 0) &&
>> -        (assign_addr >= mhd->padded_ram_size)) {
>> -        /* Re-use existing memory region if found */
>> -        mr = memory_region_find(sysmem, assign_addr, 1).mr;
>> -        memory_region_unref(mr);
>> -        if (!mr) {
>> -
>> -            MemoryRegion *standby_ram = g_new(MemoryRegion, 1);
>> -
>> -            /* offset to align to standby_subregion_size for allocation */
>> -            ram_addr_t offset = assign_addr -
>> -                                (assign_addr - mhd->padded_ram_size)
>> -                                % mhd->standby_subregion_size;
>> -
>> -            /* strlen("standby.ram") + 4 (Max of KVM_MEMORY_SLOTS) +  NULL */
>> -            char id[16];
>> -            snprintf(id, 16, "standby.ram%d",
>> -                     (int)((offset - mhd->padded_ram_size) /
>> -                     mhd->standby_subregion_size) + 1);
>> -
>> -            /* Allocate a subregion of the calculated standby_subregion_size */
>> -            if (offset + mhd->standby_subregion_size >
>> -                mhd->padded_ram_size + mhd->standby_mem_size) {
>> -                this_subregion_size = mhd->padded_ram_size +
>> -                  mhd->standby_mem_size - offset;
>> -            } else {
>> -                this_subregion_size = mhd->standby_subregion_size;
>> -            }
>> -
>> -            memory_region_init_ram(standby_ram, NULL, id, this_subregion_size,
>> -                                   &error_fatal);
>> -            /* This is a hack to make memory hotunplug work again. Once we have
>> -             * subdevices, we have to unparent them when unassigning memory,
>> -             * instead of doing it via the ref count of the MemoryRegion. */
>> -            object_ref(OBJECT(standby_ram));
>> -            object_unparent(OBJECT(standby_ram));
>> -            memory_region_add_subregion(sysmem, offset, standby_ram);
>> -        }
>> -        /* The specified subregion is no longer in standby */
>> -        mhd->standby_state_map[(assign_addr - mhd->padded_ram_size)
>> -                               / MEM_SECTION_SIZE] = 1;
>> -    }
>> +    /* FIXME, is there really no error code to indicate? */
>>      sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
> 
> Again, I think we did not actually have a mhd if we did not have
> standby mem, so this already returned invalid command before? What am I
> missing?

Nothing, we actually have to get rid of it.

Thanks

-- 

Thanks,

David / dhildenb
