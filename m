Received: from eggs.gnu.org ([209.51.188.92]:50008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCD7-0005Hz-5E
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCD4-0002ol-KX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:16:53 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52274)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCD4-0002oY-8I
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:16:50 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 31 Jan 2019 16:16:53 +0300
Message-ID: <20190131131652.23264.48851.stgit@pasha-VirtualBox>
In-Reply-To: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
References: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v11 16/25] gdbstub: add reverse step support in
 replay mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

GDB remote protocol supports two reverse debugging commands:
reverse step and reverse continue.
This patch adds support of the first one to the gdbstub.
Reverse step is intended to step one instruction in the backwards
direction. This is not possible in regular execution.
But replayed execution is deterministic, therefore we can load one of
the prior snapshots and proceed to the desired step. It is equivalent
to stepping one instruction back.
There should be at least one snapshot preceding the debugged part of
the replay log.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 accel/tcg/translator.c    |    1 +
 cpus.c                    |   14 +++++++++++---
 exec.c                    |    7 +++++++
 gdbstub.c                 |   44 +++++++++++++++++++++++++++++++++++++++++---
 include/sysemu/replay.h   |   11 +++++++++++
 replay/replay-debugging.c |   33 +++++++++++++++++++++++++++++++++
 stubs/replay.c            |    5 +++++
 7 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index afd0a49..33a543e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -17,6 +17,7 @@
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "sysemu/replay.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
diff --git a/cpus.c b/cpus.c
index aa33fb1..013341c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1104,9 +1104,17 @@ static bool cpu_can_run(CPUState *cpu)
 
 static void cpu_handle_guest_debug(CPUState *cpu)
 {
-    gdb_set_stop_cpu(cpu);
-    qemu_system_debug_request();
-    cpu->stopped = true;
+    if (!replay_running_debug()) {
+        gdb_set_stop_cpu(cpu);
+        qemu_system_debug_request();
+        cpu->stopped = true;
+    } else {
+        if (!cpu->singlestep_enabled) {
+            cpu_single_step(cpu, SSTEP_ENABLE);
+        } else {
+            cpu_single_step(cpu, 0);
+        }
+    }
 }
 
 #ifdef CONFIG_LINUX
