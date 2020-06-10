Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52160C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189A120734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4eBol0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189A120734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisZa-00052q-9Q
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKn-000842-JJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39796
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKm-0008G7-Gj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NgqF724ZlpYDgxpsvGgomKXglTKeYnsN1WEfd42scpg=;
 b=C4eBol0bpJBnPbvOv0WJIK5kWg9Ouhuop1b96AIkucac6hacqCRakXO73t2BwTg0QujF/D
 ok6Ld+SnlBIM4ABr5q1wpjqorF/o4GvDsA/aRAUA6upevuvQUgnuRvDCznRvFARyvYfNwz
 g5OjxYK6HtzCrF0ZIC0oGdPazRlEWi0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-rkGY1gscPoGRMLpNsaPBjQ-1; Wed, 10 Jun 2020 00:27:25 -0400
X-MC-Unique: rkGY1gscPoGRMLpNsaPBjQ-1
Received: by mail-wr1-f72.google.com with SMTP id e1so515101wrm.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NgqF724ZlpYDgxpsvGgomKXglTKeYnsN1WEfd42scpg=;
 b=uPbJ2EZZa4m0LvC4vz6wK72ZVktrxAxHsmeOOtCfTpmoYFXkR5obbJH63nAfJQyHL4
 snD5Ps2wbakt4rZ6GPS0cS2pqXDEc6vAPiqV7W6gPoJzwBaI2Q+k7xpkfADR+SSac8Iq
 x3DsH1AmLz8jJ+k+946eMZzCQApNkT0cbTXpJXKSy3gYkEygAVU38yI2Cpd3UMZLOoP0
 CUYAhAud4OkrB1qoCURwQnHh2nxsdAdgmIHfgceM9Kk4xDpGUldPbmYYyinx4HepYby2
 dSohhRaOUr66zC0WCLxc2uhoq0eMbXlBwLZwhLmUYSUlc8FB9y+erh5Ju9bGGwo7bSVN
 ghdg==
X-Gm-Message-State: AOAM531eqk6p9x6JNxxNMHKO1/UwwiXvgO0WuQd9G9gVwcb5NcK0GewC
 gQvLWJIB6FsN8snePVRFWcuUQndJAAJWiZHps8mrznSexxVSw9UqhTroJ2YhwZdfzsXZ+MrTPOE
 sojHkQBv+Monyuy0=
X-Received: by 2002:a1c:254:: with SMTP id 81mr1145732wmc.93.1591763244469;
 Tue, 09 Jun 2020 21:27:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6aFUmZ5t0h3PYsNSePX/5tY4B2Ik6BB2+DVverBMI9VTicaalW7qv9qGWPrSrACmu0pfjJg==
X-Received: by 2002:a1c:254:: with SMTP id 81mr1145720wmc.93.1591763244263;
 Tue, 09 Jun 2020 21:27:24 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id l2sm6095982wru.58.2020.06.09.21.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:23 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/56] virtio-balloon: fix free page hinting without an iothread
Message-ID: <20200610042613.1459309-23-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>, Alexander Bulekov <alxndr@bu.edu>,
 Wei Wang <wei.w.wang@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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

While at it, move the static initializations to instance_init().
free_page_report_status and block_iothread are implicitly set to the
right values (0/false) already, so drop the initialization.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-stable@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200520100439.19872-2-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 065cd450f1..7ff6a7aa7c 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -789,6 +789,13 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT) &&
+        !s->iothread) {
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
@@ -892,6 +886,11 @@ static void virtio_balloon_instance_init(Object *obj)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(obj);
 
+    qemu_mutex_init(&s->free_page_lock);
+    qemu_cond_init(&s->free_page_cond);
+    s->free_page_report_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+    s->free_page_report_notify.notify = virtio_balloon_free_page_report_notify;
+
     object_property_add(obj, "guest-stats", "guest statistics",
                         balloon_stats_get_all, NULL, NULL, s);
 
-- 
MST


