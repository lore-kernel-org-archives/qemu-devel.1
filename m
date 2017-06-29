Received: from eggs.gnu.org ([2001:4830:134:3::10]:34652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHg-0001s3-Lq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHZ-000364-Vz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58118
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dQNHZ-00034v-PF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5T0Nijf044627
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:05 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcpdgh4t2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:04 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 18:26:04 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 19:24:59 -0500
In-Reply-To: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1498695900-1648-5-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 4/5] qemu: hotplug: unbind VFIO devices as
 a group
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

Currently we bind a managed hostdev back to the host driver (or
"unbind" from the perspective of the stub driver) immediately upon
receiving a DEVICE_DELETED event from QEMU. In cases where we have
more one device from the group attached to a guest, this runs the risk
of putting the group in a "non-viable" state where both a guest and
host are using devices from a group simultaneously.

This patch addresses this by deferring the unbind step until all
hostdevs from a group have been detached from the guest. In the
meantime, they are left on the drvManager's inactiveList, in a similar
state as they would be if they were unmanaged devices that were bound
to VFIO via nodedev-detach but not yet plugged into a guest.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 src/libvirt_private.syms |  3 ++
 src/qemu/qemu_hostdev.c  | 16 +++++++++
 src/qemu/qemu_hostdev.h  |  4 +++
 src/qemu/qemu_hotplug.c  | 16 ++++++++-
 src/util/virhostdev.c    | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/util/virhostdev.h    |  8 +++++
 src/util/virpci.c        | 27 +++++++++++++++
 src/util/virpci.h        |  1 +
 8 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/src/libvirt_private.syms b/src/libvirt_private.syms
index 2bd3581..ba7fa39 100644
--- a/src/libvirt_private.syms
+++ b/src/libvirt_private.syms
@@ -1783,6 +1783,8 @@ virHostCPUStatsAssign;
 virHostdevFindUSBDevice;
 virHostdevIsSCSIDevice;
 virHostdevManagerGetDefault;
+virHostdevPCIDeviceGroupUnbind;
+virHostdevPCIDeviceGroupUnbindable;
 virHostdevPCINodeDeviceDetach;
 virHostdevPCINodeDeviceReAttach;
 virHostdevPCINodeDeviceReset;
@@ -2342,6 +2344,7 @@ virPCIDeviceWaitForCleanup;
 virPCIEDeviceInfoFree;
 virPCIGetDeviceAddressFromSysfsLink;
 virPCIGetHeaderType;
+virPCIGetIOMMUGroupList;
 virPCIGetNetName;
 virPCIGetPhysicalFunction;
 virPCIGetVirtualFunctionIndex;
diff --git a/src/qemu/qemu_hostdev.c b/src/qemu/qemu_hostdev.c
index 73d26f4..fdc52fe 100644
--- a/src/qemu/qemu_hostdev.c
+++ b/src/qemu/qemu_hostdev.c
@@ -384,6 +384,22 @@ qemuHostdevPrepareDomainDevices(virQEMUDriverPtr driver,
 }
 
 void
