Received: from eggs.gnu.org ([2001:4830:134:3::10]:43276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETku-00065D-1Z
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETks-0007Qd-8P
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:24 +1000
Message-Id: <20180504055930.3786-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/17] spapr: Clean up handling of LPCR
 power-saving exit bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

To prevent spurious wakeups on cpus that are supposed to be disabled, we
need to clear the LPCR bits which control certain wakeup events.
spapr_cpu_reset() has separate cases here for boot and non-boot (initiall=
y
inactive) cpus.  rtas_start_cpu() then turns the LPCR bits on when the
non-boot cpus are activated.

But explicit checks against first_cpu are not how we usually do things:
instead spapr_cpu_reset() generally sets things up for non-boot (inactive=
)
cpus, then spapr_machine_reset() and/or rtas_start_cpu() override as
necessary.

So, do that instead.  Because the LPCR activation is identical for boot
cpus and non-boot cpus just activated with rtas_start_cpu() we can put th=
e
code common in spapr_cpu_set_entry_state().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 22 +++++++---------------
 hw/ppc/spapr_rtas.c     |  2 +-
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index a52ddade5e..f3e9b879b2 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -54,28 +54,17 @@ static void spapr_cpu_reset(void *opaque)
      * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c for
      * real mode accesses, which thankfully defaults to 0 and isn't
      * accessible in guest mode.
+     *
+     * Disable Power-saving mode Exit Cause exceptions for the CPU, so
+     * we don't get spurious wakups before an RTAS start-cpu call.
      */
-    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV);
+    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_=
pm);
     lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
=20
     /* Set RMLS to the max (ie, 16G) */
     lpcr &=3D ~LPCR_RMLS;
     lpcr |=3D 1ull << LPCR_RMLS_SHIFT;
=20
-    /* Only enable Power-saving mode Exit Cause exceptions on the boot
-     * CPU. The RTAS command start-cpu will enable them on secondaries.
-     */
-    if (cs =3D=3D first_cpu) {
-        lpcr |=3D pcc->lpcr_pm;
-    }
-
-    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
-     * This can cause issues when rebooting the guest if a secondary
-     * is awaken */
-    if (cs !=3D first_cpu) {
-        lpcr &=3D ~pcc->lpcr_pm;
-    }
-
     ppc_store_lpcr(cpu, lpcr);
=20
     /* Set a full AMOR so guest can use the AMR as it sees fit */
@@ -84,11 +73,14 @@ static void spapr_cpu_reset(void *opaque)
=20
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
 {
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env =3D &cpu->env;
=20
     env->nip =3D nip;
     env->gpr[3] =3D r3;
     CPU(cpu)->halted =3D 0;
+    /* Enable Power-saving mode Exit Cause exceptions */
+    ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
 }
=20
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 652233bdf1..7f9738daed 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -162,7 +162,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPR=
MachineState *spapr,
     env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
=20
     /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
-    lpcr =3D env->spr[SPR_LPCR] | pcc->lpcr_pm;
+    lpcr =3D env->spr[SPR_LPCR];
     if (!pcc->interrupts_big_endian(callcpu)) {
         lpcr |=3D LPCR_ILE;
     }
--=20
2.17.0
