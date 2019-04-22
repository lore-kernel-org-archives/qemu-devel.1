Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5170C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92738204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92738204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35865 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIX7q-0006vj-LB
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 07:28:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0g-0000p3-Ja
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0f-0002J8-Bd
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:18 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47238)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0f-0002Iu-0E
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:17 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1DDB05400A9;
	Mon, 22 Apr 2019 14:21:16 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 14:21:15 +0300
Message-ID:
 <155593207590.21079.12680742177860870493.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.1 17/24] gdbstub: add reverse continue
 support in replay mode
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
Message-ID: <20190422112115.J8l2XAAi9kVS4W8ghuWYG6WUC7xUY7u_yYfAVjrWKW8@z>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds support of the reverse continue operation for gdbstub.
Reverse continue finds the last breakpoint that would happen in normal
execution from the beginning to the current moment.
Implementation of the reverse continue replays the execution twice:
to find the breakpoints that were hit and to seek to the last breakpoint.
Reverse continue loads the previous snapshot and tries to find the breakpoint
since that moment. If there are no such breakpoints, it proceeds to
the earlier snapshot, and so on. When no breakpoints or watchpoints were
hit at all, execution stops at the beginning of the replay log.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 cpus.c                    |    5 +++
 exec.c                    |    1 +
 gdbstub.c                 |   10 ++++++
 include/sysemu/replay.h   |    8 +++++
 replay/replay-debugging.c |   71 +++++++++++++++++++++++++++++++++++++++++++++
 stubs/replay.c            |    5 +++
 6 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 44d0b23435..ba4849861d 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1110,6 +1110,11 @@ static void cpu_handle_guest_debug(CPUState *cpu)
         cpu->stopped = true;
     } else {
         if (!cpu->singlestep_enabled) {
+            /*
+             * Report about the breakpoint and
+             * make a single step to skip it
+             */
+            replay_breakpoint();
             cpu_single_step(cpu, SSTEP_ENABLE);
         } else {
             cpu_single_step(cpu, 0);
diff --git a/exec.c b/exec.c
index 4f0d24214e..3009cfcdc2 100644
--- a/exec.c
+++ b/exec.c
@@ -2777,6 +2777,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                  * Don't process the watchpoints when we are
                  * in a reverse debugging operation.
                  */
+                replay_breakpoint();
                 return;
             }
             if (flags == BP_MEM_READ) {
diff --git a/gdbstub.c b/gdbstub.c
index e49e0f6c65..3b6cbcb576 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1454,6 +1454,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
                     put_packet(s, "E14");
                     break;
                 }
+            case 'c':
+                if (replay_reverse_continue()) {
+                    gdb_continue(s);
+                    return RS_IDLE;
+                } else {
+                    put_packet(s, "E14");
+                    break;
+                }
             default:
                 goto unknown_command;
             }
@@ -1764,7 +1772,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             pstrcat(buf, sizeof(buf), ";multiprocess+");
 
             if (replay_mode == REPLAY_MODE_PLAY) {
-                pstrcat(buf, sizeof(buf), ";ReverseStep+");
+                pstrcat(buf, sizeof(buf), ";ReverseStep+;ReverseContinue+");
             }
 
             put_packet(s, buf);
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 533003f2b0..1d18c9b6ea 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -79,11 +79,19 @@ const char *replay_get_filename(void);
  * Returns true on success.
  */
 bool replay_reverse_step(void);
+/*
+ * Start searching the last breakpoint/watchpoint.
+ * Used by gdbstub for backwards debugging.
+ * Returns true if the process successfully started.
+ */
+bool replay_reverse_continue(void);
 /*
  * Returns true if replay module is processing
  * reverse_continue or reverse_step request
  */
 bool replay_running_debug(void);
+/* Called in reverse debugging mode to collect breakpoint information */
+void replay_breakpoint(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 3d94859b8f..abb5fe687f 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -22,6 +22,8 @@
 #include "migration/snapshot.h"
 
 static bool replay_is_debugging;
+static int64_t replay_last_breakpoint;
+static int64_t replay_last_snapshot;
 
 bool replay_running_debug(void)
 {
@@ -252,3 +254,72 @@ bool replay_reverse_step(void)
 
     return false;
 }
+
+static void replay_continue_end(void)
+{
+    replay_is_debugging = false;
+    vm_stop(RUN_STATE_DEBUG);
+    replay_delete_break();
+}
+
+static void replay_continue_stop(void *opaque)
+{
+    Error *err = NULL;
+    if (replay_last_breakpoint != -1LL) {
+        replay_seek(replay_last_breakpoint, replay_stop_vm_debug, &err);
+        if (err) {
+            error_free(err);
+            replay_continue_end();
+        }
+        return;
+    }
+    /*
+     * No breakpoints since the last snapshot.
+     * Find previous snapshot and try again.
+     */
+    if (replay_last_snapshot != 0) {
+        replay_seek(replay_last_snapshot - 1, replay_continue_stop, &err);
+        if (err) {
+            error_free(err);
+            replay_continue_end();
+        }
+        replay_last_snapshot = replay_get_current_step();
+        return;
+    } else {
+        /* Seek to the very first step */
+        replay_seek(0, replay_stop_vm_debug, &err);
+        if (err) {
+            error_free(err);
+            replay_continue_end();
+        }
+        return;
+    }
+    replay_continue_end();
+}
+
+bool replay_reverse_continue(void)
+{
+    Error *err = NULL;
+
+    assert(replay_mode == REPLAY_MODE_PLAY);
+
+    if (replay_get_current_step() != 0) {
+        replay_seek(replay_get_current_step() - 1, replay_continue_stop, &err);
+        if (err) {
+            error_free(err);
+            return false;
+        }
+        replay_last_breakpoint = -1LL;
+        replay_is_debugging = true;
+        replay_last_snapshot = replay_get_current_step();
+        return true;
+    }
+
+    return false;
+}
+
+void replay_breakpoint(void)
+{
+    assert(replay_mode == REPLAY_MODE_PLAY);
+    replay_last_breakpoint = replay_get_current_step();
+}
diff --git a/stubs/replay.c b/stubs/replay.c
index 521552fa83..ee649726f4 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -85,3 +85,8 @@ bool replay_reverse_step(void)
 {
     return false;
 }
+
+bool replay_reverse_continue(void)
+{
+    return false;
+}


