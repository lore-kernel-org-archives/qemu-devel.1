Received: from eggs.gnu.org ([2001:4830:134:3::10]:33996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTe23-000715-TI
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 19:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTe20-0006Wh-Kj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 19:23:19 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:34085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cTe20-0006Uv-9n
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 19:23:16 -0500
Received: by mail-pf0-x236.google.com with SMTP id e4so27337334pfg.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 16:23:14 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <98C44148-63D0-4CFD-8ED8-6F72EADD02C3@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_C01CD2A8-2D40-4372-8891-87D2D19BBEFF";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Tue, 17 Jan 2017 16:23:10 -0800
In-Reply-To: <20170117140058.166de8c2@nial.brq.redhat.com>
References: <cover.1484593565.git.ben@skyportsystems.com>
	<ac2ea4262e8e64d010b152493ce3a3e1cc85e225.1484594095.git.ben@skyportsystems.com>
	<20170117140058.166de8c2@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] ACPI: Add Virtual Machine
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


--Apple-Mail=_C01CD2A8-2D40-4372-8891-87D2D19BBEFF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Igor,
> On Jan 17, 2017, at 5:00 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>=20
> On Mon, 16 Jan 2017 11:20:55 -0800
> ben@skyportsystems.com wrote:
>=20
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> This implements the VM Generation ID feature by passing a 128-bit
>> GUID to the guest via a fw_cfg blob.
>> Any time the GUID changes, and ACPI notify event is sent to the guest
>>=20
>> The user interface is a simple device with one parameters:
>> - guid (string, must be in UUID format
>>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> ---
>> default-configs/i386-softmmu.mak   |   1 +
>> default-configs/x86_64-softmmu.mak |   1 +
>> hw/acpi/Makefile.objs              |   1 +
>> hw/acpi/vmgenid.c                  | 207 =
+++++++++++++++++++++++++++++++++++++
>> hw/i386/acpi-build.c               |   5 +
>> hw/misc/Makefile.objs              |   1 +
>> include/hw/acpi/vmgenid.h          |  24 +++++
>> 7 files changed, 240 insertions(+)
>> create mode 100644 hw/acpi/vmgenid.c
>> create mode 100644 include/hw/acpi/vmgenid.h
>>=20
>> diff --git a/default-configs/i386-softmmu.mak =
b/default-configs/i386-softmmu.mak
>> index 0b51360..b2bccf6 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -56,3 +56,4 @@ CONFIG_IOH3420=3Dy
>> CONFIG_I82801B11=3Dy
>> CONFIG_SMBIOS=3Dy
>> CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>> +CONFIG_ACPI_VMGENID=3Dy
>> diff --git a/default-configs/x86_64-softmmu.mak =
b/default-configs/x86_64-softmmu.mak
>> index 7f89503..c6bd310 100644
>> --- a/default-configs/x86_64-softmmu.mak
>> +++ b/default-configs/x86_64-softmmu.mak
>> @@ -56,3 +56,4 @@ CONFIG_IOH3420=3Dy
>> CONFIG_I82801B11=3Dy
>> CONFIG_SMBIOS=3Dy
>> CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>> +CONFIG_ACPI_VMGENID=3Dy
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 489e63b..7dc95cd 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -4,6 +4,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D =
cpu_hotplug.o
>> common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o =
memory_hotplug_acpi_table.o
>> common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
>> common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
>> +common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
>> common-obj-$(CONFIG_ACPI) +=3D acpi_interface.o
>> common-obj-$(CONFIG_ACPI) +=3D bios-linker-loader.o
>> common-obj-$(CONFIG_ACPI) +=3D aml-build.o
>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>> new file mode 100644
>> index 0000000..596c8b7
>> --- /dev/null
>> +++ b/hw/acpi/vmgenid.c
>> @@ -0,0 +1,207 @@
>> +/*
>> + *  Virtual Machine Generation ID Device
>> + *
>> + *  Copyright (C) 2016 Skyport Systems.
>> + *
>> + *  Authors: Ben Warren <ben@skyportsystems.com>
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
>> +Object *find_vmgenid_dev(Error **errp)
>> +{
>> +    Object *obj =3D object_resolve_path_type("", VMGENID_DEVICE, =
NULL);
>> +    if (!obj) {
>> +        error_setg(errp, VMGENID_DEVICE " is not found");
>> +    }
>> +    return obj;
>> +}
>> +
>> +void vmgenid_build_acpi(GArray *table_offsets, GArray *table_data,
>> +        BIOSLinker *linker)
> wrong alignment, should be
>=20
>   f12345(arg1,
>          arg2);
>=20
OK
>> +{
>> +    Object *obj =3D find_vmgenid_dev(NULL);
>> +    if (!obj) {
>> +        return;
>> +    }
>> +    VmGenIdState *s =3D VMGENID(obj);
>> +
>> +    acpi_add_table(table_offsets, table_data);
>> +
>> +    GArray *guid =3D g_array_new(false, true, sizeof(s->guid.data));
>> +    g_array_append_val(guid, s->guid.data);
>> +
>> +    Aml *ssdt, *dev, *scope, *pkg, *method;
> Pls read CODING_STYLE and amend patch accordingly.
>=20
I assume you=E2=80=99re concerned about mixing variable declarations and =
code.  I=E2=80=99ll fix.
>> +
>> +    /* Put this in a separate SSDT table */
>> +    ssdt =3D init_aml_allocator();
>> +
>> +    /* Reserve space for header */
>> +    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
>> +
>> +    /* Storage for the GUID address */
>> +    uint32_t vgia_offset =3D table_data->len +
>> +        build_append_named_qword(ssdt->buf, "VGIA");
>> +    dev =3D aml_device("VGEN");
>> +    scope =3D aml_scope("\\_SB");
> swap scope and dev
>=20
OK
>> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVGID")));
>> +    aml_append(dev, aml_name_decl("_CID", =
aml_string("VM_Gen_Counter")));
>> +    aml_append(dev, aml_name_decl("_DDN", =
aml_string("VM_Gen_Counter")));
>> +
>> +    /* Simple status method to check that address is linked and =
non-zero */
>> +    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
>> +    Aml *if_ctx =3D aml_if(aml_equal(aml_name("VGIA"), aml_int(0)));
>> +    aml_append(if_ctx, aml_return(aml_int(0)));
>> +    aml_append(method, if_ctx);
>> +    Aml *else_ctx =3D aml_else();
>> +    aml_append(else_ctx, aml_return(aml_int(0xf)));
>> +    aml_append(method, else_ctx);
>> +    aml_append(dev, method);
> it would be cleaner if written like:
>=20
> local0 =3D 0xf
> if (vgia =3D=3D 0) {
>   local0 =3D 0
> }
> return local0
>=20
OK
>> +
>> +    /* the ADDR method returns two 32-bit words representing the =
lower and
>> +     * upper halves * of the physical address of the fw_cfg blob
>> +     * (holding the GUID) */
>> +    method =3D aml_method("ADDR", 0, AML_NOTSERIALIZED);
>> +
>> +    pkg =3D aml_package(2);
>> +    aml_append(pkg, aml_int(0));
>> +    aml_append(pkg, aml_int(0));
>> +
>> +    aml_append(method, aml_name_decl("LPKG", pkg));
> creating named object in method requires method be serialized, however
> there is no need to create named variable here, just use localX =
instead
>=20
> like:
>   addr =3D aml_local(0)
>   store(pkg, addr)
>=20
>> +    aml_append(method, aml_store(aml_and(aml_name("VGIA"),
>> +        aml_int(0xffffffff), NULL), aml_index(aml_name("LPKG"), =
aml_int(0))));
> then instead of aml_name("LPKG") it would become just =E2=80=98addr'
>=20
Great idea!
>> +    aml_append(method, aml_store(aml_shiftright(aml_name("VGIA"),
>> +        aml_int(32), NULL), aml_index(aml_name("LPKG"), =
aml_int(1))));
>> +    aml_append(method, aml_return(aml_name("LPKG")));
>> +
>> +    aml_append(dev, method);
>> +    aml_append(scope, dev);
>> +    aml_append(ssdt, scope);
>> +
>> +    /* attach an ACPI notify */
>> +    scope =3D aml_scope("_GPE");
>> +    method =3D aml_method("_E00", 0, AML_NOTSERIALIZED);
> I don't recall reason why _E00 isn't used but to be safe maybe next =
unused
> would be better (it seems to be _E05)
>=20
For some reason I thought E00 was spelled out in the VM Generation ID =
spec, but it isn=E2=80=99t.  I=E2=80=99ve reserved E05 for this
>> +    aml_append(method, aml_notify(aml_name("\\_SB.VGEN"), =
aml_int(0x80)));
>> +    aml_append(scope, method);
>> +    aml_append(ssdt, scope);
> you actually can skip scopes by providing full path in device/method =
name, like
>=20
>  aml_method("\\_GPE._E05", =E2=80=A6
>=20
Nice

>> +
>> +    /* copy AML table into ACPI tables blob and patch in fw_cfg blob =
*/
>> +    g_array_append_vals(table_data, ssdt->buf->data, =
ssdt->buf->len);
>> +    bios_linker_loader_alloc(linker, VMGENID_FW_CFG_FILE, guid, 0,
>> +                             false /* high memory */);
>> +    bios_linker_loader_add_pointer(linker,
>> +        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint64_t),
>> +        VMGENID_FW_CFG_FILE, 0);
>> +
>> +    build_header(linker, table_data,
>> +        (void *)(table_data->data + table_data->len - =
ssdt->buf->len),
>> +        "SSDT", ssdt->buf->len, 1, NULL, "VMGENID");
>> +    free_aml_allocator();
>> +}
>> +
>> +void vmgenid_add_fw_cfg(FWCfgState *s)
>> +{
>> +    Object *obj =3D find_vmgenid_dev(NULL);
>> +    if (!obj) {
>> +        return;
>> +    }
>> +    VmGenIdState *vms =3D VMGENID(obj);
>> +    fw_cfg_add_file(s, VMGENID_FW_CFG_FILE, vms->guid.data,
>> +        sizeof(vms->guid.data));
>> +}
>> +
>> +static void vmgenid_notify_guest(VmGenIdState *s)
>> +{
>> +    Object *obj =3D object_resolve_path_type("", =
TYPE_ACPI_DEVICE_IF, NULL);
>> +    if (obj) {
>> +        /* Send _GPE.E00 event */
>> +        acpi_send_event(DEVICE(obj), 1 << 0);
>> +    }
>> +}
>> +
>> +static void vmgenid_set_guid(Object *obj, const char *value, Error =
**errp)
>> +{
>> +    VmGenIdState *s =3D VMGENID(obj);
>> +
>> +    if (qemu_uuid_parse(value, &s->guid) < 0) {
>> +        error_setg(errp, "'%s." VMGENID_GUID
>> +                   "': Failed to parse GUID string: %s",
>> +                   object_get_typename(OBJECT(s)),
>> +                   value);
>> +        return;
>> +    }
> here should be code that would copy new GIUD to
> buffer allocated by firmware and then after that don't forget
> call memory_region_set_dirty() on it.
>=20
> Question is how you'd get address of it and I think that's where
> writable fwcfg files come in play.
> I'd prefer fwcfg_loader in firmware to write it back after buffer
> allocation is done as it's already has utilities for fw_cfg,
> but that probably would mean extending loader protocol to support
> new writeback command.
>=20
> PS, address one would get from guest should be migrated as well
>=20
OK, I=E2=80=99ll hack away at this part
>=20
>> +    vmgenid_notify_guest(s);
>> +}
>> +
>> +static void vmgenid_state_change(void *priv, int running, RunState =
state)
>> +{
>> +    VmGenIdState *s;
>> +
>> +    if (state !=3D RUN_STATE_RUNNING) {
>> +        return;
>> +    }
>> +    s =3D VMGENID((Object *)priv);
>> +    vmgenid_notify_guest(s);
>> +}
>> +
>> +static void vmgenid_initfn(Object *obj)
>> +{
>> +    object_property_add_str(obj, VMGENID_GUID, NULL, =
vmgenid_set_guid, NULL);
>> +    qemu_add_vm_change_state_handler(vmgenid_state_change, obj);
>> +}
>> +
>> +static const TypeInfo vmgenid_device_info =3D {
>> +    .name          =3D VMGENID_DEVICE,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(VmGenIdState),
>> +    .instance_init =3D vmgenid_initfn,
>> +};
>> +
>> +static void vmgenid_register_types(void)
>> +{
>> +    type_register_static(&vmgenid_device_info);
>> +}
>> +
>> +type_init(vmgenid_register_types)
>> +
>> +GuidInfo *qmp_query_vm_generation_id(Error **errp)
>> +{
>> +    GuidInfo *info;
>> +    VmGenIdState *vdev;
>> +    Object *obj =3D find_vmgenid_dev(errp);
>> +
>> +    if (!obj) {
>> +        return NULL;
>> +    }
>> +    vdev =3D VMGENID(obj);
>> +    info =3D g_malloc0(sizeof(*info));
>> +    info->guid =3D g_strdup_printf(UUID_FMT, vdev->guid.data[0],
>> +            vdev->guid.data[1], vdev->guid.data[2], =
vdev->guid.data[3],
>> +            vdev->guid.data[4], vdev->guid.data[5], =
vdev->guid.data[6],
>> +            vdev->guid.data[7], vdev->guid.data[8], =
vdev->guid.data[9],
>> +            vdev->guid.data[10], vdev->guid.data[11], =
vdev->guid.data[12],
>> +            vdev->guid.data[13], vdev->guid.data[14], =
vdev->guid.data[15]);
>=20
> perhaps qemu_uuid_unparse_strdup() could be used
>=20
Nice, I didn=E2=80=99t know about that.
>> +    return info;
>> +}
>> +
>> +void qmp_set_vm_generation_id(const char *guid, Error **errp)
>> +{
>> +    Object *obj =3D find_vmgenid_dev(errp);
>> +
>> +    if (!obj) {
>> +        return;
>> +    }
>> +
>> +    object_property_set_str(obj, guid, VMGENID_GUID, errp);
>> +    return;
>> +}
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 9708cdc..cde81b7 100644
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
>> @@ -2785,6 +2786,8 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>>     acpi_add_table(table_offsets, tables_blob);
>>     build_madt(tables_blob, tables->linker, pcms);
>>=20
> if (has_vmgenid()) {
>> +    vmgenid_build_acpi(table_offsets, tables_blob, tables->linker);
> }
>=20
> and remove similar check for called function
>=20
OK
>> +
>>     if (misc.has_hpet) {
>>         acpi_add_table(table_offsets, tables_blob);
>>         build_hpet(tables_blob, tables->linker);
>> @@ -2991,6 +2994,8 @@ void acpi_setup(void)
>>     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>>                     tables.tcpalog->data, =
acpi_data_len(tables.tcpalog));
>>=20
>> +    vmgenid_add_fw_cfg(pcms->fw_cfg);
> ditto
>=20
>> +
>>     if (!pcmc->rsdp_in_ram) {
>>         /*
>>          * Keep for compatibility with old machine types.
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 1a89615..ca0f1bb 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -53,3 +53,4 @@ obj-$(CONFIG_EDU) +=3D edu.o
>> obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
>> obj-$(CONFIG_AUX) +=3D auxbus.o
>> obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>> +obj-$(CONFIG_VMGENID) +=3D vmgenid.o
>> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
>> new file mode 100644
>> index 0000000..f8bdff2
>> --- /dev/null
>> +++ b/include/hw/acpi/vmgenid.h
>> @@ -0,0 +1,24 @@
>> +#ifndef ACPI_VMGENID_H
>> +#define ACPI_VMGENID_H
>> +
>> +#include "hw/acpi/bios-linker-loader.h"
>> +#include "hw/sysbus.h"
>> +#include "qemu/uuid.h"
>> +
>> +#define VMGENID_DEVICE           "vmgenid"
>> +#define VMGENID_GUID             "guid"
>> +#define VMGENID_FW_CFG_FILE      "etc/vmgenid"
>> +
>> +Object *find_vmgenid_dev(Error **errp);
>> +void vmgenid_add_fw_cfg(FWCfgState *s);
>> +void vmgenid_build_acpi(GArray *table_offsets, GArray *table_data,
>> +                       BIOSLinker *linker);
>> +
>> +#define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), =
VMGENID_DEVICE)
>> +
>> +typedef struct VmGenIdState {
>> +    SysBusDevice parent_obj;
>> +    QemuUUID guid;
>> +} VmGenIdState;
>> +
>> +#endif
>=20


--Apple-Mail=_C01CD2A8-2D40-4372-8891-87D2D19BBEFF
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
CQUxDxcNMTcwMTE4MDAyMzExWjAjBgkqhkiG9w0BCQQxFgQUoTEuL2ATOwcBmLe+tNGn80YIpt4w
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAeJqXMDUUIxHhIoEreYGEHpqgsLJsNl4NRzfJtbPz3ADeF4PMlNj+vCbM
1ylxP05WKb6nqNuXW1bVUW7gtKPIWMccJE9lvenL1oJ661vr+hf3OVuMyE8qJzsQVFyFiDmDl0yK
AgKAO6vvCLDKTVhMC1ZxQur6nfE348MyQy9IUIoxjaV2r/9ZdRnNT/6SrtFCjvTp/kEf63Qic6Cg
rsDsZH4jYOt6RSub+DefV8FWIYqliMFHOyO6NhHcSl6xNbSowy1ppXyY+jE1VkKhRSM+bf7wWvdK
iqWkZwQ4WdvrE+qODZmzuQgzIHAkUbKSOwZRMrSlT/XacHrFkCFPzygy+AAAAAAAAA==
--Apple-Mail=_C01CD2A8-2D40-4372-8891-87D2D19BBEFF--
