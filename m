Received: from eggs.gnu.org ([2001:4830:134:3::10]:35373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvMU-0006Vx-SG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvMP-00062J-Sq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:50 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38650)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvMP-00061T-H3
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:45 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 24 Jan 2017 10:17:47 +0300
Message-ID: <20170124071746.4572.61449.stgit@PASHA-ISP>
In-Reply-To: <20170124071654.4572.41407.stgit@PASHA-ISP>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 09/14] replay: save/load initial state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch implements initial vmstate creation or loading at the start
of record/replay. It is needed for rewinding the execution in the replay mode.

v4 changes:
 - snapshots are not created by default anymore

v3 changes:
 - added rrsnapshot option

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 docs/replay.txt          |   16 ++++++++++++++++
 include/sysemu/replay.h  |    9 +++++++++
 qemu-options.hx          |    8 ++++++--
 replay/replay-snapshot.c |   17 +++++++++++++++++
 replay/replay.c          |    5 +++++
 vl.c                     |    7 ++++++-
 6 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/docs/replay.txt b/docs/replay.txt
index 347b2ff..03e1931 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -196,6 +196,22 @@ is recorded to the log. In replay phase the queue is matched with
 events read from the log. Therefore block devices requests are processed
 deterministically.
 
+Snapshotting
+------------
+
+New VM snapshots may be created in replay mode. They can be used later
+to recover the desired VM state. All VM states created in replay mode
+are associated with the moment of time in the replay scenario.
+After recovering the VM state replay will start from that position.
+
+Default starting snapshot name may be specified with icount field
+rrsnapshot as follows:
+ -icount shift=7,rr=record,rrfile=replay.bin,rrsnapshot=snapshot_name
+
+This snapshot is created at start of recording and restored at start
+of replaying. It also can be loaded while replaying to roll back
+the execution.
+
 Network devices
 ---------------
 
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index abb35ca..740b425 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -43,6 +43,9 @@ typedef struct ReplayNetState ReplayNetState;
 
 extern ReplayMode replay_mode;
 
+/* Name of the initial VM snapshot */
+extern char *replay_snapshot;
+
 /* Replay process control functions */
 
 /*! Enables recording or saving event log with specified parameters */
@@ -149,4 +152,10 @@ void replay_unregister_net(ReplayNetState *rns);
 void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
                              const struct iovec *iov, int iovcnt);
 
+/* VM state operations */
+
+/*! Called at the start of execution.
+    Loads or saves initial vmstate depending on execution mode. */
+void replay_vmstate_init(void);
+
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f..32c7d2b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3390,12 +3390,12 @@ re-inject them.
 ETEXI
 
 DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
-    "-icount [shift=N|auto][,align=on|off][,sleep=on|off,rr=record|replay,rrfile=<filename>]\n" \
+    "-icount [shift=N|auto][,align=on|off][,sleep=on|off,rr=record|replay,rrfile=<filename>,rrsnapshot=<snapshot>]\n" \
     "                enable virtual instruction counter with 2^N clock ticks per\n" \
     "                instruction, enable aligning the host and virtual clocks\n" \
     "                or disable real time cpu sleeping\n", QEMU_ARCH_ALL)
 STEXI
-@item -icount [shift=@var{N}|auto][,rr=record|replay,rrfile=@var{filename}]
+@item -icount [shift=@var{N}|auto][,rr=record|replay,rrfile=@var{filename},rrsnapshot=@var{snapshot}]
 @findex -icount
 Enable virtual instruction counter.  The virtual cpu will execute one
 instruction every 2^@var{N} ns of virtual time.  If @code{auto} is specified
@@ -3428,6 +3428,10 @@ when the shift value is high (how high depends on the host machine).
 When @option{rr} option is specified deterministic record/replay is enabled.
 Replay log is written into @var{filename} file in record mode and
 read from this file in replay mode.
+
+Option rrsnapshot is used to create new vm snapshot named @var{snapshot}
+at the start of execution recording. In replay mode this option is used
+to load the initial VM state.
 ETEXI
 
 DEF("watchdog", HAS_ARG, QEMU_OPTION_watchdog, \
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 4980597..f2cf748 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -59,3 +59,20 @@ void replay_vmstate_register(void)
 {
     vmstate_register(NULL, 0, &vmstate_replay, &replay_state);
 }
+
+void replay_vmstate_init(void)
+{
+    if (replay_snapshot) {
+        if (replay_mode == REPLAY_MODE_RECORD) {
+            if (save_vmstate(cur_mon, replay_snapshot) != 0) {
+                error_report("Could not create snapshot for icount record");
+                exit(1);
+            }
+        } else if (replay_mode == REPLAY_MODE_PLAY) {
+            if (load_vmstate(replay_snapshot) != 0) {
+                error_report("Could not load snapshot for icount replay");
+                exit(1);
+            }
+        }
+    }
+}
diff --git a/replay/replay.c b/replay/replay.c
index 7f27cf1..1835b99 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -26,6 +26,7 @@
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
 ReplayMode replay_mode = REPLAY_MODE_NONE;
+char *replay_snapshot;
 
 /* Name of replay file  */
 static char *replay_filename;
@@ -292,6 +293,7 @@ void replay_configure(QemuOpts *opts)
         exit(1);
     }
 
+    replay_snapshot = g_strdup(qemu_opt_get(opts, "rrsnapshot"));
     replay_vmstate_register();
     replay_enable(fname, mode);
 
@@ -346,6 +348,9 @@ void replay_finish(void)
         replay_filename = NULL;
     }
 
+    g_free(replay_snapshot);
+    replay_snapshot = NULL;
+
     replay_finish_events();
     replay_mutex_destroy();
 }
diff --git a/vl.c b/vl.c
index c643d3f..52a6ac8 100644
--- a/vl.c
+++ b/vl.c
@@ -462,6 +462,9 @@ static QemuOptsList qemu_icount_opts = {
         }, {
             .name = "rrfile",
             .type = QEMU_OPT_STRING,
+        }, {
+            .name = "rrsnapshot",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -4651,7 +4654,9 @@ int main(int argc, char **argv, char **envp)
     replay_checkpoint(CHECKPOINT_RESET);
     qemu_system_reset(VMRESET_SILENT);
     register_global_state();
-    if (loadvm) {
+    if (replay_mode != REPLAY_MODE_NONE) {
+        replay_vmstate_init();
+    } else if (loadvm) {
         if (load_vmstate(loadvm) < 0) {
             autostart = 0;
         }
