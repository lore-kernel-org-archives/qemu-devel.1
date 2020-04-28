Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E03C83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 00:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EE5206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 00:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ott5Zfcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EE5206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTEaj-0006rL-0W
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 20:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jTEVq-0007w1-Hx
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jTEVp-0007t2-Sg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:54:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jTEVp-0007ra-FJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:54:13 -0400
Received: by mail-pl1-x641.google.com with SMTP id t4so7641404plq.12
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 17:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=f60PjaQ32uAPz31QIwCr3FQCyG63xWUpLWuGVvAuWxg=;
 b=ott5ZfcfjsX8twq3aMk83UeYAo9pX8WJJxHY6YdkeYFfBJGRxsxYZZA7v7EDhpGhKb
 o3PLPkMKlrJ6VZU4rIylsZLL9yoQh9tgeKUDkJYZNG3WjaZsm80DpmNNHaTU1pRd8+eX
 QT6oHgoIbz4xgVY48EkqikxACeJrdSGKoAJomSzwLDsqiARh5HIw/OP0UFmjY+GeScpH
 oXSN0ToZeTGGutXg7YzIJT1EP9HSBWZfh+vJ9jTblhq2+UX5qihpSOrFq5XN2ocDc2IP
 FEDCRdQWSmiIqI5/wpjAvGgNkzcuJpFjGWhIwjhjgwk98zDa6ZOmgawH9FTffN/W9xEP
 8sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=f60PjaQ32uAPz31QIwCr3FQCyG63xWUpLWuGVvAuWxg=;
 b=Xn5UDkX/uINv8z1Uo5cnGUI1p7GRAbGAlILKH0WE4t47FcBGGcUQyNA2nn1tSbIo/y
 Z+n+XXJgOF8B8fx/A1zX9iJPok1nfeOFIRGHRqDmbhs+mRdVZGqOrzqytOsH0tvzBx28
 Y8cYVz/9e1NV4/lWco1/4Z+oMViTmbXiqRS73js/T0vdKuDcsyDe2isP5CcDMo/mOGVw
 YsBJe61PqRXRDruukc8PGIkIbG0o8d9NzpdFtQg1iS+FJ+TrQzkdPbjiVlYltvNLSe1B
 smnV5h36hbPEGXzHg0unhAAgC4R0kDqd6Uzv5Ye2Fna/XXiLXvHtnR524W9cP08duaLp
 U8MQ==
X-Gm-Message-State: AGi0PuZXlDe0TBFQvUIKM2RvXV7/LGX2MBFf6FRaMLwFj3XD5YXHDk1b
 aeedaJSAlXj+W8w9Cj6IKcE=
X-Google-Smtp-Source: APiQypKM/UeoJ04DIuB1fMPrOKtfTjcu0VeAbgnUH8nfuNpNf3i8qI3e9mdrAZsIXqT5X4CvWWS+DA==
X-Received: by 2002:a17:90a:25cb:: with SMTP id
 k69mr1665193pje.93.1588035252024; 
 Mon, 27 Apr 2020 17:54:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id 67sm3945151pfx.108.2020.04.27.17.54.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 17:54:11 -0700 (PDT)
Subject: [PATCH v23 QEMU 5/5] virtio-balloon: Provide an interface for free
 page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 27 Apr 2020 17:54:10 -0700
Message-ID: <20200428005410.6158.56128.stgit@localhost.localdomain>
In-Reply-To: <20200428005134.6158.88521.stgit@localhost.localdomain>
References: <20200428005134.6158.88521.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   69 ++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h |    2 +
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 1666132a24c1..53abba290274 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -321,6 +321,67 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
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
+        /*
+         * When we discard the page it has the effect of removing the page
+         * from the hypervisor itself and causing it to be zeroed when it
+         * is returned to us. So we must not discard the page if it is
+         * accessible by another device or process, or if the guest is
+         * expecting it to retain a non-zero value.
+         */
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
@@ -841,6 +902,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
             virtio_error(vdev, "iothread is missing");
         }
     }
+
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
+        s->reporting_vq = virtio_add_queue(vdev, 32,
+                                           virtio_balloon_handle_report);
+    }
+
     reset_stats(s);
 }
 
@@ -945,6 +1012,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
     DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_PAGE_POISON, true),
+    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_REPORTING, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 3ca2a78e1aca..28fd2b396087 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_hint_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
     uint32_t free_page_hint_status;
     uint32_t num_pages;
     uint32_t actual;


