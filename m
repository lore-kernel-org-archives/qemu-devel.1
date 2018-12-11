Received: from eggs.gnu.org ([2001:4830:134:3::10]:58947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWfi1-0002O6-QZ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWfhw-0007Fq-55
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:56:13 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:39948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWfhv-0007EJ-De
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:56:07 -0500
Received: from player755.ha.ovh.net (unknown [10.109.143.223])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D866617069C
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:56:05 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-13-clg@kaod.org>
	<20181210064214.GV4261@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e43447bf-2a32-a08c-874d-7152fd89e1ba@kaod.org>
Date: Tue, 11 Dec 2018 11:55:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181210064214.GV4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/19] spapr: add a 'reset' method to
 the sPAPR IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 12/10/18 7:42 AM, David Gibson wrote:
> On Sun, Dec 09, 2018 at 08:46:03PM +0100, C=E9dric Le Goater wrote:
>> For the time being, the XIVE reset handler updates the OS CAM line of
>> the vCPU as it is done under a real hypervisor when a vCPU is
>> scheduled to run on a HW thread.
>>
>> This handler will become even more useful when we introduce the
>> machine supporting both interrupt modes, XIVE and XICS. In this
>> machine, the interrupt mode is chosen by the CAS negotiation process
>> and activated after a reset.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_irq.h  |  2 ++
>>  include/hw/ppc/spapr_xive.h |  1 +
>>  hw/intc/spapr_xive.c        | 24 ++++++++++++++++++++++++
>>  hw/ppc/spapr.c              |  5 +++++
>>  hw/ppc/spapr_irq.c          | 24 ++++++++++++++++++++++++
>>  5 files changed, 56 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 84a25ffb6c65..63061a009b4c 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -44,6 +44,7 @@ typedef struct sPAPRIrq {
>>      Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
>>                                 Error **errp);
>>      int (*post_load)(sPAPRMachineState *spapr, int version_id);
>> +    void (*reset)(sPAPRMachineState *spapr, Error **errp);
>>  } sPAPRIrq;
>> =20
>>  extern sPAPRIrq spapr_irq_xics;
>> @@ -55,6 +56,7 @@ int spapr_irq_claim(sPAPRMachineState *spapr, int ir=
q, bool lsi, Error **errp);
>>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>>  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
>> +void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
>> =20
>>  /*
>>   * XICS legacy routines
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 728a5e8dc163..7244a6231ce6 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -47,5 +47,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, voi=
d *fdt,
>>                     uint32_t phandle);
>> +void spapr_xive_reset_tctx(sPAPRXive *xive);
>> =20
>>  #endif /* PPC_SPAPR_XIVE_H */
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index a6d854b07690..560d8d031f74 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -179,6 +179,30 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
>>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
>>  }
>> =20
>> +/*
>> + * When a Virtual Processor is scheduled to run on a HW thread, the
>> + * hypervisor pushes its identifier in the OS CAM line. Emulate the
>> + * same behavior under QEMU.
>> + */
>> +void spapr_xive_reset_tctx(sPAPRXive *xive)
>> +{
>> +    CPUState *cs;
>> +    uint8_t  nvt_blk;
>> +    uint32_t nvt_idx;
>> +    uint32_t nvt_cam;
>> +
>> +    CPU_FOREACH(cs) {
>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> +        XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
>> +
>> +        spapr_xive_cpu_to_nvt(cpu, &nvt_blk, &nvt_idx);
>> +
>> +        nvt_cam =3D cpu_to_be32(TM_QW1W2_VO |
>> +                              xive_nvt_cam_line(nvt_blk, nvt_idx));
>> +        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
>> +    }
>> +}
>> +

I will need to rework that patch because the OS CAM line needs to be=20
reseted when a CPU is hot plugged also.

C.=20

>>  static void spapr_xive_end_reset(XiveEND *end)
>>  {
>>      memset(end, 0, sizeof(*end));
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 8cea4cad1732..98d69f09e080 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1619,6 +1619,11 @@ static void spapr_machine_reset(void)
>> =20
>>      qemu_devices_reset();
>> =20
>> +    /* This is fixing some of the default configuration of the XIVE
>> +     * devices. To be called after the reset of the machine devices.
>> +     */
>> +    spapr_irq_reset(spapr, &error_fatal);
>> +
>>      /* DRC reset may cause a device to be unplugged. This will cause =
troubles
>>       * if this device is used by another device (eg, a running vhost =
backend
>>       * will crash QEMU if the DIMM holding the vring goes away). To a=
void such
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 35a067cad3f8..04f5c9665550 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -209,6 +209,10 @@ static int spapr_irq_post_load_xics(sPAPRMachineS=
tate *spapr, int version_id)
>>      return 0;
>>  }
>> =20
>> +static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **er=
rp)
>> +{
>> +}
>=20
> You already have a check for a NULL reset hook in spapr_irq_reset() so
> you could omit this empty function.
>=20
>> +
>>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
>> @@ -225,6 +229,7 @@ sPAPRIrq spapr_irq_xics =3D {
>>      .dt_populate =3D spapr_dt_xics,
>>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>>      .post_load   =3D spapr_irq_post_load_xics,
>> +    .reset       =3D spapr_irq_reset_xics,
>>  };
>> =20
>>  /*
>> @@ -333,6 +338,15 @@ static int spapr_irq_post_load_xive(sPAPRMachineS=
tate *spapr, int version_id)
>>      return 0;
>>  }
>> =20
>> +static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **er=
rp)
>> +{
>> +    /*
>> +     * Set the OS CAM line of the cpu interrupt thread context. Needs
>> +     * to come after the XiveTCTX reset handlers.
>> +     */
>> +    spapr_xive_reset_tctx(spapr->xive);
>> +}
>> +
>>  /*
>>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>>   * with XICS.
>> @@ -353,6 +367,7 @@ sPAPRIrq spapr_irq_xive =3D {
>>      .dt_populate =3D spapr_dt_xive,
>>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
>>      .post_load   =3D spapr_irq_post_load_xive,
>> +    .reset       =3D spapr_irq_reset_xive,
>>  };
>> =20
>>  /*
>> @@ -398,6 +413,15 @@ int spapr_irq_post_load(sPAPRMachineState *spapr,=
 int version_id)
>>      return smc->irq->post_load(spapr, version_id);
>>  }
>> =20
>> +void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
>> +{
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> +
>> +    if (smc->irq->reset) {
>> +        smc->irq->reset(spapr, errp);
>> +    }
>> +}
>> +
>>  /*
>>   * XICS legacy routines - to deprecate one day
>>   */
>=20
