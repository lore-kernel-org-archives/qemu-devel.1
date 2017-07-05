Received: from eggs.gnu.org ([2001:4830:134:3::10]:43470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSkle-0002R7-Ri
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSkla-0004Cn-LZ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:54:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dSkla-0004CJ-By
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:54:54 -0400
Date: Wed, 5 Jul 2017 09:54:49 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1945214498.47130577.1499262889217.JavaMail.zimbra@redhat.com>
In-Reply-To: <0c4c4552-1e82-3fa2-31fc-c266f5f23f91@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-3-marcandre.lureau@redhat.com>
	<0c4c4552-1e82-3fa2-31fc-c266f5f23f91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, anderson@redhat.com, imammedo@redhat.com, Richard Henderson <rth@twiddle.net>

Hi

----- Original Message -----
> comments below
>=20
> On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
> > The VM coreinfo (vmcoreinfo) device is an emulated device which
> > exposes a 4k memory range to the guest to store various informations
> > useful to debug the guest OS. (it is greatly inspired by the VMGENID
> > device implementation)
> >=20
> > This is an early-boot alternative to the qemu-ga VMDUMP_INFO event
> > proposed in "[PATCH 00/21] WIP: dump: add kaslr support".
> >=20
> > A proof-of-concept kernel module:
> > https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/hw/acpi/aml-build.h        |   1 +
> >  include/hw/acpi/vmcoreinfo.h       |  36 +++++++
> >  hw/acpi/aml-build.c                |   2 +
> >  hw/acpi/vmcoreinfo.c               | 198
> >  +++++++++++++++++++++++++++++++++++++
> >  hw/i386/acpi-build.c               |  14 +++
> >  default-configs/arm-softmmu.mak    |   1 +
> >  default-configs/i386-softmmu.mak   |   1 +
> >  default-configs/x86_64-softmmu.mak |   1 +
> >  docs/specs/vmcoreinfo.txt          | 138 ++++++++++++++++++++++++++
> >  hw/acpi/Makefile.objs              |   1 +
> >  10 files changed, 393 insertions(+)
> >  create mode 100644 include/hw/acpi/vmcoreinfo.h
> >  create mode 100644 hw/acpi/vmcoreinfo.c
> >  create mode 100644 docs/specs/vmcoreinfo.txt
> >
> > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > index 88d0738d76..cf781bcd34 100644
> > --- a/include/hw/acpi/aml-build.h
> > +++ b/include/hw/acpi/aml-build.h
> > @@ -211,6 +211,7 @@ struct AcpiBuildTables {
> >      GArray *rsdp;
> >      GArray *tcpalog;
> >      GArray *vmgenid;
> > +    GArray *vmcoreinfo;
> >      BIOSLinker *linker;
> >  } AcpiBuildTables;
> > =20
> > diff --git a/include/hw/acpi/vmcoreinfo.h b/include/hw/acpi/vmcoreinfo.=
h
> > new file mode 100644
> > index 0000000000..40fe99c3ed
> > --- /dev/null
> > +++ b/include/hw/acpi/vmcoreinfo.h
> > @@ -0,0 +1,36 @@
> > +#ifndef ACPI_VMCOREINFO_H
> > +#define ACPI_VMCOREINFO_H
> > +
> > +#include "hw/acpi/bios-linker-loader.h"
> > +#include "hw/qdev.h"
> > +
> > +#define VMCOREINFO_DEVICE           "vmcoreinfo"
> > +#define VMCOREINFO_FW_CFG_FILE      "etc/vmcoreinfo"
> > +#define VMCOREINFO_ADDR_FW_CFG_FILE "etc/vmcoreinfo-addr"
> > +
> > +#define VMCOREINFO_FW_CFG_SIZE      4096 /* Occupy a page of memory */
> > +#define VMCOREINFO_OFFSET           40   /* allow space for
> > +                                          * OVMF SDT Header Probe
> > Supressor
> > +                                          */
> > +
> > +#define VMCOREINFO(obj) OBJECT_CHECK(VmcoreinfoState, (obj),
> > VMCOREINFO_DEVICE)
> > +
> > +typedef struct VmcoreinfoState {
>=20
> I think this should be spelled with a bit more camel-casing, like
> VMCoreInfoState or some such.
>=20

ok

> > +    DeviceClass parent_obj;
> > +    uint8_t vmcoreinfo_addr_le[8];   /* Address of memory region */
> > +    bool write_pointer_available;
> > +} VmcoreinfoState;
> > +
> > +/* returns NULL unless there is exactly one device */
> > +static inline Object *find_vmcoreinfo_dev(void)
> > +{
> > +    return object_resolve_path_type("", VMCOREINFO_DEVICE, NULL);
> > +}
> > +
> > +void vmcoreinfo_build_acpi(VmcoreinfoState *vis, GArray *table_data,
> > +                           GArray *vmci, BIOSLinker *linker);
> > +void vmcoreinfo_add_fw_cfg(VmcoreinfoState *vis, FWCfgState *s, GArray
> > *vmci);
> > +bool vmcoreinfo_get(VmcoreinfoState *vis, uint64_t *paddr, uint64_t *s=
ize,
> > +                    Error **errp);
> > +
> > +#endif
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index 36a6cc450e..47043ade4a 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c
> > @@ -1561,6 +1561,7 @@ void acpi_build_tables_init(AcpiBuildTables *tabl=
es)
> >      tables->table_data =3D g_array_new(false, true /* clear */, 1);
> >      tables->tcpalog =3D g_array_new(false, true /* clear */, 1);
> >      tables->vmgenid =3D g_array_new(false, true /* clear */, 1);
> > +    tables->vmcoreinfo =3D g_array_new(false, true /* clear */, 1);
> >      tables->linker =3D bios_linker_loader_init();
> >  }
> > =20
> > @@ -1571,6 +1572,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables
> > *tables, bool mfre)
> >      g_array_free(tables->table_data, true);
> >      g_array_free(tables->tcpalog, mfre);
> >      g_array_free(tables->vmgenid, mfre);
> > +    g_array_free(tables->vmcoreinfo, mfre);
> >  }
> > =20
> >  /* Build rsdt table */
> > diff --git a/hw/acpi/vmcoreinfo.c b/hw/acpi/vmcoreinfo.c
> > new file mode 100644
> > index 0000000000..216e0bb83a
> > --- /dev/null
> > +++ b/hw/acpi/vmcoreinfo.c
> > @@ -0,0 +1,198 @@
> > +/*
> > + *  Virtual Machine coreinfo device
> > + *  (based on Virtual Machine Generation ID Device)
> > + *
> > + *  Copyright (C) 2017 Red Hat, Inc.
> > + *  Copyright (C) 2017 Skyport Systems.
> > + *
> > + *  Authors: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > + *           Ben Warren <ben@skyportsystems.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +#include "qemu/osdep.h"
> > +#include "hw/acpi/acpi.h"
> > +#include "hw/acpi/aml-build.h"
> > +#include "hw/acpi/vmcoreinfo.h"
> > +#include "hw/nvram/fw_cfg.h"
> > +#include "sysemu/sysemu.h"
> > +#include "qapi/error.h"
> > +
> > +void vmcoreinfo_build_acpi(VmcoreinfoState *vis, GArray *table_data,
> > +                           GArray *vmci, BIOSLinker *linker)
> > +{
> > +    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
> > +    uint32_t vgia_offset;
>=20
> This should be called "vcia_offset".

ok

>=20
> > +
> > +    g_array_set_size(vmci, VMCOREINFO_FW_CFG_SIZE);
> > +
> > +    /* Put this in a separate SSDT table */
> > +    ssdt =3D init_aml_allocator();
> > +
> > +    /* Reserve space for header */
> > +    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
> > +
> > +    /* Storage address */
> > +    vgia_offset =3D table_data->len +
> > +        build_append_named_dword(ssdt->buf, "VCIA");
> > +    scope =3D aml_scope("\\_SB");
> > +    dev =3D aml_device("VMCI");
> > +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVMCI")));
> > +
> > +    /* Simple status method to check that address is linked and non-ze=
ro
> > */
> > +    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> > +    addr =3D aml_local(0);
> > +    aml_append(method, aml_store(aml_int(0xf), addr));
> > +    if_ctx =3D aml_if(aml_equal(aml_name("VCIA"), aml_int(0)));
> > +    aml_append(if_ctx, aml_store(aml_int(0), addr));
> > +    aml_append(method, if_ctx);
> > +    aml_append(method, aml_return(addr));
> > +    aml_append(dev, method);
> > +
> > +    /* the ADDR method returns two 32-bit words representing the lower=
 and
> > +     * upper halves of the physical address of the vmcoreinfo area
> > +     */
> > +    method =3D aml_method("ADDR", 0, AML_NOTSERIALIZED);
> > +
> > +    addr =3D aml_local(0);
> > +    aml_append(method, aml_store(aml_package(2), addr));
> > +
> > +    aml_append(method, aml_store(aml_add(aml_name("VCIA"),
> > +                                         aml_int(VMCOREINFO_OFFSET),
> > NULL),
> > +                                 aml_index(addr, aml_int(0))));
> > +    aml_append(method, aml_store(aml_int(0), aml_index(addr,
> > aml_int(1))));
> > +    aml_append(method, aml_return(addr));
> > +
> > +    aml_append(dev, method);
> > +    aml_append(scope, dev);
> > +    aml_append(ssdt, scope);
> > +
> > +    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> > +
> > +    /* Allocate guest memory */
> > +    bios_linker_loader_alloc(linker, VMCOREINFO_FW_CFG_FILE, vmci, 409=
6,
> > +                             false /* page boundary, high memory */);
> > +
> > +    /* Patch address of vmcoreinfo fw_cfg blob into the ADDR fw_cfg
> > +     * blob so QEMU can read the info from there.  The address is
> > +     * expected to be < 4GB, but write 64 bits anyway.
> > +     * The address that is patched in is offset in order to implement
> > +     * the "OVMF SDT Header probe suppressor"
> > +     * see docs/specs/vmcoreinfo.txt for more details.
> > +     */
> > +    bios_linker_loader_write_pointer(linker,
> > +        VMCOREINFO_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
> > +        VMCOREINFO_FW_CFG_FILE, VMCOREINFO_OFFSET);
> > +
> > +    /* Patch address of vmcoreinfo into the AML so OSPM can retrieve
> > +     * and read it.  Note that while we provide storage for 64 bits, o=
nly
> > +     * the least-signficant 32 get patched into AML.
> > +     */
> > +    bios_linker_loader_add_pointer(linker,
> > +        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint32_t),
> > +        VMCOREINFO_FW_CFG_FILE, 0);
> > +
> > +    build_header(linker, table_data,
> > +        (void *)(table_data->data + table_data->len - ssdt->buf->len),
> > +        "SSDT", ssdt->buf->len, 1, NULL, "VMCOREIN");
> > +    free_aml_allocator();
> > +}
> > +
> > +void vmcoreinfo_add_fw_cfg(VmcoreinfoState *vis, FWCfgState *s, GArray
> > *vmci)
> > +{
> > +    /* Create a read-only fw_cfg file for vmcoreinfo allocation */
> > +    /* XXX: linker could learn to allocate without backing fw_cfg? */
>=20
> Yes, and a number of other things, as I'm sure Igor and MST will point
> out upon reading the patch :)
>=20
> > +    fw_cfg_add_file(s, VMCOREINFO_FW_CFG_FILE, vmci->data,
> > +                    VMCOREINFO_FW_CFG_SIZE);
> > +    /* Create a read-write fw_cfg file for Address */
> > +    fw_cfg_add_file_callback(s, VMCOREINFO_ADDR_FW_CFG_FILE, NULL, NUL=
L,
> > +                             vis->vmcoreinfo_addr_le,
> > +                             ARRAY_SIZE(vis->vmcoreinfo_addr_le), fals=
e);
> > +}
> > +
> > +bool vmcoreinfo_get(VmcoreinfoState *vis,
> > +                    uint64_t *paddr, uint64_t *size,
> > +                    Error **errp)
> > +{
> > +    uint32_t vmcoreinfo_addr;
> > +    uint32_t version;
> > +
> > +    assert(vis);
> > +    assert(paddr);
> > +    assert(size);
> > +
> > +    memcpy(&vmcoreinfo_addr, vis->vmcoreinfo_addr_le,
> > sizeof(vmcoreinfo_addr));
> > +    vmcoreinfo_addr =3D le32_to_cpu(vmcoreinfo_addr);
> > +    if (!vmcoreinfo_addr) {
> > +        error_setg(errp, "BIOS has not yet written the address of %s",
> > +                   VMCOREINFO_DEVICE);
> > +        return false;
> > +    }
> > +
> > +    cpu_physical_memory_read(vmcoreinfo_addr, &version, sizeof(version=
));
> > +    if (version !=3D 0) {
> > +        error_setg(errp, "Unknown %s memory version", VMCOREINFO_DEVIC=
E);
> > +        return false;
> > +    }
> > +
> > +    cpu_physical_memory_read(vmcoreinfo_addr + 4, paddr, sizeof(paddr)=
);
>=20
> This is wrong, it should be sizeof(*paddr).

right

>=20
> > +    *paddr =3D le64_to_cpu(*paddr);
> > +    cpu_physical_memory_read(vmcoreinfo_addr + 12, size, sizeof(size))=
;
>=20
> This is wrong for two reasons:
> - first, it should be sizeof(*size),

ok

> - second, sizeof(*size) is 8, however, according to the design, the size
>   field is 4 bytes wide. I think the function prototype should be
>   updated to fix this.
>=20

yes

> > +    *size =3D le32_to_cpu(*size);
> > +
> > +    return true;
> > +}
> > +
> > +static const VMStateDescription vmstate_vmcoreinfo =3D {
> > +    .name =3D "vmcoreinfo",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT8_ARRAY(vmcoreinfo_addr_le, VmcoreinfoState,
> > sizeof(uint64_t)),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
> > +{
> > +    if (!bios_linker_loader_can_write_pointer()) {
> > +        error_setg(errp, "%s requires DMA write support in fw_cfg, "
> > +                   "which this machine type does not provide",
> > +                   VMCOREINFO_DEVICE);
> > +        return;
> > +    }
> > +
> > +    /* Given that this function is executing, there is at least one
> > VMCOREINFO
> > +     * device. Check if there are several.
> > +     */
> > +    if (!find_vmcoreinfo_dev()) {
> > +        error_setg(errp, "at most one %s device is permitted",
> > +                   VMCOREINFO_DEVICE);
> > +        return;
> > +    }
> > +}
>=20
> You didn't copy the reset logic from vmgenid, but that's wrong -- all
> device models that produce WRITE_POINTER linker/loader commands must
> forget about guest-returned GPAs upon reset. Think of it this way: when
> the guest executes WRITE_POINTER, it creates a reference to guest-phys
> memory in QEMU; and when the guest initiates a reboot, guest-phys memory
> is fully "invalidated", so all such references must be dropped in QEMU.
>=20
> (S3 resume is an exception, because guest memory is preserved, but both
> SeaBIOS and OVMF handle that specially -- they stash the WRITE_POINTER
> commands in a condensed format during normal boot, and then replay them
> during S3 resume. Thus, they restore the QEMU references discussed
> abovem at S3 resume.)
>=20
> In more practical terms, assume the guest boots Linux, the address is
> passed back fine, then the Linux guest reboots, and then some other
> guest OS is launched from the guest firmware and/or bootloader (or we
> just stay in the firmware / bootloader indefinitely). If a dump is
> requested at this point, QEMU shouldn't go looking for the VMCOREINFO
> ELF note at the previously communicated address.
>=20

Good point, I didn't realize it.


> The rest looks OK to me.

Thanks
