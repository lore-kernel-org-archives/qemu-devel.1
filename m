Received: from eggs.gnu.org ([209.51.188.92]:33521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrD-0001tG-2q
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrB-0005is-O9
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugr9-0005L6-Kl
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxm1C062869
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:47 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qnyradcc8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:44 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:29 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-13-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/12] target/ppc: Basic POWER9 bare-metal
 radix MMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

No guest support yet

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-radix64.c | 81 ++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index f596f3c7774e..45a7845cb928 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -30,10 +30,26 @@
 static bool ppc_radix64_get_fully_qualified_addr(CPUPPCState *env, vaddr=
 eaddr,
                                                  uint64_t *lpid, uint64_=
t *pid)
 {
-    /* We don't have HV support yet and shouldn't get here with it set a=
nyway */
-    assert(!msr_hv);
-
-    if (!msr_hv) { /* !MSR[HV] -> Guest */
+    if (msr_hv) { /* MSR[HV] -> Hypervisor/bare metal */
+        switch (eaddr & R_EADDR_QUADRANT) {
+        case R_EADDR_QUADRANT0:
+            *lpid =3D 0;
+            *pid =3D env->spr[SPR_BOOKS_PID];
+            break;
+        case R_EADDR_QUADRANT1:
+            *lpid =3D env->spr[SPR_LPIDR];
+            *pid =3D env->spr[SPR_BOOKS_PID];
+            break;
+        case R_EADDR_QUADRANT2:
+            *lpid =3D env->spr[SPR_LPIDR];
+            *pid =3D 0;
+            break;
+        case R_EADDR_QUADRANT3:
+            *lpid =3D 0;
+            *pid =3D 0;
+            break;
+        }
+    } else {  /* !MSR[HV] -> Guest */
         switch (eaddr & R_EADDR_QUADRANT) {
         case R_EADDR_QUADRANT0: /* Guest application */
             *lpid =3D env->spr[SPR_LPIDR];
@@ -185,21 +201,32 @@ static uint64_t ppc_radix64_walk_tree(PowerPCCPU *c=
pu, vaddr eaddr,
                                  raddr, psize, fault_cause, pte_addr);
 }
=20
+static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t =
*pate)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    if (!(pate->dw0 & PATE0_HR)) {
+        return false;
+    }
+    if (lpid =3D=3D 0 && !msr_hv) {
+        return false;
+    }
+    /* More checks ... */
+    return true;
+}
+
 int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                                  int mmu_idx)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    PPCVirtualHypervisorClass *vhc =3D
-        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+    PPCVirtualHypervisorClass *vhc;
     hwaddr raddr, pte_addr;
     uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
     int page_size, prot, fault_cause =3D 0;
     ppc_v3_pate_t pate;
=20
     assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
-    assert(!msr_hv); /* For now there is no Radix PowerNV Support */
-    assert(cpu->vhyp);
     assert(ppc64_use_proc_tbl(cpu));
=20
     /* Real Mode Access */
@@ -220,7 +247,23 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
     }
=20
     /* Get Process Table */
-    vhc->get_pate(cpu->vhyp, &pate);
+    if (cpu->vhyp) {
+        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->get_pate(cpu->vhyp, &pate);
+    } else {
+        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
+            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
+            return 1;
+        }
+        if (!validate_pate(cpu, lpid, &pate)) {
+            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
+        }
+        /* We don't support guest mode yet */
+        if (lpid !=3D 0) {
+            error_report("PowerNV guest support Unimplemented");
+            exit(1);
+       }
+    }
=20
     /* Index Process Table by PID to Find Corresponding Process Table En=
try */
     offset =3D pid * sizeof(struct prtb_entry);
@@ -255,8 +298,7 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cp=
u, target_ulong eaddr)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    PPCVirtualHypervisorClass *vhc =3D
-        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+    PPCVirtualHypervisorClass *vhc;
     hwaddr raddr, pte_addr;
     uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
     int page_size, fault_cause =3D 0;
@@ -274,7 +316,22 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong eaddr)
     }
=20
     /* Get Process Table */
-    vhc->get_pate(cpu->vhyp, &pate);
+    if (cpu->vhyp) {
+        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->get_pate(cpu->vhyp, &pate);
+    } else {
+        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
+            return -1;
+        }
+        if (!validate_pate(cpu, lpid, &pate)) {
+            return -1;
+        }
+        /* We don't support guest mode yet */
+        if (lpid !=3D 0) {
+            error_report("PowerNV guest support Unimplemented");
+            exit(1);
+       }
+    }
=20
     /* Index Process Table by PID to Find Corresponding Process Table En=
try */
     offset =3D pid * sizeof(struct prtb_entry);
--=20
2.20.1
