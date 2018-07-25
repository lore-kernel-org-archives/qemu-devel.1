Received: from eggs.gnu.org ([2001:4830:134:3::10]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIgC-0001AD-7L
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIg9-0002mm-6Z
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:14:08 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36516)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIg8-0002lr-Oj
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:14:05 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:14:05 +0300
Message-ID: <20180725121405.12867.77390.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 09/24] replay: introduce breakpoint at the
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch introduces replay_break qmp and hmp commands.
These commands allow stopping at the specified instruction.
It may be useful for debugging when there are some known
events that should be investigated.
The commands have one argument - number of instructions
executed since the start of the replay.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2:
 - renamed replay_break qmp command into replay-break
   (suggested by Eric Blake)
---
 hmp-commands.hx           |   15 ++++++++++++
 hmp.h                     |    1 +
 include/sysemu/replay.h   |    3 ++
 qapi/misc.json            |   17 ++++++++++++++
 replay/replay-debugging.c |   55 +++++++++++++++++++++++++++++++++++++++++++++
 replay/replay-internal.h  |    4 +++
 replay/replay.c           |   17 ++++++++++++++
 7 files changed, 112 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 91dfe51..ec58ca4 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1874,6 +1874,21 @@ Set QOM property @var{property} of object at location @var{path} to value @var{v
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
         .name       = "info",
         .args_type  = "item:s?",
         .params     = "[subcommand]",
diff --git a/hmp.h b/hmp.h
index 9d12c63..3eeea7d 100644
--- a/hmp.h
+++ b/hmp.h
@@ -148,5 +148,6 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
+void hmp_replay_break(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3ced6bc..98d709c 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -71,6 +71,9 @@ void replay_start(void);
 void replay_finish(void);
 /*! Adds replay blocker with the specified error description */
 void replay_add_blocker(Error *reason);
+/*! Sets breakpoint at the specified step.
+    If step = -1LL the existing breakpoint is removed. */
+void replay_break(int64_t step, QEMUTimerCB callback, void *opaque);
 
 /* Processing the instructions */
 
diff --git a/qapi/misc.json b/qapi/misc.json
index e246ce3..4fcd211 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3135,6 +3135,23 @@
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
 # @xen-load-devices-state:
 #
 # Load the state of all devices from file. The RAM and the block devices
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 03e7db8..819017e 100644
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
@@ -39,3 +41,56 @@ ReplayInfo *qmp_query_replay(Error **errp)
     retval->step = replay_get_current_step();
     return retval;
 }
+
+void replay_break(int64_t step, QEMUTimerCB callback, void *opaque)
+{
+    assert(replay_mode == REPLAY_MODE_PLAY);
+    assert(replay_mutex_locked());
+
+    replay_break_step = step;
+    if (replay_break_timer) {
+        timer_del(replay_break_timer);
+        timer_free(replay_break_timer);
+        replay_break_timer = NULL;
+    }
+
+    if (replay_break_step == -1LL) {
+        return;
+    }
+    assert(replay_break_step >= replay_get_current_step());
+    assert(callback);
+
+    replay_break_timer = timer_new_ns(QEMU_CLOCK_REALTIME, callback, opaque);
+}
+
+static void replay_stop_vm(void *opaque)
+{
+    vm_stop(RUN_STATE_PAUSED);
+    replay_break(-1LL, NULL, NULL);
+}
+
+void qmp_replay_break(int64_t step, Error **errp)
+{
+    if (replay_mode ==  REPLAY_MODE_PLAY) {
+        if (step >= replay_get_current_step()) {
+            replay_break(step, replay_stop_vm, NULL);
+        } else {
+            error_setg(errp, "cannot set break at the step in the past");
+        }
+    } else {
+        error_setg(errp, "setting the break is allowed only in play mode");
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
+        monitor_printf(mon, "replay_break error: %s\n", error_get_pretty(err));
+        error_free(err);
+        return;
+    }
+}
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index ef82b5e..34d19eb 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -93,6 +93,10 @@ extern ReplayState replay_state;
 extern FILE *replay_file;
 /*! Name of replay file  */
 extern char *replay_filename;
+/*! Step of the replay breakpoint */
+extern int64_t replay_break_step;
+/*! Timer for the replay breakpoint callback */
+extern QEMUTimer *replay_break_timer;
 
 void replay_put_byte(uint8_t byte);
 void replay_put_event(uint8_t event);
diff --git a/replay/replay.c b/replay/replay.c
index 8b70d7d..dcce902 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -33,6 +33,10 @@ char *replay_filename;
 ReplayState replay_state;
 static GSList *replay_blockers;
 
+/* Replay breakpoints */
+int64_t replay_break_step = -1LL;
+QEMUTimer *replay_break_timer;
+
 bool replay_next_event_is(int event)
 {
     bool res = false;
@@ -72,6 +76,13 @@ int replay_get_instructions(void)
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
@@ -98,6 +109,12 @@ void replay_account_executed_instructions(void)
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
