Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B50DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C587720B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C587720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhPh-0005Qt-QJ
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKhDb-0001Fq-0q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:16:26 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47586)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKhDY-0006Rd-L3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:16:22 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 9BFC240A2071;
 Tue, 22 Sep 2020 12:16:18 +0000 (UTC)
Subject: [PATCH v5 07/15] replay: introduce breakpoint at the specified step
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 22 Sep 2020 15:16:18 +0300
Message-ID: <160077697827.10249.16059982259705480408.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
References: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 08:15:38
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

This patch introduces replay_break, replay_delete_break
qmp and hmp commands.
These commands allow stopping at the specified instruction.
It may be useful for debugging when there are some known
events that should be investigated.
replay_break command has one argument - number of instructions
executed since the start of the replay.
replay_delete_break removes previously set breakpoint.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>

--

v4 changes:
 - removed useless error_free call
---
 hmp-commands.hx           |   32 +++++++++++++++++
 include/monitor/hmp.h     |    2 +
 qapi/replay.json          |   36 +++++++++++++++++++
 replay/replay-debugging.c |   84 +++++++++++++++++++++++++++++++++++++++++++++
 replay/replay-internal.h  |    4 ++
 replay/replay.c           |   17 +++++++++
 6 files changed, 175 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 60f395c276..e8ce385879 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1819,6 +1819,38 @@ SRST
   Set QOM property *property* of object at location *path* to value *value*
 ERST
 
+    {
+        .name       = "replay_break",
+        .args_type  = "icount:i",
+        .params     = "icount",
+        .help       = "set breakpoint at the specified instruction count",
+        .cmd        = hmp_replay_break,
+    },
+
+SRST
+``replay_break`` *icount*
+  Set replay breakpoint at instruction count *icount*.
+  Execution stops when the specified instruction is reached.
+  There can be at most one breakpoint. When breakpoint is set, any prior
+  one is removed.  The breakpoint may be set only in replay mode and only
+  "in the future", i.e. at instruction counts greater than the current one.
+  The current instruction count can be observed with ``info replay``.
+ERST
+
+    {
+        .name       = "replay_delete_break",
+        .args_type  = "",
+        .params     = "",
+        .help       = "remove replay breakpoint",
+        .cmd        = hmp_replay_delete_break,
+    },
+
+SRST
+``replay_delete_break``
+  Remove replay breakpoint which was previously set with ``replay_break``.
+  The command is ignored when there are no replay breakpoints.
+ERST
+
     {
         .name       = "info",
         .args_type  = "item:s?",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index a790589b9e..21849bdda5 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -131,5 +131,7 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
+void hmp_replay_break(Monitor *mon, const QDict *qdict);
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/replay.json b/qapi/replay.json
index e6b3f6001d..173ba76107 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -63,3 +63,39 @@
 ##
 { 'command': 'query-replay',
   'returns': 'ReplayInfo' }
+
+##
+# @replay-break:
+#
+# Set replay breakpoint at instruction count @icount.
+# Execution stops when the specified instruction is reached.
+# There can be at most one breakpoint. When breakpoint is set, any prior
+# one is removed.  The breakpoint may be set only in replay mode and only
+# "in the future", i.e. at instruction counts greater than the current one.
+# The current instruction count can be observed with @query-replay.
+#
+# @icount: instruction count to stop at
+#
+# Since: 5.2
+#
+# Example:
+#
+# -> { "execute": "replay-break", "data": { "icount": 220414 } }
+#
+##
+{ 'command': 'replay-break', 'data': { 'icount': 'int' } }
+
+##
+# @replay-delete-break:
+#
+# Remove replay breakpoint which was set with @replay-break.
+# The command is ignored when there are no replay breakpoints.
+#
+# Since: 5.2
+#
+# Example:
+#
+# -> { "execute": "replay-delete-break" }
+#
+##
+{ 'command': 'replay-delete-break' }
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 51a6de4e81..3dc23b84fc 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -12,10 +12,13 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "sysemu/replay.h"
+#include "sysemu/runstate.h"
 #include "replay-internal.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-replay.h"
+#include "qapi/qmp/qdict.h"
+#include "qemu/timer.h"
 
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
@@ -41,3 +44,84 @@ ReplayInfo *qmp_query_replay(Error **errp)
     retval->icount = replay_get_current_icount();
     return retval;
 }
