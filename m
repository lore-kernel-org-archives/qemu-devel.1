Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D824C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CBA2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUMdfYty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CBA2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzJZ-0006X5-8E
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 15:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5D-0006vq-Hg
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5B-0007SW-L1
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:47 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz5B-0007Qu-EX
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:45 -0400
Received: by mail-pg1-x543.google.com with SMTP id n9so31447517pgc.1
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VZbb1rzI4zahnAL11h/DzkD7ar6WwiCPlhOLpT3N7ho=;
 b=XUMdfYtyP/dN0NvjiEKzLhQ81PX1aEG6yfDSVTntnAkC0mjiaPutVEuE/iwMSdBaoI
 W2BAVieKDVGUWnETHBzDpm1ZmGfk/R32ANvpX6bxCan8Oz3rTCsduFiqbjm7V8wqU8/b
 bMpmDhcVV6F2wWxm9nc7j2Bn/Ofi/Zs7IjN9iW/QZAMI2nSs5Wx6sAVyRWuS0BaY5UXm
 WQA5op6gMyyi/s9Nb5FAhiwqXDqXfizNoVCq7fWlZCVe/TUh3wfRLSGOd2CkAbw8Rm8S
 rFZi2TjdomMmBQLXmyScAFfk/5j0NKU2Smfhj+o1qrw/6SRBWfVSw12ecq7VZLD5gkW6
 wutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VZbb1rzI4zahnAL11h/DzkD7ar6WwiCPlhOLpT3N7ho=;
 b=bjbgNkLsAO9wuVUJHNrTXFf9vcsPcpIH0ArWblUGeH6I7RiO0Zp8GldTAufQOBDxyC
 XzlsmNF71GK5iruNxtdldeMq7W3EQk6Alxoo2kScjqL9jyffcLgcISJwtCecsZtZBI4Q
 J447CHAoltnNwfIaijU7zbpqPHLKL+Wfwoy74mME2QXGbl8MxO2j+lOMKJjjuv5I/UtW
 95c+0MQHcoPdyQCl0lfnIZ6Acw/e2NuWWO3wkFVEw4+0ZMySaIxj3NeVE1o7nJAoQ7Za
 ayh8Hl3PTCBIqnfQHrCHq5jj7r5iDbOgT6zYN0iZiLuNWgKTyp78aoIK0ccrfvj99/hz
 MqhQ==
X-Gm-Message-State: APjAAAWnBVr3vUvmn3nZ4bv5lnPbVxu142TKs2yprn/miMKxYZNKGz0u
 DJi5mrAOlFSjYy3ormgLVpH2/Alek9o=
X-Google-Smtp-Source: APXvYqw7VsRRz+iBeE+9ZkwpQ3Zibt84S6Mpe2vBhl6+hXjcwsWUD8EUrwYhDFR18aHpFlkHDuvpsg==
X-Received: by 2002:a17:90a:8a0b:: with SMTP id
 w11mr10351911pjn.125.1564858122529; 
 Sat, 03 Aug 2019 11:48:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:48:00 -0700
Message-Id: <20190803184800.8221-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 34/34] target/arm: generate a custom MIDR
 for -cpu max
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

While most features are now detected by probing the ID_* registers
kernels can (and do) use MIDR_EL1 for working out of they have to
apply errata. This can trip up warnings in the kernel as it tries to
work out if it should apply workarounds to features that don't
actually exist in the reported CPU type.

Avoid this problem by synthesising our own MIDR value.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190726113950.7499-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   |  6 ++++++
 target/arm/cpu64.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d7c5a123a3..6e4c97d398 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1605,6 +1605,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
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
index b1bb394c6d..3a1e98a18e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -296,6 +296,25 @@ static void aarch64_max_initfn(Object *obj)
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
+         * defined and we choose to define PARTNUM just in case guest
+         * code needs to distinguish this QEMU CPU from other software
+         * implementations, though this shouldn't be needed.
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
2.17.1


