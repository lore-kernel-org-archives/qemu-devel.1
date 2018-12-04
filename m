Received: from eggs.gnu.org ([2001:4830:134:3::10]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUCP2-0005bW-Oq
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUCOz-0002xk-EI
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:14:24 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:50076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUCOz-0002vY-6V
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:14:21 -0500
Received: from player758.ha.ovh.net (unknown [10.109.146.86])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5C4A9175C31
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 16:14:19 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-20-clg@kaod.org>
	<20181128044257.GC2251@umbus.fritz.box>
	<62423058-3603-942a-915f-f9e6afd7b4cc@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1d8b8604-f962-5647-3283-7949c52d3bcc@kaod.org>
Date: Tue, 4 Dec 2018 16:14:12 +0100
MIME-Version: 1.0
In-Reply-To: <62423058-3603-942a-915f-f9e6afd7b4cc@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 19/36] spapr: add a 'pseries-3.1-xive'
 machine type
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

On 11/28/18 11:37 PM, C=E9dric Le Goater wrote:
> On 11/28/18 5:42 AM, David Gibson wrote:
>> On Fri, Nov 16, 2018 at 11:57:12AM +0100, C=E9dric Le Goater wrote:
>>> The interrupt mode is statically defined to XIVE only for this machin=
e.
>>> The guest OS is required to have support for the XIVE exploitation
>>> mode of the POWER9 interrupt controller.
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>> ---
>>>  include/hw/ppc/spapr_irq.h |  1 +
>>>  hw/ppc/spapr.c             | 36 +++++++++++++++++++++++++++++++-----
>>>  hw/ppc/spapr_irq.c         |  3 +++
>>>  3 files changed, 35 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>>> index c3b4c38145eb..b299dd794bff 100644
>>> --- a/include/hw/ppc/spapr_irq.h
>>> +++ b/include/hw/ppc/spapr_irq.h
>>> @@ -33,6 +33,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
>>>  typedef struct sPAPRIrq {
>>>      uint32_t    nr_irqs;
>>>      uint32_t    nr_msis;
>>> +    uint8_t     ov5;
>>
>> I'm a bit confused as to what exactly this represents..
>=20
> The option vector 5 bits advertised by CAS for the platform. What the
> hypervisor supports.

0x80 both mode
0x40 XIVE only
0x00 XICS only

>>
>>>      void (*init)(sPAPRMachineState *spapr, int nr_irqs, int nr_serve=
rs,
>>>                   Error **errp);
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index ad1692cdcd0f..8fbb743769db 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -1097,12 +1097,14 @@ static void spapr_dt_rtas(sPAPRMachineState *=
spapr, void *fdt)
>>>      spapr_dt_rtas_tokens(fdt, rtas);
>>>  }
>>> =20
>>> -/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU =
features
>>> - * that the guest may request and thus the valid values for bytes 24=
..26 of
>>> - * option vector 5: */
>>> -static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
>>> +/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU
>>> + * and the XIVE features that the guest may request and thus the val=
id
>>> + * values for bytes 23..26 of option vector 5: */
>>> +static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr, =
void *fdt,
>>> +                                          int chosen)
>>>  {
>>>      PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>>> =20
>>>      char val[2 * 4] =3D {
>>>          23, 0x00, /* Xive mode, filled in below. */
>>> @@ -1123,7 +1125,11 @@ static void spapr_dt_ov5_platform_support(void=
 *fdt, int chosen)
>>>          } else {
>>>              val[3] =3D 0x00; /* Hash */
>>>          }
>>> +        /* TODO: test KVM support */
>>> +        val[1] =3D smc->irq->ov5;
>>>      } else {
>>> +        val[1] =3D smc->irq->ov5;
>>
>> ..here it seems to be a specific value for this OV5 byte, indicating t=
he
>> supported intc...
>=20
> yes.>=20
>>
>>> +
>>>          /* V3 MMU supports both hash and radix in tcg (with dynamic =
switching) */
>>>          val[3] =3D 0xC0;
>>>      }
>>> @@ -1191,7 +1197,7 @@ static void spapr_dt_chosen(sPAPRMachineState *=
spapr, void *fdt)
>>>          _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_p=
ath));
>>>      }
>>> =20
>>> -    spapr_dt_ov5_platform_support(fdt, chosen);
>>> +    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>>> =20
>>>      g_free(stdout_path);
>>>      g_free(bootlist);
>>> @@ -2622,6 +2628,11 @@ static void spapr_machine_init(MachineState *m=
achine)
>>>      /* advertise support for ibm,dyamic-memory-v2 */
>>>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
>>> =20
>>> +    /* advertise XIVE */
>>> +    if (smc->irq->ov5) {
>>
>> ..but here it seems to be a bool indicating XIVE support specifically.
>=20
> ah. yes. I need to check this part. That was a while ago.

This is advertising XIVE again if the machine supports it. We need to=20
populate the DT node "ibm,arch-vec-5-platform-support" in routine
spapr_dt_ov5_platform_support() *and* also to update the machine field=20
spapr->ov5. But it seems redundant to me.=20

spapr->ov5 should be used to build the DT. Shouldn't it ? Or I really=20
missed something.=20


Thanks,=20

C.

=20
>>> +        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>>> +    }
>>> +
>>>      /* init CPUs */
>>>      spapr_init_cpus(spapr);
>>> =20
>>> @@ -3971,6 +3982,21 @@ static void spapr_machine_3_1_class_options(Ma=
chineClass *mc)
>>> =20
>>>  DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
>>> =20
>>> +static void spapr_machine_3_1_xive_instance_options(MachineState *ma=
chine)
>>> +{
>>> +    spapr_machine_3_1_instance_options(machine);
>>> +}
>>> +
>>> +static void spapr_machine_3_1_xive_class_options(MachineClass *mc)
>>> +{
>>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>>> +
>>> +    spapr_machine_3_1_class_options(mc);
>>> +    smc->irq =3D &spapr_irq_xive;
>>> +}
>>> +
>>> +DEFINE_SPAPR_MACHINE(3_1_xive, "3.1-xive", false);
>>> +
>>>  /*
>>>   * pseries-3.0
>>>   */
>>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>>> index 253abc10e780..42e73851b174 100644
>>> --- a/hw/ppc/spapr_irq.c
>>> +++ b/hw/ppc/spapr_irq.c
>>> @@ -210,6 +210,7 @@ static Object *spapr_irq_cpu_intc_create_xics(sPA=
PRMachineState *spapr,
>>>  sPAPRIrq spapr_irq_xics =3D {
>>>      .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
>>>      .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
>>> +    .ov5         =3D 0x0, /* XICS only */
>>> =20
>>>      .init        =3D spapr_irq_init_xics,
>>>      .claim       =3D spapr_irq_claim_xics,
>>> @@ -341,6 +342,7 @@ static Object *spapr_irq_cpu_intc_create_xive(sPA=
PRMachineState *spapr,
>>>  sPAPRIrq spapr_irq_xive =3D {
>>>      .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
>>>      .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
>>> +    .ov5         =3D 0x40, /* XIVE exploitation mode only */
>>> =20
>>>      .init        =3D spapr_irq_init_xive,
>>>      .claim       =3D spapr_irq_claim_xive,
>>> @@ -447,6 +449,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int =
num, bool align, Error **errp)
>>>  sPAPRIrq spapr_irq_xics_legacy =3D {
>>>      .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
>>>      .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
>>> +    .ov5         =3D 0x0, /* XICS only */
>>> =20
>>>      .init        =3D spapr_irq_init_xics,
>>>      .claim       =3D spapr_irq_claim_xics,
>>
>=20
