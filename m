Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E27C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756BB206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKhKpxR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756BB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfYP-0006Hk-0s
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQE-0007IC-Ae
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQ7-0002nd-Iu
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQ7-0002m2-6m
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id u18so10460838wmc.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j9kiPsYTsXbfYsAkLJu+kdHZvO1sRQiBT3GmVuGhPOM=;
 b=wKhKpxR30PjrZnuO8+dI+dAUqLrCBdA6CUxsG0oGyCwXiyk9PBRR/tUeLvC+O9clSy
 EpNg9Vj7PMcLeAhOjU9VdykBr81jbixd97U4q7J4S9g6su7nLzYcnXMLaReWfUj+QxC4
 27caBxUYb1KMxQxkTXoNbKl385uRsf/teJcMC5deoiSifIBAVtKhKNH+O791MdHgro7O
 i8RvEkrHlzQnqUXXsKOJhr4/L0rQG7bMAmnYucdapR8JWeI+2FxLH0cUX87Zg57OFrEU
 NQlruL2JHQg18gMxMY5cp55DJTI86HzGEQNRNPIpB/BoSRz15DLjofuOyk/RlT/NWBDn
 ZY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j9kiPsYTsXbfYsAkLJu+kdHZvO1sRQiBT3GmVuGhPOM=;
 b=k7YNfchxgzX1D44kiJC+LKowXp+4V5XrB1YMxlMw1lJC4GaZg04nlRJW3EszvrzMbb
 A71H4Ha6wTvwEpRRzFuJZ82s8t71ylBqOfJDQtpPU8ViMy3hICiVofD9TlRy37LPG1fj
 cm7Qp2zcvwQvr0r8UvbEh+j3l8qaRf1t4rBzi7bsydcFfM4rjH/e3jRxLKiLnbbw9gDh
 d1g2zSU0tpahSe9kuya81pHx8MtheOe2+VJWRpDj86lTqMEjf6eyYA/INhh1fXMcLglk
 hKfo3fem8cBzHz9UhJyYTRpMOpV/ZWGUp98IHmIJ28fm6fqE1xE1sY7j0DI/7qtxvTHH
 v96A==
X-Gm-Message-State: APjAAAWTkVTYCPMVaDs2ZHmHlQThY3kGqdzIjSE46Q6BJltBBmf4XXdd
 Ktz4R0XhrvimtI0mBEHJ0pHRGQ==
X-Google-Smtp-Source: APXvYqwaIjXh+E/WxFoTPevsUYtvTBJd51y66pul9fbALNqHu2byde1HeM/FH+zBoW+k76QlrSkkuw==
X-Received: by 2002:a1c:9c82:: with SMTP id f124mr17163676wme.25.1573839005257; 
 Fri, 15 Nov 2019 09:30:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q124sm9279347wme.13.2019.11.15.09.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:01 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 013C11FF8F;
 Fri, 15 Nov 2019 17:30:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  02/11] gdbstub: stop passing GDBState * around
Date: Fri, 15 Nov 2019 17:29:51 +0000
Message-Id: <20191115173000.21891-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115173000.21891-1-alex.bennee@linaro.org>
References: <20191115173000.21891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only have one GDBState which should be allocated at the time we
process any commands. This will make further clean-up a bit easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 307 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 177 insertions(+), 130 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c5b6701825f..2e6ff5f583c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1399,7 +1399,6 @@ static int cmd_parse_params(const char *data, const char *schema,
 }
 
 typedef struct GdbCmdContext {
-    GDBState *s;
     GdbCmdVariant *params;
     int num_params;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
@@ -1480,7 +1479,7 @@ static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
             return -1;
         }
 
-        gdb_ctx.s = s;
+        g_assert(s == gdbserver_state);
         cmd->handler(&gdb_ctx, user_ctx);
         return 0;
     }
