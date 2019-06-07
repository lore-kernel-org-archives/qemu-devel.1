Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1A7C46476
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3121208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNe2eiwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3121208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBCC-0006u1-2U
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp8-0004CJ-9c
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp5-0004jb-OI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:10 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAp5-0004aA-H3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n4so1360614wrs.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ugqvq5hjETyvltT2YWuWOJiTLDqqAsBqsH4ZO7PK4SQ=;
 b=yNe2eiwuWZwdjdrXOzN+vDRKbzkIyJRZBMgJCFoyI5loICauyVZ+q92+WM2L/NMn/n
 8EfnyVHoHnPBUVB/lzt+kmrgqBaK7rh3NWL3BJ4xr2QAu2kdg7vSLmHlpo2PyAghXTNi
 YGf16aRjGzCJNqDmeZXfS6SWwav/XqSeR0yhGv5H3l7JSidubmQ8c87eyeZa+DZwjS0t
 xhOirQkGOBQrG756ajz2Ow+wbUmvZJOhqmHZ4pEBKzB4iWOFv4mSBDGzjFn4QnbBlI0t
 Unm2okZmgNh0iRhP5V/3wnGlVvTXIWOZQZ+h5PxXABKg8QtVFCE+QGj8QB5zGwyFfKst
 3Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ugqvq5hjETyvltT2YWuWOJiTLDqqAsBqsH4ZO7PK4SQ=;
 b=NYCpdkTDDA4JxM39UBGmX7Bw3BJU/hBrRkTTHRelBZGRE68158M7bTbJGQ5OXbFK9o
 JxWTgnzY6Mhcvy+XWwZdJrlWDBrRjyzA84/Ba0XlFjtp8pg2pmy+yy5tZRnBWrWKl/jN
 XGZfNQNAlClBWp9DNtZS/HtdQStKyJ+R3qAiVl49LTGHzef9Pk0Rh1ZjBkZIZdhhkwIs
 EYMWrA7PdAnkTOywWlVz61+cSvGJPnbaNPegSubfgASfvjIWii/Bqxyb/dDNzdvKLHyO
 jK9M9WJ/d4gFjpn3sSzrBmFyVi1O2ZC9eYDIeL33qvVOesgvfGRbxUm8P6fL+3qPuREd
 ONBg==
X-Gm-Message-State: APjAAAUpRx5CAxY+EV0e4lUBGgiPxaES3SgY65b0BQSP7EDU5epRfcDb
 AulmAKfzCOugOSqXB3uU239iqg==
X-Google-Smtp-Source: APXvYqwxlsUhn8GoZeKBE6VH+0ALCX3UdPDJq3f1qepyDm63XtACv1KhcZ53UpOZGQ75/66f4bgqig==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr31389680wrr.252.1559898364026; 
 Fri, 07 Jun 2019 02:06:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z17sm1115720wru.21.2019.06.07.02.05.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:06:01 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 130EF1FF90;
 Fri,  7 Jun 2019 10:05:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:37 +0100
Message-Id: <20190607090552.12434-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 38/52] gdbstub: Implement set_thread (H pkt)
 with new infra
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190529064148.19856-7-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 3425f0674d..7735c244b3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1560,6 +1560,51 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (gdb_ctx->num_params != 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind != GDB_ONE_THREAD) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[1].thread_id.pid,
+                      gdb_ctx->params[1].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /*
+     * Note: This command is deprecated and modern gdb's will be using the
+     *       vCont command instead.
+     */
+    switch (gdb_ctx->params[0].opcode) {
+    case 'c':
+        gdb_ctx->s->c_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    case 'g':
+        gdb_ctx->s->g_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    default:
+        put_packet(gdb_ctx->s, "E22");
+        break;
+    }
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1573,7 +1618,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -1836,35 +1880,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             put_packet(s, "E22");
         break;
     case 'H':
-        type = *p++;
-
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-
-        if (thread_kind != GDB_ONE_THREAD) {
-            put_packet(s, "OK");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-        if (cpu == NULL) {
-            put_packet(s, "E22");
-            break;
-        }
-        switch (type) {
-        case 'c':
-            s->c_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        case 'g':
-            s->g_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        default:
-             put_packet(s, "E22");
-             break;
+        {
+            static const GdbCmdParseEntry set_thread_cmd_desc = {
+                .handler = handle_set_thread,
+                .cmd = "H",
+                .cmd_startswith = 1,
+                .schema = "o.t0"
+            };
+            cmd_parser = &set_thread_cmd_desc;
         }
         break;
     case 'T':
-- 
2.20.1


