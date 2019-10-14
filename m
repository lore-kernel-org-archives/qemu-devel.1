Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE79C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8218220854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8218220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2uX-0001Vw-6R
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iK2pE-0002uk-UV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iK2pD-0006WO-JP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iK2pA-0006QD-EA; Mon, 14 Oct 2019 12:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3CD03086211;
 Mon, 14 Oct 2019 16:03:55 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E23D5C1D4;
 Mon, 14 Oct 2019 16:03:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/15] replay: don't drain/flush bdrv queue while RR is working
Date: Mon, 14 Oct 2019 18:03:39 +0200
Message-Id: <20191014160343.8211-6-kwolf@redhat.com>
In-Reply-To: <20191014160343.8211-1-kwolf@redhat.com>
References: <20191014160343.8211-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 14 Oct 2019 16:03:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

In record/replay mode bdrv queue is controlled by replay mechanism.
It does not allow saving or loading the snapshots
when bdrv queue is not empty. Stopping the VM is not blocked by nonempty
queue, but flushing the queue is still impossible there,
because it may cause deadlocks in replay mode.
This patch disables bdrv_drain_all and bdrv_flush_all in
record/replay mode.

Stopping the machine when the IO requests are not finished is needed
for the debugging. E.g., breakpoint may be set at the specified step,
and forcing the IO requests to finish may break the determinism
of the execution.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 28 ++++++++++++++++++++++++++++
 cpus.c     |  2 --
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4f9ee97c2b..834841142a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "sysemu/replay.h"
=20
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in pro=
gress */
=20
@@ -600,6 +601,15 @@ void bdrv_drain_all_begin(void)
         return;
     }
=20
+    /*
+     * bdrv queue is managed by record/replay,
+     * waiting for finishing the I/O requests may
+     * be infinite
+     */
+    if (replay_events_enabled()) {
+        return;
+    }
+
     /* AIO_WAIT_WHILE() with a NULL context can only be called from the =
main
      * loop AioContext, so make sure we're in the main context. */
     assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context())=
;
@@ -629,6 +639,15 @@ void bdrv_drain_all_end(void)
     BlockDriverState *bs =3D NULL;
     int drained_end_counter =3D 0;
=20
+    /*
+     * bdrv queue is managed by record/replay,
+     * waiting for finishing the I/O requests may
+     * be endless
+     */
+    if (replay_events_enabled()) {
+        return;
+    }
+
     while ((bs =3D bdrv_next_all_states(bs))) {
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
@@ -2124,6 +2143,15 @@ int bdrv_flush_all(void)
     BlockDriverState *bs =3D NULL;
     int result =3D 0;
=20
+    /*
+     * bdrv queue is managed by record/replay,
+     * creating new flush request for stopping
+     * the VM may break the determinism
+     */
+    if (replay_events_enabled()) {
+        return result;
+    }
+
     for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
         int ret;
diff --git a/cpus.c b/cpus.c
index d2c61ff155..367f0657c5 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1097,7 +1097,6 @@ static int do_vm_stop(RunState state, bool send_sto=
p)
     }
=20
     bdrv_drain_all();
-    replay_disable_events();
     ret =3D bdrv_flush_all();
=20
     return ret;
@@ -2181,7 +2180,6 @@ int vm_prepare_start(void)
     /* We are sending this now, but the CPUs will be resumed shortly lat=
er */
     qapi_event_send_resume();
=20
-    replay_enable_events();
     cpu_enable_ticks();
     runstate_set(RUN_STATE_RUNNING);
     vm_state_notify(1, RUN_STATE_RUNNING);
--=20
2.20.1


