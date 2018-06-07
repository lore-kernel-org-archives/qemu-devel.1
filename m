Received: from eggs.gnu.org ([2001:4830:134:3::10]:39512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDW-0003Sy-4Y
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDR-0004d0-En
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:50 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:39613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxDR-0004cK-7t
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:45 -0400
Received: from player169.ha.ovh.net (unknown [10.109.108.113])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id EBF8FB5978
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:43 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:50:02 +0200
Message-Id: <20180607155003.1580-28-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 27/28] ppc: externalize ppc_get_vcpu_by_pir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

We will use it to get the CPU interrupt presenter in XIVE.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/ppc.h |  1 +
 hw/ppc/pnv.c         | 16 ----------------
 hw/ppc/ppc.c         | 16 ++++++++++++++++
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index ff0ac306be72..c8e54544e563 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 77caaea64b2f..e7bc4534e63d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1030,22 +1030,6 @@ static void pnv_ics_resend(XICSFabric *xi)
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
index ec4be25f4994..9292f986eba7 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1358,3 +1358,19 @@ void PPC_debug_write (void *opaque, uint32_t addr,=
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
--=20
2.13.6
