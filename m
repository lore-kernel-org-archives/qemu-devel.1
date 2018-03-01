Received: from eggs.gnu.org ([2001:4830:134:3::10]:59190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNs6-0004wa-0N
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNry-0007mT-Ks
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:42 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:01:59 +0100
Message-Id: <20180301130201.24666-26-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 25/27] s390x/sclp: remove memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

>From an architecture point of view, nothing can be mapped into the address
space on s390x. All there is is memory. Therefore there is also not really
an interface to communicate such information to the guest. All we can do is
specify the maximum ram address and guests can probe in that range if
memory is available and usable (TPROT).

Also memory hotplug is strange. The guest can decide at some point in
time to add / remove memory in some range. While the hypervisor can deny
to online an increment, all increments have to be predefined and there is
no way of telling the guest about a newly "hotplugged" increment. So if we
specify right now e.g.
    -m 2G,slots=2,maxmem=20G
An ordinary fedora guest will happily online (hotplug) all memory,
resulting in a guest consuming 20G. So it really behaves rather like
    -m 22G
There is no way to hotplug memory from the outside like on other
architectures. This is of course bad for upper management layers.

As the guest can create/delete memory regions while it is running, of
course migration support is not available and tricky to implement.

With virtualization, it is different. We might want to map something
into guest address space (e.g. fake DAX devices) and not detect it
automatically as memory. So we really want to use the maxmem and slots
parameter just like on all other architectures. Such devices will have
to expose the applicable memory range themselves. To finally be able to
provide memory hotplug to guests, we will need a new paravirtualized
interface to do that (e.g. something into the direction of virtio-mem).

This implies, that maxmem cannot be used for s390x memory hotplug
anymore and has to go. This simplifies the code quite a bit.

As migration support is not working, this change cannot really break
migration as guests without slots and maxmem don't see the SCLP
features. Also, the ram size calculation does not change.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180219174231.10874-1-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
[CH: tweaked patch description, as discussed on list]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c         | 310 +-----------------------------------------------
 include/hw/s390x/sclp.h |  25 ----
 target/s390x/cpu.h      |   1 -
 3 files changed, 5 insertions(+), 331 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 276972b59f..047d577313 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -15,9 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "exec/memory.h"
 #include "sysemu/sysemu.h"
-#include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
@@ -57,10 +55,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 {
     ReadInfo *read_info = (ReadInfo *) sccb;
     MachineState *machine = MACHINE(qdev_get_machine());
-    sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
     int cpu_count;
     int rnsize, rnmax;
-    int slots = MIN(machine->ram_slots, s390_get_memslot_count());
     IplParameterBlock *ipib = s390_ipl_get_iplb();
 
     /* CPU information */
@@ -80,36 +76,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
 
-    /* Memory Hotplug is only supported for the ccw machine type */
-    if (mhd) {
-        mhd->standby_subregion_size = MEM_SECTION_SIZE;
-        /* Deduct the memory slot already used for core */
-        if (slots > 0) {
-            while ((mhd->standby_subregion_size * (slots - 1)
-                    < mhd->standby_mem_size)) {
-                mhd->standby_subregion_size = mhd->standby_subregion_size << 1;
-            }
-        }
-        /*
-         * Initialize mapping of guest standby memory sections indicating which
-         * are and are not online. Assume all standby memory begins offline.
-         */
-        if (mhd->standby_state_map == 0) {
-            if (mhd->standby_mem_size % mhd->standby_subregion_size) {
-                mhd->standby_state_map = g_malloc0((mhd->standby_mem_size /
-                                             mhd->standby_subregion_size + 1) *
-                                             (mhd->standby_subregion_size /
-                                             MEM_SECTION_SIZE));
-            } else {
-                mhd->standby_state_map = g_malloc0(mhd->standby_mem_size /
-                                                   MEM_SECTION_SIZE);
-            }
-        }
-        mhd->padded_ram_size = ram_size + mhd->pad_size;
-        mhd->rzm = 1 << mhd->increment_size;
-
-        read_info->facilities |= cpu_to_be64(SCLP_FC_ASSIGN_ATTACH_READ_STOR);
-    }
     read_info->mha_pow = s390_get_mha_pow();
     read_info->hmfai = cpu_to_be32(s390_get_hmfai());
 
@@ -121,7 +87,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
         read_info->rnsize2 = cpu_to_be32(rnsize);
     }
 
