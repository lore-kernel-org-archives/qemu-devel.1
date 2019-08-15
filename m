Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EEDC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C029206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+bwkMhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C029206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5TN-0000s7-Qy
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DU-00069g-SB
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DS-0008RD-T9
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:16 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:42193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DS-0008QH-OX
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:14 -0400
Received: by mail-yw1-xc41.google.com with SMTP id z63so290561ywz.9
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sUUjkxC3I+DZZwP1yONXtBqBNrGY63NYaaa32AfTnHI=;
 b=c+bwkMhrBHZ/W42ETJF3fbyQVWvEoLsGl5w9HaVSJ9sCPLF/wMF7HEenhsk4B+5OMt
 jQRnSV3QgCPZP3jgmNXKXjXgAEeCcrVpBbz11thdyzj3D2AD0jXJnR3+ALAYd5T+Aisb
 5G4uw7ZOmOcYQTd8TPGNkAkhr5cdMczzbBmjxqPCVKyuJf+Oy2A3LPc9kof0GCxNEAcI
 ZKDpELVPV4iZ/BlNq85fTrVGr28EDhL2BUiZho+iPxf2YHgUm7idMfwOeq9tfID9k2iT
 xR48Vi1Pd7pAB1Nu9UM8RlY4htSHVZGAXKHSofjKXm5JBScnoo7Nk8e1/j3EG50PJukc
 ibfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sUUjkxC3I+DZZwP1yONXtBqBNrGY63NYaaa32AfTnHI=;
 b=lJOlgiDZRS1AsOIyFRn55uwjFo6DBA4GOb6+Xd20MC2Bs0VYL2wzuV6k6HOgOhPMzd
 3QudvMGOzpFaofIjDwdIvUK1yQ8nwucLoj+SHrkRk82/bRj1b1XONaCA+7Bhw3zBW/JR
 rMRU3F+6sdCSJg15TvWZ8mJrS9OS4wrN235dAETxGQuK+AW/DAHgb1hj8xZp18aBve61
 TwtGp83QgDiCtSd0e/WDqR1twOSp19dxAKcrswCwi1TKqC/Tha+mfXhe1WtPS/N9ldjZ
 GZemgKyyd13posBCroBY+XQFBmHyUcfeKpFjcRTlqgv0HNtSmvqQmP2drQEuIPg45p+Q
 j6gQ==
X-Gm-Message-State: APjAAAWMqUHrpAl+dv6FeFI760k/Q7iI+wAxMLLzI6ajVM5L85LHF1vR
 V6EJ+N5Y9CxiAnn1RIuzdWnWaUQK
X-Google-Smtp-Source: APXvYqxrXtft73coq7oUmnbHv95uxESVjtI3RrYexsfj4BSkKYFoinJSfebzlm3foCuYH5yPvK8bnw==
X-Received: by 2002:a81:2492:: with SMTP id k140mr1559567ywk.138.1565835013959; 
 Wed, 14 Aug 2019 19:10:13 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:13 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:03 -0400
Message-Id: <20190815020928.9679-22-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v3 21/46] target/i386: introduce modrm
 operand
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This permits the ModR/M byte to be passed raw into the code generator,
effectively allowing to short-circuit the operand decoding mechanism
and do the decoding work manually in the code generator.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7fc5149d29..25c25a30fb 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4740,6 +4740,26 @@ INSNOP_FINALIZE(tcg_temp_i64)
     tcg_temp_free_i64(arg);
 }
 
+/*
+ * modrm
+ *
+ * Operand whose value is the ModR/M byte.
+ */
+typedef int insnop_arg_t(modrm);
+typedef struct {} insnop_ctxt_t(modrm);
+
+INSNOP_INIT(modrm)
+{
+    return 0;
+}
+INSNOP_PREPARE(modrm)
+{
+    return modrm;
+}
+INSNOP_FINALIZE(modrm)
+{
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


