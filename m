Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10063C10F25
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 01:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41B5206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 01:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTDo5djy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41B5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAkmq-0008KI-35
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 20:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jAklQ-0006tE-R2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jAklP-0003wS-Pz
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:56 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jAklP-0003vY-L7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 20:29:55 -0500
Received: by mail-pg1-x541.google.com with SMTP id u12so3002323pgb.10
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 17:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gv99y10Tw9XL58AqjJTwfCMl/voN1k409rbwq+MWA5w=;
 b=jTDo5djyrC5CDMffAiqEM6L8KRzo65+Pi1blQ5PfCBPHKLWOSyFOm6HQWQEqawqLAn
 bR7eqk3COWKbtWxCjWey+hV2NjqMibb+J+3WSwyXYiamlsBdurbWgQPHRRojTTRQqkOB
 r7SIIYHOP2fAFsQPPyKiW2fFyDPiW64ukmurkzAmlMMEOy/WdFV4OY+6aqBmAcSGRh1Y
 mB823cD9c/6edxSkiViMVdx/1BkxH5WcI/sfVrjbz/L19psV1eVnXTYikHzGiA9hELTg
 +p15rFEeCrC6W7kxq5e7F+Y01wLAlAwsFOGs4oWIACKPsFHgmjyhwdy45mIel6sLXJ7Y
 Hxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gv99y10Tw9XL58AqjJTwfCMl/voN1k409rbwq+MWA5w=;
 b=P1mextZdi1S6VReXqMPGgD0VWLgCqCOQhhBei3NdWf7qThJ3MR0/RzZOr8YTheCjL7
 DsHYGa1MSDsLyzDFl/eP/+09FPLvxCas5gpt9v1oIYbxOATo5wy1IaFHXsJstknQK155
 pOunLs3Yw1pFVdo4icOLzYEtbg/5Ltq9TB+2h1Hkr1R3pRYyQr2cVtXs4fnHE4p7OhVV
 RPechlnCNva0B57v9ZElehidrbUxtQm3EIow6M8l5lXH9wySNpTV0rXISbnOIKzAKp3G
 dKJjidP7y4+4CAOy+kqVO5QaSr8z/3hT/I9TNSzOrMYo9j2hPI53GNO3QL3mi8YSJMWh
 k1jg==
X-Gm-Message-State: ANhLgQ3E+Tb+kKzcvF6jbQlDBDliUVdLDZqEntKzkf59AUAk6rqFI7fs
 5SAvG9AjzGQa/q+LJ3r1dIPl/kdjhvI=
X-Google-Smtp-Source: ADFU+vsWCCdF6tufcI9iZw18JdbcoJImWsz1pmm8DwZDnTmH4FFAcj5YLN+UFyIZ41CuL+1SpQoMVw==
X-Received: by 2002:a63:8f17:: with SMTP id n23mr10567818pgd.161.1583630994169; 
 Sat, 07 Mar 2020 17:29:54 -0800 (PST)
Received: from cloudburst.hsd1.or.comcast.net
 ([2601:1c0:6100:5580:6886:21be:91dd:78be])
 by smtp.gmail.com with ESMTPSA id w19sm32636891pgm.27.2020.03.07.17.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 17:29:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] target/arm: Disable clean_data_tbi for system mode
Date: Sat,  7 Mar 2020 17:29:46 -0800
Message-Id: <20200308012946.16303-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200308012946.16303-1-richard.henderson@linaro.org>
References: <20200308012946.16303-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must include the tag in the FAR_ELx register when raising
an addressing exception.  Which means that we should not clear
out the tag during translation.

We cannot at present comply with this for user mode, so we
retain the clean_data_tbi function for the moment, though it
no longer does what it says on the tin for system mode.  This
function is to be replaced with MTE, so don't worry about the
slight misnaming.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fefe8af7f5..8fffb52203 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -228,7 +228,18 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
 static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
 {
     TCGv_i64 clean = new_tmp_a64(s);
+    /*
+     * In order to get the correct value in the FAR_ELx register,
+     * we must present the memory subsystem with the "dirty" address
+     * including the TBI.  In system mode we can make this work via
+     * the TLB, dropping the TBI during translation.  But for user-only
+     * mode we don't have that option, and must remove the top byte now.
+     */
+#ifdef CONFIG_USER_ONLY
     gen_top_byte_ignore(s, clean, addr, s->tbid);
+#else
+    tcg_gen_mov_i64(clean, addr);
+#endif
     return clean;
 }
 
-- 
2.20.1


