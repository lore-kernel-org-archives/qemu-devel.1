Received: from eggs.gnu.org ([2001:4830:134:3::10]:56043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWKRJ-0004pN-HV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWKRG-00082o-8e
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:04:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWKRF-00082d-Ut
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:04:26 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<b9ead8f0965c42f78e73e17e461ef7f476ae4318.1485308342.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <be3cd2b4-9a33-5c2c-902a-8a5967518348@redhat.com>
Date: Wed, 25 Jan 2017 11:04:22 +0100
MIME-Version: 1.0
In-Reply-To: <b9ead8f0965c42f78e73e17e461ef7f476ae4318.1485308342.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/9] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org

On 01/25/17 02:43, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
>=20
> This implements the VM Generation ID feature by passing a 128-bit
> GUID to the guest via a fw_cfg blob.
> Any time the GUID changes, and ACPI notify event is sent to the guest

(1) typo: "and" -> "an"

>=20
> The user interface is a simple device with one parameter:
>  - guid (string, must be "auto" or in UUID format
>    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>=20
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  default-configs/i386-softmmu.mak     |   1 +
>  default-configs/x86_64-softmmu.mak   |   1 +
>  hw/acpi/Makefile.objs                |   1 +
>  hw/acpi/vmgenid.c                    | 244 +++++++++++++++++++++++++++=
++++++++
>  hw/i386/acpi-build.c                 |   9 ++
>  include/hw/acpi/acpi_dev_interface.h |   1 +
>  include/hw/acpi/vmgenid.h            |  32 +++++
>  7 files changed, 289 insertions(+)
>  create mode 100644 hw/acpi/vmgenid.c
>  create mode 100644 include/hw/acpi/vmgenid.h
>=20
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-so=
ftmmu.mak
> index 0b51360..b2bccf6 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -56,3 +56,4 @@ CONFIG_IOH3420=3Dy
>  CONFIG_I82801B11=3Dy
>  CONFIG_SMBIOS=3Dy
>  CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
> +CONFIG_ACPI_VMGENID=3Dy
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_6=
4-softmmu.mak
> index 7f89503..c6bd310 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -56,3 +56,4 @@ CONFIG_IOH3420=3Dy
>  CONFIG_I82801B11=3Dy
>  CONFIG_SMBIOS=3Dy
>  CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
> +CONFIG_ACPI_VMGENID=3Dy
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 6acf798..11c35bc 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -5,6 +5,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.=
o
>  common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
>  common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
> +common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
> =20
>  common-obj-y +=3D acpi_interface.o
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> new file mode 100644
> index 0000000..63cb039
> --- /dev/null
> +++ b/hw/acpi/vmgenid.c
> @@ -0,0 +1,244 @@
> +/*
> + *  Virtual Machine Generation ID Device
> + *
> + *  Copyright (C) 2017 Skyport Systems.
> + *
> + *  Author: Ben Warren <ben@skyportsystems.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qmp-commands.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/vmgenid.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "sysemu/sysemu.h"
> +
> +Object *find_vmgenid_dev(Error **errp)
> +{
> +    Object *obj =3D object_resolve_path_type("", VMGENID_DEVICE, NULL)=
;
> +    if (!obj) {
> +        error_setg(errp, VMGENID_DEVICE " is not found");
> +    }

(2) For general cleanliness, we should use "%s" in the format string,
and pass VMGENID_DEVICE as an argument.

> +    return obj;
> +}
> +
> +void vmgenid_build_acpi(GArray *table_offsets, GArray *table_data,
> +         BIOSLinker *linker)

(3) I think the "table_offsets" parameter should be dropped.

In this function, that param is used only for calling acpi_add_table().
Looking at other similar call sites in acpi_build(), the pattern is alway=
s:

  if (check_feature_or_device()) {
    acpi_add_table(table_offsets, table_data);
    build_stuff_for_feature_or_device();
  }

That is, the parameter should be dropped, and the acpi_add_table() call
should be moved out to acpi_build().

> +{
> +    Object *obj;
> +    VmGenIdState *s;
> +    GArray *guid, *vgia;
> +    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
> +    uint32_t vgia_offset;
> +
> +    obj =3D find_vmgenid_dev(NULL);
> +    if (!obj) {
> +        return;
> +    }
> +    s =3D VMGENID(obj);

(4) The call to this function, from acpi_build(), is already protected
by has_vmgenid(). (And, see my suggestion near the end of this email
about rebasing has_vmgenid() to find_vmgenid_dev().) Therefore we should
simply assert that find_vmgenid_dev() succeeds.

> +
> +    acpi_add_table(table_offsets, table_data);

(So this should be moved to acpi_build(), see (3) above.)

> +
> +    guid =3D g_array_new(false, true, sizeof(s->guid.data));
> +    g_array_append_val(guid, s->guid.data);

(5) We're not considering host vs. guest endianness.
Let me quote the VmGenIdState structure:

typedef struct VmGenIdState {
    SysBusDevice parent_obj;
    QemuUUID guid;
    uint64_t vgia;
} VmGenIdState;

According to the documentation of QemuUUID, and the qemu_uuid_parse()
and qemu_uuid_unparse() functions -- used later in this patch --, the
representation of the UUID fields is big-endian in the QemuUUID structure=
.

However, the Windows guest will expect the UUID fields in little-endian
representation.

(This is mentioned in the previous docs patch, and also this is general
practice for Microsoft; see for example the SMBIOS 3.0 specification,
section "7.2.1 System =97 UUID":

    Although RFC4122 recommends network byte order for all fields, the
    PC industry (including the ACPI, UEFI, and Microsoft
    specifications) has consistently used little-endian byte encoding
    for the first three fields: time_low, time_mid,
    time_hi_and_version. [...]
)

Therefore I think we should byte-swap the fields with qemu_uuid_bswap()
first.

(6) As discussed under the previous patch, the blob constructed for the
"etc/vmgenid" file should consist of 40 bytes of zero padding, then the
(little-endian) GUID, then more padding, up to the page size (4KB).

(The byte swap for the GUID should occur only in the blob, not in the
VmGenIdState.guid field.)

(7) The blob constructed in this function, as a GArray, should be the
exact same object that is later linked into fw_cfg, via acpi_setup() -->
vmgenid_add_fw_cfg().

Currently, the blob is allocated here under the variable "guid", and
passed to bios_linker_loader_alloc_ret_addr(). That results in the
creation of a new BiosLinkerFileEntry object, with the "blob" field
being set to "guid".

However, in vmgenid_add_fw_cfg(), the VmGenIdState.guid.data field is
linked into fw_cfg. This is incorrect, those objects are independent,
but they should be the same.

Here's how to implement it:

* Add the field

    GArray *vmgenid

  to the "AcpiBuildTables" structure in "include/hw/acpi/aml-build.h",
  under the "tcpalog" field.

* Extend the acpi_build_tables_init() and acpi_build_tables_cleanup()
  functions in "hw/acpi/aml-build.c", so that the new field is
  initialized and released.

* In the acpi_build() function, pass "tables->vmgenid" to
  vmgenid_build_acpi(). This will require the a new parameter for the
  latter function.

* In vmgenid_build_acpi(), construct the blob as described under (5)
  and (6).

* In the acpi_setup() function, pass "tables.vmgenid" to
  vmgenid_add_fw_cfg(). (Again, new function parameter is necessary.)

* In vmgenid_add_fw_cfg(), link "tables.vmgenid->data" into fw_cfg, not
  VmGenIdState.guid.data.

> +    vgia =3D g_array_new(false, true, sizeof(uint64_t));
> +    g_array_append_val(vgia, s->vgia);

(8) This is unnecessary.

As I mentioned earlier, under patch #2, we need not and should not
instruct the firmware to allocate room for, and download, the fw_cfg
file that is going to receive the allocation address. So this should be
simply dropped (including the "vgia" local variable).

I shall comment more on the "VmGenIdState.vgia" field, just a bit lower
down.

> +
> +    /* Put this in a separate SSDT table */
> +    ssdt =3D init_aml_allocator();
> +
> +    /* Reserve space for header */
> +    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
> +
> +    /* Storage for the GUID address */
> +    vgia_offset =3D table_data->len +
> +        build_append_named_qword(ssdt->buf, "VGIA");
> +    scope =3D aml_scope("\\_SB");
> +    dev =3D aml_device("VGEN");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVGID")));
> +    aml_append(dev, aml_name_decl("_CID", aml_string("VM_Gen_Counter")=
));
> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VM_Gen_Counter")=
));
> +
> +    /* Simple status method to check that address is linked and non-ze=
ro */
> +    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    addr =3D aml_local(0);
> +    aml_append(method, aml_store(aml_int(0xf), addr));
> +    if_ctx =3D aml_if(aml_equal(aml_name("VGIA"), aml_int(0)));
> +    aml_append(if_ctx, aml_store(aml_int(0), addr));
> +    aml_append(method, if_ctx);
> +    aml_append(method, aml_return(addr));
> +    aml_append(dev, method);
> +
> +    /* the ADDR method returns two 32-bit words representing the lower=
 and
> +     * upper halves * of the physical address of the fw_cfg blob
> +     * (holding the GUID) */
> +    method =3D aml_method("ADDR", 0, AML_NOTSERIALIZED);
> +
> +    addr =3D aml_local(0);
> +    aml_append(method, aml_store(aml_package(2), addr));
> +
> +    aml_append(method, aml_store(aml_and(aml_name("VGIA"),
> +        aml_int(0xffffffff), NULL), aml_index(addr, aml_int(0))));
> +    aml_append(method, aml_store(aml_shiftright(aml_name("VGIA"),
> +        aml_int(32), NULL), aml_index(addr, aml_int(1))));
> +    aml_append(method, aml_return(addr));

