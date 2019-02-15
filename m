Received: from eggs.gnu.org ([209.51.188.92]:33608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrG-0001yk-AY
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrE-0005nz-0p
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55598
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugrD-0005Ja-Ou
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxneO096168
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:47 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qp0u6speq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:44 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:19 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-3-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/12] target/ppci/mmu: Use LPCR:HR to chose
 radix vs. hash translation
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

Now that LPCR:HR is set properly for SPAPR, use it for deciding
the translation type, which also works for bare metal

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-book3s-v3.h | 14 +++++++++-----
 target/ppc/mmu-book3s-v3.c | 11 ++++++++++-
 target/ppc/mmu_helper.c    |  9 ++-------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index fdf80987d7b2..41b77158622a 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -43,14 +43,18 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu=
)
     return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
 }
=20
-static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
+/*
+ * The LPCR:HR bit is a shortcut that avoids having to
+ * dig out the partition table in the fast path. This is
+ * also how the HW uses it.
+ */
+static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
 {
-    PPCVirtualHypervisorClass *vhc =3D
-        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-
-    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
+    return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
 }
=20
+hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr);
+
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                               int mmu_idx);
=20
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index b60df4408f3b..a174e7efc57c 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -26,9 +26,18 @@
 int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                               int mmu_idx)
 {
-    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
+    if (ppc64_v3_radix(cpu)) { /* Guest uses radix */
         return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
     } else { /* Guest uses hash */
         return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
     }
 }
+
+hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr)
+{
+    if (ppc64_v3_radix(cpu)) {
+        return ppc_radix64_get_phys_page_debug(cpu, eaddr);
+    } else {
+        return ppc_hash64_get_phys_page_debug(cpu, eaddr);
+    }
+}
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index cefed34da4f2..ae81ee18ae95 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1342,7 +1342,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf=
, CPUPPCState *env)
         dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
         break;
     case POWERPC_MMU_3_00:
-        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
             /* TODO - Unsupported */
         } else {
             dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
@@ -1497,12 +1497,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, v=
addr addr)
     case POWERPC_MMU_2_07:
         return ppc_hash64_get_phys_page_debug(cpu, addr);
     case POWERPC_MMU_3_00:
-        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
-            return ppc_radix64_get_phys_page_debug(cpu, addr);
-        } else {
-            return ppc_hash64_get_phys_page_debug(cpu, addr);
-        }
-        break;
+        return ppc64_v3_get_phys_page_debug(cpu, addr);
 #endif
=20
     case POWERPC_MMU_32B:
--=20
2.20.1
