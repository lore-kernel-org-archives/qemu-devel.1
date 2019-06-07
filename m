Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF6FC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AD3206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vj2US+qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AD3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZC77-0003aA-4F
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45000)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB51-0008AF-6a
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB50-0005sX-1O
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB4z-0005qj-PR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id c6so1192218wml.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s9ykN90cdyqM5hfEHGBlKQoeXXY56iNyeD+K4udZ73Y=;
 b=vj2US+qPlr/1a88Hkvj1ieEJKJI9eddVak3pwQR7q3BR53iXEv+sKGuzgN+aaPus1E
 qsE4KSi4C29159YPVRjSp99hoyXU93wXCHoSv1qHOdj5O3m10VXhYfMYmjrfLyOzNTPV
 8aWwIp8RU0e5spGoTms1RAb2kr3R3ETJx5k+MaAENiWDQ7tWJkjD31LbPm52moHy3ii1
 WUI/z93TrSawfxphGXzlF1rp9xjoIQhGcXZRz1tnAdtMsA0fy02OoIyK/0Cxi5K35JVs
 7bjF+iWptPJcngEWmpvpOimgdekQXwM3ptvpozzOZ5bS5aKbJr41USbA5pDhnl7doEko
 J7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s9ykN90cdyqM5hfEHGBlKQoeXXY56iNyeD+K4udZ73Y=;
 b=JlDYFFJZlDeItjgNSM3Np2381BxKktbO0x88UFPj40dvwULhnbeUe0aCf9QvjRhlBS
 6LhNogoRBUyRTUeOt3jFX4wk+dNZymUMAp9NsBs7TfP/UY5FNqffBBw90ggymaWcEhn7
 SocFQzVDsxHhyQ01IeuOO0omi5GWGaiejzVE+yMbDC3yNupkco9H69AWWj5dRnO74uXT
 toqxoM91geSiTatXcF42IIlp3V62EJCbeFWdd7aktgNSHbkKZpOc/FPXw11u9a0t5B19
 CM+6Qy6qFEcYQfdIFDu5Oz6BLIXkxhAaZ80UqKZDINIlMmm+MO2PQBKimKc+ubEH8gyh
 Y9rA==
X-Gm-Message-State: APjAAAWp6T2ixGfvdWnXIKY7haKYZEzMJItjCjAKDv5kcAHSZKzZPC+b
 7i2VXhvPpbzlX3KNeNBGvS7ijA==
X-Google-Smtp-Source: APXvYqyU/ikzJVHy/ozLnGPVtC3fRWm82+W3HCUQK465k+CTfa68m8aUUZqnpBCHS3NwrJnsMn8pfg==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr3064252wmh.81.1559899352706; 
 Fri, 07 Jun 2019 02:22:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n5sm1298995wrj.27.2019.06.07.02.22.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BC2901FFC7;
 Fri,  7 Jun 2019 10:05:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:46 +0100
Message-Id: <20190607090552.12434-48-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 47/52] gdbstub: Implement step (s pkt) with new
 infra
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
Message-Id: <20190529064148.19856-16-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 1871077cd7..6fd276892a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1808,6 +1808,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
+    }
+
+    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1940,13 +1950,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry step_cmd_desc = {
+                .handler = handle_step,
+                .cmd = "s",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &step_cmd_desc;
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'F':
         {
             static const GdbCmdParseEntry file_io_cmd_desc = {
-- 
2.20.1


