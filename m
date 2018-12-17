Received: from eggs.gnu.org ([2001:4830:134:3::10]:59566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1XE-0002Qv-9o
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1XA-0002b8-UO
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:38:48 -0500
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:37380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZ1XA-0002Zt-Kp
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:38:44 -0500
Received: from player755.ha.ovh.net (unknown [10.109.160.239])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3DE5110DD1D
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:38:43 +0100 (CET)
References: <20181211223823.13770-1-clg@kaod.org>
	<20181211223823.13770-12-clg@kaod.org>
	<20181217060717.GI5597@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dcfacfb6-8fec-04b0-4f2a-c20097511559@kaod.org>
Date: Mon, 17 Dec 2018 23:38:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181217060717.GI5597@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 11/12] spapr: introduce a new sPAPR IRQ
 backend supporting XIVE and XICS
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

On 12/17/18 7:07 AM, David Gibson wrote:
> On Tue, Dec 11, 2018 at 11:38:22PM +0100, C=E9dric Le Goater wrote:
>> The 'dual' sPAPR IRQ backend supports both interrupt mode, XIVE
>> exploitation mode and the legacy compatibility mode (XICS). both modes
>> are not supported at the same time.
>>
>> The machine starts with the legacy mode and a new interrupt mode can
>> then be negotiated by the CAS process. In this case, the new mode is
>> activated after a reset to take into account the required changes in
>> the machine. These impact the device tree layout, the interrupt
>> presenter object and the exposed MMIO regions in the case of XIVE.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v7:
>>
>>  - usage of 'ic-mode' machine option
>>
>>  include/hw/ppc/spapr_irq.h |   1 +
>>  hw/ppc/spapr.c             |  10 ++-
>>  hw/ppc/spapr_hcall.c       |  11 +++
>>  hw/ppc/spapr_irq.c         | 143 ++++++++++++++++++++++++++++++++++++=
+
>>  4 files changed, 162 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index b34d5a00381b..29936498dbc8 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -51,6 +51,7 @@ typedef struct sPAPRIrq {
>>  extern sPAPRIrq spapr_irq_xics;
>>  extern sPAPRIrq spapr_irq_xics_legacy;
>>  extern sPAPRIrq spapr_irq_xive;
>> +extern sPAPRIrq spapr_irq_dual;
>> =20
>>  void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
>>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Erro=
r **errp);
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 5d985e38a598..97a5e3c9929f 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2636,11 +2636,11 @@ static void spapr_machine_init(MachineState *m=
achine)
>>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
>> =20
>>      /* advertise XIVE on POWER9 machines */
>> -    if (spapr->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
>> +    if (spapr->irq->ov5 & (SPAPR_OV5_XIVE_EXPLOIT | SPAPR_OV5_XIVE_BO=
TH)) {
>>          if (ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGI=
CAL_3_00,
>>                                    0, spapr->max_compat_pvr)) {
>>              spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>> -        } else {
>> +        } else if (spapr->irq->ov5 & SPAPR_OV5_XIVE_EXPLOIT) {
>>              error_report("XIVE-only machines require a POWER9 CPU");
>>              exit(1);
>>          }
>> @@ -3066,6 +3066,8 @@ static char *spapr_get_ic_mode(Object *obj, Erro=
r **errp)
>>          return g_strdup("xics");
>>      } else if (spapr->irq =3D=3D &spapr_irq_xive) {
>>          return g_strdup("xive");
>> +    } else if (spapr->irq =3D=3D &spapr_irq_dual) {
>> +        return g_strdup("dual");
>>      }
>>      g_assert_not_reached();
>>  }
>> @@ -3079,6 +3081,8 @@ static void spapr_set_ic_mode(Object *obj, const=
 char *value, Error **errp)
