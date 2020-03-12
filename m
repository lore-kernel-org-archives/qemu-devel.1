Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1691C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF5F20724
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuwmJb4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF5F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTx2-0005R3-Mi
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjg-0006qy-UL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjb-0002NF-2R
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:16 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:34580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTja-0002MZ-O4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:11 -0400
Received: by mail-pg1-x530.google.com with SMTP id t3so3577937pgn.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bHE6PfAof8zpzhd8taI/sMJJmZWaYOR9yPhWHh2spmA=;
 b=QuwmJb4RIj4W/6T4Vycd0ColDfNSSMaDG5lMq6UnJOTSwjLCa79s2gFeztSiToDcGz
 PTJExOmK0HRJHJMhd7EYg3Z9L4MDxXSfn5ZfwyOWOTldK7zwC9w9mXl5RGmKIY67KySc
 Ot/s90pmfNnp4qSgTNHCQWJ+pC+NiKuv+kL0Cs7QO9SWHLSvWJdyap/e2W48+lvNJ2e7
 bq0LDLKfxyplyr2Jidy+3PCdRCjmuWiCNDrEE1yqHZA+AMPue3tt2Xi2Rs6o8Q/2lCSt
 q7Fjb+BWER4L8B3KGMSnWKPOB2IRQCJfqyLBBtVnli8yeFFTiRh9j/qmWhJ86XyT3rQM
 eAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bHE6PfAof8zpzhd8taI/sMJJmZWaYOR9yPhWHh2spmA=;
 b=lFwKbCNm53En6a3ep/kvDdYlT07Pdr7mZiuBDtJtgzVN6j0S1nWH6C+Ltpjr4SE9b4
 UWg18b0eDSAVTVTIMP4ExmxvjGmZYNaAcpDamvyUvtIkKmmNBjhIOdFlkDBMbt0Pe16R
 POAFnBwlGRqsnthf9pdnIY5qclg8nfvPp06F0cdJ3J2BDMV8AlbozcaSBgOnzQlqLZ6s
 SJK4e/2kDSS08HYfKBjutGEWG2xIWa+lkRRh7JZd/e2Z+FqdEP+RMmXgX/4QpSD0eJIU
 SoZo/ZdMpfU9UR8VXr41tpNVZRoYjUhLkRznUd8OsvW07JpTrTvGw33sC39DhazIkMgT
 M91A==
X-Gm-Message-State: ANhLgQ2bMVMscRWZUHiDfjku5Iyhow4PIDFQy64wF1BMzrZ1q3Zdaa7T
 vnkSNR7hDm57ueS7gl4nG8BL9qLScqU=
X-Google-Smtp-Source: ADFU+vuYRolq6Gp199hZVQvuNXTtt1qBC5nlJQgQ3TBfMMZSQEaqgJAmy8KUK5vl0tzk+U5hAi8wlg==
X-Received: by 2002:a62:be0d:: with SMTP id l13mr9759640pff.217.1584042188010; 
 Thu, 12 Mar 2020 12:43:08 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 35/42] target/arm: Add mte helpers for sve scatter/gather
 memory ops
Date: Thu, 12 Mar 2020 12:42:12 -0700
Message-Id: <20200312194219.24406-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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

Because the elements are non-sequential, we cannot eliminate many
tests straight away like we can for sequential operations.  But
we often have the PTE details handy, so we can test for Tagged.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 285 ++++++++++++++++
 target/arm/sve_helper.c    | 185 +++++++++--
 target/arm/translate-sve.c | 650 +++++++++++++++++++++++++------------
 3 files changed, 872 insertions(+), 248 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 849478fc76..ddf9069c7f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1605,6 +1605,115 @@ DEF_HELPER_FLAGS_6(sve_ldsds_le_zd, TCG_CALL_NO_WG,
 DEF_HELPER_FLAGS_6(sve_ldsds_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_6(sve_ldbsu_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhsu_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldss_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldss_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldbss_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhss_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhss_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldbsu_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhsu_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhsu_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldss_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldss_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldbss_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhss_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhss_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldbdu_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhdu_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhdu_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldbds_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhds_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhds_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldbdu_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhdu_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhdu_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldbds_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhds_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhds_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldbdu_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhdu_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhdu_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsdu_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_lddd_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldbds_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhds_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldhds_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldsds_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zsu, TCG_CALL_NO_WG,
@@ -1714,6 +1823,115 @@ DEF_HELPER_FLAGS_6(sve_ldffsds_le_zd, TCG_CALL_NO_WG,
 DEF_HELPER_FLAGS_6(sve_ldffsds_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_6(sve_ldffbsu_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffss_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffss_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbss_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhss_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhss_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldffbsu_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhsu_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhsu_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffss_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffss_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbss_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhss_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhss_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldffbdu_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbds_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldffbdu_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbds_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_ldffbdu_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhdu_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsdu_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffdd_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffbds_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffhds_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_ldffsds_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_6(sve_stbs_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_sths_le_zsu, TCG_CALL_NO_WG,
@@ -1781,4 +1999,71 @@ DEF_HELPER_FLAGS_6(sve_stdd_le_zd, TCG_CALL_NO_WG,
 DEF_HELPER_FLAGS_6(sve_stdd_be_zd, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_6(sve_stbs_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sths_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sths_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbs_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sths_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sths_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stss_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbd_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_le_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_be_zsu_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbd_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_le_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_be_zss_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_6(sve_stbd_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_sthd_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stsd_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_le_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+DEF_HELPER_FLAGS_6(sve_stdd_be_zd_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, ptr, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve2_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9e8ffb7062..566a619300 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5518,7 +5518,8 @@ static target_ulong off_zd_d(void *reg, intptr_t reg_ofs)
 static inline QEMU_ALWAYS_INLINE
 void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                target_ulong base, uint32_t desc, uintptr_t retaddr,
-               int esize, int msize, zreg_off_fn *off_fn,
+               uint32_t mtedesc, int esize, int msize,
+               zreg_off_fn *off_fn,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
@@ -5546,7 +5547,9 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                         cpu_check_watchpoint(env_cpu(env), addr, msize,
                                              info.attrs, BP_MEM_READ, retaddr);
                     }
-                    /* TODO: MTE check */
+                    if (mtedesc && info.attrs.target_tlb_bit1) {
+                        mte_check1(env, mtedesc, addr, retaddr);
+                    }
                     host_fn(&scratch, reg_off, info.host);
                 } else {
                     /* Element crosses the page boundary. */
@@ -5557,7 +5560,9 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                                              msize, info.attrs,
                                              BP_MEM_READ, retaddr);
                     }
-                    /* TODO: MTE check */
+                    if (mtedesc && info.attrs.target_tlb_bit1) {
+                        mte_check1(env, mtedesc, addr, retaddr);
+                    }
                     tlb_fn(env, &scratch, reg_off, addr, retaddr);
                 }
             }
@@ -5570,20 +5575,53 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     memcpy(vd, &scratch, reg_max);
 }
 
+static inline QEMU_ALWAYS_INLINE
+void sve_ld1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
+                   target_ulong base, uint32_t desc, uintptr_t retaddr,
+                   int esize, int msize, zreg_off_fn *off_fn,
+                   sve_ldst1_host_fn *host_fn,
+                   sve_ldst1_tlb_fn *tlb_fn)
+{
+    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    /* Remove mtedesc from the normal sve descriptor. */
+    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+
+    /*
+     * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
+     * offset base entirely over the address space hole to change the
+     * pointer tag, or change the bit55 selector.  So we could here
+     * examine TBI + TCMA like we do for sve_ldN_r_mte().
+     */
+    sve_ld1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
+              esize, msize, off_fn, host_fn, tlb_fn);
+}
+
 #define DO_LD1_ZPZ_S(MEM, OFS, MSZ) \
 void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
                                  void *vm, target_ulong base, uint32_t desc) \
 {                                                                            \
-    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,             \
+    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 4, 1 << MSZ,          \
               off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
+}                                                                            \
+void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
+     void *vm, target_ulong base, uint32_t desc)                             \
+{                                                                            \
+    sve_ld1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,         \
+                  off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
 }
 
 #define DO_LD1_ZPZ_D(MEM, OFS, MSZ) \
 void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
                                  void *vm, target_ulong base, uint32_t desc) \
 {                                                                            \
-    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,             \
+    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 8, 1 << MSZ,          \
               off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
+}                                                                            \
+void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
+    void *vm, target_ulong base, uint32_t desc)                              \
+{                                                                            \
+    sve_ld1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,         \
+                  off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
 }
 
 DO_LD1_ZPZ_S(bsu, zsu, MO_8)
