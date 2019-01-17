Received: from eggs.gnu.org ([209.51.188.92]:47967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2Ur-0002EP-CL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2Ul-0005Ti-O7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55152
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gk2Uh-0005Ok-Vy
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:45 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0H7rdFh049084
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:53:40 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q2mjxtn5s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:53:39 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 17 Jan 2019 07:53:38 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 17 Jan 2019 08:53:25 +0100
In-Reply-To: <20190117075327.22194-1-clg@kaod.org>
References: <20190117075327.22194-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190117075327.22194-3-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] ppc/pnv: introduce a CPU machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Include the interrupt presenter under the machine_data as we plan to
remove it from under PowerPCCPU

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_core.h |  9 +++++++++
 hw/ppc/pnv.c              |  7 ++++---
 hw/ppc/pnv_core.c         | 12 +++++++++++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 447ae761f7ae..9961ea3a92cd 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -47,4 +47,13 @@ typedef struct PnvCoreClass {
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
=20
+typedef struct PnvCPUState {
+    struct ICPState *icp;
+} PnvCPUState;
+
+static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
+{
+    return (PnvCPUState *)cpu->machine_data;
+}
+
 #endif /* _PPC_PNV_CORE_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d84acef55b69..da540860a2b0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -673,6 +673,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
 {
     Error *local_err =3D NULL;
     Object *obj;
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
=20
     obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get_m=
achine()),
                      &local_err);
@@ -681,7 +682,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
         return;
     }
=20
-    cpu->icp =3D ICP(obj);
+    pnv_cpu->icp =3D ICP(obj);
 }
=20
 /*
@@ -1099,7 +1100,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
 {
     PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
=20
-    return cpu ? cpu->icp : NULL;
+    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
 }
=20
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
@@ -1112,7 +1113,7 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(cpu->icp, mon);
+        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index b98f277f1e02..7c806da720c6 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -155,7 +155,10 @@ static void pnv_core_realize(DeviceState *dev, Error=
 **errp)
=20
     pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
+        PowerPCCPU *cpu;
+
         obj =3D object_new(typename);
+        cpu =3D POWERPC_CPU(obj);
=20
         pc->threads[i] =3D POWERPC_CPU(obj);
=20
@@ -163,6 +166,9 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
         object_property_add_child(OBJECT(pc), name, obj, &error_abort);
         object_property_add_alias(obj, "core-pir", OBJECT(pc),
                                   "pir", &error_abort);
+
+        cpu->machine_data =3D g_new0(PnvCPUState, 1);
+
         object_unref(obj);
     }
=20
@@ -189,9 +195,13 @@ err:
=20
 static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
 {
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
+
     qemu_unregister_reset(pnv_cpu_reset, cpu);
-    object_unparent(OBJECT(cpu->icp));
+    object_unparent(OBJECT(pnv_cpu_state(cpu)->icp));
     cpu_remove_sync(CPU(cpu));
+    cpu->machine_data =3D NULL;
+    g_free(pnv_cpu);
     object_unparent(OBJECT(cpu));
 }
=20
--=20
2.20.1
