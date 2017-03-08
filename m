Received: from eggs.gnu.org ([2001:4830:134:3::10]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clbj2-0006JB-JW
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clbiw-0007Zd-AO
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:33:56 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:49613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1clbiw-0007Xt-19
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:33:50 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 42DC934937
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 14:33:48 +0100 (CET)
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-5-git-send-email-clg@kaod.org>
	<081acbff-3179-96d8-a2d6-70fd79dda728@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2716b23b-7f8b-7c6d-651f-0515b1ff6bf7@kaod.org>
Date: Wed, 8 Mar 2017 14:33:36 +0100
MIME-Version: 1.0
In-Reply-To: <081acbff-3179-96d8-a2d6-70fd79dda728@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/8] ppc/pnv: add memory regions
 for the ICP registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03/08/2017 12:24 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 03/08/2017 07:52 AM, C=C3=A9dric Le Goater wrote:
>> This provides to a PowerNV chip (POWER8) access to the Interrupt
>> Management area, which contains the registers of the Interrupt Control
>> Presenters of each thread. These are used to accept, return, forward
>> interrupts in the system.
>>
>> This area is modeled with a per-chip container memory region holding
>> all the ICP registers. Each thread of a chip is then associated with
>> its ICP registers using a memory subregion indexed by its PIR number
>> in the overall region.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/pnv.c              |  20 +++++++
>>  hw/ppc/pnv_core.c         | 146 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/pnv.h      |  20 +++++++
>>  include/hw/ppc/pnv_core.h |   1 +
>>  include/hw/ppc/xics.h     |   3 +
>>  5 files changed, 190 insertions(+)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 461d3535e99c..7b13b08deadf 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -658,6 +658,16 @@ static void pnv_chip_init(Object *obj)
>>      object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
>>  }
>>
>> +static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
>> +{
>> +    char *name;
>> +
>> +    name =3D g_strdup_printf("icp-%x", chip->chip_id);
>> +    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_S=
IZE);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip->icp_mmio);
>> +    g_free(name);
>> +}
>> +
>>  static void pnv_chip_realize(DeviceState *dev, Error **errp)
>>  {
>>      PnvChip *chip =3D PNV_CHIP(dev);
>> @@ -680,6 +690,14 @@ static void pnv_chip_realize(DeviceState *dev, Er=
ror **errp)
>>      }
>>      sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
>>
>> +    /* Interrupt Management Area. This is the memory region holding
>> +     * all the Interrupt Control Presenter (ICP) registers */
>> +    pnv_chip_icp_realize(chip, &error);
>> +    if (error) {
>> +        error_propagate(errp, error);
>> +        return;
>> +    }
>> +
>>      /* Cores */
>>      pnv_chip_core_sanitize(chip, &error);
>>      if (error) {
>> @@ -709,6 +727,8 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
>>          object_property_set_int(OBJECT(pnv_core),
>>                                  pcc->core_pir(chip, core_hwid),
>>                                  "pir", &error_fatal);
>> +        object_property_add_const_link(OBJECT(pnv_core), "xics",
>> +                                       qdev_get_machine(), &error_fat=
al);
>>          object_property_set_bool(OBJECT(pnv_core), true, "realized",
>>                                   &error_fatal);
>>          object_unref(OBJECT(pnv_core));
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index d79d530b4881..8633afbff795 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -26,6 +26,128 @@
>>  #include "hw/ppc/pnv_core.h"
>>  #include "hw/ppc/pnv_xscom.h"
>>
>> +static uint64_t pnv_core_icp_read(void *opaque, hwaddr addr, unsigned=
 width)
>> +{
>> +    ICPState *icp =3D opaque;
>> +    bool byte0 =3D (width =3D=3D 1 && (addr & 0x3) =3D=3D 0);
>=20
> hard to read, an inline function should produce the same code at be mor=
e easily reviewable.

true. I can improve that if a resend is needed.

Thanks,

C.

>> +    uint64_t val =3D 0xffffffff;
>> +
>> +    switch (addr & 0xffc) {
>> +    case 0: /* poll */
>> +        val =3D icp_ipoll(icp, NULL);
>> +        if (byte0) {
>> +            val >>=3D 24;
>> +        } else if (width !=3D 4) {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 4: /* xirr */
>> +        if (byte0) {
>> +            val =3D icp_ipoll(icp, NULL) >> 24;
>> +        } else if (width =3D=3D 4) {
>> +            val =3D icp_accept(icp);
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 12:
>> +        if (byte0) {
>> +            val =3D icp->mfrr;
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 16:
>> +        if (width =3D=3D 4) {
>> +            val =3D icp->links[0];
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 20:
>> +        if (width =3D=3D 4) {
>> +            val =3D icp->links[1];
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 24:
>> +        if (width =3D=3D 4) {
>> +            val =3D icp->links[2];
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    default:
>> +bad_access:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XICS: Bad ICP access 0x%"
>> +                      HWADDR_PRIx"/%d\n", addr, width);
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void pnv_core_icp_write(void *opaque, hwaddr addr, uint64_t va=
l,
>> +                              unsigned width)
>> +{
>> +    ICPState *icp =3D opaque;
>> +    bool byte0 =3D (width =3D=3D 1 && (addr & 0x3) =3D=3D 0);
>> +
>> +    switch (addr & 0xffc) {
>> +    case 4: /* xirr */
>> +        if (byte0) {
>> +            icp_set_cppr(icp, val);
>> +        } else if (width =3D=3D 4) {
>> +            icp_eoi(icp, val);
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 12:
>> +        if (byte0) {
>> +            icp_set_mfrr(icp, val);
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 16:
>> +        if (width =3D=3D 4) {
>> +            icp->links[0] =3D val;
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 20:
>> +        if (width =3D=3D 4) {
>> +            icp->links[1] =3D val;
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    case 24:
>> +        if (width =3D=3D 4) {
>> +            icp->links[2] =3D val;
>> +        } else {
>> +            goto bad_access;
>> +        }
>> +        break;
>> +    default:
>> +bad_access:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XICS: Bad ICP access 0x%"
>> +                      HWADDR_PRIx"/%d\n", addr, width);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps pnv_core_icp_ops =3D {
>> +    .read =3D pnv_core_icp_read,
>> +    .write =3D pnv_core_icp_write,
>> +    .valid.min_access_size =3D 1,
>> +    .valid.max_access_size =3D 4,
>> +    .impl.min_access_size =3D 1,
>> +    .impl.max_access_size =3D 4,
>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>> +};
>> +
>>  static void powernv_cpu_reset(void *opaque)
>>  {
>>      PowerPCCPU *cpu =3D opaque;
>> @@ -129,6 +251,14 @@ static void pnv_core_realize_child(Object *child,=
 Error **errp)
>>      }
>>  }
>>
>> +static ICPState *xics_get_icp_per_pir(XICSFabric *xi, int pir)
>> +{
>> +    int index =3D xics_get_cpu_index_by_pir(pir);
>> +    assert(index !=3D -1);
>> +
>> +    return xics_icp_get(xi, index);
>> +}
>> +
>>  static void pnv_core_realize(DeviceState *dev, Error **errp)
>>  {
>>      PnvCore *pc =3D PNV_CORE(OBJECT(dev));
>> @@ -140,6 +270,14 @@ static void pnv_core_realize(DeviceState *dev, Er=
ror **errp)
>>      void *obj;
>>      int i, j;
>>      char name[32];
>> +    Object *xi;
>> +
>> +    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
>> +    if (!xi) {
>> +        error_setg(errp, "%s: required link 'xics' not found: %s",
>> +                   __func__, error_get_pretty(local_err));
>> +        return;
>> +    }
>>
>>      pc->threads =3D g_malloc0(size * cc->nr_threads);
>>      for (i =3D 0; i < cc->nr_threads; i++) {
>> @@ -169,6 +307,14 @@ static void pnv_core_realize(DeviceState *dev, Er=
ror **errp)
>>      snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
>>      pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), &pnv_core_xsc=
om_ops,
>>                            pc, name, PNV_XSCOM_EX_CORE_SIZE);
>> +
>> +    pc->icp_mmios =3D g_new0(MemoryRegion, cc->nr_threads);
>> +    for (i =3D 0; i < cc->nr_threads; i++) {
>> +        ICPState *icp =3D xics_get_icp_per_pir(XICS_FABRIC(xi), pc->p=
ir + i);
>> +        snprintf(name, sizeof(name), "icp-core.%d", cc->core_id);
>> +        memory_region_init_io(&pc->icp_mmios[i], OBJECT(dev),
>> +                              &pnv_core_icp_ops, icp, name, 0x1000);
>> +    }
>>      return;
>>
>>  err:
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index 6a0b004cea93..f11215ea31f2 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -55,6 +55,7 @@ typedef struct PnvChip {
>>      MemoryRegion xscom_mmio;
>>      MemoryRegion xscom;
>>      AddressSpace xscom_as;
>> +    MemoryRegion icp_mmio;
>>
>>      PnvLpcController lpc;
>>  } PnvChip;
>> @@ -130,4 +131,23 @@ typedef struct PnvMachineState {
>>  #define PNV_XSCOM_BASE(chip)                                         =
   \
>>      (chip->xscom_base + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZE)
>>
>> +/*
>> + * XSCOM 0x20109CA defines the ICP BAR:
>> + *
>> + * 0:29   : bits 14 to 43 of address to define 1 MB region.
>> + * 30     : 1 to enable ICP to receive loads/stores against its BAR r=
egion
>> + * 31:63  : Constant 0
>> + *
>> + * Usually defined as :
>> + *
>> + *      0xffffe00200000000 -> 0x0003ffff80000000
>> + *      0xffffe00600000000 -> 0x0003ffff80100000
>> + *      0xffffe02200000000 -> 0x0003ffff80800000
>> + *      0xffffe02600000000 -> 0x0003ffff80900000
>> + *
>> + * TODO: make a macro using the chip hw id
>> + */
>> +#define PNV_ICP_BASE(chip)   0x0003ffff80000000ull
>> +#define PNV_ICP_SIZE         0x0000000000100000ull
>> +
>>  #endif /* _PPC_PNV_H */
>> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
>> index 2955a41c901f..f2fad8f6361b 100644
>> --- a/include/hw/ppc/pnv_core.h
>> +++ b/include/hw/ppc/pnv_core.h
>> @@ -38,6 +38,7 @@ typedef struct PnvCore {
>>      uint32_t pir;
>>
>>      MemoryRegion xscom_regs;
>> +    MemoryRegion *icp_mmios;
>>  } PnvCore;
>>
>>  typedef struct PnvCoreClass {
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index c2032cac55f6..a3dcdf93bbe3 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -78,6 +78,9 @@ struct ICPState {
>>      bool cap_irq_xics_enabled;
>>
>>      XICSFabric *xics;
>> +
>> +    /* for the PowerNV ICP registers (not used by Linux). */
>> +    uint32_t links[3];
>>  };
>>
>>  #define TYPE_ICS_BASE "ics-base"
>>
