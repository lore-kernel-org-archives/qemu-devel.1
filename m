Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6363DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E58820842
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UMFJfPom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E58820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1B1d-0007zz-6S
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AfT-0001bK-6x
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AfP-0002WS-2O
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXjA3152650;
 Thu, 30 Jul 2020 15:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=3rCNeo1Lw8KTjzWvOvYbs+6lVAyGwEr3YPghYoQiiNY=;
 b=UMFJfPomJfYPyHpdMbmwrvCZ5GOkfEkOFZgTvys1ghgwCWvuweuw/rBYHDLlRznCm6v1
 9PlJBSimQ1n7aRQt33Oa/2hhu7gz4G9W05Xpz5oTNqDLA+FqBJ3wxl1uDUWiq+BwnZc9
 ddz0BKPGldFIKJKdbOQpSsQx/YbXsBVmbAy5nwfsHQy596WaN3pZ062XstayWojS/tqb
 b6Li9HT6eeVA1AsKRIc5g+ErkBtlvTttW9wYQpoYDv4A+onLwnnyOVzkIkpSuruO6Aeg
 Cnq61Ri8U+0AHrup5HJ6dZ6Uq/ixt+ee93R0571VNPZcI5ASQfbUTul/+wFs/5YRPwfF Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 32hu1jvedj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:40:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWpKR188448;
 Thu, 30 Jul 2020 15:38:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 32hu5xja7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UFcH4k020536;
 Thu, 30 Jul 2020 15:38:17 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:17 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 30/32] vfio-pci: save and restore
Date: Thu, 30 Jul 2020 08:14:34 -0700
Message-Id: <1596122076-341293-31-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=4 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:38:02
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable vfio-pci devices to be saved and restored across an exec restart
of qemu.

At vfio creation time, save the value of vfio container, group, and device
descriptors in the environment.

In cprsave, save the msi message area as part of vfio-pci vmstate, and
clear the close-on-exec flag for the vfio descriptors.  The flag is not
cleared earlier because the descriptors should not persist across misc
fork and exec calls that may be performed during normal operation.

On qemu restart, vfio_realize() finds the descriptor env vars, uses
the descriptors, and notes that the device is being reused.  Device and
iommu state is already configured, so operations in vfio_realize that
would modify the configuration are skipped for a reused device, including
vfio ioctl's and writes to PCI configuration space.  The result is that
vfio_realize constructs qemu data structures that reflect the current
state of the device.  However, the reconstruction is not complete until
cprload is called, and vfio_pci_post_load uses the msi data to rebuild
interrupt structures and attach the interrupts to the new KVM instance.
Lastly, vfio device reset is suppressed when the VM is started.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/pci/pci.c                  |  4 ++
 hw/vfio/common.c              | 99 ++++++++++++++++++++++++++++++++++---------
 hw/vfio/pci.c                 | 79 ++++++++++++++++++++++++++++++++--
 hw/vfio/platform.c            |  2 +-
 include/hw/pci/pci.h          |  1 +
 include/hw/vfio/vfio-common.h |  4 +-
 migration/savevm.c            |  2 +-
 7 files changed, 163 insertions(+), 28 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 7343e00..c2e1509 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -291,6 +291,10 @@ static void pci_do_device_reset(PCIDevice *dev)
 {
     int r;
 
+    if (dev->reused) {
+        return;
+    }
+
     pci_device_deassert_intx(dev);
     assert(dev->irq_state == 0);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3335714..a51a093 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -37,6 +37,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -299,6 +300,10 @@ static int vfio_dma_unmap(VFIOContainer *container,
         .size = size,
     };
 
+    if (container->reused) {
+        return 0;
+    }
+
     while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         /*
          * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
@@ -336,6 +341,10 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
         .size = size,
     };
 
+    if (container->reused) {
+        return 0;
+    }
+
     if (!readonly) {
         map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
     }
@@ -1179,25 +1188,27 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
         return iommu_type;
     }
 
-    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
-    if (ret) {
-        error_setg_errno(errp, errno, "Failed to set group container");
-        return -errno;
-    }
+    if (!container->reused) {
+        ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
+        if (ret) {
+            error_setg_errno(errp, errno, "Failed to set group container");
+            return -errno;
+        }
 
-    while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
-        if (iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-            /*
-             * On sPAPR, despite the IOMMU subdriver always advertises v1 and
-             * v2, the running platform may not support v2 and there is no
-             * way to guess it until an IOMMU group gets added to the container.
-             * So in case it fails with v2, try v1 as a fallback.
-             */
-            iommu_type = VFIO_SPAPR_TCE_IOMMU;
-            continue;
+        while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
+            if (iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
+                /*
+                 * On sPAPR, despite the IOMMU subdriver always advertises v1
+                 * and v2, the running platform may not support v2 and there is
+                 * no way to guess it until an IOMMU group gets added to the
+                 * container. So in case it fails with v2, try v1 as a fallback.
+                 */
+                iommu_type = VFIO_SPAPR_TCE_IOMMU;
+                continue;
+            }
+            error_setg_errno(errp, errno, "Failed to set iommu for container");
+            return -errno;
         }
