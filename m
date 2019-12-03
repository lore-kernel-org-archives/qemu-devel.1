Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFACC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC05220674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGe0fRnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC05220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyLH-00085B-LN
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxJ-0003Mh-VG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxH-0000AP-Ql
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:24 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxD-0008Sz-Go
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:19 -0500
Received: by mail-pg1-x543.google.com with SMTP id b1so859597pgq.10
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1a8ny/hnKkIfvEvhTYkU192OfcIHoxtAmofS/9eIiaE=;
 b=eGe0fRnwhgZSuf0WV0QU88VpcK1P4PdFtzrmWibjbTsKWEKeONT1Bv3L3sR+fe9h+D
 RFtUXAj2UGu9PUrqiYQzXSzXK4wvOCVBXxsKZNeJBVeII1tZ/9aK5+czoTqtmvZhwzDJ
 rQM1lwk5aCHnaIUpSJXvnIAYbTj1IIuy1j2ia3r8H3Wxz+1kuXF/exxL1tNdwnc3aBbI
 0i56Jf1G1pqtQ2IJhMh0GF1gpQgbyh8O2Op3DehhNigI1aazi7X4AOBda64jGSrwHU99
 eEowgvYLaqoX1KXUQ3xmkoown5A6aTe+1iQuVTC2YulBZgSi3jFkptqryHAtN9yZbvH8
 P38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1a8ny/hnKkIfvEvhTYkU192OfcIHoxtAmofS/9eIiaE=;
 b=ir79uA1hW3gERojbcy0gxfJoD5ppWwxgeKkYQ7zJ6QGSQzWvBwcRUOwKRM0DxqECFj
 CiCkEw/ptzEBWOGpa5p1V4GqXU8e3WP04PidVL0pNr+DyYBzlJVMJN85yaNNqYfieW+5
 jmTsd8cHeIwRjKvym/83rDKsJ5NkpFlx4I+Sd7OkQ9OtwcueLmvvAec45Ut06VT07Lw6
 gG6o0UltudwgQKq26vKQm3IFnlE+pPfkfQqyAp3SRTtsuF8e6rJLKBrWrSbqDvV5USCK
 R7/PVDaOWCoOf20XiysgFOV/rIxBeP3EgM0X2zBIJEZVIqIka9EcpO9dgn7AI4BnPCXb
 QHpg==
X-Gm-Message-State: APjAAAXcIVj1q/J5wt+SoZnnqnlUPM7AXoOKto/ctXQsAZvigtNxJSDx
 WdeIYI83hXYWfWueD9RzUgG+qF9rIqU=
X-Google-Smtp-Source: APXvYqw2DikZuTCX44ZK4L+jlmjR4i1ecyu4ydltoQ3GAMS/u/XwIuLZJIf5MtbObwVruoUdpUap2g==
X-Received: by 2002:a63:4104:: with SMTP id o4mr2751403pga.169.1575340216561; 
 Mon, 02 Dec 2019 18:30:16 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 29/40] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
Date: Mon,  2 Dec 2019 18:29:26 -0800
Message-Id: <20191203022937.1474-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Since we only support a single ASID, flush the tlb when it changes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9df55a8d6b..2a4d4c2c0d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3740,6 +3740,15 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
+    /*
+     * If we are running with E2&0 regime, then the ASID is active.
+     * Flush if that changes.
+     */
+    if ((arm_hcr_el2_eff(env) & HCR_E2H) &&
+        extract64(raw_read(env, ri) ^ value, 48, 16)) {
+        tlb_flush_by_mmuidx(env_cpu(env),
+                            ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0);
+    }
     raw_write(env, ri, value);
 }
 
-- 
2.17.1


