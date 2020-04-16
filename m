Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2147C352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5B521744
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWWqMMA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5B521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAlM-0002O8-HF
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAh5-0005N4-6o
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAh2-0000cH-US
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:01:03 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jPAh2-0000br-OK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:01:00 -0400
Received: by mail-pg1-x541.google.com with SMTP id x26so2137581pgc.10
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 13:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=s+fZu2aO6tRXGmFNo6N7uZIK/R7mB4CPuTQRSWKo/zg=;
 b=lWWqMMA1I7Mjqpa+uTjluq+QbpupvV8b7x1rcPg9DPRlCLdvz7DsMFlsd17EGsuhtf
 7bE7GaCodnWbKgW+H5SDz6tuqtYglU13xboPWTxqM5lHiVYA6iVdvw5eKp6bAx1Er6MD
 8WiZRcmPaEhSARKbCaLFbIbT+L7aSw0ZsoM++P1KxiznEyhBy/SK+c6ZoEQx0kxTfJLW
 99JHN6LKcHi83eNv4cHJc6ySYd2XsgwSm8bjYDBNit3rvrc+6UtpFyyjuRQdOi2sGh1C
 dGDqYgOweXHdubnPa55XE5uGpiAiFoEeBAgA6xV1bw3FuZwkhedmbJ+VvEZ+6NSMAPgG
 JJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=s+fZu2aO6tRXGmFNo6N7uZIK/R7mB4CPuTQRSWKo/zg=;
 b=RgLYVWSYZrBe8c9xBUOrpxHj1xyCoQ5pqSgryjq3wxilo5axxe03YDVUqQx0LXTsl0
 MTQGid8dp/wTK33dK2t/FGtnkDfFlFoxyADR2LoYHsRdvzAsizWcX0snC/dSQjIOchZl
 2u2LckVlvSbzfjsVzD80JjsM7Rw0AbmoBNG+wqqFMUKzyGwuVrgPH1/u7XrmzNErHJ3g
 dw4S9UG63eYMB7/j9S5DBpuUBc0cbZa6okkfjed71ZX769tN5N5XwTxCX3IZAQnZ3GPC
 N3owRkMNWMZiIe44vaJXNPybqK0eQGGg1TGL1xU/szgIiovbq06VlnUpLXu1NvX92d+J
 Rt2A==
X-Gm-Message-State: AGi0PuY5ZdVhSMCV60ZUuVBimEcnwyOIYGGlSOTCxKb+WQVMlQXDE4ec
 0i+g/4nQmNS+LNLachlfYKw=
X-Google-Smtp-Source: APiQypKp80LJqYRtWhN9gvIHqT4UZ7J2TAp+fDrnH0c7x/W1TSwHeNuKzA09cTFOWP7QbBA55VZzzg==
X-Received: by 2002:a65:530b:: with SMTP id m11mr12882427pgq.338.1587067258819; 
 Thu, 16 Apr 2020 13:00:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id x16sm3834761pfc.61.2020.04.16.13.00.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 13:00:58 -0700 (PDT)
Subject: [PATCH v20 QEMU 5/5] virtio-balloon: Provide an interface for free
 page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Thu, 16 Apr 2020 13:00:57 -0700
Message-ID: <20200416200057.13144.75507.stgit@localhost.localdomain>
In-Reply-To: <20200416195641.13144.16955.stgit@localhost.localdomain>
References: <20200416195641.13144.16955.stgit@localhost.localdomain>
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

Add support for free page reporting. The idea is to function very similar
to how the balloon works in that we basically end up madvising the page as
not being used. However we don't really need to bother with any deflate
type logic since the page will be faulted back into the guest when it is
read or written to.

This provides a new way of letting the guest proactively report free
pages to the hypervisor, so the hypervisor can reuse them. In contrast to
inflate/deflate that is triggered via the hypervisor explicitly.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   62 +++++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-balloon.h |    2 +
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 19d587fd05cb..e5c9317921a1 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -321,6 +321,59 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
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
+        if (qemu_balloon_is_inhibited() || dev->poison_val) {
+            continue;
+        }
+
+        for (i = 0; i < elem->in_num; i++) {
+            void *addr = elem->in_sg[i].iov_base;
+            size_t size = elem->in_sg[i].iov_len;
+            ram_addr_t ram_offset;
+            RAMBlock *rb;
+
+            /*
+             * There is no need to check the memory section to see if
+             * it is ram/readonly/romd like there is for handle_output
+             * below. If the region is not meant to be written to then
+             * address_space_map will have allocated a bounce buffer
+             * and it will be freed in address_space_unmap and trigger
+             * and unassigned_mem_write before failing to copy over the
+             * buffer. If more than one bad descriptor is provided it
+             * will return NULL after the first bounce buffer and fail
+             * to map any resources.
+             */
+            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
+            if (!rb) {
+                trace_virtio_balloon_bad_addr(elem->in_addr[i]);
+                continue;
+            }
+
+            /*
+             * For now we will simply ignore unaligned memory regions, or
+             * regions that overrun the end of the RAMBlock.
+             */
+            if (!QEMU_IS_ALIGNED(ram_offset | size, qemu_ram_pagesize(rb)) ||
+		(ram_offset + size) > qemu_ram_get_used_length(rb)) {
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
@@ -728,7 +781,8 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
     f |= dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
-    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT) ||
+        virtio_has_feature(f, VIRTIO_BALLOON_F_REPORTING)) {
         virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
     }
 
@@ -818,6 +872,10 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
+        s->rvq = virtio_add_queue(vdev, 32, virtio_balloon_handle_report);
+    }
+
     if (virtio_has_feature(s->host_features,
                            VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
@@ -949,6 +1007,8 @@ static Property virtio_balloon_properties[] = {
      */
     DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
                      qemu_4_0_config_size, false),
+    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_REPORTING, true),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 3ca2a78e1aca..ac4013d51010 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_hint_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *rvq;
     uint32_t free_page_hint_status;
     uint32_t num_pages;
     uint32_t actual;


