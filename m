Received: from eggs.gnu.org ([2001:4830:134:3::10]:50336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewT1n-0003Ck-6m
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewT1j-0002Bc-8k
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:43 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:58780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ewT1i-0002AR-MD
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:39 -0400
Received: from player734.ha.ovh.net (unknown [10.109.105.37])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 2F351CE9AA
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:34:37 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 15 Mar 2018 13:34:02 +0000
Message-Id: <20180315133402.13470-5-clg@kaod.org>
In-Reply-To: <20180315133402.13470-1-clg@kaod.org>
References: <20180315133402.13470-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/4] target/ppc: generalize check on radix
 when in HV mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On a POWER9 processor, the first doubleword of the partition table
entry (as pointed to by the PTCR) indicates whether the host uses HPT
or Radix Tree translation for that partition. Use that bit to check
for radix mode on pseries and powernv QEMU machines.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v2:

 - reworked ppc64_v3_radix() to distinguish pseries machine from
   powernv machines
 - kept ppc64_radix_guest()

 Changes since v1:

 - fixed commit log
 - introduced ppc64_v3_get_patbe0()
 - renamed ppc64_radix() in ppc64_v3_radix()

 target/ppc/mmu-book3s-v3.c | 23 +++++++++++++++++++++--
 target/ppc/mmu-book3s-v3.h |  4 +++-
 target/ppc/mmu_helper.c    |  4 ++--
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index b60df4408f3b..89edbb6abc5c 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -19,16 +19,35 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "qemu/error-report.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 #include "mmu-radix64.h"
=20
+bool ppc64_v3_radix(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    /* sPAPR machine */
+    if (cpu->vhyp) {
+        return ppc64_radix_guest(cpu);
+    }
+
+    /* PowerNV machine - only HV mode is supported */
+    if (msr_hv) {
+        return ppc64_v3_get_patbe0(cpu) & PATBE0_HR;
+    } else {
+        error_report("PowerNV guest support Unimplemented");
+        exit(1);
+    }
+}
+
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                               int mmu_idx)
 {
-    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
+    if (ppc64_v3_radix(cpu)) {
         return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
-    } else { /* Guest uses hash */
+    } else {
         return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
     }
 }
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index a7ab580c3140..9721791d2dd3 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -29,7 +29,8 @@
 #define PTCR_PATS               0x000000000000001FULL /* Partition Table=
 Size */
=20
 /* Partition Table Entry Fields */
-#define PATBE1_GR 0x8000000000000000
+#define PATBE0_HR               PPC_BIT(0)            /* 1:Host Radix  0=
:HPT  */
+#define PATBE1_GR               PPC_BIT(0)            /* 1:Guest Radix 0=
:HPT  */
=20
 /* Process Table Entry */
 struct prtb_entry {
@@ -50,6 +51,7 @@ static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
=20
     return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
 }
+bool ppc64_v3_radix(PowerPCCPU *cpu);
=20
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                               int mmu_idx);
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 03009eee723a..fba203cdef18 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1285,7 +1285,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf=
, CPUPPCState *env)
         dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
         break;
     case POWERPC_MMU_VER_3_00:
-        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
             /* TODO - Unsupported */
         } else {
             dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
@@ -1431,7 +1431,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, va=
ddr addr)
     case POWERPC_MMU_VER_2_07:
         return ppc_hash64_get_phys_page_debug(cpu, addr);
     case POWERPC_MMU_VER_3_00:
-        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
             return ppc_radix64_get_phys_page_debug(cpu, addr);
         } else {
             return ppc_hash64_get_phys_page_debug(cpu, addr);
--=20
2.13.6
