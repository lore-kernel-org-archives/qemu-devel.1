Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDEEC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72E321941
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72E321941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDWL-0005LM-0B
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kNDOU-0003LB-98
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:02:02 -0400
Received: from mail.ispras.ru ([83.149.199.84]:35218)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kNDOR-0002fd-1j
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:02:01 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 0DF7240F9AAE;
 Tue, 29 Sep 2020 11:01:57 +0000 (UTC)
Subject: [PATCH v6 09/14] replay: flush rr queue before loading the vmstate
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 29 Sep 2020 14:01:56 +0300
Message-ID: <160137731672.31007.8039171437790634738.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
References: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 07:01:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, pavel.dovgalyuk@ispras.ru,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
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

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/sysemu/replay.h  |    2 ++
 migration/savevm.c       |   12 ++++++------
 replay/replay-events.c   |    4 ++++
 replay/replay-internal.h |    2 --
 4 files changed, 12 insertions(+), 8 deletions(-)

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
index 0e8dc78684..d2e141f7b1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2881,12 +2881,6 @@ int load_snapshot(const char *name, Error **errp)
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
@@ -2920,6 +2914,12 @@ int load_snapshot(const char *name, Error **errp)
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
 
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 302b84043a..a1c6bb934e 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -77,6 +77,10 @@ bool replay_has_events(void)
 
 void replay_flush_events(void)
 {
+    if (replay_mode == REPLAY_MODE_NONE) {
+        return;
+    }
+
     g_assert(replay_mutex_locked());
 
     while (!QTAILQ_EMPTY(&events_list)) {
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


