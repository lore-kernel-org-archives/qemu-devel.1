Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA85C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9F121D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9F121D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtN4-0004OF-Q6
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenjiajun8@huawei.com>)
 id 1kMt2e-0006rm-3X
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:18:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5150 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenjiajun8@huawei.com>)
 id 1kMt2X-0002cM-Bu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:18:07 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6B0DF57FAA03AFBC79C8;
 Mon, 28 Sep 2020 21:17:46 +0800 (CST)
Received: from DESKTOP-RHHE7UD.china.huawei.com (10.174.187.16) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 21:17:39 +0800
From: Jiajun Chen <chenjiajun8@huawei.com>
To: <raphael.s.norwitz@gmail.com>
Subject: [PATCH] vhost-user: add separate memslot counter for vhost-user
Date: Mon, 28 Sep 2020 21:17:31 +0800
Message-ID: <20200928131731.69684-1-chenjiajun8@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.16]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=chenjiajun8@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:17:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, imammedo@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Used_memslots is equal to dev->mem->nregions now, it is true for
vhost kernel, but not for vhost user, which uses the memory regions
that have file descriptor. In fact, not all of the memory regions
have file descriptor.
It is usefully in some scenarios, e.g. used_memslots is 8, and only
5 memory slots can be used by vhost user, it is failed to hot plug
a new memory RAM because vhost_has_free_slot just returned false,
but we can hot plug it safely in fact.

--
ChangeList:
v3:
-make used_memslots a member of struct vhost_dev instead of a global static value

v2:
-eliminating useless used_memslots_exceeded variable and used_memslots_is_exceeded() API

v1:
-vhost-user: add separate memslot counter for vhost-user

Signed-off-by: Jiajun Chen <chenjiajun8@huawei.com>
Signed-off-by: Jianjay Zhou <jianjay.zhou@huawei.com>
---
 hw/virtio/vhost-backend.c         | 12 ++++++++++
 hw/virtio/vhost-user.c            | 25 +++++++++++++++++++++
 hw/virtio/vhost.c                 | 37 +++++++++++++++++++++++--------
 include/hw/virtio/vhost-backend.h |  5 +++++
 include/hw/virtio/vhost.h         |  1 +
 net/vhost-user.c                  |  7 ++++++
 6 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 782b1d67d9..7016f23ec5 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -238,6 +238,16 @@ static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
         qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL);
 }
 
+static void vhost_kernel_set_used_memslots(struct vhost_dev *dev)
+{
+    dev->used_memslots = dev->mem->nregions;
+}
+
+static unsigned int vhost_kernel_get_used_memslots(struct vhost_dev *dev)
+{
+    return dev->used_memslots;
+}
+
 static const VhostOps kernel_ops = {
         .backend_type = VHOST_BACKEND_TYPE_KERNEL,
         .vhost_backend_init = vhost_kernel_init,
@@ -269,6 +279,8 @@ static const VhostOps kernel_ops = {
 #endif /* CONFIG_VHOST_VSOCK */
         .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
+        .vhost_set_used_memslots = vhost_kernel_set_used_memslots,
+        .vhost_get_used_memslots = vhost_kernel_get_used_memslots,
 };
 #endif
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 31231218dc..5dea64d8a8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2354,6 +2354,29 @@ void vhost_user_cleanup(VhostUserState *user)
     user->chr = NULL;
 }
 
