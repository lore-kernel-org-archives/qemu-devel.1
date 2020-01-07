Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F9DC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6A3207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPyCKIje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6A3207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iok7l-0005av-0M
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojPL-0005Ez-28
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojPJ-0007fi-6O
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojPJ-0007fR-1h
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1jQK9Yxd2TIknp+M77tR7Mc2wzi2h6Dp27XqCYt2e4=;
 b=fPyCKIjePdaUwI//TKcaHe7ESs2iipUwaLRw2S7gIYiHUZmk/6VYVrKhcY8lm3uxjn964z
 UBIzaTNwFZUCnD0FBNTbKDQYDftYUabaj8MAO2Nr6G4R5hPZc1LosePGUoj9lmBWX5pDFt
 M4gVLPiLJdrl0jOV75vCjX4xdk8/YFU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-P4YjSryYOIyAmt6QiWv3YA-1; Tue, 07 Jan 2020 02:36:03 -0500
Received: by mail-qk1-f198.google.com with SMTP id a6so1818848qkl.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ks6shax4mMonha1r8yzWlFliM2SkYmnLxhP6HsmGeGE=;
 b=tE8txtbcjWeRYWpG9ETQLjMKK0AgrphOhV32BLwh5cSmt1ws930TEeCTkV3oKDAu3j
 zfrnQFVgtCB0U2eqW1t0GkPKReY1Oa9fiLDy6S01RS6U2wZ3Zb7Oh7ZKqGd3HjXTfjll
 ycDuKbFG2pJKqh0ZaTwTs7tgCGXLKGqeFkIzF5MIX38tLnAqsY+sYtTSXzwuvoHs5z5C
 pYvblafyT8w8xqaGw2frx7jqJE+LTI8AImGdmnGNnhzyKJIdlDjewYQQPpw2orWOKa2V
 eH0et+PaPif7lVdBweDXZTF+/XQRCNrHK70t9vrgMwW+bJoC9NnCIT53n9Sfbs0hvF/B
 NIoQ==
X-Gm-Message-State: APjAAAUx1ys8/z971XdeUY0NTRrlkvNtJWhLvGeeutUa+OuCPWy7XS7c
 qnVpmWB+t9HX/eGi7yyXjRKvHuJNEDPHGTu0NMOiJhrnnoXBP1qJkxFSBxlFl60hEwx3En8vhA4
 d+jSy2jti6vcG4oU=
X-Received: by 2002:a05:620a:74f:: with SMTP id
 i15mr89033207qki.93.1578382562572; 
 Mon, 06 Jan 2020 23:36:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgzb9UzEfNOwS9WvoZxKtWM6MJjpMAV0FDBmm4BIhXQ3JT0KfR9OhnEaPnZ1aRINcSh4MU1w==
X-Received: by 2002:a05:620a:74f:: with SMTP id
 i15mr89033190qki.93.1578382562306; 
 Mon, 06 Jan 2020 23:36:02 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id r37sm24889260qtj.44.2020.01.06.23.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:36:01 -0800 (PST)
Date: Tue, 7 Jan 2020 02:35:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/32] virtio: don't enable notifications during polling
Message-ID: <20200107073451.298261-11-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: P4YjSryYOIyAmt6QiWv3YA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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


