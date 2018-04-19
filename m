Received: from eggs.gnu.org ([2001:4830:134:3::10]:58747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xp-0001sl-7w
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xl-0001Xf-Ad
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:47:01 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:34339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98xl-0001X7-3U
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:57 -0400
Received: from player792.ha.ovh.net (unknown [10.109.120.8])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id EF4D2AE8B0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:55 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:29 +0200
Message-Id: <20180419124331.3915-34-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 33/35] ppc: externalize ppc_get_vcpu_by_pir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

We will use it to get the CPU interrupt presenter in XIVE.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c         | 16 ----------------
 hw/ppc/ppc.c         | 16 ++++++++++++++++
 include/hw/ppc/ppc.h |  1 +
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 91452b7eeb01..d07a8ce38e99 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -992,22 +992,6 @@ static void pnv_ics_resend(XICSFabric *xi)
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
--=20
2.13.6
