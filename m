Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A134AC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1AD205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1YgHwmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1AD205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTYC-0002un-IX
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJk-00088E-Ht
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJi-0003Rd-ML
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJh-0003L7-P0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id s5so17917949wrg.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a8zAz9iWkn+7gzsaWAdfIiX2cwmNIeyNTWkgmqsB7IQ=;
 b=O1YgHwmRDlcL2q3Mvm5dtHYKy+CScFTB5SB1mJZMHddv7okzOnT5ZEWL2oMPzC9map
 my8NjX/MdDRdTYYh0WTGbCP4+4rWC55pw/C4Gs4QReAjt4UDYFdEroAYgF6pyMl/hXEB
 WQyfuxOwtCm/JF9v2Zz9BOLXJYCcU60uNzcO6W5fmr+Mu4c/0SrwbCXP6Udt6hfuv4uP
 XRv8/CRrmFi75FHGaqc9Yp/e1XIkV/hB9HeC4OSk6tno7RGDvRS1yYq3RGwIZi6PedFN
 COzFmEhx2PLg8AKuDyKMyAwtO2Lkpx8JgJps3BYfNdXJIU7ha92zliymdDDdprvBoGQX
 nA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=a8zAz9iWkn+7gzsaWAdfIiX2cwmNIeyNTWkgmqsB7IQ=;
 b=gf0QO+1NQS+5YPF6ao8YlGKOuBeznME9MlksrC2EL8SVS07zFFd3v8luscAoJakAt3
 l4sguE5ewsMyMSTHjfxFPIES9zW9u5GTNI+c4gKBawXZ3YPLxY7s04Tok4e+BZ3q2TTx
 0SmXzdO7CxOeynDacNd89XtwcaoP74mYKXdwPACUNV7AW1oFwrDWfMef+27dbc+IoNjX
 4T3uyd17oWFHtWLG8JoyuS+WBqTj+5YRF9k0+p8/RJrE3oamCtE7m3A+hLa3A5J4n2s5
 jArrumCfY9x3K/sJYhFYY11zycpRrI6dV1P3wNe60O+6J54r0e+jrY7Xtgyuca8ZI0NT
 V8LA==
X-Gm-Message-State: ANhLgQ0jhjSyVQsaA6e8bXD87/+NzOYdErg7vunJDDf5HQndV+Ynn8m8
 iY9RQsDusNLLHgJZ1+mJy9krrD1+
X-Google-Smtp-Source: ADFU+vvkA+KtNrnnLUhd7+APeqDMseS390/n31y3R2EEC6qMvdTE59pW41uqKs4wIWwhS9yMgrnCsQ==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr29270735wru.127.1584278912115; 
 Sun, 15 Mar 2020 06:28:32 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/13] target/rx: Collect all bytes during disassembly
Date: Sun, 15 Mar 2020 14:28:07 +0100
Message-Id: <20200315132810.7022-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Collected, to be used in the next patch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-23-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/disas.c | 62 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 814ef97480..dcfb7baf99 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -25,43 +25,59 @@ typedef struct DisasContext {
     disassemble_info *dis;
     uint32_t addr;
     uint32_t pc;
+    uint8_t len;
+    uint8_t bytes[8];
 } DisasContext;
 
 
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
-                           int i, int n)
+                                  int i, int n)
 {
-    bfd_byte buf;
+    uint32_t addr = ctx->addr;
+
+    g_assert(ctx->len == i);
+    g_assert(n <= ARRAY_SIZE(ctx->bytes));
+
     while (++i <= n) {
-        ctx->dis->read_memory_func(ctx->addr++, &buf, 1, ctx->dis);
-        insn |= buf << (32 - i * 8);
+        ctx->dis->read_memory_func(addr++, &ctx->bytes[i - 1], 1, ctx->dis);
+        insn |= ctx->bytes[i - 1] << (32 - i * 8);
     }
+    ctx->addr = addr;
+    ctx->len = n;
+
     return insn;
 }
 
 static int32_t li(DisasContext *ctx, int sz)
 {
-    int32_t addr;
-    bfd_byte buf[4];
-    addr = ctx->addr;
+    uint32_t addr = ctx->addr;
+    uintptr_t len = ctx->len;
 
     switch (sz) {
     case 1:
+        g_assert(len + 1 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 1;
-        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
-        return (int8_t)buf[0];
+        ctx->len += 1;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
+        return (int8_t)ctx->bytes[len];
     case 2:
+        g_assert(len + 2 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 2;
-        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
-        return ldsw_le_p(buf);
+        ctx->len += 2;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
+        return ldsw_le_p(ctx->bytes + len);
     case 3:
+        g_assert(len + 3 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 3;
-        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
-        return (int8_t)buf[2] << 16 | lduw_le_p(buf);
+        ctx->len += 3;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 3, ctx->dis);
+        return (int8_t)ctx->bytes[len + 2] << 16 | lduw_le_p(ctx->bytes + len);
     case 0:
+        g_assert(len + 4 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 4;
-        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
-        return ldl_le_p(buf);
+        ctx->len += 4;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 4, ctx->dis);
+        return ldl_le_p(ctx->bytes + len);
     default:
         g_assert_not_reached();
     }
@@ -110,7 +126,7 @@ static const char psw[] = {
 static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
 {
     uint32_t addr = ctx->addr;
-    uint8_t buf[2];
+    uintptr_t len = ctx->len;
     uint16_t dsp;
 
     switch (ld) {
@@ -119,14 +135,18 @@ static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
         out[0] = '\0';
         return;
     case 1:
+        g_assert(len + 1 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 1;
-        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
-        dsp = buf[0];
+        ctx->len += 1;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
+        dsp = ctx->bytes[len];
         break;
     case 2:
+        g_assert(len + 2 <= ARRAY_SIZE(ctx->bytes));
         ctx->addr += 2;
-        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
-        dsp = lduw_le_p(buf);
+        ctx->len += 2;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
+        dsp = lduw_le_p(ctx->bytes + len);
         break;
     default:
         g_assert_not_reached();
@@ -1392,8 +1412,10 @@ int print_insn_rx(bfd_vma addr, disassemble_info *dis)
     DisasContext ctx;
     uint32_t insn;
     int i;
+
     ctx.dis = dis;
     ctx.pc = ctx.addr = addr;
+    ctx.len = 0;
 
     insn = decode_load(&ctx);
     if (!decode(&ctx, insn)) {
-- 
2.21.1