@@ -1505,7 +1504,7 @@ static void run_cmd_parser(GDBState *s, const char *data,
 static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBProcess *process;
-    GDBState *s = gdb_ctx->s;
+    GDBState *s = gdbserver_state;
     uint32_t pid = 1;
 
     if (s->multiprocess) {
@@ -1540,40 +1539,44 @@ static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     CPUState *cpu;
+    GDBState *s = gdbserver_state;
 
     if (!gdb_ctx->num_params) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
     if (gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
-    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+    cpu = gdb_get_cpu(s, gdb_ctx->params[0].thread_id.pid,
                       gdb_ctx->params[0].thread_id.tid);
     if (!cpu) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
-    put_packet(gdb_ctx->s, "OK");
+    put_packet(s, "OK");
 }
 
 static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     if (gdb_ctx->num_params) {
-        gdb_set_cpu_pc(gdb_ctx->s, gdb_ctx->params[0].val_ull);
+        gdb_set_cpu_pc(s, gdb_ctx->params[0].val_ull);
     }
 
-    gdb_ctx->s->signal = 0;
-    gdb_continue(gdb_ctx->s);
+    s->signal = 0;
+    gdb_continue(s);
 }
 
 static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     unsigned long signal = 0;
+    GDBState *s = gdbserver_state;
 
     /*
      * Note: C sig;[addr] is currently unsupported and we simply
@@ -1583,36 +1586,37 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
         signal = gdb_ctx->params[0].val_ul;
     }
 
-    gdb_ctx->s->signal = gdb_signal_to_target(signal);
-    if (gdb_ctx->s->signal == -1) {
-        gdb_ctx->s->signal = 0;
+    s->signal = gdb_signal_to_target(signal);
+    if (s->signal == -1) {
+        s->signal = 0;
     }
-    gdb_continue(gdb_ctx->s);
+    gdb_continue(s);
 }
 
 static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     CPUState *cpu;
+    GDBState *s = gdbserver_state;
 
     if (gdb_ctx->num_params != 2) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
     if (gdb_ctx->params[1].thread_id.kind == GDB_READ_THREAD_ERR) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
     if (gdb_ctx->params[1].thread_id.kind != GDB_ONE_THREAD) {
-        put_packet(gdb_ctx->s, "OK");
+        put_packet(s, "OK");
         return;
     }
 
-    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[1].thread_id.pid,
+    cpu = gdb_get_cpu(s, gdb_ctx->params[1].thread_id.pid,
                       gdb_ctx->params[1].thread_id.tid);
     if (!cpu) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
@@ -1622,15 +1626,15 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
      */
     switch (gdb_ctx->params[0].opcode) {
     case 'c':
-        gdb_ctx->s->c_cpu = cpu;
-        put_packet(gdb_ctx->s, "OK");
+        s->c_cpu = cpu;
+        put_packet(s, "OK");
         break;
     case 'g':
-        gdb_ctx->s->g_cpu = cpu;
-        put_packet(gdb_ctx->s, "OK");
+        s->g_cpu = cpu;
+        put_packet(s, "OK");
         break;
     default:
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         break;
     }
 }
@@ -1638,9 +1642,10 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int res;
+    GDBState *s = gdbserver_state;
 
     if (gdb_ctx->num_params != 3) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
@@ -1648,22 +1653,23 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
                                 gdb_ctx->params[1].val_ull,
                                 gdb_ctx->params[2].val_ull);
     if (res >= 0) {
-        put_packet(gdb_ctx->s, "OK");
+        put_packet(s, "OK");
         return;
     } else if (res == -ENOSYS) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
         return;
     }
 
-    put_packet(gdb_ctx->s, "E22");
+    put_packet(s, "E22");
 }
 
 static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int res;
+    GDBState *s = gdbserver_state;
 
     if (gdb_ctx->num_params != 3) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
@@ -1671,14 +1677,14 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
                                 gdb_ctx->params[1].val_ull,
                                 gdb_ctx->params[2].val_ull);
     if (res >= 0) {
-        put_packet(gdb_ctx->s, "OK");
+        put_packet(s, "OK");
         return;
     } else if (res == -ENOSYS) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
         return;
     }
 