(9) This is the part (the ADDR method) where you should please add 40
decimal to the contents of the VGIA field, and return that value.

> +
> +    aml_append(dev, method);
> +    aml_append(scope, dev);
> +    aml_append(ssdt, scope);
> +
> +    /* attach an ACPI notify */
> +    method =3D aml_method("\\_GPE._E05", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_notify(aml_name("\\_SB.VGEN"), aml_int(0x80=
)));
> +    aml_append(ssdt, method);
> +
> +    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> +
> +    /* Allocate guest memory for the Address fw_cfg blob */
> +    bios_linker_loader_alloc(linker, VMGENID_ADDR_FW_CFG_FILE, vgia, 0=
,
> +                             false /* high memory */);

(10) this should be dropped, in accordance with (8).

> +    /* Allocate guest memory for the GUID fw_cfg blob and return addre=
ss */
> +    bios_linker_loader_alloc_ret_addr(linker, VMGENID_GUID_FW_CFG_FILE=
, guid,
> +                                      0, false, VMGENID_ADDR_FW_CFG_FI=
LE);

(11) The arguments are not entirely correct; the ones to update are:

- "guid" should be replaced by the new parameter of vmgenid_build_acpi()
that stands for "AcpiBuildTables.vmgenid" and whose contents you
constuct here. See (7).

