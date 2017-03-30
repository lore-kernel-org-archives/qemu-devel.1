Received: from eggs.gnu.org ([2001:4830:134:3::10]:55783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctZl4-0007qz-Jl
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctZl1-0001vV-D6
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:04:58 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:40479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ctZl1-0001uM-4D
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:04:55 -0400
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 898E077DBA
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 15:04:52 +0200 (CEST)
References: <1490795611-4762-1-git-send-email-clg@kaod.org>
	<1490795611-4762-3-git-send-email-clg@kaod.org>
	<20170330064605.GF22163@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3e6f5e93-6b87-1304-98f7-73c828fe14af@kaod.org>
Date: Thu, 30 Mar 2017 15:04:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170330064605.GF22163@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/9] spapr: move the IRQ server number
 mapping under the machine
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

On 03/30/2017 08:46 AM, David Gibson wrote:
> On Wed, Mar 29, 2017 at 03:53:24PM +0200, C=E9dric Le Goater wrote:
>> This is the second step to abstract the IRQ 'server' number of the
>> XICS layer. Now that the prereq cleanups have been done in the
>> previous patch, we can move down the 'cpu_dt_id' to 'cpu_index'
>> mapping in the sPAPR machine handler.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/intc/xics_spapr.c    | 5 ++---
>>  hw/ppc/spapr.c          | 3 ++-
>>  hw/ppc/spapr_cpu_core.c | 2 +-
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
>> index 58f100d379cb..f05308b897f2 100644
>> --- a/hw/intc/xics_spapr.c
>> +++ b/hw/intc/xics_spapr.c
>> @@ -52,9 +52,8 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>>  static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>>                            target_ulong opcode, target_ulong *args)
>>  {
>> -    target_ulong server =3D xics_get_cpu_index_by_dt_id(args[0]);
>>      target_ulong mfrr =3D args[1];
>> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), server);
>> +    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
>> =20
>>      if (!icp) {
>>          return H_PARAMETER;
>> @@ -122,7 +121,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
>>      }
>> =20
>>      nr =3D rtas_ld(args, 0);
>> -    server =3D xics_get_cpu_index_by_dt_id(rtas_ld(args, 1));
>> +    server =3D rtas_ld(args, 1);
>>      priority =3D rtas_ld(args, 2);
>> =20
>>      if (!ics_valid_irq(ics, nr) || !xics_icp_get(XICS_FABRIC(spapr), =
server)
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 8aecea3dd10c..b9f7f8607869 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3024,9 +3024,10 @@ static void spapr_ics_resend(XICSFabric *dev)
>>      ics_resend(spapr->ics);
>>  }
>> =20
>> -static ICPState *spapr_icp_get(XICSFabric *xi, int server)
>> +static ICPState *spapr_icp_get(XICSFabric *xi, int cpu_dt_id)
>>  {
>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>> +    int server =3D xics_get_cpu_index_by_dt_id(cpu_dt_id);
>=20
> The idea is good, but this is a bad name (as it was in the original
> version, too).  The whole point here is that the XICS server number
> (as it appears in the ICS registers) is the input to this function,
> and we no longer assume that is equal to cpu_index.
>=20
> Seems we could just get the cpu object by dt_id here, then go to ICP(cp=
u->intc).

yes that would be nice and this is exactly what pnv does now, but=20
this is only possible because the PnvICPState objects are allocated=20
from under PnvCore. This is not the case for sPAPR yet.

Currently, when the sPAPR core are realized, we call spapr_cpu_init()=20
which first gets its ICP with :

	xics_icp_get(xi, cpu->cpu_dt_id);

so we cannot use ICP(cpu->intc) in this XICSFabric handler, it is not
assigned yet. It only will be at the end of spapr_cpu_init() when=20

	xics_cpu_setup(xi, cpu, icp);

is called.=20


As suggested in an email this morning, I think we could allocate=20
the ICP from under the sPAPR core if we knew which ICP type to use=20
(KVM or not). =20

For that, we could use a new XICSFabric handler :

	const char *icp_type(XICSFabric *xi)

or a machine attribute to get the type. The ICP type would be chosen=20
in xics_system_init() a bit like it is done today but we would not=20
create the ICP object.=20

or we could use a machine helper (probably better) : =20

	ICPState *spapr_icp_create(MachineState *machine);  =20

which would only do the ICP part of xics_system_init(). The ICS
object can be created later on, it is not a problem.=20

We have kind of a chicken and egg problem with the Core and the=20
ICP objects today that it would be nice to untangle.=20

Suggestions ?


C.=20


>=20
>>      return (server < spapr->nr_servers) ? &spapr->icps[server] : NULL=
;
>>  }
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 7db61bd72476..4e1a99591d19 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -64,7 +64,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu,
>>  {
>>      CPUPPCState *env =3D &cpu->env;
>>      XICSFabric *xi =3D XICS_FABRIC(spapr);
>> -    ICPState *icp =3D xics_icp_get(xi, CPU(cpu)->cpu_index);
>> +    ICPState *icp =3D xics_icp_get(xi, cpu->cpu_dt_id);
>> =20
>>      /* Set time-base frequency to 512 MHz */
>>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
>=20
