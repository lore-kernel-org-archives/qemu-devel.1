Received: from eggs.gnu.org ([209.51.188.92]:54781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGW-0005zc-F9
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGR-0001OE-Eo
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35970
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGQ-0001Dv-J9
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:50:58 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268n11K119045
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:51 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r29wr3us4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:50 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:49 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:10 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-6-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/27] ppc/pnv: change the CPU machine_data
 presenter type to Object *
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

The POWER9 PowerNV machine will use a XIVE interrupt presenter type.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_core.h | 2 +-
 hw/ppc/pnv.c              | 6 +++---
 hw/ppc/pnv_core.c         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 9961ea3a92cd..6874bb847a01 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -48,7 +48,7 @@ typedef struct PnvCoreClass {
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
=20
 typedef struct PnvCPUState {
-    struct ICPState *icp;
+    Object *intc;
 } PnvCPUState;
=20
 static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9aa81c7f09c2..b90d03711a05 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -684,7 +684,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
         return;
     }
=20
-    pnv_cpu->icp =3D ICP(obj);
+    pnv_cpu->intc =3D obj;
 }
=20
 /*
@@ -1086,7 +1086,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
 {
     PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
=20
-    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
+    return cpu ? ICP(pnv_cpu_state(cpu)->intc) : NULL;
 }
=20
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
@@ -1099,7 +1099,7 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
+        icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7c806da720c6..38179cdc53dc 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -198,7 +198,7 @@ static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
     PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
=20
     qemu_unregister_reset(pnv_cpu_reset, cpu);
-    object_unparent(OBJECT(pnv_cpu_state(cpu)->icp));
+    object_unparent(OBJECT(pnv_cpu_state(cpu)->intc));
     cpu_remove_sync(CPU(cpu));
     cpu->machine_data =3D NULL;
     g_free(pnv_cpu);
--=20
2.20.1