- 0 (for "alloc_align") should be replaced with 4096, because we want
the blob to be page aligned in the guest.

> +    /* Patch address of GUID fw_cfg blob into the AML */
> +    bios_linker_loader_add_pointer(linker,
> +        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint64_t),
> +        VMGENID_GUID_FW_CFG_FILE, 0);

Yes, this is correct!

> +
> +    build_header(linker, table_data,
> +        (void *)(table_data->data + table_data->len - ssdt->buf->len),
> +        "SSDT", ssdt->buf->len, 1, NULL, "VMGENID");
> +    free_aml_allocator();
> +}

Looks fine to me.

> +
> +void vmgenid_add_fw_cfg(FWCfgState *s)
> +{
> +    Object *obj =3D find_vmgenid_dev(NULL);
> +    if (!obj) {
> +        return;
> +    }

(12) The call to this function is protected by has_vmgenid(), so we
should just assert success here.

> +    VmGenIdState *vms =3D VMGENID(obj);
> +    /* Create a read-only fw_cfg file for GUID */
> +    fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, vms->guid.data,
> +        sizeof(vms->guid.data));

(13) According to (7) and (11), the data linked into fw_cfg should be
"tables.vmgenid->data". (From a new parameter of this function.)

> +    /* Create a read-write fw_cfg file for Address */
> +    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, NULL,
> +                             &vms->vgia, sizeof(uint64_t), false);
> +}

(14) Okay, so this is where I comment on the "VmGenIdState.vgia".

The address written by the guest is not approprite to represent as a
uint64_t field in "VmGenIdState". (The same applies to "vmstate_vmgenid"
/ VMSTATE_UINT64() lower.)

The reason is that the guest will always write the address in
little-endian order, but the host can be little endian and big endian
alike. Given that you need to work with this address value as a numeric
quantity in QEMU, you should explicitly convert from guest endian(LE) to
host endian (whatever that is).

IOW,

- the "VmGenIdState.vgia" field should be defined as:

    uint8_t vgia_le[8];

- linked as such into fw_cfg,

- migrated as such (because migration between little-endian and
  big-endian hosts keeps the *host value*, doing any necessary byte
  swaps automatically, and that, with the current representation, would
  appear to the guest, if it read back the contents of the address
  fw_cfg file),

- and converted explicitly to host endian when dereferenced.

I'll point out the last two items more precisely below.

