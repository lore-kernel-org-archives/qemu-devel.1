Received: from eggs.gnu.org ([2001:4830:134:3::10]:34017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEaO-00028g-7N
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEaK-0002m3-HC
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:35 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44114)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEaI-0002gv-Ic
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:31 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 10 Oct 2018 16:34:31 +0300
Message-ID: <20181010133431.24538.53838.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 10/19] replay: introduce breakpoint at the
 specified step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, war2jordan@live.com, pavel.dovgaluk@ispras.ru, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.comdovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

This patch introduces replay_break, replay_delete_break
qmp and hmp commands.
These commands allow stopping at the specified instruction.
It may be useful for debugging when there are some known
events that should be investigated.
replay_break command has one argument - number of instructions
executed since the start of the replay.
replay_delete_break removes previously set breakpoint.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2:
 - renamed replay_break qmp command into replay-break
   (suggested by Eric Blake)
v7:
 - introduces replay_delete_break command
---
 hmp-commands.hx           |   29 ++++++++++++++++
 hmp.h                     |    2 +
 qapi/misc.json            |   31 +++++++++++++++++
 replay/replay-debugging.c |   84 +++++++++++++++++++++++++++++++++++++++++++++
 replay/replay-internal.h  |    4 ++
 replay/replay.c           |   17 +++++++++
 6 files changed, 167 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index db0c681..615d725 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1888,6 +1888,35 @@ Set QOM property @var{property} of object at location @var{path} to value @var{v
 ETEXI
 
     {
+        .name       = "replay_break",
+        .args_type  = "step:i",
+        .params     = "step",
+        .help       = "sets breakpoint on the specified step of the replay",
+        .cmd        = hmp_replay_break,
+    },
+
+STEXI
+@item replay_break @var{step}
+@findex replay_break
+Set breakpoint on the specified step of the replay.
+Execution stops when the specified step is reached.
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
+Removes replay breakpoint which was previously set with replay_break.
+ETEXI
+
+    {
         .name       = "info",
         .args_type  = "item:s?",
         .params     = "[subcommand]",
diff --git a/hmp.h b/hmp.h
index d792149..c9b9b4f 100644
--- a/hmp.h
+++ b/hmp.h
@@ -149,5 +149,7 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
+void hmp_replay_break(Monitor *mon, const QDict *qdict);
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/misc.json b/qapi/misc.json
index 79f6b21..e00a9b0 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3140,6 +3140,37 @@
   'returns': 'ReplayInfo' }
 
 ##
+# @replay-break:
+#
+# Set breakpoint on the specified step of the replay.
+# Execution stops when the specified step is reached.
+#
+# @step: execution step to stop at
+#
+# Since: 3.1
+#
+# Example:
+#
+# -> { "execute": "replay-break", "data": { "step": 220414 } }
+#
+##
+{ 'command': 'replay-break', 'data': { 'step': 'int' } }
+
+##
+# @replay-delete-break:
+#
+# Removes replay breakpoint.
+#
+# Since: 3.1
+#
+# Example:
+#
+# -> { "execute": "replay-delete-break" }
+#
+##
+{ 'command': 'replay-delete-break' }
+
+##
 # @xen-load-devices-state:
 #
 # Load the state of all devices from file. The RAM and the block devices
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 1d7e75d..207d6e0 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -16,6 +16,8 @@
 #include "hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/qmp/qdict.h"
+#include "qemu/timer.h"
 
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
@@ -40,3 +42,85 @@ ReplayInfo *qmp_query_replay(Error **errp)
     retval->step = replay_get_current_step();
     return retval;
 }
+
+static void replay_break(uint64_t step, QEMUTimerCB callback, void *opaque)
+{
+    assert(replay_mode == REPLAY_MODE_PLAY);
+    assert(replay_mutex_locked());
+    assert(replay_break_step >= replay_get_current_step());
+    assert(callback);
+
+    replay_break_step = step;
+
+    if (replay_break_timer) {
+        timer_del(replay_break_timer);
+    } else {
+        replay_break_timer = timer_new_ns(QEMU_CLOCK_REALTIME, callback, opaque);
+    }
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
+    replay_break_step = -1ULL;
+}
+
+static void replay_stop_vm(void *opaque)
+{
+    vm_stop(RUN_STATE_PAUSED);
+    replay_delete_break();
+}
+
+void qmp_replay_break(int64_t step, Error **errp)
+{
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        if (step >= replay_get_current_step()) {
+            replay_break(step, replay_stop_vm, NULL);
+        } else {
+            error_setg(errp, "cannot set breakpoint at the step in the past");
+        }
+    } else {
+        error_setg(errp, "setting the breakpoint is allowed only in play mode");
+    }
+}
+
+void hmp_replay_break(Monitor *mon, const QDict *qdict)
+{
+    int64_t step = qdict_get_try_int(qdict, "step", -1LL);
+    Error *err = NULL;
+
+    qmp_replay_break(step, &err);
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
index af6f4d5..94b7e9b 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -91,6 +91,10 @@ extern ReplayState replay_state;
 
 /* File for replay writing */
 extern FILE *replay_file;
+/* Step of the replay breakpoint */
+extern uint64_t replay_break_step;
+/* Timer for the replay breakpoint callback */
+extern QEMUTimer *replay_break_timer;
 
 void replay_put_byte(uint8_t byte);
 void replay_put_event(uint8_t event);
diff --git a/replay/replay.c b/replay/replay.c
index e6b1045..c6d5de9 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -34,6 +34,10 @@ static char *replay_filename;
 ReplayState replay_state;
 static GSList *replay_blockers;
 
+/* Replay breakpoints */
+uint64_t replay_break_step = -1ULL;
+QEMUTimer *replay_break_timer;
+
 bool replay_next_event_is(int event)
 {
     bool res = false;
@@ -73,6 +77,13 @@ int replay_get_instructions(void)
     replay_mutex_lock();
     if (replay_next_event_is(EVENT_INSTRUCTION)) {
         res = replay_state.instructions_count;
+        if (replay_break_step != -1LL) {
+            uint64_t current = replay_get_current_step();
+            assert(replay_break_step >= current);
+            if (current + res > replay_break_step) {
+                res = replay_break_step - current;
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
+            if (replay_break_step == replay_state.current_step) {
+                /* Cannot make callback directly from the vCPU thread */
+                timer_mod_ns(replay_break_timer,
+                    qemu_clock_get_ns(QEMU_CLOCK_REALTIME));
+            }
         }
     }
 }
