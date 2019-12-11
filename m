Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B0C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3DF2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzIE+Q8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3DF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5T6-0007WI-1E
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qc-00056L-Q9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qb-0003Go-GP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:34 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5Qb-0003Fe-8f
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:33 -0500
Received: by mail-wr1-x441.google.com with SMTP id q6so3369014wro.9
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O0Jf5y+8WX2MrhSZ/nUB9xdvSb4JJDgKsTQiepZ4FSg=;
 b=UzIE+Q8mM7wDhVX/ha2hftVjUv3iJf+Le9wn4r0F7M7l7b8NvrQ0kFHVBVDzt7OoCq
 6iGzX2TLYdlQU2te2HNsitzWsQJOTEYRiH5kZtK5RFxeQ1kkxjc8B6aQW02ocFifzFSz
 YTDwduhss6I3qtfLf1e3pfwUyDIXclXOiNDHkbFhEq5CQnlUqXMLrFKPfcS2Is1j8own
 XWysXwE7Wd/ioMRofcybwXG2WxgwhAH+Pvy0VrsrBdwjpqlWPps7cHhjGXWfoPIhdIeQ
 fBJDx+/53jypFH54c9ryBBsoR4PXygJ+2BU3owtFB0qekXSj0F0/QvhbeeVeeg9Usy79
 xD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O0Jf5y+8WX2MrhSZ/nUB9xdvSb4JJDgKsTQiepZ4FSg=;
 b=PUkTUiWDEIiUwNTH/ydAQq/o/9I/AxeeEny9Zcok8cuFm6EVV6WoA3ZKA+Nbh+VjI6
 LGN577YntjjAJ9opB/nij4GRDsp0NtDalJof/v9Ey/tckPt5UrPVM/jRdYgIQu5JzHLI
 fxdxiD+vAU6arpOtY6708a6McTAoJpzxpYk0d/Zer/BAxcX0KeydBR8Mzi3xxZRjHIOa
 pSOJKF9Bm94xtYHp4f8Mtvkm78QCekjQIe0bhCjx9IjRqBr+1P3TodfHrc6ce3UecF+k
 538u6zWfcBjuJpJ1gkNxx3EQ5o0yCkoFIDjrbpBc5rfwnFOlEyXfJGfh74mBKlKF8vid
 24tQ==
X-Gm-Message-State: APjAAAWavexCx1YX9SkjdEjzg4HSPnFHNDyRLs5uXzY8e+FlRZDcVDR9
 DMQov+YlNW7QTNxf7BncR6hI/A==
X-Google-Smtp-Source: APXvYqzT7l5GpaFeNauDMB8XdIhNmDKBz5PiP4YBk+GcZZjCG5jKQngBvaOS44mQ48DGtbkghgEWDg==
X-Received: by 2002:adf:b591:: with SMTP id c17mr881407wre.108.1576083932206; 
 Wed, 11 Dec 2019 09:05:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p10sm3024222wmi.15.2019.12.11.09.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 216F91FF96;
 Wed, 11 Dec 2019 17:05:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 07/20] target/m68k: use gdb_get_reg helpers
Date: Wed, 11 Dec 2019 17:05:07 +0000
Message-Id: <20191211170520.7747-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 alan.hayward@arm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v3
  - fix mem_buf references
  - fix mem_buf + len cases
---
 target/m68k/helper.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index ae766a6cb0b..2573ee7a535 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,19 +72,15 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
-        return 8;
+        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(mem_buf, 0);
     }
     return 0;
 }
@@ -112,21 +108,18 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 static int m68k_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
-        stw_be_p(mem_buf, env->fregs[n].l.upper);
-        memset(mem_buf + 2, 0, 2);
-        stq_be_p(mem_buf + 4, env->fregs[n].l.lower);
-        return 12;
+        int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
+        len += gdb_get_reg16(mem_buf + len, 0);
+        len += gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
+        return len;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(mem_buf, 0);
     }
     return 0;
 }
-- 
2.20.1


