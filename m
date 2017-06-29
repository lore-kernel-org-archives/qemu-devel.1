Received: from eggs.gnu.org ([2001:4830:134:3::10]:34650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHg-0001s1-LM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHa-00036k-8t
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39873
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dQNHa-00035O-2A
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:06 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5T0OJgA116041
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:05 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcnmqajn3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:05 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 18:26:04 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 19:25:00 -0500
In-Reply-To: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1498695900-1648-6-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 5/5] qemu: hotplug: wait for VFIO group FD
 close before unbind
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

QEMU emits DEVICE_DELETED events during a device's "unparent"
callback, but some additional cleanup occurs afterward via
"finalize". In most cases libvirt can ignore the latter, but in the
case of VFIO the closing of a device's group FD happens here, which
is something libvirt needs to wait for before attempting to bind a
hostdev back to a host driver. In the case of powernv, and possibly
other host archs as well, failing to do this can lead to the host
device driver crashing due to necessary setup (like restoring default
DMA windows for the IOMMU group) not being completed yet.

We attempt to avoid this here by polling the QEMU process for open
FDs referencing /dev/vfio/<group num> and waiting for a certain period
of time. In practice the delay between the DEVICE_DELETED
event and closing of the group FD seems to be around 6 seconds, so we
set the max wait time at 15 seconds. If we time out we leave the
device in the inactiveList and bound to VFIO. We only attempt the
wait if the last hostdev from an IOMMU group is being detached and
there's reasonable expectation that the group FD will be closed soon.

There are alternatives to this approach, like adding a specific
group delete event to QEMU and handling this cleanup via and
asynchronous event handler, nut since we do a similar poll-wait for
things like KVM device passthrough this simple approach is hopefully
a reasonable starting point at least.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 src/libvirt_private.syms |  1 +
 src/qemu/qemu_hotplug.c  | 34 +++++++++++++++++++++++++++++--
 src/util/virfile.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/util/virfile.h       |  1 +
 4 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/src/libvirt_private.syms b/src/libvirt_private.syms
index ba7fa39..787267c 100644
--- a/src/libvirt_private.syms
+++ b/src/libvirt_private.syms
@@ -1657,6 +1657,7 @@ virFileIsDir;
 virFileIsExecutable;
 virFileIsLink;
 virFileIsMountPoint;
+virFileIsOpenByPid;
 virFileIsSharedFS;
 virFileIsSharedFSType;
 virFileLength;
diff --git a/src/qemu/qemu_hotplug.c b/src/qemu/qemu_hotplug.c
index af5ee6f..d200bab 100644
--- a/src/qemu/qemu_hotplug.c
+++ b/src/qemu/qemu_hotplug.c
@@ -68,6 +68,8 @@ VIR_LOG_INIT("qemu.qemu_hotplug");
 /* Wait up to 5 seconds for device removal to finish. */
 unsigned long long qemuDomainRemoveDeviceWaitTime = 1000ull * 5;
 
