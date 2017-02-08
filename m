Received: from eggs.gnu.org ([2001:4830:134:3::10]:57565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cbYiF-0002Wl-6n
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cbYiB-0004gj-1t
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:19:35 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:37666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cbYiA-0004gM-M1
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:19:30 -0500
Received: by mail-it0-x22d.google.com with SMTP id r185so112357196ita.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 12:19:27 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <6E23D270-9A6C-4C3F-9092-AA67873AD534@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_789E9632-EC20-4C38-BFE2-3C4AD87E191C";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 8 Feb 2017 12:19:24 -0800
In-Reply-To: <20170207144822.70b7a014@nial.brq.redhat.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<20170207144822.70b7a014@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com


--Apple-Mail=_789E9632-EC20-4C38-BFE2-3C4AD87E191C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks for reviewing Igor.

> On Feb 7, 2017, at 5:48 AM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Sun,  5 Feb 2017 01:12:00 -0800
> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
>=20
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> This implements the VM Generation ID feature by passing a 128-bit
>> GUID to the guest via a fw_cfg blob.
>> Any time the GUID changes, an ACPI notify event is sent to the guest
>>=20
>> The user interface is a simple device with one parameter:
>> - guid (string, must be "auto" or in UUID format
>>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> ---
>> default-configs/i386-softmmu.mak     |   1 +
>> default-configs/x86_64-softmmu.mak   |   1 +
>> hw/acpi/Makefile.objs                |   1 +
>> hw/acpi/vmgenid.c                    | 206 =
+++++++++++++++++++++++++++++++++++
>> hw/i386/acpi-build.c                 |  10 ++
>> include/hw/acpi/acpi_dev_interface.h |   1 +
>> include/hw/acpi/vmgenid.h            |  37 +++++++
>> 7 files changed, 257 insertions(+)
>> create mode 100644 hw/acpi/vmgenid.c
>> create mode 100644 include/hw/acpi/vmgenid.h
>>=20
>> diff --git a/default-configs/i386-softmmu.mak =
b/default-configs/i386-softmmu.mak
>> index 384cefb..1a43542 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -58,3 +58,4 @@ CONFIG_I82801B11=3Dy
>> CONFIG_SMBIOS=3Dy
>> CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>> CONFIG_PXB=3Dy
>> +CONFIG_ACPI_VMGENID=3Dy
>> diff --git a/default-configs/x86_64-softmmu.mak =
b/default-configs/x86_64-softmmu.mak
>> index 491a191..aee8b08 100644
>> --- a/default-configs/x86_64-softmmu.mak
>> +++ b/default-configs/x86_64-softmmu.mak
>> @@ -58,3 +58,4 @@ CONFIG_I82801B11=3Dy
>> CONFIG_SMBIOS=3Dy
>> CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>> CONFIG_PXB=3Dy
>> +CONFIG_ACPI_VMGENID=3Dy
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 6acf798..11c35bc 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -5,6 +5,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D =
cpu_hotplug.o
>> common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
>> common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
>> common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
>> +common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
>> common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
>>=20
>> common-obj-y +=3D acpi_interface.o
>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>> new file mode 100644
>> index 0000000..6c9ecfd
>> --- /dev/null
>> +++ b/hw/acpi/vmgenid.c
>> @@ -0,0 +1,206 @@
>> +/*
>> + *  Virtual Machine Generation ID Device
>> + *
>> + *  Copyright (C) 2017 Skyport Systems.
>> + *
>> + *  Author: Ben Warren <ben@skyportsystems.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qmp-commands.h"
>> +#include "hw/acpi/acpi.h"
>> +#include "hw/acpi/aml-build.h"
>> +#include "hw/acpi/vmgenid.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +#include "sysemu/sysemu.h"
>> +
>> +void vmgenid_build_acpi(GArray *table_data, GArray *guid, BIOSLinker =
*linker)
>> +{
>> +    Object *obj;
>> +    VmGenIdState *s;
>> +    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
>> +    uint32_t vgia_offset;
>> +
>> +    obj =3D find_vmgenid_dev(NULL);
> get obj from caller
>=20
>> +    assert(obj);
>> +    s =3D VMGENID(obj);
>> +
>> +    /* Fill in the GUID values */
>> +    if (guid->len !=3D VMGENID_FW_CFG_SIZE) {
>> +        g_array_set_size(guid, VMGENID_FW_CFG_SIZE);
> does it have to be conditional?
>=20
No, I guess not.
>> +    }
>> +    g_array_insert_vals(guid, VMGENID_GUID_OFFSET, s->guid.data, =
16);
>> +
>> +    /* Put this in a separate SSDT table */
>> +    ssdt =3D init_aml_allocator();
>> +
>> +    /* Reserve space for header */
>> +    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
>> +
>> +    /* Storage for the GUID address */
>> +    vgia_offset =3D table_data->len +
>> +        build_append_named_dword(ssdt->buf, "VGIA");
>> +    scope =3D aml_scope("\\_SB");
>> +    dev =3D aml_device("VGEN");
>> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVGID")));
>> +    aml_append(dev, aml_name_decl("_CID", =
aml_string("VM_Gen_Counter")));
>> +    aml_append(dev, aml_name_decl("_DDN", =
aml_string("VM_Gen_Counter")));
>> +
>> +    /* Simple status method to check that address is linked and =
non-zero */
>> +    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
>> +    addr =3D aml_local(0);
>> +    aml_append(method, aml_store(aml_int(0xf), addr));
>> +    if_ctx =3D aml_if(aml_equal(aml_name("VGIA"), aml_int(0)));
>> +    aml_append(if_ctx, aml_store(aml_int(0), addr));
>> +    aml_append(method, if_ctx);
>> +    aml_append(method, aml_return(addr));
>> +    aml_append(dev, method);
>> +
>> +    /* the ADDR method returns two 32-bit words representing the =
lower and
>> +     * upper halves * of the physical address of the fw_cfg blob
>> +     * (holding the GUID) */
>> +    method =3D aml_method("ADDR", 0, AML_NOTSERIALIZED);
>> +
>> +    addr =3D aml_local(0);
>> +    aml_append(method, aml_store(aml_package(2), addr));
>> +
>> +    aml_append(method, aml_store(aml_add(aml_name("VGIA"),
>> +                                         =
aml_int(VMGENID_GUID_OFFSET), NULL),
>> +                                 aml_index(addr, aml_int(0))));
>> +    aml_append(method, aml_store(aml_int(0), aml_index(addr, =
aml_int(1))));
> I'd rather have "VGIA" patched wit address to GUID and not the blob =
start,
> see next comment about how.
>=20
> Also usage aml_index() looks a bit confusing, how about:
>=20
> pkg =3D aml_local(0)
> aml_store(aml_package(2), pkg)
> aml_append(pkg, aml_name("VGIA"))
> aml_append(pkg, aml_int(0))
>=20
I=E2=80=99ll try that, it does look simpler.  I thought I tried this and =
couldn=E2=80=99t get it to work, but will try again.
>> +    aml_append(method, aml_return(addr));
>> +
>> +    aml_append(dev, method);
>> +    aml_append(scope, dev);
>> +    aml_append(ssdt, scope);
>> +
>> +    /* attach an ACPI notify */
>> +    method =3D aml_method("\\_GPE._E05", 0, AML_NOTSERIALIZED);
>> +    aml_append(method, aml_notify(aml_name("\\_SB.VGEN"), =
aml_int(0x80)));
>> +    aml_append(ssdt, method);
>> +
>> +    g_array_append_vals(table_data, ssdt->buf->data, =
ssdt->buf->len);
>> +
>> +    /* Allocate guest memory for the Data fw_cfg blob */
>> +    bios_linker_loader_alloc(linker, VMGENID_GUID_FW_CFG_FILE, guid, =
4096,
>> +                             false /* page boundary, high memory =
*/);
> does it guaranties that blob will be allocated in cacheable page?
> (SeaBIOS/OVMF)
>=20
>> +
>> +    /* Patch address of GUID fw_cfg blob into the ADDR fw_cfg blob =
*/
>> +    bios_linker_loader_add_pointer(linker,
>> +        VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint32_t),
>> +        VMGENID_GUID_FW_CFG_FILE, 0, true);
>> +
>> +    /* Patch address of GUID fw_cfg blob into the AML */
>> +    bios_linker_loader_add_pointer(linker,
>> +        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint32_t),
>> +        VMGENID_GUID_FW_CFG_FILE, 0, false);
> see @src_offset argument description,
> putting VMGENID_GUID_OFFSET would make patched place point directly to =
GUID
>=20
>> +
>> +    build_header(linker, table_data,
>> +        (void *)(table_data->data + table_data->len - =
ssdt->buf->len),
>> +        "SSDT", ssdt->buf->len, 1, NULL, "VMGENID");
>> +    free_aml_allocator();
>> +}
>> +
>> +void vmgenid_add_fw_cfg(FWCfgState *s, GArray *guid)
>> +{
>> +    Object *obj =3D find_vmgenid_dev(NULL);
>> +    assert(obj);
>> +    VmGenIdState *vms =3D VMGENID(obj);
>> +
>> +    /* Create a read-only fw_cfg file for GUID */
>> +    fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, guid->data,
>> +                    VMGENID_FW_CFG_SIZE);
>> +    /* Create a read-write fw_cfg file for Address */
>> +    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, =
NULL,
>> +                             vms->vgia_le, sizeof(uint32_t), false);
>> +}
>> +
>> +static void vmgenid_update_guest(VmGenIdState *s)
>> +{
>> +    Object *obj =3D object_resolve_path_type("", =
TYPE_ACPI_DEVICE_IF, NULL);
>> +    uint32_t vgia;
>> +
>> +    if (obj) {
>> +        /* Write the GUID to guest memory */
>> +        memcpy(&vgia, s->vgia_le, sizeof(vgia));
>> +        vgia =3D le32_to_cpu(vgia);
>> +        if (vgia) {
>> +            cpu_physical_memory_write(vgia + VMGENID_GUID_OFFSET,
>> +                                      s->guid.data, =
sizeof(s->guid.data));
>> +            /* Send _GPE.E05 event */
>> +            acpi_send_event(DEVICE(obj), =
ACPI_VMGENID_CHANGE_STATUS);
>> +        }
>> +    }
>> +}
>> +
>> +static void vmgenid_set_guid(Object *obj, const char *value, Error =
**errp)
>> +{
>> +    VmGenIdState *s =3D VMGENID(obj);
>> +
>> +    if (!strncmp(value, "auto", 4)) {
>> +        qemu_uuid_generate(&s->guid);
>> +    } else if (qemu_uuid_parse(value, &s->guid) < 0) {
>> +        error_setg(errp, "'%s. %s': Failed to parse GUID string: =
%s",
>> +                   object_get_typename(OBJECT(s)), VMGENID_GUID, =
value);
>> +        return;
>> +    }
>> +    /* QemuUUID has the first three words as big-endian, and expect =
that any
>> +     * GUIDs passed in will always be BE.  The guest, however will =
expect
>> +     * the fields to be little-endian, so store that way internally. =
 Make
>> +     * sure to swap back whenever reporting via monitor */
>> +    qemu_uuid_bswap(&s->guid);
>> +
>> +    /* Send the ACPI notify */
>> +    vmgenid_update_guest(s);
>> +}
>> +
>> +/* After restoring an image, we need to update the guest memory and =
notify
>> + * it of a potential change to VM Generation ID */
>> +static int vmgenid_post_load(void *opaque, int version_id)
>> +{
>> +    VmGenIdState *s =3D opaque;
>> +    vmgenid_update_guest(s);
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_vmgenid =3D {
>> +    .name =3D "vmgenid",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .post_load =3D vmgenid_post_load,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_UINT8_ARRAY(vgia_le, VmGenIdState, =
sizeof(uint32_t)),
> file with address could be memory region and migrated automatically,
> ex: rsdp_mr + acpi_add_rom_blob + acpi_ram_update
>=20
I don=E2=80=99t follow.  Can you please elaborate?
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +static void vmgenid_initfn(Object *obj)
>> +{
>> +    object_property_add_str(obj, VMGENID_GUID, NULL, =
vmgenid_set_guid, NULL);
>> +}
>> +
>> +static void vmgenid_device_class_init(ObjectClass *klass, void =
*data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->vmsd =3D &vmstate_vmgenid;
>> +}
>> +
>> +static const TypeInfo vmgenid_device_info =3D {
>> +    .name          =3D VMGENID_DEVICE,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(VmGenIdState),
>> +    .instance_init =3D vmgenid_initfn,
>> +    .class_init    =3D vmgenid_device_class_init,
>> +};
>> +
>> +static void vmgenid_register_types(void)
>> +{
>> +    type_register_static(&vmgenid_device_info);
>> +}
>> +
>> +type_init(vmgenid_register_types)
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 78a1d84..4c40f76 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -42,6 +42,7 @@
>> #include "hw/acpi/memory_hotplug.h"
>> #include "sysemu/tpm.h"
>> #include "hw/acpi/tpm.h"
>> +#include "hw/acpi/vmgenid.h"
>> #include "sysemu/tpm_backend.h"
>> #include "hw/timer/mc146818rtc_regs.h"
>> #include "sysemu/numa.h"
>> @@ -2653,6 +2654,11 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>>     acpi_add_table(table_offsets, tables_blob);
>>     build_madt(tables_blob, tables->linker, pcms);
>>=20
>> +    if (find_vmgenid_dev(NULL)) {
>> +        acpi_add_table(table_offsets, tables_blob);
>> +        vmgenid_build_acpi(tables_blob, tables->vmgenid, =
tables->linker);
> pass find_vmgenid_dev(NULL) result as an argument to =
vmgenid_build_acpi()
> so it won't have to do lookup again.
>=20
OK
>> +    }
>> +
>>     if (misc.has_hpet) {
>>         acpi_add_table(table_offsets, tables_blob);
>>         build_hpet(tables_blob, tables->linker);
>> @@ -2859,6 +2865,10 @@ void acpi_setup(void)
>>     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>>                     tables.tcpalog->data, =
acpi_data_len(tables.tcpalog));
>>=20
>> +    if (find_vmgenid_dev(NULL)) {
> it's second lookup, cache result of the 1st call and reuse it here
>=20
OK
>> +        vmgenid_add_fw_cfg(pcms->fw_cfg, tables.vmgenid);
>> +    }
>> +
>>     if (!pcmc->rsdp_in_ram) {
>>         /*
>>          * Keep for compatibility with old machine types.
>> diff --git a/include/hw/acpi/acpi_dev_interface.h =
b/include/hw/acpi/acpi_dev_interface.h
>> index 71d3c48..3c2e4e9 100644
>> --- a/include/hw/acpi/acpi_dev_interface.h
>> +++ b/include/hw/acpi/acpi_dev_interface.h
>> @@ -11,6 +11,7 @@ typedef enum {
>>     ACPI_CPU_HOTPLUG_STATUS =3D 4,
>>     ACPI_MEMORY_HOTPLUG_STATUS =3D 8,
>>     ACPI_NVDIMM_HOTPLUG_STATUS =3D 16,
>> +    ACPI_VMGENID_CHANGE_STATUS =3D 32,
>> } AcpiEventStatusBits;
>>=20
>> #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
>> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
>> new file mode 100644
>> index 0000000..b60437a
>> --- /dev/null
>> +++ b/include/hw/acpi/vmgenid.h
>> @@ -0,0 +1,37 @@
>> +#ifndef ACPI_VMGENID_H
>> +#define ACPI_VMGENID_H
>> +
>> +#include "hw/acpi/bios-linker-loader.h"
>> +#include "hw/sysbus.h"
>> +#include "qemu/uuid.h"
>> +
>> +#define VMGENID_DEVICE           "vmgenid"
>> +#define VMGENID_GUID             "guid"
>> +#define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid"
>> +#define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
>> +
>> +#define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
>> +#define VMGENID_GUID_OFFSET      40   /* allow space for
>> +                                       * OVMF SDT Header Probe =
Supressor */
>> +
>> +void vmgenid_add_fw_cfg(FWCfgState *s, GArray *guid);
>> +void vmgenid_build_acpi(GArray *table_data, GArray *guid, BIOSLinker =
*linker);
>> +
>> +#define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), =
VMGENID_DEVICE)
>> +
>> +typedef struct VmGenIdState {
>> +    SysBusDevice parent_obj;
> Could it work with just plain Device parent?
> If it works then you can drop patch:
>  [PATCH v5 08/10] PC: Support dynamic sysbus on pc_i440fx
>=20
Huh, I was sure I tried that originally and couldn=E2=80=99t make it =
work, but it turns out it does.  Definitely better.
>> +    QemuUUID guid;
>> +    uint8_t vgia_le[4];
>> +} VmGenIdState;
>> +
>> +static Object *find_vmgenid_dev(Error **errp)
>> +{
>> +    Object *obj =3D object_resolve_path_type("", VMGENID_DEVICE, =
NULL);
>> +    if (!obj && errp) {
> all callers pass NULL as errp, I'd just drop errp altogether.
>=20
OK
>> +        error_setg(errp, "%s is not found", VMGENID_DEVICE);
>> +    }
>> +    return obj;
>> +}
>> +
>> +#endif


--Apple-Mail=_789E9632-EC20-4C38-BFE2-3C4AD87E191C
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
CQUxDxcNMTcwMjA4MjAxOTI1WjAjBgkqhkiG9w0BCQQxFgQUkfVhCMw1tL5DP4DO+dxUZIurzLgw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEATd75X5Z2uK3M7T7KjtFLzB4d2SUXwbqYM6lRIGSwnacIV5Mq1BmkaoEH
qmfDn/mWb6VVlBbX+7EKaxEBOchrL4XSa5h12kcqo7t+hJ92Q4ezK9zyVmS50jWRb+8bOUFk6Uep
sYVNltQ2T5Ftj4x23RbuHc974KMxdPBXO1uLEPs45LIQ1mDm2XHBJyJX0s5/mkcZtewhLPdgbRCC
f2TJHCwFHHJBRdLEOLDy7wE62Ei1HBjD/ZVojvxPTdjqK/qKbSXYF7LwC2eCrYsSb2vFtX7l8IbJ
At7xpfqT9Mrn45XvDVZDKsShDgGmBFCIjTRTWvqObpb4O+ZV0qooBBKR2QAAAAAAAA==
--Apple-Mail=_789E9632-EC20-4C38-BFE2-3C4AD87E191C--
