Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659AC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3FC2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3FC2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT29q-0001iF-C4
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:38:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hT296-0001QO-6v
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hT28y-0006Mb-BC
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:37:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hT28v-0006Hs-1j
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D623C05B1CA;
	Tue, 21 May 2019 10:36:56 +0000 (UTC)
Received: from localhost (ovpn-117-188.ams2.redhat.com [10.36.117.188])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C8AA4600C6;
	Tue, 21 May 2019 10:36:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 11:36:50 +0100
Message-Id: <20190521103650.18479-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 21 May 2019 10:37:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC] scsi: restart dma after vm change state handlers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various components register vm change state handlers to restart device
emulation when the guest is unpaused.  These handlers run in an
arbitrary order since there is no way to specific explicit dependencies
or priorities.

Each SCSIDevice has a vm change state handler to restart failed I/O
requests when the guest is unpaused.  It schedules a BH in the
AioContext of the BlockBackend.

When virtio-scsi is used with an iothread, the BH may execute in the
iothread while the main loop thread is invoking the remaining vm change
state handlers.  In this case virtio-scsi iothread may not be fully
started yet, leading to problems.

One symptom is that I/O request completion is processed in the iothread
before virtio-scsi iothread is fully started and the MSI notify code
path takes the BQL.  This violates QEMU's lock order and causes a
deadlock.

This patch defers restarting SCSIDevice requests until after all vm
change state handlers have completed.  It's an ugly fix because we're
taking advantage of side-effects instead of explicitly introducing
dependencies that are visible in the source code, but I haven't found a
cleaner solution that isn't also complex and hard to understand.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This is RFC because I am waiting for a test result on the system where
the bug was originally discovered.  I'm also open to nicer solutions!

 hw/scsi/scsi-bus.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index c480553083..13b3823752 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -134,13 +134,10 @@ void scsi_req_retry(SCSIRequest *req)
     req->retry =3D true;
 }
=20
-static void scsi_dma_restart_cb(void *opaque, int running, RunState stat=
e)
+static void scsi_device_retry_reqs_bh(void *opaque)
 {
     SCSIDevice *s =3D opaque;
=20
-    if (!running) {
-        return;
-    }
     if (!s->bh) {
         AioContext *ctx =3D blk_get_aio_context(s->conf.blk);
         s->bh =3D aio_bh_new(ctx, scsi_dma_restart_bh, s);
@@ -148,6 +145,22 @@ static void scsi_dma_restart_cb(void *opaque, int ru=
nning, RunState state)
     }
 }
=20
+static void scsi_dma_restart_cb(void *opaque, int running, RunState stat=
e)
+{
+    SCSIDevice *s =3D opaque;
+
+    if (!running) {
+        return;
+    }
+
+    /* Defer to a main loop BH since other vm change state handlers may =
need to
+     * run before the bus is ready for I/O activity (e.g. virtio-scsi's
+     * iothread setup).
+     */
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            scsi_device_retry_reqs_bh, s);
+}
+
 static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev =3D SCSI_DEVICE(qdev);
--=20
2.21.0


