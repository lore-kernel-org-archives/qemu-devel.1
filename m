Received: from eggs.gnu.org ([2001:4830:134:3::10]:47721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYD8-0001hU-7p
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYD4-0002yM-5j
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:42 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42080)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYD3-0002xk-OD
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:38 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:27:38 +0300
Message-ID: <20180111082738.27295.80055.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v3 29/30] replay: improve replay performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

This patch skips cpu_exec when there is no CPU code to execute in replay mode.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
---
 cpus.c                  |   50 +++++++++++++++++++++++++----------------------
 include/sysemu/replay.h |    3 +++
 replay/replay.c         |   13 ++++++++++++
 3 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/cpus.c b/cpus.c
index bafedfc..ef4c5b9 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1449,39 +1449,43 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
+        if (!replay_has_checkpoint()) {
+            while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
 
-            atomic_mb_set(&tcg_current_rr_cpu, cpu);
-            current_cpu = cpu;
+                atomic_mb_set(&tcg_current_rr_cpu, cpu);
+                current_cpu = cpu;
 
-            qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
-                              (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
+                qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
+                                  (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
 
-            if (cpu_can_run(cpu)) {
-                int r;
+                if (cpu_can_run(cpu)) {
+                    int r;
 
-                prepare_icount_for_run(cpu);
+                    prepare_icount_for_run(cpu);
 
-                r = tcg_cpu_exec(cpu);
+                    r = tcg_cpu_exec(cpu);
 
-                process_icount_data(cpu);
+                    process_icount_data(cpu);
 
-                if (r == EXCP_DEBUG) {
-                    cpu_handle_guest_debug(cpu);
-                    break;
-                } else if (r == EXCP_ATOMIC) {
-                    cpu_exec_step_atomic(cpu);
+                    if (r == EXCP_DEBUG) {
+                        cpu_handle_guest_debug(cpu);
+                        break;
+                    } else if (r == EXCP_ATOMIC) {
+                        cpu_exec_step_atomic(cpu);
+                        break;
+                    }
+                } else if (cpu->stop) {
+                    if (cpu->unplug) {
+                        cpu = CPU_NEXT(cpu);
+                    }
                     break;
                 }
-            } else if (cpu->stop) {
-                if (cpu->unplug) {
-                    cpu = CPU_NEXT(cpu);
-                }
-                break;
-            }
 
-            cpu = CPU_NEXT(cpu);
-        } /* while (cpu && !cpu->exit_request).. */
+                cpu = CPU_NEXT(cpu);
+            } /* while (cpu && !cpu->exit_request).. */
+        } else {
+            qemu_notify_event();
+        }
 
         /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
         atomic_set(&tcg_current_rr_cpu, NULL);
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index d026b28..44c1ff7 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -122,6 +122,9 @@ void replay_shutdown_request(ShutdownCause cause);
     Returns 0 in PLAY mode if checkpoint was not found.
     Returns 1 in all other cases. */
 bool replay_checkpoint(ReplayCheckpoint checkpoint);
+/*! Used to determine that checkpoint is pending.
+    Does not proceed to the next event in the log. */
+bool replay_has_checkpoint(void);
 
 /* Asynchronous events queue */
 
diff --git a/replay/replay.c b/replay/replay.c
index c9fd984..b9c496a 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -219,6 +219,19 @@ out:
     return res;
 }
 
+bool replay_has_checkpoint(void)
+{
+    bool res = false;
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        replay_mutex_lock();
+        replay_account_executed_instructions();
+        res = EVENT_CHECKPOINT <= replay_state.data_kind
+            && replay_state.data_kind <= EVENT_CHECKPOINT_LAST;
+        replay_mutex_unlock();
+    }
+    return res;
+}
+
 void replay_init_locks(void)
 {
     replay_mutex_init();
