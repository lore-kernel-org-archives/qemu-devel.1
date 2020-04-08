Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DB5C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 22:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC8A20730
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 22:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ1de24/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC8A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMJcS-0001vC-6W
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 18:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMJba-0000cy-CB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 18:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMJbY-0001Q5-Vw
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 18:55:34 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jMJbY-0001Os-BE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 18:55:32 -0400
Received: by mail-pg1-x541.google.com with SMTP id k5so4035570pga.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 15:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=QbFPTJ8PrOkL5KW33hQUGbiq9WhS0luRbBZRC56AG18=;
 b=BQ1de24/AEstFg+DyJgjenWMHK9k+WF1qAfAQPhJS/WnNJTXg245v/1hFgVlQLiXy5
 Qv2qtuqOsUQ/rd9mUi4d1KQUKY6K+FC7NCEARgJkwuI+pO7JD+QmhnmTmNgpkrYAsucU
 L3nDh4turo752xeDvRPbZXnc5UHCZrmJXRL2RaE5vVHtMCSawJnln1g8+goydlnYPw9v
 r+xg+jzKONBXECGJ9L7lyCnsG+tNXgLqbv7J5d673gqOYXxyBiyfinIhjYZ0on7FJgDY
 kCkdzy7vh0uBikfqH0uBfVTO5lWGl2R/xhfPT2Iai4yG5FAO/qMf1RfH+GNyPAMw7S9s
 V0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=QbFPTJ8PrOkL5KW33hQUGbiq9WhS0luRbBZRC56AG18=;
 b=nQtg7AjUeKGynjAomL0lvNOUFdsIB8o14sX3nktVR7p337CI5FP1akqedYJ2CzSuRw
 gmOE/GtehB826fJgzC6xZx5e+wisqJJwSgBJm0K8C1ald4pD54xh81QDyLeAZyjxH3JI
 n82Z1t8TVEMttj+wfzQ6t4O1b3aKpMnuxbRlz1cZVBT5/HOAsaCuLjcDEqmON3l00aDe
 DBrC6c1CvYFV41sNaoQOW7GszjEwYjhuSIYvL1iS99Sv7XhwsROujc9IDd7ky1l8RgNh
 lw7zOkp/mRfxKvvFZImULD9ZC23X09cOqLinruh70Kp2XNByRceIfNs4js+yzbaDKUvk
 m9EQ==
X-Gm-Message-State: AGi0PubAhPROIBoZDpT0MdyYO9neVrcpz9WY1UDq+iMQr4RW0uX5NqDU
 csz0KiPPNuw/9eshJAAH4l4=
X-Google-Smtp-Source: APiQypL1CAdbCD7EYmaUHpQ/VthBhJ1skS91TE/SBVEBg0ys4mFzgPpQUJhezQUJMCHwwJXAx4aFMA==
X-Received: by 2002:a62:ae05:: with SMTP id q5mr10160634pff.307.1586386530703; 
 Wed, 08 Apr 2020 15:55:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id x13sm16624418pfj.185.2020.04.08.15.55.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Apr 2020 15:55:30 -0700 (PDT)
Subject: [PATCH v18 QEMU 3/3] virtio-balloon: Provide a interface for free
 page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Wed, 08 Apr 2020 15:55:29 -0700
Message-ID: <20200408225529.18764.44086.stgit@localhost.localdomain>
In-Reply-To: <20200408225302.18764.209.stgit@localhost.localdomain>
References: <20200408225302.18764.209.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Add support for what I am referring to as "free page reporting".
Basically the idea is to function very similar to how the balloon works
in that we basically end up madvising the page as not being used. However
we don't really need to bother with any deflate type logic since the page
will be faulted back into the guest when it is read or written to.

This is meant to be a simplification of the existing balloon interface
to use for providing hints to what memory needs to be freed. I am assuming
this is safe to do as the deflate logic does not actually appear to do very
much other than tracking what subpages have been released and which ones
haven't.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   48 +++++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-balloon.h |    2 +-
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 1c6d36a29a04..297b267198ac 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -321,6 +321,42 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
     balloon_stats_change_timer(s, 0);
 }
 
+static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
+    VirtQueueElement *elem;
+
+    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
+        unsigned int i;
+
+        for (i = 0; i < elem->in_num; i++) {
+            void *addr = elem->in_sg[i].iov_base;
+            size_t size = elem->in_sg[i].iov_len;
+            ram_addr_t ram_offset;
+            size_t rb_page_size;
+            RAMBlock *rb;
+
+            if (qemu_balloon_is_inhibited() || dev->poison_val) {
+                continue;
+            }
+
+            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
+            rb_page_size = qemu_ram_pagesize(rb);
+
+            /* For now we will simply ignore unaligned memory regions */
+            if ((ram_offset | size) & (rb_page_size - 1)) {
+                continue;
+            }
+
+            ram_block_discard_range(rb, ram_offset, size);
+        }
+
+        virtqueue_push(vq, elem, 0);
+        virtio_notify(vdev, vq);
+        g_free(elem);
+    }
+}
+
 static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
@@ -628,7 +664,8 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
         return sizeof(struct virtio_balloon_config);
     }
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON) ||
-        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT) ||
+        virtio_has_feature(features, VIRTIO_BALLOON_F_REPORTING)) {
         return sizeof(struct virtio_balloon_config);
     }
     return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
@@ -717,7 +754,8 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
     f |= dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
-    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT) ||
+        virtio_has_feature(f, VIRTIO_BALLOON_F_REPORTING)) {
         virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
     }
 
@@ -807,6 +845,10 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
+        s->rvq = virtio_add_queue(vdev, 32, virtio_balloon_handle_report);
+    }
+
     if (virtio_has_feature(s->host_features,
                            VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
@@ -940,6 +982,8 @@ static Property virtio_balloon_properties[] = {
      */
     DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
                      qemu_4_0_config_size, false),
+    DEFINE_PROP_BIT("unused-page-reporting", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_REPORTING, true),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 7fe78e5c14d7..db5bf7127112 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *rvq;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;


