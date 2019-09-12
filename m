Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3241C4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 18:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AD120684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 18:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AD120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8TjY-0006WD-QY
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 14:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8Thl-0005GR-Jz
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 14:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8Thk-00042P-Hw
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 14:20:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>)
 id 1i8Thd-0003wz-RO; Thu, 12 Sep 2019 14:20:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE6F9309174E;
 Thu, 12 Sep 2019 18:20:19 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93D9C453B;
 Thu, 12 Sep 2019 18:20:02 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 20:19:25 +0200
Message-Id: <20190912181924.48539-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 12 Sep 2019 18:20:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH] virtio-blk: schedule virtio_notify_config
 to run on main context
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
Cc: kwolf@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Another AioContext-related issue, and this is a tricky one.

Executing a QMP block_resize request for a virtio-blk device running
on an iothread may cause a deadlock involving the following mutexes:

 - main thead
  * Has acquired: qemu_mutex_global.
  * Is trying the acquire: iothread AioContext lock via
    AIO_WAIT_WHILE (after aio_poll).

 - iothread
  * Has acquired: AioContext lock.
  * Is trying to acquire: qemu_mutex_global (via
    virtio_notify_config->prepare_mmio_access).

With this change, virtio_blk_resize checks if it's being called from a
coroutine context running on a non-main thread, and if that's the
case, creates a new coroutine and schedules it to be run on the main
thread.

This works, but means the actual operation is done
asynchronously, perhaps opening a window in which a "device_del"
operation may fit and remove the VirtIODevice before
virtio_notify_config() is executed.

I *think* it shouldn't be possible, as BHs will be processed before
any new QMP/monitor command, but I'm open to a different approach.

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1744955
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/block/virtio-blk.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 18851601cb..c763d071f6 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -16,6 +16,7 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "trace.h"
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
@@ -1086,11 +1087,33 @@ static int virtio_blk_load_device(VirtIODevice *v=
dev, QEMUFile *f,
     return 0;
 }
=20
+static void coroutine_fn virtio_resize_co_entry(void *opaque)
+{
+    VirtIODevice *vdev =3D opaque;
+
+    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context())=
;
+    virtio_notify_config(vdev);
+    aio_wait_kick();
+}
+
 static void virtio_blk_resize(void *opaque)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
+    Coroutine *co;
=20
-    virtio_notify_config(vdev);
+    if (qemu_in_coroutine() &&
+        qemu_get_current_aio_context() !=3D qemu_get_aio_context()) {
+        /*
+         * virtio_notify_config() needs to acquire the global mutex,
+         * so calling it from a coroutine running on a non-main context
+         * may cause a deadlock. Instead, create a new coroutine and
+         * schedule it to be run on the main thread.
+         */
+        co =3D qemu_coroutine_create(virtio_resize_co_entry, vdev);
+        aio_co_schedule(qemu_get_aio_context(), co);
+    } else {
+        virtio_notify_config(vdev);
+    }
 }
=20
 static const BlockDevOps virtio_block_ops =3D {
--=20
2.21.0