diff --git a/exec.c b/exec.c
index da3e635..b00eff7 100644
--- a/exec.c
+++ b/exec.c
@@ -2740,6 +2740,13 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (cpu_watchpoint_address_matches(wp, vaddr, len)
             && (wp->flags & flags)) {
+            if (replay_running_debug()) {
+                /*
+                 * Don't process the watchpoints when we are
+                 * in a reverse debugging operation.
+                 */
+                return;
+            }
             if (flags == BP_MEM_READ) {
                 wp->flags |= BP_WATCHPOINT_HIT_READ;
             } else {
diff --git a/gdbstub.c b/gdbstub.c
index 3129b5c..d9bf386 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -39,6 +39,7 @@
 #include "sysemu/kvm.h"
 #include "exec/semihost.h"
 #include "exec/exec-all.h"
+#include "sysemu/replay.h"
 
 #ifdef CONFIG_USER_ONLY
 #define GDB_ATTACHED "0"
@@ -344,6 +345,20 @@ typedef struct GDBState {
  */
 static int sstep_flags = SSTEP_ENABLE|SSTEP_NOIRQ|SSTEP_NOTIMER;
 
+/* Retrieves flags for single step mode. */
+static int get_sstep_flags(void)
+{
+    /*
+     * In replay mode all events written into the log should be replayed.
+     * That is why NOIRQ flag is removed in this mode.
+     */
+    if (replay_mode != REPLAY_MODE_NONE) {
+        return SSTEP_ENABLE;
+    } else {
+        return sstep_flags;
+    }
+}
+
 static GDBState *gdbserver_state;
 
 bool gdb_has_xml;
@@ -434,7 +449,7 @@ static int gdb_continue_partial(GDBState *s, char *newstates)
     CPU_FOREACH(cpu) {
         if (newstates[cpu->cpu_index] == 's') {
             trace_gdbstub_op_stepping(cpu->cpu_index);
-            cpu_single_step(cpu, sstep_flags);
+            cpu_single_step(cpu, get_sstep_flags());
         }
     }
     s->running_state = 1;
@@ -453,7 +468,7 @@ static int gdb_continue_partial(GDBState *s, char *newstates)
                 break; /* nothing to do here */
             case 's':
                 trace_gdbstub_op_stepping(cpu->cpu_index);
-                cpu_single_step(cpu, sstep_flags);
+                cpu_single_step(cpu, get_sstep_flags());
                 cpu_resume(cpu);
                 flag = 1;
                 break;
@@ -1409,9 +1424,28 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             addr = strtoull(p, (char **)&p, 16);
             gdb_set_cpu_pc(s, addr);
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
+        cpu_single_step(s->c_cpu, get_sstep_flags());
         gdb_continue(s);
         return RS_IDLE;
+    case 'b':
+        /* Backward debugging commands */
+        if (replay_mode == REPLAY_MODE_PLAY) {
+            switch (*p) {
+            case 's':
+                if (replay_reverse_step()) {
+                    gdb_continue(s);
+                    return RS_IDLE;
+                } else {
+                    put_packet(s, "E14");
+                    break;
+                }
+            default:
+                goto unknown_command;
+            }
+        } else {
+            put_packet(s, "E22");
+        }
+        goto unknown_command;
     case 'F':
         {
             target_ulong ret;
@@ -1714,6 +1748,10 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             }
             pstrcat(buf, sizeof(buf), ";multiprocess+");
 
+            if (replay_mode == REPLAY_MODE_PLAY) {
+                pstrcat(buf, sizeof(buf), ";ReverseStep+");
+            }
+
             put_packet(s, buf);
             break;
         }
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index d7e859d..533003f 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -73,6 +73,17 @@ void replay_finish(void);
 void replay_add_blocker(Error *reason);
 /* Returns name of the replay log file */
 const char *replay_get_filename(void);
+/*
+ * Start making one step in backward direction.
+ * Used by gdbstub for backwards debugging.
+ * Returns true on success.
+ */
+bool replay_reverse_step(void);
+/*
+ * Returns true if replay module is processing
+ * reverse_continue or reverse_step request
+ */
+bool replay_running_debug(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index d99a9c1..a2fb857 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -21,6 +21,13 @@
 #include "block/snapshot.h"
 #include "migration/snapshot.h"
 
+static bool replay_is_debugging;
+
+bool replay_running_debug(void)
+{
+    return replay_is_debugging;
+}
+
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
     if (replay_mode == REPLAY_MODE_NONE) {
@@ -219,3 +226,29 @@ void hmp_replay_seek(Monitor *mon, const QDict *qdict)
         return;
     }
 }
+
+static void replay_stop_vm_debug(void *opaque)
+{
+    replay_is_debugging = false;
+    vm_stop(RUN_STATE_DEBUG);
+    replay_break(-1LL, NULL, NULL);
+}
+
+bool replay_reverse_step(void)
+{
+    Error *err = NULL;
+
+    assert(replay_mode == REPLAY_MODE_PLAY);
+
+    if (replay_get_current_step() != 0) {
+        replay_seek(replay_get_current_step() - 1, replay_stop_vm_debug, &err);
+        if (err) {
+            error_free(err);
+            return false;
+        }
+        replay_is_debugging = true;
+        return true;
+    }
+
+    return false;
+}
diff --git a/stubs/replay.c b/stubs/replay.c
index 4ac6078..521552f 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -80,3 +80,8 @@ void replay_mutex_lock(void)
 void replay_mutex_unlock(void)
 {
 }
+
+bool replay_reverse_step(void)
+{
+    return false;
+}
