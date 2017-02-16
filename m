Received: from eggs.gnu.org ([2001:4830:134:3::10]:47922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFJo-00050o-NK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFJk-0007Bl-Jq
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:13:28 -0500
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceFJk-0007BM-79
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:13:24 -0500
Received: by mail-it0-x234.google.com with SMTP id 203so89115858ith.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 22:13:24 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <C00AEC57-4D67-483F-9A05-9CAC464FB4FD@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_54A7666A-96CB-4771-B8EA-BF24D9120CC0";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 15 Feb 2017 22:13:21 -0800
In-Reply-To: <6d3caba0-c747-457d-0fee-b02f7f09e50a@redhat.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<111628dff0803a21b75cc390858f0c288decee22.1487139038.git.ben@skyportsystems.com>
	<20170215131903.2394b096@nial.brq.redhat.com>
	<6d3caba0-c747-457d-0fee-b02f7f09e50a@redhat.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com


--Apple-Mail=_54A7666A-96CB-4771-B8EA-BF24D9120CC0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 15, 2017, at 7:24 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/15/17 13:19, Igor Mammedov wrote:
>> On Tue, 14 Feb 2017 22:15:46 -0800
>> ben@skyportsystems.com wrote:
>>=20
>>> From: Ben Warren <ben@skyportsystems.com>
>>>=20
>>> This implements the VM Generation ID feature by passing a 128-bit
>>> GUID to the guest via a fw_cfg blob.
>>> Any time the GUID changes, an ACPI notify event is sent to the guest
>>>=20
>>> The user interface is a simple device with one parameter:
>>> - guid (string, must be "auto" or in UUID format
>>>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>>=20
>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>> ---
>>> default-configs/i386-softmmu.mak     |   1 +
>>> default-configs/x86_64-softmmu.mak   |   1 +
>>> hw/acpi/Makefile.objs                |   1 +
>>> hw/acpi/vmgenid.c                    | 237 =
+++++++++++++++++++++++++++++++++++
>>> hw/i386/acpi-build.c                 |  16 +++
>>> include/hw/acpi/acpi_dev_interface.h |   1 +
>>> include/hw/acpi/vmgenid.h            |  35 ++++++
>>> 7 files changed, 292 insertions(+)
>>> create mode 100644 hw/acpi/vmgenid.c
>>> create mode 100644 include/hw/acpi/vmgenid.h
>>>=20
>>> diff --git a/default-configs/i386-softmmu.mak =
b/default-configs/i386-softmmu.mak
>>> index 48b07a4..029e952 100644
>>> --- a/default-configs/i386-softmmu.mak
>>> +++ b/default-configs/i386-softmmu.mak
>>> @@ -59,3 +59,4 @@ CONFIG_I82801B11=3Dy
>>> CONFIG_SMBIOS=3Dy
>>> CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>>> CONFIG_PXB=3Dy
>>> +CONFIG_ACPI_VMGENID=3Dy
>>> diff --git a/default-configs/x86_64-softmmu.mak =
b/default-configs/x86_64-softmmu.mak
>>> index fd96345..d1d7432 100644
>>> --- a/default-configs/x86_64-softmmu.mak
>>> +++ b/default-configs/x86_64-softmmu.mak
>>> @@ -59,3 +59,4 @@ CONFIG_I82801B11=3Dy
>>> CONFIG_SMBIOS=3Dy
>>> CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>>> CONFIG_PXB=3Dy
>>> +CONFIG_ACPI_VMGENID=3Dy
>>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>>> index 6acf798..11c35bc 100644
>>> --- a/hw/acpi/Makefile.objs
>>> +++ b/hw/acpi/Makefile.objs
>>> @@ -5,6 +5,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D =
cpu_hotplug.o
>>> common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
>>> common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
>>> common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
>>> +common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
>>> common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
>>>=20
>>> common-obj-y +=3D acpi_interface.o
>>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>>> new file mode 100644
>>> index 0000000..b1b7b32
>>> --- /dev/null
>>> +++ b/hw/acpi/vmgenid.c
>>> @@ -0,0 +1,237 @@
>>> +/*
>>> + *  Virtual Machine Generation ID Device
>>> + *
>>> + *  Copyright (C) 2017 Skyport Systems.
>>> + *
>>> + *  Author: Ben Warren <ben@skyportsystems.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>>> + * See the COPYING file in the top-level directory.
>>> + *
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qmp-commands.h"
>>> +#include "hw/acpi/acpi.h"
>>> +#include "hw/acpi/aml-build.h"
>>> +#include "hw/acpi/vmgenid.h"
>>> +#include "hw/nvram/fw_cfg.h"
>>> +#include "sysemu/sysemu.h"
>>> +
>>> +void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, =
GArray *guid,
>>> +                        BIOSLinker *linker)
>>> +{
>>> +    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
>>> +    uint32_t vgia_offset;
>>> +    QemuUUID guid_le;
>>> +
>>> +    /* Fill in the GUID values.  These need to be converted to =
little-endian
>>> +     * first, since that's what the guest expects
>>> +     */
>>> +    g_array_set_size(guid, VMGENID_FW_CFG_SIZE);
>>> +    memcpy(&guid_le.data, &vms->guid.data, sizeof(vms->guid.data));
>>> +    qemu_uuid_bswap(&guid_le);
>>> +    /* The GUID is written at a fixed offset into the fw_cfg file
>>> +     * in order to implement the "OVMF SDT Header probe suppressor"
>>> +     * see docs/specs/vmgenid.txt for more details
>>> +     */
>>> +    g_array_insert_vals(guid, VMGENID_GUID_OFFSET, guid_le.data,
>>> +                        ARRAY_SIZE(guid_le.data));
>=20
> Ben:
>=20
> (1) The logic is sane here, but the initial sizing of the array is not
> correct. The initial size should be
>=20
>  (VMGENID_FW_CFG_SIZE - ARRAY_SIZE(guid_le.data))
>=20
> The reason for this is that g_array_insert_vals() really inserts (it
> doesn't overwrite) data, therefore it grows the array. =46rom the GLib
> source code [glib/garray.c]:
>=20
> ------------------
> GArray*
> g_array_insert_vals (GArray        *farray,
>                     guint          index_,
>                     gconstpointer  data,
>                     guint          len)
> {
>  GRealArray *array =3D (GRealArray*) farray;
>=20
>  g_return_val_if_fail (array, NULL);
>=20
>  g_array_maybe_expand (array, len);
>=20
>  memmove (g_array_elt_pos (array, len + index_),
>           g_array_elt_pos (array, index_),
>           g_array_elt_len (array, array->len - index_));
>=20
>  memcpy (g_array_elt_pos (array, index_), data, g_array_elt_len =
(array,
> len));
>=20
>  array->len +=3D len;
>=20
>  g_array_zero_terminate (array);
>=20
>  return farray;
> }
> ------------------
>=20
> This is an extremely minor wart, because later on:
>=20
Fixed in v7.  Thanks for pointing this out.
>>> +
>>> +    /* Put this in a separate SSDT table */
>>> +    ssdt =3D init_aml_allocator();
>>> +
>>> +    /* Reserve space for header */
>>> +    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
>>> +
>>> +    /* Storage for the GUID address */
>>> +    vgia_offset =3D table_data->len +
>>> +        build_append_named_dword(ssdt->buf, "VGIA");
>>> +    scope =3D aml_scope("\\_SB");
>>> +    dev =3D aml_device("VGEN");
>>> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVGID")));
>>> +    aml_append(dev, aml_name_decl("_CID", =
aml_string("VM_Gen_Counter")));
>>> +    aml_append(dev, aml_name_decl("_DDN", =
aml_string("VM_Gen_Counter")));
>>> +
>>> +    /* Simple status method to check that address is linked and =
non-zero */
>>> +    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
>>> +    addr =3D aml_local(0);
>>> +    aml_append(method, aml_store(aml_int(0xf), addr));
>>> +    if_ctx =3D aml_if(aml_equal(aml_name("VGIA"), aml_int(0)));
>>> +    aml_append(if_ctx, aml_store(aml_int(0), addr));
>>> +    aml_append(method, if_ctx);
>>> +    aml_append(method, aml_return(addr));
>>> +    aml_append(dev, method);
>>> +
>>> +    /* the ADDR method returns two 32-bit words representing the =
lower and
>>> +     * upper halves * of the physical address of the fw_cfg blob
>>> +     * (holding the GUID)
>>> +     */
>>> +    method =3D aml_method("ADDR", 0, AML_NOTSERIALIZED);
>>> +
>>> +    addr =3D aml_local(0);
>>> +    aml_append(method, aml_store(aml_package(2), addr));
>>> +
>>> +    aml_append(method, aml_store(aml_add(aml_name("VGIA"),
>>> +                                         =
aml_int(VMGENID_GUID_OFFSET), NULL),
>>> +                                 aml_index(addr, aml_int(0))));
>>> +    aml_append(method, aml_store(aml_int(0), aml_index(addr, =
aml_int(1))));
>> Just curious,
>> so suggested in v5 simple declaration style=20
>>=20
>> Package(2) {
>>  ADD(VGIA, VMGENID_GUID_OFFSET),
>>  0
>> }
>>=20
>> wasn't working for you?
>>=20
>>> +    aml_append(method, aml_return(addr));
>>> +
>>> +    aml_append(dev, method);
>>> +    aml_append(scope, dev);
>>> +    aml_append(ssdt, scope);
>>> +
>>> +    /* attach an ACPI notify */
>>> +    method =3D aml_method("\\_GPE._E05", 0, AML_NOTSERIALIZED);
>>> +    aml_append(method, aml_notify(aml_name("\\_SB.VGEN"), =
aml_int(0x80)));
>>> +    aml_append(ssdt, method);
>>> +
>>> +    g_array_append_vals(table_data, ssdt->buf->data, =
ssdt->buf->len);
>>> +
>>> +    /* Allocate guest memory for the Data fw_cfg blob */
>>> +    bios_linker_loader_alloc(linker, VMGENID_GUID_FW_CFG_FILE, =
guid, 4096,
>>> +                             false /* page boundary, high memory =
*/);
>>> +
>>> +    /* Patch address of GUID fw_cfg blob into the ADDR fw_cfg blob
>>> +     * so QEMU can write the GUID there.  The address is expected =
to be
>>> +     * < 4GB, but write 64 bits anyway.
>>> +     */
>>> +    bios_linker_loader_write_pointer(linker,
>>> +        VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
>>> +        VMGENID_GUID_FW_CFG_FILE);
>>> +
>>> +    /* Patch address of GUID fw_cfg blob into the AML so OSPM can =
retrieve
>>> +     * and read it.  Note that while we provide storage for 64 =
bits, only
>>> +     * the least-signficant 32 get patched into AML.
>>> +     */
>>> +    bios_linker_loader_add_pointer(linker,
>>> +        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint32_t),
>>> +        VMGENID_GUID_FW_CFG_FILE, 0);
>>> +
>>> +    build_header(linker, table_data,
>>> +        (void *)(table_data->data + table_data->len - =
ssdt->buf->len),
>>> +        "SSDT", ssdt->buf->len, 1, NULL, "VMGENID");
>>> +    free_aml_allocator();
>>> +}
>>> +
>>> +void vmgenid_add_fw_cfg(VmGenIdState *vms, FWCfgState *s, GArray =
*guid)
>>> +{
>>> +    /* Create a read-only fw_cfg file for GUID */
>>> +    fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, guid->data,
>>> +                    VMGENID_FW_CFG_SIZE);
>=20
> we do expose the correct size to the guest (and the underlying =
QEMU-side
> allocation is larger, not smaller than that, so it is safe).
>=20
> So I guess I could call this an "innocent leak of 16 bytes" -- it's up
> to you if you want to fix it. (I really don't want to obsess about =
this
> at v6, I could have noticed the exact same in v5!)
>=20
>>> +    /* Create a read-write fw_cfg file for Address */
>>> +    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, =
NULL,
>>> +                             vms->vmgenid_addr_le,
>>> +                             ARRAY_SIZE(vms->vmgenid_addr_le), =
false);
>>> +}
>>> +
>>> +static void vmgenid_update_guest(VmGenIdState *vms)
>>> +{
>>> +    Object *obj =3D object_resolve_path_type("", =
TYPE_ACPI_DEVICE_IF, NULL);
>>> +    uint32_t vmgenid_addr;
>>> +    QemuUUID guid_le;
>>> +
>>> +    if (obj) {
>>> +        /* Write the GUID to guest memory */
>>> +        memcpy(&vmgenid_addr, vms->vmgenid_addr_le, =
sizeof(vmgenid_addr));
>>> +        vmgenid_addr =3D le32_to_cpu(vmgenid_addr);
>>> +        /* A zero value in vmgenid_addr means that BIOS has not yet =
written
>>> +         * the address
>>> +         */
>>> +        if (vmgenid_addr) {
>>> +            /* QemuUUID has the first three words as big-endian, =
and expect
>>> +             * that any GUIDs passed in will always be BE.  The =
guest,
>>> +             * however, will expect the fields to be little-endian.
>>> +             * Perform a byte swap immediately before writing.
>>> +             */
>>> +            memcpy(&guid_le.data, &vms->guid.data, =
sizeof(vms->guid.data));
>> potential stack corruption if guid_le and vms->guid types ever =
diverge
>> why not just do
>>  guid_le.data =3D guid.data
>=20
> Igor:
>=20
> That would be an array assignment, and wouldn't work:
>=20
> typedef struct {
>    union {
>        unsigned char data[16];
>        struct {
>            /* Generated in BE endian, can be swapped with
> qemu_uuid_bswap. */
>            uint32_t time_low;
>            uint16_t time_mid;
>            uint16_t time_high_and_version;
>            uint8_t  clock_seq_and_reserved;
>            uint8_t  clock_seq_low;
>            uint8_t  node[6];
>        } fields;
>    };
> } QemuUUID;
>=20
> I think the code is safe: both the local variable "guid_le" and
> "VmGenIdState.guid" are declared with type "QemuUUID".
>=20
> I agree that a style improvement would be
>=20
>  guid_le =3D vms->guid;
>=20
Changed to this in v7
> since structure assignment is okay.
>=20
> Personally I feel neutrally about this.
>=20
>>=20
>>> +            qemu_uuid_bswap(&guid_le);
>>> +            /* The GUID is written at a fixed offset into the =
fw_cfg file
>>> +             * in order to implement the "OVMF SDT Header probe =
suppressor"
>>> +             * see docs/specs/vmgenid.txt for more details
>>> +             */
>>> +            cpu_physical_memory_write(vmgenid_addr + =
VMGENID_GUID_OFFSET,
>>> +                                      guid_le.data, =
sizeof(guid_le.data));
>>> +            /* Send _GPE.E05 event */
>>> +            acpi_send_event(DEVICE(obj), =
ACPI_VMGENID_CHANGE_STATUS);
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static void vmgenid_set_guid(Object *obj, const char *value, Error =
**errp)
>>> +{
>>> +    VmGenIdState *vms =3D VMGENID(obj);
>>> +
>>> +    if (!strcmp(value, "auto")) {
>>> +        qemu_uuid_generate(&vms->guid);
>>> +    } else if (qemu_uuid_parse(value, &vms->guid) < 0) {
>>> +        error_setg(errp, "'%s. %s': Failed to parse GUID string: =
%s",
>>> +                   object_get_typename(OBJECT(vms)), VMGENID_GUID, =
value);
>>> +        return;
>>> +    }
>>> +
>>> +    vmgenid_update_guest(vms);
>>> +}
>>> +
>>> +/* After restoring an image, we need to update the guest memory and =
notify
>>> + * it of a potential change to VM Generation ID
>>> + */
>>> +static int vmgenid_post_load(void *opaque, int version_id)
>>> +{
>>> +    VmGenIdState *vms =3D opaque;
>>> +    vmgenid_update_guest(vms);
>>> +    return 0;
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_vmgenid =3D {
>>> +    .name =3D "vmgenid",
>>> +    .version_id =3D 1,
>>> +    .minimum_version_id =3D 1,
>>> +    .post_load =3D vmgenid_post_load,
>>> +    .fields =3D (VMStateField[]) {
>>> +        VMSTATE_UINT8_ARRAY(vmgenid_addr_le, VmGenIdState, =
sizeof(uint64_t)),
>>> +        VMSTATE_END_OF_LIST()
>>> +    },
>>> +};
>>> +
>>> +static void vmgenid_initfn(Object *obj)
>>> +{
>>> +    object_property_add_str(obj, VMGENID_GUID, NULL, =
vmgenid_set_guid, NULL);
>> missing:
>>  object_property_set_description()
>> or even better use class properties here:
>>=20
>> =
object_class_property_add_str()/object_class_property_set_description()
>>=20
>>> +}
>>> +
>>> +static void vmgenid_handle_reset(void *opaque)
>>> +{
>>> +    VmGenIdState *vms =3D VMGENID(opaque);
>>> +    /* Clear the guest-allocated GUID address when the VM resets */
>>> +    memset(vms->vmgenid_addr_le, 0, =
ARRAY_SIZE(vms->vmgenid_addr_le));
>>> +}
>>> +
>>> +static void vmgenid_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    VmGenIdState *vms =3D VMGENID(dev);
>>> +    qemu_register_reset(vmgenid_handle_reset, vms);
>>> +}
>>> +
>>> +static void vmgenid_device_class_init(ObjectClass *klass, void =
*data)
>>> +{
>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +
>>> +    dc->vmsd =3D &vmstate_vmgenid;
>>> +    dc->realize =3D vmgenid_realize;
>> it needs:
>>=20
>> dc->hotpluggable =3D false;
>>=20
>>> +}
>>> +
>>> +static const TypeInfo vmgenid_device_info =3D {
>>> +    .name          =3D VMGENID_DEVICE,
>>> +    .parent        =3D TYPE_DEVICE,
>>> +    .instance_size =3D sizeof(VmGenIdState),
>>> +    .instance_init =3D vmgenid_initfn,
>>> +    .class_init    =3D vmgenid_device_class_init,
>>> +};
>>> +
>>> +static void vmgenid_register_types(void)
>>> +{
>>> +    type_register_static(&vmgenid_device_info);
>>> +}
>>> +
>>> +type_init(vmgenid_register_types)
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index 1c928ab..db04cf5 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -42,6 +42,7 @@
>>> #include "hw/acpi/memory_hotplug.h"
>>> #include "sysemu/tpm.h"
>>> #include "hw/acpi/tpm.h"
>>> +#include "hw/acpi/vmgenid.h"
>>> #include "sysemu/tpm_backend.h"
>>> #include "hw/timer/mc146818rtc_regs.h"
>>> #include "sysemu/numa.h"
>>> @@ -2610,6 +2611,7 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>>>     size_t aml_len =3D 0;
>>>     GArray *tables_blob =3D tables->table_data;
>>>     AcpiSlicOem slic_oem =3D { .id =3D NULL, .table_id =3D NULL };
>>> +    Object *vmgenid_dev;
>>>=20
>>>     acpi_get_pm_info(&pm);
>>>     acpi_get_misc_info(&misc);
>>> @@ -2653,6 +2655,13 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>>>     acpi_add_table(table_offsets, tables_blob);
>>>     build_madt(tables_blob, tables->linker, pcms);
>>>=20
>>> +    vmgenid_dev =3D find_vmgenid_dev();
>>> +    if (vmgenid_dev) {
>>> +        acpi_add_table(table_offsets, tables_blob);
>>> +        vmgenid_build_acpi(VMGENID(vmgenid_dev), tables_blob,
>>> +                           tables->vmgenid, tables->linker);
>>> +    }
>>> +
>>>     if (misc.has_hpet) {
>>>         acpi_add_table(table_offsets, tables_blob);
>>>         build_hpet(tables_blob, tables->linker);
>>> @@ -2823,6 +2832,7 @@ void acpi_setup(void)
>>>     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>>>     AcpiBuildTables tables;
>>>     AcpiBuildState *build_state;
>>> +    Object *vmgenid_dev;
>>>=20
>>>     if (!pcms->fw_cfg) {
>>>         ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>>> @@ -2859,6 +2869,12 @@ void acpi_setup(void)
>>>     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>>>                     tables.tcpalog->data, =
acpi_data_len(tables.tcpalog));
>>>=20
>>> +    vmgenid_dev =3D find_vmgenid_dev();
>>> +    if (vmgenid_dev) {
>>> +        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
>>> +                           tables.vmgenid);
>>> +    }
>>> +
>>>     if (!pcmc->rsdp_in_ram) {
>>>         /*
>>>          * Keep for compatibility with old machine types.
>>> diff --git a/include/hw/acpi/acpi_dev_interface.h =
b/include/hw/acpi/acpi_dev_interface.h
>>> index 71d3c48..3c2e4e9 100644
>>> --- a/include/hw/acpi/acpi_dev_interface.h
>>> +++ b/include/hw/acpi/acpi_dev_interface.h
>>> @@ -11,6 +11,7 @@ typedef enum {
>>>     ACPI_CPU_HOTPLUG_STATUS =3D 4,
>>>     ACPI_MEMORY_HOTPLUG_STATUS =3D 8,
>>>     ACPI_NVDIMM_HOTPLUG_STATUS =3D 16,
>>> +    ACPI_VMGENID_CHANGE_STATUS =3D 32,
>>> } AcpiEventStatusBits;
>>>=20
>>> #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
>>> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
>>> new file mode 100644
>>> index 0000000..db7fa0e
>>> --- /dev/null
>>> +++ b/include/hw/acpi/vmgenid.h
>>> @@ -0,0 +1,35 @@
>>> +#ifndef ACPI_VMGENID_H
>>> +#define ACPI_VMGENID_H
>>> +
>>> +#include "hw/acpi/bios-linker-loader.h"
>>> +#include "hw/qdev.h"
>>> +#include "qemu/uuid.h"
>>> +
>>> +#define VMGENID_DEVICE           "vmgenid"
>>> +#define VMGENID_GUID             "guid"
>>> +#define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid_guid"
>>> +#define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
>>> +
>>> +#define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
>>> +#define VMGENID_GUID_OFFSET      40   /* allow space for
>>> +                                       * OVMF SDT Header Probe =
Supressor
>>> +                                       */
>>> +
>>> +#define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), =
VMGENID_DEVICE)
>>> +
>>> +typedef struct VmGenIdState {
>>> +    DeviceClass parent_obj;
>>> +    QemuUUID guid;                /* The 128-bit GUID seen by the =
guest */
>>> +    uint8_t vmgenid_addr_le[8];   /* Address of the GUID =
(little-endian) */
>>> +} VmGenIdState;
>>> +
>>> +static inline Object *find_vmgenid_dev(void)
>>> +{
>>> +    return object_resolve_path_type("", VMGENID_DEVICE, NULL);
>> What will happen if CLI would be:
>>  -device vmgenid -device vmgenid
>> As I understand, it should be exclusive single instance device,
>> and there is nothing to prevent second instance of it.
>=20
> Igor:
>=20
> I agree with your observation, but I don't think it's a show-stopper
> (not at this point anyway). I think it is similar to the case that I
> raised earlier, about <=3D 2.6 machine types that have no DMA support =
in
> fw_cfg, hence WRITE_POINTER cannot work on them.
>=20
> Both of these cases (i.e., too early machine types, and multiple =
vmgenid
> devices) come from "pathologic" command lines, and don't prevent the
> intended use of the device (assuming a correct command line). So, I
> think it should be safe to address these questions later, in a =
followup
> series (for 2.10, likely).
>=20
> Ben:
>=20
> Summary:
> - the sizing wart that I mentioned under (1) is innocent; it doesn't
> deserve a repost on its own. If you do a v7, I suggest that you fix it
> up, but I don't insist.
>=20
> - Personally I'm fine with the rest. I see that Igor made some =
comments,
> but I feel that a good chunk of those could have been made for v5 just
> the same (example: dc->hotpluggable, object_property_set_description() =
/
> class properties). I wouldn't like to delay this series any longer.
> Those improvements can be added later, IMO -- but please do work out
> with Igor whether he really wants a v7 for those.
>=20
> I'm fine with the patch as-is, and I'm also fine with it if Igor's
> comments are addressed:
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com =
<mailto:lersek@redhat.com>>
>=20
> If you do other changes though, please drop my R-b.
>=20
Thanks so much for all the reviews.  I=E2=80=99ve left off your R-b =
because I ended up using the =E2=80=98src_offset=E2=80=99 argument for =
write_pointer().  Other than that, all recommended changes are made.
> ... I'd like to look at the rest of this series a little, and then =
I'll
> try to come back with test results (with OVMF).
>=20
> Thanks!
> Laszlo
>=20
>>=20
>>=20
>>> +}
>>> +
>>> +void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, =
GArray *guid,
>>> +                        BIOSLinker *linker);
>>> +void vmgenid_add_fw_cfg(VmGenIdState *vms, FWCfgState *s, GArray =
*guid);
>>> +
>>> +#endif


--Apple-Mail=_54A7666A-96CB-4771-B8EA-BF24D9120CC0
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ+zCCBK8w
ggOXoAMCAQICEQDgI8sVEoNTia1hbnpUZ2shMA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYTAlNF
MRQwEgYDVQQKEwtBZGRUcnVzdCBBQjEmMCQGA1UECxMdQWRkVHJ1c3QgRXh0ZXJuYWwgVFRQIE5l
dHdvcmsxIjAgBgNVBAMTGUFkZFRydXN0IEV4dGVybmFsIENBIFJvb3QwHhcNMTQxMjIyMDAwMDAw
WhcNMjAwNTMwMTA0ODM4WjCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAibEN2npTGU5wUh28VqYGJre4SeCW
51Gr8fBaE0kVo7SMG2C8elFCp3mMpCLfF2FOkdV2IwoU00oCf7YdCYBupQQ92bq7Fv6hh6kuQ1JD
FnyvMlDIpk9a6QjYz5MlnHuI6DBk5qT4VoD9KiQUMxeZrETlaYujRgZLwjPU6UCfBrCxrJNAubUI
kzqcKlOjENs9IGE8VQOO2U52JQIhKfqjfHF2T+7hX4Hp+1SA28N7NVK3hN4iPSwwLTF/Wb1SN7Az
aS1D6/rWpfGXd2dRjNnuJ+u8pQc4doykqTj/34z1A6xJvsr3c5k6DzKrnJU6Ez0ORjpXdGFQvsZA
P8vk4p+iIQIDAQABo4IBFzCCARMwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTLVBowHQYD
VR0OBBYEFJJha4LhoqCqT+xn8cKj97SAAMHsMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
AQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDUGCCsGAQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNl
cnRydXN0LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAGypurFXBOquIxdjtzVXzqmthK8AJECOZD8Vm
am+x9bS1d14PAmEA330F/hKzpICAAPz7HVtqcgIKQbwFusFY1SbC6tVNhPv+gpjPWBvjImOcUvi7
BTarfVil3qs7Y+Xa1XPv7OD7e+Kj//BCI5zKto1NPuRLGAOyqC3U2LtCS5BphRDbpjc06HvgARCl
nMo6x59PiDRuimXQGoq7qdzKyjbR9PzCZCk1r9axp3ER0gNDsY8+muyeMlP0dpLKhjQHuSzK5hxK
2JkNwYbikJL7WkJqIyEQ6WXH9dW7fuqMhSACYurROgcsWcWZM/I4ieW26RZ6H3kU9koQGib6fIr7
mzCCBUQwggQsoAMCAQICEQCWOeMVlifzA+PvGfHjMeybMA0GCSqGSIb3DQEBCwUAMIGbMQswCQYD
VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRow
GAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYwNTE5MDAwMDAwWhcNMTcw
NTE5MjM1OTU5WjAnMSUwIwYJKoZIhvcNAQkBFhZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAryjnKj/3VRzbNXiWAp7RAZSzUCOzDG6WJ2ybuDWP
A7uDl48iX2v3ulbcZq8G0sL1nwGvBdSrmd5X3Qzirx0ti0Qe0mlAd22PEOL/xR5ChLDhNI6i43cM
R1qM1JNtuC5Dz8h2TfYbF/VuKkA1YVuXNguSP8Z1DQXptE1m3yS0gk9LLdDkqq7Vi/zfSmD1NYHN
gEGvtux/3lMp8pHgQiZo8PxKH2Y4zem0AiWtZ9fKZqYWRIhECJ+etvpGvh4dNIj8vdo/ig3uSwLv
ePX7rFz3C5WHOyKjl4VGHNOA5IRZjabp4bdAEIiMPU7lfWt0o4nCRtM/G/6FvFinR6PIHSma1wID
AQABo4IB9DCCAfAwHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFJv6
uT+NCtbUQ0MHZLryEY65oKgbMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAhBgNVHREEGjAYgRZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMA0GCSqG
SIb3DQEBCwUAA4IBAQAwVeCMNqTr20+cqsHnSK2AtzxKZyVG9y51wB88lPnRGHe2m+qKGdPgAh/7
iDzEEXsy4sDwHVHVq4kLHW9lX7CvRTxCtmOAtsty5ePhJjh3CX+nsK2HKpi043E6azad6L64DNVN
dMZFwUrUu8dYjOp48TPpIhW13Sbu2t/SOZK4G8EZAaZPX8Dg34tyHRUvM/B/eaJuUgdM5qY2IU+F
7U2K4hBHkhJMJgQ7TyVe8GhdBMaztY4GHqhWP5cCgZBdC9QII8E5jqX7//FbBRB0zVHRVeBZO32H
TvapSOG8ZYd0n5l5j3rBQnLfHWsnQ07rL2+w8W9BBPSZBbciPuwOe3ksMYIDxjCCA8ICAQEwgbEw
gZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1Nh
bGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1
NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z
8eMx7JswCQYFKw4DAhoFAKCCAekwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTcwMjE2MDYxMzIxWjAjBgkqhkiG9w0BCQQxFgQUu5fhUVE61+DNUrhmYx06XKH4Y3ow
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEApR7628Ahn7caA1GWmJOy9rSbew8i3H40uXimHhoQUmudr2OAwcfG2Q2z
tN0g5bROaC5OdKMMGNe76J0Lao+0slOs0D25OUIXzE4Z+dzhGgnB5C0xKjhWpogHYQyzAA9PKHIc
o/tL4RTAH4xXWzIv85u1W56FjcKAT3JcMudt9PtDd4qSTbG4jIJnUP+WZ15MAOK26WWUa4xr3cB9
FI33CKfKtB42k0/UiKXhJKHEriKI37GwRqNWEB5Z+XkyvX5u2VsnOE5xyoLTTeDmkEIUaIoQej+E
J0yW/bQKSMWyPbnCZkv7nSJaZ4JzdB2DIFJCGRaPl8xONcR8xm7pR23SfgAAAAAAAA==
--Apple-Mail=_54A7666A-96CB-4771-B8EA-BF24D9120CC0--
