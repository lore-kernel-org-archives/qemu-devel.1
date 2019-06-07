Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A810C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9ADE208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGGWbPMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ADE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZC2c-0001HI-8o
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4z-00084G-76
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4y-0005oO-2c
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB4w-0005hl-3g
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:30 -0400
Received: by mail-wr1-x442.google.com with SMTP id m3so1422062wrv.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6p4AOuc6tSqUtkly1124rR3i8VzgPPw2QQg37+GiwQw=;
 b=LGGWbPMPy8kvNxxFhLdei3Ebzjt4NHqzX2b2XzS7za1J/oD6Tk4l+OzLzOQsiguEpG
 JOwErwhTsNXNb2C1PjsdqZ1/+4Y6FULvLUuXS4uIZ5JLtS1azzUfxedKJ4Sk0CMPaTr3
 8DQHLLpI2CY/6ssbU3Rk3UPJ/agK5pi3hWS5dEvHnMZMDvm/DQB7wtTqFGJgPsk7K9Rj
 ZyUwGLf0vfBzOj5JRljOVGnraSjHGQoAhBSk0BIdV9cEf6Oy/CCIwAIC97V4D/wFoGed
 zYPUyCbZGFQM85si4qZg0HTP8dLtnySezCHjHO6CE5Fh933s8btVADuPircn7aIlKBSw
 W5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6p4AOuc6tSqUtkly1124rR3i8VzgPPw2QQg37+GiwQw=;
 b=HTBvGzcT1fwczs3qyzGn8YywKf15Tpalyxht/AvK4oyccvzY587H8HB2R/u2vd8m5O
 lGU9/CKStkWErepgFpxx6586kh7gsgiraoLuFbKcmgQRQ0xof243dIi6OUoAlZC3Br3t
 hyRpXIwZHLaXsfo7nb9BZ205ZTU5SfhgPaxWfcbp2JjXOpHrbMHF07EikkUYukUa9DDi
 lUBKdawKyII1f+2hDNLQY1A8FDrhinNBuzCBwHaZxSk4iJp3/JPBW5z+P07SEWaS6UgK
 EDzS83jLWZ0XgcdqH9Tqrscj5tbNOP2BA6RDMleF0QKNlNz0AC9RoYtB9ZHcp7Tlxo1N
 //Dg==
X-Gm-Message-State: APjAAAVkIAQPMkSAOcEQaYW/xWqS2HizJFTFv3XAqnBzcG4JIqj+rq0i
 SuyNVEG+UGd4mKYSfdeje1IBDA==
X-Google-Smtp-Source: APXvYqwJOk+pkqh43h4lliU9+sRXjy17u5gICefpxIC/iMlyBgzv02nKsZaOEQATWvjcfN4U6gmKoA==
X-Received: by 2002:adf:dc43:: with SMTP id m3mr15729283wrj.279.1559899347429; 
 Fri, 07 Jun 2019 02:22:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q20sm4023504wra.36.2019.06.07.02.22.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:26 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02AF11FFC9;
 Fri,  7 Jun 2019 10:05:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:49 +0100
Message-Id: <20190607090552.12434-51-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 50/52] gdbstub: Implement target halted (? pkt)
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

Note: The user-mode thread-id has been correctly reported since bd88c780e6

Signed-off-by: Jon Doron <arilou@gmail.com>
Message-Id: <20190529064148.19856-19-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index c45cefd721..26c0c30682 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2265,13 +2265,29 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -2283,15 +2299,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.20.1


