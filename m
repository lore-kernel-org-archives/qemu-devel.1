Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30180C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8AC62075C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3dAg1W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AC62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayUN-00019E-Vw
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOJ-0002xo-Uw
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOH-0003DT-0H
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:11 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayOG-0003Cu-QE
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:08 -0500
Received: by mail-wr1-x442.google.com with SMTP id b6so8150633wrq.0
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cVLoNyrOG/MAL6mzJFsBL4SblyEDJESFcoquktiFLt0=;
 b=V3dAg1W88O85xwdAfOEKiMcJdkmn4U0WgrhOF8gCkGuRulVMdBE7Ygm39j3igLTsQW
 HtzZvsIA2mKv25IQdLNhfQ3poJS67IuStMy2hpHaAh0RzA1bgv1Zt7dz20/q8JrpEhIN
 mID545Y0K5/MTpqLf1Dqrel+vG6H8535xDtKbGhLAX4dbJsoyj6Xb2V+yqaV+YkNka/p
 yulnqFYftJMTpAWMRlL/ZZjlrFa3UNlDxAFobe/7Vo/LAAd3NjWFBS3tZNDu7fSogm9a
 wsr1Uf/rZab5ArzTJ2IFuuDzHEQ3a+HUaEcE1OMlgyXU+EhNn1GbAaXrp9SedmrE42yh
 i+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cVLoNyrOG/MAL6mzJFsBL4SblyEDJESFcoquktiFLt0=;
 b=FRGk7Tg240L+lInJYSeC+nnnz93iB7blEVBEgH2kiUp2FbHuatykN8EnI86VnOwlQo
 G4xvoUMDbaORikDcSlw3JIppv43itexT1LnguV15XQV9Hyd9ARCuebHI7TfKYrAFatjs
 DCvUtUd/brvqHJviPpWXpQiPTANTP+1tDa7Q1pxWkAIA8k+uEI+juveTHI+IIMCqg7f8
 m7dvJPo/0bpNCkBMMxrbrI+yl1IDT4TU3M0Wst+u6Z3u8/MLB3yzYj1yCdmSIt9AJw7e
 RcV2q9ECbmqYynRLbRYOtsV76ZOF8BY1tCFPPPDfA4qpKtnf6kFQAwbmpUa05xYWAD+p
 pGEQ==
X-Gm-Message-State: APjAAAXF9eBVj9ZbphOC7DHNGzGHorbAJrjq8QKfdrkLvoVrjyGKdM3P
 ikYua7eKx/LGJUnnkSqxW7BOhA==
X-Google-Smtp-Source: APXvYqyJVpRqT19/rLlrUj4LoMg+aiyEY0ez8Ff1XO83ZMt4Cs78JwfHjeK1zg3xOW9HS/NVJeQcTQ==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr63020823wrv.382.1575103567647; 
 Sat, 30 Nov 2019 00:46:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm9239999wme.45.2019.11.30.00.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:46:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8640A1FF91;
 Sat, 30 Nov 2019 08:46:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/14] gdbstub: move mem_buf to GDBState and use GByteArray
Date: Sat, 30 Nov 2019 08:45:52 +0000
Message-Id: <20191130084602.10818-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191130084602.10818-1-alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

This is in preparation for further re-factoring of the register API
with the rest of the code. Theoretically the read register function
could overwrite the MAX_PACKET_LENGTH buffer although currently all
registers are well within the size range.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub.c | 62 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index dc8a6f2c7e2..265157282f2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -367,6 +367,7 @@ typedef struct GDBState {
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
     GString *str_buf;
+    GByteArray *mem_buf;
 } GDBState;
 
 /* By default use no IRQs and no timers while single stepping so as to
@@ -382,6 +383,7 @@ static void init_gdbserver_state(void)
     memset(&gdbserver_state, 0, sizeof(GDBState));
     gdbserver_state.init = true;
     gdbserver_state.str_buf = g_string_new(NULL);
+    gdbserver_state.mem_buf = g_byte_array_sized_new(MAX_PACKET_LENGTH);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -576,12 +578,13 @@ static void memtohex(GString *buf, const uint8_t *mem, int len)
     g_string_append_c(buf, '\0');
 }
 
-static void hextomem(uint8_t *mem, const char *buf, int len)
+static void hextomem(GByteArray *mem, const char *buf, int len)
 {
     int i;
 
     for(i = 0; i < len; i++) {
-        mem[i] = (fromhex(buf[0]) << 4) | fromhex(buf[1]);
+        guint8 byte = fromhex(buf[0]) << 4 | fromhex(buf[1]);
+        g_byte_array_append(mem, &byte, 1);
         buf += 2;
     }
 }
@@ -1412,7 +1415,6 @@ static int cmd_parse_params(const char *data, const char *schema,
 typedef struct GdbCmdContext {
     GdbCmdVariant *params;
     int num_params;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
 } GdbCmdContext;
 
 typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
@@ -1504,6 +1506,7 @@ static void run_cmd_parser(GDBState *s, const char *data,
     }
 
     g_string_set_size(gdbserver_state.str_buf, 0);
+    g_byte_array_set_size(gdbserver_state.mem_buf, 0);
 
     /* In case there was an error during the command parsing we must
     * send a NULL packet to indicate the command is not supported */
