Received: from eggs.gnu.org ([2001:4830:134:3::10]:34581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHc-0001rj-KJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHX-00033f-LM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dQNHX-00032W-AN
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5T0OaDX009458
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:02 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bcgxudvy7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:01 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 20:26:00 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 19:24:56 -0500
In-Reply-To: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1498695900-1648-2-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 1/5] virhostdev: factor release out from
 reattach and export it for use later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libvir-list@redhat.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, alex.williamson@redhat.com, abologna@redhat.com, laine@laine.org, pkrempa@redhat.com, berrange@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 src/libvirt_private.syms |  1 +
 src/util/virhostdev.c    | 83 ++++++++++++++++++++++++++++++++++++++++--------
 src/util/virhostdev.h    |  8 +++++
 3 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/src/libvirt_private.syms b/src/libvirt_private.syms
index c1e9471..2bd3581 100644
--- a/src/libvirt_private.syms
+++ b/src/libvirt_private.syms
@@ -1798,6 +1798,7 @@ virHostdevReAttachPCIDevices;
 virHostdevReAttachSCSIDevices;
 virHostdevReAttachSCSIVHostDevices;
 virHostdevReAttachUSBDevices;
+virHostdevReleasePCIDevices;
 virHostdevUpdateActiveDomainDevices;
 virHostdevUpdateActiveMediatedDevices;
 virHostdevUpdateActivePCIDevices;
diff --git a/src/util/virhostdev.c b/src/util/virhostdev.c
index 579563c..2cd3f34 100644
--- a/src/util/virhostdev.c
+++ b/src/util/virhostdev.c
@@ -932,16 +932,20 @@ virHostdevReattachPCIDevice(virHostdevManagerPtr mgr,
     }
 }
 
-/* @oldStateDir:
- * For upgrade purpose: see virHostdevRestoreNetConfig
+/*
+ * Move PCI devices to inactive list and prepare them for reattaching
+ * to host driver
+ *
+ * Pre-condition: inactivePCIHostdevs & activePCIHostdevs
+ * are locked
  */
-void
-virHostdevReAttachPCIDevices(virHostdevManagerPtr mgr,
-                             const char *drv_name,
-                             const char *dom_name,
-                             virDomainHostdevDefPtr *hostdevs,
-                             int nhostdevs,
-                             const char *oldStateDir)
+static void
+virHostdevReleasePCIDevicesInternal(virHostdevManagerPtr mgr,
+                                    const char *drv_name,
+                                    const char *dom_name,
+                                    virDomainHostdevDefPtr *hostdevs,
+                                    int nhostdevs,
+                                    const char *oldStateDir)
 {
     virPCIDeviceListPtr pcidevs;
     size_t i;
@@ -949,9 +953,6 @@ virHostdevReAttachPCIDevices(virHostdevManagerPtr mgr,
     if (!nhostdevs)
         return;
 
-    virObjectLock(mgr->activePCIHostdevs);
-    virObjectLock(mgr->inactivePCIHostdevs);
-
     if (!(pcidevs = virHostdevGetPCIHostDeviceList(hostdevs, nhostdevs))) {
         VIR_ERROR(_("Failed to allocate PCI device list: %s"),
                   virGetLastErrorMessage());
@@ -1056,8 +1057,62 @@ virHostdevReAttachPCIDevices(virHostdevManagerPtr mgr,
         }
     }
 
-    /* Step 5: Reattach managed devices to their host drivers; unmanaged
-     *         devices don't need to be processed further */
+ cleanup:
+    virObjectUnref(pcidevs);
+}
+
+void
+virHostdevReleasePCIDevices(virHostdevManagerPtr mgr,
+                            const char *drv_name,
+                            const char *dom_name,
+                            virDomainHostdevDefPtr *hostdevs,
+                            int nhostdevs,
+                            const char *oldStateDir)
+{
+    virObjectLock(mgr->activePCIHostdevs);
+    virObjectLock(mgr->inactivePCIHostdevs);
+
+
+    virHostdevReleasePCIDevicesInternal(mgr, drv_name, dom_name,
+                                        hostdevs, nhostdevs, oldStateDir);
+
+    virObjectUnlock(mgr->activePCIHostdevs);
+    virObjectUnlock(mgr->inactivePCIHostdevs);
+}
+
+/* @oldStateDir:
+ * For upgrade purpose: see virHostdevRestoreNetConfig
+ */
+void
+virHostdevReAttachPCIDevices(virHostdevManagerPtr mgr,
+                             const char *drv_name,
+                             const char *dom_name,
+                             virDomainHostdevDefPtr *hostdevs,
+                             int nhostdevs,
+                             const char *oldStateDir)
+{
+    virPCIDeviceListPtr pcidevs;
+    size_t i;
+
+    if (!nhostdevs)
+        return;
+
+    virObjectLock(mgr->activePCIHostdevs);
+    virObjectLock(mgr->inactivePCIHostdevs);
+
+    /* Release PCI devices to the inactive list */
+    virHostdevReleasePCIDevicesInternal(mgr, drv_name, dom_name,
+                                        hostdevs, nhostdevs, oldStateDir);
+
+    if (!(pcidevs = virHostdevGetPCIHostDeviceList(hostdevs, nhostdevs))) {
+        VIR_ERROR(_("Failed to allocate PCI device list: %s"),
+                  virGetLastErrorMessage());
+        virResetLastError();
+        goto cleanup;
+    }
+
+    /* Reattach managed devices to their host drivers; unmanaged
+     * devices don't need to be processed further */
     for (i = 0; i < virPCIDeviceListCount(pcidevs); i++) {
         virPCIDevicePtr pci = virPCIDeviceListGet(pcidevs, i);
         virPCIDevicePtr actual;
diff --git a/src/util/virhostdev.h b/src/util/virhostdev.h
index 54e1c66..fbc7fbd 100644
--- a/src/util/virhostdev.h
+++ b/src/util/virhostdev.h
@@ -114,6 +114,14 @@ virHostdevReAttachPCIDevices(virHostdevManagerPtr hostdev_mgr,
                              const char *oldStateDir)
     ATTRIBUTE_NONNULL(1);
 void
+virHostdevReleasePCIDevices(virHostdevManagerPtr mgr,
+                            const char *drv_name,
+                            const char *dom_name,
+                            virDomainHostdevDefPtr *hostdevs,
+                            int nhostdevs,
+                            const char *oldStateDir)
+    ATTRIBUTE_NONNULL(1);
+void
 virHostdevReAttachUSBDevices(virHostdevManagerPtr hostdev_mgr,
                               const char *drv_name,
                               const char *dom_name,
-- 
2.7.4
