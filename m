Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D852C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034492184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0019gmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034492184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa5Y-0006lj-V7
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3X-0007zD-LP
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3W-0005Xx-2A
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3V-00057B-NI
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:41 -0400
Received: by mail-pg1-x541.google.com with SMTP id n9so8750238pgc.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7Q+qzJFod9kksrq0MTcu1pbDq266ikI0MizQ0l0Hmw0=;
 b=Q0019gmPK95SO5m+WZ6yD67NmbBwrh6nrkPTGmtXg1r4c8lx+jex+cIF0gXD99R3x0
 OFjNHCGSfDJNvAFsRE0B/IatcEGmKDTgvG/EefeU15CHl8myJzlVmsX+eg+Qc880OYiQ
 2O+VpgziZGMBO9Vi+eZTLmoJ80BwWoVW6WNTZU+cfBzb/cHthMDBpWZHaOaVb7QSJ+Ze
 FtlwhnGjlEbDJjTN0tVmbbbaz0DCiek8+c2mfnYS8rQpbyszsanfMcOP+IMGqjPo0EwY
 dJctmtvwy6XI2RaH+XCwPIbyUykcRM+ohDi1/q0X1bKEEe9r4bnO8xALLlubUNcgMohs
 IOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7Q+qzJFod9kksrq0MTcu1pbDq266ikI0MizQ0l0Hmw0=;
 b=n6KoypwuM8BnC+zIKkiwf7dE9VyavX+A6GgI0w6361N7SCFxbZBB7QbEhhCnRdI9vN
 Jsy4Fzl9C73fdIpIYZvHlGSUkMu1qj3tGF5CXiblLCqR3LzUpezWHYUNFn19AvfW8Gwe
 Bf1gtlqYnQ9dcvrl07KBxIz34IkDTbyW5opsXErnnK6NXnx94gOSbMmF+8bTS42et+8r
 Dv5yfl/YOlOO+P0+RAheFqsF7n2UnRenSEMEdN6fuhZM8enL9TeV8sJE6vpE2XOI/dXj
 IXiWlJAJ29pHo0odv53s6CnsbDn0/Jbiv9XrXPV6dtc89PT4FC7mBqn4NBZQxSWorm12
 V/rQ==
X-Gm-Message-State: APjAAAVQwlaaC3wZ5+VzzQzfk0erNukwqAOw7DzlC/XvpEAHZG7rg4PZ
 awF4czBeuoN/SppfhRAOxA+RQvrXSkI=
X-Google-Smtp-Source: APXvYqyhWL6IQXGgVv9+FssQtRNS87jQnlYgc5UqRBsp9xPo9GNYiuIdMt1LwxQtP42jxWXx+LixVA==
X-Received: by 2002:a63:24c1:: with SMTP id
 k184mr57409828pgk.120.1563570215664; 
 Fri, 19 Jul 2019 14:03:35 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:08 -0700
Message-Id: <20190719210326.15466-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH for-4.2 06/24] target/arm: Define
 isar_feature_aa64_vh
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddb..e6a76d14c6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3573,6 +3573,11 @@ static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
 }
 
+static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+}
+
 static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
-- 
2.17.1