@@ -5662,7 +5700,8 @@ DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 static inline QEMU_ALWAYS_INLINE
 void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                  target_ulong base, uint32_t desc, uintptr_t retaddr,
-                 const int esz, const int msz, zreg_off_fn *off_fn,
+                 uint32_t mtedesc, const int esz, const int msz,
+                 zreg_off_fn *off_fn,
                  sve_ldst1_host_fn *host_fn,
                  sve_ldst1_tlb_fn *tlb_fn)
 {
@@ -5687,6 +5726,9 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
      * Probe the first element, allowing faults.
      */
     addr = base + (off_fn(vm, reg_off) << scale);
+    if (mtedesc) {
+        mte_check1(env, mtedesc, addr, retaddr);
+    }
     tlb_fn(env, vd, reg_off, addr, retaddr);
 
     /* After any fault, zero the other elements. */
@@ -5719,7 +5761,11 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                                          BP_MEM_READ)) {
                     goto fault;
                 }
-                /* TODO: MTE check. */
+                if (mtedesc &&
+                    info.attrs.target_tlb_bit1 &&
+                    !mte_probe1(env, mtedesc, addr, retaddr)) {
+                    goto fault;
+                }
 
                 host_fn(vd, reg_off, info.host);
             }
@@ -5732,20 +5778,58 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     record_fault(env, reg_off, reg_max);
 }
 
-#define DO_LDFF1_ZPZ_S(MEM, OFS, MSZ) \
-void HELPER(sve_ldff##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
-                                   void *vm, target_ulong base, uint32_t desc) \
-{                                                                              \
-    sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), MO_32, MSZ,              \
-                off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
+static inline QEMU_ALWAYS_INLINE
+void sve_ldff1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
+                     target_ulong base, uint32_t desc, uintptr_t retaddr,
+                     const int esz, const int msz,
+                     zreg_off_fn *off_fn,
+                     sve_ldst1_host_fn *host_fn,
+                     sve_ldst1_tlb_fn *tlb_fn)
+{
+    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    /* Remove mtedesc from the normal sve descriptor. */
+    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+
+    /*
+     * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
+     * offset base entirely over the address space hole to change the
+     * pointer tag, or change the bit55 selector.  So we could here
+     * examine TBI + TCMA like we do for sve_ldN_r_mte().
+     */
+    sve_ldff1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
+                esz, msz, off_fn, host_fn, tlb_fn);
 }
 
