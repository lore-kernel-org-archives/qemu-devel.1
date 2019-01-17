Received: from eggs.gnu.org ([209.51.188.92]:43390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2GJ-0006yk-Nf
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2GG-00045p-UN
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:50 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57890)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2GG-0003dh-IJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:48 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 17 Jan 2019 10:38:27 +0300
Message-ID: <20190117073827.5399.13751.stgit@pasha-VirtualBox>
In-Reply-To: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v10 17/24] gdbstub: add reverse continue
 support in replay mode
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
index 013341c..6ef0992 100644
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
index 6e95469..b16fa7a 100644
--- a/exec.c
+++ b/exec.c
@@ -2745,6 +2745,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                  * Don't process the watchpoints when we are
                  * in a reverse debugging operation.
                  */
+                replay_breakpoint();
                 return;
             }
             if (flags == BP_MEM_READ) {
diff --git a/gdbstub.c b/gdbstub.c
index 442187d..60176d5 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1463,6 +1463,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
@@ -1773,7 +1781,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             pstrcat(buf, sizeof(buf), ";multiprocess+");
 
             if (replay_mode == REPLAY_MODE_PLAY) {
-                pstrcat(buf, sizeof(buf), ";ReverseStep+");
+                pstrcat(buf, sizeof(buf), ";ReverseStep+;ReverseContinue+");
             }
 
             put_packet(s, buf);
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 533003f..1d18c9b 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -80,10 +80,18 @@ const char *replay_get_filename(void);
  */
 bool replay_reverse_step(void);
 /*
+ * Start searching the last breakpoint/watchpoint.
+ * Used by gdbstub for backwards debugging.
+ * Returns true if the process successfully started.
+ */
+bool replay_reverse_continue(void);
+/*
  * Returns true if replay module is processing
  * reverse_continue or reverse_step request
  */
 bool replay_running_debug(void);
+/* Called in reverse debugging mode to collect breakpoint information */
+void replay_breakpoint(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index a2fb857..65e1bd9 100644
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
+    replay_break(-1LL, NULL, NULL);
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
index 521552f..ee64972 100644
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
