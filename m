Received: from eggs.gnu.org ([209.51.188.92]:57817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkq-00050B-0p
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUko-0002TQ-Jl
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:38 +1100
Message-Id: <20190226045304.25618-25-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/50] target/ppc: Fix synchronization of mttcg
 with broadcast TLB flushes
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

Let's use the generic helper tlb_flush_all_cpus_synced() instead
of iterating the CPUs ourselves.

We do lose the optimization of clearing the "other" CPUs "need flush"
flags but this shouldn't be a problem in practice.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215170029.15641-9-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper_regs.h | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 5efd18049e..a2205e1044 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -174,26 +174,19 @@ static inline int hreg_store_msr(CPUPPCState *env, =
target_ulong value,
 static inline void check_tlb_flush(CPUPPCState *env, bool global)
 {
     CPUState *cs =3D CPU(ppc_env_get_cpu(env));
-    if (env->tlb_need_flush & TLB_NEED_LOCAL_FLUSH) {
-        tlb_flush(cs);
-        env->tlb_need_flush &=3D ~TLB_NEED_LOCAL_FLUSH;
-    }
=20
-    /* Propagate TLB invalidations to other CPUs when the guest uses bro=
adcast
-     * TLB invalidation instructions.
-     */
+    /* Handle global flushes first */
     if (global && (env->tlb_need_flush & TLB_NEED_GLOBAL_FLUSH)) {
-        CPUState *other_cs;
-        CPU_FOREACH(other_cs) {
-            if (other_cs !=3D cs) {
-                PowerPCCPU *cpu =3D POWERPC_CPU(other_cs);
-                CPUPPCState *other_env =3D &cpu->env;
-
-                other_env->tlb_need_flush &=3D ~TLB_NEED_LOCAL_FLUSH;
-                tlb_flush(other_cs);
-            }
-        }
         env->tlb_need_flush &=3D ~TLB_NEED_GLOBAL_FLUSH;
+        env->tlb_need_flush &=3D ~TLB_NEED_LOCAL_FLUSH;
+        tlb_flush_all_cpus_synced(cs);
+        return;
+    }
+
+    /* Then handle local ones */
+    if (env->tlb_need_flush & TLB_NEED_LOCAL_FLUSH) {
+        env->tlb_need_flush &=3D ~TLB_NEED_LOCAL_FLUSH;
+        tlb_flush(cs);
     }
 }
 #else
--=20
2.20.1
