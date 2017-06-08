Received: from eggs.gnu.org ([2001:4830:134:3::10]:48278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxiY-0006My-21
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxiU-0007QD-W6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:18 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:51036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIxiU-0007O0-Pt
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:14 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4E1F33EAD0
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 15:43:13 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 08 Jun 2017 15:43:08 +0200
Message-ID: <149692938872.12119.17948850600182624221.stgit@bahia>
In-Reply-To: <149692935202.12119.3614006195497745877.stgit@bahia>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 4/6] xics: drop ICPStateClass::cpu_setup()
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

The cpu_setup() handler is only implemented by xics_kvm, where it really
does a typical "realize" job. Moreover, the realize() handler is called
shortly after cpu_setup(), on the same path.

This patch converts xics_kvm to implement realize() instead of cpu_setup().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |    4 ----
 hw/intc/xics_kvm.c    |   12 ++++++------
 include/hw/ppc/xics.h |    1 -
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index fdbfddffeea5..7ccfb53c55a0 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -324,10 +324,6 @@ static void icp_realize(DeviceState *dev, Error **errp)
     cpu->intc = OBJECT(icp);
     icp->cs = CPU(obj);
 
-    if (icpc->cpu_setup) {
-        icpc->cpu_setup(icp, cpu);
-    }
-
     env = &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER7:
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 41c5b9439562..3091ad3ac2c8 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -115,9 +115,9 @@ static void icp_kvm_reset(ICPState *icp)
     icp_set_kvm_state(icp, 1);
 }
 
-static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
+static void icp_kvm_realize(ICPState *icp, Error **errp)
 {
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = icp->cs;
     KVMEnabledICP *enabled_icp;
     unsigned long vcpu_id = kvm_arch_vcpu_id(cs);
     int ret;
@@ -139,9 +139,9 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
 
     ret = kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd, vcpu_id);
     if (ret < 0) {
-        error_report("Unable to connect CPU%ld to kernel XICS: %s", vcpu_id,
-                     strerror(errno));
-        exit(1);
+        error_setg(errp, "Unable to connect CPU%ld to kernel XICS: %s", vcpu_id,
+                   strerror(errno));
+        return;
     }
     enabled_icp = g_malloc(sizeof(*enabled_icp));
     enabled_icp->vcpu_id = vcpu_id;
@@ -154,7 +154,7 @@ static void icp_kvm_class_init(ObjectClass *klass, void *data)
 
     icpc->pre_save = icp_get_kvm_state;
     icpc->post_load = icp_set_kvm_state;
-    icpc->cpu_setup = icp_kvm_cpu_setup;
+    icpc->realize = icp_kvm_realize;
     icpc->reset = icp_kvm_reset;
 }
 
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 37b8fb1e8817..28d248abad61 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -68,7 +68,6 @@ struct ICPStateClass {
     void (*realize)(ICPState *icp, Error **errp);
     void (*pre_save)(ICPState *icp);
     int (*post_load)(ICPState *icp, int version_id);
-    void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
     void (*reset)(ICPState *icp);
 };
 
