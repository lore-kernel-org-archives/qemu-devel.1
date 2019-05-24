Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E53C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F9120675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqi7gUts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F9120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57091 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCrQ-0007yw-9F
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:16:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdn-0004D3-NX
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdl-0002Dj-Pe
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdf-00024A-HH
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id 15so9728731wmg.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0K6XJDL6BHpBdzcJvkw9ibcDs824edt12MdOLNnZMaI=;
	b=sqi7gUtstUuOrGxyZdWPlvRtpQ0YniOVr/ragnGrFcgQ5iXBWqPJj1kJHcocn5Ql9a
	fE0xCOXpYqtjGTvDY7nW4wL1nbQouZ+KlAenRfs1h+TXryyIHWwUhp8xs5reJv5Nt5ID
	O8A/DwO5bygT3SxffQutIOWD8x+t1rdBaYgfoNcJdxdq0FRIG8uZT2TRm3udQm4qJSGr
	OTiwa8gySkl9qyv7GuoeybytEHTEUnB5eX0ZnSUfqiOVRBSN2xlkReJCByLCUzhhU1iW
	B4HmgCdqoOBWIuewFSZ1TjVO+hd9+yTR6IAcw+FdGKJbRP62bhLOjzuOZH6lX/rkRmrc
	dNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0K6XJDL6BHpBdzcJvkw9ibcDs824edt12MdOLNnZMaI=;
	b=LOi+W4x1QBBOYt1Qbu+AC946z23DCb7WjSxutpQDxcYE3TvycFEXFgFbGLBqTzzg80
	uy9OiuB3frSzXtgIebbG0VAR0s1dqXUqkiMi+ZssNETK3Yh6iNR+tmcRFcXgMWAEiJ3R
	92aToMVSxbYSXD0zDZmNT7FMZhUJoJNKMp4wHnlsN+lUVX8GQWKMoipXSHF0PrtVxqDs
	wwc3OfkMfDjP3KLELgjLu5OH0fyNsvl1HJmLL5LW1wECh86Sn62NNhhV5/QZEGRhtoVe
	dkf2LHJ9+HT8UD6eT5jCcQe26RJAjVyzE9vZhUEkNx9aWL2tiE3oPOfnkeDUk3HLfiJ/
	ze3g==
X-Gm-Message-State: APjAAAXL5I7u+0lIdCiKkFgfJapJ+hrxtjn6bPl2BkAHOfEiWujxNnCr
	6AO8DcVzAQCCIVsJhNefyMUT/fy7
X-Google-Smtp-Source: APXvYqxyMjn/Hox80gl35AgKS1irbyjjZ8Z90f+3TXUH9F83pAsKP3PMjn1UhEgp6hOzwEPrxKXqAw==
X-Received: by 2002:a05:600c:ca:: with SMTP id u10mr398443wmm.33.1558713705120;
	Fri, 24 May 2019 09:01:45 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:44 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:11 +0300
Message-Id: <20190524160118.31134-14-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v11 13/20] gdbstub: Implement read all
 registers (g pkt) with new infra
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

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 1afad31b49..781f5882ac 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1760,6 +1760,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1767,7 +1782,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1926,14 +1941,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.21.0


