Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B841EC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BA6217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iI3ODzXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BA6217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOEy-0001mD-OM
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCJ-0004sH-SB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCI-000569-LQ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:43 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOCI-00051I-ED
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:42 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so3639258wrl.13
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5wBDeZKmYofKOsnZiNwMAFl1gvv88UQfd1fG073rc/U=;
 b=iI3ODzXGho/7WybVa4eA7Y35iEqLgJiH8OrYdKE+Gs5gcCCe7iFN2b8oOAYlV2Uamv
 BO3cyKETkW5gE3DRJVgBgoeBk0cpYQ07/p395bJ34nyWbvrBcFDql30+ApJtNWnayXyJ
 dm/nAkdsvq+EcpYC9hWPCmcRy0L3lpvhy0GIXxgsTk9W9gdeJCzmAZsCU3bEWlJAQhFu
 MaHvRNcxHPEvZGysdMoOaTowOUz/EtJxy5y8XGZFw/nrQ2fnIxH3T0GM8wUSVlocp2Ue
 24yk126BraJ3k5gqafEjp7aQTfnMkbObFD721jxzUQfhkTFVJPtQwpwePPjmR3xh0usg
 MN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5wBDeZKmYofKOsnZiNwMAFl1gvv88UQfd1fG073rc/U=;
 b=ESoB79wKn2hPMSm65JtDABYbDCMQfpH0YmpQJ5hxvWOT6owIzvvTVLY32ti8PbzIc3
 U/bwHhiATIZo6SW9Xt6cZzD6R3+yTiwiQ+folzTgwhzoViNC067nRK2O/k1qroueCHXy
 Krhw61gKaXG0HwLMFFbcLe39V9MqtMANOiffU2gD0Yh60qGirhHuvEmyO8tkL6HqFQUE
 WheXjVbYUbHAK7/UO1MmaR/yD8adt7uBavlZaN2wzvlZ7fgbKCZbAhJqMvx4PfAkK1y6
 o2ej+UZdX8efELs+ONptNsgyCiqj6SHDgYiyMYS5nuwv6s1RSy4elDrBIb7wwv2gEP5o
 zTBA==
X-Gm-Message-State: APjAAAVyhTNVVDJt/StBt+Yw1+dMtKx0rsP/mk/5UtdKDQ2hPy3UXFbV
 iOUYrp/1VwfVcSuPyTSYfi3jLQ==
X-Google-Smtp-Source: APXvYqxeQsLxqqkjiiH7s8Dnc7ViFF831HE9iTBTCynzyA6shrqFVATfNssa0SkEoeKSXs9uIm+i/g==
X-Received: by 2002:a05:6000:8c:: with SMTP id
 m12mr30160483wrx.142.1580922641558; 
 Wed, 05 Feb 2020 09:10:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z25sm259904wmf.14.2020.02.05.09.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:10:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 321381FF96;
 Wed,  5 Feb 2020 17:10:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 07/22] target/m68k: use gdb_get_reg helpers
Date: Wed,  5 Feb 2020 17:10:16 +0000
Message-Id: <20200205171031.22582-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
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