-#define DO_LDFF1_ZPZ_D(MEM, OFS, MSZ) \
-void HELPER(sve_ldff##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
-                                   void *vm, target_ulong base, uint32_t desc) \
-{                                                                              \
-    sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), MO_64, MSZ,              \
-                off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
+#define DO_LDFF1_ZPZ_S(MEM, OFS, MSZ)                                   \
+void HELPER(sve_ldff##MEM##_##OFS)                                      \
+    (CPUARMState *env, void *vd, void *vg,                              \
+     void *vm, target_ulong base, uint32_t desc)                        \
+{                                                                       \
+    sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), 0, MO_32, MSZ,    \
+                off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
+}                                                                       \
+void HELPER(sve_ldff##MEM##_##OFS##_mte)                                \
+    (CPUARMState *env, void *vd, void *vg,                              \
+     void *vm, target_ulong base, uint32_t desc)                        \
+{                                                                       \
+    sve_ldff1_z_mte(env, vd, vg, vm, base, desc, GETPC(), MO_32, MSZ,   \
+                    off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
+}
+
+#define DO_LDFF1_ZPZ_D(MEM, OFS, MSZ)                                   \
+void HELPER(sve_ldff##MEM##_##OFS)                                      \
+    (CPUARMState *env, void *vd, void *vg,                              \
+     void *vm, target_ulong base, uint32_t desc)                        \
+{                                                                       \
+    sve_ldff1_z(env, vd, vg, vm, base, desc, GETPC(), 0, MO_64, MSZ,    \
+                off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
+}                                                                       \
+void HELPER(sve_ldff##MEM##_##OFS##_mte)                                \
+    (CPUARMState *env, void *vd, void *vg,                              \
+     void *vm, target_ulong base, uint32_t desc)                        \
+{                                                                       \
+    sve_ldff1_z_mte(env, vd, vg, vm, base, desc, GETPC(), MO_64, MSZ,   \
+                    off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb); \
 }
 
 DO_LDFF1_ZPZ_S(bsu, zsu, MO_8)
@@ -5817,7 +5901,8 @@ DO_LDFF1_ZPZ_D(dd_be, zd, MO_64)
 static inline QEMU_ALWAYS_INLINE
 void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                target_ulong base, uint32_t desc, uintptr_t retaddr,
-               int esize, int msize, zreg_off_fn *off_fn,
+               uint32_t mtedesc, int esize, int msize,
+               zreg_off_fn *off_fn,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
@@ -5861,7 +5946,10 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                     cpu_check_watchpoint(env_cpu(env), addr, msize,
                                          info.attrs, BP_MEM_WRITE, retaddr);
                 }
-                /* TODO: MTE check. */
+
+                if (mtedesc && info.attrs.target_tlb_bit1) {
+                    mte_check1(env, mtedesc, addr, retaddr);
+                }
             }
             i += 1;
             reg_off += esize;
@@ -5891,20 +5979,53 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     } while (reg_off < reg_max);
 }
 
-#define DO_ST1_ZPZ_S(MEM, OFS, MSZ) \
-void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
-                                 void *vm, target_ulong base, uint32_t desc) \
-{                                                                            \
-    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,             \
-              off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb);       \
+static inline QEMU_ALWAYS_INLINE
+void sve_st1_z_mte(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
+                   target_ulong base, uint32_t desc, uintptr_t retaddr,
+                   int esize, int msize, zreg_off_fn *off_fn,
+                   sve_ldst1_host_fn *host_fn,
+                   sve_ldst1_tlb_fn *tlb_fn)
+{
+    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    /* Remove mtedesc from the normal sve descriptor. */
+    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+
+    /*
+     * ??? TODO: For the 32-bit offset extractions, base + ofs cannot
+     * offset base entirely over the address space hole to change the
+     * pointer tag, or change the bit55 selector.  So we could here
+     * examine TBI + TCMA like we do for sve_ldN_r_mte().
+     */
+    sve_st1_z(env, vd, vg, vm, base, desc, retaddr, mtedesc,
+              esize, msize, off_fn, host_fn, tlb_fn);
 }
 
-#define DO_ST1_ZPZ_D(MEM, OFS, MSZ) \
-void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+#define DO_ST1_ZPZ_S(MEM, OFS, MSZ)                                     \
+void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,  \
                                  void *vm, target_ulong base, uint32_t desc) \
-{                                                                            \
-    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,             \
-              off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb);       \
+{                                                                       \
+    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 4, 1 << MSZ,     \
+              off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb);  \
+}                                                                       \
+void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
+    void *vm, target_ulong base, uint32_t desc)                         \
+{                                                                       \
+    sve_st1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,    \
+                  off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
+}
+
+#define DO_ST1_ZPZ_D(MEM, OFS, MSZ)                                     \
+void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,  \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                       \
+    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 8, 1 << MSZ,     \
+              off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb);  \
+}                                                                       \
+void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
+    void *vm, target_ulong base, uint32_t desc)                         \
+{                                                                       \
+    sve_st1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,    \
+                  off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
 }
 
 DO_ST1_ZPZ_S(bs, zsu, MO_8)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ce67b79b02..d4525b9112 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5226,7 +5226,7 @@ static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a)
  */
 
 static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
-                       int scale, TCGv_i64 scalar, int msz,
+                       int scale, TCGv_i64 scalar, int msz, bool is_write,
                        gen_helper_gvec_mem_scatter *fn)
 {
     unsigned vsz = vec_full_reg_size(s);
@@ -5234,8 +5234,16 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     TCGv_ptr t_pg = tcg_temp_new_ptr();
     TCGv_ptr t_zt = tcg_temp_new_ptr();
     TCGv_i32 t_desc;
-    int desc;
+    int desc = 0;
 
+    if (s->mte_active[0]) {
+        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
+        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
+        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
+        desc <<= SVE_MTEDESC_SHIFT;
+    }
     desc = simd_desc(vsz, vsz, scale);
     t_desc = tcg_const_i32(desc);
 
@@ -5250,176 +5258,339 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     tcg_temp_free_i32(t_desc);
 }
 
