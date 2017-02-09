Received: from eggs.gnu.org ([2001:4830:134:3::10]:45308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cblWL-0007lU-Pp
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cblWC-0003oZ-4J
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:00:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cblVx-0003go-UZ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:59:59 -0500
Date: Thu, 9 Feb 2017 10:59:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170209105937.6870b4e1@Igors-MacBook-Pro.local>
In-Reply-To: <6E23D270-9A6C-4C3F-9092-AA67873AD534@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<20170207144822.70b7a014@nial.brq.redhat.com>
	<6E23D270-9A6C-4C3F-9092-AA67873AD534@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com

On Wed, 8 Feb 2017 12:19:24 -0800
Ben Warren <ben@skyportsystems.com> wrote:

> Thanks for reviewing Igor.
>=20
> > On Feb 7, 2017, at 5:48 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> >=20
> > On Sun,  5 Feb 2017 01:12:00 -0800
> > ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
> >=20
> >> From: Ben Warren <ben@skyportsystems.com>
> >>=20
> >> This implements the VM Generation ID feature by passing a 128-bit
> >> GUID to the guest via a fw_cfg blob.
> >> Any time the GUID changes, an ACPI notify event is sent to the guest
> >>=20
> >> The user interface is a simple device with one parameter:
> >> - guid (string, must be "auto" or in UUID format
> >>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
> >>=20
> >> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> >> ---
> >> default-configs/i386-softmmu.mak     |   1 +
> >> default-configs/x86_64-softmmu.mak   |   1 +
> >> hw/acpi/Makefile.objs                |   1 +
> >> hw/acpi/vmgenid.c                    | 206 +++++++++++++++++++++++++++=
++++++++
> >> hw/i386/acpi-build.c                 |  10 ++
> >> include/hw/acpi/acpi_dev_interface.h |   1 +
> >> include/hw/acpi/vmgenid.h            |  37 +++++++
> >> 7 files changed, 257 insertions(+)
> >> create mode 100644 hw/acpi/vmgenid.c
> >> create mode 100644 include/hw/acpi/vmgenid.h
> >>=20
> >> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-s=
oftmmu.mak
> >> index 384cefb..1a43542 100644
> >> --- a/default-configs/i386-softmmu.mak
> >> +++ b/default-configs/i386-softmmu.mak
> >> @@ -58,3 +58,4 @@ CONFIG_I82801B11=3Dy
> >> CONFIG_SMBIOS=3Dy
> >> CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
> >> CONFIG_PXB=3Dy
> >> +CONFIG_ACPI_VMGENID=3Dy
> >> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_=
64-softmmu.mak
> >> index 491a191..aee8b08 100644
> >> --- a/default-configs/x86_64-softmmu.mak
> >> +++ b/default-configs/x86_64-softmmu.mak
> >> @@ -58,3 +58,4 @@ CONFIG_I82801B11=3Dy
> >> CONFIG_SMBIOS=3Dy
> >> CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
> >> CONFIG_PXB=3Dy
> >> +CONFIG_ACPI_VMGENID=3Dy
> >> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> >> index 6acf798..11c35bc 100644
> >> --- a/hw/acpi/Makefile.objs
> >> +++ b/hw/acpi/Makefile.objs
> >> @@ -5,6 +5,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug=
.o
> >> common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
> >> common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
> >> common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
> >> +common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
> >> common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
> >>=20
> >> common-obj-y +=3D acpi_interface.o
> >> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> >> new file mode 100644
> >> index 0000000..6c9ecfd
> >> --- /dev/null
> >> +++ b/hw/acpi/vmgenid.c
> >> @@ -0,0 +1,206 @@
> >> +/*
> >> + *  Virtual Machine Generation ID Device
> >> + *
> >> + *  Copyright (C) 2017 Skyport Systems.
> >> + *
> >> + *  Author: Ben Warren <ben@skyportsystems.com>
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
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
> >> +void vmgenid_build_acpi(GArray *table_data, GArray *guid, BIOSLinker =
*linker)
> >> +{
> >> +    Object *obj;
> >> +    VmGenIdState *s;
> >> +    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
> >> +    uint32_t vgia_offset;
> >> +
> >> +    obj =3D find_vmgenid_dev(NULL);
> > get obj from caller
> >=20
> >> +    assert(obj);
> >> +    s =3D VMGENID(obj);
> >> +
> >> +    /* Fill in the GUID values */
> >> +    if (guid->len !=3D VMGENID_FW_CFG_SIZE) {
> >> +        g_array_set_size(guid, VMGENID_FW_CFG_SIZE);
> > does it have to be conditional?
> >=20
> No, I guess not.
> >> +    }
> >> +    g_array_insert_vals(guid, VMGENID_GUID_OFFSET, s->guid.data, 16);
> >> +
> >> +    /* Put this in a separate SSDT table */
> >> +    ssdt =3D init_aml_allocator();
> >> +
> >> +    /* Reserve space for header */
> >> +    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
> >> +
> >> +    /* Storage for the GUID address */
> >> +    vgia_offset =3D table_data->len +
> >> +        build_append_named_dword(ssdt->buf, "VGIA");
> >> +    scope =3D aml_scope("\\_SB");
> >> +    dev =3D aml_device("VGEN");
> >> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVGID")));
> >> +    aml_append(dev, aml_name_decl("_CID", aml_string("VM_Gen_Counter"=
)));
> >> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VM_Gen_Counter"=
)));
> >> +
> >> +    /* Simple status method to check that address is linked and non-z=
ero */
> >> +    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> >> +    addr =3D aml_local(0);
> >> +    aml_append(method, aml_store(aml_int(0xf), addr));
> >> +    if_ctx =3D aml_if(aml_equal(aml_name("VGIA"), aml_int(0)));
> >> +    aml_append(if_ctx, aml_store(aml_int(0), addr));
> >> +    aml_append(method, if_ctx);
> >> +    aml_append(method, aml_return(addr));
> >> +    aml_append(dev, method);
> >> +
> >> +    /* the ADDR method returns two 32-bit words representing the lowe=
r and
> >> +     * upper halves * of the physical address of the fw_cfg blob
> >> +     * (holding the GUID) */
> >> +    method =3D aml_method("ADDR", 0, AML_NOTSERIALIZED);
> >> +
> >> +    addr =3D aml_local(0);
> >> +    aml_append(method, aml_store(aml_package(2), addr));
> >> +
> >> +    aml_append(method, aml_store(aml_add(aml_name("VGIA"),
> >> +                                         aml_int(VMGENID_GUID_OFFSET)=
, NULL),
> >> +                                 aml_index(addr, aml_int(0))));
> >> +    aml_append(method, aml_store(aml_int(0), aml_index(addr, aml_int(=
1))));
> > I'd rather have "VGIA" patched wit address to GUID and not the blob sta=
rt,
> > see next comment about how.
> >=20
> > Also usage aml_index() looks a bit confusing, how about:
> >=20
> > pkg =3D aml_local(0)
> > aml_store(aml_package(2), pkg)
> > aml_append(pkg, aml_name("VGIA"))
> > aml_append(pkg, aml_int(0))
> >=20
> I=E2=80=99ll try that, it does look simpler.  I thought I tried this and =
couldn=E2=80=99t get it to work, but will try again.
> >> +    aml_append(method, aml_return(addr));
> >> +
> >> +    aml_append(dev, method);
> >> +    aml_append(scope, dev);
> >> +    aml_append(ssdt, scope);
> >> +
> >> +    /* attach an ACPI notify */
> >> +    method =3D aml_method("\\_GPE._E05", 0, AML_NOTSERIALIZED);
> >> +    aml_append(method, aml_notify(aml_name("\\_SB.VGEN"), aml_int(0x8=
0)));
> >> +    aml_append(ssdt, method);
> >> +
> >> +    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> >> +
> >> +    /* Allocate guest memory for the Data fw_cfg blob */
> >> +    bios_linker_loader_alloc(linker, VMGENID_GUID_FW_CFG_FILE, guid, =
4096,
> >> +                             false /* page boundary, high memory */);
> > does it guaranties that blob will be allocated in cacheable page?
> > (SeaBIOS/OVMF)
> >=20
> >> +
> >> +    /* Patch address of GUID fw_cfg blob into the ADDR fw_cfg blob */
> >> +    bios_linker_loader_add_pointer(linker,
> >> +        VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint32_t),
> >> +        VMGENID_GUID_FW_CFG_FILE, 0, true);
> >> +
> >> +    /* Patch address of GUID fw_cfg blob into the AML */
> >> +    bios_linker_loader_add_pointer(linker,
> >> +        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint32_t),
> >> +        VMGENID_GUID_FW_CFG_FILE, 0, false);
> > see @src_offset argument description,
> > putting VMGENID_GUID_OFFSET would make patched place point directly to =
GUID
> >=20
> >> +
> >> +    build_header(linker, table_data,
> >> +        (void *)(table_data->data + table_data->len - ssdt->buf->len),
> >> +        "SSDT", ssdt->buf->len, 1, NULL, "VMGENID");
> >> +    free_aml_allocator();
> >> +}
> >> +
> >> +void vmgenid_add_fw_cfg(FWCfgState *s, GArray *guid)
> >> +{
> >> +    Object *obj =3D find_vmgenid_dev(NULL);
> >> +    assert(obj);
> >> +    VmGenIdState *vms =3D VMGENID(obj);
> >> +
> >> +    /* Create a read-only fw_cfg file for GUID */
> >> +    fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, guid->data,
> >> +                    VMGENID_FW_CFG_SIZE);
> >> +    /* Create a read-write fw_cfg file for Address */
> >> +    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, NULL,
> >> +                             vms->vgia_le, sizeof(uint32_t), false);
> >> +}
> >> +
> >> +static void vmgenid_update_guest(VmGenIdState *s)
> >> +{
> >> +    Object *obj =3D object_resolve_path_type("", TYPE_ACPI_DEVICE_IF,=
 NULL);
> >> +    uint32_t vgia;
> >> +
> >> +    if (obj) {
> >> +        /* Write the GUID to guest memory */
> >> +        memcpy(&vgia, s->vgia_le, sizeof(vgia));
> >> +        vgia =3D le32_to_cpu(vgia);
> >> +        if (vgia) {
> >> +            cpu_physical_memory_write(vgia + VMGENID_GUID_OFFSET,
> >> +                                      s->guid.data, sizeof(s->guid.da=
ta));
> >> +            /* Send _GPE.E05 event */
> >> +            acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
> >> +        }
> >> +    }
> >> +}
> >> +
> >> +static void vmgenid_set_guid(Object *obj, const char *value, Error **=
errp)
> >> +{
> >> +    VmGenIdState *s =3D VMGENID(obj);
> >> +
> >> +    if (!strncmp(value, "auto", 4)) {
> >> +        qemu_uuid_generate(&s->guid);
> >> +    } else if (qemu_uuid_parse(value, &s->guid) < 0) {
> >> +        error_setg(errp, "'%s. %s': Failed to parse GUID string: %s",
> >> +                   object_get_typename(OBJECT(s)), VMGENID_GUID, valu=
e);
> >> +        return;
> >> +    }
> >> +    /* QemuUUID has the first three words as big-endian, and expect t=
hat any
> >> +     * GUIDs passed in will always be BE.  The guest, however will ex=
pect
> >> +     * the fields to be little-endian, so store that way internally. =
 Make
> >> +     * sure to swap back whenever reporting via monitor */
> >> +    qemu_uuid_bswap(&s->guid);
> >> +
> >> +    /* Send the ACPI notify */
> >> +    vmgenid_update_guest(s);
> >> +}
> >> +
> >> +/* After restoring an image, we need to update the guest memory and n=
otify
> >> + * it of a potential change to VM Generation ID */
> >> +static int vmgenid_post_load(void *opaque, int version_id)
> >> +{
> >> +    VmGenIdState *s =3D opaque;
> >> +    vmgenid_update_guest(s);
> >> +    return 0;
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_vmgenid =3D {
> >> +    .name =3D "vmgenid",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .post_load =3D vmgenid_post_load,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_UINT8_ARRAY(vgia_le, VmGenIdState, sizeof(uint32_t)),
> > file with address could be memory region and migrated automatically,
> > ex: rsdp_mr + acpi_add_rom_blob + acpi_ram_update
> >=20
> I don=E2=80=99t follow.  Can you please elaborate?
acpi_add_rom_blob() allocates memory that is automatically migrated
without need for explicit VMSTATE_FOO magic.

rsdp_mr is an example that uses this approach.

> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >> +static void vmgenid_initfn(Object *obj)
> >> +{
> >> +    object_property_add_str(obj, VMGENID_GUID, NULL, vmgenid_set_guid=
, NULL);
> >> +}
> >> +
> >> +static void vmgenid_device_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +
> >> +    dc->vmsd =3D &vmstate_vmgenid;
> >> +}
> >> +
> >> +static const TypeInfo vmgenid_device_info =3D {
> >> +    .name          =3D VMGENID_DEVICE,
> >> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >> +    .instance_size =3D sizeof(VmGenIdState),
> >> +    .instance_init =3D vmgenid_initfn,
> >> +    .class_init    =3D vmgenid_device_class_init,
> >> +};
> >> +
> >> +static void vmgenid_register_types(void)
> >> +{
> >> +    type_register_static(&vmgenid_device_info);
> >> +}
> >> +
> >> +type_init(vmgenid_register_types)
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 78a1d84..4c40f76 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -42,6 +42,7 @@
> >> #include "hw/acpi/memory_hotplug.h"
> >> #include "sysemu/tpm.h"
> >> #include "hw/acpi/tpm.h"
> >> +#include "hw/acpi/vmgenid.h"
> >> #include "sysemu/tpm_backend.h"
> >> #include "hw/timer/mc146818rtc_regs.h"
> >> #include "sysemu/numa.h"
> >> @@ -2653,6 +2654,11 @@ void acpi_build(AcpiBuildTables *tables, Machin=
eState *machine)
> >>     acpi_add_table(table_offsets, tables_blob);
> >>     build_madt(tables_blob, tables->linker, pcms);
> >>=20
> >> +    if (find_vmgenid_dev(NULL)) {
> >> +        acpi_add_table(table_offsets, tables_blob);
> >> +        vmgenid_build_acpi(tables_blob, tables->vmgenid, tables->link=
er);
> > pass find_vmgenid_dev(NULL) result as an argument to vmgenid_build_acpi=
()
> > so it won't have to do lookup again.
> >=20
> OK
> >> +    }
> >> +
> >>     if (misc.has_hpet) {
> >>         acpi_add_table(table_offsets, tables_blob);
> >>         build_hpet(tables_blob, tables->linker);
> >> @@ -2859,6 +2865,10 @@ void acpi_setup(void)
> >>     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
> >>                     tables.tcpalog->data, acpi_data_len(tables.tcpalog=
));
> >>=20
> >> +    if (find_vmgenid_dev(NULL)) {
> > it's second lookup, cache result of the 1st call and reuse it here
> >=20
> OK
> >> +        vmgenid_add_fw_cfg(pcms->fw_cfg, tables.vmgenid);
> >> +    }
> >> +
> >>     if (!pcmc->rsdp_in_ram) {
> >>         /*
> >>          * Keep for compatibility with old machine types.
> >> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/ac=
pi_dev_interface.h
> >> index 71d3c48..3c2e4e9 100644
> >> --- a/include/hw/acpi/acpi_dev_interface.h
> >> +++ b/include/hw/acpi/acpi_dev_interface.h
> >> @@ -11,6 +11,7 @@ typedef enum {
> >>     ACPI_CPU_HOTPLUG_STATUS =3D 4,
> >>     ACPI_MEMORY_HOTPLUG_STATUS =3D 8,
> >>     ACPI_NVDIMM_HOTPLUG_STATUS =3D 16,
> >> +    ACPI_VMGENID_CHANGE_STATUS =3D 32,
> >> } AcpiEventStatusBits;
> >>=20
> >> #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> >> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> >> new file mode 100644
> >> index 0000000..b60437a
> >> --- /dev/null
> >> +++ b/include/hw/acpi/vmgenid.h
> >> @@ -0,0 +1,37 @@
> >> +#ifndef ACPI_VMGENID_H
> >> +#define ACPI_VMGENID_H
> >> +
> >> +#include "hw/acpi/bios-linker-loader.h"
> >> +#include "hw/sysbus.h"
> >> +#include "qemu/uuid.h"
> >> +
> >> +#define VMGENID_DEVICE           "vmgenid"
> >> +#define VMGENID_GUID             "guid"
> >> +#define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid"
> >> +#define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
> >> +
> >> +#define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
> >> +#define VMGENID_GUID_OFFSET      40   /* allow space for
> >> +                                       * OVMF SDT Header Probe Supres=
sor */
> >> +
> >> +void vmgenid_add_fw_cfg(FWCfgState *s, GArray *guid);
> >> +void vmgenid_build_acpi(GArray *table_data, GArray *guid, BIOSLinker =
*linker);
> >> +
> >> +#define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), VMGENID_DEVICE)
> >> +
> >> +typedef struct VmGenIdState {
> >> +    SysBusDevice parent_obj;
> > Could it work with just plain Device parent?
> > If it works then you can drop patch:
> >  [PATCH v5 08/10] PC: Support dynamic sysbus on pc_i440fx
> >=20
> Huh, I was sure I tried that originally and couldn=E2=80=99t make it work=
, but it turns out it does.  Definitely better.
> >> +    QemuUUID guid;
> >> +    uint8_t vgia_le[4];
> >> +} VmGenIdState;
> >> +
> >> +static Object *find_vmgenid_dev(Error **errp)
> >> +{
> >> +    Object *obj =3D object_resolve_path_type("", VMGENID_DEVICE, NULL=
);
> >> +    if (!obj && errp) {
> > all callers pass NULL as errp, I'd just drop errp altogether.
> >=20
> OK
> >> +        error_setg(errp, "%s is not found", VMGENID_DEVICE);
> >> +    }
> >> +    return obj;
> >> +}
> >> +
> >> +#endif
>=20
