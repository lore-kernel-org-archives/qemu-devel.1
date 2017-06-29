Received: from eggs.gnu.org ([2001:4830:134:3::10]:34618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHd-0001rp-DK
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHY-000345-74
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39775
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dQNHX-00033L-U0
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5T0OJRp115992
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:03 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcnmqajm4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:03 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 18:26:02 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 19:24:58 -0500
In-Reply-To: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1498695900-1648-4-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 3/5] virpci: introduce
 virPCIIOMMUGroupIterate()
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

This serves a similar purpose to virPCIDeviceAddressIOMMUGroupIterate,
but uses the iommu group number to find matches instead of a device
within the group. We refactor the code to use this new function and
also export it for use in subsequent patches.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 src/util/virpci.c | 42 ++++++++++++++++++++++++++++++------------
 src/util/virpci.h |  3 +++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/src/util/virpci.c b/src/util/virpci.c
index 2c1b758..b842f44 100644
--- a/src/util/virpci.c
+++ b/src/util/virpci.c
@@ -49,6 +49,7 @@
 VIR_LOG_INIT("util.pci");
 
 #define PCI_SYSFS "/sys/bus/pci/"
+#define IOMMU_GROUP_SYSFS "/sys/kernel/iommu_groups/"
 #define PCI_ID_LEN 10   /* "XXXX XXXX" */
 #define PCI_ADDR_LEN 13 /* "XXXX:XX:XX.X" */
 
@@ -2178,16 +2179,13 @@ int virPCIDeviceFileIterate(virPCIDevicePtr dev,
     return ret;
 }
 
-
-/* virPCIDeviceAddressIOMMUGroupIterate:
- *   Call @actor for all devices in the same iommu_group as orig
- *   (including orig itself) Even if there is no iommu_group for the
- *   device, call @actor once for orig.
+/* virPCIIOMMUGroupIterate:
+ *   Call @actor for all devices in a particular iommu_group.
  */
 int
-virPCIDeviceAddressIOMMUGroupIterate(virPCIDeviceAddressPtr orig,
-                                     virPCIDeviceAddressActor actor,
-                                     void *opaque)
+virPCIIOMMUGroupIterate(int iommu_group,
+                        virPCIDeviceAddressActor actor,
+                        void *opaque)
 {
     char *groupPath = NULL;
     DIR *groupDir = NULL;
@@ -2196,13 +2194,11 @@ virPCIDeviceAddressIOMMUGroupIterate(virPCIDeviceAddressPtr orig,
     int direrr;
 
     if (virAsprintf(&groupPath,
-                    PCI_SYSFS "devices/%04x:%02x:%02x.%x/iommu_group/devices",
-                    orig->domain, orig->bus, orig->slot, orig->function) < 0)
+                    IOMMU_GROUP_SYSFS "%d/devices",
+                    iommu_group) < 0)
         goto cleanup;
 
     if (virDirOpenQuiet(&groupDir, groupPath) < 0) {
-        /* just process the original device, nothing more */
-        ret = (actor)(orig, opaque);
         goto cleanup;
     }
 
@@ -2230,6 +2226,28 @@ virPCIDeviceAddressIOMMUGroupIterate(virPCIDeviceAddressPtr orig,
     return ret;
 }
 
+/* virPCIDeviceAddressIOMMUGroupIterate:
+ *   Call @actor for all devices in the same iommu_group as orig
+ *   (including orig itself) Even if there is no iommu_group for the
+ *   device, call @actor once for orig.
+ */
+int
+virPCIDeviceAddressIOMMUGroupIterate(virPCIDeviceAddressPtr orig,
+                                     virPCIDeviceAddressActor actor,
+                                     void *opaque)
+{
+    int ret = -1;
+
+    ret = virPCIIOMMUGroupIterate(virPCIDeviceAddressGetIOMMUGroupNum(orig),
+                                  actor, opaque);
+    if (ret < 0) {
+        /* just process the original device, nothing more */
+        ret = (actor)(orig, opaque);
+    }
+
+    return ret;
+}
+
 
 static int
 virPCIDeviceGetIOMMUGroupAddOne(virPCIDeviceAddressPtr newDevAddr, void *opaque)
diff --git a/src/util/virpci.h b/src/util/virpci.h
index 570684e..5ec1306 100644
--- a/src/util/virpci.h
+++ b/src/util/virpci.h
@@ -176,6 +176,9 @@ typedef int (*virPCIDeviceAddressActor)(virPCIDeviceAddressPtr addr,
 int virPCIDeviceAddressIOMMUGroupIterate(virPCIDeviceAddressPtr orig,
                                          virPCIDeviceAddressActor actor,
                                          void *opaque);
+int virPCIIOMMUGroupIterate(int iommu_group,
+                            virPCIDeviceAddressActor actor,
+                            void *opaque);
 virPCIDeviceListPtr virPCIDeviceGetIOMMUGroupList(virPCIDevicePtr dev);
 int virPCIDeviceAddressGetIOMMUGroupAddresses(virPCIDeviceAddressPtr devAddr,
                                               virPCIDeviceAddressPtr **iommuGroupDevices,
-- 
2.7.4
