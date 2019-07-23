Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF7C7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555FF20644
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRleVK1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555FF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41363 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpt2p-0005uV-HE
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 07:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpt2b-0005QB-2b
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpt2Z-0000vJ-Td
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:33:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpt2Z-0000uY-Lp
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:33:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so42761913wru.13
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DWbDWaYfcxmkGXUdUBX0lMq0CUBdZuPA0MBGgprVLng=;
 b=WRleVK1KsOtUXGCyav3mR2h3r66Z4gFEHcejcl+/2OUqs1FPk9J5bfo+829yTQktuf
 vJfxYnJOwZb3cJ4S7nRuBbXndljS+eoHAjoGY1VehSauOmAiMzv55PxpxMkuTcXlpy0C
 cnpDUN9wXsQBdX0HLy2Q8mzwPfe1Yl8pGGauSRgRYQDoW8hlnOiBTsGJgIR27ERH8GNq
 JPfFpTJ3CiaLE0mjxgafi4WfPRnDqIOco+S7XOqERcH6IvAhwBnm3qLZMgVLCP73VOBt
 YacWIqIZsE+Df/rovuOexV5Xahxx1H7TmOpAJzu8hrMzc6iqNmoHWM1pQvUEPElf27jI
 tlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DWbDWaYfcxmkGXUdUBX0lMq0CUBdZuPA0MBGgprVLng=;
 b=auq0Jtbxmlroitp8ip+IOM11gj+Qi7z3h3uBOlAgXHKSfF02v7MQK7JrbvNxKLh3CO
 zbyxuJaTaPm0EPXbDq9MnwSk3IRj08bqyHlH5mq21FV4jKzgfs2uKq2R0Ob5SKR1LbEH
 M3Ysx6d0Kgzp634D1zpWwDKzO+42bA+4MeRCp6gLScL47Hkjt7d72ZPe7a6ufJvZpvX9
 zRXaSJGtl6GmiibEp7ulp8+dTxAXZbClKnqIZ5jtqlsLkiErGJsUWbCDtCAXdbzBSDA+
 TNO+cc4rSLSu31MNjZnQFkuvoSJpEuy9Mc6Wk88yAkuqxdJ2KKHh6Jypfmg6n3BxF4df
 9Kpw==
X-Gm-Message-State: APjAAAXym/ElJ7Wi9ZzkDi6CaoU3tRvrgdTGA9CgkhL/BvpVPHkz2ZAE
 8tpJbbh/DcHb0c+ML2EBj+aUUQ==
X-Google-Smtp-Source: APXvYqzddgK9tKugmZgAQoJeSHRWFw3WocoNVqCU4voI2N6j60LoeacRcB8VbAYm7qg+05KPghNXXA==
X-Received: by 2002:adf:ab51:: with SMTP id r17mr54329617wrc.95.1563881586322; 
 Tue, 23 Jul 2019 04:33:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e3sm38553746wrt.93.2019.07.23.04.33.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 04:33:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59BBC1FF87;
 Tue, 23 Jul 2019 12:33:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:33:01 +0100
Message-Id: <20190723113301.16867-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH for 4.2] target/arm: generate a custom MIDR for
 -cpu max
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

While most features are now detected by probing the ID_* registers
kernels can (and do) use MIDR_EL1 for working out of they have to
apply errata. This can trip up warnings in the kernel as it tries to
work out if it should apply workarounds to features that don't
actually exist in the reported CPU type.

Avoid this problem by synthesising our own MIDR value using the
reserved value of 0 for the implementer and telling kernels the ID
registers should tell them everything they need to know.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - don't leak QEMU version into ID reg
---
 target/arm/cpu.h   | 6 ++++++
 target/arm/cpu64.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7efbb488d9d..61eaef924e4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1605,6 +1605,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
 /*
  * System register ID fields.
  */
+FIELD(MIDR_EL1, REVISION, 0, 4)
+FIELD(MIDR_EL1, PARTNUM, 4, 12)
+FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
+FIELD(MIDR_EL1, VARIENT, 20, 4)
+FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
+
 FIELD(ID_ISAR0, SWAP, 0, 4)
 FIELD(ID_ISAR0, BITCOUNT, 4, 4)
 FIELD(ID_ISAR0, BITFIELD, 8, 4)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b1bb394c6dd..e88aadfd2fd 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -296,6 +296,12 @@ static void aarch64_max_initfn(Object *obj)
         uint32_t u;
         aarch64_a57_initfn(obj);
 
+        /* reset MIDR so our franken-max-cpu type isn't mistaken for a real one */
+        t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0); /* Reserved for SW */
+        t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf); /* See ID_* for details */
+        /* the rest is enigmatically empty lest kernels assume it means something */
+        cpu->midr = t;
+
         t = cpu->isar.id_aa64isar0;
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);
-- 
2.20.1


