Received: from eggs.gnu.org ([209.51.188.92]:54748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGV-0005zU-5L
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGQ-0001J4-7f
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGP-0001Cs-NO
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:50:58 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mVKU114321
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:49 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2abwtd92-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:48 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:46 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:07 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-3-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/27] ppc: externalize ppc_get_vcpu_by_pir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

We will use it to get the CPU interrupt presenter in XIVE when the
TIMA is accessed from the indirect page.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/ppc.h |  1 +
 hw/ppc/pnv.c         | 16 ----------------
 hw/ppc/ppc.c         | 16 ++++++++++++++++
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 746170f635c6..4bdcb8bacd4e 100644
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
index 3d5dfef220e2..9aa81c7f09c2 100644
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
index 9145aeddcb29..b2ff99ec66a1 100644
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
--=20
2.20.1
