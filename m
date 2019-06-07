Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7FAC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912E7208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5DsfHhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912E7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZC1t-0008Vc-UY
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB50-00088e-LP
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4z-0005rQ-E6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:54227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB4z-0005pc-7z
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id x15so1269377wmj.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gr42vRKrUtGXl0PC7wlu1Mzbd+6iYUnnF6QdAndqlX8=;
 b=d5DsfHhzjtaYyKNtHVkGf4bnxjwVq0P5yRswjrck/XRMWVAYDPbbLpQBkQpYdRLH7k
 QH2U1DVVNtsEG11zrz6foyBSgOPhsWBqSHoAIZTjSzWFyGXAgIKGGtkymKSnPDBro/Zj
 fMFOKrO5lJPFMkfscpfnlfBzFVakQVpLRXIeArUUVC4poiht+owWAjTP1oSqknpNERpc
 ZW6EKhqJy7XS3zdhYNPr/p9+fXX2BTWM8eg70gmwYS6ghXWrtsrcbdDeFEO2qNhQMRc5
 Xji7OxADG7OORLOCYhQ3Dp6SYMqg1PMz/zQ1vDCB7FwuoFsjn6ftTMeIV3d4P9Wl9Tiz
 vg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gr42vRKrUtGXl0PC7wlu1Mzbd+6iYUnnF6QdAndqlX8=;
 b=PeAE3+r8x8LduxKAI0Pe8w0CCl65Jt2up/nepHOzgynMu5+Yyld7srLreDPvqCFy1v
 L52rYbFicD5C3skHAaDzgGNZQts7GxzzfLSVun+z234UBq39OtphiEK8+n2V+TDHyBgd
 mymIflxnDs39/k3YZrUSFCsz/c2oBvXdTv/x2rGmm0ZwVr9MXcBd8sTzfj8U0/qZZklL
 4QCKqag8dCtcsnayRlhQpf+RBceY22v5SbsjchkJ2SoLjtFtoWYgNo8rMQeDgSL8XwpN
 iWFYwcZb2QYutyt9Ec0GkroHTiyixVPmuwbZKatcCZDkLeYs8oz1s6xZRbX6p2xBRM6P
 yhIA==
X-Gm-Message-State: APjAAAVK7Kb4312w5lh0vN9OJvvSWGgD8oG3qWC7xnFOIMFe93/5m/Y9
 KKisLvOmMsAjVVgzwNyOiZ8zwA==
X-Google-Smtp-Source: APXvYqwkV/iSmoxaToCtV+B+EAHSy/nXBBCMzL1kiMEp/KdV5QjZ0ZUtbmiez9xmgfK1ti40+HWQMQ==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr3085392wmk.67.1559899352168; 
 Fri, 07 Jun 2019 02:22:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c12sm1223966wmb.1.2019.06.07.02.22.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A886A1FFC5;
 Fri,  7 Jun 2019 10:05:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:45 +0100
Message-Id: <20190607090552.12434-47-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 46/52] gdbstub: Implement file io (F pkt) with
 new infra
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
Message-Id: <20190529064148.19856-15-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index b3c5ced80d..1871077cd7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1789,6 +1789,25 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params >= 2 && gdb_ctx->s->current_syscall_cb) {
+        target_ulong ret, err;
+
+        ret = (target_ulong)gdb_ctx->params[0].val_ull;
+        err = (target_ulong)gdb_ctx->params[1].val_ull;
+        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
+        gdb_ctx->s->current_syscall_cb = NULL;
+    }
+
+    if (gdb_ctx->num_params >= 3 && gdb_ctx->params[2].opcode == (uint8_t)'C') {
+        put_packet(gdb_ctx->s, "T02");
+        return;
+    }
+
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1930,28 +1949,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         return RS_IDLE;
     case 'F':
         {
-            target_ulong ret;
-            target_ulong err;
-
-            ret = strtoull(p, (char **)&p, 16);
-            if (*p == ',') {
-                p++;
-                err = strtoull(p, (char **)&p, 16);
-            } else {
-                err = 0;
-            }
-            if (*p == ',')
-                p++;
-            type = *p;
-            if (s->current_syscall_cb) {
-                s->current_syscall_cb(s->c_cpu, ret, err);
-                s->current_syscall_cb = NULL;
-            }
-            if (type == 'C') {
-                put_packet(s, "T02");
-            } else {
-                gdb_continue(s);
-            }
+            static const GdbCmdParseEntry file_io_cmd_desc = {
+                .handler = handle_file_io,
+                .cmd = "F",
+                .cmd_startswith = 1,
+                .schema = "L,L,o0"
+            };
+            cmd_parser = &file_io_cmd_desc;
         }
         break;
     case 'g':
-- 
2.20.1


