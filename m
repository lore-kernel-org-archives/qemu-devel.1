Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F13C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD7D2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAZU+2Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD7D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3Dp-0003E8-OQ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo30C-00020l-3f
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo30A-0001VN-4p
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMCRg1JOSToToM0qV8mrZvUYcfN0PGV9WdI3UL15Th4=;
 b=XAZU+2PkwbhYVPp5AE+7/cmVQwR6mFq+1UhTpK/QuGPKCzwc2brQzNvQFjwo/aKXPgvaH8
 K6mabTZ7FaXqkNzKMcMcobXq+pLWfnS+kFGFB78L+WSxHoycRDq+DnlViuddq+BKUTa0jQ
 CBSKCQ7pxsoUcVYA9ug/CaRY8JTNPII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-c0r1a9EvPTyX5apHd52dog-1; Wed, 24 Jun 2020 06:51:00 -0400
X-MC-Unique: c0r1a9EvPTyX5apHd52dog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DE6F18A8220;
 Wed, 24 Jun 2020 10:50:59 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C21C71DC;
 Wed, 24 Jun 2020 10:50:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/31] replay: synchronize on every virtual timer callback
Date: Wed, 24 Jun 2020 06:50:24 -0400
Message-Id: <20200624105048.375353-7-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

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
Message-Id: <159012932716.27256.8854065545365559921.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay.c   |  2 +-
 util/qemu-timer.c | 32 +++++++++-----------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/replay/replay.c b/replay/replay.c
index 7d93746c73..83ed9e0e24 100644
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
-- 
2.26.2



