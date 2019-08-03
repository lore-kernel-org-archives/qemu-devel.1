Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C28AC433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFCF2073D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPvHAofj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFCF2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htz7K-0002qq-W6
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4c-00061C-0o
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4a-000777-Uv
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:09 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4a-00076R-Pe
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:08 -0400
Received: by mail-pg1-x543.google.com with SMTP id x15so27322524pgg.8
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Rs0ix/SYQKzQx2FXXQO106tmFBYyCQIrr3vAmMEheQ=;
 b=vPvHAofjDh13cvA96WTwyjFAdTULJbdQ9ybEFKJfgyYtqSaKhbOjXvki83K0xHqo11
 MtokYAYkf6sRn5wnU8jQawtxscZaTYUt+AZIExuMd1wZejf8tNQ1Sfi6yxddylozCGR/
 KI3d3Rybp77SktK7y2d1h68Tj9aKww6QaRRuuj7ZE2Xy+9SpsnqN9lAlrxLWQFKD7vEE
 I2URa8cgSieAlS83ATnACU2iiRE5N6FtxZip8dABXOGRbmKe4f+YImVa8ivdnw9kphBN
 CKon3LMB/w6/XtDeZ5S1GPpYRfDlXnJscrpe8roUK+OHwU7g6ePJvDppWqhMq/fls1hc
 zdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Rs0ix/SYQKzQx2FXXQO106tmFBYyCQIrr3vAmMEheQ=;
 b=gQDFDBUKwyjrmJNxdsNzOfsPuQelXkxar2cyk05AbzOw3g4mGgDB/oeOkXdwGQ9wzU
 hthGnm6TL8WRZuCxgxQ4qHtO5R+VMz6EXFDRsqjbI2VcKxtryZdUzaTQOqYLyUudVeod
 DVuxxM7Q13qa99+Oy6sNtOT/5m0AZldm947YdmP3OqAU7kjNfRo9kgiwBTxmwblZXxBr
 Nv0D1S3dW4roaug4NqjAu796pqWo+CfSCjYJNRKlPKmKeojkqY/Q8TloFJ0+ZNG5rwHm
 JJmdGouK4hS5LqpUla0I+N4TkwwUbIB85C5eB/eu655S8FlSD82gMgSTstRX0MJlTY9A
 wk7g==
X-Gm-Message-State: APjAAAWQ52FFqrnek7zauEwPhM6j6/Xz245CAFVAUade1F1Cy4xpupkM
 SMB2IfGqxkl+lgsPvC+azcyh85NFWu4=
X-Google-Smtp-Source: APXvYqwfqGKZuSNSsCvI/U31pcyp3UPCGhi9soCIZOjfGaoy0K/asXvr35NSg45u3lrQ2vhhDIUEkA==
X-Received: by 2002:aa7:97b7:: with SMTP id d23mr68186838pfq.203.1564858087487; 
 Sat, 03 Aug 2019 11:48:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:30 -0700
Message-Id: <20190803184800.8221-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 04/34] target/arm: Install ASIDs for
 short-form from EL1
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

This is less complex than the LPAE case, but still we now avoid the
flush in case it is only the PROCID field that is changing.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2a65f4127e..c0dc76ed41 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -551,17 +551,31 @@ static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-
-    if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
-        && !extended_addresses_enabled(env)) {
-        /* For VMSA (when not using the LPAE long descriptor page table
-         * format) this register includes the ASID, so do a TLB flush.
-         * For PMSA it is purely a process ID and no action is needed.
-         */
-        tlb_flush(CPU(cpu));
-    }
     raw_write(env, ri, value);
+
+    /*
+     * For VMSA (when not using the LPAE long descriptor page table format)
+     * this register includes the ASID.  For PMSA it is purely a process ID
+     * and no action is needed.
+     */
+    if (!arm_feature(env, ARM_FEATURE_PMSA) &&
+        !extended_addresses_enabled(env)) {
+        CPUState *cs = env_cpu(env);
+        int asid = extract32(value, 0, 8);
+        int idxmask;
+
+        switch (ri->secure) {
+        case ARM_CP_SECSTATE_S:
+            idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+            break;
+        case ARM_CP_SECSTATE_NS:
+            idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
+    }
 }
 
 /* IS variants of TLB operations must affect all cores */
-- 
2.17.1


