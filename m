Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5997C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D6621881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D6621881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACHm-0002gg-Hj
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAC7d-0004Ei-Sz
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAC7W-0001Xw-NR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:58:13 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42246)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAC7W-0001X9-03
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:58:10 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 370385400BA;
 Tue, 17 Sep 2019 14:58:08 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 14:58:08 +0300
Message-ID: <156872148803.1757.18423223977374974885.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
References: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [for-4.2 PATCH 4/6] replay: don't drain/flush bdrv
 queue while RR is working
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
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
---
 block/io.c |   28 ++++++++++++++++++++++++++++
 cpus.c     |    2 --
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index f8c3596131..fdb586cb72 100644
--- a/block/io.c
+++ b/block/io.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "sysemu/replay.h"
 
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
 
@@ -600,6 +601,15 @@ void bdrv_drain_all_begin(void)
         return;
     }
 
+    /*
+     * bdrv queue is managed by record/replay,
+     * waiting for finishing the I/O requests may
+     * be infinite
+     */
+    if (replay_events_enabled()) {
+        return;
+    }
+
     /* AIO_WAIT_WHILE() with a NULL context can only be called from the main
      * loop AioContext, so make sure we're in the main context. */
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
@@ -629,6 +639,15 @@ void bdrv_drain_all_end(void)
     BlockDriverState *bs = NULL;
     int drained_end_counter = 0;
 
+    /*
+     * bdrv queue is managed by record/replay,
+     * waiting for finishing the I/O requests may
+     * be endless
+     */
+    if (replay_events_enabled()) {
+        return;
+    }
+
     while ((bs = bdrv_next_all_states(bs))) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
@@ -2111,6 +2130,15 @@ int bdrv_flush_all(void)
     BlockDriverState *bs = NULL;
     int result = 0;
 
+    /*
+     * bdrv queue is managed by record/replay,
+     * creating new flush request for stopping
+     * the VM may break the determinism
+     */
+    if (replay_events_enabled()) {
+        return result;
+    }
+
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
         int ret;
diff --git a/cpus.c b/cpus.c
index 85cd451a86..eb1c65ebc8 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1086,7 +1086,6 @@ static int do_vm_stop(RunState state, bool send_stop)
     }
 
     bdrv_drain_all();
-    replay_disable_events();
     ret = bdrv_flush_all();
 
     return ret;
@@ -2172,7 +2171,6 @@ int vm_prepare_start(void)
     /* We are sending this now, but the CPUs will be resumed shortly later */
     qapi_event_send_resume();
 
-    replay_enable_events();
     cpu_enable_ticks();
     runstate_set(RUN_STATE_RUNNING);
     vm_state_notify(1, RUN_STATE_RUNNING);


