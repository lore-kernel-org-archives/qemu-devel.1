Received: from eggs.gnu.org ([2001:4830:134:3::10]:46809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dB05x-0006Jn-Je
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dB05u-0008OM-HB
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:38:33 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:46075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dB05u-0008O2-9l
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:38:30 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 87E3DD2CE1
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:38:27 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 17 May 2017 16:38:20 +0200
Message-ID: <149503190026.11264.1637374942003022823.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] xics_kvm: cache already enabled vCPU ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Since commit a45863bda90d ("xics_kvm: Don't enable KVM_CAP_IRQ_XICS if
already enabled"), we were able to re-hotplug a vCPU that had been hot-
unplugged ealier, thanks to a boolean flag in ICPState that we set when
enabling KVM_CAP_IRQ_XICS.

This could work because the lifecycle of all ICPState objects was the
same as the machine. Commit 5bc8d26de20c ("spapr: allocate the ICPState
object from under sPAPRCPUCore") broke this assumption and now we always
pass a freshly allocated ICPState object (ie, with the flag unset) to
icp_kvm_cpu_setup().

This cause re-hotplug to fail with:

Unable to connect CPU8 to kernel XICS: Device or resource busy

Let's fix this by caching all the vCPU ids for which KVM_CAP_IRQ_XICS was
enabled. This also drops the now useless boolean flag from ICPState.

Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c    |   27 ++++++++++++++++++++-------
 include/hw/ppc/xics.h |    1 -
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index dd93531ae376..dd7f29846235 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -42,6 +42,14 @@
 
 static int kernel_xics_fd = -1;
 
+typedef struct KVMEnabledICP {
+    unsigned long vcpu_id;
+    QLIST_ENTRY(KVMEnabledICP) node;
+} KVMEnabledICP;
+
+static QLIST_HEAD(, KVMEnabledICP)
+    kvm_enabled_icps = QLIST_HEAD_INITIALIZER(&kvm_enabled_icps);
+
 /*
  * ICP-KVM
  */
@@ -121,6 +129,8 @@ static void icp_kvm_reset(void *dev)
 static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
+    KVMEnabledICP *enabled_icp;
+    unsigned long vcpu_id = kvm_arch_vcpu_id(cs);
     int ret;
 
     if (kernel_xics_fd == -1) {
@@ -132,18 +142,21 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
      * which was hot-removed earlier we don't have to renable
      * KVM_CAP_IRQ_XICS capability again.
      */
-    if (icp->cap_irq_xics_enabled) {
-        return;
+    QLIST_FOREACH(enabled_icp, &kvm_enabled_icps, node) {
+        if (enabled_icp->vcpu_id == vcpu_id) {
+            return;
+        }
     }
 
-    ret = kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,
-                              kvm_arch_vcpu_id(cs));
+    ret = kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd, vcpu_id);
     if (ret < 0) {
-        error_report("Unable to connect CPU%ld to kernel XICS: %s",
-                     kvm_arch_vcpu_id(cs), strerror(errno));
+        error_report("Unable to connect CPU%ld to kernel XICS: %s", vcpu_id,
+                     strerror(errno));
         exit(1);
     }
-    icp->cap_irq_xics_enabled = true;
+    enabled_icp = g_malloc(sizeof(*enabled_icp));
+    enabled_icp->vcpu_id = vcpu_id;
+    QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
 }
 
 static void icp_kvm_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index d6cb51f3ad5d..a3073f90533a 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -81,7 +81,6 @@ struct ICPState {
     uint8_t pending_priority;
     uint8_t mfrr;
     qemu_irq output;
-    bool cap_irq_xics_enabled;
 
     XICSFabric *xics;
 };
