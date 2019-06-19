Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47013C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B2520B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6y1yZHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B2520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSox-00063s-Cl
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34499)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmb-00041I-Bj
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmV-0001hA-Cl
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:17 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:41245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0001fG-H8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:09 -0400
Received: by mail-yb1-xb44.google.com with SMTP id d2so7077662ybh.8
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f1TNYWO3EEifVKZE2F7vRjyCMw4wSrP5B9IQTXvCdlA=;
 b=N6y1yZHXVDiebr5MtA36UMo5CPLLyOPVRFZspXz/nxJyGdGUObWPvz38O6g57/NNz+
 frpj9a2l7Vv9weUd0A9GNmrMZ7UBafGBSCw/NFOdOmX1H9xHh504+qJ+4mkjDysiPzmM
 l8aekkbuM7f8k5YXFS3sRwRDyvaBU+hSfI+gChm6qBfRgut6/7AU6jTZY3L+xj7mOfn9
 IC5xPOso0cHK9A7TL+vd4IJSiOOjcMLt8yPtDRKFhpp4V8JjxXaqeeB5PH/H0h9ZE3r4
 ZRNF8uJYQFDhk2k71rOBuUPRtAwA3m3X3GFHTy9IYoWiPC5H67zb358kusTmHYn6NVfG
 QFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f1TNYWO3EEifVKZE2F7vRjyCMw4wSrP5B9IQTXvCdlA=;
 b=G7NuumzWBhP/e23bzYYF+RNeAKYq/SfdujKvjW1E5KKpGABifPAl3coVUA4B1JIPI8
 ty2WFOMxv7t+r4zxHsCtp7Z+FZOeNNoKnGg4KhKRsY8p3l/mc6EYc4ynT27dlG1neX6D
 gwwAvekG6MBs7gINY0rnv8GA58Oo/Dho8g5UZX1K2Lvc+mXAcq3A3aZmWMNaJGFLUVl/
 1YewwYSAU1Wf4uZMXvl0EHyk2dIQYe+5lZ3c8bq67C+UUrdP3+eZMWk+9KURtk/68zPW
 xV2cmoNNCjb8gipr64VBqheLTYmPCQAzIkm8Jr7mPighhhmCZQJsd3Ag0M12yGFANvZm
 OZEg==
X-Gm-Message-State: APjAAAUp7/krTFvbw1tJiigakAQe6lerCRKRgYfmZHBPlcnGHoG6B7xR
 pk4Q2g3BTO5KV8AlIlh7l7xS7ooI
X-Google-Smtp-Source: APXvYqztvc6ldGU2fVCd5zeB4I0v5QQhoGYq7QkLHghaoJZgbZxpIorv0EJ/m9YDUQuUyAPmal7sHA==
X-Received: by 2002:a5b:405:: with SMTP id m5mr20382836ybp.261.1560920707827; 
 Tue, 18 Jun 2019 22:05:07 -0700 (PDT)
Received: from localhost.localdomain (67-9-99-67.biz.bhn.net. [67.9.99.67])
 by smtp.gmail.com with ESMTPSA id e12sm1714426ywe.85.2019.06.18.22.05.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 22:05:07 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 01:04:46 -0400
Message-Id: <20190619050447.22201-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619050447.22201-1-jan.bobek@gmail.com>
References: <20190619050447.22201-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU RFC PATCH v1 6/7] x86.risu: add SSE instructions
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

Add an x86 configuration file with all SSE instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 x86.risu