-    rnmax = machine->maxram_size >> sclp->increment_size;
+    /* we don't support standby memory, maxram_size is never exposed */
+    rnmax = machine->ram_size >> sclp->increment_size;
     if (rnmax < 0x10000) {
         read_info->rnmax = cpu_to_be16(rnmax);
     } else {
@@ -139,195 +106,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
 }
 
-static void read_storage_element0_info(SCLPDevice *sclp, SCCB *sccb)
-{
-    int i, assigned;
-    int subincrement_id = SCLP_STARTING_SUBINCREMENT_ID;
-    ReadStorageElementInfo *storage_info = (ReadStorageElementInfo *) sccb;
-    sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
-
-    if (!mhd) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        return;
-    }
-
-    if ((ram_size >> mhd->increment_size) >= 0x10000) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
-        return;
-    }
-
-    /* Return information regarding core memory */
-    storage_info->max_id = cpu_to_be16(mhd->standby_mem_size ? 1 : 0);
-    assigned = ram_size >> mhd->increment_size;
-    storage_info->assigned = cpu_to_be16(assigned);
-
-    for (i = 0; i < assigned; i++) {
-        storage_info->entries[i] = cpu_to_be32(subincrement_id);
-        subincrement_id += SCLP_INCREMENT_UNIT;
-    }
-    sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
-}
-
-static void read_storage_element1_info(SCLPDevice *sclp, SCCB *sccb)
-{
-    ReadStorageElementInfo *storage_info = (ReadStorageElementInfo *) sccb;
-    sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
-
-    if (!mhd) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        return;
-    }
-
-    if ((mhd->standby_mem_size >> mhd->increment_size) >= 0x10000) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
-        return;
-    }
-
-    /* Return information regarding standby memory */
-    storage_info->max_id = cpu_to_be16(mhd->standby_mem_size ? 1 : 0);
-    storage_info->assigned = cpu_to_be16(mhd->standby_mem_size >>
-                                         mhd->increment_size);
-    storage_info->standby = cpu_to_be16(mhd->standby_mem_size >>
-                                        mhd->increment_size);
-    sccb->h.response_code = cpu_to_be16(SCLP_RC_STANDBY_READ_COMPLETION);
-}
-
-static void attach_storage_element(SCLPDevice *sclp, SCCB *sccb,
-                                   uint16_t element)
-{
-    int i, assigned, subincrement_id;
-    AttachStorageElement *attach_info = (AttachStorageElement *) sccb;
-    sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
-
-    if (!mhd) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        return;
-    }
-
-    if (element != 1) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        return;
-    }
-
-    assigned = mhd->standby_mem_size >> mhd->increment_size;
-    attach_info->assigned = cpu_to_be16(assigned);
-    subincrement_id = ((ram_size >> mhd->increment_size) << 16)
-                      + SCLP_STARTING_SUBINCREMENT_ID;
-    for (i = 0; i < assigned; i++) {
-        attach_info->entries[i] = cpu_to_be32(subincrement_id);
-        subincrement_id += SCLP_INCREMENT_UNIT;
-    }
-    sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
-}
-
-static void assign_storage(SCLPDevice *sclp, SCCB *sccb)
-{
-    MemoryRegion *mr = NULL;
-    uint64_t this_subregion_size;
-    AssignStorage *assign_info = (AssignStorage *) sccb;
-    sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
-    ram_addr_t assign_addr;
-    MemoryRegion *sysmem = get_system_memory();
-
-    if (!mhd) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        return;
-    }
-    assign_addr = (be16_to_cpu(assign_info->rn) - 1) * mhd->rzm;
-
-    if ((assign_addr % MEM_SECTION_SIZE == 0) &&
-        (assign_addr >= mhd->padded_ram_size)) {
-        /* Re-use existing memory region if found */
-        mr = memory_region_find(sysmem, assign_addr, 1).mr;
-        memory_region_unref(mr);
-        if (!mr) {
-
-            MemoryRegion *standby_ram = g_new(MemoryRegion, 1);
-
-            /* offset to align to standby_subregion_size for allocation */
-            ram_addr_t offset = assign_addr -
-                                (assign_addr - mhd->padded_ram_size)
-                                % mhd->standby_subregion_size;
-
-            /* strlen("standby.ram") + 4 (Max of KVM_MEMORY_SLOTS) +  NULL */
-            char id[16];
-            snprintf(id, 16, "standby.ram%d",
-                     (int)((offset - mhd->padded_ram_size) /
-                     mhd->standby_subregion_size) + 1);
-
-            /* Allocate a subregion of the calculated standby_subregion_size */
-            if (offset + mhd->standby_subregion_size >
-                mhd->padded_ram_size + mhd->standby_mem_size) {
-                this_subregion_size = mhd->padded_ram_size +
-                  mhd->standby_mem_size - offset;
-            } else {
-                this_subregion_size = mhd->standby_subregion_size;
-            }
-
-            memory_region_init_ram(standby_ram, NULL, id, this_subregion_size,
-                                   &error_fatal);
-            /* This is a hack to make memory hotunplug work again. Once we have
-             * subdevices, we have to unparent them when unassigning memory,
-             * instead of doing it via the ref count of the MemoryRegion. */
-            object_ref(OBJECT(standby_ram));
-            object_unparent(OBJECT(standby_ram));
-            memory_region_add_subregion(sysmem, offset, standby_ram);
-        }
-        /* The specified subregion is no longer in standby */
-        mhd->standby_state_map[(assign_addr - mhd->padded_ram_size)
-                               / MEM_SECTION_SIZE] = 1;
-    }
-    sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
-}
-
-static void unassign_storage(SCLPDevice *sclp, SCCB *sccb)
-{
-    MemoryRegion *mr = NULL;
-    AssignStorage *assign_info = (AssignStorage *) sccb;
-    sclpMemoryHotplugDev *mhd = get_sclp_memory_hotplug_dev();
-    ram_addr_t unassign_addr;
-    MemoryRegion *sysmem = get_system_memory();
-
-    if (!mhd) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        return;
-    }
-    unassign_addr = (be16_to_cpu(assign_info->rn) - 1) * mhd->rzm;
-
-    /* if the addr is a multiple of 256 MB */
-    if ((unassign_addr % MEM_SECTION_SIZE == 0) &&
-        (unassign_addr >= mhd->padded_ram_size)) {
-        mhd->standby_state_map[(unassign_addr -
-                           mhd->padded_ram_size) / MEM_SECTION_SIZE] = 0;
-
-        /* find the specified memory region and destroy it */
-        mr = memory_region_find(sysmem, unassign_addr, 1).mr;
-        memory_region_unref(mr);
-        if (mr) {
-            int i;
-            int is_removable = 1;
-            ram_addr_t map_offset = (unassign_addr - mhd->padded_ram_size -
-                                     (unassign_addr - mhd->padded_ram_size)
-                                     % mhd->standby_subregion_size);
-            /* Mark all affected subregions as 'standby' once again */
-            for (i = 0;
-                 i < (mhd->standby_subregion_size / MEM_SECTION_SIZE);
-                 i++) {
-
-                if (mhd->standby_state_map[i + map_offset / MEM_SECTION_SIZE]) {
-                    is_removable = 0;
-                    break;
-                }
-            }
-            if (is_removable) {
-                memory_region_del_subregion(sysmem, mr);
-                object_unref(OBJECT(mr));
-            }
-        }
-    }
-    sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
-}
-
 /* Provide information about the CPU */
 static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
 {
@@ -390,22 +168,6 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
     case SCLP_CMDW_READ_CPU_INFO:
         sclp_c->read_cpu_info(sclp, sccb);
         break;
-    case SCLP_READ_STORAGE_ELEMENT_INFO:
-        if (code & 0xff00) {
-            sclp_c->read_storage_element1_info(sclp, sccb);
-        } else {
-            sclp_c->read_storage_element0_info(sclp, sccb);
-        }
-        break;
-    case SCLP_ATTACH_STORAGE_ELEMENT:
-        sclp_c->attach_storage_element(sclp, sccb, (code & 0xff00) >> 8);
-        break;
-    case SCLP_ASSIGN_STORAGE:
-        sclp_c->assign_storage(sclp, sccb);
-        break;
-    case SCLP_UNASSIGN_STORAGE:
-        sclp_c->unassign_storage(sclp, sccb);
-        break;
     case SCLP_CMDW_CONFIGURE_IOA:
         sclp_configure_io_adapter(sclp, sccb, true);
         break;
@@ -540,9 +302,6 @@ static void sclp_memory_init(SCLPDevice *sclp)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     ram_addr_t initial_mem = machine->ram_size;
-    ram_addr_t max_mem = machine->maxram_size;
-    ram_addr_t standby_mem = max_mem - initial_mem;
-    ram_addr_t pad_mem = 0;
     int increment_size = 20;
 
     /* The storage increment size is a multiple of 1M and is a power of 2.
@@ -552,34 +311,14 @@ static void sclp_memory_init(SCLPDevice *sclp)
     while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
         increment_size++;
     }
-    if (machine->ram_slots) {
-        while ((standby_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
-            increment_size++;
-        }
-    }
     sclp->increment_size = increment_size;
 
-    /* The core and standby memory areas need to be aligned with
-     * the increment size.  In effect, this can cause the
-     * user-specified memory size to be rounded down to align
-     * with the nearest increment boundary. */
+    /* The core memory area needs to be aligned with the increment size.
+     * In effect, this can cause the user-specified memory size to be rounded
+     * down to align with the nearest increment boundary. */
     initial_mem = initial_mem >> increment_size << increment_size;
-    standby_mem = standby_mem >> increment_size << increment_size;
-
-    /* If the size of ram is not on a MEM_SECTION_SIZE boundary,
-       calculate the pad size necessary to force this boundary. */
-    if (machine->ram_slots && standby_mem) {
-        sclpMemoryHotplugDev *mhd = init_sclp_memory_hotplug_dev();
 
-        if (initial_mem % MEM_SECTION_SIZE) {
-            pad_mem = MEM_SECTION_SIZE - initial_mem % MEM_SECTION_SIZE;
-        }
-        mhd->increment_size = increment_size;
-        mhd->pad_size = pad_mem;
-        mhd->standby_mem_size = standby_mem;
-    }
     machine->ram_size = initial_mem;
-    machine->maxram_size = initial_mem + pad_mem + standby_mem;
     /* let's propagate the changed ram size into the global variable. */
     ram_size = initial_mem;
 }
