Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C8C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A0220663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A0220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvtsG-00074u-0c
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 22:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvtrD-0005aa-1k
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 22:42:47 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvtrB-00042k-4w
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 22:42:46 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0U2rWAKu_1594867354; 
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0U2rWAKu_1594867354) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Jul 2020 10:42:37 +0800
From: Hui Zhu <teawater@gmail.com>
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 akpm@linux-foundation.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC for qemu v4 1/2] virtio_balloon: Add cont-pages and icvq
Date: Thu, 16 Jul 2020 10:41:54 +0800
Message-Id: <1594867315-8626-5-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Received-SPF: pass client-ip=47.88.44.36;
 envelope-from=teawaterz@linux.alibaba.com; helo=out4436.biz.mail.alibaba.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 22:42:26
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, NML_ADSP_CUSTOM_MED=0.9,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
Cc: Hui Zhu <teawaterz@linux.alibaba.com>, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds cont-pages option to virtio_balloon.  virtio_balloon
will open flags VIRTIO_BALLOON_F_CONT_PAGES with this option.
And it add a vq icvq to inflate continuous pages.
When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
from icvq and use madvise MADV_DONTNEED release the pages.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c                      | 80 ++++++++++++++++---------
 include/hw/virtio/virtio-balloon.h              |  2 +-
 include/standard-headers/linux/virtio_balloon.h |  1 +
 3 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7..d36a5c8 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -65,23 +65,26 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset,
+                                 size_t size,
                                  PartiallyBalloonedPage *pbp)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
     RAMBlock *rb;
     size_t rb_page_size;
-    int subpages;
+    int subpages, pages_num;
 
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
     rb = qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size = qemu_ram_pagesize(rb);
 
+    size &= ~(rb_page_size - 1);
+
     if (rb_page_size == BALLOON_PAGE_SIZE) {
         /* Easy case */
 
-        ram_block_discard_range(rb, rb_offset, rb_page_size);
+        ram_block_discard_range(rb, rb_offset, size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -99,32 +102,38 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 
     rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
-    base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
-               (rb_offset - rb_aligned_offset);
 
-    if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
-        /* We've partially ballooned part of a host page, but now
-         * we're trying to balloon part of a different one.  Too hard,
-         * give up on the old partial page */
-        virtio_balloon_pbp_free(pbp);
-    }
+    for (pages_num = size / BALLOON_PAGE_SIZE;
+         pages_num > 0; pages_num--) {
+        base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
+                   (rb_offset - rb_aligned_offset);
 
-    if (!pbp->bitmap) {
-        virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
-    }
+        if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
+            /* We've partially ballooned part of a host page, but now
+            * we're trying to balloon part of a different one.  Too hard,
+            * give up on the old partial page */
+            virtio_balloon_pbp_free(pbp);
+        }
 
-    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
-            pbp->bitmap);
+        if (!pbp->bitmap) {
+            virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
+        }
 
-    if (bitmap_full(pbp->bitmap, subpages)) {
-        /* We've accumulated a full host page, we can actually discard
-         * it now */
+        set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
+                pbp->bitmap);
 
-        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
-        /* We ignore errors from ram_block_discard_range(), because it
-         * has already reported them, and failing to discard a balloon
-         * page is not fatal */
-        virtio_balloon_pbp_free(pbp);
+        if (bitmap_full(pbp->bitmap, subpages)) {
+            /* We've accumulated a full host page, we can actually discard
+            * it now */
+
+            ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
+            /* We ignore errors from ram_block_discard_range(), because it
+            * has already reported them, and failing to discard a balloon
+            * page is not fatal */
+            virtio_balloon_pbp_free(pbp);
+        }
+
+        mr_offset += BALLOON_PAGE_SIZE;
     }
 }
 
@@ -340,12 +349,21 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
             unsigned int p = virtio_ldl_p(vdev, &pfn);
             hwaddr pa;
+            unsigned int psize = BALLOON_PAGE_SIZE;
 
             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset += 4;
 
-            section = memory_region_find(get_system_memory(), pa,
-                                         BALLOON_PAGE_SIZE);
+            if (vq == s->icvq) {
+                uint32_t psize_ptr;
+                if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psize_ptr, 4) != 4) {
+                    break;
+                }
+                psize = virtio_ldl_p(vdev, &psize_ptr);
+                offset += 4;
+            }
+
+            section = memory_region_find(get_system_memory(), pa, psize);
             if (!section.mr) {
                 trace_virtio_balloon_bad_addr(pa);
                 continue;
@@ -361,9 +379,10 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             trace_virtio_balloon_handle_output(memory_region_name(section.mr),
                                                pa);
             if (!qemu_balloon_is_inhibited()) {
-                if (vq == s->ivq) {
+                if (vq == s->ivq || vq == s->icvq) {
                     balloon_inflate_page(s, section.mr,
-                                         section.offset_within_region, &pbp);
+                                         section.offset_within_region,
+                                         psize, &pbp);
                 } else if (vq == s->dvq) {
                     balloon_deflate_page(s, section.mr, section.offset_within_region);
                 } else {
@@ -816,6 +835,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
             virtio_error(vdev, "iothread is missing");
         }
     }
+
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
+        s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
+    }
+
     reset_stats(s);
 }
 
@@ -916,6 +940,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_CONT_PAGES, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d..6a2514d 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2..033926c 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
2.7.4


