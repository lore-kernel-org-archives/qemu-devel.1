Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E7C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081A420760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmh/8Cr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081A420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhbN-0001XP-Oy
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQS-0003NE-Nv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:55005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQQ-0001Wu-M0
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id p15so1815678wmi.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wM70NITwc42Whej4N3YEEzYrn9T/JQZRJIsTDSZHZoE=;
 b=Qmh/8Cr+8nRP6Wc4PiP/9tv05Ms5AnFm8ufjCDwjLAi/Q9oyFbgbV6hG1MQKpLPBEF
 jtDCTiO8vRipGlA3eecoTjg0bfmnqXFnQY4s2G8sW8skBo0dazWQFLXxN2I62CRdGplu
 f+I4ygXh074fNeaxIe+RSlH0eAlxGCSfsmCd9kGmhCYfN0JR/nVClwYqdCZ9gHwzyfeL
 3Hvapk66wv3jkV5l053nK7HWI3dfkknF5Jhro9trTOPuUQ1CGAmfXsxoU7GvHPIwWEcw
 N6Xu5Pm6v+7LjsXiDS/6gVshWW9RtXBhkMW7Wyjr8m7WPE78FHfAYqgHDOBnjPBvQrSP
 p9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wM70NITwc42Whej4N3YEEzYrn9T/JQZRJIsTDSZHZoE=;
 b=s7Rk7ocu1Xnn0WTfufiEjirQpFfHCMi5b2MfQiui4D515Z42bzbgOFtJPO+vGqxaFh
 jzddsI09xVWr3hkD2BFnp4Ui6h4Z/IVI7sNYp6Vc92yejP7G5OVLwuGgtBTFQtH++sjx
 50g0sAyzqw2q5eWSXMrtgTz7vGFdbkGfN7zoop9UYKVKAmpBvPNtEM1AcaC4Ytj5QpbT
 78AWY/1e0/jAG4aEJgIApp46lw1ue9LlhLSy5/2JhRfARa21WRGNZkfNc0SBR26ajvCQ
 vFZ6M/+iwNwL/F1wYx0yHQoz5bpWPzy150HTQJlzzEQMIzcheIMMeOh0ZRb7pIr7r9zI
 bVZA==
X-Gm-Message-State: AOAM53295l8gp1SqkMmlIS0jTal8ufZ+8wBypi+87Gy7KDm9vQTltrU4
 tTPJ7hj6LNKv5GgrvLlbqukQJsyMDYk=
X-Google-Smtp-Source: ABdhPJywduqkFWtWNaOviBmnC1TdQqDDJoYRV9+dPXUcL3Yf+KTiksg2RGHcgQgqC0W7CT+7ZsJtYg==
X-Received: by 2002:a05:600c:214c:: with SMTP id
 v12mr1505271wml.23.1601969416925; 
 Tue, 06 Oct 2020 00:30:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/37] gdbstub: add reverse continue support in replay mode
Date: Tue,  6 Oct 2020 09:29:44 +0200
Message-Id: <20201006072947.487729-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x333.google.com
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
Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds support of the reverse continue operation for gdbstub.
Reverse continue finds the last breakpoint that would happen in normal
execution from the beginning to the current moment.
Implementation of the reverse continue replays the execution twice:
to find the breakpoints that were hit and to seek to the last breakpoint.
Reverse continue loads the previous snapshot and tries to find the breakpoint
since that moment. If there are no such breakpoints, it proceeds to
the earlier snapshot, and so on. When no breakpoints or watchpoints were
hit at all, execution stops at the beginning of the replay log.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Message-Id: <160174522930.12451.6994758004725016836.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                    |  1 +
 gdbstub.c                 | 10 +++++-
 include/sysemu/replay.h   |  8 +++++
 replay/replay-debugging.c | 72 +++++++++++++++++++++++++++++++++++++++
 softmmu/cpus.c            |  5 +++
 stubs/replay.c            |  5 +++
 6 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index d8072668ea..ec68f4a9ca 100644
--- a/exec.c
+++ b/exec.c
@@ -2753,6 +2753,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                  * Don't process the watchpoints when we are
                  * in a reverse debugging operation.
                  */
+                replay_breakpoint();
                 return;
             }
             if (flags == BP_MEM_READ) {
diff --git a/gdbstub.c b/gdbstub.c
index 79e8ccc050..ac92273018 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1907,6 +1907,13 @@ static void handle_backward(GdbCmdContext *gdb_ctx, void *user_ctx)
                 put_packet("E14");
             }
             return;
+        case 'c':
+            if (replay_reverse_continue()) {
+                gdb_continue();
+            } else {
+                put_packet("E14");
+            }
+            return;
         }
     }
 
@@ -2161,7 +2168,8 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     if (replay_mode == REPLAY_MODE_PLAY) {
-        g_string_append(gdbserver_state.str_buf, ";ReverseStep+");
+        g_string_append(gdbserver_state.str_buf,
+            ";ReverseStep+;ReverseContinue+");
     }
 
     if (gdb_ctx->num_params &&
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 90bbb5d825..172b20c60c 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -81,11 +81,19 @@ const char *replay_get_filename(void);
  * Returns true on success.
  */
 bool replay_reverse_step(void);
+/*
+ * Start searching the last breakpoint/watchpoint.
+ * Used by gdbstub for backwards debugging.
+ * Returns true if the process successfully started.
+ */
+bool replay_reverse_continue(void);
 /*
  * Returns true if replay module is processing
  * reverse_continue or reverse_step request
  */
 bool replay_running_debug(void);
+/* Called in reverse debugging mode to collect breakpoint information */
+void replay_breakpoint(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 1e1dec0295..30ca38e5dd 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -23,6 +23,8 @@
 #include "migration/snapshot.h"
 
 static bool replay_is_debugging;
+static int64_t replay_last_breakpoint;
+static int64_t replay_last_snapshot;
 
 bool replay_running_debug(void)
 {
@@ -246,3 +248,73 @@ bool replay_reverse_step(void)
 
     return false;
 }
+
+static void replay_continue_end(void)
+{
+    replay_is_debugging = false;
+    vm_stop(RUN_STATE_DEBUG);
+    replay_delete_break();
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
+        replay_last_snapshot = replay_get_current_icount();
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
+    if (replay_get_current_icount() != 0) {
+        replay_seek(replay_get_current_icount() - 1,
+                    replay_continue_stop, &err);
+        if (err) {
+            error_free(err);
+            return false;
+        }
+        replay_last_breakpoint = -1LL;
+        replay_is_debugging = true;
+        replay_last_snapshot = replay_get_current_icount();
+        return true;
+    }
+
+    return false;
+}
+
+void replay_breakpoint(void)
+{
+    assert(replay_mode == REPLAY_MODE_PLAY);
+    replay_last_breakpoint = replay_get_current_icount();
+}
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 95c557fac5..9e33416b4d 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -286,6 +286,11 @@ void cpu_handle_guest_debug(CPUState *cpu)
 {
     if (replay_running_debug()) {
         if (!cpu->singlestep_enabled) {
+            /*
+             * Report about the breakpoint and
+             * make a single step to skip it
+             */
+            replay_breakpoint();
             cpu_single_step(cpu, SSTEP_ENABLE);
         } else {
             cpu_single_step(cpu, 0);
diff --git a/stubs/replay.c b/stubs/replay.c
index d5b52302e9..45ebe77fb9 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -98,3 +98,8 @@ bool replay_reverse_step(void)
 {
     return false;
 }
+
+bool replay_reverse_continue(void)
+{
+    return false;
+}
-- 
2.26.2



