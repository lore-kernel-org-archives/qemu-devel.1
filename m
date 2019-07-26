Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C21BC41517
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1573422CED
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6rMdZ5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1573422CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwq6-0004su-Ez
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqwpt-0004Tq-48
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqwpr-0007G3-2S
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:48:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqwpl-000756-26
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:48:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so53820611wrs.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WP9TNtIq8AQ768qefR0XP58fo9jH6KyHrm9DYwaaZig=;
 b=U6rMdZ5WOQSoWAtiKiiBA+JA2K0JAyP388XpcKB77kiSY14SWBHV0zPQ05Mh5PioH3
 H5N+EAbNtW8TGJttq33QP36uZ8SACDzCUDq3/mm6k+7CdKfKN0ptof7Bw3aLc/aIc5Ft
 RWx+9ppNjd1Ym1yy3mZhaicLkqc+/h6SIokaO9zwK4l8VJnbo/7+OROGSNYN8XQxSTFa
 6eD8BmY7zZ8G/zltd8SMwyGxc1K/1mfgUUGAo/zm1YIj7/9KpG1hxV6yTu11LIHDhF7A
 G2ghsbrDkFjqAPW6YIthiEi7q+DzPup7QBCxAsk1tbporwU0LsqehohEri7CYVIB1QZa
 wegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WP9TNtIq8AQ768qefR0XP58fo9jH6KyHrm9DYwaaZig=;
 b=fERR1kYEcW0s0Kj8yWamcMF7AYRBVaFwOp4lwY+WsHdjMdJcOi1BZH0rPE4ShJAQcy
 MmPKJfbPsqOL98JpClTU3t2bTt51g6OpNZZwg2CElmWWiaTB4H+q1WqMANiacgATtSzk
 14L/rZ5eeR7W68/MkQintswm5LrUL3RKls/GGD6xP7MR6GblUjrPqHEEcGkM11A6J3UE
 72yCKubETG+KZY3A45MEfBCfydlPGGImAQ3aJLonFta3KnRG7NoMxK9OVfwWrUQT/Wsa
 atMItfJxHD4WNmvVNf9V6mATCbSFlZvmY1gv/E9z9uO60DxMvBsZ3Hnl97adHcohX/yu
 2MRw==
X-Gm-Message-State: APjAAAUIVHfzRFanDtwwOa1O4tqoYLRHK8vMDnRn6OOF/2g2BeHceOQ6
 Lyo5lC5Ht25JhSkgv+ZatqATTg==
X-Google-Smtp-Source: APXvYqwWwZsMm+EKGuJa+XI/vz72W51AE+fNs9nbKHdoQaiPA/vfuuvuzqEkEPNg+IdL8+nrpS8GIA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr1459921wro.307.1564134487467; 
 Fri, 26 Jul 2019 02:48:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c1sm113646151wrh.1.2019.07.26.02.48.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 02:48:06 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 356B41FF87;
 Fri, 26 Jul 2019 10:48:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:47:57 +0100
Message-Id: <20190726094757.17779-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v3] target/arm: generate a custom MIDR for -cpu
 max
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

Avoid this problem by synthesising our own MIDR value.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - don't leak QEMU version into ID reg
v3
  - move comment into one block
  - explicit setting of more fields
---
 target/arm/cpu.h   |  6 ++++++
 target/arm/cpu64.c | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddbd..67f2af0e169 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1611,6 +1611,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
 /*
  * System register ID fields.
  */
+FIELD(MIDR_EL1, REVISION, 0, 4)
+FIELD(MIDR_EL1, PARTNUM, 4, 12)
+FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
+FIELD(MIDR_EL1, VARIANT, 20, 4)
+FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
+
 FIELD(ID_ISAR0, SWAP, 0, 4)
 FIELD(ID_ISAR0, BITCOUNT, 4, 4)
 FIELD(ID_ISAR0, BITFIELD, 8, 4)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1901997a064..f99008d7da1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -296,6 +296,23 @@ static void aarch64_max_initfn(Object *obj)
         uint32_t u;
         aarch64_a57_initfn(obj);
 
+        /*
+         * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
+         * one and try to apply errata workarounds or use impdef features we
+         * don't provide.
+         * An IMPLEMENTER field of 0 means "reserved for software use";
+         * ARCHITECTURE must be 0xf indicating "v7 or later, check ID registers
+         * to see which features are present";
+         * the VARIANT, PARTNUM and REVISION fields are all implementation
+         * defined and we choose to set VARIANT and leave the versions at zero.
+         */
+        t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
+        t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
+        t = FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
+        t = FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
+        t = FIELD_DP64(t, MIDR_EL1, REVISION, 0);
+        cpu->midr = t;
+
         t = cpu->isar.id_aa64isar0;
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);
-- 
2.20.1


