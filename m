Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D596EC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D4D208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWzJofJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D4D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZC0v-0007hW-Gi
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45040)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB53-0008FW-91
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4y-0005oG-1Q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB4w-0005iY-2Y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id t5so1185482wmh.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EGXlq8sYJb23DS1OyTu+2jMnILwAaOcvzkQgAo0cZYs=;
 b=XWzJofJLXnCEgbUUrFCam5HYaNJxWOO/HBzfYzerV0Vx0IOq/UQjEDZ9fOHBQ72LZP
 sFvv5MjQgvYEDrbfow77xk+vkf7WnRGyP3kzoR2YahFocgMYYikSC17DNhzaznl7I+zw
 vGALIU8Mue+F7yYWKO/L+o6Lk/2bPtFiOYWXljfOzPA9Ix6X8TbGnWqAoWZ3U4wu+hU9
 8K9GWq+6AYxYZeIEFYcR7X9Jh7RBO/+plAEfNwBrjtprob9gM/tKaVf61phGYgBNMG9U
 iTrSZdMlzKip7P9UkdyRmseooy+veUHkIU7wkxoMkAik8JUIFm0YE0t6lrLt/8JhcVg+
 VBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EGXlq8sYJb23DS1OyTu+2jMnILwAaOcvzkQgAo0cZYs=;
 b=OIwvJG2bIlI0frhAy43TyvhZhtekrxkB3MsbmkBzQPqCsryrMql05Ddr9ei9X1G2WB
 BaUFSD8G1VOutRO2fQpgiYw3iORojTKLH/HX6S1esgMtxg9+qjW3lPsv/RgBfol5ub7i
 iwAWYLe3tNOs9WCtI8KLJrOCZ3XEkQ6yp6NTDLPasGnXe5NAhfFlrnFFaTHvDrP23KHT
 lCEiccQT8t4XTCnMIF6BdyL1adDsYz1gFsgAyD4HB/Vjn61tLEN9pPHk5dJbga8xH6XY
 x4WQxCnuuD8uh2GBXoowuFuEI/XCkI8RU1RuWfNsHdB7DtnsKUxF2SUrCHqQP4k+K6yC
 93cw==
X-Gm-Message-State: APjAAAVp2dauSixSYUvW1xjqr9H4YsuYVs9VALBC6JZ4sq9sYzEGBSeO
 NQ7qofEhx9MyEvyZ4Klm3osf+g==
X-Google-Smtp-Source: APXvYqxxu5VOEpq/N+NnxKkALq1qC8lKKIUKcT1X15MbWMnt+AKGjWeyRzgRlWO+gt4F4e/sLarWMQ==
X-Received: by 2002:a1c:968c:: with SMTP id y134mr2712946wmd.122.1559899347983; 
 Fri, 07 Jun 2019 02:22:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g5sm1720611wrp.29.2019.06.07.02.22.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F39971FFBD;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:36 +0100
Message-Id: <20190607090552.12434-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 37/52] gdbstub: Implement continue with signal
 (C pkt) with new infra
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
Message-Id: <20190529064148.19856-6-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index c3089a6b5a..3425f0674d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1541,6 +1541,25 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    unsigned long signal = 0;
+
+    /*
+     * Note: C sig;[addr] is currently unsupported and we simply
+     *       omit the addr parameter
+     */
+    if (gdb_ctx->num_params) {
+        signal = gdb_ctx->params[0].val_ul;
+    }
+
+    gdb_ctx->s->signal = gdb_signal_to_target(signal);
+    if (gdb_ctx->s->signal == -1) {
+        gdb_ctx->s->signal = 0;
+    }
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1588,11 +1607,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'C':
-        s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
-        if (s->signal == -1)
-            s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        {
+            static const GdbCmdParseEntry cont_with_sig_cmd_desc = {
+                .handler = handle_cont_with_sig,
+                .cmd = "C",
+                .cmd_startswith = 1,
+                .schema = "l0"
+            };
+            cmd_parser = &cont_with_sig_cmd_desc;
+        }
+        break;
     case 'v':
         if (strncmp(p, "Cont", 4) == 0) {
             p += 4;
-- 
2.20.1


