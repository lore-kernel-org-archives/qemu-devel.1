Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC79DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86ADE20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/ZHaq+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ADE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuBu-00049h-OU
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRZ-0000z0-R0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRW-00015y-SV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRW-00011D-Lw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id m3so18986520wmi.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5wBDeZKmYofKOsnZiNwMAFl1gvv88UQfd1fG073rc/U=;
 b=O/ZHaq+4jqJ1zeOhhv8adHC0sTLb41OJphB8gOFfwFNIKK95KvhUhpcoZx1htTfaph
 3EzpkoPgrc92HV79JPkUZe709WIGflu3o5NOD8MYgtFSuI7frK5hb0sI8tg0cN6to/GE
 jH8P5+JC+glZ0b52Za1WCK3Jp4NNo6erz7TTLV5rjwXE8BU0k6j3898SnN5+DLn1X4W+
 rdHqYQH/aPcvPSPwzbT2f1ROyt69pU+Y0IfI1Y25I6w6NC3kIvBX7F8FL3FNLhUuXVCs
 MSY5WSeisnVTkBDbEV832Q2VGMLYYYvHf70kvvGWsablTuYkvKHKlYmN2D6FVNgxzZeb
 jLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5wBDeZKmYofKOsnZiNwMAFl1gvv88UQfd1fG073rc/U=;
 b=BHXpytI6j7bdQK1Xewrw+CYuc3Uwzw5Zy4kH1l4O1KpMSVzNG5ft4RWmds3qmhqR+N
 8+TaPodj6WU7i68IFhEw3huyaHjFFxEW2zZUfxlnYLGN4VhdAzDwKClIun/oc4cI/O86
 HiKiQQawIWQSRULRpiMlh/DQT7xoWtX2UaG/ZjfUlGHZnLKTzsEJCOiM2WTEfpWt2A6V
 VxUB2MmprjyM2KnaujyxzBe8EXYChq1zsmckDy5dJAgwgTjD3D/w9EEHQpoIbQf5bmBN
 Td5MPKWfvpe/RSFJ51slai8+gCAJHh9LUVSumLzr7tYMW5yz//UiLhsni0CGLtln9KPP
 I8fA==
X-Gm-Message-State: ANhLgQ3tU3oDuaBjh0Nw6fRDBQbKXmbSgqeTc2i+po56THJYc10V9isB
 xXoQ9y43gODOwZCUhaKejw0Sng==
X-Google-Smtp-Source: ADFU+vtepgVND9dXrAr3lAHeZb1+zcrFt059iGnfun1ovyDggTxuhLjwSvm26r+2aJzf4HmXxKpT1Q==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr156570wmk.172.1584379341542; 
 Mon, 16 Mar 2020 10:22:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s131sm417588wmf.35.2020.03.16.10.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A6731FF9B;
 Mon, 16 Mar 2020 17:21:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 12/28] target/m68k: use gdb_get_reg helpers
Date: Mon, 16 Mar 2020 17:21:39 +0000
Message-Id: <20200316172155.971-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

---
v3
  - fix mem_buf references
  - fix mem_buf + len cases
---
 target/m68k/helper.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index baf7729af00..c23b70f854d 100644
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


