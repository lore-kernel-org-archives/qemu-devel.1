Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E1C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4742076A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnWtAoTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4742076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPp2Q-0000UC-DW
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp18-0007Al-Dn
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp17-0003a9-5Z
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:42380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPp16-0003WT-VB
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id v2so2144258plp.9
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iN3Z57PDGKinzIwPdadosHp6DxwbmBFlWcXBLF5XklA=;
 b=pnWtAoTCH0FaZCWLBk3fhwD6cWQBV1M6oIIe4T03Jc1utPtk3h7xl0HeJqbjb4fjYk
 MPFD+TDKft9IZBAER0AS5hR12lhztuEs2aJMRVpDr2xMZxmltPYaMWmK63YN63AjcxgD
 sIhKrGqxwNp4LH79hc3nM2CpRv2QMDJ3+5Y40T61Iwcy2uJifBw8nPT+GYtpnSoW7rr1
 ixq33fCb45sJVYdGF0dpC99c3tqfU8UeWynu96MrDKSej0gO7e3jmC3YSh3um9PxdORA
 YoCm4cG183ARbMlQtZiRmXq76vsiCrgVIqE4glWj6f5SU2n36Ic8C2kTg7jq4lre3mtw
 zxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iN3Z57PDGKinzIwPdadosHp6DxwbmBFlWcXBLF5XklA=;
 b=U5RpouLrU5R96tmifxem/lbNdetd228jpCC28WCQAHmjOvXikYFf1gSipEwMsc0aYy
 VffyDZhBEBxSWzmajYLCGe7CTbqet1UUj8zCZWOY5isVfNnKn54UGLQnU0Ibxk5nfZTk
 vMA494Hsfy88rK8jkSlH1UvTanVZUEMLsqTUcxj9GXyUT5ZQRe0976nWT3X7wJbDtXkJ
 0uY57XkI92P8Q3TOlYWysqFcZtb96G3U/njWeYcMy6g0t1juTxU0w131W/vHO9Qgszg0
 ytsZCtM6Q8EzdF3Rbr7hhynjexPlfHyQ80a0MwbYMNfBiLr+q21vc7VRGkgfZWBLLrV2
 wkeA==
X-Gm-Message-State: AGi0PuZM+tuh1r55MhcpcDIUgnohP+tzuxORND7Gr/gU0u76erwUQf62
 qXxeS0nogCupzsJR6AHFPRs4+GA5RRg=
X-Google-Smtp-Source: APiQypJ0s/B6jYmjTj1lvD5X0NlXKYPxcUc40xFlobsxJtcTB9jI31bCRwLMDHm2KRH6Ju1SbhtTaA==
X-Received: by 2002:a17:902:ed03:: with SMTP id
 b3mr8161792pld.247.1587222263518; 
 Sat, 18 Apr 2020 08:04:23 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t103sm8668601pjb.46.2020.04.18.08.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:04:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] tcg: Remove tcg_gen_gvec_dup{8,16,32,64}i
Date: Sat, 18 Apr 2020 08:04:10 -0700
Message-Id: <20200418150411.1831-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418150411.1831-1-richard.henderson@linaro.org>
References: <20200418150411.1831-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::634
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

These interfaces are now unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h |  5 -----
 tcg/tcg-op-gvec.c         | 28 ----------------------------
 2 files changed, 33 deletions(-)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index eb0d47a42b..fa8a0c8d03 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -320,11 +320,6 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, TCGv_i64);
 
-void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t s, uint32_t m, uint8_t x);
-void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t s, uint32_t m, uint16_t x);
-void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t s, uint32_t m, uint32_t x);
-void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t s, uint32_t m, uint64_t x);
-
 void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index de16c027b3..5a6cc19812 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1541,34 +1541,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
-void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, uint64_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_64, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
-void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, uint32_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_32, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
-void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, uint16_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_16, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
-void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
-                         uint32_t maxsz, uint8_t x)
-{
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
-}
-
 void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
                           uint32_t maxsz, uint64_t x)
 {
-- 
2.20.1


