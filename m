Received: from eggs.gnu.org ([209.51.188.92]:57622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkj-0004tq-H3
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkh-0002Bc-Or
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:33 +1100
Message-Id: <20190226045304.25618-20-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/50] target/ppc/mmu: Use LPCR:HR to chose
 radix vs. hash translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Now that LPCR:HR is set properly for SPAPR, use it for deciding
the translation type, which also works for bare metal

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215170029.15641-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-book3s-v3.c | 11 ++++++++++-
 target/ppc/mmu-book3s-v3.h | 14 +++++++++-----
 target/ppc/mmu_helper.c    |  9 ++-------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index b60df4408f..a174e7efc5 100644
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
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index fdf80987d7..41b7715862 100644
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
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index bcf19da61d..4a6be4d63b 100644
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
@@ -1489,12 +1489,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, v=
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