-    put_packet(gdb_ctx->s, "E22");
+    put_packet(s, "E22");
 }
 
 /*
@@ -1695,100 +1701,107 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int reg_size;
+    GDBState *s = gdbserver_state;
 
     if (!gdb_has_xml) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
         return;
     }
 
     if (gdb_ctx->num_params != 2) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
     reg_size = strlen(gdb_ctx->params[1].data) / 2;
     hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
-    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+    gdb_write_register(s->g_cpu, gdb_ctx->mem_buf,
                        gdb_ctx->params[0].val_ull);
-    put_packet(gdb_ctx->s, "OK");
+    put_packet(s, "OK");
 }
 
 static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int reg_size;
+    GDBState *s = gdbserver_state;
 
     if (!gdb_has_xml) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
         return;
     }
 
     if (!gdb_ctx->num_params) {
-        put_packet(gdb_ctx->s, "E14");
+        put_packet(s, "E14");
         return;
     }
 
-    reg_size = gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+    reg_size = gdb_read_register(s->g_cpu, gdb_ctx->mem_buf,
                                  gdb_ctx->params[0].val_ull);
     if (!reg_size) {
-        put_packet(gdb_ctx->s, "E14");
+        put_packet(s, "E14");
         return;
     }
 
     memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     if (gdb_ctx->num_params != 3) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
     /* hextomem() reads 2*len bytes */
     if (gdb_ctx->params[1].val_ull > strlen(gdb_ctx->params[2].data) / 2) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
     hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
              gdb_ctx->params[1].val_ull);
-    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+    if (target_memory_rw_debug(s->g_cpu, gdb_ctx->params[0].val_ull,
                                gdb_ctx->mem_buf,
                                gdb_ctx->params[1].val_ull, true)) {
-        put_packet(gdb_ctx->s, "E14");
+        put_packet(s, "E14");
         return;
     }
 
-    put_packet(gdb_ctx->s, "OK");
+    put_packet(s, "OK");
 }
 
 static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     if (gdb_ctx->num_params != 2) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
     /* memtohex() doubles the required space */
     if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
-    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+    if (target_memory_rw_debug(s->g_cpu, gdb_ctx->params[0].val_ull,
                                gdb_ctx->mem_buf,
                                gdb_ctx->params[1].val_ull, false)) {
-        put_packet(gdb_ctx->s, "E14");
+        put_packet(s, "E14");
         return;
     }
 
     memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     target_ulong addr, len;
     uint8_t *registers;
     int reg_size;
@@ -1797,37 +1810,40 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    cpu_synchronize_state(s->g_cpu);
     registers = gdb_ctx->mem_buf;
     len = strlen(gdb_ctx->params[0].data) / 2;
     hextomem(registers, gdb_ctx->params[0].data, len);
-    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs && len > 0;
+    for (addr = 0; addr < s->g_cpu->gdb_num_g_regs && len > 0;
          addr++) {
-        reg_size = gdb_write_register(gdb_ctx->s->g_cpu, registers, addr);
+        reg_size = gdb_write_register(s->g_cpu, registers, addr);
         len -= reg_size;
         registers += reg_size;
     }
-    put_packet(gdb_ctx->s, "OK");
+    put_packet(s, "OK");
 }
 
 static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     target_ulong addr, len;
 
-    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    cpu_synchronize_state(s->g_cpu);
     len = 0;
-    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
-        len += gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
+    for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
+        len += gdb_read_register(s->g_cpu, gdb_ctx->mem_buf + len,
                                  addr);
     }
 
     memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    if (gdb_ctx->num_params >= 1 && gdb_ctx->s->current_syscall_cb) {
+    GDBState *s = gdbserver_state;
+
+    if (gdb_ctx->num_params >= 1 && s->current_syscall_cb) {
         target_ulong ret, err;
 
         ret = (target_ulong)gdb_ctx->params[0].val_ull;
@@ -1836,51 +1852,56 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
         } else {
             err = 0;
         }
-        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
-        gdb_ctx->s->current_syscall_cb = NULL;
+        s->current_syscall_cb(s->c_cpu, ret, err);
+        s->current_syscall_cb = NULL;
     }
 
     if (gdb_ctx->num_params >= 3 && gdb_ctx->params[2].opcode == (uint8_t)'C') {
-        put_packet(gdb_ctx->s, "T02");
+        put_packet(s, "T02");
         return;
     }
 
