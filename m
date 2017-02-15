Received: from eggs.gnu.org ([2001:4830:134:3::10]:33109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ce27g-0004KL-BJ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ce27d-0006At-Pp
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:08:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ce27d-0006Ac-Gl
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:08:01 -0500
Date: Wed, 15 Feb 2017 17:07:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170215170757.59fe54de@nial.brq.redhat.com>
In-Reply-To: <6d3caba0-c747-457d-0fee-b02f7f09e50a@redhat.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<111628dff0803a21b75cc390858f0c288decee22.1487139038.git.ben@skyportsystems.com>
	<20170215131903.2394b096@nial.brq.redhat.com>
	<6d3caba0-c747-457d-0fee-b02f7f09e50a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 4/7] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, mst@redhat.com

On Wed, 15 Feb 2017 16:24:52 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 02/15/17 13:19, Igor Mammedov wrote:
> > On Tue, 14 Feb 2017 22:15:46 -0800
> > ben@skyportsystems.com wrote:
> >   
> >> From: Ben Warren <ben@skyportsystems.com>
> >>
> >> This implements the VM Generation ID feature by passing a 128-bit
> >> GUID to the guest via a fw_cfg blob.
> >> Any time the GUID changes, an ACPI notify event is sent to the guest
> >>
> >> The user interface is a simple device with one parameter:
> >>  - guid (string, must be "auto" or in UUID format
> >>    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
> >>
> >> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> >> ---
> >>  default-configs/i386-softmmu.mak     |   1 +
> >>  default-configs/x86_64-softmmu.mak   |   1 +
> >>  hw/acpi/Makefile.objs                |   1 +
> >>  hw/acpi/vmgenid.c                    | 237 +++++++++++++++++++++++++++++++++++
> >>  hw/i386/acpi-build.c                 |  16 +++
> >>  include/hw/acpi/acpi_dev_interface.h |   1 +
> >>  include/hw/acpi/vmgenid.h            |  35 ++++++
> >>  7 files changed, 292 insertions(+)
> >>  create mode 100644 hw/acpi/vmgenid.c
> >>  create mode 100644 include/hw/acpi/vmgenid.h
> >>
> >> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> >> index 48b07a4..029e952 100644
> >> --- a/default-configs/i386-softmmu.mak
> >> +++ b/default-configs/i386-softmmu.mak
> >> @@ -59,3 +59,4 @@ CONFIG_I82801B11=y
> >>  CONFIG_SMBIOS=y
> >>  CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
> >>  CONFIG_PXB=y
> >> +CONFIG_ACPI_VMGENID=y
> >> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> >> index fd96345..d1d7432 100644
> >> --- a/default-configs/x86_64-softmmu.mak
> >> +++ b/default-configs/x86_64-softmmu.mak
> >> @@ -59,3 +59,4 @@ CONFIG_I82801B11=y
> >>  CONFIG_SMBIOS=y
> >>  CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
> >>  CONFIG_PXB=y
> >> +CONFIG_ACPI_VMGENID=y
> >> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> >> index 6acf798..11c35bc 100644
> >> --- a/hw/acpi/Makefile.objs
> >> +++ b/hw/acpi/Makefile.objs
> >> @@ -5,6 +5,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
> >>  common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
> >>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
> >>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
> >> +common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
> >>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
> >>  
> >>  common-obj-y += acpi_interface.o
> >> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> >> new file mode 100644
> >> index 0000000..b1b7b32
> >> --- /dev/null
> >> +++ b/hw/acpi/vmgenid.c
> >> @@ -0,0 +1,237 @@
> >> +/*
> >> + *  Virtual Machine Generation ID Device
> >> + *
> >> + *  Copyright (C) 2017 Skyport Systems.
> >> + *
> >> + *  Author: Ben Warren <ben@skyportsystems.com>
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> >> + * See the COPYING file in the top-level directory.
> >> + *
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qmp-commands.h"
> >> +#include "hw/acpi/acpi.h"
> >> +#include "hw/acpi/aml-build.h"
> >> +#include "hw/acpi/vmgenid.h"
> >> +#include "hw/nvram/fw_cfg.h"
> >> +#include "sysemu/sysemu.h"
> >> +
> >> +void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
> >> +                        BIOSLinker *linker)
> >> +{
> >> +    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
> >> +    uint32_t vgia_offset;
> >> +    QemuUUID guid_le;
> >> +
> >> +    /* Fill in the GUID values.  These need to be converted to little-endian
> >> +     * first, since that's what the guest expects
> >> +     */
> >> +    g_array_set_size(guid, VMGENID_FW_CFG_SIZE);
> >> +    memcpy(&guid_le.data, &vms->guid.data, sizeof(vms->guid.data));
> >> +    qemu_uuid_bswap(&guid_le);
> >> +    /* The GUID is written at a fixed offset into the fw_cfg file
> >> +     * in order to implement the "OVMF SDT Header probe suppressor"
> >> +     * see docs/specs/vmgenid.txt for more details
> >> +     */
> >> +    g_array_insert_vals(guid, VMGENID_GUID_OFFSET, guid_le.data,
> >> +                        ARRAY_SIZE(guid_le.data));  
> 
> Ben:
> 
> (1) The logic is sane here, but the initial sizing of the array is not
> correct. The initial size should be
> 
>   (VMGENID_FW_CFG_SIZE - ARRAY_SIZE(guid_le.data))
> 
> The reason for this is that g_array_insert_vals() really inserts (it
> doesn't overwrite) data, therefore it grows the array. From the GLib
> source code [glib/garray.c]:
> 
> ------------------
> GArray*
> g_array_insert_vals (GArray        *farray,
>                      guint          index_,
>                      gconstpointer  data,
>                      guint          len)
> {
>   GRealArray *array = (GRealArray*) farray;
> 
>   g_return_val_if_fail (array, NULL);
> 
>   g_array_maybe_expand (array, len);
> 
>   memmove (g_array_elt_pos (array, len + index_),
>            g_array_elt_pos (array, index_),
>            g_array_elt_len (array, array->len - index_));
> 
>   memcpy (g_array_elt_pos (array, index_), data, g_array_elt_len (array,
> len));
> 
>   array->len += len;
> 
>   g_array_zero_terminate (array);
> 
>   return farray;
> }
> ------------------
> 
> This is an extremely minor wart, because later on:
> 
> >> +
> >> +    /* Put this in a separate SSDT table */
> >> +    ssdt = init_aml_allocator();
> >> +
> >> +    /* Reserve space for header */
> >> +    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
> >> +
> >> +    /* Storage for the GUID address */
> >> +    vgia_offset = table_data->len +
> >> +        build_append_named_dword(ssdt->buf, "VGIA");
> >> +    scope = aml_scope("\\_SB");
> >> +    dev = aml_device("VGEN");
> >> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVGID")));
> >> +    aml_append(dev, aml_name_decl("_CID", aml_string("VM_Gen_Counter")));
> >> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VM_Gen_Counter")));
> >> +
> >> +    /* Simple status method to check that address is linked and non-zero */
> >> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >> +    addr = aml_local(0);
> >> +    aml_append(method, aml_store(aml_int(0xf), addr));
> >> +    if_ctx = aml_if(aml_equal(aml_name("VGIA"), aml_int(0)));
> >> +    aml_append(if_ctx, aml_store(aml_int(0), addr));
> >> +    aml_append(method, if_ctx);
> >> +    aml_append(method, aml_return(addr));
> >> +    aml_append(dev, method);
> >> +
> >> +    /* the ADDR method returns two 32-bit words representing the lower and
> >> +     * upper halves * of the physical address of the fw_cfg blob
> >> +     * (holding the GUID)
> >> +     */
> >> +    method = aml_method("ADDR", 0, AML_NOTSERIALIZED);
> >> +
> >> +    addr = aml_local(0);
> >> +    aml_append(method, aml_store(aml_package(2), addr));
> >> +
> >> +    aml_append(method, aml_store(aml_add(aml_name("VGIA"),
> >> +                                         aml_int(VMGENID_GUID_OFFSET), NULL),
> >> +                                 aml_index(addr, aml_int(0))));
> >> +    aml_append(method, aml_store(aml_int(0), aml_index(addr, aml_int(1))));  
> > Just curious,
> > so suggested in v5 simple declaration style 
> > 
> > Package(2) {
> >   ADD(VGIA, VMGENID_GUID_OFFSET),
> >   0
> > }
> > 
> > wasn't working for you?
> >   
> >> +    aml_append(method, aml_return(addr));
> >> +
> >> +    aml_append(dev, method);
> >> +    aml_append(scope, dev);
> >> +    aml_append(ssdt, scope);
> >> +
> >> +    /* attach an ACPI notify */
> >> +    method = aml_method("\\_GPE._E05", 0, AML_NOTSERIALIZED);
> >> +    aml_append(method, aml_notify(aml_name("\\_SB.VGEN"), aml_int(0x80)));
> >> +    aml_append(ssdt, method);
> >> +
> >> +    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> >> +
> >> +    /* Allocate guest memory for the Data fw_cfg blob */
> >> +    bios_linker_loader_alloc(linker, VMGENID_GUID_FW_CFG_FILE, guid, 4096,
> >> +                             false /* page boundary, high memory */);
> >> +
> >> +    /* Patch address of GUID fw_cfg blob into the ADDR fw_cfg blob
> >> +     * so QEMU can write the GUID there.  The address is expected to be
> >> +     * < 4GB, but write 64 bits anyway.
> >> +     */
> >> +    bios_linker_loader_write_pointer(linker,
> >> +        VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
> >> +        VMGENID_GUID_FW_CFG_FILE);
> >> +
> >> +    /* Patch address of GUID fw_cfg blob into the AML so OSPM can retrieve
> >> +     * and read it.  Note that while we provide storage for 64 bits, only
> >> +     * the least-signficant 32 get patched into AML.
> >> +     */
> >> +    bios_linker_loader_add_pointer(linker,
> >> +        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint32_t),
> >> +        VMGENID_GUID_FW_CFG_FILE, 0);
> >> +
> >> +    build_header(linker, table_data,
> >> +        (void *)(table_data->data + table_data->len - ssdt->buf->len),
> >> +        "SSDT", ssdt->buf->len, 1, NULL, "VMGENID");
> >> +    free_aml_allocator();
> >> +}
> >> +
> >> +void vmgenid_add_fw_cfg(VmGenIdState *vms, FWCfgState *s, GArray *guid)
> >> +{
> >> +    /* Create a read-only fw_cfg file for GUID */
> >> +    fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, guid->data,
> >> +                    VMGENID_FW_CFG_SIZE);  
> 
> we do expose the correct size to the guest (and the underlying QEMU-side
> allocation is larger, not smaller than that, so it is safe).
> 
> So I guess I could call this an "innocent leak of 16 bytes" -- it's up
> to you if you want to fix it. (I really don't want to obsess about this
> at v6, I could have noticed the exact same in v5!)
> 
> >> +    /* Create a read-write fw_cfg file for Address */
> >> +    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, NULL,
> >> +                             vms->vmgenid_addr_le,
> >> +                             ARRAY_SIZE(vms->vmgenid_addr_le), false);
> >> +}
> >> +
> >> +static void vmgenid_update_guest(VmGenIdState *vms)
> >> +{
> >> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
> >> +    uint32_t vmgenid_addr;
> >> +    QemuUUID guid_le;
> >> +
> >> +    if (obj) {
> >> +        /* Write the GUID to guest memory */
> >> +        memcpy(&vmgenid_addr, vms->vmgenid_addr_le, sizeof(vmgenid_addr));
> >> +        vmgenid_addr = le32_to_cpu(vmgenid_addr);
> >> +        /* A zero value in vmgenid_addr means that BIOS has not yet written
> >> +         * the address
> >> +         */
> >> +        if (vmgenid_addr) {
> >> +            /* QemuUUID has the first three words as big-endian, and expect
> >> +             * that any GUIDs passed in will always be BE.  The guest,
> >> +             * however, will expect the fields to be little-endian.
> >> +             * Perform a byte swap immediately before writing.
> >> +             */
> >> +            memcpy(&guid_le.data, &vms->guid.data, sizeof(vms->guid.data));  
> > potential stack corruption if guid_le and vms->guid types ever diverge
> > why not just do
> >   guid_le.data = guid.data  
> 
> Igor:
> 
> That would be an array assignment, and wouldn't work:
> 
> typedef struct {
>     union {
>         unsigned char data[16];
>         struct {
>             /* Generated in BE endian, can be swapped with
> qemu_uuid_bswap. */
>             uint32_t time_low;
>             uint16_t time_mid;
>             uint16_t time_high_and_version;
>             uint8_t  clock_seq_and_reserved;
>             uint8_t  clock_seq_low;
>             uint8_t  node[6];
>         } fields;
>     };
> } QemuUUID;
> 
> I think the code is safe: both the local variable "guid_le" and
> "VmGenIdState.guid" are declared with type "QemuUUID".
> 
> I agree that a style improvement would be
> 
>   guid_le = vms->guid;
it looks much better than memcpy()

> 
> since structure assignment is okay.
> 
> Personally I feel neutrally about this.
> 
> >   
> >> +            qemu_uuid_bswap(&guid_le);
> >> +            /* The GUID is written at a fixed offset into the fw_cfg file
> >> +             * in order to implement the "OVMF SDT Header probe suppressor"
> >> +             * see docs/specs/vmgenid.txt for more details
> >> +             */
> >> +            cpu_physical_memory_write(vmgenid_addr + VMGENID_GUID_OFFSET,
> >> +                                      guid_le.data, sizeof(guid_le.data));
> >> +            /* Send _GPE.E05 event */
> >> +            acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
> >> +        }
> >> +    }
> >> +}
> >> +
> >> +static void vmgenid_set_guid(Object *obj, const char *value, Error **errp)
> >> +{
> >> +    VmGenIdState *vms = VMGENID(obj);
> >> +
> >> +    if (!strcmp(value, "auto")) {
> >> +        qemu_uuid_generate(&vms->guid);
> >> +    } else if (qemu_uuid_parse(value, &vms->guid) < 0) {
> >> +        error_setg(errp, "'%s. %s': Failed to parse GUID string: %s",
> >> +                   object_get_typename(OBJECT(vms)), VMGENID_GUID, value);
> >> +        return;
> >> +    }
> >> +
> >> +    vmgenid_update_guest(vms);
> >> +}
> >> +
> >> +/* After restoring an image, we need to update the guest memory and notify
> >> + * it of a potential change to VM Generation ID
> >> + */
> >> +static int vmgenid_post_load(void *opaque, int version_id)
> >> +{
> >> +    VmGenIdState *vms = opaque;
> >> +    vmgenid_update_guest(vms);
> >> +    return 0;
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_vmgenid = {
> >> +    .name = "vmgenid",
> >> +    .version_id = 1,
> >> +    .minimum_version_id = 1,
> >> +    .post_load = vmgenid_post_load,
> >> +    .fields = (VMStateField[]) {
> >> +        VMSTATE_UINT8_ARRAY(vmgenid_addr_le, VmGenIdState, sizeof(uint64_t)),
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >> +static void vmgenid_initfn(Object *obj)
> >> +{
> >> +    object_property_add_str(obj, VMGENID_GUID, NULL, vmgenid_set_guid, NULL);  
> > missing:
> >   object_property_set_description()
> > or even better use class properties here:
> > 
> > object_class_property_add_str()/object_class_property_set_description()
> >   
> >> +}
> >> +
> >> +static void vmgenid_handle_reset(void *opaque)
> >> +{
> >> +    VmGenIdState *vms = VMGENID(opaque);
> >> +    /* Clear the guest-allocated GUID address when the VM resets */
> >> +    memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le));
> >> +}
> >> +
> >> +static void vmgenid_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    VmGenIdState *vms = VMGENID(dev);
> >> +    qemu_register_reset(vmgenid_handle_reset, vms);
> >> +}
> >> +
> >> +static void vmgenid_device_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc = DEVICE_CLASS(klass);
> >> +
> >> +    dc->vmsd = &vmstate_vmgenid;
> >> +    dc->realize = vmgenid_realize;  
> > it needs:
> > 
> > dc->hotpluggable = false;
> >   
> >> +}
> >> +
> >> +static const TypeInfo vmgenid_device_info = {
> >> +    .name          = VMGENID_DEVICE,
> >> +    .parent        = TYPE_DEVICE,
> >> +    .instance_size = sizeof(VmGenIdState),
> >> +    .instance_init = vmgenid_initfn,
> >> +    .class_init    = vmgenid_device_class_init,
> >> +};
> >> +
> >> +static void vmgenid_register_types(void)
> >> +{
> >> +    type_register_static(&vmgenid_device_info);
> >> +}
> >> +
> >> +type_init(vmgenid_register_types)
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 1c928ab..db04cf5 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -42,6 +42,7 @@
> >>  #include "hw/acpi/memory_hotplug.h"
> >>  #include "sysemu/tpm.h"
> >>  #include "hw/acpi/tpm.h"
> >> +#include "hw/acpi/vmgenid.h"
> >>  #include "sysemu/tpm_backend.h"
> >>  #include "hw/timer/mc146818rtc_regs.h"
> >>  #include "sysemu/numa.h"
> >> @@ -2610,6 +2611,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >>      size_t aml_len = 0;
> >>      GArray *tables_blob = tables->table_data;
> >>      AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
> >> +    Object *vmgenid_dev;
> >>  
> >>      acpi_get_pm_info(&pm);
> >>      acpi_get_misc_info(&misc);
> >> @@ -2653,6 +2655,13 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >>      acpi_add_table(table_offsets, tables_blob);
> >>      build_madt(tables_blob, tables->linker, pcms);
> >>  
> >> +    vmgenid_dev = find_vmgenid_dev();
> >> +    if (vmgenid_dev) {
> >> +        acpi_add_table(table_offsets, tables_blob);
> >> +        vmgenid_build_acpi(VMGENID(vmgenid_dev), tables_blob,
> >> +                           tables->vmgenid, tables->linker);
> >> +    }
> >> +
> >>      if (misc.has_hpet) {
> >>          acpi_add_table(table_offsets, tables_blob);
> >>          build_hpet(tables_blob, tables->linker);
> >> @@ -2823,6 +2832,7 @@ void acpi_setup(void)
> >>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> >>      AcpiBuildTables tables;
> >>      AcpiBuildState *build_state;
> >> +    Object *vmgenid_dev;
> >>  
> >>      if (!pcms->fw_cfg) {
> >>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
> >> @@ -2859,6 +2869,12 @@ void acpi_setup(void)
> >>      fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
> >>                      tables.tcpalog->data, acpi_data_len(tables.tcpalog));
> >>  
> >> +    vmgenid_dev = find_vmgenid_dev();
> >> +    if (vmgenid_dev) {
> >> +        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
> >> +                           tables.vmgenid);
> >> +    }
> >> +
> >>      if (!pcmc->rsdp_in_ram) {
> >>          /*
> >>           * Keep for compatibility with old machine types.
> >> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> >> index 71d3c48..3c2e4e9 100644
> >> --- a/include/hw/acpi/acpi_dev_interface.h
> >> +++ b/include/hw/acpi/acpi_dev_interface.h
> >> @@ -11,6 +11,7 @@ typedef enum {
> >>      ACPI_CPU_HOTPLUG_STATUS = 4,
> >>      ACPI_MEMORY_HOTPLUG_STATUS = 8,
> >>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
> >> +    ACPI_VMGENID_CHANGE_STATUS = 32,
> >>  } AcpiEventStatusBits;
> >>  
> >>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> >> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> >> new file mode 100644
> >> index 0000000..db7fa0e
> >> --- /dev/null
> >> +++ b/include/hw/acpi/vmgenid.h
> >> @@ -0,0 +1,35 @@
> >> +#ifndef ACPI_VMGENID_H
> >> +#define ACPI_VMGENID_H
> >> +
> >> +#include "hw/acpi/bios-linker-loader.h"
> >> +#include "hw/qdev.h"
> >> +#include "qemu/uuid.h"
> >> +
> >> +#define VMGENID_DEVICE           "vmgenid"
> >> +#define VMGENID_GUID             "guid"
> >> +#define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid_guid"
> >> +#define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
> >> +
> >> +#define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
> >> +#define VMGENID_GUID_OFFSET      40   /* allow space for
> >> +                                       * OVMF SDT Header Probe Supressor
> >> +                                       */
> >> +
> >> +#define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), VMGENID_DEVICE)
> >> +
> >> +typedef struct VmGenIdState {
> >> +    DeviceClass parent_obj;
> >> +    QemuUUID guid;                /* The 128-bit GUID seen by the guest */
> >> +    uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-endian) */
> >> +} VmGenIdState;
> >> +
> >> +static inline Object *find_vmgenid_dev(void)
> >> +{
> >> +    return object_resolve_path_type("", VMGENID_DEVICE, NULL);  
> > What will happen if CLI would be:
> >   -device vmgenid -device vmgenid
> > As I understand, it should be exclusive single instance device,
> > and there is nothing to prevent second instance of it.  
> 
> Igor:
> 
> I agree with your observation, but I don't think it's a show-stopper
> (not at this point anyway). I think it is similar to the case that I
> raised earlier, about <= 2.6 machine types that have no DMA support in
> fw_cfg, hence WRITE_POINTER cannot work on them.
> 
> Both of these cases (i.e., too early machine types, and multiple vmgenid
> devices) come from "pathologic" command lines, and don't prevent the
> intended use of the device (assuming a correct command line). So, I
> think it should be safe to address these questions later, in a followup
> series (for 2.10, likely).
it is fixes so we can merge them in 2.9 during soft-freeze

> 
> Ben:
> 
> Summary:
> - the sizing wart that I mentioned under (1) is innocent; it doesn't
> deserve a repost on its own. If you do a v7, I suggest that you fix it
> up, but I don't insist.
> 
> - Personally I'm fine with the rest. I see that Igor made some comments,
> but I feel that a good chunk of those could have been made for v5 just
> the same (example: dc->hotpluggable, object_property_set_description() /
> class properties). I wouldn't like to delay this series any longer.
> Those improvements can be added later, IMO -- but please do work out
> with Igor whether he really wants a v7 for those.
since it's minor fixes not influencing other patches within series
there is not need to repost whole series,
just this fixed up patch as replay to this thread tagged as v7
or a patch on top, I'm fine with either way.

> 
> I'm fine with the patch as-is, and I'm also fine with it if Igor's
> comments are addressed:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> If you do other changes though, please drop my R-b.
> 
> ... I'd like to look at the rest of this series a little, and then I'll
> try to come back with test results (with OVMF).
> 
> Thanks!
> Laszlo
> 
> > 
> >   
> >> +}
> >> +
> >> +void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
> >> +                        BIOSLinker *linker);
> >> +void vmgenid_add_fw_cfg(VmGenIdState *vms, FWCfgState *s, GArray *guid);
> >> +
> >> +#endif  
> >   
> 