-/* Indexed by [be][ff][xs][u][msz].  */
-static gen_helper_gvec_mem_scatter * const gather_load_fn32[2][2][2][2][3] = {
-    /* Little-endian */
-    { { { { gen_helper_sve_ldbss_zsu,
-            gen_helper_sve_ldhss_le_zsu,
-            NULL, },
-          { gen_helper_sve_ldbsu_zsu,
-            gen_helper_sve_ldhsu_le_zsu,
-            gen_helper_sve_ldss_le_zsu, } },
-        { { gen_helper_sve_ldbss_zss,
-            gen_helper_sve_ldhss_le_zss,
-            NULL, },
-          { gen_helper_sve_ldbsu_zss,
-            gen_helper_sve_ldhsu_le_zss,
-            gen_helper_sve_ldss_le_zss, } } },
+/* Indexed by [mte][be][ff][xs][u][msz].  */
+static gen_helper_gvec_mem_scatter * const
+gather_load_fn32[2][2][2][2][2][3] = {
+    { /* MTE Inactive */
+        { /* Little-endian */
+            { { { gen_helper_sve_ldbss_zsu,
+                  gen_helper_sve_ldhss_le_zsu,
+                  NULL, },
+                { gen_helper_sve_ldbsu_zsu,
+                  gen_helper_sve_ldhsu_le_zsu,
+                  gen_helper_sve_ldss_le_zsu, } },
+              { { gen_helper_sve_ldbss_zss,
+                  gen_helper_sve_ldhss_le_zss,
+                  NULL, },
+                { gen_helper_sve_ldbsu_zss,
+                  gen_helper_sve_ldhsu_le_zss,
+                  gen_helper_sve_ldss_le_zss, } } },
 
-      /* First-fault */
-      { { { gen_helper_sve_ldffbss_zsu,
-            gen_helper_sve_ldffhss_le_zsu,
-            NULL, },
-          { gen_helper_sve_ldffbsu_zsu,
-            gen_helper_sve_ldffhsu_le_zsu,
-            gen_helper_sve_ldffss_le_zsu, } },
-        { { gen_helper_sve_ldffbss_zss,
-            gen_helper_sve_ldffhss_le_zss,
-            NULL, },
-          { gen_helper_sve_ldffbsu_zss,
-            gen_helper_sve_ldffhsu_le_zss,
-            gen_helper_sve_ldffss_le_zss, } } } },
+            /* First-fault */
+            { { { gen_helper_sve_ldffbss_zsu,
+                  gen_helper_sve_ldffhss_le_zsu,
+                  NULL, },
+                { gen_helper_sve_ldffbsu_zsu,
+                  gen_helper_sve_ldffhsu_le_zsu,
+                  gen_helper_sve_ldffss_le_zsu, } },
+              { { gen_helper_sve_ldffbss_zss,
+                  gen_helper_sve_ldffhss_le_zss,
+                  NULL, },
+                { gen_helper_sve_ldffbsu_zss,
+                  gen_helper_sve_ldffhsu_le_zss,
+                  gen_helper_sve_ldffss_le_zss, } } } },
 
-    /* Big-endian */
-    { { { { gen_helper_sve_ldbss_zsu,
-            gen_helper_sve_ldhss_be_zsu,
-            NULL, },
-          { gen_helper_sve_ldbsu_zsu,
-            gen_helper_sve_ldhsu_be_zsu,
-            gen_helper_sve_ldss_be_zsu, } },
-        { { gen_helper_sve_ldbss_zss,
-            gen_helper_sve_ldhss_be_zss,
-            NULL, },
-          { gen_helper_sve_ldbsu_zss,
-            gen_helper_sve_ldhsu_be_zss,
-            gen_helper_sve_ldss_be_zss, } } },
+        { /* Big-endian */
+            { { { gen_helper_sve_ldbss_zsu,
+                  gen_helper_sve_ldhss_be_zsu,
+                  NULL, },
+                { gen_helper_sve_ldbsu_zsu,
+                  gen_helper_sve_ldhsu_be_zsu,
+                  gen_helper_sve_ldss_be_zsu, } },
+              { { gen_helper_sve_ldbss_zss,
+                  gen_helper_sve_ldhss_be_zss,
+                  NULL, },
+                { gen_helper_sve_ldbsu_zss,
+                  gen_helper_sve_ldhsu_be_zss,
+                  gen_helper_sve_ldss_be_zss, } } },
 
-      /* First-fault */
-      { { { gen_helper_sve_ldffbss_zsu,
-            gen_helper_sve_ldffhss_be_zsu,
-            NULL, },
-          { gen_helper_sve_ldffbsu_zsu,
-            gen_helper_sve_ldffhsu_be_zsu,
-            gen_helper_sve_ldffss_be_zsu, } },
-        { { gen_helper_sve_ldffbss_zss,
-            gen_helper_sve_ldffhss_be_zss,
-            NULL, },
-          { gen_helper_sve_ldffbsu_zss,
-            gen_helper_sve_ldffhsu_be_zss,
-            gen_helper_sve_ldffss_be_zss, } } } },
+            /* First-fault */
+            { { { gen_helper_sve_ldffbss_zsu,
+                  gen_helper_sve_ldffhss_be_zsu,
+                  NULL, },
+                { gen_helper_sve_ldffbsu_zsu,
+                  gen_helper_sve_ldffhsu_be_zsu,
+                  gen_helper_sve_ldffss_be_zsu, } },
+              { { gen_helper_sve_ldffbss_zss,
+                  gen_helper_sve_ldffhss_be_zss,
+                  NULL, },
+                { gen_helper_sve_ldffbsu_zss,
+                  gen_helper_sve_ldffhsu_be_zss,
+                  gen_helper_sve_ldffss_be_zss, } } } } },
+    { /* MTE Active */
+        { /* Little-endian */
+            { { { gen_helper_sve_ldbss_zsu_mte,
+                  gen_helper_sve_ldhss_le_zsu_mte,
+                  NULL, },
+                { gen_helper_sve_ldbsu_zsu_mte,
+                  gen_helper_sve_ldhsu_le_zsu_mte,
+                  gen_helper_sve_ldss_le_zsu_mte, } },
+              { { gen_helper_sve_ldbss_zss_mte,
+                  gen_helper_sve_ldhss_le_zss_mte,
+                  NULL, },
+                { gen_helper_sve_ldbsu_zss_mte,
+                  gen_helper_sve_ldhsu_le_zss_mte,
+                  gen_helper_sve_ldss_le_zss_mte, } } },
+
+            /* First-fault */
+            { { { gen_helper_sve_ldffbss_zsu_mte,
+                  gen_helper_sve_ldffhss_le_zsu_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbsu_zsu_mte,
+                  gen_helper_sve_ldffhsu_le_zsu_mte,
+                  gen_helper_sve_ldffss_le_zsu_mte, } },
+              { { gen_helper_sve_ldffbss_zss_mte,
+                  gen_helper_sve_ldffhss_le_zss_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbsu_zss_mte,
+                  gen_helper_sve_ldffhsu_le_zss_mte,
+                  gen_helper_sve_ldffss_le_zss_mte, } } } },
+
+        { /* Big-endian */
+            { { { gen_helper_sve_ldbss_zsu_mte,
+                  gen_helper_sve_ldhss_be_zsu_mte,
+                  NULL, },
+                { gen_helper_sve_ldbsu_zsu_mte,
+                  gen_helper_sve_ldhsu_be_zsu_mte,
+                  gen_helper_sve_ldss_be_zsu_mte, } },
+              { { gen_helper_sve_ldbss_zss_mte,
+                  gen_helper_sve_ldhss_be_zss_mte,
+                  NULL, },
+                { gen_helper_sve_ldbsu_zss_mte,
+                  gen_helper_sve_ldhsu_be_zss_mte,
+                  gen_helper_sve_ldss_be_zss_mte, } } },
+
+            /* First-fault */
+            { { { gen_helper_sve_ldffbss_zsu_mte,
+                  gen_helper_sve_ldffhss_be_zsu_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbsu_zsu_mte,
+                  gen_helper_sve_ldffhsu_be_zsu_mte,
+                  gen_helper_sve_ldffss_be_zsu_mte, } },
+              { { gen_helper_sve_ldffbss_zss_mte,
+                  gen_helper_sve_ldffhss_be_zss_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbsu_zss_mte,
+                  gen_helper_sve_ldffhsu_be_zss_mte,
+                  gen_helper_sve_ldffss_be_zss_mte, } } } } },
 };
 
 /* Note that we overload xs=2 to indicate 64-bit offset.  */
-static gen_helper_gvec_mem_scatter * const gather_load_fn64[2][2][3][2][4] = {
-    /* Little-endian */
-    { { { { gen_helper_sve_ldbds_zsu,
-            gen_helper_sve_ldhds_le_zsu,
-            gen_helper_sve_ldsds_le_zsu,
-            NULL, },
-          { gen_helper_sve_ldbdu_zsu,
-            gen_helper_sve_ldhdu_le_zsu,
-            gen_helper_sve_ldsdu_le_zsu,
-            gen_helper_sve_lddd_le_zsu, } },
-        { { gen_helper_sve_ldbds_zss,
-            gen_helper_sve_ldhds_le_zss,
-            gen_helper_sve_ldsds_le_zss,
-            NULL, },
-          { gen_helper_sve_ldbdu_zss,
-            gen_helper_sve_ldhdu_le_zss,
-            gen_helper_sve_ldsdu_le_zss,
-            gen_helper_sve_lddd_le_zss, } },
-        { { gen_helper_sve_ldbds_zd,
-            gen_helper_sve_ldhds_le_zd,
-            gen_helper_sve_ldsds_le_zd,
-            NULL, },
-          { gen_helper_sve_ldbdu_zd,
-            gen_helper_sve_ldhdu_le_zd,
-            gen_helper_sve_ldsdu_le_zd,
-            gen_helper_sve_lddd_le_zd, } } },
+static gen_helper_gvec_mem_scatter * const
+gather_load_fn64[2][2][2][3][2][4] = {
+    { /* MTE Inactive */
+        { /* Little-endian */
+            { { { gen_helper_sve_ldbds_zsu,
+                  gen_helper_sve_ldhds_le_zsu,
+                  gen_helper_sve_ldsds_le_zsu,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zsu,
+                  gen_helper_sve_ldhdu_le_zsu,
+                  gen_helper_sve_ldsdu_le_zsu,
+                  gen_helper_sve_lddd_le_zsu, } },
+              { { gen_helper_sve_ldbds_zss,
+                  gen_helper_sve_ldhds_le_zss,
+                  gen_helper_sve_ldsds_le_zss,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zss,
+                  gen_helper_sve_ldhdu_le_zss,
+                  gen_helper_sve_ldsdu_le_zss,
+                  gen_helper_sve_lddd_le_zss, } },
+              { { gen_helper_sve_ldbds_zd,
+                  gen_helper_sve_ldhds_le_zd,
+                  gen_helper_sve_ldsds_le_zd,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zd,
+                  gen_helper_sve_ldhdu_le_zd,
+                  gen_helper_sve_ldsdu_le_zd,
+                  gen_helper_sve_lddd_le_zd, } } },
 
-      /* First-fault */
-      { { { gen_helper_sve_ldffbds_zsu,
-            gen_helper_sve_ldffhds_le_zsu,
-            gen_helper_sve_ldffsds_le_zsu,
-            NULL, },
-          { gen_helper_sve_ldffbdu_zsu,
-            gen_helper_sve_ldffhdu_le_zsu,
-            gen_helper_sve_ldffsdu_le_zsu,
-            gen_helper_sve_ldffdd_le_zsu, } },
-        { { gen_helper_sve_ldffbds_zss,
-            gen_helper_sve_ldffhds_le_zss,
-            gen_helper_sve_ldffsds_le_zss,
-            NULL, },
-          { gen_helper_sve_ldffbdu_zss,
-            gen_helper_sve_ldffhdu_le_zss,
-            gen_helper_sve_ldffsdu_le_zss,
-            gen_helper_sve_ldffdd_le_zss, } },
-        { { gen_helper_sve_ldffbds_zd,
-            gen_helper_sve_ldffhds_le_zd,
-            gen_helper_sve_ldffsds_le_zd,
-            NULL, },
-          { gen_helper_sve_ldffbdu_zd,
-            gen_helper_sve_ldffhdu_le_zd,
-            gen_helper_sve_ldffsdu_le_zd,
-            gen_helper_sve_ldffdd_le_zd, } } } },
+            /* First-fault */
+            { { { gen_helper_sve_ldffbds_zsu,
+                  gen_helper_sve_ldffhds_le_zsu,
+                  gen_helper_sve_ldffsds_le_zsu,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zsu,
+                  gen_helper_sve_ldffhdu_le_zsu,
+                  gen_helper_sve_ldffsdu_le_zsu,
+                  gen_helper_sve_ldffdd_le_zsu, } },
+              { { gen_helper_sve_ldffbds_zss,
+                  gen_helper_sve_ldffhds_le_zss,
+                  gen_helper_sve_ldffsds_le_zss,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zss,
+                  gen_helper_sve_ldffhdu_le_zss,
+                  gen_helper_sve_ldffsdu_le_zss,
+                  gen_helper_sve_ldffdd_le_zss, } },
+              { { gen_helper_sve_ldffbds_zd,
+                  gen_helper_sve_ldffhds_le_zd,
+                  gen_helper_sve_ldffsds_le_zd,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zd,
+                  gen_helper_sve_ldffhdu_le_zd,
+                  gen_helper_sve_ldffsdu_le_zd,
+                  gen_helper_sve_ldffdd_le_zd, } } } },
+        { /* Big-endian */
+            { { { gen_helper_sve_ldbds_zsu,
+                  gen_helper_sve_ldhds_be_zsu,
+                  gen_helper_sve_ldsds_be_zsu,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zsu,
+                  gen_helper_sve_ldhdu_be_zsu,
+                  gen_helper_sve_ldsdu_be_zsu,
+                  gen_helper_sve_lddd_be_zsu, } },
+              { { gen_helper_sve_ldbds_zss,
+                  gen_helper_sve_ldhds_be_zss,
+                  gen_helper_sve_ldsds_be_zss,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zss,
+                  gen_helper_sve_ldhdu_be_zss,
+                  gen_helper_sve_ldsdu_be_zss,
+                  gen_helper_sve_lddd_be_zss, } },
+              { { gen_helper_sve_ldbds_zd,
+                  gen_helper_sve_ldhds_be_zd,
+                  gen_helper_sve_ldsds_be_zd,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zd,
+                  gen_helper_sve_ldhdu_be_zd,
+                  gen_helper_sve_ldsdu_be_zd,
+                  gen_helper_sve_lddd_be_zd, } } },
 
-    /* Big-endian */
-    { { { { gen_helper_sve_ldbds_zsu,
-            gen_helper_sve_ldhds_be_zsu,
-            gen_helper_sve_ldsds_be_zsu,
-            NULL, },
-          { gen_helper_sve_ldbdu_zsu,
-            gen_helper_sve_ldhdu_be_zsu,
-            gen_helper_sve_ldsdu_be_zsu,
-            gen_helper_sve_lddd_be_zsu, } },
-        { { gen_helper_sve_ldbds_zss,
-            gen_helper_sve_ldhds_be_zss,
-            gen_helper_sve_ldsds_be_zss,
-            NULL, },
-          { gen_helper_sve_ldbdu_zss,
-            gen_helper_sve_ldhdu_be_zss,
-            gen_helper_sve_ldsdu_be_zss,
-            gen_helper_sve_lddd_be_zss, } },
-        { { gen_helper_sve_ldbds_zd,
-            gen_helper_sve_ldhds_be_zd,
-            gen_helper_sve_ldsds_be_zd,
-            NULL, },
-          { gen_helper_sve_ldbdu_zd,
-            gen_helper_sve_ldhdu_be_zd,
-            gen_helper_sve_ldsdu_be_zd,
-            gen_helper_sve_lddd_be_zd, } } },
+            /* First-fault */
+            { { { gen_helper_sve_ldffbds_zsu,
+                  gen_helper_sve_ldffhds_be_zsu,
+                  gen_helper_sve_ldffsds_be_zsu,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zsu,
+                  gen_helper_sve_ldffhdu_be_zsu,
+                  gen_helper_sve_ldffsdu_be_zsu,
+                  gen_helper_sve_ldffdd_be_zsu, } },
+              { { gen_helper_sve_ldffbds_zss,
+                  gen_helper_sve_ldffhds_be_zss,
+                  gen_helper_sve_ldffsds_be_zss,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zss,
+                  gen_helper_sve_ldffhdu_be_zss,
+                  gen_helper_sve_ldffsdu_be_zss,
+                  gen_helper_sve_ldffdd_be_zss, } },
+              { { gen_helper_sve_ldffbds_zd,
+                  gen_helper_sve_ldffhds_be_zd,
+                  gen_helper_sve_ldffsds_be_zd,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zd,
+                  gen_helper_sve_ldffhdu_be_zd,
+                  gen_helper_sve_ldffsdu_be_zd,
+                  gen_helper_sve_ldffdd_be_zd, } } } } },
+    { /* MTE Active */
+        { /* Little-endian */
+            { { { gen_helper_sve_ldbds_zsu_mte,
+                  gen_helper_sve_ldhds_le_zsu_mte,
+                  gen_helper_sve_ldsds_le_zsu_mte,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zsu_mte,
+                  gen_helper_sve_ldhdu_le_zsu_mte,
+                  gen_helper_sve_ldsdu_le_zsu_mte,
+                  gen_helper_sve_lddd_le_zsu_mte, } },
+              { { gen_helper_sve_ldbds_zss_mte,
+                  gen_helper_sve_ldhds_le_zss_mte,
+                  gen_helper_sve_ldsds_le_zss_mte,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zss_mte,
+                  gen_helper_sve_ldhdu_le_zss_mte,
+                  gen_helper_sve_ldsdu_le_zss_mte,
+                  gen_helper_sve_lddd_le_zss_mte, } },
+              { { gen_helper_sve_ldbds_zd_mte,
+                  gen_helper_sve_ldhds_le_zd_mte,
+                  gen_helper_sve_ldsds_le_zd_mte,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zd_mte,
+                  gen_helper_sve_ldhdu_le_zd_mte,
+                  gen_helper_sve_ldsdu_le_zd_mte,
+                  gen_helper_sve_lddd_le_zd_mte, } } },
 
-      /* First-fault */
-      { { { gen_helper_sve_ldffbds_zsu,
-            gen_helper_sve_ldffhds_be_zsu,
-            gen_helper_sve_ldffsds_be_zsu,
-            NULL, },
-          { gen_helper_sve_ldffbdu_zsu,
-            gen_helper_sve_ldffhdu_be_zsu,
-            gen_helper_sve_ldffsdu_be_zsu,
-            gen_helper_sve_ldffdd_be_zsu, } },
-        { { gen_helper_sve_ldffbds_zss,
-            gen_helper_sve_ldffhds_be_zss,
-            gen_helper_sve_ldffsds_be_zss,
-            NULL, },
-          { gen_helper_sve_ldffbdu_zss,
-            gen_helper_sve_ldffhdu_be_zss,
-            gen_helper_sve_ldffsdu_be_zss,
-            gen_helper_sve_ldffdd_be_zss, } },
-        { { gen_helper_sve_ldffbds_zd,
-            gen_helper_sve_ldffhds_be_zd,
-            gen_helper_sve_ldffsds_be_zd,
-            NULL, },
-          { gen_helper_sve_ldffbdu_zd,
-            gen_helper_sve_ldffhdu_be_zd,
-            gen_helper_sve_ldffsdu_be_zd,
-            gen_helper_sve_ldffdd_be_zd, } } } },
+            /* First-fault */
+            { { { gen_helper_sve_ldffbds_zsu_mte,
+                  gen_helper_sve_ldffhds_le_zsu_mte,
+                  gen_helper_sve_ldffsds_le_zsu_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zsu_mte,
+                  gen_helper_sve_ldffhdu_le_zsu_mte,
+                  gen_helper_sve_ldffsdu_le_zsu_mte,
+                  gen_helper_sve_ldffdd_le_zsu_mte, } },
+              { { gen_helper_sve_ldffbds_zss_mte,
+                  gen_helper_sve_ldffhds_le_zss_mte,
+                  gen_helper_sve_ldffsds_le_zss_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zss_mte,
+                  gen_helper_sve_ldffhdu_le_zss_mte,
+                  gen_helper_sve_ldffsdu_le_zss_mte,
+                  gen_helper_sve_ldffdd_le_zss_mte, } },
+              { { gen_helper_sve_ldffbds_zd_mte,
+                  gen_helper_sve_ldffhds_le_zd_mte,
+                  gen_helper_sve_ldffsds_le_zd_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zd_mte,
+                  gen_helper_sve_ldffhdu_le_zd_mte,
+                  gen_helper_sve_ldffsdu_le_zd_mte,
+                  gen_helper_sve_ldffdd_le_zd_mte, } } } },
+        { /* Big-endian */
+            { { { gen_helper_sve_ldbds_zsu_mte,
+                  gen_helper_sve_ldhds_be_zsu_mte,
+                  gen_helper_sve_ldsds_be_zsu_mte,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zsu_mte,
+                  gen_helper_sve_ldhdu_be_zsu_mte,
+                  gen_helper_sve_ldsdu_be_zsu_mte,
+                  gen_helper_sve_lddd_be_zsu_mte, } },
+              { { gen_helper_sve_ldbds_zss_mte,
+                  gen_helper_sve_ldhds_be_zss_mte,
+                  gen_helper_sve_ldsds_be_zss_mte,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zss_mte,
+                  gen_helper_sve_ldhdu_be_zss_mte,
+                  gen_helper_sve_ldsdu_be_zss_mte,
+                  gen_helper_sve_lddd_be_zss_mte, } },
+              { { gen_helper_sve_ldbds_zd_mte,
+                  gen_helper_sve_ldhds_be_zd_mte,
+                  gen_helper_sve_ldsds_be_zd_mte,
+                  NULL, },
+                { gen_helper_sve_ldbdu_zd_mte,
+                  gen_helper_sve_ldhdu_be_zd_mte,
+                  gen_helper_sve_ldsdu_be_zd_mte,
+                  gen_helper_sve_lddd_be_zd_mte, } } },
+
+            /* First-fault */
+            { { { gen_helper_sve_ldffbds_zsu_mte,
+                  gen_helper_sve_ldffhds_be_zsu_mte,
+                  gen_helper_sve_ldffsds_be_zsu_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zsu_mte,
+                  gen_helper_sve_ldffhdu_be_zsu_mte,
+                  gen_helper_sve_ldffsdu_be_zsu_mte,
+                  gen_helper_sve_ldffdd_be_zsu_mte, } },
+              { { gen_helper_sve_ldffbds_zss_mte,
+                  gen_helper_sve_ldffhds_be_zss_mte,
+                  gen_helper_sve_ldffsds_be_zss_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zss_mte,
+                  gen_helper_sve_ldffhdu_be_zss_mte,
+                  gen_helper_sve_ldffsdu_be_zss_mte,
+                  gen_helper_sve_ldffdd_be_zss_mte, } },
+              { { gen_helper_sve_ldffbds_zd_mte,
+                  gen_helper_sve_ldffhds_be_zd_mte,
+                  gen_helper_sve_ldffsds_be_zd_mte,
+                  NULL, },
+                { gen_helper_sve_ldffbdu_zd_mte,
+                  gen_helper_sve_ldffhdu_be_zd_mte,
+                  gen_helper_sve_ldffsdu_be_zd_mte,
+                  gen_helper_sve_ldffdd_be_zd_mte, } } } } },
 };
 
 static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
-    int be = s->be_data == MO_BE;
+    bool be = s->be_data == MO_BE;
+    bool mte = s->mte_active[0];
 
     if (!sve_access_check(s)) {
         return true;
@@ -5427,23 +5598,24 @@ static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a)
 
     switch (a->esz) {
     case MO_32:
-        fn = gather_load_fn32[be][a->ff][a->xs][a->u][a->msz];
+        fn = gather_load_fn32[mte][be][a->ff][a->xs][a->u][a->msz];
         break;
     case MO_64:
-        fn = gather_load_fn64[be][a->ff][a->xs][a->u][a->msz];
+        fn = gather_load_fn64[mte][be][a->ff][a->xs][a->u][a->msz];
         break;
     }
     assert(fn != NULL);
 
     do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
-               cpu_reg_sp(s, a->rn), a->msz, fn);
+               cpu_reg_sp(s, a->rn), a->msz, false, fn);
     return true;
 }
 
 static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
