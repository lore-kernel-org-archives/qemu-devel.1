Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF83C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24595206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24595206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijKLR-0005l6-Ta
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 04:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJf-00044a-2t
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJd-00048e-1d
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:47:54 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50888)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKJc-0003zj-Ib
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:47:52 -0500
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 2BC6354006B;
 Mon, 23 Dec 2019 12:47:47 +0300 (MSK)
Subject: [for-5.0 PATCH 06/11] replay: introduce breakpoint at the specified
 step
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 23 Dec 2019 12:47:46 +0300
Message-ID: <157709446688.12933.7598131292472178158.stgit@pasha-Precision-3630-Tower>
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

This patch introduces replay_break, replay_delete_break
qmp and hmp commands.
These commands allow stopping at the specified instruction.
It may be useful for debugging when there are some known
events that should be investigated.
replay_break command has one argument - number of instructions
executed since the start of the replay.
replay_delete_break removes previously set breakpoint.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>

--

v2:
 - renamed replay_break qmp command into replay-break
   (suggested by Eric Blake)
v7:
 - introduces replay_delete_break command
v9:
 - changed 'step' parameter name to 'icount'
 - moved json stuff to replay.json and updated the description
   (suggested by Markus Armbruster)
v10:
 - updated descriptions (suggested by Markus Armbruster)
v11:
 - fixed replay_break rearm bug
---
 hmp-commands.hx           |   34 ++++++++++++++++++
 include/monitor/hmp.h     |    2 +
 qapi/replay.json          |   36 +++++++++++++++++++
 replay/replay-debugging.c |   86 +++++++++++++++++++++++++++++++++++++++++++++
 replay/replay-internal.h  |    4 ++
 replay/replay.c           |   17 +++++++++
 6 files changed, 179 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index cfcc044ce4..3704294da8 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1930,6 +1930,40 @@ ETEXI
 STEXI
 @item qom-set @var{path} @var{property} @var{value}
 Set QOM property @var{property} of object at location @var{path} to value @var{value}
+ETEXI
+
+    {
+        .name       = "replay_break",
+        .args_type  = "icount:i",
+        .params     = "icount",
+        .help       = "set breakpoint at the specified instruction count",
+        .cmd        = hmp_replay_break,
+    },
+
+STEXI
+@item replay_break @var{icount}
+@findex replay_break
+Set replay breakpoint at instruction count @var{icount}.
+Execution stops when the specified instruction is reached.
+There can be at most one breakpoint. When breakpoint is set, any prior
+one is removed.  The breakpoint may be set only in replay mode and only
+"in the future", i.e. at instruction counts greater than the current one.
+The current instruction count can be observed with 'info replay'.
+ETEXI
+
+    {
+        .name       = "replay_delete_break",
+        .args_type  = "",
+        .params     = "",
+        .help       = "removes replay breakpoint",
+        .cmd        = hmp_replay_delete_break,
+    },
+
+STEXI
+@item replay_delete_break
+@findex replay_delete_break
+Remove replay breakpoint which was previously set with replay_break.
+The command is ignored when there are no replay breakpoints.
 ETEXI
 
     {
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 783784cf10..0fd477aa13 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -154,5 +154,7 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
+void hmp_replay_break(Monitor *mon, const QDict *qdict);
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/replay.json b/qapi/replay.json
index 67f2d1f859..e3266ef3a9 100644
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
+# Since: 5.0
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
+# Since: 5.0
+#
+# Example:
+#
+# -> { "execute": "replay-delete-break" }
+#
+##
+{ 'command': 'replay-delete-break' }
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 8cf15ebc11..166ba10d2c 100644
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
@@ -41,3 +44,86 @@ ReplayInfo *qmp_query_replay(Error **errp)
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
+        error_free(err);
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
+        error_free(err);
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
index 9ec6ce9996..86b3e943c2 100644
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


