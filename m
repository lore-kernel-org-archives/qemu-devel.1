Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63BFC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933B8229F9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Db8o7UOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933B8229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxUk-0007HQ-Ty
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqxUV-0006iX-J2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqxUR-0006Y1-AN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:30:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqxUQ-0006Hp-Jr
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:30:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so47571187wmj.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JKZ/eufwsGEOLBqmS8Sok2hjujRO4sX8Mpyc9JijYgk=;
 b=Db8o7UOubhgqfWqNAq2FijwUXtlDbH6WVUGzbcm0PGN6pYX+rddAo2iTDYs6gW3pxo
 YYmEKKCs/s8uky5mwbjRxr7e4EUMT3iy+vCOWoQ7lFqa7Q59YlFPxNCwbu0T4+9H9NCB
 xkTzOIM7wr45+xmtFfFkQOmjOlljKxJqgd1T4AJQhW1uJl8BN9FW91K04sYyQGIRSDfi
 858PPxYtoGTqrdAM1r6+W977XjGhJBsumO1PbWCfd/PkRntyW/CuZ/0+nzRzoCEJWyCW
 heU4/25JXYgkJ6oLvtpiDwh+DkjmLXUmFHqN9QPlP+uJsJfpZfuZ/AJ5jgaEeKiKT9HV
 E4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JKZ/eufwsGEOLBqmS8Sok2hjujRO4sX8Mpyc9JijYgk=;
 b=DH8aBq7RgN0baiDMmkOpFbgmPBk8KiBvPUAZewB8/Z0O2WDWpMlpYA3sgA6YJ1gU7d
 iar/6Ll0ysJ9rmMGirUdpA/2kU6T8tkTnuHkU3wiUqp7CSuOn7qQENmAwOhCNQa3/PaQ
 WlVdZsNJDPtiITHqIx9NpoiuUpy9UBzEubxaPxuJzqKmZY0GgaD4kBfPI0e4NItCenbi
 8gRG8/xP8Wn4mRLOS4E5D5SJyd1a0lmbZRaxId14wvFZCKbYOYQpMO5qfajku6pIMCBR
 HzFFujJajQiGeP/vNICWQ/H/v/SFi9jVoOUTrUhWKViv07MdSZGP3tI34QBQonYpnsjC
 NMWQ==
X-Gm-Message-State: APjAAAULEhiokYIVD64mLFyG1KJlgw+9dO7S6X21F3+mqpb1DNbb7h/L
 j8hnnNCefZF7p9XU8SfH3fnSNw==
X-Google-Smtp-Source: APXvYqxdZPN4ODEVuSDHLlXkpTf6HJ/XpiKs39IsiZU0U4fv/X/oef0uYWBXiHTCdUvgSaoIK8hnig==
X-Received: by 2002:a05:600c:2111:: with SMTP id
 u17mr64627899wml.64.1564137014759; 
 Fri, 26 Jul 2019 03:30:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 4sm120168288wro.78.2019.07.26.03.30.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 03:30:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA02C1FF87;
 Fri, 26 Jul 2019 11:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 11:30:10 +0100
Message-Id: <20190726103010.31741-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v4] target/arm: generate a custom MIDR for -cpu
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---
v2
  - don't leak QEMU version into ID reg
v3
  - move comment into one block
  - explicit setting of more fields
v4
  - minor reword of comment
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
index 1901997a064..511d31dce41 100644
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
+         * defined and we choose to define VARIANT and set the others to zero.
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


