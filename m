Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A44C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869A020756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beTkeJwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869A020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKCW-0003EI-WB
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7Y-000513-H5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:28 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7X-0005un-2B
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id e15so3979424pfh.6
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 19:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h4nXGEfFKdYYxAxVCeZfgKCWCHDlbl0aB+zYefgN5rQ=;
 b=beTkeJwF0RNwyM5S8cby2EtTfgia+VK55dpYJO451RHn6Suyf1C/HNkT9a+FT1dDyQ
 CbSYtq529xfbp08/Nbw5kKYqfjWICC5UOpRhLdT7IIPt71CbDwsHaG8QIjioW8wxhemS
 TmYEvg29N3/NPZ83iZcOodJUubgQxQGqzF7JYIL0TQmBJRvaLTCxJ9fRw1ITp+Kjr+DW
 5W64PD7kDbe/kTEroV5e/7qC9p1Qz2IqYdyYylxlVSGy49VgG++YrGIanbR15btrkaHG
 jvQ24pA8btIMd31qxV3NUKlZZaMgHJGQVjLOsvWbWTJxQSGlHw8PwQSizgmoldfFLzEc
 a/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h4nXGEfFKdYYxAxVCeZfgKCWCHDlbl0aB+zYefgN5rQ=;
 b=mSp6wMGfHDFnceNqns6HuAl+hqXYB/lO5SlGqNgd/8EF2QO9jcqEjgjoh4YToJjgCl
 15+y7y380QZs80u3irWJIkKbv85xzqaXklHVJAo7PbfG5n8wzoQofWjJb2eoy/vEBP38
 Yhgo2HeP8r3wXLFL57NFMdtZ+j1+CSRQ4JFQj6/Uye4ViG9OfRmVpHpMEGOmUFMJLcSE
 wHWQymT0ImSGdY8xxpXMALCWG76BulxbkbiH8QxkesViw4XCS2BDBqzJjUwmHqFdMlFT
 /GEaVBNkF0p9LNOb52pCQMGjhMc8+a5K7mSc7JIe4hoES3N41rV1GY9KOqV+AC5erSI7
 d64Q==
X-Gm-Message-State: AOAM533c5X4PR/K2kXRcS3CvxaQjSLyE8SdW1HQdXtfkLkGTnukpWSgc
 I78clPhswLlNRHMG/6mHdqE193kHroSBYQ==
X-Google-Smtp-Source: ABdhPJyjTEFReAx/auockyOZYHrgqX+8FV7OQTZpxoSq9ctwUSipQ+yHSVoSHKTNlIO57uXPmRwJtg==
X-Received: by 2002:a17:90a:fa93:: with SMTP id
 cu19mr89530pjb.117.1604024785397; 
 Thu, 29 Oct 2020 19:26:25 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b7sm4446517pfr.171.2020.10.29.19.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 19:26:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/11] target/arm: Use neon_element_offset in vfp_reg_offset
Date: Thu, 29 Oct 2020 19:26:11 -0700
Message-Id: <20201030022618.785675-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030022618.785675-1-richard.henderson@linaro.org>
References: <20201030022618.785675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This seems a bit more readable than using offsetof CPU_DoubleU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 88a926d1df..88ded4ac2c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1122,18 +1122,13 @@ static long neon_element_offset(int reg, int element, MemOp size)
     return neon_full_reg_offset(reg) + ofs;
 }
 
-static inline long vfp_reg_offset(bool dp, unsigned reg)
+/* Return the offset of a VFP Dreg (dp = true) or VFP Sreg (dp = false). */
+static long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
-        return offsetof(CPUARMState, vfp.zregs[reg >> 1].d[reg & 1]);
+        return neon_element_offset(reg, 0, MO_64);
     } else {
-        long ofs = offsetof(CPUARMState, vfp.zregs[reg >> 2].d[(reg >> 1) & 1]);
-        if (reg & 1) {
-            ofs += offsetof(CPU_DoubleU, l.upper);
-        } else {
-            ofs += offsetof(CPU_DoubleU, l.lower);
-        }
-        return ofs;
+        return neon_element_offset(reg >> 1, reg & 1, MO_32);
     }
 }
 
-- 
2.25.1


