Received: from eggs.gnu.org ([2001:4830:134:3::10]:38087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZw1R-0003ld-Sf
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZw1O-0001Nd-Md
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:20:57 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:40441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZw1O-0001M8-Ca
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:20:54 -0400
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id DA16688F78
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 11:20:52 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-27-git-send-email-clg@kaod.org>
	<61f9467e-f7be-e939-ce7e-d83b70933576@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5e2c76ad-679a-d367-a478-9d50509a0547@kaod.org>
Date: Tue, 25 Jul 2017 11:20:49 +0200
MIME-Version: 1.0
In-Reply-To: <61f9467e-f7be-e939-ce7e-d83b70933576@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 26/26] spapr: force XIVE
 exploitation mode for POWER9 (HACK)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/25/2017 04:43 AM, Alexey Kardashevskiy wrote:
> On 06/07/17 03:13, C=C3=A9dric Le Goater wrote:
>> The CAS negotiation process determines the interrupt controller model
>> to use in the guest but currently, the sPAPR machine make uses of the
>> controller very early in the initialization sequence. The interrupt
>> source is used to allocate IRQ numbers and populate the device tree
>> and the interrupt presenter objects are created along with the CPU.
>>
>> One solution would be use a bitmap to allocate these IRQ numbers and
>> then instantiate the interrupt source object of the correct type with
>> the bitmap as a constructor parameter.
>>
>> As for the interrupt presenter objects, we could allocated them later
>> in the boot process. May be on demand, when a CPU is first notified.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/spapr.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 62 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index ca3a6bc2ea16..623fc776c886 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -237,6 +237,38 @@ error:
>>      return NULL;
>>  }
>> =20
>> +static XiveICSState *spapr_xive_ics_create(XIVE *x, int nr_irqs, Erro=
r **errp)
>> +{
>> +    Error *local_err =3D NULL;
>> +    int irq_base;
>> +    Object *obj;
>> +
>> +    /*
>> +     * TODO: use an XICS_IRQ_BASE alignment to be in sync with XICS
>> +     * irq numbers. we should probably simplify the XIVE model or use
>> +     * a common allocator. a bitmap maybe ?
>> +     */
>> +    irq_base =3D xive_alloc_hw_irqs(x, nr_irqs, XICS_IRQ_BASE);
>> +    if (irq_base < 0) {
>> +        error_setg(errp, "Failed to allocate %d irqs", nr_irqs);
>> +        return NULL;
>> +    }
>> +
>> +    obj =3D object_new(TYPE_ICS_XIVE);
>> +    object_property_add_child(OBJECT(x), "hw", obj, NULL);
>> +
>> +    xive_ics_create(ICS_XIVE(obj), x, irq_base, nr_irqs, 16 /* 64KB p=
age */,
>> +                    XIVE_SRC_TRIGGER, &local_err);
>> +    if (local_err) {
>> +        goto error;
>> +    }
>> +    return ICS_XIVE(obj);
>> +
>> +error:
>> +    error_propagate(errp, local_err);
>> +    return NULL;
>> +}
>> +
>>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *=
cpu,
>>                                    int smt_threads)
>>  {
>> @@ -814,6 +846,11 @@ static int spapr_dt_cas_updates(sPAPRMachineState=
 *spapr, void *fdt,
>>      /* /interrupt controller */
>>      if (!spapr_ovec_test(ov5_updates, OV5_XIVE_EXPLOIT)) {
>>          spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
>> +    } else {
>> +        xive_spapr_populate(spapr->xive, fdt);
>> +
>> +        /* Install XIVE MMIOs */
>> +        xive_mmio_map(spapr->xive);
>=20
>=20
> xive_mmio_map() could be called where sysbus_init_mmio() is called as o=
nce
> these are mmap'ed, they are never unmapped and tm_base/vc_base never
> change. And XIVE is always created on P9 anyway.

OK. So you don't think we should map/unmap depending on=20
CAS negotiation of the OV5_XIVE_EXPLOIT bit ?=20

Thanks,

C.=20


>=20
>=20
>>      }
>> =20
>>      offset =3D fdt_path_offset(fdt, "/chosen");
>> @@ -963,6 +1000,13 @@ static void spapr_dt_ov5_platform_support(void *=
fdt, int chosen)
>>          } else {
>>              val[3] =3D 0x00; /* Hash */
>>          }
>> +
>> +        /* TODO: introduce a kvmppc_has_cap_xive() ? Works with
>=20
>=20
> Yes.
>=20
>> +         * irqchip=3Doff for now
>> +         */
>> +        if (first_ppc_cpu->env.excp_model & POWERPC_EXCP_POWER9) {
>> +            val[1] =3D 0x01;
>> +        }
>>      } else {
>>          if (first_ppc_cpu->env.mmu_model & POWERPC_MMU_V3) {
>>              /* V3 MMU supports both hash and radix (with dynamic swit=
ching) */
>> @@ -971,6 +1015,9 @@ static void spapr_dt_ov5_platform_support(void *f=
dt, int chosen)
>>              /* Otherwise we can only do hash */
>>              val[3] =3D 0x00;
>>          }
>> +        if (first_ppc_cpu->env.excp_model & POWERPC_EXCP_POWER9) {
>> +            val[1] =3D 0x01;
>> +        }
>>      }
>>      _FDT(fdt_setprop(fdt, chosen, "ibm,arch-vec-5-platform-support",
>>                       val, sizeof(val)));
>> @@ -2237,6 +2284,21 @@ static void ppc_spapr_init(MachineState *machin=
e)
>>      spapr->ov5 =3D spapr_ovec_new();
>>      spapr->ov5_cas =3D spapr_ovec_new();
>> =20
>> +    /* TODO: force XIVE mode by default on POWER9.
>> +     *
>> +     * Switching from XICS to XIVE is badly broken. The ICP type is
>> +     * incorrect and the ICS is needed before the CAS negotiation to
>> +     * allocate irq numbers ...
>> +     */
>> +    if (strstr(machine->cpu_model, "POWER9") ||
>> +        !strcmp(machine->cpu_model, "host")) {
>> +        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>> +
>> +        spapr->icp_type =3D TYPE_XIVE_ICP;
>> +        spapr->ics =3D ICS_BASE(
>> +            spapr_xive_ics_create(spapr->xive, XICS_IRQS_SPAPR, &erro=
r_fatal));
>> +    }
>> +
>>      if (smc->dr_lmb_enabled) {
>>          spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
>>          spapr_validate_node_memory(machine, &error_fatal);
>>
>=20
>=20