@@ -1716,8 +1719,8 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     reg_size = strlen(gdb_ctx->params[1].data) / 2;
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
-    gdb_write_register(gdbserver_state.g_cpu, gdb_ctx->mem_buf,
+    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(gdbserver_state.g_cpu, gdbserver_state.mem_buf->data,
                        gdb_ctx->params[0].val_ull);
     put_packet("OK");
 }
@@ -1736,14 +1739,17 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    reg_size = gdb_read_register(gdbserver_state.g_cpu, gdb_ctx->mem_buf,
+    reg_size = gdb_read_register(gdbserver_state.g_cpu,
+                                 gdbserver_state.mem_buf->data,
                                  gdb_ctx->params[0].val_ull);
     if (!reg_size) {
         put_packet("E14");
         return;
+    } else {
+        g_byte_array_set_size(gdbserver_state.mem_buf, reg_size);
     }
 
-    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, reg_size);
+    memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, reg_size);
     put_strbuf();
 }
 
@@ -1760,11 +1766,11 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
+    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[2].data,
              gdb_ctx->params[1].val_ull);
     if (target_memory_rw_debug(gdbserver_state.g_cpu, gdb_ctx->params[0].val_ull,
-                               gdb_ctx->mem_buf,
-                               gdb_ctx->params[1].val_ull, true)) {
+                               gdbserver_state.mem_buf->data,
+                               gdbserver_state.mem_buf->len, true)) {
         put_packet("E14");
         return;
     }
@@ -1785,14 +1791,17 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
+    g_byte_array_set_size(gdbserver_state.mem_buf, gdb_ctx->params[1].val_ull);
+
     if (target_memory_rw_debug(gdbserver_state.g_cpu, gdb_ctx->params[0].val_ull,
-                               gdb_ctx->mem_buf,
-                               gdb_ctx->params[1].val_ull, false)) {
+                               gdbserver_state.mem_buf->data,
+                               gdbserver_state.mem_buf->len, false)) {
         put_packet("E14");
         return;
     }
 
-    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data,
+             gdbserver_state.mem_buf->len);
     put_strbuf();
 }
 
@@ -1807,9 +1816,9 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     cpu_synchronize_state(gdbserver_state.g_cpu);
-    registers = gdb_ctx->mem_buf;
     len = strlen(gdb_ctx->params[0].data) / 2;
-    hextomem(registers, gdb_ctx->params[0].data, len);
+    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[0].data, len);
+    registers = gdbserver_state.mem_buf->data;
     for (addr = 0; addr < gdbserver_state.g_cpu->gdb_num_g_regs && len > 0;
          addr++) {
         reg_size = gdb_write_register(gdbserver_state.g_cpu, registers, addr);
@@ -1826,11 +1835,14 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     cpu_synchronize_state(gdbserver_state.g_cpu);
     len = 0;
     for (addr = 0; addr < gdbserver_state.g_cpu->gdb_num_g_regs; addr++) {
-        len += gdb_read_register(gdbserver_state.g_cpu, gdb_ctx->mem_buf + len,
+        len += gdb_read_register(gdbserver_state.g_cpu,
+                                 gdbserver_state.mem_buf->data + len,
                                  addr);
     }
+    /* FIXME: This is after the fact sizing */
+    g_byte_array_set_size(gdbserver_state.mem_buf, len);
 
-    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, len);
+    memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, len);
     put_strbuf();
 }
 
@@ -2003,7 +2015,7 @@ static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
     cpu = get_first_cpu_in_process(process);
     g_string_assign(gdbserver_state.str_buf, "QC");
     gdb_append_thread_id(cpu, gdbserver_state.str_buf);
-    put_strbuf();;
+    put_strbuf();
 }
 
 static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2015,7 +2027,7 @@ static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
 
     g_string_assign(gdbserver_state.str_buf, "m");
     gdb_append_thread_id(gdbserver_state.query_cpu, gdbserver_state.str_buf);
-    put_strbuf();;
+    put_strbuf();
     gdbserver_state.query_cpu = gdb_next_attached_cpu(gdbserver_state.query_cpu);
 }
 
@@ -2058,7 +2070,7 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
     trace_gdbstub_op_extra_info(rs->str);
     memtohex(gdbserver_state.str_buf, (uint8_t *)rs->str, rs->len);
-    put_strbuf();;
+    put_strbuf();
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -2079,6 +2091,7 @@ static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
 #else
 static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    const guint8 zero = 0;
     int len;
 
     if (!gdb_ctx->num_params) {
@@ -2093,11 +2106,12 @@ static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     len = len / 2;
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
-    gdb_ctx->mem_buf[len++] = 0;
-    qemu_chr_be_write(gdbserver_state.mon_chr, gdb_ctx->mem_buf, len);
+    g_byte_array_set_size(gdbserver_state.mem_buf, len);
+    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[0].data, len);
+    g_byte_array_append(gdbserver_state.mem_buf, &zero, 1);
+    qemu_chr_be_write(gdbserver_state.mon_chr, gdbserver_state.mem_buf->data,
+                      gdbserver_state.mem_buf->len);
     put_packet("OK");
-
 }
 #endif
 
-- 
2.20.1