-        error_setg_errno(errp, errno, "Failed to set iommu for container");
-        return -errno;
     }
 
     container->iommu_type = iommu_type;
@@ -1210,6 +1221,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     VFIOContainer *container;
     int ret, fd;
     VFIOAddressSpace *space;
+    char name[40];
+    bool reused;
 
     space = vfio_get_address_space(as);
 
@@ -1254,7 +1267,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
     }
 
-    fd = qemu_open("/dev/vfio/vfio", O_RDWR);
+    snprintf(name, sizeof(name), "vfio_container_%d", group->groupid);
+    fd = getenv_fd(name);
+    reused = (fd >= 0);
+    if (fd < 0) {
+        fd = qemu_open("/dev/vfio/vfio", O_RDWR);
+    }
+
     if (fd < 0) {
         error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
         ret = -errno;
@@ -1272,6 +1291,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->space = space;
     container->fd = fd;
+    container->cid = group->groupid;
+    container->reused = reused;
     container->error = NULL;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
@@ -1395,6 +1416,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     container->initialized = true;
 
+    if (!reused) {
+        setenv_fd(name, fd);
+    }
+
     return 0;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
@@ -1418,6 +1443,7 @@ put_space_exit:
 static void vfio_disconnect_container(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
+    char name[40];
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
@@ -1450,6 +1476,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
         }
 
         trace_vfio_disconnect_container(container->fd);
+        snprintf(name, sizeof(name), "vfio_container_%d", container->cid);
+        unsetenv_fd(name);
         close(container->fd);
         g_free(container);
 
@@ -1462,6 +1490,7 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     VFIOGroup *group;
     char path[32];
     struct vfio_group_status status = { .argsz = sizeof(status) };
+    bool reused;
 
     QLIST_FOREACH(group, &vfio_group_list, next) {
         if (group->groupid == groupid) {
@@ -1479,7 +1508,13 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open(path, O_RDWR);
+
+    group->fd = getenv_fd(path);
+    reused = (group->fd >= 0);
+    if (group->fd < 0) {
+        group->fd = qemu_open(path, O_RDWR);
+    }
+
     if (group->fd < 0) {
         error_setg_errno(errp, errno, "failed to open %s", path);
         goto free_group_exit;
@@ -1513,6 +1548,10 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
 
     QLIST_INSERT_HEAD(&vfio_group_list, group, next);
 
+    if (!reused) {
+        setenv_fd(path, group->fd);
+    }
+
     return group;
 
 close_fd_exit:
@@ -1526,6 +1565,8 @@ free_group_exit:
 
 void vfio_put_group(VFIOGroup *group)
 {
+    char path[32];
+
     if (!group || !QLIST_EMPTY(&group->device_list)) {
         return;
     }
@@ -1537,6 +1578,8 @@ void vfio_put_group(VFIOGroup *group)
     vfio_disconnect_container(group);
     QLIST_REMOVE(group, next);
     trace_vfio_put_group(group->fd);
+    snprintf(path, sizeof(path), "/dev/vfio/%d", group->groupid);
+    unsetenv_fd(path);
     close(group->fd);
     g_free(group);
 
@@ -1546,12 +1589,18 @@ void vfio_put_group(VFIOGroup *group)
 }
 
 int vfio_get_device(VFIOGroup *group, const char *name,
-                    VFIODevice *vbasedev, Error **errp)
+                    VFIODevice *vbasedev, bool *reusedp, Error **errp)
 {
     struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
     int ret, fd;
+    bool reused;
+
+    fd = getenv_fd(name);
+    reused = (fd >= 0);
+    if (fd < 0) {
+        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
+    }
 
-    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
     if (fd < 0) {
         error_setg_errno(errp, errno, "error getting device from group %d",
                          group->groupid);
@@ -1601,6 +1650,13 @@ int vfio_get_device(VFIOGroup *group, const char *name,
                           dev_info.num_irqs);
 
     vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
+
+    if (!reused) {
+        setenv_fd(name, fd);
+    }
+    if (reusedp) {
+        *reusedp = reused;
+    }
     return 0;
 }
 
@@ -1612,6 +1668,7 @@ void vfio_put_base_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_put_base_device(vbasedev->fd);
+    unsetenv_fd(vbasedev->name);
     close(vbasedev->fd);
 }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2e561c0..5743807 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -49,6 +49,7 @@
 
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
+static const VMStateDescription vfio_pci_vmstate;
 
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
@@ -1585,6 +1586,14 @@ static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled)
     }
 }
 
