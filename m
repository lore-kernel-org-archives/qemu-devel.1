Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC771C38A2F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4B12076A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rb9WgWKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4B12076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPp6D-0005f9-Tr
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp16-00079M-RI
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp15-0003T6-MO
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:24 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPp15-0003R3-Gg
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:23 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kb16so2469589pjb.1
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6wR3Zr8XJfJQ9/S/T3rAi9WBRdsZYxCEV7NAimr7My8=;
 b=rb9WgWKnPtm949f3mlSzS8H844iFBeZ1hvnXl8Ea3Tjpp2fC80dLkwMU7tvrTa8ii3
 0L+TKzmjbteiKh+Ahsm8hYAGJVT8HZTJ6fqSmcqArNMaFrpJvCn4xRGcXhXuapzbBDqI
 5Hu46GfJ8W+DYofAG307lily13uBxydYlpvIVhCQ6MnV8ZtISyGqOXndK0gGX/U9WFgM
 VcD/xTH2Mpo/4JALD2mXzVd3vXvwOIIbPVDWt99tR3Uwdzvke02I47rkxbXkPlGxD2Oj
 9JXypTDif1pSrWJyCiv9FGqVYH4F4ZP5jhJi6Zrym/FUSJDGk/A2ebocJuUdWdrWSU98
 LWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6wR3Zr8XJfJQ9/S/T3rAi9WBRdsZYxCEV7NAimr7My8=;
 b=CqPndZ5lLlO7wmlQGQEQvWCb62kosulhFe8I2EypdwdAAGWvUOABDlMgiVryRostiV
 HOSOedPMY4VNnA6guS/KQRxxdUa1HMJgGvxj9gVI58tlCnI2xyOAszCXM5ltgJamMvl4
 exnLB6COb8YPswE2OOTBEXrvR991jPdHStwflCtZkOhluZSDLm2iZkboMM7gYLBXAIF0
 uDfTlThFbk14fn/xu+efntmAAUTywUQZRPOvM1KHgh+5N2shCsNdCeYJj9ZS19ZdYxrd
 kQvRv8bwqyRQKxdXwTC8KVbLs8++0kGFtA1gq5zYPDXfH04ZzCmdfi9SZqlY5cIgOahO
 PogQ==
X-Gm-Message-State: AGi0PuaA51ONN+q+ylo57rtQNfkmYusL9Q6mfluPdq5/jE2DHPU6vnVP
 y4JqiMoHBcQ17F75G2fPt5JMVwTFNHs=
X-Google-Smtp-Source: APiQypJF50sqDa2TFnV4niHCaqQNhvzogu5BP9eye1VdMgsHgaB/oBcwoSbU6d1wmVMH5EeSBl1viw==
X-Received: by 2002:a17:902:8d86:: with SMTP id
 v6mr8821583plo.57.1587222261978; 
 Sat, 18 Apr 2020 08:04:21 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t103sm8668601pjb.46.2020.04.18.08.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:04:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] tcg: Use tcg_gen_gvec_dup_imm in logical simplifications
Date: Sat, 18 Apr 2020 08:04:09 -0700
Message-Id: <20200418150411.1831-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418150411.1831-1-richard.henderson@linaro.org>
References: <20200418150411.1831-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: peter.maydell@linaro.org, david@redhat.com, zhiwei_liu@c-sky.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the outgoing interface.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 593bb4542e..de16c027b3 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2326,7 +2326,7 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2343,7 +2343,7 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2360,7 +2360,7 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2411,7 +2411,7 @@ void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
-- 
2.20.1