diff --git a/x86.risu b/x86.risu
new file mode 100644
index 0000000..cc40bbc
--- /dev/null
+++ b/x86.risu
@@ -0,0 +1,99 @@
+###############################################################################
+# Copyright (c) 2019 Linaro Limited
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Jan Bobek - initial implementation
+###############################################################################
+
+# Input file for risugen defining x86 instructions
+.mode x86
+
+# SSE Data Transfer Instructions
+MOVUPS          SSE     00001111 0001000 d !emit { modrm(); mem(size => 16); }
+MOVSS           SSE     00001111 0001000 d !emit { rep(); modrm(); mem(size => 4); }
+MOVHLPS         SSE     00001111 00010010  !emit { modrm(mod => MOD_DIRECT); }
+MOVLPS          SSE     00001111 0001001 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVLHPS         SSE     00001111 00010110  !emit { modrm(mod => MOD_DIRECT); }
+MOVHPS          SSE     00001111 0001011 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVAPS          SSE     00001111 0010100 d !emit { modrm(); mem(size => 16, align => 16); }
+MOVMSKPS        SSE     00001111 01010000  !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+
+# SSE Packed Arithmetic Instructions
+ADDPS           SSE     00001111 01011000 !emit { modrm(); mem(size => 16, align => 16); }
+ADDSS           SSE     00001111 01011000 !emit { rep(); modrm(); mem(size => 4); }
+SUBPS           SSE     00001111 01011100 !emit { modrm(); mem(size => 16, align => 16); }
+SUBSS           SSE     00001111 01011100 !emit { rep(); modrm(); mem(size => 4); }
+MULPS           SSE     00001111 01011001 !emit { modrm(); mem(size => 16, align => 16); }
+MULSS           SSE     00001111 01011001 !emit { rep(); modrm(); mem(size => 4); }
+DIVPS           SSE     00001111 01011110 !emit { modrm(); mem(size => 16, align => 16); }
+DIVSS           SSE     00001111 01011110 !emit { rep(); modrm(); mem(size => 4); }
+RCPPS           SSE     00001111 01010011 !emit { modrm(); mem(size => 16, align => 16); }
+RCPSS           SSE     00001111 01010011 !emit { rep(); modrm(); mem(size => 4); }
+SQRTPS          SSE     00001111 01010001 !emit { modrm(); mem(size => 16, align => 16); }
+SQRTSS          SSE     00001111 01010001 !emit { rep(); modrm(); mem(size => 4); }
+RSQRTPS         SSE     00001111 01010010 !emit { modrm(); mem(size => 16, align => 16); }
+RSQRTSS         SSE     00001111 01010010 !emit { rep(); modrm(); mem(size => 4); }
+MINPS           SSE     00001111 01011101 !emit { modrm(); mem(size => 16, align => 16); }
+MINSS           SSE     00001111 01011101 !emit { rep(); modrm(); mem(size => 4); }
+MAXPS           SSE     00001111 01011111 !emit { modrm(); mem(size => 16, align => 16); }
+MAXSS           SSE     00001111 01011111 !emit { rep(); modrm(); mem(size => 4); }
+
+# SSE Comparison Instructions
+CMPPS           SSE     00001111 11000010 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+CMPSS           SSE     00001111 11000010 !emit { rep(); modrm(); mem(size => 4); imm(size => 1); }
+UCOMISS         SSE     00001111 00101110 !emit { modrm(); mem(size => 4); }
+COMISS          SSE     00001111 00101111 !emit { modrm(); mem(size => 4); }
+
+# SSE Logical Instructions
+ANDPS           SSE     00001111 01010100 !emit { modrm(); mem(size => 16, align => 16); }
+ANDNPS          SSE     00001111 01010101 !emit { modrm(); mem(size => 16, align => 16); }
+ORPS            SSE     00001111 01010110 !emit { modrm(); mem(size => 16, align => 16); }
+XORPS           SSE     00001111 01010111 !emit { modrm(); mem(size => 16, align => 16); }
+
+# SSE Shuffle and Unpack Instructions
+SHUFPS          SSE     00001111 11000110 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+UNPCKLPS        SSE     00001111 00010100 !emit { modrm(); mem(size => 16, align => 16); }
+UNPCKHPS        SSE     00001111 00010101 !emit { modrm(); mem(size => 16, align => 16); }
+
+# SSE Conversion Instructions
+CVTPI2PS        SSE     00001111 00101010 !emit { modrm(); mem(size => 8); }
+CVTSI2SS        SSE     00001111 00101010 !emit { rep(); modrm(); mem(size => 4); }
+CVTSI2SS_64     SSE     00001111 00101010 !emit { rep(); rex(w => 1); modrm(); mem(size => 8); }
+CVTPS2PI        SSE     00001111 00101101 !emit { modrm(); mem(size => 8); }
+CVTSS2SI        SSE     00001111 00101101 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTSS2SI_64     SSE     00001111 00101101 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTTPS2PI       SSE     00001111 00101100 !emit { modrm(); mem(size => 8); }
+CVTTSS2SI       SSE     00001111 00101100 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTTSS2SI_64    SSE     00001111 00101100 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+
+# SSE MXCSR State Management Instructions
+# LDMXCSR         SSE     00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 4); }
+STMXCSR         SSE     00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 3); mem(size => 4); }
+
+# SSE 64-bit SIMD Integer Instructions
+PAVGB           SSE     00001111 11100000 !emit { modrm(); mem(size => 8); }
+PAVGW           SSE     00001111 11100011 !emit { modrm(); mem(size => 8); }
+PEXTRW          SSE     00001111 11000101 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); mem(size => 8); imm(size => 1); }
+PINSRW          SSE     00001111 11000100 !emit { modrm(); mem(size => 2); imm(size => 1); }
+PMAXUB          SSE     00001111 11011110 !emit { modrm(); mem(size => 8); }
+PMAXSW          SSE     00001111 11101110 !emit { modrm(); mem(size => 8); }
+PMINUB          SSE     00001111 11011010 !emit { modrm(); mem(size => 8); }
+PMINSW          SSE     00001111 11101010 !emit { modrm(); mem(size => 8); }
+PMOVMSKB        SSE     00001111 11010111 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); mem(size => 8); }
+PMULHUW         SSE     00001111 11100100 !emit { modrm(); mem(size => 8); }
+PSADBW          SSE     00001111 11110110 !emit { modrm(); mem(size => 8); }
+PSHUFW          SSE     00001111 01110000 !emit { modrm(); mem(size => 8); imm(size => 1); }
+
+# SSE Cacheability Control, Prefetch, and Instruction Ordering Instructions
+MASKMOVQ        SSE     00001111 11110111 !emit { modrm(mod => MOD_DIRECT); mem(size => 8, base => REG_EDI); }
+MOVNTQ          SSE     00001111 11100111 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVNTPS         SSE     00001111 00101011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+PREFETCHT0      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 1); mem(size => 1); }
+PREFETCHT1      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 1); }
+PREFETCHT2      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 3); mem(size => 1); }
+PREFETCHNTA     SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 0); mem(size => 1); }
+SFENCE          SSE     00001111 10101110 !emit { modrm(mod => MOD_DIRECT, reg => 7); }
-- 
2.20.1


