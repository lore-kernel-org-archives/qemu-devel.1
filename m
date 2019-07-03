Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C9AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ADB2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amRPd7cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ADB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiheR-0005jM-VY
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53155)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hihZI-0002hn-Tk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hihZF-00078s-HL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hihZ8-0006vo-T4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id z23so2960627wma.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m+82LmGiTUR8ft7yGco+ML19JHV1vi8nCqyq/raGSyc=;
 b=amRPd7cNQqjH1DB4/gfYLm89jy4FPHMN4SDAOTlYl49UMvlwIzlxX3i6kWzHPXmiSc
 DjKL/i1ujAS4CCsnKlOMTPnLlTnQHXVoF8BDVBJPFQFoUMEgaPfiDrun/2Na4t5itmvD
 v/6bacFZ8tKCvqrXcua92SnsoRUlVwktfxet3QTAZ4GWlLn9WLAA8oGxuU+J79DSkb7D
 Jt1KbOXQt2I4bI6ow2MGaVttzfG6pRVbr4cj18WVXKpeYjbk4ZkHCh56kzbaZIktY8yl
 M3rKxqPT6yGXUgFJfEwRsP7h0HolWwfR0eI27elV5CciYyJFvmd/mezmV9LOrVJzlYM6
 eXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m+82LmGiTUR8ft7yGco+ML19JHV1vi8nCqyq/raGSyc=;
 b=ocmQfh2MlBKcOfp1jdRHlUa9RIa2mq+EXhwS/9I/LG0ZcR8H+LGKh4jkM/nQB+oPph
 7OWQxnmhURCHY61bPN0PJwoq1ix3DlEtU/kmGiXo1XwX49MbJsRzpwxx/Uqhmekgydw0
 cI7k3cVGeA7Vt3SDrygHbLmZt95KRIYdY7XNrBzDKsfIT2aNP2l1MkPgIWtxwj9eoVN5
 wIf6qwDIUVdLu4xxMOcqIAgAQ1lq0OLzBf1j+0Wn38gH1wPN8IQuJ0/+7qxP+LdZRPpd
 04rZcc+ylOhw2QICDgdi2WYSg74iWUgJBKtG6sGEiESBD3HaqlBH1BeXK4UuZQwJ6OHS
 xDwA==
X-Gm-Message-State: APjAAAXIBfCH9j+V/AHMwatsBlF70tGogiwAHkMvvx5zfi6FdSZPaln5
 L6vrWEH/XQadI+aJg7K+wOKj7g==
X-Google-Smtp-Source: APXvYqx5Hv2/M7GDadMZ561cW2Uzx73M+YYvMv9RY9olcnOsqdViISjtm8sENHnHp+oz9CtJmvdqow==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr8879731wmc.77.1562169166227; 
 Wed, 03 Jul 2019 08:52:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z17sm2708049wrr.13.2019.07.03.08.52.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 08:52:45 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E6791FF90;
 Wed,  3 Jul 2019 16:52:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 16:52:43 +0100
Message-Id: <20190703155244.28166-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703155244.28166-1-alex.bennee@linaro.org>
References: <20190703155244.28166-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 3/4] target/arm: handle A-profile A32
 semihosting at translate time
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As for the other semihosting calls we can resolve this at translate
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8e2e955cbe..139b2f6765 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7699,6 +7699,22 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
     arm_gen_test_cc(cond ^ 1, s->condlabel);
 }
 
+static inline void gen_arm_swi(DisasContext *s, int imm24)
+{
+    if (semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        s->current_el != 0 &&
+#endif
+        (imm24 == 0x123456)) {
+        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        return;
+    }
+
+    gen_set_pc_im(s, s->pc);
+    s->svc_imm = imm24;
+    s->base.is_jmp = DISAS_SWI;
+}
+
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
     unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
@@ -9249,9 +9265,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         case 0xf:
             /* swi */
-            gen_set_pc_im(s, s->pc);
-            s->svc_imm = extract32(insn, 0, 24);
-            s->base.is_jmp = DISAS_SWI;
+            gen_arm_swi(s, extract32(insn, 0, 24));
             break;
         default:
         illegal_op:
-- 
2.20.1


