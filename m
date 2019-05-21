Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0A8C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE034217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL9b2Xsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE034217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50623 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1lD-0006Vj-42
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:12:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZR-0005yZ-75
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZQ-0007u7-3g
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZP-0007ru-TA
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id e15so17872168wrs.4
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+NF9Yo7d6jp3qeQ6UNfGvcDfxpGOYkZyN8rNP8o5Qo8=;
	b=VL9b2Xsv/uylVeCYuRqb9dKPxzfF5WehXDN2bOkbi4J1v3j7wWGDBXnAZgv9vPEYkK
	pG5rU/Ek+8mUGPgxDxKeN6PG50oQiOK4wmV9KKTAzm1qyTmqwLNwZjl0bjcB0xSgr0f0
	HetWXbUJHlII75cM3OjPIeRbb0OyCJ91J1RapknfPOSXNOnHmUjClP/C8lTzuyQsKThe
	agwQKgGbG8i4oaM7hTW3yeQups4XJCA9CeFoKucfZnQUFVH9GRSTTjY+eEPg1OnDEnPN
	vTZi/h35T/w2d3Ob7LKMdGEcZ6fReqikSGCRUYjjnP33cbcGqTxxAVwqiD4JhIf6PR3/
	FLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+NF9Yo7d6jp3qeQ6UNfGvcDfxpGOYkZyN8rNP8o5Qo8=;
	b=BRMs0/R4tBwf5JePKd1zmxm5msEWke0GEjRQm6sbQez11F4a2ndmaODL5YKKCSLacg
	5wWRSdEU2ykkzyEqWJhaZnhSHFeK/aKpsydK/lHWOkSTz2ilZqVJA8j8ASgzIQZB6LvR
	3P8JqwUeEu4XayeXKiExG+i6yjqX/WC9/x6GoM3Zx/gj9jhS5CwApH6iYTL5wGiaAI9W
	8Wgam33LuOUONlScUX4/k4itHAeHe3YmWXdS/0owlZzsja0yrrbEwRziIO2hGdab29O7
	qHPLs/IB77FSdQbWGmRC74gdhEKzktj+4HJfEfSkYg7d9yMd595mrNyKKQrFS68G6Px7
	pRYA==
X-Gm-Message-State: APjAAAW2tgkRKR1CqF6dvq94Y1YU8YYpuRLdJph+8xIMn1W8c/Q+tvUZ
	6XPIOMwgOKt9DbFGkSgsb2Jcvx7a
X-Google-Smtp-Source: APXvYqxBqlYCzfNihFixJF+RzsPjYrlGgUqJQ+Jwik/gYbbkylWtZzQV4ZA364FNng8j4gHDrqZmwQ==
X-Received: by 2002:adf:ce0c:: with SMTP id p12mr22873525wrn.19.1558432829914; 
	Tue, 21 May 2019 03:00:29 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:29 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:46 +0300
Message-Id: <20190521095948.8204-19-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v10 18/20] gdbstub: Implement target halted (?
 pkt) with new infra
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note: The user-mode thread-id has been correctly reported since bd88c780e6

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 57a05fd6a4..097b7d1231 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2251,13 +2251,29 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    char thread_id[16];
+
+    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
+                      sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
+             GDB_SIGNAL_TRAP, thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    /*
+     * Remove all the breakpoints when this query is issued,
+     * because gdb is doing an initial connect and the state
+     * should be cleaned up.
+     */
+    gdb_breakpoint_remove_all();
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     const char *p;
     int ch;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
-    char thread_id[16];
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -2269,15 +2285,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case '?':
-        /* TODO: Make this return the correct value for user-mode.  */
-        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
-                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
-        put_packet(s, buf);
-        /* Remove all the breakpoints when this query is issued,
-         * because gdb is doing and initial connect and the state
-         * should be cleaned up.
-         */
-        gdb_breakpoint_remove_all();
+        {
+            static const GdbCmdParseEntry target_halted_cmd_desc = {
+                .handler = handle_target_halt,
+                .cmd = "?",
+                .cmd_startswith = 1
+            };
+            cmd_parser = &target_halted_cmd_desc;
+        }
         break;
     case 'c':
         {
-- 
2.21.0


