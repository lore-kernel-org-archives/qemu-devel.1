Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E86C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AA5206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNhhBEL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AA5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpvl-0000T6-Q2
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMU-0002Lf-BW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMS-0006UL-Bs
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:45 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMS-0006Tr-5p
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:44 -0400
Received: by mail-pf1-x442.google.com with SMTP id 129so1946965pfa.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JhmaAGzRoow6PV3mD1aboEwUvmsUrSNHW6vrm01q9UA=;
 b=eNhhBEL5W3OtD0P4jcvd636YxZSbqIkbtSAji8NqXmO/jUYNdcN9uGXP1MRb9ERTzK
 fV0r8EKdmtiqAxgt8/yiM3hALXwu3wzHOrv7Uo0Mzw4rEdCXzmVKz5p6X1XxX26LJ7By
 3ACWkDpuqkQ3QElmHwAEJedX7ULxqbuAnqN40E7HjVXLsbC+JlIDyBYoApz7DmRgSnN/
 wAAMONm3ToZG7Wme9VvyGZ78D7+GNvQe4ALsZB3KQlj10VfFJ6ua4p57fI8S/JC9S1Ay
 hA/xuwmQC3J7tH4jV5A/6QIs4uOtM+p9sSNGe+xW4kk3M5GDNQnv69xA3VY3ZUo/r22V
 m7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JhmaAGzRoow6PV3mD1aboEwUvmsUrSNHW6vrm01q9UA=;
 b=lTWKWAcqk4EpJ7r3X0yWNCwNn4pCwLxdv3r3mjQ8JNl40eqSvEsneKzaHZlotM9Xci
 8ooFL4PpMUPLUtPfXyUxj9glnMHVQOvJmNGcaebKXYWryJMPfCz15dF6xZJO+Pl9KgRJ
 ImejeSHuISL5j20Hp+lnm9ULl0g1/eBYf3OnqplyJwEwqIKfwc/PGwLJcoHBOb6ILHZr
 v7xspCL4/Cy/x5VSIPcz6/aXiLb7Q7qk6wZI/Iv91mfCljqCJ1I9tXTVjjUcNvjcTZah
 Kg51q6IzJM8lduEMrvoOldORqakdAwDUpDgsrQCuQwHVNyp0HGjiznrsZTodV8xXTi+r
 qi9Q==
X-Gm-Message-State: APjAAAUH31Nj0VHrYhEJkg5IYf0qMq3F7KSwUi95F/d+oKjRNZBFURfF
 qw6uLqp+s7cRTpGTiFLPf2mwmUXpWa4=
X-Google-Smtp-Source: APXvYqxoagVaQD4lMq4gQRlMqh9SI+umOIy27rtVUV3ClakfJ/Hf2+4Q2pNwr8XILBjD+GC3jasvaw==
X-Received: by 2002:aa7:9516:: with SMTP id b22mr26306293pfp.106.1566250722846; 
 Mon, 19 Aug 2019 14:38:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:24 -0700
Message-Id: <20190819213755.26175-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 37/68] target/arm: Convert PLI, PLD, PLDW
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 37 +++++++++++++++++++-----------------
 target/arm/a32-uncond.decode | 10 ++++++++++
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 46e88d1d17..a30a9bb4e0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10136,6 +10136,26 @@ static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
     return true;
 }
 
+/*
+ * Preload instructions
+ * All are nops, contingent on the appropriate arch level.
+ */
+
+static bool trans_PLD(DisasContext *s, arg_PLD *a)
+{
+    return ENABLE_ARCH_5TE;
+}
+
+static bool trans_PLDW(DisasContext *s, arg_PLD *a)
+{
+    return arm_dc_feature(s, ARM_FEATURE_V7MP);
+}
+
+static bool trans_PLI(DisasContext *s, arg_PLD *a)
+{
+    return ENABLE_ARCH_7;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10196,23 +10216,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             return;
         }
-        if (((insn & 0x0f30f000) == 0x0510f000) ||
-            ((insn & 0x0f30f010) == 0x0710f000)) {
-            if ((insn & (1 << 22)) == 0) {
-                /* PLDW; v7MP */
-                if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
-                    goto illegal_op;
-                }
-            }
-            /* Otherwise PLD; v5TE+ */
-            ARCH(5TE);
-            return;
-        }
-        if (((insn & 0x0f70f000) == 0x0450f000) ||
-            ((insn & 0x0f70f010) == 0x0650f000)) {
-            ARCH(7);
-            return; /* PLI; V7 */
-        }
         if (((insn & 0x0f700000) == 0x04100000) ||
             ((insn & 0x0f700010) == 0x06100000)) {
             if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index d5ed48f0fd..aed381cb8e 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -54,3 +54,13 @@ SB               1111 0101 0111 1111 1111 0000 0111 0000
 
 # Set Endianness
 SETEND           1111 0001 0000 0001 0000 00 E:1 0 0000 0000  &setend
+
+# Preload instructions
+
+PLD              1111 0101 -101 ---- 1111 ---- ---- ----    # (imm, lit) 5te
+PLDW             1111 0101 -001 ---- 1111 ---- ---- ----    # (imm, lit) 7mp
+PLI              1111 0100 -101 ---- 1111 ---- ---- ----    # (imm, lit) 7
+
+PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (register) 5te
+PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (register) 7mp
+PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (register) 7
-- 
2.17.1


