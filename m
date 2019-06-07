Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79ACC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953FD208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+6+TyO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953FD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBqJ-0007hs-TW
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4z-00085k-LQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4y-0005p9-Au
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:47043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB4y-0005mA-1u
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id n4so1372140wrw.13
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6ItlL8HIelf+krBS9v4fi6BpYYbdu3JhklvwiNP6ff4=;
 b=x+6+TyO88zsLJFCXpdRp1Rjin74r2YvB1iOoyZDly6fqezu/e4E7kbHna2yv+Vrf5s
 sgg20+w1NSUWgo0ULRwusjZpQ1QoeWgXy0x2Nu2VzM09rfJc8YKKJjFLvIdyuNrLqDMt
 qeSrlstyvAzaw8Hwq68Nk/oBy9lvLSUBJaih+omjbGTYEsu+tY/Pmvi6KlVrhEXq+Zk6
 7EHdURlGF5hiyfXqPv8HwhyUo3F6Ssl4CabFL245heL7rykmEMkIDTxuQbmuVrBa4DLC
 CZsdouEAgeUKyp80m9xlOFxL7sahcrFtqOVf8DCTFLkajS9yP23oof0zGz41RkMR20p6
 4Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ItlL8HIelf+krBS9v4fi6BpYYbdu3JhklvwiNP6ff4=;
 b=ngpCxVTiHbnyop6F4VE8qLkzxl/szjoIpbPdi9gFZO7M4SeQTkMJ8aOk4ld+26fCHO
 CWhoURYqhPl6hEKYhSqZw0WVHpGHtVS6Kjy78cF8qfOSiM6JKHjpyH6hzE9oA1fqvLCm
 DocX0vFAVPt0b/ZjyXXcFB45ax8zs8pARyOUdhqh+pOMYol8Ki+M16bYRNVRest3XYt6
 Edx9isZiHfUmuZRfVdIm1jGVoHiU4gQsu3hQxjRfnUZZUOh7Kar0lIJoE9bZtVkvZ9PN
 nirk36DgANci9BnT7y/tfqpXVmz/DTbGCw0t8FC4YlCjqPAnlaqkN9wn7rzK/dqm5EaW
 Iy7Q==
X-Gm-Message-State: APjAAAVbUYHDQcD9+7h4qXwNAIk7biPvOsdTpxfl7qYm905/mT5zL+HA
 YSAVscFu7GhsD1mRKy6MwZgWdQ==
X-Google-Smtp-Source: APXvYqzaf9hCDHP1+6kqDMmjMqiT+UgNokZ31O4LeagTzC/M9aCe5HZaXoO3uw3flluaGmqwLrSl9A==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr16425976wrs.289.1559899350160; 
 Fri, 07 Jun 2019 02:22:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p190sm1254631wmp.48.2019.06.07.02.22.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C1BA1FFC0;
 Fri,  7 Jun 2019 10:05:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:40 +0100
Message-Id: <20190607090552.12434-42-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 41/52] gdbstub: Implement get register (p pkt)
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
Message-Id: <20190529064148.19856-10-arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 630f931765..63809b2ab9 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1672,6 +1672,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    /*
+     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
+     * This works, but can be very slow.  Anything new enough to
+     * understand XML also knows how to use this properly.
+     */
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    reg_size = gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                                 gdb_ctx->params[0].val_ull);
+    if (!reg_size) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1901,18 +1931,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'p':
-        /* Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-           This works, but can be very slow.  Anything new enough to
-           understand XML also knows how to use this properly.  */
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        reg_size = gdb_read_register(s->g_cpu, mem_buf, addr);
-        if (reg_size) {
-            memtohex(buf, mem_buf, reg_size);
-            put_packet(s, buf);
-        } else {
-            put_packet(s, "E14");
+        {
+            static const GdbCmdParseEntry get_reg_cmd_desc = {
+                .handler = handle_get_reg,
+                .cmd = "p",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &get_reg_cmd_desc;
         }
         break;
     case 'P':
-- 
2.20.1


