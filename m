Received: from eggs.gnu.org ([209.51.188.92]:33569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrF-0001xQ-3D
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugrD-0005nF-P1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:01:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54496
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugrD-0005LY-II
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:00:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGxqNb144622
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qp0pp2jnf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:00:46 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 17:00:44 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 18:00:25 +0100
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215170029.15641-9-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/12] target/ppc: Fix synchronization of mttcg
 with broadcast TLB flushes
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

Let's use the generic helper tlb_flush_all_cpus_synced() instead
of iterating the CPUs ourselves.

We do lose the optimization of clearing the "other" CPUs "need flush"
flags but this shouldn't be a problem in practice.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/helper_regs.h | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 5efd18049e7c..a2205e1044c9 100644
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
