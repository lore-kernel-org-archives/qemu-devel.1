Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186D1C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72B920776
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72B920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1I9-0001zI-3r
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pavel.Dovgaluk@gmail.com>)
 id 1jc1HK-0000Xb-Ga
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:35:34 -0400
Received: from mail.ispras.ru ([83.149.199.45]:38440)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jc1HG-0007ck-AK
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:35:34 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 9E375CD46A;
 Fri, 22 May 2020 09:35:27 +0300 (MSK)
Subject: [PATCH v2] replay: synchronize on every virtual timer callback
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 22 May 2020 09:35:27 +0300
Message-ID: <159012932716.27256.8854065545365559921.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:35:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FROM=0.001, NML_ADSP_CUSTOM_MED=0.9,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, pavel.dovgaluk@ispras.ru,
 dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes virtual timer callbacks depend on order
of virtual timer processing and warping of virtual clock.
Therefore every callback should be logged to make replay deterministic.
This patch creates a checkpoint before every virtual timer callback.
With these checkpoints virtual timers processing and clock warping
events order is completely deterministic.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Acked-by: Alex Bennée <alex.bennee@linaro.org>

--

v2:
  - remove mutex lock/unlock for virtual clock checkpoint since it is
    not process any asynchronous events (commit ca9759c2a92f528f256fef0e3922416f7bb47bf9)
  - bump record/replay log file version
---
 0 files changed

diff --git a/replay/replay.c b/replay/replay.c
index 706c7b4f4b..53edad1377 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02009
+#define REPLAY_VERSION              0xe0200a
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index b6575a2cd5..f62b4feecd 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -501,7 +501,6 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     bool progress = false;
     QEMUTimerCB *cb;
     void *opaque;
-    bool need_replay_checkpoint = false;
 
     if (!atomic_read(&timer_list->active_timers)) {
         return false;
@@ -517,16 +516,6 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
         break;
     default:
     case QEMU_CLOCK_VIRTUAL:
-        if (replay_mode != REPLAY_MODE_NONE) {
-            /* Checkpoint for virtual clock is redundant in cases where
-             * it's being triggered with only non-EXTERNAL timers, because
-             * these timers don't change guest state directly.
-             * Since it has conditional dependence on specific timers, it is
-             * subject to race conditions and requires special handling.
-             * See below.
-             */
-            need_replay_checkpoint = true;
-        }
         break;
     case QEMU_CLOCK_HOST:
         if (!replay_checkpoint(CHECKPOINT_CLOCK_HOST)) {
@@ -559,19 +548,16 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
              */
             break;
         }
-        if (need_replay_checkpoint
-                && !(ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)) {
-            /* once we got here, checkpoint clock only once */
-            need_replay_checkpoint = false;
+        /* Checkpoint for virtual clock is redundant in cases where
+         * it's being triggered with only non-EXTERNAL timers, because
+         * these timers don't change guest state directly.
+         */
+        if (replay_mode != REPLAY_MODE_NONE
+            && timer_list->clock->type == QEMU_CLOCK_VIRTUAL
+            && !(ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)
+            && !replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
             qemu_mutex_unlock(&timer_list->active_timers_lock);
-            if (!replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
-                goto out;
-            }
-            qemu_mutex_lock(&timer_list->active_timers_lock);
-            /* The lock was released; start over again in case the list was
-             * modified.
-             */
-            continue;
+            goto out;
         }
 
         /* remove timer from the list before calling the callback */


