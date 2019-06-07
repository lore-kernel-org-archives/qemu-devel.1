Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0137C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF0520B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qggzb5Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF0520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBZZ-0002Xf-DV
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42067)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvK-000299-97
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvI-0004iS-AJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:54136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvG-0004d1-95
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id x15so1233511wmj.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mKQZU6ogd55Zge5HtRJs79TkvuWBYPKwIchB5EdBCmo=;
 b=Qggzb5Od3/dWyGwkOoAh+qFgw4boIabzrgi9tfJPj66CYfhxl06rxENpdMtso65NC7
 4U1xufQH6hwR7vvZ0l7q01PAgdeNS6enF5kxDgvxO2+fYDn9ofvxMu35L7JREP1FNpO2
 RAokO4pYNoF3003yCqNVnbLTelpOWqDISmuIbKG4uSda9vUU9kM+io3WQcNrU9CS+T61
 r6xdsCMRtEullg+OsBTcbNA0ZhLo72rJzY4mEM9ZLF8D1Y/JkOWRsmkftCn80WFf47dj
 1GxAsNTfJKMil9GWVy7MNlG8dH3yYTUoWhi/cJ3xjUMoppsZ18qVtfrT1t9UGIE4OvLE
 9kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mKQZU6ogd55Zge5HtRJs79TkvuWBYPKwIchB5EdBCmo=;
 b=K7czF6djdFPvjBg8BMSbEsd3haSK5ITDkcyWEUOkcLU3XNRpzrIx+KUl721mJsqEpq
 D4tXjqoMNYnY0zCtV4cVAKg/tcAWgTxM7KGB8zKOXGXcCte1b/GMZYoYv/6dh25QXgBM
 D3LTS8QlIrP2Qot4mlaE1/1P/vPFXETDaPKFP5+KbEJ5lJVA32ll9LQbMlCGpTfzxwD7
 NB2SyEAuMQD0LwzUOQLy6/d7yQ6/qvxRbwwlvNZoJMs9PPPL5UeIPRygKIl+4syNviex
 AiYqy0fFYsCoY3KizIxsnSPQ1HIPj/tp+Qyt25JIvB8bPAd8Lzaopg/1iMWLKDx13cEE
 YC4A==
X-Gm-Message-State: APjAAAV3oiPhW9nrEC2bAfxNT313xkpPUru9gZORD85uwKxlPSzdPkD1
 SqkZaXzP6w7mictRH9JgggfRaw==
X-Google-Smtp-Source: APXvYqzDdqSZHpuMCqEs7w+gYbkknWsH9jyj7s4SD/479qIHuFStqg955Q6w6Pwo5mKhPxSOKhgLpw==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr2788771wmi.146.1559898748529; 
 Fri, 07 Jun 2019 02:12:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x8sm1348899wmc.5.2019.06.07.02.12.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 964161FFC4;
 Fri,  7 Jun 2019 10:05:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:44 +0100
Message-Id: <20190607090552.12434-46-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 45/52] gdbstub: Implement read all registers (g
 pkt) with new infra
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
Message-Id: <20190529064148.19856-14-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 880bbb469a..b3c5ced80d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1774,6 +1774,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    len = 0;
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
+        len += gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
+                                 addr);
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1781,7 +1796,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1940,14 +1955,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'g':
-        cpu_synchronize_state(s->g_cpu);
-        len = 0;
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-            reg_size = gdb_read_register(s->g_cpu, mem_buf + len, addr);
-            len += reg_size;
+        {
+            static const GdbCmdParseEntry read_all_regs_cmd_desc = {
+                .handler = handle_read_all_regs,
+                .cmd = "g",
+                .cmd_startswith = 1
+            };
+            cmd_parser = &read_all_regs_cmd_desc;
         }
-        memtohex(buf, mem_buf, len);
-        put_packet(s, buf);
         break;
     case 'G':
         {
-- 
2.20.1