+static void vfio_config_sync(VFIOPCIDevice *vdev, uint32_t offset, size_t len)
+{
+    if (pread(vdev->vbasedev.fd, vdev->pdev.config + offset, len,
+          vdev->config_offset + offset) != len) {
+        error_report("vfio_config_sync pread failed");
+    }
+}
+
 static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
@@ -1626,6 +1635,7 @@ static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
     char *name;
+    PCIDevice *pdev = &vdev->pdev;
 
     if (!bar->size) {
         return;
@@ -1646,6 +1656,9 @@ static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
     }
 
     pci_register_bar(&vdev->pdev, nr, bar->type, bar->mr);
+    if (pdev->reused) {
+        vfio_config_sync(vdev, pci_bar(pdev, nr), 8);
+    }
 }
 
 static void vfio_bars_register(VFIOPCIDevice *vdev)
@@ -2805,7 +2818,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    ret = vfio_get_device(group, vdev->vbasedev.name, &vdev->vbasedev, errp);
+    ret = vfio_get_device(group, vdev->vbasedev.name, &vdev->vbasedev,
+                          &pdev->reused, errp);
     if (ret) {
         vfio_put_group(group);
         goto error;
@@ -2972,9 +2986,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                                              vfio_intx_routing_notifier);
         vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
-        ret = vfio_intx_enable(vdev, errp);
-        if (ret) {
-            goto out_deregister;
+        if (!pdev->reused) {
+            ret = vfio_intx_enable(vdev, errp);
+            if (ret) {
+                goto out_deregister;
+            }
         }
     }
 
@@ -3017,6 +3033,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
+    vfio_config_sync(vdev, pdev->msix_cap + PCI_MSIX_FLAGS, 2);
+    if (pdev->reused) {
+        pci_update_mappings(pdev);
+    }
+
     return;
 
 out_deregister:
@@ -3080,6 +3101,10 @@ static void vfio_pci_reset(DeviceState *dev)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(dev);
 
+    if (vdev->pdev.reused) {
+        return;
+    }
+
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
     vfio_pci_pre_reset(vdev);
@@ -3182,6 +3207,51 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static int vfio_pci_post_load(void *opaque, int version_id)
+{
+    int vector;
+    MSIMessage msg;
+    Error *err = 0;
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = &vdev->pdev;
+
+    if (msix_enabled(pdev)) {
+        vfio_msix_enable(vdev);
+        pdev->msix_function_masked = false;
+
+        for (vector = 0; vector < vdev->pdev.msix_entries_nr; vector++) {
+            if (!msix_is_masked(pdev, vector)) {
+                msg = msix_get_message(pdev, vector);
+                vfio_msix_vector_use(pdev, vector, msg);
+            }
+        }
+
+    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
+        vfio_intx_enable(vdev, &err);
+        if (err) {
+            error_report_err(err);
+        }
+    }
+
+    vdev->vbasedev.group->container->reused = false;
+    vdev->pdev.reused = false;
+
+    return 0;
+}
+
+static const VMStateDescription vfio_pci_vmstate = {
+    .name = "vfio-pci",
+    .unmigratable = 1,
+    .mode_mask = VMS_RESTART,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .post_load = vfio_pci_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_MSIX(pdev, VFIOPCIDevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3189,6 +3259,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vfio_pci_reset;
     device_class_set_props(dc, vfio_pci_dev_properties);
+    dc->vmsd = &vfio_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ac2cefc..e6e1a5d 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -592,7 +592,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
             return -EBUSY;
         }
     }
-    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
+    ret = vfio_get_device(group, vbasedev->name, vbasedev, 0, errp);
     if (ret) {
         vfio_put_group(group);
         return ret;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index bd07c86..c926a24 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -358,6 +358,7 @@ struct PCIDevice {
 
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
+    bool reused;
 };
 
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c78f3ff..4e2a332 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -73,6 +73,8 @@ typedef struct VFIOContainer {
     unsigned iommu_type;
     Error *error;
     bool initialized;
+    bool reused;
+    int cid;
     unsigned long pgsizes;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
@@ -177,7 +179,7 @@ void vfio_reset_handler(void *opaque);
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
-                    VFIODevice *vbasedev, Error **errp);
+                    VFIODevice *vbasedev, bool *reused, Error **errp);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
diff --git a/migration/savevm.c b/migration/savevm.c
index 881dc13..2606cf0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1568,7 +1568,7 @@ static int qemu_savevm_state(QEMUFile *f, VMStateMode mode, Error **errp)
         return -EINVAL;
     }
 
-    if (migrate_use_block()) {
+    if ((mode & (VMS_SNAPSHOT | VMS_MIGRATE)) && migrate_use_block()) {
         error_setg(errp, "Block migration and snapshots are incompatible");
         return -EINVAL;
     }
-- 
1.8.3.1


