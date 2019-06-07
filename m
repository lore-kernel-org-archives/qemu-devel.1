Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D43C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1F820B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OclLWVAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1F820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBiV-0001e2-CP
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42199)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002FK-A0
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004yo-Nd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004oP-CM
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id c6so1161751wml.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nMFCZfwkMlDoG7F9uNweZDiNnzGq2iNoqNGA+iU0AVQ=;
 b=OclLWVAtK+ADY39NWGpm9RLDld2yzN2AgU9shKcm6B/5ibkaTGyxl45lqCZQdxWImG
 PROEd8OsxTfmUQ99KUqhIGdYoZfwsjSvHA5hcxnoqORP7aE6l/tSWqgNYf0yWbn+ghdw
 jv2m6p+lGlbmBg3EG7TiJU390nTVHRgBBeXdEnYDGRDruZMlX/zYHq6xU2iBYC7PMOIS
 ZmQ7Ehi8avrySxFxWNOhGIb3Hqpztw85225mbMw9UMS5asTj0DTrSeuEqwtSVybpEgvw
 A8dYTrImri1rVl8gKoSViMmpMs97pt7pYqtbeOq6H7PDD1240Qyyn2YD6EGGxinFRv5k
 OrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nMFCZfwkMlDoG7F9uNweZDiNnzGq2iNoqNGA+iU0AVQ=;
 b=gY8MceA7xXltdJdbW9IjteO+17Sp6H40bKKR6/S24wxAPYZCubN+NTdK+69BX3Bz+E
 RXTTALFKz3ZegjHuM2TlLI04c3zWcannWhahSp0EIrFqzIsoFyUIT+o5pU/j4wkBxVGl
 UHErbKh8mxpm2vgMl3EL2s0Iw7l5wsuhyPxxO1sS9qNLoFREr8HelXIpgWPFRlCslSEK
 e0dDSYN3MjVAmzVDTrtg0rpxSvD7b1k9+kdlP7/F79ciS7iula/YIIMHjG4FRBPdSGYd
 R0z4ecokWK5V+sj1CmCwT6+QC+dib52cn4hWb/uaPwaVqpNm//1TJ8HJxIjyloJW8LDz
 sb3g==
X-Gm-Message-State: APjAAAXGRpIs2vWYU/iOBbRMxlaMztOiot1u2zfTGqPg5yzDowvOA/4v
 zQ9hrW1Ty/rSgnUN+lGShnwwk5Lyio0=
X-Google-Smtp-Source: APXvYqzYu35bnL68b4gaK9vDVkpMbmdZoWjH9ckS6+4cMZH2gEMVjq2hyanBkfu6PHCUT6Vg/JspSw==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr3054998wmi.50.1559898755657;
 Fri, 07 Jun 2019 02:12:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l1sm1523446wmg.13.2019.06.07.02.12.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:32 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1543F1FFCA;
 Fri,  7 Jun 2019 10:05:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:50 +0100
Message-Id: <20190607090552.12434-52-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 51/52] gdbstub: Clear unused variables in
 gdb_handle_packet
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
Message-Id: <20190529064148.19856-20-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 26c0c30682..12671e6e11 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2284,17 +2284,11 @@ static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
-    const char *p;
-    int ch;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
-    p = line_buf;
-    ch = *p++;
-    switch(ch) {
+    switch (line_buf[0]) {
     case '!':
         put_packet(s, "OK");
         break;
@@ -2511,8 +2505,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     default:
         /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
+        put_packet(s, "");
         break;
     }
 
-- 
2.20.1


