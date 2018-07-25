Received: from eggs.gnu.org ([2001:4830:134:3::10]:39528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIiN-0002xc-Hw
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIiK-00061m-Gb
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:23 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36780)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIiK-0005zv-1D
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:20 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:16:21 +0300
Message-ID: <20180725121621.12867.99063.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 16/24] gdbstub: add reverse step support in
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

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
 exec.c                    |    5 +++++
 gdbstub.c                 |   42 +++++++++++++++++++++++++++++++++++++++---
 include/sysemu/replay.h   |    7 +++++++
 replay/replay-debugging.c |   33 +++++++++++++++++++++++++++++++++
 stubs/replay.c            |    5 +++++
 7 files changed, 101 insertions(+), 6 deletions(-)

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
index 9b98b1f..e53a364 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1042,9 +1042,17 @@ static bool cpu_can_run(CPUState *cpu)
 
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
index 4f5df07..c4b5125 100644
--- a/exec.c
+++ b/exec.c
@@ -2761,6 +2761,11 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (cpu_watchpoint_address_matches(wp, vaddr, len)
             && (wp->flags & flags)) {
+            if (replay_running_debug()) {
+                /* Don't process the watchpoints when we are
+                   in a reverse debugging operation. */
+                return;
+            }
             if (flags == BP_MEM_READ) {
                 wp->flags |= BP_WATCHPOINT_HIT_READ;
             } else {
diff --git a/gdbstub.c b/gdbstub.c
index d6ab950..fa108f4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -39,6 +39,7 @@
 #include "sysemu/kvm.h"
 #include "exec/semihost.h"
 #include "exec/exec-all.h"
+#include "sysemu/replay.h"
 
 #ifdef CONFIG_USER_ONLY
 #define GDB_ATTACHED "0"
@@ -334,6 +335,19 @@ typedef struct GDBState {
  */
 static int sstep_flags = SSTEP_ENABLE|SSTEP_NOIRQ|SSTEP_NOTIMER;
 
+/*! Retrieves flags for single step mode. */
+static int get_sstep_flags(void)
+{
+    /* In replay mode all events written into the log should be replayed.
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
@@ -424,7 +438,7 @@ static int gdb_continue_partial(GDBState *s, char *newstates)
     CPU_FOREACH(cpu) {
         if (newstates[cpu->cpu_index] == 's') {
             trace_gdbstub_op_stepping(cpu->cpu_index);
-            cpu_single_step(cpu, sstep_flags);
+            cpu_single_step(cpu, get_sstep_flags());
         }
     }
     s->running_state = 1;
@@ -443,7 +457,7 @@ static int gdb_continue_partial(GDBState *s, char *newstates)
                 break; /* nothing to do here */
             case 's':
                 trace_gdbstub_op_stepping(cpu->cpu_index);
-                cpu_single_step(cpu, sstep_flags);
+                cpu_single_step(cpu, get_sstep_flags());
                 cpu_resume(cpu);
                 flag = 1;
                 break;
@@ -1082,9 +1096,28 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
@@ -1347,6 +1380,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             if (cc->gdb_core_xml_file != NULL) {
                 pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
             }
+            if (replay_mode == REPLAY_MODE_PLAY) {
+                pstrcat(buf, sizeof(buf), ";ReverseStep+");
+            }
             put_packet(s, buf);
             break;
         }
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 84a1ec5..611eabb 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -74,6 +74,13 @@ void replay_add_blocker(Error *reason);
 /*! Sets breakpoint at the specified step.
     If step = -1LL the existing breakpoint is removed. */
 void replay_break(int64_t step, QEMUTimerCB callback, void *opaque);
+/*! Start making one step in backward direction.
+    Used by gdbstub for backwards debugging.
+    Returns true on success. */
+bool replay_reverse_step(void);
+/*! Returns true if replay module is processing
+    reverse_continue or reverse_step request */
+bool replay_running_debug(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 8d6c03d..388cf12 100644
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
@@ -183,3 +190,29 @@ void hmp_replay_seek(Monitor *mon, const QDict *qdict)
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
+        replay_seek(replay_get_current_step() - 1, &err, replay_stop_vm_debug);
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
index 04279ab..b0fba0e 100644
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
