Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3764DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085E120720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdFjCgsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085E120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmwI-0004V9-6N
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmuw-0002cC-Mq
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmuu-0001IZ-T5
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SejujQmFP8i9uGegxOHZH22A3MzEqNQC/7kkGUHxhs=;
 b=DdFjCgsEepdeRuRskf9oEIunqTOqZjxjMz25dFMzZeiYiPRH9TTDyFhDFbx/a6HZN7F2rQ
 wZXVYpxbHe3kaC0iTc94rNcR0DhNdyiRLgD+DbsgeKN3+Iwwb80UibivtMFDOATUm54vLz
 Eb2oEx+ZY6GjKwrqxfNxDDW71/gPbDY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-kvLc4tTkMyG7L9CYslksHQ-1; Sat, 04 Jul 2020 14:29:34 -0400
X-MC-Unique: kvLc4tTkMyG7L9CYslksHQ-1
Received: by mail-wr1-f69.google.com with SMTP id o25so36282838wro.16
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3SejujQmFP8i9uGegxOHZH22A3MzEqNQC/7kkGUHxhs=;
 b=WFegdPxggmgb+KtNxi9UYDFvJgBsgQGUOHw6ZfwF51PuInnSphiBOZZFLdMJ6LcqvI
 vUiGc2GwCqY/HAQg/6UhH91aM6Ad2P4oRYcltlxqMZbQdvgFaDZPERiRYASphX1PmX7l
 z/LEQBUAl/VDSnuuXiO096ypwzmPA7R8yHYXlZd0dQOnJaByEZMp8RXaz6pkqWFJnqDD
 TYLUBgyT4YGUXi5OfwhDPF80YOVK/BZKyxdGg7z82LctVycWvt+aQIOclAKlN2AVNg0s
 P23dw+j6bwbybVs+dAEshBRoKkz1oPEpcYJ/FyYp/vqo9VyQMHk48U/Sbjo5HHkpGy5r
 2UKQ==
X-Gm-Message-State: AOAM5321uFiid9MxwCJfGY1M0q/EV7tfzH+JidIMm9e4JfLqLmujNgrl
 nz9s5Pv21z/tFS3n8yBaSyHSEvKZphp7tp33nNU44DtPnVwbc7wJdgMrWKBqqOUHCDnimH/lIfq
 +CnjwlCJAZMAQMJo=
X-Received: by 2002:adf:fe85:: with SMTP id l5mr39581540wrr.333.1593887372917; 
 Sat, 04 Jul 2020 11:29:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl7cC5HFtxklJWiLlUrG+mOqBn8iRF97gmoUQxr/9BjLTgrbk7C+zAbM7yDMq0iARg8U2bXQ==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr39581530wrr.333.1593887372687; 
 Sat, 04 Jul 2020 11:29:32 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 190sm5442856wmb.15.2020.07.04.11.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:32 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/41] virtio-balloon: always indicate S_DONE when
 migration fails
Message-ID: <20200704182750.1088103-4-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

If something goes wrong during precopy, before stopping the VM, we will
never send a S_DONE indication to the VM, resulting in the hinted pages
not getting released to be used by the guest OS (e.g., Linux).

Easy to reproduce:
1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
2. Cancel migration (e.g., HMP "migrate_cancel")
3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
   no free memory left.

While at it, add similar locking to virtio_balloon_free_page_done() as
done in virtio_balloon_free_page_stop. Locking is still weird, but that
has to be sorted out separately.

There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
comments regarding S_DONE handling.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200629080615.26022-1-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a43..8a84718490 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -628,8 +628,13 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
-    virtio_notify_config(vdev);
+    if (s->free_page_report_status != FREE_PAGE_REPORT_S_DONE) {
+        /* See virtio_balloon_free_page_stop() */
+        qemu_mutex_lock(&s->free_page_lock);
+        s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
+        qemu_mutex_unlock(&s->free_page_lock);
+        virtio_notify_config(vdev);
+    }
 }
 
 static int
@@ -653,17 +658,26 @@ virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
     case PRECOPY_NOTIFY_SETUP:
         precopy_enable_free_page_optimization();
         break;
-    case PRECOPY_NOTIFY_COMPLETE:
-    case PRECOPY_NOTIFY_CLEANUP:
     case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
         virtio_balloon_free_page_stop(dev);
         break;
     case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
         if (vdev->vm_running) {
             virtio_balloon_free_page_start(dev);
-        } else {
-            virtio_balloon_free_page_done(dev);
+            break;
         }
+        /*
+         * Set S_DONE before migrating the vmstate, so the guest will reuse
+         * all hinted pages once running on the destination. Fall through.
+         */
+    case PRECOPY_NOTIFY_CLEANUP:
+        /*
+         * Especially, if something goes wrong during precopy or if migration
+         * is canceled, we have to properly communicate S_DONE to the VM.
+         */
+        virtio_balloon_free_page_done(dev);
+        break;
+    case PRECOPY_NOTIFY_COMPLETE:
         break;
     default:
         virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
-- 
MST


