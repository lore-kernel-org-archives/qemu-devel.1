Received: from eggs.gnu.org ([2001:4830:134:3::10]:43054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRVdV-0000Ul-D5
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRVdR-0001pd-9H
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:05:41 -0500
Date: Wed, 20 Dec 2017 15:05:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171220040524.GB5981@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<2e44be300496e431ca22073c3431eb97a81ff86b.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <2e44be300496e431ca22073c3431eb97a81ff86b.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 15/17] ppc: add mvme3100 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:13PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  default-configs/ppc-softmmu.mak |   1 +
>  hw/ppc/Makefile.objs            |   1 +
>  hw/ppc/mvme3100.c               | 740 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/mvme3100_cpld.c          | 192 +++++++++++
>  4 files changed, 934 insertions(+)
>  create mode 100644 hw/ppc/mvme3100.c
>  create mode 100644 hw/ppc/mvme3100_cpld.c
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index bb225c6e46..3777194a4a 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -52,3 +52,4 @@ CONFIG_SERIAL_ISA=3Dy
>  CONFIG_MC146818RTC=3Dy
>  CONFIG_ISA_TESTDEV=3Dy
>  CONFIG_RS6000_MC=3Dy
> +CONFIG_DSRTCI2C=3Dy
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index c1a63d0c39..c1118aaa42 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -26,5 +26,6 @@ obj-$(CONFIG_MAC) +=3D mac_newworld.o
>  obj-$(CONFIG_E500) +=3D e500.o mpc8544ds.o e500plat.o
>  obj-$(CONFIG_E500) +=3D ppce500_spin.o
>  obj-$(CONFIG_E500) +=3D e500_ccsr.o
> +obj-$(CONFIG_E500) +=3D mvme3100.o mvme3100_cpld.o
>  # PowerPC 440 Xilinx ML507 reference board.
>  obj-$(CONFIG_XILINX) +=3D virtex_ml507.o
> diff --git a/hw/ppc/mvme3100.c b/hw/ppc/mvme3100.c
> new file mode 100644
> index 0000000000..8eb6a3a9a4
> --- /dev/null
> +++ b/hw/ppc/mvme3100.c
> @@ -0,0 +1,740 @@
> +/*
> + * MVME3100 board emulation
> + *
> + * Copyright (c) 2015 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + *
> + * This model was developed according to the
> + * MVME3100 Single Board Computer Programmer's Reference
> + * P/N: 6806800G37B
> + * July 2014
> + *
> + * mvme3100-1152
> + *   677MHz core, 256MB ram, 64MB flash
> + * mvme3100-1263
> + *   833MHz core, 512MB ram, 128MB flash
> + *
> + * MOTLoad on mvme3100-1152 says:
> + *   MPU-Type             =3DMPC8540
> + *   MPU-Int Clock Speed  =3D666MHz
> + *   MPU-CCB Clock Speed  =3D333MHz
> + *   MPU-DDR Clock Speed  =3D166MHz
> + *   MPU-PCI Clock Speed  =3D66MHz, PCI, 64-bit
> + *   MPU-Int Cache(L2) Enabled, 256KB, L2CTL =3DA8000300
> + *   Reset/Boot Vector    =3DFlash0
> + *   Local Memory Found   =3D10000000 (&268435456)
> + *
> + * MOTLoad on mvme3100-1263 says:
> + *   MPU-Type             =3DMPC8540
> + *   MPU-Int Clock Speed  =3D833MHz
> + *   MPU-CCB Clock Speed  =3D333MHz
> + *   MPU-DDR Clock Speed  =3D166MHz
> + *   MPU-PCI Clock Speed  =3D66MHz, PCI, 64-bit
> + *   MPU-Int Cache(L2) Enabled, 256KB, L2CTL =3DA8000300
> + *   Reset/Boot Vector    =3DFlash0
> + *   Local Memory Found   =3D20000000 (&536870912)
> + *
> + * Clock ratios
> + *   CCB/PCI  -> 5/1
> + *   core/CCB -> 2/1 (-1152)
> + *            -> 5/2 (-1263)
> + *
> + * The overall memory map is determined by the Local Address Windows.
> + * We do not model the LAWs explicitly.
> + *
> + * MOTLoad configures as follows (a super set of table 1-4)
> + *   (MOTLoad RTOS Version 2.0,  PAL Version 1.2 RM04)
> + * LAW 0, 7 - disabled
> + * LAW 1 - 0x00000000 -> 0x7fffffff - RAM 2G
> + * LAW 2 - 0x80000000 -> 0xbfffffff - PCI 1G
> + * LAW 3 - 0xc0000000 -> 0xdfffffff - PCI 512MB
> + * LAW 4 - 0xe0000000 -> 0xe0ffffff - PCI 16MB
> + * gap   - 0xe1000000 -> 0xbfffffff - CCSR @ 0xe1000000
> + * LAW 5 - 0xe2000000 -> 0xe2ffffff - LBC 16MB
> + * gap   - 0xe3000000 -> 0xefffffff
> + * LAW 6 - 0xf0000000 -> 0xffffffff - LBC 256MB
> + *
> + * And validated against the RTEMS 4.9.6 mvme3100 BSP
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "e500.h"
> +#include "cpu.h"
> +#include "qemu-common.h"
> +#include "cpu-qom.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/dma.h"
> +#include "sysemu/block-backend.h"
> +#include "hw/loader.h"
> +#include "hw/pci/pci.h"
> +#include "hw/boards.h"
> +#include "hw/ppc/ppc.h"
> +#include "hw/net/fsl_etsec/etsec.h"
> +#include "sysemu/device_tree.h"
> +#include "sysemu/qtest.h"
> +#include "hw/ppc/openpic.h"
> +#include "qemu/error-report.h"
> +
> +/* Same as prep.c and other PPC boards */
> +#define CFG_ADDR 0xf0000510
> +
> +#define TYPE_MVME3100 MACHINE_TYPE_NAME("mvme3100")
> +#define MVME3100(obj) OBJECT_CHECK(MVME3100State, (obj), TYPE_MVME3100)
> +#define MVME3100_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MVME3100Class, (obj), TYPE_MVME3100)
> +#define MVME3100_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(MVME3100Class, (klass), TYPE_MVME3100)
> +
> +#define E500_TSEC_OFFSET(N)     (0x24000 + (N) * 0x1000)
> +
> +/* Complex Core Bus frequency */
> +#define CCB_FREQ (333333333u)
> +
> +typedef struct mvme3100_info {
> +    const char *desc;
> +    uint32_t cpu_freq;
> +    uint32_t porpllsr;
> +    uint32_t ram_size;
> +} mvme3100_info;
> +typedef struct MVME3100Class {
> +    /*< private >*/
> +    MachineClass parent_class;
> +    /*< public >*/
> +
> +    const mvme3100_info *info;

I'm not seeing a lot of point to having this as a separate structure,
rather then embedding the fields directly in the MVME3100Class.

> +} MVME3100Class;
> +
> +typedef struct MVME3100State {
> +    /*< private >*/
> +    MachineState parent_obj;
> +    /*< public >*/
> +
> +    uint32_t load_address,
> +             entry_address;
> +
> +    MemoryRegion ram;
> +} MVME3100State;
> +
> +
> +/* motload "global environment" variables */
> +static
> +const char *gev[] =3D {
> +        /* TODO: somehow snoop in slirp_instances to pick up IP config? =
*/
> +        "mot-/dev/enet0-cipa=3D10.0.2.15",
> +        "mot-/dev/enet0-gipa=3D10.0.2.2",
> +        "mot-/dev/enet0-snma=3D255.255.255.0",
> +        "mot-/dev/enet0-sipa=3D10.0.2.2",

Right, it does look like these are things that the user might want to
configure.  I won't insist on that for an initial merge, though.

> +        /* RTEMS specific names for things motload doesn't have */
> +        "rtems-dns-server=3D10.0.2.3",
> +        "rtems-client-name=3Dqemu",
> +        NULL,
> +};
> +
> +/* Prepare Motorola Vital Product Data eeprom image.
> + * Provided to bootloader for use as a default.
> + *
> + * Begins with constant "MOTLOAD" followed by variable length records
> + * with a two byte header (ID code then body length in bytes).
> + *
> + * | ID | Length | body .... | repeated until ID=3D0xFF
> + *
> + * ID Codes:
> + *  1 - Product ID (string)
> + *  2 - Assembly # (string)
> + *  3 - Serial # (string)
> + *  5 - CPU Speed (Hz, 4 byte integer + 1 nil)
> + *  6 - Bus Speed (Hz, 4 byte integer + 1 nil)
> + *  8 - Ethernet MAC (6 bytes + 1 nil)
> + *  9 - CPU type
> + *  A - VPD CRC (4 bytes)
> + *  B - Flash Config (??)
> + *  E - L2 Cache Config (??)
> + *  F - VPD Version (4 bytes)
> + * 19 - L3 Cache Config (??)
> + * FF - End of VPD (size zero)
> + *
> + * Repeat entries for repeated units.  eg. two ID=3D0x8 for two NICs
> + *
> + * MOTLoad uses the same eeprom to hold it's user configuration
> + * Global Environment Variable (GEV) list.
> + */
> +typedef struct vpdeeprom {
> +    char * const base;
> +    char *cur;
> +    size_t total;
> +} vpdeeprom;
> +
> +static
> +void append_gev_vpd(vpdeeprom *vpd, const char *str)
> +{
> +    const size_t remaining =3D vpd->total - (vpd->cur - vpd->base),
> +                 len =3D strlen(str);

Just repeat the const size_t for the second declaration, it'll be
easier to read.

> +
> +    if ((len =3D=3D 0 && remaining < 1)
> +            || (remaining < len + 2))
> +    {

qemu style puts the { on the same line as the if.  Best run your whole
set through checkpatch.pl to catch other style errors.

> +        fprintf(stderr, "VPD GEV overflow\n");

Use error_report() please.  Or even error_setg() and add an Error **
parmaeter to this function (letting the caller decide whether it
should be fatal or not).

> +        return;
> +    }
> +
> +    memcpy(vpd->cur, str, len + 1);
> +
> +    vpd->cur +=3D len + 1;
> +}
> +
> +static
> +void append_vpd(vpdeeprom *vpd, uint8_t id, size_t cnt, const void *val)
> +{
> +    const size_t remaining =3D vpd->total - (vpd->cur - vpd->base);
> +
> +    /* must have enough space for this entry and final ID=3D0xff */
> +    if ((id =3D=3D 0xff && remaining < 2)
> +            || (remaining + 4 < cnt || cnt > 255))

Odd bracketing here.  || is associative, so the () around the last two
clauses looks redundant.

> +    {
> +        fprintf(stderr, "VPD overflow\n");
> +        return;
> +    }
> +
> +    vpd->cur[0] =3D id;
> +    vpd->cur[1] =3D cnt;
> +    memcpy(vpd->cur + 2, val, cnt);
> +
> +    vpd->cur +=3D 2 + cnt;
> +}
> +
> +static
> +void append_string_vpd(vpdeeprom *vpd, uint8_t id, const char *str)
> +{
> +    /* include trailing nil */
> +    append_vpd(vpd, id, strlen(str) + 1, str);
> +}
> +
> +static
> +void append_mac_vpd(vpdeeprom *vpd, uint8_t id, const MACAddr *addr)
> +{
> +    char buf[7];
> +    memcpy(buf, addr->a, 6);
> +    buf[6] =3D 0;
> +
> +    append_vpd(vpd, id, 7, buf);
> +}
> +
> +static
> +void append_u32_vpd(vpdeeprom *vpd, uint8_t id, uint32_t val)
> +{
> +    union {
> +        uint32_t ival;
> +        char bytes[5]; /* include trailing nil */
> +    } buf;
> +    buf.ival =3D cpu_to_be32(val);
> +    buf.bytes[4] =3D 0;
> +
> +    append_vpd(vpd, id, 5, buf.bytes);
> +}
> +
> +static
> +void build_vpd(const mvme3100_info *info, char *buf, size_t cnt,
> +               const char *extra)
> +{
> +    vpdeeprom vpd =3D {buf, buf, cnt};
> +    size_t i;
> +
> +    memset(buf, 0, cnt);
> +
> +    strcpy(buf, "MOTOROLA");
> +    vpd.cur +=3D 8;
> +
> +    /* Product ID (eg. "MVME3100-1152") */
> +    append_string_vpd(&vpd, 1, info->desc);
> +
> +    /* serial number */
> +    append_string_vpd(&vpd, 3, "E0120000");

Giving a fixed serial number seems a bit bogus.  Could you derive this
=66rom the qemu instance UUID, maybe?

> +    /* CPU Freq. */
> +    append_u32_vpd(&vpd, 5, info->cpu_freq);
> +
> +    /* PCI Bus Freq. */
> +    append_u32_vpd(&vpd, 6, 66666666);
> +
> +    for (i =3D 0; i < MAX_NICS; i++) {
> +        if (nd_table[i].used) {
> +            append_mac_vpd(&vpd, 8, &nd_table[i].macaddr);
> +        }
> +    }
> +
> +    append_vpd(&vpd, 0xff, 0, NULL);
> +
> +    if (vpd.cur - vpd.base > 0x10f8) {
> +        fprintf(stderr, "VPD overflows GEV area.\n");
> +        return;
> +    }
> +
> +    /* MOTLOAD's Global Environment Variables
> +     * start at offset 0x10f8.
> +     * This is a set of nil terminated strings of the form "name=3Dvalue"
> +     * with a zero length string signaling the end.
> +     */
> +    vpd.cur =3D vpd.base + 0x10f8;
> +
> +    for (i =3D 0; gev[i]; i++) {
> +        append_gev_vpd(&vpd, gev[i]);
> +    }
> +
> +    if (extra) {
> +        char *E =3D g_strdup(extra);
> +        char **opts =3D g_strsplit(E, " ", 0);

IIRC g_strsplit() is non destructive on the input, so you shouldn't
need the E temporary.

> +        size_t i;
> +
> +        g_free(E);
> +
> +        for (i =3D 0; opts[i]; i++) {
> +            char *opt =3D g_strstrip(opts[i]);
> +            size_t olen =3D strlen(opt);
> +
> +            if (olen =3D=3D 0) {
> +                continue;
> +            } else if (!strchr(opt, '=3D')) {
> +                fprintf(stderr, "Missing '=3D' in -append %s\n", extra);
> +                continue;
> +            }
> +
> +            append_gev_vpd(&vpd, opt);
> +        }
> +
> +        g_strfreev(opts);
> +    }
> +
> +    /* zero length string signals end */
> +    append_gev_vpd(&vpd, "");
> +}
> +
> +static
> +void set_map(CPUPPCState *env, unsigned way,
> +             target_ulong va, hwaddr pa,
> +             unsigned size)
> +{
> +    ppcmas_tlb_t *tlb =3D booke206_get_tlbm(env, 1, 0, way);
> +
> +    tlb->mas1 =3D MAS1_VALID | (size << MAS1_TSIZE_SHIFT);
> +    tlb->mas2 =3D (va & TARGET_PAGE_MASK) | MAS2_I | MAS2_G;
> +    tlb->mas7_3 =3D (pa & TARGET_PAGE_MASK) | MAS3_SR | MAS3_SW | MAS3_S=
X;
> +}
> +
> +static
> +void remap_tlb_bare(CPUPPCState *env)
> +{
> +    /* The MPC8540 ref. manual says only the upper 4KB (ROM)
> +     * is mapped, but doesn't say exactly how this mapping
> +     * is setup.  So we arbitrarily decide to use TLB1 entry 0.
> +     */
> +    set_map(env, 0, 0xfffff000, 0xfffff000, 0x02);
> +
> +    env->tlb_dirty =3D true;
> +}
> +
> +static void mvme3100_cpu_reset(void *opaque)
> +{
> +    PowerPCCPU *cpu =3D opaque;
> +    CPUState *cs =3D CPU(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    cpu_reset(cs);
> +
> +    /* HID0 clock control functions not modeled.
> +     * Decrementer always enabled with CCB/8 as reference.
> +     * HID0[EMCP] and HID0[TBEN] set
> +     */
> +    env->spr[SPR_HID0] |=3D 0x80004000;
> +
> +    remap_tlb_bare(&cpu->env);
> +    env->nip =3D 0xfffffffc;
> +}
> +
> +static
> +void mvme3100_pci1_set_irq(void *opaque, int irq_num, int level)
> +{
> +    qemu_irq *pic =3D opaque;
> +
> +    qemu_set_irq(pic[irq_num], level);
> +}
> +
> +/* PCI config from a real mvme3100 as configured by motload
> + *
> + *  BUS:SLOT:FUN  VENDOR-DEV_ID: COMMAND STATUS BASE_ADDR0 BASE_ADDR1 IR=
Q_PIN -> IRQ_LINE
> + *  0:0x00:0    0x1057-0x0008:  0x0006 0x20B0 0x80000000 0x00000000     =
  0 ->   0 (=3D0x00)
> + *  0:0x11:0    0x10E3-0x0148:  0x0146 0x02B0 0x80100004 0x00000000     =
  1 ->   0 (=3D0x00)
> + *  0:0x12:0    0x10B5-0x6520:  0x0147 0x02B0 0x00000000 0x00000000     =
  0 ->   0 (=3D0x00)
> + *  0:0x13:0    0x10B5-0x6520:  0x0147 0x02B0 0x00000000 0x00000000     =
  0 ->   0 (=3D0x00)
> + *  0:0x14:0    0x8086-0x3200:  0x0145 0x02B0 0x00012001 0x00013001     =
  1 ->   2 (=3D0x02)
> + *  2:0x00:0    0x1033-0x0035:  0x0146 0x0210 0x80300000 0x00000000     =
  1 ->   4 (=3D0x04)
> + *  2:0x00:1    0x1033-0x0035:  0x0146 0x0210 0x80301000 0x00000000     =
  2 ->   5 (=3D0x05)
> + *
> + * The modeled PCI host bridge differs.
> + *
> + * We model one PCI-PCI bridge (0:0x12:0) but with a different vendor/de=
vice
> + *
> + * We don't model:
> + * # The SATA controller GD31244 (0x8086-0x3200)
> + * # The USB (OHCI) controller uPD740101 (0x1033-0x0035)
> + * # The second PCI-PCI bridge (0:0x13:0) in front of the USB controllers
> + *
> + * (Note that the SATA controller found on newer boards is different)
> + */
> +
> +static void mvme3100_init(MachineState *machine)
> +{
> +    MVME3100State *mvme3100 =3D MVME3100(machine);
> +    const mvme3100_info *info;
> +    DeviceState *dev;
> +    BusState *i2c;
> +    PCIBus *pci0, *pci1;
> +    SysBusDevice *cpld, *pic;
> +    qemu_irq *pci1_pins =3D g_malloc_n(4, sizeof(*pci1_pins));
> +    FWCfgState *fwinfo;
> +    DriveInfo *drvinfo;
> +    MemoryRegion *ccsr;
> +
> +    {
> +        MVME3100Class *klass =3D MVME3100_GET_CLASS(machine);
> +        info =3D klass->info;
> +    }
> +
> +    /* Setup CPU */
> +
> +    ppce500_init(machine, CCB_FREQ / 8u);
> +
> +    memory_region_allocate_system_memory(&mvme3100->ram, NULL,
> +                                         "mvme3100.ram", ram_size);
> +    memory_region_add_subregion(get_system_memory(), 0, &mvme3100->ram);
> +
> +    qemu_register_reset(mvme3100_cpu_reset, POWERPC_CPU(first_cpu));
> +
> +    /* Create CCSR and builtin periphrials */
> +    dev =3D qdev_create(NULL, "e500-ccsr");
> +    object_property_add_child(qdev_get_machine(), "e500-ccsr",
> +                              OBJECT(dev), NULL);
> +    qdev_prop_set_uint32(dev, "ccb-freq", CCB_FREQ);
> +    qdev_prop_set_uint32(dev, "mpic-model", OPENPIC_MODEL_FSL_MPIC_20);
> +    qdev_prop_set_uint32(dev, "porpllsr", info->porpllsr);
> +    qdev_prop_set_uint32(dev, "base", 0xff700000ULL);
> +    qdev_prop_set_uint32(dev, "ram-size", ram_size);
> +    qdev_prop_set_uint32(dev, "pci_first_slot", 0);
> +    qdev_prop_set_uint32(dev, "pci_first_pin_irq", 1);
> +    qdev_init_nofail(dev);
> +
> +    ccsr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +
> +    pic =3D SYS_BUS_DEVICE(object_resolve_path("/machine/pic", NULL));
> +
> +    /* Setup mvme3100 specific CPLD device */
> +    cpld =3D SYS_BUS_DEVICE(qdev_create(NULL, "mvme3100-cpld"));
> +    object_property_add_child(qdev_get_machine(), "cpld",
> +                              OBJECT(cpld), &error_fatal);
> +    qdev_init_nofail(DEVICE(cpld));
> +
> +    memory_region_add_subregion(get_system_memory(),
> +                                0xe2000000,
> +                                sysbus_mmio_get_region(cpld, 0));
> +
> +    fwinfo =3D fw_cfg_init_mem(CFG_ADDR, CFG_ADDR + 2);
> +    fw_cfg_add_i16(fwinfo, FW_CFG_NB_CPUS, 1);
> +    fw_cfg_add_i16(fwinfo, FW_CFG_MAX_CPUS, 1);
> +    fw_cfg_add_i64(fwinfo, FW_CFG_RAM_SIZE, machine->ram_size);
> +
> +    dev =3D DEVICE(object_resolve_path("/machine/pci-host", NULL));
> +    assert(dev);
> +    pci0 =3D PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
> +    assert(pci0);
> +
> +    /* Add expansion PCI bus (2x PMC sites)
> +     * "pci-bridge" is not a PLX bridge, but shouldn't matter?
> +     */
> +    dev =3D qdev_create(BUS(pci0), "pci-bridge");
> +
> +    qdev_prop_set_uint8(dev, "chassis_nr", 1);
> +    qdev_prop_set_int32(dev, "addr", PCI_DEVFN(0x12, 0));
> +
> +    qdev_init_nofail(dev);
> +
> +    pci1 =3D PCI_BUS(qdev_get_child_bus(dev, "pci.1"));
> +    assert(pci1);
> +
> +    pci1_pins[0] =3D qdev_get_gpio_in(DEVICE(pic), 4);
> +    pci1_pins[1] =3D qdev_get_gpio_in(DEVICE(pic), 5);
> +    pci1_pins[2] =3D qdev_get_gpio_in(DEVICE(pic), 6);
> +    pci1_pins[3] =3D qdev_get_gpio_in(DEVICE(pic), 7);
> +
> +    pci_bus_irqs(pci1, mvme3100_pci1_set_irq,
> +                 pci_swizzle_map_irq_fn, pci1_pins, 4);
> +
> +    /* the actual PLX bridge doesn't emit interrupts */
> +    pci_set_byte(PCI_DEVICE(dev)->config + PCI_INTERRUPT_PIN, 0);
> +
> +    /* root bus is only home to soldered devices, and has a
> +     * an arbitrary IRQ pin mapping.
> +     * Don't allow qdev_device_add() to consider it.
> +     */
> +    {
> +        BusState *bpci0 =3D BUS(pci0);
> +        BusClass *bcls  =3D BUS_GET_CLASS(pci0);
> +        assert(bpci0);

I think the BUS() macro will already abort() if pci0 is NULL or not a
BUS.

> +        /* bus 0 is thus declared to be full.
> +         * as a side-effect, expansion PCI bus limited to 15 devices
> +         */
> +        bpci0->max_index =3D bcls->max_dev =3D 15;
> +    }
> +
> +    /* I2C Controller */
> +    dev =3D DEVICE(object_resolve_path("/machine/i2c[0]", NULL));
> +    assert(dev);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(DEVICE(pic), 16 + 27));
> +    i2c =3D qdev_get_child_bus(dev, "bus");
> +    assert(i2c);
> +
> +    /* NIC (2x TSEC and 1x FEC) */
> +    if (nd_table[0].used) {
> +        qemu_check_nic_model(&nd_table[0], "eTSEC");
> +
> +        dev =3D etsec_create(E500_TSEC_OFFSET(0), ccsr, &nd_table[0],
> +                qdev_get_gpio_in(DEVICE(pic), 16 + 13),
> +                qdev_get_gpio_in(DEVICE(pic), 16 + 14),
> +                qdev_get_gpio_in(DEVICE(pic), 16 + 18));
> +
> +    } else if (nd_table[1].used) {
> +        qemu_check_nic_model(&nd_table[1], "eTSEC");
> +
> +        dev =3D etsec_create(E500_TSEC_OFFSET(1), ccsr, &nd_table[1],
> +                qdev_get_gpio_in(DEVICE(pic), 16 + 19),
> +                qdev_get_gpio_in(DEVICE(pic), 16 + 20),
> +                qdev_get_gpio_in(DEVICE(pic), 16 + 23));
> +
> +    } else if (nd_table[2].used) {
> +        qemu_log_mask(LOG_UNIMP, "FEC (ethernet #3) not modeled\n");
> +    }
> +
> +    /* VPD EEPROM */
> +    dev =3D qdev_create(i2c, "at24c-eeprom");
> +    object_property_add_child(qdev_get_machine(), "vpd", OBJECT(dev),
> +                              &error_fatal);
> +    qdev_prop_set_uint8(dev, "address", 0xa8 >> 1);
> +    qdev_prop_set_uint32(dev, "rom-size", 8192 * 8);
> +
> +    drvinfo =3D drive_get(IF_PFLASH, 0, 0);
> +    if (drvinfo) {
> +        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(drvinfo),
> +                            &error_fatal);
> +    }
> +
> +    qdev_init_nofail(dev);
> +
> +    {
> +        char *buf;
> +
> +        buf =3D g_malloc0(8192 * 8);
> +
> +        build_vpd(info, buf, 8192 * 8, machine->kernel_cmdline);
> +
> +        fw_cfg_add_file(fwinfo, "tomload/vpd", buf, 8192 * 8);
> +    }
> +
> +    /* DS1375 RTC */
> +    dev =3D qdev_create(i2c, "ds1375");
> +    object_property_add_child(qdev_get_machine(), "rtc", OBJECT(dev),
> +                              &error_fatal);
> +    qdev_prop_set_uint8(dev, "address", 0xd0 >> 1);
> +    qdev_init_nofail(dev);
> +    qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(DEVICE(pic), 11));
> +
> +    /* TODO: unmodeled i2c devices.
> +     * 0x90 - ds1621 temperature sensor
> +     * 0xa0 - 256*8 byte DDR SPD (???)
> +     * 0xa4 - 64k*8 byte eeprom for "user" configuration
> +     * 0xa6 - 64k*8 byte eeprom for "user" configuration
> +     * 0xaa -  8k*8 byte eeprom for VPD of rear expansion card
> +     */
> +
> +    if (!bios_name) {
> +        bios_name =3D "tomload.bin";
> +    }
> +
> +    if (!qtest_enabled()) {
> +        MemoryRegion *rom =3D g_malloc0(sizeof(*rom));
> +        char *fullname =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name=
);
> +
> +        if (!fullname) {
> +            fprintf(stderr, "qemu: could not find bios file '%s'\n",
> +                    bios_name);
> +            exit(1);
> +        }
> +
> +        memory_region_init_ram(rom, OBJECT(cpld), "rom",
> +                               0x800000, &error_fatal);
> +
> +        memory_region_add_subregion(get_system_memory(),
> +                                    0xff800000, rom);
> +
> +        /* BIOS =3D=3D image in rom (last 8MB of address space).
> +         * Execution starts with the final word 0xfffffffc
> +         */
> +        int bsize =3D get_image_size(fullname);
> +        if (bsize !=3D 8 * 1024 * 1024 ||
> +                -1 =3D=3D load_image_targphys(fullname,
> +                                          0xff800000, 8 * 1024 * 1024))
> +        {
> +            fprintf(stderr, "qemu: could not load bios file '%s'"
> +                            " (%u bytes, requires 8MB)\n",
> +                    fullname, (unsigned)bsize);
> +            exit(1);
> +        }
> +
> +        memory_region_set_readonly(rom, true);
> +
> +        g_free(fullname);
> +    }
> +
> +    {
> +        hwaddr image_addr =3D mvme3100->load_address;
> +
> +        int image_size =3D load_image_targphys(machine->kernel_filename,
> +                                             image_addr, 0x01000000);
> +        if (machine->kernel_filename &&
> +                -1 =3D=3D image_size)
> +        {
> +            fprintf(stderr, "qemu: could not load file '%s'\n",
> +                    machine->kernel_filename);
> +            exit(1);
> +
> +        } else if (mvme3100->entry_address =3D=3D 0) {
> +            mvme3100->entry_address =3D image_addr;
> +
> +        } else if (mvme3100->entry_address < image_addr
> +                  || mvme3100->entry_address >=3D image_addr + image_siz=
e)
> +        {
> +            fprintf(stderr, "qemu: entry-address out of range\n");
> +            exit(1);
> +        }
> +
> +        if (machine->kernel_cmdline) {
> +            fw_cfg_add_i32(fwinfo, FW_CFG_CMDLINE_SIZE,
> +                           strlen(machine->kernel_cmdline) + 1);
> +            fw_cfg_add_string(fwinfo, FW_CFG_CMDLINE_DATA,
> +                              machine->kernel_cmdline);
> +        }
> +
> +        fw_cfg_add_i32(fwinfo, FW_CFG_KERNEL_ADDR, image_addr);
> +        fw_cfg_add_i32(fwinfo, FW_CFG_KERNEL_ENTRY, mvme3100->entry_addr=
ess);
> +        fw_cfg_add_i32(fwinfo, FW_CFG_KERNEL_SIZE, image_size);
> +    }
> +}
> +
> +static void mvme3100_inst_init(Object *obj)
> +{
> +    MVME3100State *mvme3100 =3D MVME3100(obj);
> +    mvme3100->load_address =3D 0x10000;
> +    mvme3100->entry_address =3D 0;
> +}
> +
> +static void mvme3100_visit_addr(Object *obj,
> +                                Visitor *v,
> +                                const char *name,
> +                                void *opaque,
> +                                Error **errp)
> +{
> +    MVME3100State *mvme3100 =3D MVME3100(obj);
> +    uint32_t *ptr;
> +
> +    if (strcmp(name, "load-address") =3D=3D 0) {
> +        ptr =3D &mvme3100->load_address;
> +    } else if (strcmp(name, "entry-address") =3D=3D 0) {
> +        ptr =3D &mvme3100->entry_address;
> +    } else {
> +        fprintf(stderr, "logic error: mvme3100 has no prop '%s'\n", name=
);
> +        exit(1);
> +    }
> +
> +    visit_type_uint32(v, name, ptr, errp);
> +}
> +
> +static void ppce500_machine_class_init(ObjectClass *klass, void *raw)
> +{
> +    mvme3100_info *info =3D raw;
> +    MachineClass *mc =3D MACHINE_CLASS(klass);
> +    MVME3100Class *m3c =3D MVME3100_CLASS(klass);
> +
> +    m3c->info =3D info;
> +
> +    mc->desc =3D info->desc;
> +    mc->init =3D mvme3100_init;
> +    mc->max_cpus =3D 1;
> +    mc->default_ram_size =3D info->ram_size;
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("mpc8540_v21");
> +
> +    object_class_property_add(OBJECT_CLASS(mc), "load-address", "uint32",
> +                              &mvme3100_visit_addr, &mvme3100_visit_addr=
, NULL,
> +                              NULL, &error_fatal);
> +    object_class_property_add(OBJECT_CLASS(mc), "entry-address", "uint32=
",
> +                              &mvme3100_visit_addr, &mvme3100_visit_addr=
, NULL,
> +                              NULL, &error_fatal);
> +}
> +
> +static const TypeInfo mvme3100_type =3D {
> +    .abstract =3D true,
> +    .name =3D TYPE_MVME3100,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(MVME3100State),
> +    .instance_init =3D mvme3100_inst_init,
> +    .class_size =3D sizeof(MVME3100Class),
> +};
> +
> +static mvme3100_info mvme3100_1152 =3D {
> +    .desc =3D "MVME3100-1152",
> +    .cpu_freq =3D 666666666u,
> +    /* CCB/PCI  -> 5/1
> +     * core/CCB -> 2/1
> +     *
> +     * plat ratio =3D 5 -> 5:1 CCB:PCI
> +     * e500 ratio =3D 4 -> 4:1 e500:CCB
> +     */
> +    .porpllsr =3D 0x0004000a,
> +    .ram_size =3D 256 * (1 << 20),
> +};
> +
> +static const TypeInfo mvme3100_1152_type =3D {
> +    .name =3D MACHINE_TYPE_NAME("mvme3100-1152"),
> +    .parent =3D TYPE_MVME3100,
> +    .class_init =3D ppce500_machine_class_init,
> +    .class_data =3D &mvme3100_1152,
> +};
> +
> +static mvme3100_info mvme3100_1263 =3D {
> +    .desc =3D "MVME3100-1263",
> +    .cpu_freq =3D 833333333u,
> +    /* CCB/PCI  -> 5/1
> +     * core/CCB -> 5/2
> +     */
> +    .porpllsr =3D 0x0005000a,
> +    .ram_size =3D 512 * (1 << 20),
> +};
> +
> +static const TypeInfo mvme3100_1263_type =3D {
> +    .name =3D MACHINE_TYPE_NAME("mvme3100-1263"),
> +    .parent =3D TYPE_MVME3100,
> +    .class_init =3D ppce500_machine_class_init,
> +    .class_data =3D &mvme3100_1263,
> +};
> +
> +static void mvme3100_machine_init(void)
> +{
> +    type_register_static(&mvme3100_type);
> +    type_register_static(&mvme3100_1152_type);
> +    type_register_static(&mvme3100_1263_type);
> +}
> +
> +type_init(mvme3100_machine_init)
> diff --git a/hw/ppc/mvme3100_cpld.c b/hw/ppc/mvme3100_cpld.c
> new file mode 100644
> index 0000000000..41024566ce
> --- /dev/null
> +++ b/hw/ppc/mvme3100_cpld.c
> @@ -0,0 +1,192 @@
> +/*
> + * MVME3100 board CPLD (local logic)
> + *
> + * Copyright (c) 2015 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + *
> + * This model was developed according to the
> + * MVME3100 Single Board Computer Programmer's Reference
> + * P/N: 6806800G37B
> + * July 2014
> + *
> + * And validated against the RTEMS 4.9.6 mvme3100 BSP
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "exec/address-spaces.h"
> +#include "qemu-common.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/sysbus.h"
> +
> +/* #define DEBUG_3100CPLD */
> +
> +#define TYPE_CPLD "mvme3100-cpld"
> +
> +#define CPLD(obj) OBJECT_CHECK(MVMECPLD, (obj), TYPE_CPLD)
> +
> +#ifdef DEBUG_3100CPLD
> +#define DPRINTK(FMT, ...) printf(TYPE_CPLD " : " FMT, ## __VA_ARGS__)
> +#else
> +#define DPRINTK(FMT, ...) do {} while (0)
> +#endif
> +
> +#define LOG(MSK, FMT, ...) qemu_log_mask(MSK, TYPE_CPLD " : " FMT, \
> +    ## __VA_ARGS__)
> +
> +#define CPLD_SIZE 0x20
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +
> +    uint8_t mem[0x10];
> +    uint32_t test;
> +
> +    MemoryRegion mmio;
> +} MVMECPLD;
> +
> +static
> +uint64_t cpld_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    MVMECPLD *self =3D opaque;
> +    uint32_t offset =3D addr;
> +    uint32_t val, A;
> +
> +    switch (offset) {
> +    case 1 ... 0xf:
> +        val =3D 0;
> +        A =3D offset;
> +        while (size--) {
> +            val <<=3D 8;
> +            val |=3D self->mem[A++];
> +        }
> +        break;
> +    case 0x10:
> +        val =3D self->test;
> +        break;
> +    case 0x14:
> +        val =3D ~self->test;
> +        break;
> +    default:
> +        LOG(LOG_UNIMP, "read from unimplimented register %08x\n",
> +            (unsigned)offset);
> +        val =3D 0;
> +    }
> +
> +    DPRINTK("read %08x -> %08x\n", (unsigned)offset, (unsigned)val);
> +
> +    return val;
> +}
> +
> +static
> +void cpld_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    MVMECPLD *self =3D opaque;
> +    uint32_t offset =3D addr;
> +
> +    DPRINTK("write %08x <- %08x\n", (unsigned)offset, (unsigned)val);
> +
> +    switch (offset) {
> +    case 0:
> +        break;
> +    case 1:
> +        /* TODO: TSTAT_MASK and EEPROM_WPEEPROM */
> +        if ((val & 0xe0) =3D=3D 0xa0) {
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        }
> +        self->mem[offset >> 2] =3D val & 0x3;
> +        break;
> +    case 2:
> +        self->mem[offset >> 2] =3D val & 0xf;
> +        break;
> +    case 3:
> +        self->mem[offset >> 2] =3D val & 0x18;
> +        break;
> +    case 4 ... 9:
> +        break;
> +    case 10 ... 13:
> +        /* TODO: allow date to be changed? */
> +        break;
> +    case 0x10:
> +        self->test =3D val;
> +        break;
> +    case 0x11:
> +        self->test =3D ~val;
> +        break;
> +    default:
> +        LOG(LOG_UNIMP, "write to unimplimented register %08x\n",
> +            (unsigned)offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps cpld_ops =3D {
> +    .read =3D cpld_read,
> +    .write =3D cpld_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +static
> +void mvme3100_cpld_realize(DeviceState *dev, Error **errp)
> +{
> +    MVMECPLD *self =3D CPLD(dev);
> +
> +    memory_region_init_io(&self->mmio, OBJECT(self), &cpld_ops, self,
> +                          TYPE_CPLD, CPLD_SIZE);
> +
> +    sysbus_init_mmio(&self->parent_obj, &self->mmio);
> +}
> +
> +static Property mvme3100_cpld_props[] =3D {
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static
> +void mvme3100_cpld_reset(DeviceState *dev)
> +{
> +    MVMECPLD *self =3D CPLD(dev);
> +
> +    self->mem[0] =3D 0; /* Type VME SBC, SAFE_START=3D=3D0 */
> +    self->mem[1] =3D 3;
> +    self->mem[2] =3D 1;
> +    self->mem[3] =3D 9;
> +    self->mem[4] =3D 9;
> +    self->mem[5] =3D 0xa9;
> +    self->mem[6] =3D 1;
> +    self->mem[7] =3D 0xe0; /* TODO, TSEC phy irq status */
> +    self->mem[8] =3D 1; /* TODO: PMC presence ...? */
> +    self->mem[9] =3D 1; /* TODO: real rev. # */
> +    self->mem[10] =3D 15; /* TODO: real date code */
> +    self->mem[11] =3D 11;
> +    self->mem[12] =3D 14;
> +    self->mem[13] =3D 1;
> +    self->test =3D 0;
> +}
> +
> +static
> +void mvme3100_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D &mvme3100_cpld_realize;
> +    dc->reset =3D &mvme3100_cpld_reset;
> +    dc->desc =3D "mvme3100 CPLD logic";
> +    dc->props =3D mvme3100_cpld_props;
> +}
> +
> +static const TypeInfo mvme3100_cpld_info =3D {
> +    .name =3D TYPE_CPLD,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(MVMECPLD),
> +    .class_size =3D sizeof(SysBusDeviceClass),
> +    .class_init =3D mvme3100_class_init,
> +};
> +
> +static
> +void mvme3100_cpld_register(void)
> +{
> +    type_register_static(&mvme3100_cpld_info);
> +}
> +
> +type_init(mvme3100_cpld_register)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo54YEACgkQbDjKyiDZ
s5LVjRAAmaRinPnb/uQ38HjAxZ6sb2q/nMZP7HRpG+6ZwQiaZAYFjPnHp+Oaue8J
WIl1wMuVPjLZPvY97ij76+VznGy4W7R0Ld1fi6QTOqmxKJx4oAwu6ESawATPeJCP
WMfM3O1pJ4tF84oXj5WHuEBkIQ8sieffnfiz8483fNhpcTTVNW9knoMdBpHiwVv3
a/q5+VwCq7vbs/7dUElGr0PmoW/JPwhwmm/A+4lkv4LGWjaBJl79s/UhygiaX96u
yKJRabHd4/XMn6uziQK4QB2W1Ss1u1Z8Q6sFnXLp2CVVa+D3Um9ocboaa/rrTIpI
vtBLFsYCxw4vlXcyNofMKT6Du0VH4Du8avMHMlrtFkfW7Am49BA3SDw9MGDttGRw
NvnhXruwy4NNv/mPmunmU/KHd51h8XK+JQ2NTsRb1cTORJLsMOgpknYIEuS5IdAK
M7utIrUlav9IYjzw+JQZemPTImsYGVv8gsKgcqDNAj0j6PUrQbgiSMnXFIxbi4LP
ek7mBFLwCE3Dc5e+LVozYFQ7scZgtdl9P5EV77SH9+frkLewrCDvBNhgOXEoQB70
J7obtzogElVqj8bSBDEPLEWTsI8H3TNJ7v7a9q6TZ77+j20/BTTSgsdyCrj+cmQb
diGfGMb4D/6Q/QgodBKVgh3NvMbCmeTkkdwAjU2/L5+3tFaSbFc=
=zV4n
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
