Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C440C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D51B20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMXahHkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D51B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBZR-0002Hn-C5
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42213)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002Fj-CU
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004yK-H9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004u1-8R
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id v14so1370430wrr.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HpSzE7CRb/eTzWpNX5jhhMANtC+sz7VcxjFAzL6p7RU=;
 b=EMXahHkm/lYzmnDZ4m+7jNA0Wckplr5O2W/TMPEy5U9x5UeyTxZKGMW6jCQvjD6syn
 u26n19W82p+tMxMG1xljUy2xVzJNkb5/8HVwwHgmCbgviJ7n3SjUxvYYeMGZYGsvIxAH
 Caxdcrs9ycDtl14FPmU7pV4pzne9/Hv36XkDnp0djuebva7rPuxOs0B2bsAgqP4i+pjU
 6HYAA+Fook6yGgfgccufNBEBMaaqyGipXAhcCEtKIMsHbdGVEphCMi5Vw4GtdkjjafvY
 n1LrC2cIjVx6MeRzOlqd2nD50Tx+JDiI3fmreDCCaLDH8eiFWH3L0nH4s3b8p7jW4ozn
 2Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HpSzE7CRb/eTzWpNX5jhhMANtC+sz7VcxjFAzL6p7RU=;
 b=hJHFkH3w/mWPSkejfg8rFCs3i59qCGIyVYL0g5r11Plt+7GNPKnVpkdHcpiMNqJ/6b
 u8OIpcHXLYzYAl94ksPacTs7abl+aHxVG9nK03ydrHAk7+VQGE0+yKZJWKsMboQBI2kS
 pOjb04wsxReOwqDTIv2AEg1ZQ07Ak90RrChQzAnrYVZcrsRNxz3Xp14bIjIWN8yyDRYN
 hI87mYY/gvJDpW6jmT17lhL5tuhbP7wFVMnP5OFXKGCzB4ONlipbqGwUvCR1HxQPXuDl
 W4lLqkryccA2jggx1346ELiUcP8mdMitISm3hWaHY0F+g29jVq8nN59ZkrtRXgZXolNg
 TxIA==
X-Gm-Message-State: APjAAAVwtZx1Ky3GXUsCC8E6rdwfyACnRb2RslNPpO6tnAExabCem2Qk
 Tch1h6bph3j5pHMIlvdVZv0/xQ==
X-Google-Smtp-Source: APXvYqyKvdDoTDQUuxjr6ZorstWK2SR9u88SaCpYTKhtO0vdFpjQycjuWYOkUgUrPSh80ySd7WaAmg==
X-Received: by 2002:a5d:638e:: with SMTP id p14mr3203837wru.238.1559898758476; 
 Fri, 07 Jun 2019 02:12:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u205sm1279667wmu.47.2019.06.07.02.12.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 713591FFC2;
 Fri,  7 Jun 2019 10:05:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:42 +0100
Message-Id: <20190607090552.12434-44-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 43/52] gdbstub: Implement read memory (m pkt)
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
Message-Id: <20190529064148.19856-12-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 681a0c8550..ceaa47d184 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1727,6 +1727,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params != 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* memtohex() doubles the required space */
+    if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, false)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1916,22 +1940,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'm':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, NULL, 16);
-
-        /* memtohex() doubles the required space */
-        if (len > MAX_PACKET_LENGTH / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len, false) != 0) {
-            put_packet (s, "E14");
-        } else {
-            memtohex(buf, mem_buf, len);
-            put_packet(s, buf);
+        {
+            static const GdbCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_mem,
+                .cmd = "m",
+                .cmd_startswith = 1,
+                .schema = "L,L0"
+            };
+            cmd_parser = &read_mem_cmd_desc;
         }
         break;
     case 'M':
-- 
2.20.1


