Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE9C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA94E20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v19kzQAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA94E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isFvQ-0001W5-VJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isFuR-0000YJ-IK
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isFuQ-0001ea-H1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:54:47 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:39658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isFuQ-0001e7-B1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:54:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id g6so9119593plp.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RRNhppJBo3j9IN3x0V0TBNKZ3vFfjEjJ3mBvklIP5Zw=;
 b=v19kzQADXsfBcfKI0OkA5BojzaKnnInTVaB7o3XUeUCPEX5h7Maoj/uW5qdw0GQwm1
 tqYNka7lKo6ODqB7MsgrSlC2F2suMR1w3Hp5Mbw+W46FexD/S+y02bnI09WIJIQ8dOCj
 /6n8yVgIsa2EyRiK7rNsYRXFb0M0i0PQmgv+DNIMqX5gVcMoxAwPtHNvGt+Htyf4tlqH
 mV/oc3cseITYLXutpHJKT3baOxLQVDSTk2iFqSh9iv6YDXUGeMTX/mXcwMy4dQNrcrHh
 qMKgKr6+5hnF/0VBhAcb/Pb+5YpeKkLaudUdKTmepXkeYLx85IZNVCfCWPV1QwmPjXUy
 htNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RRNhppJBo3j9IN3x0V0TBNKZ3vFfjEjJ3mBvklIP5Zw=;
 b=hLqwiSd8eyoN4raw5aGzJTVC68l9V4ZDE0Yz30gxFzxX/UUQ3YTGwdYVq11EQuoNcu
 OUGhDrsyU4Bs2BlKpcGQ82GOK4mUZynnffz9OvO7p7Lzo7v4nws2a24jBVVJbIRqO7/p
 WydZjDfUgpG9X082MtFp8AYaPqXPnJQnEobwNBh4qNMSMuiksbcXPCCQJh1aDensZdrA
 fOHMKoMG92eMlRqyy3+rn/M7rsF6+85U8WMhhxZkO6kMmaq0mniFrhqH5YXiJgEFZg6q
 32QzD6o57aZUZcEU5BUZvZhcAAVIPfIDtbkgcjlNFG/4NhjBUIrknXwC6XxCfbFRfLUU
 3q3A==
X-Gm-Message-State: APjAAAX/Qh36hBPwcErn2tBU1/lg7xKKQ3DkimK2tS1UOtN391LDrC0Q
 RyXrxm8CaC366sa+75EzHzOMuJXFnj0=
X-Google-Smtp-Source: APXvYqwYgG3qfmxq5VYIhhHkEjiHO6Ui3dlxc/oW+ZyfgO9U2bFtqC/mFnb/HnjvqmBWFtlRk3q2FQ==
X-Received: by 2002:a17:90b:30c8:: with SMTP id
 hi8mr2520175pjb.73.1579222484950; 
 Thu, 16 Jan 2020 16:54:44 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id l14sm23848628pgt.42.2020.01.16.16.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 16:54:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] target/openrisc: Fix FPCSR mask to allow setting DZF
Date: Thu, 16 Jan 2020 14:54:40 -1000
Message-Id: <20200117005440.3524-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117005440.3524-1-richard.henderson@linaro.org>
References: <20200117005440.3524-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
Cc: peter.maydell@linaro.org, Stafford Horne <shorne@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stafford Horne <shorne@gmail.com>

The mask used when setting FPCSR allows setting bits 10 to 1.  However,
OpenRISC has flags and config bits in 11 to 1, 11 being Divide by Zero
Flag (DZF).  This seems like an off-by-one bug.

This was found when testing the GLIBC test suite which has test cases to
set and clear all bits.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Message-Id: <20200110212843.27335-1-shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 59e1413279..6f75ea0505 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -70,7 +70,7 @@ void cpu_set_fpcsr(CPUOpenRISCState *env, uint32_t val)
         float_round_down
     };
 
-    env->fpcsr = val & 0x7ff;
+    env->fpcsr = val & 0xfff;
     set_float_rounding_mode(rm_to_sf[extract32(val, 1, 2)], &env->fp_status);
 }
 
-- 
2.20.1


