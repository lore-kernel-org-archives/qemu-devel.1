Received: from eggs.gnu.org ([2001:4830:134:3::10]:59123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1co5n4-0003ag-KQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1co5mz-0006J5-51
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:04:22 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:39197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1co5my-0006FW-PS
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:04:17 -0400
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id D2DA161950
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:04:14 +0100 (CET)
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-2-git-send-email-clg@kaod.org>
	<20170314053856.GH12564@umbus.fritz.box>
	<3136fbfa-938a-679e-0bf6-c1dab315d425@kaod.org>
	<20170315045344.GB12603@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f1ad7d48-ce4b-2b05-26a6-db28af170a82@kaod.org>
Date: Wed, 15 Mar 2017 11:04:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170315045344.GB12603@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/8] ppc/xics: add a
 xics_get_cpu_index_by_pir() helper
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

On 03/15/2017 05:53 AM, David Gibson wrote:
> On Tue, Mar 14, 2017 at 06:00:43PM +0100, C=E9dric Le Goater wrote:
>> On 03/14/2017 06:38 AM, David Gibson wrote:
>>> On Wed, Mar 08, 2017 at 11:52:44AM +0100, C=E9dric Le Goater wrote:
>>>> This helper will be used to translate the server number of the XIVE
>>>> (which is a PIR) into an ICPState index number (which is a cpu index=
).
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> This seems a slightly roundabout way of doing things.  Why not just
>>> have the vcpu_by_pir() interface, then have the XICSFabric implemento=
r
>>> go directly from PIR to xics server state.
>>
>> So what you are saying is that we should try to move the "nature"
>> of the 'server' parameter of the xics framework in the icp_get()=20
>> handler of the XICSFabric. Correct ? Because at the end, it all=20
>> boils down to use a 'server' to look for an ICPState.
>>
>> Each machine would do its conversion :=20
>>
>> 	xics_get_cpu_index_by_dt_id() for spapr
>> 	xics_get_cpu_index_by_pir() for powernv
>=20
> Yes, that's exactly right.  I think it makes sense for the XICSFabric
> to be the thing that defines the mapping from XICS server numbers to
> whatever other ID is relevant.
>=20

OK. So we need some more cleanups in the current code because=20
'cpu_index' is still being used in a couple of places. Below
is a patch adding an ICPState backlink to ease the transition.=20
After this one, moving the XICS server mapping under the=20
icp_get() handler is trivial. Tell me if you like the idea and=20
I will send both patches.=20

If not, we can still do a few thing but we will need to move=20
the lookup out of xics_cpu_setup() *and* xics_cpu_destoy().


Thanks,

C.=20











>From dad67b9fdcafa7f9e84ce27e6ae5fd2c2bbd6b3f Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org>
Date: Wed, 15 Mar 2017 09:17:11 +0100
Subject: [PATCH] ppc/xics: introduce a ICPState backlink under PowerPCCPU
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Currently, 'cpu_index' is used to lookup for ICPState objects. But,
this can be a problem for platforms having a different index, the
PowerNV uses a core PIR number for instance.

One way to abstract the IRQ 'server' number of the XICS layer is to
let the core init routine of the platform do the lookup of the
ICPState and store the resulting ICPState object under PowerPCCPU.
This enables us to limit the use of 'cpu_index' in XICS making it more
generic for other platforms.

It also has the benefit of simplifying the sPAPR hcalls which do not
need to do any ICPState lookup anymore.

Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c          |  4 ++--
 hw/intc/xics_spapr.c    | 20 +++++---------------
 hw/ppc/spapr_cpu_core.c |  4 +++-
 target/ppc/cpu.h        |  2 ++
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e740989a1162..5cde86ceb3bc 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -52,7 +52,7 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
 void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
+    ICPState *icp =3D cpu->icp;
=20
     assert(icp);
     assert(cs =3D=3D icp->cs);
@@ -65,7 +65,7 @@ void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    ICPState *icp =3D xics_icp_get(xi, cs->cpu_index);
+    ICPState *icp =3D cpu->icp;
     ICPStateClass *icpc;
=20
     assert(icp);
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 84d24b2837a7..178b3adc8af7 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -43,11 +43,9 @@
 static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
-    CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
     target_ulong cppr =3D args[0];
=20
-    icp_set_cppr(icp, cppr);
+    icp_set_cppr(cpu->icp, cppr);
     return H_SUCCESS;
 }
=20
@@ -69,9 +67,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
 static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
-    CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
-    uint32_t xirr =3D icp_accept(icp);
+    uint32_t xirr =3D icp_accept(cpu->icp);
=20
     args[0] =3D xirr;
     return H_SUCCESS;
@@ -80,9 +76,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
 static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
-    CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
-    uint32_t xirr =3D icp_accept(icp);
+    uint32_t xirr =3D icp_accept(cpu->icp);
=20
     args[0] =3D xirr;
     args[1] =3D cpu_get_host_ticks();
@@ -92,21 +86,17 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
 static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                           target_ulong opcode, target_ulong *args)
 {
-    CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
     target_ulong xirr =3D args[0];
=20
-    icp_eoi(icp, xirr);
+    icp_eoi(cpu->icp, xirr);
     return H_SUCCESS;
 }
=20
 static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
-    CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
     uint32_t mfrr;
-    uint32_t xirr =3D icp_ipoll(icp, &mfrr);
+    uint32_t xirr =3D icp_ipoll(cpu->icp, &mfrr);
=20
     args[0] =3D xirr;
     args[1] =3D mfrr;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 6883f0991ae9..59f1cba6fba5 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -63,6 +63,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
                            Error **errp)
 {
     CPUPPCState *env =3D &cpu->env;
+    XICSFabric *xi =3D XICS_FABRIC(spapr);
=20
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
@@ -80,7 +81,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
         }
     }
=20
-    xics_cpu_setup(XICS_FABRIC(spapr), cpu);
+    cpu->icp =3D xics_icp_get(xi, CPU(cpu)->cpu_index);
+    xics_cpu_setup(xi, cpu);
=20
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5ee33b3fd315..b1626d0a6607 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1176,6 +1176,7 @@ do {                                            \
=20
 typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
 typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
+typedef struct ICPState ICPState;
=20
 /**
  * PowerPCCPU:
@@ -1196,6 +1197,7 @@ struct PowerPCCPU {
     uint32_t max_compat;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
+    ICPState *icp;
=20
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
--=20
2.7.4
