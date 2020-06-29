Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8AEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F7923134
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WT2uuBfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F7923134
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpool-0005i3-LT
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jpooC-0005HS-Hb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:06:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jpooA-0000aR-3b
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593417987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Quvs3auXGsiNa9bwq9vvT9IlJxvPAaxrbsRhS2i4QrE=;
 b=WT2uuBfRIuHTzyAqTm0OIh/sgqllOgvxdmfYGbaUtLkhfdxWrFi3P0Ol6azCzoHp4p+0Cj
 kXVk4EeGf8MCIuGfYXvsEfFnnn2T7YaE6UZkuoxkO/648rrm1pcjiHoWfHP+lqrvpFHImc
 2Tc2HnxFXiBVOhCKgsxU7nfkRwtPKQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-CTox0YmYPJiuz3BNW_XxQg-1; Mon, 29 Jun 2020 04:06:26 -0400
X-MC-Unique: CTox0YmYPJiuz3BNW_XxQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8B08015FD;
 Mon, 29 Jun 2020 08:06:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-157.ams2.redhat.com [10.36.114.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BCAC121A56;
 Mon, 29 Jun 2020 08:06:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-balloon: always indicate S_DONE when migration fails
Date: Mon, 29 Jun 2020 10:06:15 +0200
Message-Id: <20200629080615.26022-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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
Cc: virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Wei Wang <wei.w.wang@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
2.26.2