+qemuHostdevReleasePCIDevices(virQEMUDriverPtr driver,
+                             const char *name,
+                             virDomainHostdevDefPtr *hostdevs,
+                             int nhostdevs)
+{
+    virQEMUDriverConfigPtr cfg = virQEMUDriverGetConfig(driver);
+    const char *oldStateDir = cfg->stateDir;
+    virHostdevManagerPtr hostdev_mgr = driver->hostdevMgr;
+
+    virHostdevReleasePCIDevices(hostdev_mgr, QEMU_DRIVER_NAME, name,
+                                hostdevs, nhostdevs, oldStateDir);
+
+    virObjectUnref(cfg);
+}
+
+void
 qemuHostdevReAttachPCIDevices(virQEMUDriverPtr driver,
                               const char *name,
                               virDomainHostdevDefPtr *hostdevs,
diff --git a/src/qemu/qemu_hostdev.h b/src/qemu/qemu_hostdev.h
index 9a7c7f1..b010085 100644
--- a/src/qemu/qemu_hostdev.h
+++ b/src/qemu/qemu_hostdev.h
@@ -74,6 +74,10 @@ void qemuHostdevReAttachPCIDevices(virQEMUDriverPtr driver,
                                    const char *name,
                                    virDomainHostdevDefPtr *hostdevs,
                                    int nhostdevs);
+void qemuHostdevReleasePCIDevices(virQEMUDriverPtr driver,
+                                  const char *name,
+                                  virDomainHostdevDefPtr *hostdevs,
+                                  int nhostdevs);
 void qemuHostdevReAttachUSBDevices(virQEMUDriverPtr driver,
                                    const char *name,
                                    virDomainHostdevDefPtr *hostdevs,
diff --git a/src/qemu/qemu_hotplug.c b/src/qemu/qemu_hotplug.c
index b557e82..af5ee6f 100644
--- a/src/qemu/qemu_hotplug.c
+++ b/src/qemu/qemu_hotplug.c
@@ -3896,7 +3896,10 @@ qemuDomainRemoveHostDevice(virQEMUDriverPtr driver,
 
     switch ((virDomainHostdevSubsysType) hostdev->source.subsys.type) {
     case VIR_DOMAIN_HOSTDEV_SUBSYS_TYPE_PCI:
-        qemuHostdevReAttachPCIDevices(driver, vm->def->name, &hostdev, 1);
+        if (is_vfio)
+            qemuHostdevReleasePCIDevices(driver, vm->def->name, &hostdev, 1);
+        else
+            qemuHostdevReAttachPCIDevices(driver, vm->def->name, &hostdev, 1);
         qemuDomainReleaseDeviceAddress(vm, hostdev->info, NULL);
         /* QEMU might no longer need to lock as much memory, eg. we just
          * detached the last VFIO device, so adjust the limit here */
@@ -3925,6 +3928,17 @@ qemuDomainRemoveHostDevice(virQEMUDriverPtr driver,
         virDomainNetDefFree(net);
     }
 
+    if (is_vfio) {
+        int iommu_group =
+            virPCIDeviceAddressGetIOMMUGroupNum(&hostdev->source.subsys.u.pci.addr);
+        if (virHostdevPCIDeviceGroupUnbindable(driver->hostdevMgr,
+                                               iommu_group)) {
+            virHostdevPCIDeviceGroupUnbind(driver->hostdevMgr,
+                                           iommu_group);
+        }
+    }
+
+
     ret = 0;
 
  cleanup:
diff --git a/src/util/virhostdev.c b/src/util/virhostdev.c
index 2cd3f34..a7f04fe 100644
--- a/src/util/virhostdev.c
+++ b/src/util/virhostdev.c
@@ -905,6 +905,96 @@ virHostdevPreparePCIDevices(virHostdevManagerPtr mgr,
     return ret;
 }
 
+static bool
+virHostdevPCIDeviceUnbindableInternal(virHostdevManagerPtr mgr,
+                                      int iommu_group)
+{
+    struct virHostdevIsPCINodeDeviceUsedData data = { mgr, NULL, true };
+
+    if (virPCIIOMMUGroupIterate(iommu_group,
+                                virHostdevIsPCINodeDeviceUsed,
+                                &data) < 0) {
+        VIR_DEBUG("IOMMU group %d is not unbindable", iommu_group);
+        return false;
+    }
+
+    VIR_DEBUG("IOMMU group %d is unbindable", iommu_group);
+    return true;
+}
+
+/*
+ * Check if devices within IOMMU group are in use by any domains
+ */
+bool
+virHostdevPCIDeviceGroupUnbindable(virHostdevManagerPtr mgr,
+                                   int iommu_group)
+{
+    bool result;
+
+    virObjectLock(mgr->activePCIHostdevs);
+    result = virHostdevPCIDeviceUnbindableInternal(mgr, iommu_group);
+    virObjectUnlock(mgr->activePCIHostdevs);
+
+    return result;
+}
+
+/*
+ * Confirm all devices in IOMMU group are in inactiveList
+ * before attempting to reattach to host driver. Devices in IOMMU
+ * group that aren't in either activeList or inactiveList are considered
+ * outside our control, so we treat them as inactive as well.
+ *
+ * Callers can check virHostdevPCIDeviceGroupUnbindable() beforehand
+ * for some indication that the group is ready for reattach to the
+ * host, but since it's possible for a hostdev from the group to get
+ * re-attached to a guest prior to subsequently calling this function
+ * there is no guarantee of this, which should be fine since it would
+ * only be immediately rebound to the stub driver anyway.
+ */
+void
+virHostdevPCIDeviceGroupUnbind(virHostdevManagerPtr mgr,
+                               int iommu_group)
+{
+    virPCIDeviceListPtr pcidevs = NULL;
+    size_t i;
+
+    virObjectLock(mgr->activePCIHostdevs);
+    virObjectLock(mgr->inactivePCIHostdevs);
+
+    if (!virHostdevPCIDeviceUnbindableInternal(mgr, iommu_group)) {
+        VIR_DEBUG("IOMMU group %d still in use, deferring reattach "
+                  "of PCI devices to host", iommu_group);
+        goto cleanup;
+    }
+
+    pcidevs = virPCIGetIOMMUGroupList(iommu_group);
+    for (i = 0; i < virPCIDeviceListCount(pcidevs); i++) {
+        virPCIDevicePtr actual, pci = virPCIDeviceListGet(pcidevs, i);
+        virPCIDeviceAddressPtr devAddr = virPCIDeviceGetAddress(pci);
+
+        actual = virPCIDeviceListFindByIDs(mgr->inactivePCIHostdevs,
+                                           devAddr->domain,
+                                           devAddr->bus,
+                                           devAddr->slot,
+                                           devAddr->function);
+        if (actual) {
+            VIR_DEBUG("Reattaching PCI device %s", virPCIDeviceGetName(actual));
+            if (virPCIDeviceGetManaged(actual))
+                if (virPCIDeviceReattach(actual, mgr->activePCIHostdevs,
+                                         mgr->inactivePCIHostdevs) < 0) {
+                    VIR_ERROR(_("Failed to re-attach PCI device: %s"),
+                              virGetLastErrorMessage());
+                    virResetLastError();
+                }
+        }
+    }
+
+ cleanup:
+    virObjectUnref(pcidevs);
+    virObjectUnlock(mgr->activePCIHostdevs);
+    virObjectUnlock(mgr->inactivePCIHostdevs);
+}
+
 /*
  * Pre-condition: inactivePCIHostdevs & activePCIHostdevs
  * are locked
diff --git a/src/util/virhostdev.h b/src/util/virhostdev.h
index fbc7fbd..2ab8101 100644
--- a/src/util/virhostdev.h
+++ b/src/util/virhostdev.h
@@ -122,6 +122,14 @@ virHostdevReleasePCIDevices(virHostdevManagerPtr mgr,
                             const char *oldStateDir)
     ATTRIBUTE_NONNULL(1);
 void
+virHostdevPCIDeviceGroupUnbind(virHostdevManagerPtr mgr,
+                               int iommu_group)
+    ATTRIBUTE_NONNULL(1);
+bool
+virHostdevPCIDeviceGroupUnbindable(virHostdevManagerPtr mgr,
+                                   int iommu_group)
+    ATTRIBUTE_NONNULL(1);
+void
 virHostdevReAttachUSBDevices(virHostdevManagerPtr hostdev_mgr,
                               const char *drv_name,
                               const char *dom_name,
diff --git a/src/util/virpci.c b/src/util/virpci.c
index b842f44..a8e5190 100644
--- a/src/util/virpci.c
+++ b/src/util/virpci.c
@@ -2298,6 +2298,33 @@ virPCIDeviceGetIOMMUGroupList(virPCIDevicePtr dev)
 }
 
 
+/*
+ * virPCIGetIOMMUGroupList - return a virPCIDeviceList containing
+ * all of the devices in @iommu_group.
+ *
+ * Return the new list, or NULL on failure
+ */
+virPCIDeviceListPtr
+virPCIGetIOMMUGroupList(int iommu_group)
+{
+    virPCIDeviceListPtr groupList = virPCIDeviceListNew();
+
+    if (!groupList)
+        goto error;
+
+    if (virPCIIOMMUGroupIterate(iommu_group,
+                                virPCIDeviceGetIOMMUGroupAddOne,
+                                groupList) < 0)
+        goto error;
+
+    return groupList;
+
+ error:
+    virObjectUnref(groupList);
+    return NULL;
+}
+
+
 typedef struct {
     virPCIDeviceAddressPtr **iommuGroupDevices;
     size_t *nIommuGroupDevices;
diff --git a/src/util/virpci.h b/src/util/virpci.h
index 5ec1306..5bcacb2 100644
--- a/src/util/virpci.h
+++ b/src/util/virpci.h
@@ -180,6 +180,7 @@ int virPCIIOMMUGroupIterate(int iommu_group,
                             virPCIDeviceAddressActor actor,
                             void *opaque);
 virPCIDeviceListPtr virPCIDeviceGetIOMMUGroupList(virPCIDevicePtr dev);
+virPCIDeviceListPtr virPCIGetIOMMUGroupList(int iommu_group);
 int virPCIDeviceAddressGetIOMMUGroupAddresses(virPCIDeviceAddressPtr devAddr,
                                               virPCIDeviceAddressPtr **iommuGroupDevices,
                                               size_t *nIommuGroupDevices);
-- 
2.7.4
