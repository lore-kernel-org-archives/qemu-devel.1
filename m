Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D47C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8400206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8400206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijKQn-0003qV-Uu
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 04:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJr-0004Jc-AQ
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJq-0005yU-1b
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:48:07 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50932)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJp-0005t1-L8
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:48:05 -0500
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id D9B5B54006B;
 Mon, 23 Dec 2019 12:48:03 +0300 (MSK)
Subject: [for-5.0 PATCH 08/11] replay: flush rr queue before loading the
 vmstate
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 23 Dec 2019 12:48:03 +0300
Message-ID: <157709448356.12933.1621745423878239085.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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

Non-empty record/replay queue prevents saving and loading the VM state,
because it includes pending bottom halves and block coroutines.
But when the new VM state is loaded, we don't have to preserve the consistency
of the current state anymore. Therefore this patch just flushes the queue
allowing the coroutines to finish and removes checking for empty rr queue
for load_snapshot function.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 include/sysemu/replay.h  |    2 ++
 migration/savevm.c       |   12 ++++++------
 replay/replay-internal.h |    2 --
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index e00ed2f4a5..239c01e7df 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -149,6 +149,8 @@ void replay_disable_events(void);
 void replay_enable_events(void);
 /*! Returns true when saving events is enabled */
 bool replay_events_enabled(void);
+/* Flushes events queue */
+void replay_flush_events(void);
 /*! Adds bottom half event to the queue */
 void replay_bh_schedule_event(QEMUBH *bh);
 /* Adds oneshot bottom half event to the queue */
diff --git a/migration/savevm.c b/migration/savevm.c
index ae84bf6ab0..0c5cac372a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2834,12 +2834,6 @@ int load_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!replay_can_snapshot()) {
-        error_setg(errp, "Record/replay does not allow loading snapshot "
-                   "right now. Try once more later.");
-        return -EINVAL;
-    }
-
     if (!bdrv_all_can_snapshot(&bs)) {
         error_setg(errp,
                    "Device '%s' is writable but does not support snapshots",
@@ -2873,6 +2867,12 @@ int load_snapshot(const char *name, Error **errp)
         return -EINVAL;
     }
 
+    /*
+     * Flush the record/replay queue. Now the VM state is going
+     * to change. Therefore we don't need to preserve its consistency
+     */
+    replay_flush_events();
+
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 2f6145ec7c..97649ed8d7 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -149,8 +149,6 @@ void replay_read_next_clock(unsigned int kind);
 void replay_init_events(void);
 /*! Clears internal data structures for events handling */
 void replay_finish_events(void);
-/*! Flushes events queue */
-void replay_flush_events(void);
 /*! Returns true if there are any unsaved events in the queue */
 bool replay_has_events(void);
 /*! Saves events from queue into the file */