-    gdb_continue(gdb_ctx->s);
+    gdb_continue(s);
 }
 
 static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     if (gdb_ctx->num_params) {
-        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
+        gdb_set_cpu_pc(s, (target_ulong)gdb_ctx->params[0].val_ull);
     }
 
-    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
-    gdb_continue(gdb_ctx->s);
+    cpu_single_step(s->c_cpu, sstep_flags);
+    gdb_continue(s);
 }
 
 static void handle_v_cont_query(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    put_packet(gdb_ctx->s, "vCont;c;C;s;S");
+    GDBState *s = gdbserver_state;
+    put_packet(s, "vCont;c;C;s;S");
 }
 
 static void handle_v_cont(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     int res;
 
     if (!gdb_ctx->num_params) {
         return;
     }
 
-    res = gdb_handle_vcont(gdb_ctx->s, gdb_ctx->params[0].data);
+    res = gdb_handle_vcont(s, gdb_ctx->params[0].data);
     if ((res == -EINVAL) || (res == -ERANGE)) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
     } else if (res) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
     }
 }
 
 static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     GDBProcess *process;
     CPUState *cpu;
     char thread_id[16];
@@ -1890,31 +1911,33 @@ static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
         goto cleanup;
     }
 
-    process = gdb_get_process(gdb_ctx->s, gdb_ctx->params[0].val_ul);
+    process = gdb_get_process(s, gdb_ctx->params[0].val_ul);
     if (!process) {
         goto cleanup;
     }
 
-    cpu = get_first_cpu_in_process(gdb_ctx->s, process);
+    cpu = get_first_cpu_in_process(s, process);
     if (!cpu) {
         goto cleanup;
     }
 
     process->attached = true;
-    gdb_ctx->s->g_cpu = cpu;
-    gdb_ctx->s->c_cpu = cpu;
+    s->g_cpu = cpu;
+    s->c_cpu = cpu;
 
-    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
+    gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id));
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
              GDB_SIGNAL_TRAP, thread_id);
 cleanup:
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_v_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     /* Kill the target */
-    put_packet(gdb_ctx->s, "OK");
+    put_packet(s, "OK");
     error_report("QEMU: Terminated via GDBstub");
     exit(0);
 }
@@ -1947,43 +1970,52 @@ static GdbCmdParseEntry gdb_v_commands_table[] = {
 
 static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     if (!gdb_ctx->num_params) {
         return;
     }
 
-    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+    if (process_string_cmd(s, NULL, gdb_ctx->params[0].data,
                            gdb_v_commands_table,
                            ARRAY_SIZE(gdb_v_commands_table))) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
     }
 }
 
 static void handle_query_qemu_sstepbits(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
              "ENABLE=%x,NOIRQ=%x,NOTIMER=%x", SSTEP_ENABLE,
              SSTEP_NOIRQ, SSTEP_NOTIMER);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_set_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     if (!gdb_ctx->num_params) {
         return;
     }
 
     sstep_flags = gdb_ctx->params[0].val_ul;
-    put_packet(gdb_ctx->s, "OK");
+    put_packet(s, "OK");
 }
 
 static void handle_query_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%x", sstep_flags);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     CPUState *cpu;
     GDBProcess *process;
     char thread_id[16];
@@ -1993,48 +2025,51 @@ static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
      * the first thread of the current process (gdb returns the
      * first thread).
      */