+/* Wait up to 15 seconds for iommu group close */
+unsigned long long qemuDomainRemoveDeviceGroupWaitTime = 1000ull * 15;
 
 /**
  * qemuDomainPrepareDisk:
@@ -3830,6 +3832,32 @@ qemuDomainRemoveSCSIVHostDevice(virQEMUDriverPtr driver,
 }
 
 static int
+qemuDomainWaitForDeviceGroupClose(virDomainObjPtr vm, int iommu_group)
+{
+    char *group_path;
+    unsigned long long remaining_ms = qemuDomainRemoveDeviceGroupWaitTime;
+    int rc = -1;
+
+    if (virAsprintf(&group_path, "/dev/vfio/%d", iommu_group) < 0)
+        return -1;
+
+    while ((rc = virFileIsOpenByPid(group_path, vm->pid)) == 1) {
+        if (remaining_ms <= 0)
+            break;
+        usleep(100*1000);
+        remaining_ms -= 100;
+    }
+
+    VIR_DEBUG("IOMMU group %d FD status: %d, wait time: %llu ms",
+              iommu_group, rc,
+              qemuDomainRemoveDeviceGroupWaitTime - remaining_ms);
+
+    VIR_FREE(group_path);
+    return rc;
+}
+
+
+static int
 qemuDomainRemoveHostDevice(virQEMUDriverPtr driver,
                            virDomainObjPtr vm,
                            virDomainHostdevDefPtr hostdev)
@@ -3933,8 +3961,10 @@ qemuDomainRemoveHostDevice(virQEMUDriverPtr driver,
             virPCIDeviceAddressGetIOMMUGroupNum(&hostdev->source.subsys.u.pci.addr);
         if (virHostdevPCIDeviceGroupUnbindable(driver->hostdevMgr,
                                                iommu_group)) {
-            virHostdevPCIDeviceGroupUnbind(driver->hostdevMgr,
-                                           iommu_group);
+            if (qemuDomainWaitForDeviceGroupClose(vm, iommu_group) == 0) {
+                virHostdevPCIDeviceGroupUnbind(driver->hostdevMgr,
+                                               iommu_group);
+            }
         }
     }
 
diff --git a/src/util/virfile.c b/src/util/virfile.c
index d444b32..29b762f 100644
--- a/src/util/virfile.c
+++ b/src/util/virfile.c
@@ -4162,3 +4162,55 @@ virFileReadValueString(char **value, const char *format, ...)
     VIR_FREE(str);
     return ret;
 }
+
+int
+virFileIsOpenByPid(const char *path, pid_t pid)
+{
+    struct dirent *ent;
+    DIR *filelist_dir;
+    char *filelist_path;
+    bool found = false;
+    int rc = -1;
+
+    if (!path || !IS_ABSOLUTE_FILE_NAME(path)) {
+        virReportError(VIR_ERR_INTERNAL_ERROR,
+                       _("invalid path: %s"), path ? path : "null");
+        goto error;
+    }
+
+    if (virAsprintf(&filelist_path, "/proc/%d/fd", pid) < 0)
+        goto error;
+
+    if (virDirOpen(&filelist_dir, filelist_path) < 0) {
+        virReportError(VIR_ERR_INTERNAL_ERROR,
+                       _("unable to open directory: %s"), filelist_path);
+        goto error;
+    }
+
+    while (!found &&
+           (rc = virDirRead(filelist_dir, &ent, filelist_path)) == 1) {
+        char *resolved_path = NULL;
+        char *link_path;
+        if ((rc = virAsprintf(&link_path, "%s/%s", filelist_path, ent->d_name)) < 0)
+            break;
+        if (virFileResolveLink(link_path, &resolved_path) == 0) {
+            if (resolved_path) {
+                VIR_DEBUG("checking absolute path for match (need: %s, got: %s)",
+                          path, resolved_path);
+                if (STREQ(resolved_path, path))
+                    found = true;
+                VIR_FREE(resolved_path);
+            }
+        }
+    }
+
+    VIR_DIR_CLOSE(filelist_dir);
+ error:
+    VIR_FREE(filelist_path);
+
+    VIR_DEBUG("returning, rc: %d, found: %d", rc, found);
+    if (rc < 0)
+        return rc;
+
+    return found ? 1 : 0;
+}
diff --git a/src/util/virfile.h b/src/util/virfile.h
index 57ceb80..fb86786 100644
--- a/src/util/virfile.h
+++ b/src/util/virfile.h
@@ -347,6 +347,7 @@ int virFileReadValueScaledInt(unsigned long long *value, const char *format, ...
 int virFileReadValueString(char **value, const char *format, ...)
  ATTRIBUTE_FMT_PRINTF(2, 3);
 
+int virFileIsOpenByPid(const char *path, pid_t pid);
 
 int virFileInData(int fd,
                   int *inData,
-- 
2.7.4