-    int be = s->be_data == MO_BE;
+    bool be = s->be_data == MO_BE;
+    bool mte = s->mte_active[0];
     TCGv_i64 imm;
 
     if (a->esz < a->msz || (a->esz == a->msz && !a->u)) {
@@ -5455,10 +5627,10 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
 
     switch (a->esz) {
     case MO_32:
-        fn = gather_load_fn32[be][a->ff][0][a->u][a->msz];
+        fn = gather_load_fn32[mte][be][a->ff][0][a->u][a->msz];
         break;
     case MO_64:
-        fn = gather_load_fn64[be][a->ff][2][a->u][a->msz];
+        fn = gather_load_fn64[mte][be][a->ff][2][a->u][a->msz];
         break;
     }
     assert(fn != NULL);
@@ -5467,63 +5639,108 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
      * by loading the immediate into the scalar parameter.
      */
     imm = tcg_const_i64(a->imm << a->msz);
-    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, a->msz, fn);
+    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, a->msz, false, fn);
     tcg_temp_free_i64(imm);
     return true;
 }
 
-/* Indexed by [be][xs][msz].  */
-static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][2][3] = {
-    /* Little-endian */
-    { { gen_helper_sve_stbs_zsu,
-        gen_helper_sve_sths_le_zsu,
-        gen_helper_sve_stss_le_zsu, },
-      { gen_helper_sve_stbs_zss,
-        gen_helper_sve_sths_le_zss,
-        gen_helper_sve_stss_le_zss, } },
-    /* Big-endian */
-    { { gen_helper_sve_stbs_zsu,
-        gen_helper_sve_sths_be_zsu,
-        gen_helper_sve_stss_be_zsu, },
-      { gen_helper_sve_stbs_zss,
-        gen_helper_sve_sths_be_zss,
-        gen_helper_sve_stss_be_zss, } },
+/* Indexed by [mte][be][xs][msz].  */
+static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][2][2][3] = {
+    { /* MTE Inactive */
+        { /* Little-endian */
+            { gen_helper_sve_stbs_zsu,
+              gen_helper_sve_sths_le_zsu,
+              gen_helper_sve_stss_le_zsu, },
+            { gen_helper_sve_stbs_zss,
+              gen_helper_sve_sths_le_zss,
+              gen_helper_sve_stss_le_zss, } },
+        { /* Big-endian */
+            { gen_helper_sve_stbs_zsu,
+              gen_helper_sve_sths_be_zsu,
+              gen_helper_sve_stss_be_zsu, },
+            { gen_helper_sve_stbs_zss,
+              gen_helper_sve_sths_be_zss,
+              gen_helper_sve_stss_be_zss, } } },
+    { /* MTE Active */
+        { /* Little-endian */
+            { gen_helper_sve_stbs_zsu_mte,
+              gen_helper_sve_sths_le_zsu_mte,
+              gen_helper_sve_stss_le_zsu_mte, },
+            { gen_helper_sve_stbs_zss_mte,
+              gen_helper_sve_sths_le_zss_mte,
+              gen_helper_sve_stss_le_zss_mte, } },
+        { /* Big-endian */
+            { gen_helper_sve_stbs_zsu_mte,
+              gen_helper_sve_sths_be_zsu_mte,
+              gen_helper_sve_stss_be_zsu_mte, },
+            { gen_helper_sve_stbs_zss_mte,
+              gen_helper_sve_sths_be_zss_mte,
+              gen_helper_sve_stss_be_zss_mte, } } },
 };
 
 /* Note that we overload xs=2 to indicate 64-bit offset.  */
