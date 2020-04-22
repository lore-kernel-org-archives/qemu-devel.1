Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1EBC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE182098B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+8GWSOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE182098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK2q-0000lx-3c
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRK03-0005TQ-QT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRK02-0003ZD-OF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:31 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32]:35713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jRK02-0003WI-9f
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:30 -0400
Received: by mail-qv1-xf32.google.com with SMTP id v10so1401231qvr.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=SH/65jIkrtSeeW/mAEjdDz+ENo/q+X4g5sfgY/LNkF8=;
 b=o+8GWSOHmbU20SpYCo6cG5qDyEn618Ub2pWbnxpl9VOimJ4keG2iNhuxuN6EOl9z0g
 6sMyoEqyMPm24tfSgVqlbgSxMF/qnYdensEqTa0nYuoxVC4aMf8r3OQVI9x1UN9igIuh
 ln/tcmJGUKxU5AuKodXh11qCQ4uZT5h5UbA85pFbR7RVzE0B1COyaLU7+UQNQLZWeMQs
 G5wb946Eg1t7Z/iHZKqu6UqylcQ5kbPHImRb0UJQwdtmtmOQ1rH+C8OW9MrE57wImh3V
 OBvAMtcbQ5hr9qT1VVyO4r6/Rg6bFc50JN2+ipFVgZcPnVZQngyZ5AH2NDPgJZfoGgyT
 1SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=SH/65jIkrtSeeW/mAEjdDz+ENo/q+X4g5sfgY/LNkF8=;
 b=Fo5uU21p7XXyv4yctBTWzGBZSb+UI6WTXg+hOcAnFFonljXSXOxewYgd6Qb1a9CYAr
 d7tMR7oLMHbur9sPty4CBtKq4rtI2PHHvCAd2v7Mn9c0N3yMY44Tr37dozZOj+XPG1Yx
 4KWi+8SiMp+dOQuvuns9J/si0ys7S3Mxy/AtDVh+js4XI9tHEHHWL878xG7l/F6dJUXK
 42blVAvppGVHxkg0zn6negGyTYoLDHUMuahGlKGuaa15ffYhy/px6kJmQEn11AStfOGU
 k1d+ABXrMD1oIE8W5e5EIFwVER3bRZYvDTVp1JmLVtKWHs/XdcZE25aGnYcEdJPotM3U
 ce7w==
X-Gm-Message-State: AGi0Pua7rMYs4eUBHsPV3Cpgbtq20THEVR7tSP93JS+9dNFAaB53BXFS
 6vouB2zi1CpZJV6PP0K/nYQIPsvBTUs=
X-Google-Smtp-Source: APiQypILZzG2AF6qSMFleXJPZPIwp9FqAM9MYhXU03tP1UBo9fl5/OaSf4KPQNy9pPbXCDUI69VVgQ==
X-Received: by 2002:a0c:e8c2:: with SMTP id m2mr247175qvo.24.1587579689243;
 Wed, 22 Apr 2020 11:21:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id f130sm4397937qke.22.2020.04.22.11.21.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Apr 2020 11:21:28 -0700 (PDT)
Subject: [PATCH v21 QEMU 5/5] virtio-balloon: Provide an interface for free
 page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Wed, 22 Apr 2020 11:21:27 -0700
Message-ID: <20200422182127.12258.26300.stgit@localhost.localdomain>
In-Reply-To: <20200422181649.12258.37077.stgit@localhost.localdomain>
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qv1-xf32.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::f32
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
 hw/virtio/virtio-balloon.c         |   70 ++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h |    2 +
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 5effc8b4653b..b473ff7f4b88 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -321,6 +321,60 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
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
+            goto skip_element;
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
+                (ram_offset + size) > qemu_ram_get_used_length(rb)) {
+                continue;
+            }
+
+            ram_block_discard_range(rb, ram_offset, size);
+        }
+
+skip_element:
+        virtqueue_push(vq, elem, 0);
+        virtio_notify(vdev, vq);
+        g_free(elem);
+    }
+}
+
 static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
@@ -782,6 +836,16 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
     int ret;
 
+    /*
+     * Page reporting is dependant on page poison to make sure we can
+     * report a page without changing the state of the internal data.
+     * We need to set the flag before we call virtio_init as it will
+     * affect the config size of the vdev.
+     */
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
+        s->host_features |= 1 << VIRTIO_BALLOON_F_PAGE_POISON;
+    }
+
     virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
                 virtio_balloon_config_size(s));
 
@@ -798,6 +862,10 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
+        s->rvq = virtio_add_queue(vdev, 32, virtio_balloon_handle_report);
+    }
+
     if (virtio_has_feature(s->host_features,
                            VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
@@ -923,6 +991,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_REPORTING, true),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
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


