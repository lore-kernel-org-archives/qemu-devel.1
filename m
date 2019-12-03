Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84642C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA7720684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDfre/tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA7720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyHE-00032Y-8j
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxD-0003Iw-2O
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxA-0008P0-5i
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:18 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxx1-0008Ec-Kn
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id az9so990953plb.11
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lQbiu/SxmR9ri07lGyjSz1lcJZjKc1rywBJ6yn3nMng=;
 b=LDfre/tOQ28OmXBXhIvRmbsI9D3oWyEr2PIwdSXkCQfQQFF9KhUFgaZSNYmAuDuHPk
 +xO8D2tikvUlCC4nA1Hk0uqPqMdoy+9wztwdT0gEgP9zN+N2RIrPIwXzBtYGnigbJZui
 AbxZIPJra4TRXj/+A/xy4Wq13eoZhJQgxbz8MV3Mp6GQO8l556QMzND3SfhXnP0/sfUe
 m19smqWh4OGaHCp+B4E5WPk/UTJgDtoFXzrFemTZDZqS08yzZQY9jmgXMdQgratDlHG9
 RX4Ra2o2rMr/+pNmeg/SHufpZgvkVpw/dOJ8oYX9d3TGTNvQMttFEK+8kH1JT7Xwl2qB
 SsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lQbiu/SxmR9ri07lGyjSz1lcJZjKc1rywBJ6yn3nMng=;
 b=hDfEKJsoAQXGLouKOSo9S4oZfrKtkWzqn0+LP9+35E6exingF+hzMdX/i1jvTzY76C
 t/vdQqGHyz9voOciOPddIHDcnwAGhDs3UUCRcFUPXNbJtBr3Tv8t0uPcsZynikF67FJi
 l81I6SNGZUCMxBfE3HCrpt1gnUmZTacMdLChNhpDvImup1tQD0jOV/dt5E7YcL82aN6R
 tFbAp1sFu7NFdfPP0u07+jE8+tGDtD1+1bKpT+HRZGvpWxwgbngCBKxPAZizx5Dnucuh
 +fNCDmyg+yG+CSNEG5pMUwU23EJ6cz1fYs3fq19vn2MtyxgIVoLWo8MImSv3gTiXRxom
 uVCQ==
X-Gm-Message-State: APjAAAVEI/8ofZkwGRw4SXo614Ylpob1YAr48D5S8RITkuyJq/ReatbA
 yRczNuxzAsZKV+lGDpV8GoRRiI6uHh8=
X-Google-Smtp-Source: APXvYqwAwrw1Y0olNvR2AzMK71SHNqvgqU+bAqgdiLM4woow0wzHytmkzQW74PNi6EN5PkMlLEA5qw==
X-Received: by 2002:a17:902:854c:: with SMTP id
 d12mr2660819plo.264.1575340201081; 
 Mon, 02 Dec 2019 18:30:01 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/40] target/arm: Tidy ARMMMUIdx m-profile definitions
Date: Mon,  2 Dec 2019 18:29:14 -0800
Message-Id: <20191203022937.1474-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the magic numbers with the relevant ARM_MMU_IDX_M_* constants.
Keep the definitions short by referencing previous symbols.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6ba5126852..015301e93a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2871,14 +2871,14 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_SE0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
-    ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MPrivNegPri = 3 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSUser = 4 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSPriv = 5 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSUserNegPri = 6 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSPrivNegPri = 7 | ARM_MMU_IDX_M,
+    ARMMMUIdx_MUser = ARM_MMU_IDX_M,
+    ARMMMUIdx_MPriv = ARM_MMU_IDX_M | ARM_MMU_IDX_M_PRIV,
+    ARMMMUIdx_MUserNegPri = ARMMMUIdx_MUser | ARM_MMU_IDX_M_NEGPRI,
+    ARMMMUIdx_MPrivNegPri = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_NEGPRI,
+    ARMMMUIdx_MSUser = ARMMMUIdx_MUser | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSPriv = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSUserNegPri = ARMMMUIdx_MUserNegPri | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSPrivNegPri = ARMMMUIdx_MPrivNegPri | ARM_MMU_IDX_M_S,
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
-- 
2.17.1


