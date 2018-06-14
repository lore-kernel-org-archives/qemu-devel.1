Received: from eggs.gnu.org ([2001:4830:134:3::10]:42321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTYbu-0006Ob-GH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTYbq-0005bX-DY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:12:46 -0400
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-6-peter.maydell@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <666290e7-7dee-39b9-0621-7667791584ce@redhat.com>
Date: Thu, 14 Jun 2018 22:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180604152941.20374-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/13] hw/misc/tz-mpc.c: Implement the
 Arm TrustZone Memory Protection Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

Hi Peter,
On 06/04/2018 05:29 PM, Peter Maydell wrote:
> Implement the Arm TrustZone Memory Protection Controller, which sits
> in front of RAM and allows secure software to configure it to either
> pass through or reject transactions.
>=20
> We implement the MPC as a QEMU IOMMU, which will direct transactions
> either through to the devices and memory behind it or to a special
> "never works" AddressSpace if they are blocked.
>=20
> This initial commit implements the skeleton of the device:
>  * it always permits accesses
>  * it doesn't implement most of the registers
>  * it doesn't implement the interrupt or other behaviour
>    for blocked transactions
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/misc/Makefile.objs           |   1 +
>  include/hw/misc/tz-mpc.h        |  70 ++++++
>  hw/misc/tz-mpc.c                | 381 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |   2 +
>  default-configs/arm-softmmu.mak |   1 +
>  hw/misc/trace-events            |   7 +
>  6 files changed, 462 insertions(+)
>  create mode 100644 include/hw/misc/tz-mpc.h
>  create mode 100644 hw/misc/tz-mpc.c
>=20
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 00e834d0f06..7295e676a64 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -61,6 +61,7 @@ obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
>  obj-$(CONFIG_MPS2_FPGAIO) +=3D mps2-fpgaio.o
>  obj-$(CONFIG_MPS2_SCC) +=3D mps2-scc.o
> =20
> +obj-$(CONFIG_TZ_MPC) +=3D tz-mpc.o
>  obj-$(CONFIG_TZ_PPC) +=3D tz-ppc.o
>  obj-$(CONFIG_IOTKIT_SECCTL) +=3D iotkit-secctl.o
> =20
> diff --git a/include/hw/misc/tz-mpc.h b/include/hw/misc/tz-mpc.h
> new file mode 100644
> index 00000000000..b5eaf1699ea
> --- /dev/null
> +++ b/include/hw/misc/tz-mpc.h
> @@ -0,0 +1,70 @@
> +/*
> + * ARM TrustZone memory protection controller emulation
nit AHB5 TrustZone Memory Protection controller? This is the title of
chapter in the spec.
> + *
> + * Copyright (c) 2018 Linaro Limited
> + * Written by Peter Maydell
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License version 2 or
> + * (at your option) any later version.
> + */
> +
> +/* This is a model of the TrustZone memory protection controller (MPC)=
.
> + * It is documented in the ARM CoreLink SIE-200 System IP for Embedded=
 TRM
> + * (DDI 0571G):
> + * https://developer.arm.com/products/architecture/m-profile/docs/ddi0=
571/g
> + *
> + * The MPC sits in front of memory and allows secure software to
> + * configure it to either pass through or reject transactions.
> + * Rejected transactions may be configured to either be aborted, or to
> + * behave as RAZ/WI. An interrupt can be signalled for a rejected tran=
saction.
> + *
> + * The MPC has a register interface which the guest uses to configure =
it.
> + *
> + * QEMU interface:
> + * + sysbus MMIO region 0: MemoryRegion for the MPC's config registers
> + * + sysbus MMIO region 1: MemoryRegion for the upstream end of the MP=
C
> + * + Property "downstream": MemoryRegion defining the downstream memor=
y
> + * + Named GPIO output "irq": set for a transaction-failed interrupt
> + */
> +
> +#ifndef TZ_MPC_H
> +#define TZ_MPC_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_TZ_MPC "tz-mpc"
> +#define TZ_MPC(obj) OBJECT_CHECK(TZMPC, (obj), TYPE_TZ_MPC)
> +
> +#define TZ_NUM_PORTS 16
> +
> +#define TYPE_TZ_MPC_IOMMU_MEMORY_REGION "tz-mpc-iommu-memory-region"
> +
> +typedef struct TZMPC TZMPC;
> +
> +struct TZMPC {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +
> +    qemu_irq irq;
> +
> +    /* Properties */
> +    MemoryRegion *downstream;
> +
> +    hwaddr blocksize;
> +    uint32_t blk_max;
> +
> +    /* MemoryRegions exposed to user */
> +    MemoryRegion regmr;
> +    IOMMUMemoryRegion upstream;
> +
> +    /* MemoryRegion used internally */
> +    MemoryRegion blocked_io;
> +
> +    AddressSpace downstream_as;
> +    AddressSpace blocked_io_as;
> +};
> +
> +#endif
> diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
> new file mode 100644
> index 00000000000..d4467ccc3b2
> --- /dev/null
> +++ b/hw/misc/tz-mpc.c
> @@ -0,0 +1,381 @@
> +/*
> + * ARM TrustZone memory protection controller emulation
> + *
> + * Copyright (c) 2018 Linaro Limited
> + * Written by Peter Maydell
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License version 2 or
> + * (at your option) any later version.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "hw/sysbus.h"
> +#include "hw/registerfields.h"
> +#include "hw/misc/tz-mpc.h"
> +
> +/* Our IOMMU has two IOMMU indexes, one for secure transactions and on=
e for
> + * non-secure transactions.
> + */
> +enum {
> +    IOMMU_IDX_S,
> +    IOMMU_IDX_NS,
> +    IOMMU_NUM_INDEXES,
> +};
> +
> +/* Config registers */
> +REG32(CTRL, 0x00)
> +REG32(BLK_MAX, 0x10)
> +REG32(BLK_CFG, 0x14)
> +REG32(BLK_IDX, 0x18)
> +REG32(BLK_LUT, 0x1c)
> +REG32(INT_STAT, 0x20)
> +REG32(INT_CLEAR, 0x24)
> +REG32(INT_EN, 0x28)
> +REG32(INT_INFO1, 0x2c)
> +REG32(INT_INFO2, 0x30)
> +REG32(INT_SET, 0x34)
> +REG32(PIDR4, 0xfd0)
> +REG32(PIDR5, 0xfd4)
> +REG32(PIDR6, 0xfd8)
> +REG32(PIDR7, 0xfdc)
> +REG32(PIDR0, 0xfe0)
> +REG32(PIDR1, 0xfe4)
> +REG32(PIDR2, 0xfe8)
> +REG32(PIDR3, 0xfec)
> +REG32(CIDR0, 0xff0)
> +REG32(CIDR1, 0xff4)
> +REG32(CIDR2, 0xff8)
> +REG32(CIDR3, 0xffc)
> +
> +static const uint8_t tz_mpc_idregs[] =3D {
> +    0x04, 0x00, 0x00, 0x00,
> +    0x60, 0xb8, 0x1b, 0x00,
> +    0x0d, 0xf0, 0x05, 0xb1,
> +};
> +
> +static MemTxResult tz_mpc_reg_read(void *opaque, hwaddr addr,
> +                                   uint64_t *pdata,
> +                                   unsigned size, MemTxAttrs attrs)
> +{
> +    uint64_t r;
> +    uint32_t offset =3D addr & ~0x3;
> +
> +    switch (offset) {
> +    case A_PIDR4:
> +    case A_PIDR5:
> +    case A_PIDR6:
> +    case A_PIDR7:
> +    case A_PIDR0:
> +    case A_PIDR1:
> +    case A_PIDR2:
> +    case A_PIDR3:
> +    case A_CIDR0:
> +    case A_CIDR1:
> +    case A_CIDR2:
> +    case A_CIDR3:
> +        r =3D tz_mpc_idregs[(offset - A_PIDR4) / 4];
> +        break;
> +    case A_INT_CLEAR:
> +    case A_INT_SET:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "TZ MPC register read: write-only offset 0x%x\n"=
,
> +                      offset);
> +        r =3D 0;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "TZ MPC register read: bad offset 0x%x\n", offse=
t);
> +        r =3D 0;
> +        break;
> +    }
> +
> +    if (size !=3D 4) {
> +        /* None of our registers are read-sensitive (except BLK_LUT,
> +         * which can special case the "size not 4" case), so just
> +         * pull the right bytes out of the word read result.
> +         */
> +        r =3D extract32(r, (addr & 3) * 8, size * 8);
> +    }
> +
> +    trace_tz_mpc_reg_read(addr, r, size);
> +    *pdata =3D r;
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult tz_mpc_reg_write(void *opaque, hwaddr addr,
> +                                    uint64_t value,
> +                                    unsigned size, MemTxAttrs attrs)
> +{
> +    uint32_t offset =3D addr & ~0x3;
> +
> +    trace_tz_mpc_reg_write(addr, value, size);
> +
> +    if (size !=3D 4) {
> +        /* Expand the byte or halfword write to a full word size.
> +         * In most cases we can do this with zeroes; the exceptions
> +         * are CTRL, BLK_IDX and BLK_LUT.
> +         */
> +        uint32_t oldval;
> +
> +        switch (offset) {
> +            /* As we add support for registers which need expansions
> +             * other than zeroes we'll fill in cases here.
> +             */
> +        default:
> +            oldval =3D 0;
> +            break;
> +        }
> +        value =3D deposit32(oldval, (addr & 3) * 8, size * 8, value);
> +    }
> +
> +    switch (offset) {
> +    case A_PIDR4:
> +    case A_PIDR5:
> +    case A_PIDR6:
> +    case A_PIDR7:
> +    case A_PIDR0:
> +    case A_PIDR1:
> +    case A_PIDR2:
> +    case A_PIDR3:
> +    case A_CIDR0:
> +    case A_CIDR1:
> +    case A_CIDR2:
> +    case A_CIDR3:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "TZ MPC register write: read-only offset 0x%x\n"=
, offset);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "TZ MPC register write: bad offset 0x%x\n", offs=
et);
> +        break;
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps tz_mpc_reg_ops =3D {
> +    .read_with_attrs =3D tz_mpc_reg_read,
> +    .write_with_attrs =3D tz_mpc_reg_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 4,
> +    .impl.min_access_size =3D 1,
> +    .impl.max_access_size =3D 4,
> +};
> +
> +/* Accesses only reach these read and write functions if the MPC is
> + * blocking them; non-blocked accesses go directly to the downstream
> + * memory region without passing through this code.
> + */
> +static MemTxResult tz_mpc_mem_blocked_read(void *opaque, hwaddr addr,
> +                                           uint64_t *pdata,
> +                                           unsigned size, MemTxAttrs a=
ttrs)
> +{
> +    trace_tz_mpc_mem_blocked_read(addr, size, attrs.secure);
> +
> +    *pdata =3D 0;
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult tz_mpc_mem_blocked_write(void *opaque, hwaddr addr,
> +                                            uint64_t value,
> +                                            unsigned size, MemTxAttrs =
attrs)
> +{
> +    trace_tz_mpc_mem_blocked_write(addr, value, size, attrs.secure);
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps tz_mpc_mem_blocked_ops =3D {
> +    .read_with_attrs =3D tz_mpc_mem_blocked_read,
> +    .write_with_attrs =3D tz_mpc_mem_blocked_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 1,
> +    .impl.max_access_size =3D 8,
> +};
> +
> +static IOMMUTLBEntry tz_mpc_translate(IOMMUMemoryRegion *iommu,
> +                                      hwaddr addr, IOMMUAccessFlags fl=
ags,
> +                                      int iommu_idx)
> +{
> +    TZMPC *s =3D TZ_MPC(container_of(iommu, TZMPC, upstream));
> +    bool ok;
> +
> +    IOMMUTLBEntry ret =3D {
> +        .iova =3D addr & ~(s->blocksize - 1),
> +        .translated_addr =3D addr & ~(s->blocksize - 1),
> +        .addr_mask =3D s->blocksize - 1,
> +        .perm =3D IOMMU_RW,
> +    };
> +
> +    /* Look at the per-block configuration for this address, and
> +     * return a TLB entry directing the transaction at either
> +     * downstream_as or blocked_io_as, as appropriate.
> +     * For the moment, always permit accesses.
> +     */
> +    ok =3D true;
> +
> +    trace_tz_mpc_translate(addr, flags,
> +                           iommu_idx =3D=3D IOMMU_IDX_S ? "S" : "NS",
> +                           ok ? "pass" : "block");
> +
> +    ret.target_as =3D ok ? &s->downstream_as : &s->blocked_io_as;
> +    return ret;
> +}
> +
> +static int tz_mpc_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs =
attrs)
> +{
> +    /* We treat unspecified attributes like secure. Transactions with
> +     * unspecified attributes come from places like
> +     * cpu_physical_memory_write_rom() for initial image load, and we =
want
> +     * those to pass through the from-reset "everything is secure" con=
fig.
> +     * All the real during-emulation transactions from the CPU will
> +     * specify attributes.
> +     */
> +    return (attrs.unspecified || attrs.secure) ? IOMMU_IDX_S : IOMMU_I=
DX_NS;
> +}
> +
> +static int tz_mpc_num_indexes(IOMMUMemoryRegion *iommu)
> +{
> +    return IOMMU_NUM_INDEXES;
> +}
> +
> +static void tz_mpc_reset(DeviceState *dev)
> +{
> +}
> +
> +static void tz_mpc_init(Object *obj)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    TZMPC *s =3D TZ_MPC(obj);
> +
> +    qdev_init_gpio_out_named(dev, &s->irq, "irq", 1);
> +}
> +
> +static void tz_mpc_realize(DeviceState *dev, Error **errp)
> +{
> +    Object *obj =3D OBJECT(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    TZMPC *s =3D TZ_MPC(dev);
> +    uint64_t size;
> +
> +    /* We can't create the upstream end of the port until realize,
> +     * as we don't know the size of the MR used as the downstream unti=
l then.
> +     * We insist on having a downstream, to avoid complicating the cod=
e
> +     * with handling the "don't know how big this is" case. It's easy
> +     * enough for the user to create an unimplemented_device as downst=
ream
> +     * if they have nothing else to plug into this.
> +     */
> +    if (!s->downstream) {
> +        error_setg(errp, "MPC 'downstream' link not set");
> +        return;
> +    }
> +
> +    size =3D memory_region_size(s->downstream);
> +
> +    memory_region_init_iommu(&s->upstream, sizeof(s->upstream),
> +                             TYPE_TZ_MPC_IOMMU_MEMORY_REGION,
> +                             obj, "tz-mpc-upstream", size);
> +
> +    /* In real hardware the block size is configurable. In QEMU we cou=
ld
> +     * make it configurable but will need it to be at least as big as =
the
> +     * target page size so we can execute out of the resulting MRs. Gu=
est
> +     * software is supposed to check the block size using the BLK_CFG
> +     * register, so make it fixed at the page size.
> +     */
> +    s->blocksize =3D memory_region_iommu_get_min_page_size(&s->upstrea=
m);
> +    if (size % s->blocksize !=3D 0) {
> +        error_setg(errp,
> +                   "MPC 'downstream' size %" PRId64
> +                   " is not a multiple of %" HWADDR_PRIx " bytes",
> +                   size, s->blocksize);
> +        object_unref(OBJECT(&s->upstream));
> +        return;
> +    }
> +
> +    /* BLK_MAX is the max value of BLK_IDX, which indexes an array of =
32-bit
> +     * words, each bit of which indicates one block.
> +     */
> +    s->blk_max =3D DIV_ROUND_UP(size / s->blocksize, 32);
> +
> +    memory_region_init_io(&s->regmr, obj, &tz_mpc_reg_ops,
> +                          s, "tz-mpc-regs", 0x1000);
> +    sysbus_init_mmio(sbd, &s->regmr);
> +
> +    sysbus_init_mmio(sbd, MEMORY_REGION(&s->upstream));
> +
> +    /* This memory region is not exposed to users of this device as a
> +     * sysbus MMIO region, but is instead used internally as something
> +     * that our IOMMU translate function might direct accesses to.
> +     */
> +    memory_region_init_io(&s->blocked_io, obj, &tz_mpc_mem_blocked_ops=
,
> +                          s, "tz-mpc-blocked-io", size);
> +
> +    address_space_init(&s->downstream_as, s->downstream,
> +                       "tz-mpc-downstream");
> +    address_space_init(&s->blocked_io_as, &s->blocked_io,
> +                       "tz-mpc-blocked-io");
> +}
> +
> +static const VMStateDescription tz_mpc_vmstate =3D {
> +    .name =3D "tz-mpc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property tz_mpc_properties[] =3D {
> +    DEFINE_PROP_LINK("downstream", TZMPC, downstream,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void tz_mpc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D tz_mpc_realize;
> +    dc->vmsd =3D &tz_mpc_vmstate;
> +    dc->reset =3D tz_mpc_reset;
> +    dc->props =3D tz_mpc_properties;
> +}
> +
> +static const TypeInfo tz_mpc_info =3D {
> +    .name =3D TYPE_TZ_MPC,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(TZMPC),
> +    .instance_init =3D tz_mpc_init,
> +    .class_init =3D tz_mpc_class_init,
> +};
> +
> +static void tz_mpc_iommu_memory_region_class_init(ObjectClass *klass,
> +                                                  void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate =3D tz_mpc_translate;
> +    imrc->attrs_to_index =3D tz_mpc_attrs_to_index;
> +    imrc->num_indexes =3D tz_mpc_num_indexes;
> +}
> +
> +static const TypeInfo tz_mpc_iommu_memory_region_info =3D {
> +    .name =3D TYPE_TZ_MPC_IOMMU_MEMORY_REGION,
> +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> +    .class_init =3D tz_mpc_iommu_memory_region_class_init,
> +};
> +
> +static void tz_mpc_register_types(void)
> +{
> +    type_register_static(&tz_mpc_info);
> +    type_register_static(&tz_mpc_iommu_memory_region_info);
> +}
> +
> +type_init(tz_mpc_register_types);
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41cd3736a9b..9b712b92021 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -449,6 +449,8 @@ F: hw/char/cmsdk-apb-uart.c
>  F: include/hw/char/cmsdk-apb-uart.h
>  F: hw/misc/tz-ppc.c
>  F: include/hw/misc/tz-ppc.h
> +F: hw/misc/tz-mpc.c
> +F: include/hw/misc/tz-mpc.h
> =20
>  ARM cores
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-soft=
mmu.mak
> index 8ba2558b36a..0f7dc2eb315 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -107,6 +107,7 @@ CONFIG_CMSDK_APB_UART=3Dy
>  CONFIG_MPS2_FPGAIO=3Dy
>  CONFIG_MPS2_SCC=3Dy
> =20
> +CONFIG_TZ_MPC=3Dy
>  CONFIG_TZ_PPC=3Dy
>  CONFIG_IOTKIT=3Dy
>  CONFIG_IOTKIT_SECCTL=3Dy
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index ec5a9f0da13..72bf9d57000 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -84,6 +84,13 @@ mos6522_set_sr_int(void) "set sr_int"
>  mos6522_write(uint64_t addr, uint64_t val) "reg=3D0x%"PRIx64 " val=3D0=
x%"PRIx64
>  mos6522_read(uint64_t addr, unsigned val) "reg=3D0x%"PRIx64 " val=3D0x=
%x"
> =20
> +# hw/misc/tz-mpc.c
> +tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC=
 regs read: offset 0x%x data 0x%" PRIx64 " size %u"
> +tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MP=
C regs write: offset 0x%x data 0x%" PRIx64 " size %u"
> +tz_mpc_mem_blocked_read(uint64_t addr, unsigned size, bool secure) "TZ=
 MPC blocked read: offset 0x%" PRIx64 " size %u secure %d"
> +tz_mpc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned size, =
bool secure) "TZ MPC blocked write: offset 0x%" PRIx64 " data 0x%" PRIx64=
 " size %u secure %d"
> +tz_mpc_translate(uint64_t addr, int flags, const char *idx, const char=
 *res) "TZ MPC translate: addr 0x%" PRIx64 " flags 0x%x iommu_idx %s: %s"
> +
>  # hw/misc/tz-ppc.c
>  tz_ppc_reset(void) "TZ PPC: reset"
>  tz_ppc_cfg_nonsec(int n, int level) "TZ PPC: cfg_nonsec[%d] =3D %d"
>=20
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
