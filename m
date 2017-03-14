Received: from eggs.gnu.org ([2001:4830:134:3::10]:43108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cnjHr-0002wq-8T
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cnjHm-0002Tx-9P
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:02:39 -0400
Received: from mo3.mail-out.ovh.net ([178.32.228.3]:38715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cnjHl-0002TP-Vg
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:02:34 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 72188B6A0D
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 11:02:32 +0100 (CET)
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-6-git-send-email-clg@kaod.org>
	<20170314055245.GL12564@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2db92f23-c8f8-69ed-20c5-f16ea1e5c6a7@kaod.org>
Date: Tue, 14 Mar 2017 11:02:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170314055245.GL12564@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 5/8] ppc/pnv: map the ICP memory
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03/14/2017 06:52 AM, David Gibson wrote:
> On Wed, Mar 08, 2017 at 11:52:48AM +0100, C=E9dric Le Goater wrote:
>> and populate the device tree accordingly for the guest to start using
>> interrupts. This also links the ICP object to its associated CPUState
>> (only used by KVM to control the kernel vCPU).
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/pnv.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  hw/ppc/pnv_core.c | 12 ++++++++----
>>  2 files changed, 63 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 7b13b08deadf..0ae11cc3a2ca 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -35,6 +35,7 @@
>>  #include "monitor/monitor.h"
>>  #include "hw/intc/intc.h"
>> =20
>> +#include "hw/ppc/xics.h"
>>  #include "hw/ppc/pnv_xscom.h"
>> =20
>>  #include "hw/isa/isa.h"
>> @@ -216,6 +217,47 @@ static void powernv_create_core_node(PnvChip *chi=
p, PnvCore *pc, void *fdt)
>>                         servers_prop, sizeof(servers_prop))));
>>  }
>> =20
>> +static void powernv_populate_icp(PnvChip *chip, void *fdt, int offset=
,
>> +                          uint32_t pir, uint32_t count)
>> +{
>> +    uint64_t addr;
>> +    char *name;
>> +    const char compat[] =3D "IBM,power8-icp\0IBM,ppc-xicp";
>> +    uint32_t irange[2], i, rsize;
>> +    uint64_t *reg;
>> +
>> +    /*
>> +     * TODO: add multichip ICP BAR
>> +     */
>> +    addr =3D PNV_ICP_BASE(chip) | (pir << 12);
>> +
>> +    irange[0] =3D cpu_to_be32(pir);
>> +    irange[1] =3D cpu_to_be32(count);
>> +
>> +    rsize =3D sizeof(uint64_t) * 2 * count;
>> +    reg =3D g_malloc(rsize);
>> +    for (i =3D 0; i < count; i++) {
>> +        reg[i * 2] =3D cpu_to_be64(addr | ((pir + i) * 0x1000));
>> +        reg[i * 2 + 1] =3D cpu_to_be64(0x1000);
>> +    }
>> +
>> +    name =3D g_strdup_printf("interrupt-controller@%"PRIX64, addr);
>> +    offset =3D fdt_add_subnode(fdt, offset, name);
>> +    _FDT(offset);
>> +    g_free(name);
>> +
>> +    _FDT((fdt_setprop(fdt, offset, "compatible", compat, sizeof(compa=
t))));
>> +    _FDT((fdt_setprop(fdt, offset, "reg", reg, rsize)));
>> +    _FDT((fdt_setprop_string(fdt, offset, "device_type",
>> +                              "PowerPC-External-Interrupt-Presentatio=
n")));
>> +    _FDT((fdt_setprop(fdt, offset, "interrupt-controller", NULL, 0)))=
;
>> +    _FDT((fdt_setprop(fdt, offset, "ibm,interrupt-server-ranges",
>> +                       irange, sizeof(irange))));
>> +    _FDT((fdt_setprop_cell(fdt, offset, "#interrupt-cells", 1)));
>> +    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0)));
>> +    g_free(reg);
>> +}
>> +
>>  static void powernv_populate_chip(PnvChip *chip, void *fdt)
>>  {
>>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>> @@ -229,6 +271,10 @@ static void powernv_populate_chip(PnvChip *chip, =
void *fdt)
>>          PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
>> =20
>>          powernv_create_core_node(chip, pnv_core, fdt);
>> +
>> +        /* Interrupt Control Presenters (ICP). One per thread. */
>> +        powernv_populate_icp(chip, fdt, 0, pnv_core->pir,
>=20
> All the xicp nodes under the root bus, is that correct?

yes. The '0' parameter feels useless there.

C.=20


>=20
>> +                             CPU_CORE(pnv_core)->nr_threads);
>>      }
>> =20
>>      if (chip->ram_size) {
>> @@ -697,6 +743,7 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
>>          error_propagate(errp, error);
>>          return;
>>      }
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
>> =20
>>      /* Cores */
>>      pnv_chip_core_sanitize(chip, &error);
>> @@ -711,6 +758,7 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
>>               && (i < chip->nr_cores); core_hwid++) {
>>          char core_name[32];
>>          void *pnv_core =3D chip->cores + i * typesize;
>> +        int j;
>> =20
>>          if (!(chip->cores_mask & (1ull << core_hwid))) {
>>              continue;
>> @@ -738,6 +786,13 @@ static void pnv_chip_realize(DeviceState *dev, Er=
ror **errp)
>>                                  PNV_XSCOM_EX_CORE_BASE(pcc->xscom_cor=
e_base,
>>                                                         core_hwid),
>>                                  &PNV_CORE(pnv_core)->xscom_regs);
>> +
>> +        /* Map the ICP registers for each thread */
>> +        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
>> +            memory_region_add_subregion(&chip->icp_mmio,
>> +                                 (pcc->core_pir(chip, core_hwid) + j)=
 << 12,
>> +                                  &PNV_CORE(pnv_core)->icp_mmios[j]);
>> +        }
>>          i++;
>>      }
>>      g_free(typename);
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index 8633afbff795..d28fa445b11b 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -25,6 +25,7 @@
>>  #include "hw/ppc/pnv.h"
>>  #include "hw/ppc/pnv_core.h"
>>  #include "hw/ppc/pnv_xscom.h"
>> +#include "hw/ppc/xics.h"
>> =20
>>  static uint64_t pnv_core_icp_read(void *opaque, hwaddr addr, unsigned=
 width)
