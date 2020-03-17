Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE23C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE46D2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVlUAW+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE46D2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFM8-0007x6-0T
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCo-000420-P0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCm-0004An-Tf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCm-000445-L4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id z13so6136154wml.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T0CiFFiWYIaYPKYRBKJcJx8291mmGW0+BGwrLGbj5DM=;
 b=dVlUAW+bq0fqQaimnqyzzZBO/DO3zzFS0V4nYLEc05tUX9r2CRZEZ7ijYbpJS6s6K7
 W9765FKZNyNMlk0THX3LriDxOJ2cCBxsgFfFKLIi8qAZKIg47zI7b1n8zhpZwOrGWdoq
 YzV8t2N+RbxTA7EsRWGNMsKcO2bz6Pwt7KScCC6VPWsx3d2dCuv/Vx778DxHsIY53/uX
 QPwiy4F7OPCEgOSMTjaEKqwe2cOaR384QHupu/v5Ve6/DtQoQ702fuRYePN0o3xuq2+F
 K+gCjDk5BC/0eLnL3WWCLi6NlvYwqcQgVBXarhEVfh+Tz2VN65vdoD12f1VyGt8qkM5s
 MTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T0CiFFiWYIaYPKYRBKJcJx8291mmGW0+BGwrLGbj5DM=;
 b=ekPOSJxbC1b63ZCgKStZnNP8nvDad2xWcdICH/T0PmEIN6Vq/F5i5lwas8QxhJUe6O
 DKH1PmgTa2uOi+4yJw7yBI5nAdMo5jboxtCfmewL+dz0SUHoS8AKI5AEiQVDEy0MrQAk
 qcGnKwHNipFpAs9KUGGqR2nC+4Nr4mi9E+4oLcHejKWp2zgpylub6cEtI/f+HCAoWNVm
 sStpDKkSEg2rNf0LC3SQ8UGr7dqIwUxhfJ4xy3j7SfV9nMGN41B+2DqxRqYujVdvVoFO
 st9KR9QmjVFI48jHKQKOXKCd8ijarGiRCJj7rKQZzssdnqu9+FIylr1uhiUWnPZI58zo
 mjOQ==
X-Gm-Message-State: ANhLgQ013OppKrQiWwTq+oWKkUAuSnSwI0z9rdBZ8LIimRKhu8xZEdzH
 s4Z/xpmiYAIKACUnnANSv5Rds3qZ
X-Google-Smtp-Source: ADFU+vvuF0MIbiehFjIvk2RyW9VAOtipQBMe/iSeKTTdSiPULBYopShQ0WSmPqeolN0vy7qmcdPXmg==
X-Received: by 2002:a05:600c:14d5:: with SMTP id
 i21mr167586wmh.82.1584462993256; 
 Tue, 17 Mar 2020 09:36:33 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b202sm4618697wmd.15.2020.03.17.09.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 09:36:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/13] target/rx: Collect all bytes during disassembly
Date: Tue, 17 Mar 2020 17:36:14 +0100
Message-Id: <20200317163616.30027-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317163616.30027-1-f4bug@amsat.org>
References: <20200317163616.30027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
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