> +
> +static void vmgenid_update_guest(VmGenIdState *s)
> +{
> +    Object *obj =3D object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, =
NULL);
> +    if (obj) {
> +
> +        /* Write the GUID to guest memory */
> +        if (s->vgia) {
> +            cpu_physical_memory_write(s->vgia, s->guid.data,
> +                                      sizeof(s->guid.data));
> +        }

(15) So here you need to copy the "s->vgia_le" array into a local
uint64_t variable, and convert it from LE to host endian with the
le64_to_cpus() function.

If the result compares unequal to zero, then you should add 40 decimal
-- see the blob's structure before --, and write the current GUID to
*that* guest physical address.

NB, the data to write (i.e., s->guid) should be treated with
qemu_uuid_bswap() for the guest first, because on the host side, it is
guaranteed BE, but the guest needs LE. Again, see (5) above.


> +        /* Send _GPE.E05 event */
> +        acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);

(16) I think this should also depend on vgia_le being nonzero!

> +    }
> +}
> +
> +static void vmgenid_set_guid(Object *obj, const char *value, Error **e=
rrp)
> +{
> +    VmGenIdState *s =3D VMGENID(obj);
> +
> +    if (!strncmp(value, "auto", 4)) {
> +        qemu_uuid_generate(&s->guid);
> +    } else if (qemu_uuid_parse(value, &s->guid) < 0) {
> +        error_setg(errp, "'%s." VMGENID_GUID
> +                   "': Failed to parse GUID string: %s",
> +                   object_get_typename(OBJECT(s)),
> +                   value);

(17) Please don't embed VMGENID_GUID in the format string, use %s and an
argument instead.

> +        return;
> +    }
> +    /* Send the ACPI notify */
> +    vmgenid_update_guest(s);
> +}
> +
> +/* After restoring an image, we need to update the guest memory and no=
tify
> + * it of a potential change to VM Generation ID */
> +static int vmgenid_post_load(void *opaque, int version_id)
> +{
> +    VmGenIdState *s =3D opaque;
> +    vmgenid_update_guest(s);
> +    return 0;
> +}

Hm.... Okay, I think this should be fine; on the target host (or when
the vmstate is reloaded from a file / snapshot), it is the management
layer's responsibility to set a new GUID on the command line.

So here we don't have to generate a new GUID. I believe the following
happens:

- Libvirt starts QEMU on the target host, with a new GUID (auto, or
specific). vmgenid_set_guid() gets called due to the property being set,
which either generates a random GUID, or parses it from the command line.

- vmgenid_set_guid() calls vmgenid_update_guest(). Given that at this
point the vgia_le field is zero, nothing is written to guest memory.
And, according to my remark (16), the _GPE.E05 event is also not raised
(which would otherwise consist of setting bit5 in the STS register, and
injecting an SCI).

- the incoming migration stream is processed. The "vgia_le" field is
loaded from the source host, but the "guid" field preserves the value
parsed from the command line on the target host (or the value generated
on the target host)

- vmgenid_post_load() is called. Given that "vgia_le" is no longer zero,
the GUID parsed (or generated) on the host side is written into guest
memory.

Seems sane to me.

> +
> +/* Store the VM Generation ID guest address as part of state info
> + * This is necessary because BIOS will not run when a VM is restored
> + * and so will not tell QEMU the guest address */

(18) I propose to drop this comment.

The more general explanation (which covers all vmstate descriptions) is
that all state that is under the guest's influence must be migrated. In
our case, the address is under guest influence.

> +static const VMStateDescription vmstate_vmgenid =3D {
> +    .name =3D "vmgenid",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D vmgenid_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(vgia, VmGenIdState),

(19) Referring back to (14), this should be

  VMSTATE_UINT8_ARRAY(vgia_le, VmGenIdState, sizeof(uint64_t))

> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void vmgenid_initfn(Object *obj)
> +{
> +    VmGenIdState *s =3D VMGENID(obj);
> +
> +    object_property_add_str(obj, VMGENID_GUID, NULL, vmgenid_set_guid,=
 NULL);
> +    s->vgia =3D 0;

(20) The zero assignment should not be necessary, the full object is
zeroed when allocated.

> +}
> +
> +static void vmgenid_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->vmsd =3D &vmstate_vmgenid;
> +}
> +
> +static const TypeInfo vmgenid_device_info =3D {
> +    .name          =3D VMGENID_DEVICE,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(VmGenIdState),
> +    .instance_init =3D vmgenid_initfn,
> +    .class_init    =3D vmgenid_device_class_init,
> +};
> +
> +static void vmgenid_register_types(void)
> +{
> +    type_register_static(&vmgenid_device_info);
> +}
> +
> +type_init(vmgenid_register_types)
> +
> +GuidInfo *qmp_query_vm_generation_id(Error **errp)
> +{
> +    GuidInfo *info;
> +    VmGenIdState *vdev;
> +    Object *obj =3D find_vmgenid_dev(errp);
> +
> +    if (!obj) {
> +        return NULL;
> +    }
> +    vdev =3D VMGENID(obj);
> +    info =3D g_malloc0(sizeof(*info));
> +    info->guid =3D qemu_uuid_unparse_strdup(&vdev->guid);
> +    return info;
> +}
> +
> +void qmp_set_vm_generation_id(const char *guid, Error **errp)
> +{
> +    Object *obj =3D find_vmgenid_dev(errp);
> +
> +    if (!obj) {
> +        return;
> +    }
> +
> +    object_property_set_str(obj, guid, VMGENID_GUID, errp);
> +    return;
> +}