+
+static void replay_break(uint64_t icount, QEMUTimerCB callback, void *opaque)
+{
+    assert(replay_mode == REPLAY_MODE_PLAY);
+    assert(replay_mutex_locked());
+    assert(replay_break_icount >= replay_get_current_icount());
+    assert(callback);
+
+    replay_break_icount = icount;
+
+    if (replay_break_timer) {
+        timer_del(replay_break_timer);
+    }
+    replay_break_timer = timer_new_ns(QEMU_CLOCK_REALTIME,
+                                      callback, opaque);
+}
+
+static void replay_delete_break(void)
+{
+    assert(replay_mode == REPLAY_MODE_PLAY);
+    assert(replay_mutex_locked());
+
+    if (replay_break_timer) {
+        timer_del(replay_break_timer);
+        timer_free(replay_break_timer);
+        replay_break_timer = NULL;
+    }
+    replay_break_icount = -1ULL;
+}
+
+static void replay_stop_vm(void *opaque)
+{
+    vm_stop(RUN_STATE_PAUSED);
+    replay_delete_break();
+}
+
+void qmp_replay_break(int64_t icount, Error **errp)
+{
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        if (icount >= replay_get_current_icount()) {
+            replay_break(icount, replay_stop_vm, NULL);
+        } else {
+            error_setg(errp,
+                "cannot set breakpoint at the instruction in the past");
+        }
+    } else {
+        error_setg(errp, "setting the breakpoint is allowed only in play mode");
+    }
+}
+
+void hmp_replay_break(Monitor *mon, const QDict *qdict)
+{
+    int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
+    Error *err = NULL;
+
+    qmp_replay_break(icount, &err);
+    if (err) {
+        error_report_err(err);
+        return;
+    }
+}
+
+void qmp_replay_delete_break(Error **errp)
+{
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        replay_delete_break();
+    } else {
+        error_setg(errp, "replay breakpoints are allowed only in play mode");
+    }
+}
+
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    qmp_replay_delete_break(&err);
+    if (err) {
+        error_report_err(err);
+        return;
+    }
+}
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 33ac551e78..2f6145ec7c 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -94,6 +94,10 @@ extern ReplayState replay_state;
 
 /* File for replay writing */
 extern FILE *replay_file;
+/* Instruction count of the replay breakpoint */
+extern uint64_t replay_break_icount;
+/* Timer for the replay breakpoint callback */
+extern QEMUTimer *replay_break_timer;
 
 void replay_put_byte(uint8_t byte);
 void replay_put_event(uint8_t event);
diff --git a/replay/replay.c b/replay/replay.c
index 42e82f7bc7..220886e32e 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -34,6 +34,10 @@ static char *replay_filename;
 ReplayState replay_state;
 static GSList *replay_blockers;
 
+/* Replay breakpoints */
+uint64_t replay_break_icount = -1ULL;
+QEMUTimer *replay_break_timer;
+
 bool replay_next_event_is(int event)
 {
     bool res = false;
@@ -73,6 +77,13 @@ int replay_get_instructions(void)
     replay_mutex_lock();
     if (replay_next_event_is(EVENT_INSTRUCTION)) {
         res = replay_state.instruction_count;
+        if (replay_break_icount != -1LL) {
+            uint64_t current = replay_get_current_icount();
+            assert(replay_break_icount >= current);
+            if (current + res > replay_break_icount) {
+                res = replay_break_icount - current;
+            }
+        }
     }
     replay_mutex_unlock();
     return res;
@@ -99,6 +110,12 @@ void replay_account_executed_instructions(void)
                    will be read from the log. */
                 qemu_notify_event();
             }
+            /* Execution reached the break step */
+            if (replay_break_icount == replay_state.current_icount) {
+                /* Cannot make callback directly from the vCPU thread */
+                timer_mod_ns(replay_break_timer,
+                    qemu_clock_get_ns(QEMU_CLOCK_REALTIME));
+            }
         }
     }
 }