>>          spapr->irq =3D &spapr_irq_xics;
>>      } else if (strcmp(value, "xive") =3D=3D 0) {
>>          spapr->irq =3D &spapr_irq_xive;
>> +    } else if (strcmp(value, "dual") =3D=3D 0) {
>> +        spapr->irq =3D &spapr_irq_dual;
>>      } else {
>>          error_setg(errp, "Bad value for \"ic-mode\" property");
>>      }
>> @@ -3127,7 +3131,7 @@ static void spapr_instance_init(Object *obj)
>>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
>>                              spapr_set_ic_mode, NULL);
>>      object_property_set_description(obj, "ic-mode",
>> -                 "Specifies the interrupt controller mode (xics, xive=
)",
>> +                 "Specifies the interrupt controller mode (xics, xive=
, dual)",
>>                   NULL);
>>  }
>> =20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index ae913d070f50..09386458f267 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1654,6 +1654,17 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
>>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
>>                                            ov5_updates) !=3D 0);
>>      }
>> +
>> +    /*
>> +     * Generate a machine reset when we have an update of the
>> +     * interrupt mode. Only required on the machine supporting both
>> +     * mode.
>> +     */
>> +    if (!spapr->cas_reboot) {
>> +        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_E=
XPLOIT)
>> +            && spapr->irq->ov5 & SPAPR_OV5_XIVE_BOTH;
>> +    }
>> +
>>      spapr_ovec_cleanup(ov5_updates);
>> =20
>>      if (spapr->cas_reboot) {
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index b1319905327f..31d195b08952 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -375,6 +375,149 @@ sPAPRIrq spapr_irq_xive =3D {
>>      .reset       =3D spapr_irq_reset_xive,
>>  };
>> =20
>> +/*
>> + * Dual XIVE and XICS IRQ backend.
>> + *
>> + * Both interrupt mode, XIVE and XICS, objects are created but the
>> + * machine starts in legacy interrupt mode (XICS). It can be changed
>> + * by the CAS negotiation process and, in that case, the new mode is
>> + * activated after extra machine reset.
>> + */
>> +
>> +/*
>> + * Returns the sPAPR IRQ backend negotiated by CAS. XICS is the
>> + * default.
>> + */
>> +static sPAPRIrq *spapr_irq_current(sPAPRMachineState *spapr)
>> +{
>> +    return spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ?
>> +        &spapr_irq_xive : &spapr_irq_xics;
>> +}
>> +
>> +static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **err=
p)
>> +{
>> +    MachineState *machine =3D MACHINE(spapr);
>> +    Error *local_err =3D NULL;
>> +
>> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
>> +        error_setg(errp, "No KVM support for the 'dual' machine");
>> +        return;
>> +    }
>> +
>> +    spapr_irq_xics.init(spapr, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    spapr_irq_xive.init(spapr, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +}
>> +
>> +static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, bo=
ol lsi,
>> +                                Error **errp)
>> +{
>> +    int ret;
>> +    Error *local_err =3D NULL;
>> +
>> +    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return ret;
>> +    }
>> +
>> +    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void spapr_irq_free_dual(sPAPRMachineState *spapr, int irq, in=
t num)
>> +{
>> +    spapr_irq_xive.free(spapr, irq, num);
>> +    spapr_irq_xics.free(spapr, irq, num);
>> +}
>> +
>> +static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
>> +{
>> +    return spapr_irq_current(spapr)->qirq(spapr, irq);
>> +}
>=20
> This still makes me really nervous - I'd really prefer to have qirqs
> independent of the backend, rather than relying on *every* irq using
> device never looking up qirqs in advance.

I will take a look. This is a large rework I won't have time to address=20
this year. I have removed the dual machine from v9.

You would move the qirq array at the machine level ? =20

Thanks,

C.


>=20
>> +static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monit=
or *mon)
>> +{
>> +    spapr_irq_current(spapr)->print_info(spapr, mon);
>> +}
>> +
>> +static void spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
>> +                                       uint32_t nr_servers, void *fdt=
,
>> +                                       uint32_t phandle)
>> +{
>> +    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, pha=
ndle);
>> +}
>> +
>> +static Object *spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spap=
r,
>> +                                              Object *cpu, Error **er=
rp)
>> +{
>> +    Error *local_err =3D NULL;
>> +
>> +    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return NULL;
>> +    }
>> +
>> +    /* Default to XICS interrupt mode */
>> +    return spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
>> +}
>> +
>> +static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int ver=
sion_id)
>> +{
>> +    /*
>> +     * Force a reset of the XIVE backend after migration. The machine
>> +     * defaults to XICS at startup.
>> +     */
>> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>> +        spapr_irq_xive.reset(spapr, &error_fatal);
>> +    }
>> +
>> +    return spapr_irq_current(spapr)->post_load(spapr, version_id);
>> +}
>> +
>> +static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **er=
rp)
>> +{
>> +    /*
>> +     * Reset the interrupt mode selected by CAS.
>> +     */
>> +    spapr_irq_current(spapr)->reset(spapr, errp);
>> +}
>> +
>> +/*
>> + * Define values in sync with the XIVE and XICS backend
>> + */
>> +#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
>> +#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IR=
Q_MSI)
>> +
>> +sPAPRIrq spapr_irq_dual =3D {
>> +    .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
>> +    .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
>> +    .ov5         =3D SPAPR_OV5_XIVE_BOTH,
>> +
>> +    .init        =3D spapr_irq_init_dual,
>> +    .claim       =3D spapr_irq_claim_dual,
>> +    .free        =3D spapr_irq_free_dual,
>> +    .qirq        =3D spapr_qirq_dual,
>> +    .print_info  =3D spapr_irq_print_info_dual,
>> +    .dt_populate =3D spapr_irq_dt_populate_dual,
>> +    .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
>> +    .post_load   =3D spapr_irq_post_load_dual,
>> +    .reset       =3D spapr_irq_reset_dual,
>> +};
>> +
>>  /*
>>   * sPAPR IRQ frontend routines for devices
>>   */
>=20
