Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2AFC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0692073B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvCqiyPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0692073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfUo-00055Z-84
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQF-0007JC-3Q
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQD-0002wG-Jd
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:14 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQD-0002vO-AO
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:13 -0500
Received: by mail-wr1-x444.google.com with SMTP id e6so11872751wrw.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BHDxU8iZVrNx1udU01MCyPFAL7yLbjoQGxN2YxYLy1A=;
 b=HvCqiyPT/7hrIDrY6aaFIDF2iJ7jzctrTr8OK0I7TFJZTQYFyhQTh3zcQViU6LEDZh
 66FFkC0JQf+bGeOKaVSyOw1PYJ0CL7dG981uliei2XX+P9gHbjoxIfIg1jlkHKfI5nZm
 LxXBMzNO1zsr2qze3IhzZtJCD6NHdXDVq9WPwZZhDGxQ9V+3sMQACx+pORjECAyt+ACY
 lUxUaHeQQ4cKhx+K9RexOgWMBW/j8Tg6R37iGrafNSTGsth5V0hhP+oM5piqN8g/osb8
 W6+Nbo60nezip82Rnww6K7gQdJvrcZLM0JOvwtR6zPR+JQPqdt24Eqa+SBcxXJ3B6Fqb
 pY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BHDxU8iZVrNx1udU01MCyPFAL7yLbjoQGxN2YxYLy1A=;
 b=Q9sulkDpaeE+8vxvQOGz78oQ+ZzCu6+nidoCc1vYLaQTh2l6Ct1tiEDKzO1m1hbCJo
 67OGpCUCTKeZ80gEQsZtffL5Cq0lEsKRhv4fhzMdX1O7jWpvOiTkw2SFuh0uHaCFx+Ik
 Ej8/xvDZQX3gbslKz/hOKZNaUMDDhXr0PleOx1umosuIVOgMMPP/iaAhcZ+6DDWFWpwJ
 J9ShEaa8WXx1P9vRrRzvD5H6IJnuHQYBBIj9NoR1zqD/a0dLOaYtz4LfsJyWJilGO6NR
 RZYCbfivVYhPmjaqZUdIYSzrCMbOb6xCWE5WwXkmairVwJ4ShAScTsC6zL9D004EdFEb
 /c+A==
X-Gm-Message-State: APjAAAWykJtgX6kiq8G55mktasglOAfD7oRby0Uqub954WyQRGH3doCD
 jcn525XhgDhXDoYgiK/NmBivhw==
X-Google-Smtp-Source: APXvYqyTS4/liqGR8ouxGHECZ58oJTFZqBFXKTE2Zqcp/+t3wstN+y6KnjV4qteEcE2EKDvxNR7vhg==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr13035975wrv.359.1573839012186; 
 Fri, 15 Nov 2019 09:30:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm11580645wrr.88.2019.11.15.09.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 682531FF96;
 Fri, 15 Nov 2019 17:30:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  07/11] target/m68k: use gdb_get_reg helpers
Date: Fri, 15 Nov 2019 17:29:56 +0000
Message-Id: <20191115173000.21891-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115173000.21891-1-alex.bennee@linaro.org>
References: <20191115173000.21891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
---
 target/m68k/helper.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index ae766a6cb0b..70b0c0b5076 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,19 +72,15 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
-        return 8;
+        return gdb_get_reg64(buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(buf, 0);
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
+        int len = gdb_get_reg16(buf, env->fregs[n].l.upper);
+        len += gdb_get_reg16(buf, 0);
+        len += gdb_get_reg64(buf, env->fregs[n].l.lower);
+        return len;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(buf, 0);
     }
     return 0;
 }
-- 
2.20.1


