Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB525C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA88204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA88204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35909 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIX9s-0000LL-QD
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 07:30:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWza-00084A-BQ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWzZ-0001XI-9R
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:10 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46910)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWzY-0001X7-UH
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:20:09 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1389C5400A9;
	Mon, 22 Apr 2019 14:20:08 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 14:20:07 +0300
Message-ID:
 <155593200785.21079.10270664368681344263.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.1 05/24] replay: don't drain/flush bdrv
 queue while RR is working
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
	pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
	crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
	jasowang@redhat.com, quintela@redhat.com, armbru@redhat.com,
	mreitz@redhat.com, alex.bennee@linaro.org,
	maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
	boost.lists@gmail.com, thomas.dullien@googlemail.com,
	dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
	dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422112007.Nym-pmDXDi7t_Pvb-DnGIghI5X5zRI-gjldT4hukLrw@z>

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
index dfc153b8d8..fe189a4238 100644
--- a/block/io.c
+++ b/block/io.c
@@ -32,6 +32,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "sysemu/replay.h"
 
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
 
@@ -538,6 +539,15 @@ void bdrv_drain_all_begin(void)
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
@@ -566,6 +576,15 @@ void bdrv_drain_all_end(void)
 {
     BlockDriverState *bs = NULL;
 
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
 
@@ -1962,6 +1981,15 @@ int bdrv_flush_all(void)
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
index e83f72b48b..5ff61fbf53 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1078,7 +1078,6 @@ static int do_vm_stop(RunState state, bool send_stop)
     }
 
     bdrv_drain_all();
-    replay_disable_events();
     ret = bdrv_flush_all();
 
     return ret;
@@ -2150,7 +2149,6 @@ int vm_prepare_start(void)
     /* We are sending this now, but the CPUs will be resumed shortly later */
     qapi_event_send_resume();
 
-    replay_enable_events();
     cpu_enable_ticks();
     runstate_set(RUN_STATE_RUNNING);
     vm_state_notify(1, RUN_STATE_RUNNING);


