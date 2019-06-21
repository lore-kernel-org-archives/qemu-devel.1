Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF555C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 08:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82BC20673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 08:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82BC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFM3-0003hi-3a
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 04:57:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58372)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1heEza-0004CE-S3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1heEoE-00010x-B0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:22:11 -0400
Received: from mail.ispras.ru ([83.149.199.45]:41600)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1heEoD-00010J-V7
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:22:10 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 17A7E54006B;
 Fri, 21 Jun 2019 11:22:09 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 11:22:08 +0300
Message-ID: <156110532889.25431.10442246764810242357.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <156110523748.25431.9310430853468653085.stgit@pasha-Precision-3630-Tower>
References: <156110523748.25431.9310430853468653085.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.1 16/24] gdbstub: add reverse step
 support in replay mode
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
 cpus.c                    |   14 +++++++++--
 exec.c                    |    7 ++++++
 gdbstub.c                 |   56 +++++++++++++++++++++++++++++++++++++++++++--
 include/sysemu/replay.h   |   11 +++++++++
 replay/replay-debugging.c |   33 +++++++++++++++++++++++++++
 stubs/replay.c            |    5 ++++
 7 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a3..708bbedd43 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -16,6 +16,7 @@
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "sysemu/replay.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
diff --git a/cpus.c b/cpus.c
index 0a44253523..c2356f9836 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1109,9 +1109,17 @@ static bool cpu_can_run(CPUState *cpu)
 
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
index e7622d1956..ee21e6de34 100644
--- a/exec.c
+++ b/exec.c
@@ -2816,6 +2816,13 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
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
index 8618e34311..2fe718d0b7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -43,6 +43,7 @@
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
 #include "exec/exec-all.h"
+#include "sysemu/replay.h"
 
 #ifdef CONFIG_USER_ONLY
 #define GDB_ATTACHED "0"
@@ -364,6 +365,20 @@ typedef struct GDBState {
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
@@ -454,7 +469,7 @@ static int gdb_continue_partial(GDBState *s, char *newstates)
     CPU_FOREACH(cpu) {
         if (newstates[cpu->cpu_index] == 's') {
             trace_gdbstub_op_stepping(cpu->cpu_index);
-            cpu_single_step(cpu, sstep_flags);
+            cpu_single_step(cpu, get_sstep_flags());
         }
     }
     s->running_state = 1;
@@ -473,7 +488,7 @@ static int gdb_continue_partial(GDBState *s, char *newstates)
                 break; /* nothing to do here */
             case 's':
                 trace_gdbstub_op_stepping(cpu->cpu_index);
-                cpu_single_step(cpu, sstep_flags);
+                cpu_single_step(cpu, get_sstep_flags());
                 cpu_resume(cpu);
                 flag = 1;
                 break;
@@ -1826,10 +1841,31 @@ static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
         gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
     }
 
-    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
+    cpu_single_step(gdb_ctx->s->c_cpu, get_sstep_flags());
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_backward(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        put_packet(gdb_ctx->s, "E22");
+    }
+    if (gdb_ctx->num_params == 1) {
+        switch (gdb_ctx->params[0].opcode) {
+        case 's':
+            if (replay_reverse_step()) {
+                gdb_continue(gdb_ctx->s);
+            } else {
+                put_packet(gdb_ctx->s, "E14");
+            }
+            return;
+        }
+    }
+
+    /* Default invalid command */
+    put_packet(gdb_ctx->s, "");
+}
+
 static void handle_v_cont_query(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     put_packet(gdb_ctx->s, "vCont;c;C;s;S");
@@ -2084,6 +2120,9 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
         pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
                 ";qXfer:features:read+");
     }
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";ReverseStep+");
+    }
 
     if (gdb_ctx->num_params &&
         strstr(gdb_ctx->params[0].data, "multiprocess+")) {
@@ -2423,6 +2462,17 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             cmd_parser = &step_cmd_desc;
         }
         break;
+    case 'b':
+        {
+            static const GdbCmdParseEntry backward_cmd_desc = {
+                .handler = handle_backward,
+                .cmd = "b",
+                .cmd_startswith = 1,
+                .schema = "o0"
+            };
+            cmd_parser = &backward_cmd_desc;
+        }
+        break;
     case 'F':
         {
             static const GdbCmdParseEntry file_io_cmd_desc = {
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index d7e859d915..533003f2b0 100644
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
index e3821ab1ba..3d94859b8f 100644
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
+    replay_delete_break();
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
index 4ac607895d..521552fa83 100644
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