-    process = gdb_get_cpu_process(gdb_ctx->s, gdb_ctx->s->g_cpu);
-    cpu = get_first_cpu_in_process(gdb_ctx->s, process);
-    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
+    process = gdb_get_cpu_process(s, s->g_cpu);
+    cpu = get_first_cpu_in_process(s, process);
+    gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id));
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "QC%s", thread_id);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     char thread_id[16];
 
-    if (!gdb_ctx->s->query_cpu) {
-        put_packet(gdb_ctx->s, "l");
+    if (!s->query_cpu) {
+        put_packet(s, "l");
         return;
     }
 
-    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->query_cpu, thread_id,
+    gdb_fmt_thread_id(s, s->query_cpu, thread_id,
                       sizeof(thread_id));
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "m%s", thread_id);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
-    gdb_ctx->s->query_cpu =
-        gdb_next_attached_cpu(gdb_ctx->s, gdb_ctx->s->query_cpu);
+    put_packet(s, gdb_ctx->str_buf);
+    s->query_cpu =
+        gdb_next_attached_cpu(s, s->query_cpu);
 }
 
 static void handle_query_first_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    gdb_ctx->s->query_cpu = gdb_first_attached_cpu(gdb_ctx->s);
+    GDBState *s = gdbserver_state;
+    s->query_cpu = gdb_first_attached_cpu(s);
     handle_query_threads(gdb_ctx, user_ctx);
 }
 
 static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     CPUState *cpu;
     int len;
 
     if (!gdb_ctx->num_params ||
         gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
-    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+    cpu = gdb_get_cpu(s, gdb_ctx->params[0].thread_id.pid,
                       gdb_ctx->params[0].thread_id.tid);
     if (!cpu) {
         return;
@@ -2042,7 +2077,7 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
 
     cpu_synchronize_state(cpu);
 
-    if (gdb_ctx->s->multiprocess && (gdb_ctx->s->process_num > 1)) {
+    if (s->multiprocess && (s->process_num > 1)) {
         /* Print the CPU model and name in multiprocess mode */
         ObjectClass *oc = object_get_class(OBJECT(cpu));
         const char *cpu_model = object_class_get_name(oc);
@@ -2059,50 +2094,53 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
     trace_gdbstub_op_extra_info((char *)gdb_ctx->mem_buf);
     memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 #ifdef CONFIG_USER_ONLY
 static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     TaskState *ts;
 
-    ts = gdb_ctx->s->c_cpu->opaque;
+    ts = s->c_cpu->opaque;
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
              "Text=" TARGET_ABI_FMT_lx ";Data=" TARGET_ABI_FMT_lx
              ";Bss=" TARGET_ABI_FMT_lx,
              ts->info->code_offset,
              ts->info->data_offset,
              ts->info->data_offset);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 #else
 static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     int len;
 
     if (!gdb_ctx->num_params) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
     len = strlen(gdb_ctx->params[0].data);
     if (len % 2) {
-        put_packet(gdb_ctx->s, "E01");
+        put_packet(s, "E01");
         return;
     }
 
     len = len / 2;
     hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
     gdb_ctx->mem_buf[len++] = 0;
-    qemu_chr_be_write(gdb_ctx->s->mon_chr, gdb_ctx->mem_buf, len);
-    put_packet(gdb_ctx->s, "OK");
+    qemu_chr_be_write(s->mon_chr, gdb_ctx->mem_buf, len);
+    put_packet(s, "OK");
 
 }
 #endif
 
 static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     CPUClass *cc;
 
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "PacketSize=%x",
@@ -2115,15 +2153,16 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 
     if (gdb_ctx->num_params &&
         strstr(gdb_ctx->params[0].data, "multiprocess+")) {
-        gdb_ctx->s->multiprocess = true;
+        s->multiprocess = true;
     }
 
     pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess+");
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     GDBProcess *process;
     CPUClass *cc;
     unsigned long len, total_len, addr;
@@ -2131,22 +2170,22 @@ static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
     const char *p;
 
     if (gdb_ctx->num_params < 3) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
-    process = gdb_get_cpu_process(gdb_ctx->s, gdb_ctx->s->g_cpu);
-    cc = CPU_GET_CLASS(gdb_ctx->s->g_cpu);
+    process = gdb_get_cpu_process(s, s->g_cpu);
+    cc = CPU_GET_CLASS(s->g_cpu);
     if (!cc->gdb_core_xml_file) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
         return;
     }
 
     gdb_has_xml = true;
     p = gdb_ctx->params[0].data;
-    xml = get_feature_xml(gdb_ctx->s, p, &p, process);
+    xml = get_feature_xml(s, p, &p, process);
     if (!xml) {
-        put_packet(gdb_ctx->s, "E00");
+        put_packet(s, "E00");
         return;
     }
 
@@ -2154,7 +2193,7 @@ static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
     len = gdb_ctx->params[2].val_ul;
     total_len = strlen(xml);
     if (addr > total_len) {
-        put_packet(gdb_ctx->s, "E00");
+        put_packet(s, "E00");
         return;
     }
 
@@ -2170,35 +2209,39 @@ static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
         len = memtox(gdb_ctx->str_buf + 1, xml + addr, total_len - addr);
     }
 