+static void vhost_user_set_used_memslots(struct vhost_dev *dev)
+{
+    int i;
+    dev->used_memslots = 0;
+
+    for (i = 0; i < dev->mem->nregions; ++i) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
+        ram_addr_t offset;
+        MemoryRegion *mr;
+        int fd;
+
+        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+        if (mr && fd > 0) {
+            dev->used_memslots++;
+        }
+    }
+}
+
+static unsigned int vhost_user_get_used_memslots(struct vhost_dev *dev)
+{
+    return dev->used_memslots;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
@@ -2387,4 +2410,6 @@ const VhostOps user_ops = {
         .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
         .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
         .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
+        .vhost_set_used_memslots = vhost_user_set_used_memslots,
+        .vhost_get_used_memslots = vhost_user_get_used_memslots,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e7a6..98b967669b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -45,20 +45,20 @@
 static struct vhost_log *vhost_log;
 static struct vhost_log *vhost_log_shm;
 
-static unsigned int used_memslots;
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
 bool vhost_has_free_slot(void)
 {
-    unsigned int slots_limit = ~0U;
     struct vhost_dev *hdev;
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
-        unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
-        slots_limit = MIN(slots_limit, r);
+        if (hdev->vhost_ops->vhost_get_used_memslots(hdev) >=
+            hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
+            return false;
+        }
     }
-    return slots_limit > used_memslots;
+    return true;
 }
 
 static void vhost_dev_sync_region(struct vhost_dev *dev,
@@ -502,7 +502,6 @@ static void vhost_commit(MemoryListener *listener)
                        dev->n_mem_sections * sizeof dev->mem->regions[0];
     dev->mem = g_realloc(dev->mem, regions_size);
     dev->mem->nregions = dev->n_mem_sections;
-    used_memslots = dev->mem->nregions;
     for (i = 0; i < dev->n_mem_sections; i++) {
         struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
         struct MemoryRegionSection *mrs = dev->mem_sections + i;
@@ -678,6 +677,7 @@ static void vhost_region_add_section(struct vhost_dev *dev,
         dev->tmp_sections[dev->n_tmp_sections - 1].fv = NULL;
         memory_region_ref(section->mr);
     }
+    dev->vhost_ops->vhost_set_used_memslots(dev);
 }
 
 /* Used for both add and nop callbacks */
@@ -693,6 +693,17 @@ static void vhost_region_addnop(MemoryListener *listener,
     vhost_region_add_section(dev, section);
 }
 
+static void vhost_region_del(MemoryListener *listener,
+                             MemoryRegionSection *section)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    if (!vhost_section(dev, section)) {
+        return;
+    }
+    dev->vhost_ops->vhost_set_used_memslots(dev);
+}
+
 static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
@@ -1300,6 +1311,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->memory_listener = (MemoryListener) {
         .begin = vhost_begin,
         .commit = vhost_commit,
+        .region_del = vhost_region_del,
         .region_add = vhost_region_addnop,
         .region_nop = vhost_region_addnop,
         .log_start = vhost_log_start,
@@ -1346,9 +1358,16 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
-    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
-        error_report("vhost backend memory slots limit is less"
-                " than current number of present memory slots");
+    /*
+     * If we started a VM without any vhost device,
+     * for the first time vhost device hot-plug
+     * (vhost_get_used_memslots is always 0),
+     * so it needs to double check here.
+     */
+    if (hdev->vhost_ops->vhost_get_used_memslots(hdev) >
+        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
+        error_report("vhost backend memory slots limit is less than"
+                     " current number of present memory slots");
         r = -1;
         if (busyloop_timeout) {
             goto fail_busyloop;
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 8825bd278f..6569c95a43 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -124,6 +124,9 @@ typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t *dev_id);
 
 typedef bool (*vhost_force_iommu_op)(struct vhost_dev *dev);
 
+typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
+typedef unsigned int (*vhost_get_used_memslots_op)(struct vhost_dev *dev);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -168,6 +171,8 @@ typedef struct VhostOps {
     vhost_vq_get_addr_op  vhost_vq_get_addr;
     vhost_get_device_id_op vhost_get_device_id;
     vhost_force_iommu_op vhost_force_iommu;
+    vhost_set_used_memslots_op vhost_set_used_memslots;
+    vhost_get_used_memslots_op vhost_get_used_memslots;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 767a95ec0b..5ded21f86d 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -90,6 +90,7 @@ struct vhost_dev {
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
     const VhostDevConfigOps *config_ops;
+    unsigned int used_memslots;
 };
 
 struct vhost_net {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 17532daaf3..7e93955537 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -20,6 +20,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "trace.h"
+#include "include/hw/virtio/vhost.h"
 
 typedef struct NetVhostUserState {
     NetClientState nc;
@@ -347,6 +348,12 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
         qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
                                  net_vhost_user_event, NULL, nc0->name, NULL,
                                  true);
+
+        if (!vhost_has_free_slot()) {
+            error_report("used memslots exceeded the backend limit, quit "
+                         "loop");
+            goto err;
+        }
     } while (!s->started);
 
     assert(s->vhost_net);
-- 
2.27.0.dirty