-static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][3][4] = {
-    /* Little-endian */
-    { { gen_helper_sve_stbd_zsu,
-        gen_helper_sve_sthd_le_zsu,
-        gen_helper_sve_stsd_le_zsu,
-        gen_helper_sve_stdd_le_zsu, },
-      { gen_helper_sve_stbd_zss,
-        gen_helper_sve_sthd_le_zss,
-        gen_helper_sve_stsd_le_zss,
-        gen_helper_sve_stdd_le_zss, },
-      { gen_helper_sve_stbd_zd,
-        gen_helper_sve_sthd_le_zd,
-        gen_helper_sve_stsd_le_zd,
-        gen_helper_sve_stdd_le_zd, } },
-    /* Big-endian */
-    { { gen_helper_sve_stbd_zsu,
-        gen_helper_sve_sthd_be_zsu,
-        gen_helper_sve_stsd_be_zsu,
-        gen_helper_sve_stdd_be_zsu, },
-      { gen_helper_sve_stbd_zss,
-        gen_helper_sve_sthd_be_zss,
-        gen_helper_sve_stsd_be_zss,
-        gen_helper_sve_stdd_be_zss, },
-      { gen_helper_sve_stbd_zd,
-        gen_helper_sve_sthd_be_zd,
-        gen_helper_sve_stsd_be_zd,
-        gen_helper_sve_stdd_be_zd, } },
+static gen_helper_gvec_mem_scatter * const scatter_store_fn64[2][2][3][4] = {
+    { /* MTE Inactive */
+         { /* Little-endian */
+             { gen_helper_sve_stbd_zsu,
+               gen_helper_sve_sthd_le_zsu,
+               gen_helper_sve_stsd_le_zsu,
+               gen_helper_sve_stdd_le_zsu, },
+             { gen_helper_sve_stbd_zss,
+               gen_helper_sve_sthd_le_zss,
+               gen_helper_sve_stsd_le_zss,
+               gen_helper_sve_stdd_le_zss, },
+             { gen_helper_sve_stbd_zd,
+               gen_helper_sve_sthd_le_zd,
+               gen_helper_sve_stsd_le_zd,
+               gen_helper_sve_stdd_le_zd, } },
+         { /* Big-endian */
+             { gen_helper_sve_stbd_zsu,
+               gen_helper_sve_sthd_be_zsu,
+               gen_helper_sve_stsd_be_zsu,
+               gen_helper_sve_stdd_be_zsu, },
+             { gen_helper_sve_stbd_zss,
+               gen_helper_sve_sthd_be_zss,
+               gen_helper_sve_stsd_be_zss,
+               gen_helper_sve_stdd_be_zss, },
+             { gen_helper_sve_stbd_zd,
+               gen_helper_sve_sthd_be_zd,
+               gen_helper_sve_stsd_be_zd,
+               gen_helper_sve_stdd_be_zd, } } },
+    { /* MTE Inactive */
+         { /* Little-endian */
+             { gen_helper_sve_stbd_zsu_mte,
+               gen_helper_sve_sthd_le_zsu_mte,
+               gen_helper_sve_stsd_le_zsu_mte,
+               gen_helper_sve_stdd_le_zsu_mte, },
+             { gen_helper_sve_stbd_zss_mte,
+               gen_helper_sve_sthd_le_zss_mte,
+               gen_helper_sve_stsd_le_zss_mte,
+               gen_helper_sve_stdd_le_zss_mte, },
+             { gen_helper_sve_stbd_zd_mte,
+               gen_helper_sve_sthd_le_zd_mte,
+               gen_helper_sve_stsd_le_zd_mte,
+               gen_helper_sve_stdd_le_zd_mte, } },
+         { /* Big-endian */
+             { gen_helper_sve_stbd_zsu_mte,
+               gen_helper_sve_sthd_be_zsu_mte,
+               gen_helper_sve_stsd_be_zsu_mte,
+               gen_helper_sve_stdd_be_zsu_mte, },
+             { gen_helper_sve_stbd_zss_mte,
+               gen_helper_sve_sthd_be_zss_mte,
+               gen_helper_sve_stsd_be_zss_mte,
+               gen_helper_sve_stdd_be_zss_mte, },
+             { gen_helper_sve_stbd_zd_mte,
+               gen_helper_sve_sthd_be_zd_mte,
+               gen_helper_sve_stsd_be_zd_mte,
+               gen_helper_sve_stdd_be_zd_mte, } } },
 };
 
 static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
 {
     gen_helper_gvec_mem_scatter *fn;
-    int be = s->be_data == MO_BE;
+    bool be = s->be_data == MO_BE;
+    bool mte = s->mte_active[0];
 
     if (a->esz < a->msz || (a->msz == 0 && a->scale)) {
         return false;
@@ -5533,23 +5750,24 @@ static bool trans_ST1_zprz(DisasContext *s, arg_ST1_zprz *a)
     }
     switch (a->esz) {
     case MO_32:
-        fn = scatter_store_fn32[be][a->xs][a->msz];
+        fn = scatter_store_fn32[mte][be][a->xs][a->msz];
         break;
     case MO_64:
-        fn = scatter_store_fn64[be][a->xs][a->msz];
+        fn = scatter_store_fn64[mte][be][a->xs][a->msz];
         break;
     default:
         g_assert_not_reached();
     }
     do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
-               cpu_reg_sp(s, a->rn), a->msz, fn);
+               cpu_reg_sp(s, a->rn), a->msz, true, fn);
     return true;
 }
 
 static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
 {
     gen_helper_gvec_mem_scatter *fn = NULL;
-    int be = s->be_data == MO_BE;
+    bool be = s->be_data == MO_BE;
+    bool mte = s->mte_active[0];
     TCGv_i64 imm;
 
     if (a->esz < a->msz) {
@@ -5561,10 +5779,10 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
 
     switch (a->esz) {
     case MO_32:
-        fn = scatter_store_fn32[be][0][a->msz];
+        fn = scatter_store_fn32[mte][be][0][a->msz];
         break;
     case MO_64:
-        fn = scatter_store_fn64[be][2][a->msz];
+        fn = scatter_store_fn64[mte][be][2][a->msz];
         break;
     }
     assert(fn != NULL);
@@ -5573,7 +5791,7 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
      * by loading the immediate into the scalar parameter.
      */
     imm = tcg_const_i64(a->imm << a->msz);
-    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, a->msz, fn);
+    do_mem_zpz(s, a->rd, a->pg, a->rn, 0, imm, a->msz, true, fn);
     tcg_temp_free_i64(imm);
     return true;
 }
-- 
2.20.1


