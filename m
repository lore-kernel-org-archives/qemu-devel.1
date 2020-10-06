Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5057AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD41B206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsjAkoh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD41B206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPi1i-0002e6-0R
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQR-0003KU-R9
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:19 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQP-0001WU-OR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id e17so3523430wru.12
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BZEg5NVPWJDkC3vQrt886XwMNy/dNcS/j2ONP5TF7e8=;
 b=LsjAkoh6cNtsvcD1QeQeuEUk/CSsf2/GdgracXb2PKwlpMwws0+XVAzPZsV3Gy8EB3
 8/aNrE/ctcUGibOfWU7dvxPBguK41iV9DpoTYy7ThqeH3OhXdJpusc3CNm3FJDNflaEm
 //exxO8RDIsdPhRuehTNrfGI+9dT7v6HGehnJSuMx0mDJg4OAlGsxwu9l0WLFi2Hndpe
 jMdV8ja15LYpGcSOCL7FmKKEjXd93XSRfE2KTI/XGAgFdnLA6m1EVbTcN4wrRQ8w2CaR
 yIX60hNaMGwz+uH11FP8mP6/W5FDmLiK+kvU/rFIkbIAWRj0xyKrMw+1+lmUBl2PkYCe
 Hj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BZEg5NVPWJDkC3vQrt886XwMNy/dNcS/j2ONP5TF7e8=;
 b=IsiK52E6cVAYuZREFter+37ir1ixiLJAony99uLgWMzM3m6yu7ix3OLqGWAABIp1p9
 mI28af9VUL1+BGgzlS9C7igUzPNUhHvqylr9Cbxh5xDlziyhn13Yhiv3gn1WynnI9yBl
 fJYi21V78+G6pPMVMM1U0Fz24XeWQ6u3DWXTmBKn/JSVvYamnuxh1l2ai7A66HoCw13u
 pUmsjDqXwLdibel6Pkxq0O55eC7q5cBuNf3eOGDyioJ4g70VmOXhhLjnxHo9jEyqsvdV
 ytitxPOuSu+BU1FY2EfyLrGnN5U7w/ikvVchUrXsBK4WQkBne26KXkNo+GZ6T+14t/d2
 8ipQ==
X-Gm-Message-State: AOAM531zK0c/PHzdQhILILJslR+fHL6uh4MFNpGtKrx6wK6kH5Luz2jT
 PwDjYikektGjSHW65K/fJM5KtMG0ax0=
X-Google-Smtp-Source: ABdhPJydlP/n6IY1AjZgWUZi2ANToAHE1b2xdUV2aaAMZ2RDwneiID3Ph+me4jDtnFr9YLQ8ebV6Dw==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr3340342wrv.222.1601969416067; 
 Tue, 06 Oct 2020 00:30:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/37] gdbstub: add reverse step support in replay mode
Date: Tue,  6 Oct 2020 09:29:43 +0200
Message-Id: <20201006072947.487729-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
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

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--

v4 changes:
 - inverted condition in cpu_handle_guest_debug (suggested by Alex Bennée)
Message-Id: <160174522341.12451.1498758422543765253.stgit@pasha-ThinkPad-X280>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translator.c    |  1 +
 exec.c                    |  7 +++++
 gdbstub.c                 | 55 +++++++++++++++++++++++++++++++++++++--
 include/sysemu/replay.h   | 11 ++++++++
 replay/replay-debugging.c | 34 ++++++++++++++++++++++++
 softmmu/cpus.c            | 14 +++++++---
 stubs/replay.c            |  5 ++++
 7 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 603d17ff83..fb1e19c585 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -17,6 +17,7 @@
 #include "exec/log.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
+#include "sysemu/replay.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
diff --git a/exec.c b/exec.c
index 2305f5553e..d8072668ea 100644
--- a/exec.c
+++ b/exec.c
@@ -2748,6 +2748,13 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (watchpoint_address_matches(wp, addr, len)
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
index 9dfb6e4142..79e8ccc050 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -51,6 +51,7 @@
 #include "sysemu/runstate.h"
 #include "hw/semihosting/semihost.h"
 #include "exec/exec-all.h"
+#include "sysemu/replay.h"
 
 #ifdef CONFIG_USER_ONLY
 #define GDB_ATTACHED "0"
@@ -375,6 +376,20 @@ typedef struct GDBState {
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
 static GDBState gdbserver_state;
 
 static void init_gdbserver_state(void)
@@ -501,7 +516,7 @@ static int gdb_continue_partial(char *newstates)
                 break; /* nothing to do here */
             case 's':
                 trace_gdbstub_op_stepping(cpu->cpu_index);
-                cpu_single_step(cpu, sstep_flags);
+                cpu_single_step(cpu, get_sstep_flags());
                 cpu_resume(cpu);
                 flag = 1;
                 break;
@@ -1874,10 +1889,31 @@ static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
         gdb_set_cpu_pc((target_ulong)gdb_ctx->params[0].val_ull);
     }
 
-    cpu_single_step(gdbserver_state.c_cpu, sstep_flags);
+    cpu_single_step(gdbserver_state.c_cpu, get_sstep_flags());
     gdb_continue();
 }
 
+static void handle_backward(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        put_packet("E22");
+    }
+    if (gdb_ctx->num_params == 1) {
+        switch (gdb_ctx->params[0].opcode) {
+        case 's':
+            if (replay_reverse_step()) {
+                gdb_continue();
+            } else {
+                put_packet("E14");
+            }
+            return;
+        }
+    }
+
+    /* Default invalid command */
+    put_packet("");
+}
+
 static void handle_v_cont_query(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     put_packet("vCont;c;C;s;S");
@@ -2124,6 +2160,10 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        g_string_append(gdbserver_state.str_buf, ";ReverseStep+");
+    }
+
     if (gdb_ctx->num_params &&
         strstr(gdb_ctx->params[0].data, "multiprocess+")) {
         gdbserver_state.multiprocess = true;
@@ -2460,6 +2500,17 @@ static int gdb_handle_packet(const char *line_buf)
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
index c486c3afb2..90bbb5d825 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -75,6 +75,17 @@ void replay_finish(void);
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
index e1fe6b8661..1e1dec0295 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -22,6 +22,13 @@
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
@@ -212,3 +219,30 @@ void hmp_replay_seek(Monitor *mon, const QDict *qdict)
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
+    if (replay_get_current_icount() != 0) {
+        replay_seek(replay_get_current_icount() - 1,
+                    replay_stop_vm_debug, &err);
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
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index f3d0c59f78..95c557fac5 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -284,9 +284,17 @@ bool cpu_can_run(CPUState *cpu)
 
 void cpu_handle_guest_debug(CPUState *cpu)
 {
-    gdb_set_stop_cpu(cpu);
-    qemu_system_debug_request();
-    cpu->stopped = true;
+    if (replay_running_debug()) {
+        if (!cpu->singlestep_enabled) {
+            cpu_single_step(cpu, SSTEP_ENABLE);
+        } else {
+            cpu_single_step(cpu, 0);
+        }
+    } else {
+        gdb_set_stop_cpu(cpu);
+        qemu_system_debug_request();
+        cpu->stopped = true;
+    }
 }
 
 #ifdef CONFIG_LINUX
diff --git a/stubs/replay.c b/stubs/replay.c
index eacb366aa8..d5b52302e9 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -93,3 +93,8 @@ uint64_t replay_get_current_icount(void)
 {
     return 0;
 }
+
+bool replay_reverse_step(void)
+{
+    return false;
+}
-- 
2.26.2



