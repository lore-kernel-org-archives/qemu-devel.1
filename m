Received: from eggs.gnu.org ([209.51.188.92]:42754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to5-0000tW-5o
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to3-0001Iy-TL
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:25 +1100
Message-Id: <20190310082703.1245-23-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/60] ppc: externalize ppc_get_vcpu_by_pir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

We will use it to get the CPU interrupt presenter in XIVE when the
TIMA is accessed from the indirect page.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 16 ----------------
 hw/ppc/ppc.c         | 16 ++++++++++++++++
 include/hw/ppc/ppc.h |  1 +
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3d5dfef220..9aa81c7f09 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1082,22 +1082,6 @@ static void pnv_ics_resend(XICSFabric *xi)
     }
 }
=20
-static PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
-{
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-        CPUPPCState *env =3D &cpu->env;
-
-        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
-            return cpu;
-        }
-    }
-
-    return NULL;
-}
-
 static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
 {
     PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 9145aeddcb..b2ff99ec66 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1487,3 +1487,19 @@ void PPC_debug_write (void *opaque, uint32_t addr,=
 uint32_t val)
         break;
     }
 }
+
+PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        CPUPPCState *env =3D &cpu->env;
+
+        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 746170f635..4bdcb8bacd 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -4,6 +4,7 @@
 #include "target/ppc/cpu-qom.h"
=20
 void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level);
+PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
=20
 /* PowerPC hardware exceptions management helpers */
 typedef void (*clk_setup_cb)(void *opaque, uint32_t freq);
--=20
2.20.1
