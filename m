Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FF8C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5C4206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5C4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCId8-0003mF-Qt
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 03:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jCIcE-0002VI-Qd
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jCIcD-0003jf-Dp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:50:50 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:58871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jCIcD-0003iq-1u
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:50:49 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04396; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0TsNBE7I_1583999424; 
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0TsNBE7I_1583999424) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 12 Mar 2020 15:50:28 +0800
From: Hui Zhu <teawater@gmail.com>
To: mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org,
 pagupta@redhat.com, mojha@codeaurora.org, david@redhat.com,
 namit@vmware.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: [RFC for QEMU] virtio-balloon: Add option thp-order to set
 VIRTIO_BALLOON_F_THP_ORDER
Date: Thu, 12 Mar 2020 15:49:55 +0800
Message-Id: <1583999395-9131-2-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583999395-9131-1-git-send-email-teawater@gmail.com>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
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
Cc: Hui Zhu <teawaterz@linux.alibaba.com>, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the guest kernel has many fragmentation pages, use virtio_balloon
will split THP of QEMU when it calls MADV_DONTNEED madvise to release
the balloon pages.
Set option thp-order to on will open flags VIRTIO_BALLOON_F_THP_ORDER.
It will set balloon size to THP size to handle the THP split issue.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c                      | 67 ++++++++++++++++---------
 include/standard-headers/linux/virtio_balloon.h |  4 ++
 2 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7..cfe86b0 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -340,37 +340,49 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
             unsigned int p = virtio_ldl_p(vdev, &pfn);
             hwaddr pa;
+            size_t handle_size = BALLOON_PAGE_SIZE;
 
             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset += 4;
 
-            section = memory_region_find(get_system_memory(), pa,
-                                         BALLOON_PAGE_SIZE);
-            if (!section.mr) {
-                trace_virtio_balloon_bad_addr(pa);
-                continue;
-            }
-            if (!memory_region_is_ram(section.mr) ||
-                memory_region_is_rom(section.mr) ||
-                memory_region_is_romd(section.mr)) {
-                trace_virtio_balloon_bad_addr(pa);
-                memory_region_unref(section.mr);
-                continue;
-            }
+            if (virtio_has_feature(s->host_features,
+                                   VIRTIO_BALLOON_F_THP_ORDER))
+                handle_size = BALLOON_PAGE_SIZE << VIRTIO_BALLOON_THP_ORDER;
+
+            while (handle_size > 0) {
+                section = memory_region_find(get_system_memory(), pa,
+                                             BALLOON_PAGE_SIZE);
+                if (!section.mr) {
+                    trace_virtio_balloon_bad_addr(pa);
+                    continue;
+                }
+                if (!memory_region_is_ram(section.mr) ||
+                    memory_region_is_rom(section.mr) ||
+                    memory_region_is_romd(section.mr)) {
+                    trace_virtio_balloon_bad_addr(pa);
+                    memory_region_unref(section.mr);
+                    continue;
+                }
 
-            trace_virtio_balloon_handle_output(memory_region_name(section.mr),
-                                               pa);
-            if (!qemu_balloon_is_inhibited()) {
-                if (vq == s->ivq) {
-                    balloon_inflate_page(s, section.mr,
-                                         section.offset_within_region, &pbp);
-                } else if (vq == s->dvq) {
-                    balloon_deflate_page(s, section.mr, section.offset_within_region);
-                } else {
-                    g_assert_not_reached();
+                trace_virtio_balloon_handle_output(memory_region_name(section.mr),
+                                                   pa);
+                if (!qemu_balloon_is_inhibited()) {
+                    if (vq == s->ivq) {
+                        balloon_inflate_page(s, section.mr,
+                                             section.offset_within_region,
+                                             &pbp);
+                    } else if (vq == s->dvq) {
+                        balloon_deflate_page(s, section.mr,
+                                             section.offset_within_region);
+                    } else {
+                        g_assert_not_reached();
+                    }
                 }
+                memory_region_unref(section.mr);
+
+                pa += BALLOON_PAGE_SIZE;
+                handle_size -= BALLOON_PAGE_SIZE;
             }
-            memory_region_unref(section.mr);
         }
 
         virtqueue_push(vq, elem, offset);
@@ -693,6 +705,8 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
 
     memcpy(&config, config_data, virtio_balloon_config_size(dev));
     dev->actual = le32_to_cpu(config.actual);
+    if (virtio_has_feature(vdev->host_features, VIRTIO_BALLOON_F_THP_ORDER))
+        dev->actual <<= VIRTIO_BALLOON_THP_ORDER;
     if (dev->actual != oldactual) {
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
@@ -728,6 +742,9 @@ static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
     }
     if (target) {
         dev->num_pages = (vm_ram_size - target) >> VIRTIO_BALLOON_PFN_SHIFT;
+        if (virtio_has_feature(dev->host_features,
+                               VIRTIO_BALLOON_F_THP_ORDER))
+            dev->num_pages >>= VIRTIO_BALLOON_THP_ORDER;
         virtio_notify_config(vdev);
     }
     trace_virtio_balloon_to_target(target, dev->num_pages);
@@ -916,6 +933,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("thp-order", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_THP_ORDER, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2..f54d613 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,10 +36,14 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Set balloon page order to thp order */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
 
+/* The order of the balloon page */
+#define VIRTIO_BALLOON_THP_ORDER 9
+
 #define VIRTIO_BALLOON_CMD_ID_STOP	0
 #define VIRTIO_BALLOON_CMD_ID_DONE	1
 struct virtio_balloon_config {
-- 
2.7.4


