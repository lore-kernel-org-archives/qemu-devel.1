Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B90BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4993120787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJVtsEs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4993120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabHt-00016F-L3
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jabH0-0008Sx-GJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:37:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27748
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jabGy-0006XW-39
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589791039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFiNzqKUj9HdAKWL3/7nvK9e59GqJrgLob/Psphcl9E=;
 b=RJVtsEs6iu+pbSlizMxVu9uw42g0S/TCJSC+xorqNIJ97/VNYQ9tEBc8BcPTZ9k3+4sIbC
 uweXW93LWvASl7VxPJCIhEuv8zwuOjm6nr1WDl2g2eZwqZQqFPFWdiAftRWGhXi8RdRp9q
 wdGdhvxnOqH0ikjdARBXYGzmhnYz7mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-ZcRIzBcEPg2dqOUgLwDlWA-1; Mon, 18 May 2020 04:37:17 -0400
X-MC-Unique: ZcRIzBcEPg2dqOUgLwDlWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 702C21B18BC0;
 Mon, 18 May 2020 08:37:16 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-224.ams2.redhat.com [10.36.113.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D86A25C1B2;
 Mon, 18 May 2020 08:37:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/3] virtio-balloon: fix free page hinting without an
 iothread
Date: Mon, 18 May 2020 10:37:02 +0200
Message-Id: <20200518083704.52646-2-david@redhat.com>
In-Reply-To: <20200518083704.52646-1-david@redhat.com>
References: <20200518083704.52646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Alexander Bulekov <alxndr@bu.edu>,
 Wei Wang <wei.w.wang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case we don't have an iothread, we mark the feature as abscent but
still add the queue. 'free_page_bh' remains set to NULL.

qemu-system-i386 \
        -M microvm \
        -nographic \
        -device virtio-balloon-device,free-page-hint=true \
        -nographic \
        -display none \
        -monitor none \
        -serial none \
        -qtest stdio

Doing a "write 0xc0000e30 0x24
0x030000000300000003000000030000000300000003000000030000000300000003000000"

We will trigger a SEGFAULT. Let's move the check and bail out.

While at it, move the static initializations to instance_initialize().

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 065cd450f1..dc3b1067ab 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -789,6 +789,13 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (virtio_has_feature(s->host_features,
+        VIRTIO_BALLOON_F_FREE_PAGE_HINT) && !s->iothread) {
+        error_setg(errp, "'free-page-hint' requires 'iothread' to be set");
+        virtio_cleanup(vdev);
+        return;
+    }
+
     s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
@@ -797,24 +804,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
                            VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
-        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
-        s->free_page_report_cmd_id =
-                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
-        s->free_page_report_notify.notify =
-                                       virtio_balloon_free_page_report_notify;
         precopy_add_notifier(&s->free_page_report_notify);
-        if (s->iothread) {
-            object_ref(OBJECT(s->iothread));
-            s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
-                                       virtio_ballloon_get_free_page_hints, s);
-            qemu_mutex_init(&s->free_page_lock);
-            qemu_cond_init(&s->free_page_cond);
-            s->block_iothread = false;
-        } else {
-            /* Simply disable this feature if the iothread wasn't created. */
-            s->host_features &= ~(1 << VIRTIO_BALLOON_F_FREE_PAGE_HINT);
-            virtio_error(vdev, "iothread is missing");
-        }
+
+        object_ref(OBJECT(s->iothread));
+        s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
+                                     virtio_ballloon_get_free_page_hints, s);
     }
     reset_stats(s);
 }
@@ -892,6 +886,13 @@ static void virtio_balloon_instance_init(Object *obj)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(obj);
 
+    qemu_mutex_init(&s->free_page_lock);
+    qemu_cond_init(&s->free_page_cond);
+    s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+    s->free_page_report_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+    s->free_page_report_notify.notify = virtio_balloon_free_page_report_notify;
+    s->block_iothread = false;
+
     object_property_add(obj, "guest-stats", "guest statistics",
                         balloon_stats_get_all, NULL, NULL, s);
 
-- 
2.25.4