>>  {
>> @@ -165,7 +166,7 @@ static void powernv_cpu_reset(void *opaque)
>>      env->msr |=3D MSR_HVB; /* Hypervisor mode */
>>  }
>> =20
>> -static void powernv_cpu_init(PowerPCCPU *cpu, Error **errp)
>> +static void powernv_cpu_init(PowerPCCPU *cpu, XICSFabric *xi, Error *=
*errp)
>>  {
>>      CPUPPCState *env =3D &cpu->env;
>>      int core_pir;
>> @@ -185,6 +186,9 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Erro=
r **errp)
>>      cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
>> =20
>>      qemu_register_reset(powernv_cpu_reset, cpu);
>> +
>> +    /* xics_cpu_setup() assigns the CPU to the ICPState */
>> +    xics_cpu_setup(xi, cpu);
>>  }
>> =20
>>  /*
>> @@ -232,7 +236,7 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D=
 {
>>      .endianness =3D DEVICE_BIG_ENDIAN,
>>  };
>> =20
>> -static void pnv_core_realize_child(Object *child, Error **errp)
>> +static void pnv_core_realize_child(Object *child, XICSFabric *xi, Err=
or **errp)
>>  {
>>      Error *local_err =3D NULL;
>>      CPUState *cs =3D CPU(child);
>> @@ -244,7 +248,7 @@ static void pnv_core_realize_child(Object *child, =
Error **errp)
>>          return;
>>      }
>> =20
>> -    powernv_cpu_init(cpu, &local_err);
>> +    powernv_cpu_init(cpu, xi, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>> @@ -298,7 +302,7 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
>>      for (j =3D 0; j < cc->nr_threads; j++) {
>>          obj =3D pc->threads + j * size;
>> =20
>> -        pnv_core_realize_child(obj, &local_err);
>> +        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
>>          if (local_err) {
>>              goto err;
>>          }
>=20
