Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B1C282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E1B204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E1B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIX9u-0000NX-5L
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 07:30:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0R-0000cc-Rk
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0Q-0002AX-0H
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:03 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47134)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0O-00028a-0G
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:01 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1DF2E5400A9;
	Mon, 22 Apr 2019 14:20:59 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 14:20:58 +0300
Message-ID:
 <155593205889.21079.14799791777208991110.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.1 14/24] replay: refine replay-time module
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
Message-ID: <20190422112058.E_LUcsxnjP51k6ZWjhsti1I8LIFwBm9vph6wjwvLj0M@z>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch removes refactoring artifacts from the replay/replay-time.c

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-time.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/replay/replay-time.c b/replay/replay-time.c
index 0df1693337..60f47b73a7 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -15,18 +15,19 @@
 #include "replay-internal.h"
 #include "qemu/error-report.h"
 
-int64_t replay_save_clock(ReplayClockKind kind, int64_t clock, int64_t raw_icount)
+int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
+                          int64_t raw_icount)
 {
-    if (replay_file) {
-        g_assert(replay_mutex_locked());
+    g_assert(replay_file);
+    g_assert(replay_mutex_locked());
 
-        /* Due to the caller's locking requirements we get the icount from it
-         * instead of using replay_save_instructions().
-         */
-        replay_advance_current_step(raw_icount);
-        replay_put_event(EVENT_CLOCK + kind);
-        replay_put_qword(clock);
-    }
+    /*
+     * Due to the caller's locking requirements we get the icount from it
+     * instead of using replay_save_instructions().
+     */
+    replay_advance_current_step(raw_icount);
+    replay_put_event(EVENT_CLOCK + kind);
+    replay_put_qword(clock);
 
     return clock;
 }
@@ -48,20 +49,15 @@ void replay_read_next_clock(ReplayClockKind kind)
 /*! Reads next clock event from the input. */
 int64_t replay_read_clock(ReplayClockKind kind)
 {
+    int64_t ret;
     g_assert(replay_file && replay_mutex_locked());
 
     replay_account_executed_instructions();
 
-    if (replay_file) {
-        int64_t ret;
-        if (replay_next_event_is(EVENT_CLOCK + kind)) {
-            replay_read_next_clock(kind);
-        }
-        ret = replay_state.cached_clock[kind];
-
-        return ret;
+    if (replay_next_event_is(EVENT_CLOCK + kind)) {
+        replay_read_next_clock(kind);
     }
+    ret = replay_state.cached_clock[kind];
 
-    error_report("REPLAY INTERNAL ERROR %d", __LINE__);
-    exit(1);
+    return ret;
 }