(21) These two QMP functions are probably fine, but IMO they don't
belong to this patch. They should go into patch #5 ("qmp/hmp: add
query-vm-generation-id and 'info vm-generation-id' commands").

What's more, given that GuidInfo is generated from "qapi-schema.json",
and that file is extended only in the next patch, I believe if you check
out the tree at this stage exactly, it won't build.

I think you may have squashed these functions into the wrong patch
during a git-rebase.

> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1c928ab..78b4da5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -42,6 +42,7 @@
>  #include "hw/acpi/memory_hotplug.h"
>  #include "sysemu/tpm.h"
>  #include "hw/acpi/tpm.h"
> +#include "hw/acpi/vmgenid.h"
>  #include "sysemu/tpm_backend.h"
>  #include "hw/timer/mc146818rtc_regs.h"
>  #include "sysemu/numa.h"
> @@ -2653,6 +2654,10 @@ void acpi_build(AcpiBuildTables *tables, Machine=
State *machine)
>      acpi_add_table(table_offsets, tables_blob);
>      build_madt(tables_blob, tables->linker, pcms);
> =20
> +    if (has_vmgenid()) {
> +        vmgenid_build_acpi(table_offsets, tables_blob, tables->linker)=
;
> +    }
> +
>      if (misc.has_hpet) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_hpet(tables_blob, tables->linker);
> @@ -2859,6 +2864,10 @@ void acpi_setup(void)
>      fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>                      tables.tcpalog->data, acpi_data_len(tables.tcpalog=
));
> =20
> +    if (has_vmgenid()) {
> +        vmgenid_add_fw_cfg(pcms->fw_cfg);
> +    }
> +
>      if (!pcmc->rsdp_in_ram) {
>          /*
>           * Keep for compatibility with old machine types.

The necessary changes for these hunks follow from the above points.

> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acp=
i_dev_interface.h
> index 71d3c48..3c2e4e9 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -11,6 +11,7 @@ typedef enum {
>      ACPI_CPU_HOTPLUG_STATUS =3D 4,
>      ACPI_MEMORY_HOTPLUG_STATUS =3D 8,
>      ACPI_NVDIMM_HOTPLUG_STATUS =3D 16,
> +    ACPI_VMGENID_CHANGE_STATUS =3D 32,
>  } AcpiEventStatusBits;
> =20
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> new file mode 100644
> index 0000000..e4ac6f8
> --- /dev/null
> +++ b/include/hw/acpi/vmgenid.h
> @@ -0,0 +1,32 @@
> +#ifndef ACPI_VMGENID_H
> +#define ACPI_VMGENID_H
> +
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "hw/sysbus.h"
> +#include "qemu/uuid.h"
> +
> +#define VMGENID_DEVICE           "vmgenid"
> +#define VMGENID_GUID             "guid"
> +#define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid"
> +#define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
> +
> +Object *find_vmgenid_dev(Error **errp);
> +void vmgenid_add_fw_cfg(FWCfgState *s);
> +void vmgenid_build_acpi(GArray *table_offsets, GArray *table_data,
> +                       BIOSLinker *linker);
> +
> +#define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), VMGENID_DEVICE)
> +
> +typedef struct VmGenIdState {
> +    SysBusDevice parent_obj;
> +    QemuUUID guid;
> +    uint64_t vgia;
> +

(22) Unnecessary empty line.

> +} VmGenIdState;
> +
> +static inline bool has_vmgenid(void)
> +{
> +    return object_resolve_path_type("", VMGENID_DEVICE, NULL) !=3D NUL=
L;
> +}
> +
> +#endif
>=20

(23) We have two very similar functions here, find_vmgenid_dev() and
has_vmgenid(). I think has_vmgenid() should be rebased to
find_vmgenid_dev(). See also (4) above.

Thanks!
Laszlo