-    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
+    put_packet_binary(s, gdb_ctx->str_buf, len + 1, true);
 }
 
 static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    put_packet(gdb_ctx->s, GDB_ATTACHED);
+    GDBState *s = gdbserver_state;
+    put_packet(s, GDB_ATTACHED);
 }
 
 static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "sstepbits;sstep");
 #ifndef CONFIG_USER_ONLY
     pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";PhyMemMode");
 #endif
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 #ifndef CONFIG_USER_ONLY
 static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
                                            void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "%d", phy_memory_mode);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
 }
 
 static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     if (!gdb_ctx->num_params) {
-        put_packet(gdb_ctx->s, "E22");
+        put_packet(s, "E22");
         return;
     }
 
@@ -2207,7 +2250,7 @@ static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
     } else {
         phy_memory_mode = 1;
     }
-    put_packet(gdb_ctx->s, "OK");
+    put_packet(s, "OK");
 }
 #endif
 
@@ -2319,51 +2362,56 @@ static GdbCmdParseEntry gdb_gen_set_table[] = {
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     if (!gdb_ctx->num_params) {
         return;
     }
 
-    if (!process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+    if (!process_string_cmd(s, NULL, gdb_ctx->params[0].data,
                             gdb_gen_query_set_common_table,
                             ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+    if (process_string_cmd(s, NULL, gdb_ctx->params[0].data,
                            gdb_gen_query_table,
                            ARRAY_SIZE(gdb_gen_query_table))) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
     }
 }
 
 static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
+
     if (!gdb_ctx->num_params) {
         return;
     }
 
-    if (!process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+    if (!process_string_cmd(s, NULL, gdb_ctx->params[0].data,
                             gdb_gen_query_set_common_table,
                             ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+    if (process_string_cmd(s, NULL, gdb_ctx->params[0].data,
                            gdb_gen_set_table,
                            ARRAY_SIZE(gdb_gen_set_table))) {
-        put_packet(gdb_ctx->s, "");
+        put_packet(s, "");
     }
 }
 
 static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    GDBState *s = gdbserver_state;
     char thread_id[16];
 
-    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
+    gdb_fmt_thread_id(s, s->c_cpu, thread_id,
                       sizeof(thread_id));
     snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
              GDB_SIGNAL_TRAP, thread_id);
-    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    put_packet(s, gdb_ctx->str_buf);
     /*
      * Remove all the breakpoints when this query is issued,
      * because gdb is doing an initial connect and the state
@@ -3052,10 +3100,9 @@ gdb_handlesig(CPUState *cpu, int sig)
 /* Tell the remote gdb that the process has exited due to SIG.  */
 void gdb_signalled(CPUArchState *env, int sig)
 {
-    GDBState *s;
+    GDBState *s = gdbserver_state;
     char buf[4];
 
-    s = gdbserver_state;
     if (gdbserver_fd < 0 || s->fd < 0) {
         return;
     }
-- 
2.20.1


