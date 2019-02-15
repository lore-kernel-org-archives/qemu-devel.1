Received: from eggs.gnu.org ([209.51.188.92]:50751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqc-000471-Fw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqa-0005Pl-Gz
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41692
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubqY-0005J1-Hd
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:00 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXxjc009250
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:39:55 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qnvc2s0ur-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:39:55 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:39:53 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:39:48 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023078871.1011724.3083923389814185598.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 01/10] xics: Explicitely call KVM ICP methods
 from the common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

The pre_save(), post_load() and synchronize_state() methods of the
ICPStateClass type are really KVM only things. Make that obvious
by dropping the indirections and directly calling the KVM functions
instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |   24 +++++++++++-------------
 hw/intc/xics_kvm.c    |   12 ++++--------
 include/hw/ppc/xics.h |    9 +++++----
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 16e8ffa2aaf7..988b53abd17d 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -37,18 +37,18 @@
 #include "qapi/visitor.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
+#include "sysemu/kvm.h"
 
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
-    ICPStateClass *icpc = ICP_GET_CLASS(icp);
     int cpu_index = icp->cs ? icp->cs->cpu_index : -1;
 
     if (!icp->output) {
         return;
     }
 
-    if (icpc->synchronize_state) {
-        icpc->synchronize_state(icp);
+    if (kvm_irqchip_in_kernel()) {
+        icp_synchronize_state(icp);
     }
 
     monitor_printf(mon, "CPU %d XIRR=%08x (%p) PP=%02x MFRR=%02x\n",
@@ -252,25 +252,23 @@ static void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
     }
 }
 
-static int icp_dispatch_pre_save(void *opaque)
+static int icp_pre_save(void *opaque)
 {
     ICPState *icp = opaque;
-    ICPStateClass *info = ICP_GET_CLASS(icp);
 
-    if (info->pre_save) {
-        info->pre_save(icp);
+    if (kvm_irqchip_in_kernel()) {
+        icp_get_kvm_state(icp);
     }
 
     return 0;
 }
 
-static int icp_dispatch_post_load(void *opaque, int version_id)
+static int icp_post_load(void *opaque, int version_id)
 {
     ICPState *icp = opaque;
-    ICPStateClass *info = ICP_GET_CLASS(icp);
 
-    if (info->post_load) {
-        return info->post_load(icp, version_id);
+    if (kvm_irqchip_in_kernel()) {
+        return icp_set_kvm_state(icp);
     }
 
     return 0;
@@ -280,8 +278,8 @@ static const VMStateDescription vmstate_icp_server = {
     .name = "icp/server",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_save = icp_dispatch_pre_save,
-    .post_load = icp_dispatch_post_load,
+    .pre_save = icp_pre_save,
+    .post_load = icp_post_load,
     .fields = (VMStateField[]) {
         /* Sanity check */
         VMSTATE_UINT32(xirr, ICPState),
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index dff13300504c..7efa99b8b434 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -54,7 +54,7 @@ static QLIST_HEAD(, KVMEnabledICP)
 /*
  * ICP-KVM
  */
-static void icp_get_kvm_state(ICPState *icp)
+void icp_get_kvm_state(ICPState *icp)
 {
     uint64_t state;
     int ret;
@@ -83,14 +83,14 @@ static void do_icp_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
     icp_get_kvm_state(arg.host_ptr);
 }
 
-static void icp_synchronize_state(ICPState *icp)
+void icp_synchronize_state(ICPState *icp)
 {
     if (icp->cs) {
         run_on_cpu(icp->cs, do_icp_synchronize_state, RUN_ON_CPU_HOST_PTR(icp));
     }
 }
 
-static int icp_set_kvm_state(ICPState *icp, int version_id)
+int icp_set_kvm_state(ICPState *icp)
 {
     uint64_t state;
     int ret;
@@ -121,7 +121,7 @@ static void icp_kvm_reset(DeviceState *dev)
 
     icpc->parent_reset(dev);
 
-    icp_set_kvm_state(ICP(dev), 1);
+    icp_set_kvm_state(ICP(dev));
 }
 
 static void icp_kvm_realize(DeviceState *dev, Error **errp)
@@ -178,10 +178,6 @@ static void icp_kvm_class_init(ObjectClass *klass, void *data)
                                     &icpc->parent_realize);
     device_class_set_parent_reset(dc, icp_kvm_reset,
                                   &icpc->parent_reset);
-
-    icpc->pre_save = icp_get_kvm_state;
-    icpc->post_load = icp_set_kvm_state;
-    icpc->synchronize_state = icp_synchronize_state;
 }
 
 static const TypeInfo icp_kvm_info = {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index fad786e8b22d..3236ccec924c 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -66,10 +66,6 @@ struct ICPStateClass {
 
     DeviceRealize parent_realize;
     DeviceReset parent_reset;
-
-    void (*pre_save)(ICPState *icp);
-    int (*post_load)(ICPState *icp, int version_id);
-    void (*synchronize_state)(ICPState *icp);
 };
 
 struct ICPState {
@@ -203,4 +199,9 @@ void icp_resend(ICPState *ss);
 Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
                    Error **errp);
 
+/* KVM */
+void icp_get_kvm_state(ICPState *icp);
+int icp_set_kvm_state(ICPState *icp);
+void icp_synchronize_state(ICPState *icp);
+
 #endif /* XICS_H */
