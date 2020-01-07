Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99703C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBD12080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDJPf6Lf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBD12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioryw-0003qG-Ra
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorkP-00079w-LC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorkN-00054r-Ta
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33992
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorkN-00054a-O6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1jQK9Yxd2TIknp+M77tR7Mc2wzi2h6Dp27XqCYt2e4=;
 b=JDJPf6LfMTmG+xL9059VWgwjiXZnJadox5iTeqbT5+7ZbFfyjX81EEJTtO8wQsyNL0/PV5
 oekZNu40fP55RE4K1165TA6lWDWAuqvrn64frJo7s5630OhMynHXAe+LNXN93IQRfqNBqQ
 uIVqqBcUIf9hM05UQnNcKi5O+oqbTtQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-xg12IX3aNiiyuCfhwg9RAg-1; Tue, 07 Jan 2020 11:30:19 -0500
Received: by mail-qk1-f198.google.com with SMTP id d1so131128qkk.15
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ks6shax4mMonha1r8yzWlFliM2SkYmnLxhP6HsmGeGE=;
 b=Fwe/p5U+ZAAYqufn4zNGHHKy6OCBmcpw1R/YHDCXXaJjO1UyOGHAOPFYMMgQbf456m
 1/TH19IreZ0MP/Ffn4JRL9RrbxqRO9Pqh1l5fdOTRuAC+A+BAwapII0wETOhMEw1IyHg
 Pw+Q9NhQawFzWfRUgsluB0VOiDsHdFzQKthDHC/MWrnDM0h4tjq4yv/vnb6PKIK0NkTz
 ZlTXOU++x7vKu2EErV4oduAz2RDzxxFc9dPF5Jkq52JvJKJYadxD6sRP34cNS6UbMWV8
 dNaoDd0JkbhQbRmGtLpVozFigfVeRKCBO4nUsjonjxEibrLAzBBALlCKCos+uR/pWXtW
 xCMQ==
X-Gm-Message-State: APjAAAWTlBZ00qAah3X8AKbZTgxmH8rzb6rz+quMm4FczJc0Co1DENT4
 FQgl1g5gRE0742clXLc4MaoxyM5qqqpZ2fkKa4Rs237SGl3F39QuFkOFHJbM/gS4lYrb4LjqIpd
 Rf6obJNPsIbve+AI=
X-Received: by 2002:ad4:4b6a:: with SMTP id m10mr229638qvx.116.1578414619134; 
 Tue, 07 Jan 2020 08:30:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfMQGFR18WwTvHFSW5GJ9gR37znPFSMdOgvJO89YIRRpvXpo7QexUhtxdEylB0Y3BNuy4lWw==
X-Received: by 2002:ad4:4b6a:: with SMTP id m10mr229611qvx.116.1578414618846; 
 Tue, 07 Jan 2020 08:30:18 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id t73sm33063qke.71.2020.01.07.08.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:30:18 -0800 (PST)
Date: Tue, 7 Jan 2020 11:30:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 10/32] virtio: don't enable notifications during polling
Message-ID: <20200107162850.411448-11-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: xg12IX3aNiiyuCfhwg9RAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Virtqueue notifications are not necessary during polling, so we disable
them.  This allows the guest driver to avoid MMIO vmexits.
Unfortunately the virtio-blk and virtio-scsi handler functions re-enable
notifications, defeating this optimization.

Fix virtio-blk and virtio-scsi emulation so they leave notifications
disabled.  The key thing to remember for correctness is that polling
always checks one last time after ending its loop, therefore it's safe
to lose the race when re-enabling notifications at the end of polling.

There is a measurable performance improvement of 5-10% with the null-co
block driver.  Real-life storage configurations will see a smaller
improvement because the MMIO vmexit overhead contributes less to
latency.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20191209210957.65087-1-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  1 +
 hw/block/virtio-blk.c      |  9 +++++++--
 hw/scsi/virtio-scsi.c      |  9 +++++++--
 hw/virtio/virtio.c         | 12 ++++++------
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 777772475c..b69d517496 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -228,6 +228,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int ve=
rsion_id);
=20
 void virtio_notify_config(VirtIODevice *vdev);
=20
+bool virtio_queue_get_notification(VirtQueue *vq);
 void virtio_queue_set_notification(VirtQueue *vq, int enable);
=20
 int virtio_queue_ready(VirtQueue *vq);
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index d62e6377c2..b12157b5eb 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -764,13 +764,16 @@ bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *=
vq)
 {
     VirtIOBlockReq *req;
     MultiReqBuffer mrb =3D {};
+    bool suppress_notifications =3D virtio_queue_get_notification(vq);
     bool progress =3D false;
=20
     aio_context_acquire(blk_get_aio_context(s->blk));
     blk_io_plug(s->blk);
=20
     do {
-        virtio_queue_set_notification(vq, 0);
+        if (suppress_notifications) {
+            virtio_queue_set_notification(vq, 0);
+        }
=20
         while ((req =3D virtio_blk_get_request(s, vq))) {
             progress =3D true;
@@ -781,7 +784,9 @@ bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq=
)
             }
         }
=20
-        virtio_queue_set_notification(vq, 1);
+        if (suppress_notifications) {
+            virtio_queue_set_notification(vq, 1);
+        }
     } while (!virtio_queue_empty(vq));
=20
     if (mrb.num_reqs) {
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index e8b2b64d09..f080545f48 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -597,12 +597,15 @@ bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQue=
ue *vq)
 {
     VirtIOSCSIReq *req, *next;
     int ret =3D 0;
+    bool suppress_notifications =3D virtio_queue_get_notification(vq);
     bool progress =3D false;
=20
     QTAILQ_HEAD(, VirtIOSCSIReq) reqs =3D QTAILQ_HEAD_INITIALIZER(reqs);
=20
     do {
-        virtio_queue_set_notification(vq, 0);
+        if (suppress_notifications) {
+            virtio_queue_set_notification(vq, 0);
+        }
=20
         while ((req =3D virtio_scsi_pop_req(s, vq))) {
             progress =3D true;
@@ -622,7 +625,9 @@ bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue=
 *vq)
             }
         }
=20
-        virtio_queue_set_notification(vq, 1);
+        if (suppress_notifications) {
+            virtio_queue_set_notification(vq, 1);
+        }
     } while (ret !=3D -EINVAL && !virtio_queue_empty(vq));
=20
     QTAILQ_FOREACH_SAFE(req, &reqs, next, next) {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7bc6a9455e..95d8ff8508 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -432,6 +432,11 @@ static void virtio_queue_packed_set_notification(VirtQ=
ueue *vq, int enable)
     }
 }
=20
+bool virtio_queue_get_notification(VirtQueue *vq)
+{
+    return vq->notification;
+}
+
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification =3D enable;
@@ -3410,17 +3415,12 @@ static bool virtio_queue_host_notifier_aio_poll(voi=
d *opaque)
 {
     EventNotifier *n =3D opaque;
     VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
-    bool progress;
=20
     if (!vq->vring.desc || virtio_queue_empty(vq)) {
         return false;
     }
=20
-    progress =3D virtio_queue_notify_aio_vq(vq);
-
-    /* In case the handler function re-enabled notifications */
-    virtio_queue_set_notification(vq, 0);
-    return progress;
+    return virtio_queue_notify_aio_vq(vq);
 }
=20
 static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
--=20
MST