@@ -613,11 +352,6 @@ static void sclp_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 
     sc->read_SCP_info = read_SCP_info;
-    sc->read_storage_element0_info = read_storage_element0_info;
-    sc->read_storage_element1_info = read_storage_element1_info;
-    sc->attach_storage_element = attach_storage_element;
-    sc->assign_storage = assign_storage;
-    sc->unassign_storage = unassign_storage;
     sc->read_cpu_info = sclp_read_cpu_info;
     sc->execute = sclp_execute;
     sc->service_interrupt = service_interrupt;
@@ -632,42 +366,8 @@ static TypeInfo sclp_info = {
     .class_size = sizeof(SCLPDeviceClass),
 };
 
-sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void)
-{
-    DeviceState *dev;
-    dev = qdev_create(NULL, TYPE_SCLP_MEMORY_HOTPLUG_DEV);
-    object_property_add_child(qdev_get_machine(),
-                              TYPE_SCLP_MEMORY_HOTPLUG_DEV,
-                              OBJECT(dev), NULL);
-    qdev_init_nofail(dev);
-    return SCLP_MEMORY_HOTPLUG_DEV(object_resolve_path(
-                                   TYPE_SCLP_MEMORY_HOTPLUG_DEV, NULL));
-}
-
-sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void)
-{
-    return SCLP_MEMORY_HOTPLUG_DEV(object_resolve_path(
-                                   TYPE_SCLP_MEMORY_HOTPLUG_DEV, NULL));
-}
-
-static void sclp_memory_hotplug_dev_class_init(ObjectClass *klass,
-                                               void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-}
-
-static TypeInfo sclp_memory_hotplug_dev_info = {
-    .name = TYPE_SCLP_MEMORY_HOTPLUG_DEV,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(sclpMemoryHotplugDev),
-    .class_init = sclp_memory_hotplug_dev_class_init,
-};
-
 static void register_types(void)
 {
-    type_register_static(&sclp_memory_hotplug_dev_info);
     type_register_static(&sclp_info);
 }
 type_init(register_types);
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 847ff32f85..476cbf78f2 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -202,12 +202,6 @@ typedef struct SCLPDeviceClass {
     /* private */
     DeviceClass parent_class;
     void (*read_SCP_info)(SCLPDevice *sclp, SCCB *sccb);
-    void (*read_storage_element0_info)(SCLPDevice *sclp, SCCB *sccb);
-    void (*read_storage_element1_info)(SCLPDevice *sclp, SCCB *sccb);
-    void (*attach_storage_element)(SCLPDevice *sclp, SCCB *sccb,
-                                   uint16_t element);
-    void (*assign_storage)(SCLPDevice *sclp, SCCB *sccb);
-    void (*unassign_storage)(SCLPDevice *sclp, SCCB *sccb);
     void (*read_cpu_info)(SCLPDevice *sclp, SCCB *sccb);
 
     /* public */
@@ -215,23 +209,6 @@ typedef struct SCLPDeviceClass {
     void (*service_interrupt)(SCLPDevice *sclp, uint32_t sccb);
 } SCLPDeviceClass;
 
-typedef struct sclpMemoryHotplugDev sclpMemoryHotplugDev;
-
-#define TYPE_SCLP_MEMORY_HOTPLUG_DEV "sclp-memory-hotplug-dev"
-#define SCLP_MEMORY_HOTPLUG_DEV(obj) \
-  OBJECT_CHECK(sclpMemoryHotplugDev, (obj), TYPE_SCLP_MEMORY_HOTPLUG_DEV)
-
-struct sclpMemoryHotplugDev {
-    SysBusDevice parent;
-    ram_addr_t standby_mem_size;
-    ram_addr_t padded_ram_size;
-    ram_addr_t pad_size;
-    ram_addr_t standby_subregion_size;
-    ram_addr_t rzm;
-    int increment_size;
-    char *standby_state_map;
-};
-
 static inline int sccb_data_len(SCCB *sccb)
 {
     return be16_to_cpu(sccb->h.length) - sizeof(sccb->h);
@@ -239,8 +216,6 @@ static inline int sccb_data_len(SCCB *sccb)
 
 
 void s390_sclp_init(void);
-sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
-sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
 void sclp_service_interrupt(uint32_t sccb);
 void raise_irq_cpu_hotplug(void);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 802324b3e2..5bd6de7e8e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -622,7 +622,6 @@ QEMU_BUILD_BUG_ON(sizeof(SysIB) != 4096);
 #define SIGP_ORDER_MASK 0x000000ff
 
 /* from s390-virtio-ccw */
-#define MEM_SECTION_SIZE             0x10000000UL
 #define MAX_AVAIL_SLOTS              32
 
 /* machine check interruption code */
-- 
2.13.6
