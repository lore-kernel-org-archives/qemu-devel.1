Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8894CC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFB5208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIcOGZZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFB5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZC2f-0001Q4-Lr
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB56-0008RI-Qz
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB55-0005zq-NQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB55-0005yv-Gh
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id p11so1397318wre.7
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cMrj3E5Bd95PqGJENY32z7PQs37HAPouZyZmhNIb23k=;
 b=tIcOGZZ8/013NtHbCCUeLcIfcab86vNwBY9Ku2yiozOl7Zmo8ObkRNm+umUC0wB4sq
 mo0Y/lTSlCUDyyWANdrwVGvWnOic1VnJLAgxVL+/cRlpAmp5JvZCxa3QTXJ9qyu4HGZS
 pLYqcC3D6MgrxVD3Y5+IXqHiI+EZDxInvn7901FErXujILsNhTAHMdaPafyXrJWcD8V+
 a+gNbYjpdpuG/kAGLvGu9dRZuZDw0Yu3WVqCq7m4SVyrwGYV6QMYhdclFJ9VF1c/q4sS
 K/L0nGPZN5I6tiUMW+HO5oS0qsXU/hmyt34OCm5d8o9g0lCQo1CzXy79eE8bN751Pu4H
 k0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cMrj3E5Bd95PqGJENY32z7PQs37HAPouZyZmhNIb23k=;
 b=K09Qjmx/hLkZ2OfsuDnmAaNCte1Muh67OMSx5It/x4zjNva/pzouRrnRuMXGfnJNlk
 OOVDvyeDRxcRBDTzI2Bi6UHPQ6+xi+33H/8ddJZVWIbac6plqYg9nwsCtpr2TB4j73Db
 pc7gkf4OKnnfsuQdG68avhrkiv6vfgRkp/Ec3+cl/k+yCmfnWKZ3CroCwewQGo7PQYXX
 rytGlS2RQTwwdk5FlH2LyFe3VsPKJGAexQ9c2PxYhzvnYzOO5rQubqxEeFwvHjL4LMJc
 JDQgl5Hg8YPEM/r6fTwLwrTUJvUCrp5Qkd/hW2Q9MQUf6XYuc6a61pBxjSqWkZB1rACM
 uizQ==
X-Gm-Message-State: APjAAAUJxkNbgvbXx/abh7GZXw/qZBIDsWOFCcwxY8+Bh5pxHObKNv3e
 vyi9XwCZ6vkB6w41/5DbfIU5yg==
X-Google-Smtp-Source: APXvYqwK/gbb0dTaAEvNTs4POZ712fOKUn6ZnxyHhMXhYOrA44O7gbThDNeKROW42K4NYCBBdSbERw==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr18362010wrw.10.1559899358447; 
 Fri, 07 Jun 2019 02:22:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p2sm1583377wrx.90.2019.06.07.02.22.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 263A91FFBE;
 Fri,  7 Jun 2019 10:05:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:38 +0100
Message-Id: <20190607090552.12434-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 39/52] gdbstub: Implement breakpoint commands
 (Z/z pkt) with new infra
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
Message-Id: <20190529064148.19856-8-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 7735c244b3..8416f4c13f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -950,7 +950,7 @@ static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
 }
 #endif
 
-static int gdb_breakpoint_insert(target_ulong addr, target_ulong len, int type)
+static int gdb_breakpoint_insert(int type, target_ulong addr, target_ulong len)
 {
     CPUState *cpu;
     int err = 0;
@@ -987,7 +987,7 @@ static int gdb_breakpoint_insert(target_ulong addr, target_ulong len, int type)
     }
 }
 
-static int gdb_breakpoint_remove(target_ulong addr, target_ulong len, int type)
+static int gdb_breakpoint_remove(int type, target_ulong addr, target_ulong len)
 {
     CPUState *cpu;
     int err = 0;
@@ -1605,6 +1605,52 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params != 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[0].val_ul,
+                                gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
+static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params != 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_remove(gdb_ctx->params[0].val_ul,
+                                gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1860,24 +1906,26 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'Z':
+        {
+            static const GdbCmdParseEntry insert_bp_cmd_desc = {
+                .handler = handle_insert_bp,
+                .cmd = "Z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &insert_bp_cmd_desc;
+        }
+        break;
     case 'z':
-        type = strtoul(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (ch == 'Z')
-            res = gdb_breakpoint_insert(addr, len, type);
-        else
-            res = gdb_breakpoint_remove(addr, len, type);
-        if (res >= 0)
-             put_packet(s, "OK");
-        else if (res == -ENOSYS)
-            put_packet(s, "");
-        else
-            put_packet(s, "E22");
+        {
+            static const GdbCmdParseEntry remove_bp_cmd_desc = {
+                .handler = handle_remove_bp,
+                .cmd = "z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &remove_bp_cmd_desc;
+        }
         break;
     case 'H':
         {
-- 
2.20.1


