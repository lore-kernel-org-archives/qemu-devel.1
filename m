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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B68A20663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B68A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvttX-0001Lp-JC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 22:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvtrE-0005cH-HI
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 22:42:48 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:26625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvtrC-00043n-PW
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 22:42:48 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04427; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0U2rVPuE_1594867357; 
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0U2rVPuE_1594867357) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Jul 2020 10:42:39 +0800
From: Hui Zhu <teawater@gmail.com>
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 akpm@linux-foundation.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC for qemu v4 2/2] virtio_balloon: Add dcvq to deflate continuous
 pages
Date: Thu, 16 Jul 2020 10:41:55 +0800
Message-Id: <1594867315-8626-6-git-send-email-teawater@gmail.com>
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

This commit adds a vq dcvq to deflate continuous pages.
When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
from icvq and use madvise MADV_WILLNEED with the pages.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c         | 14 +++++++++-----
 include/hw/virtio/virtio-balloon.h |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d36a5c8..165adf7 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -138,7 +138,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 }
 
 static void balloon_deflate_page(VirtIOBalloon *balloon,
-                                 MemoryRegion *mr, hwaddr mr_offset)
+                                 MemoryRegion *mr, hwaddr mr_offset,
+                                 size_t size)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset;
@@ -153,10 +154,11 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
     rb_page_size = qemu_ram_pagesize(rb);
 
     host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
+    size &= ~(rb_page_size - 1);
 
     /* When a page is deflated, we hint the whole host page it lives
      * on, since we can't do anything smaller */
-    ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
+    ret = qemu_madvise(host_addr, size, QEMU_MADV_WILLNEED);
     if (ret != 0) {
         warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
                     strerror(errno));
@@ -354,7 +356,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset += 4;
 
-            if (vq == s->icvq) {
+            if (vq == s->icvq || vq == s->dcvq) {
                 uint32_t psize_ptr;
                 if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psize_ptr, 4) != 4) {
                     break;
@@ -383,8 +385,9 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
                     balloon_inflate_page(s, section.mr,
                                          section.offset_within_region,
                                          psize, &pbp);
-                } else if (vq == s->dvq) {
-                    balloon_deflate_page(s, section.mr, section.offset_within_region);
+                } else if (vq == s->dvq || vq == s->dcvq) {
+                    balloon_deflate_page(s, section.mr, section.offset_within_region,
+                                         psize);
                 } else {
                     g_assert_not_reached();
                 }
@@ -838,6 +841,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
         s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
+        s->dcvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     }
 
     reset_stats(s);
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 6a2514d..848a7fb 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq, *dcvq;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
-- 
2.7.4


