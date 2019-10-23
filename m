Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA5CCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AAB21872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kl7dFo28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AAB21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIFm-0004yc-Ph
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-000861-T6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8q-0001Dg-MX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8o-00013Z-L2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:40 -0400
Received: by mail-qt1-x843.google.com with SMTP id g50so18582133qtb.4
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IBA+abtZ26hlRDDlZ8eTB3Pn4yNYwZChmFB+u2JQGOM=;
 b=Kl7dFo28PEXr9icb+mFQdKLB4ia3YW7xNtm5+36Axi5JLbMVMjmEJg+o1rLT7O6hFY
 Njdd1uj18qTWYtm1tKivlXWozJ0IXiXkjEMBjxjH1Xtqcy78egANpG+uFQbfRcZOwDj0
 FVcZcImevfyeqhw6Xii0bm3EbKKIVsuiQ5xidiZxYuFShVTIpllo8EOt/iqv9JiKt2eb
 WPe8B12kbWYO8FX4R67m6AdhgjfSeB2Ia0IyFw4pgky5hh7WXRlLZGZNQTU4Ib3rH9ka
 hjw2vkFPUXNyDR1/FBkytveJpl2WqoS2zJUzfWkrFDoVRFw+xsmiuz3xMdtAv+Z/ZY/+
 2YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IBA+abtZ26hlRDDlZ8eTB3Pn4yNYwZChmFB+u2JQGOM=;
 b=L42PabNQYuvb39SSpTAAOyURxuS6tzclsG/BVRQw4vJM7NJJPOwcV3BS47XE8Vw9yG
 IJyfsE4aJUDwJvFAWedqVtpPK234nomQ2EhRsU+6o6kJx09keUONxqQ0oOvKaa1bSeRf
 DobIfi1EBrgRywsaFqhFysb5sWBIAhmxato5JK24iIXuZDezuhK/CQKlVuk5fv0AuiJq
 cJU+AWX5Xishg+slX0z/v4j5nc5/oCrGWhHEIXXRKN6ScZAvY4szPGSaQbgHttfnOv3n
 p0tme1TBPIhOfop5RdeRCAshk0mIg+XxoG1x2hZqVQvxJqOLMa8vPNoaCehP34AmOy04
 5O5A==
X-Gm-Message-State: APjAAAVWPYdKqzrUO4+ZHJiAfTRm5LD+d/He/XgfbNdUCKvY+c+ctr6w
 E5+I/w9/P2Ahs2JBfWVPmbihuuhKnxE=
X-Google-Smtp-Source: APXvYqy3W63RxWhSSR5seFaLZo0aDIGTzsWVncaCydtEqw8o04kC8LCJtNLOZTHhGvLZzwcdsoQHFA==
X-Received: by 2002:ac8:3597:: with SMTP id k23mr3420879qtb.195.1571842871709; 
 Wed, 23 Oct 2019 08:01:11 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 07/24] target/arm: Split out rebuild_hflags_a32
Date: Wed, 23 Oct 2019 11:00:40 -0400
Message-Id: <20191023150057.25731-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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

Currently a trivial wrapper for rebuild_hflags_common_32.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 296a4b2232..d1cd54cc93 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,6 +11106,12 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11218,7 +11224,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-- 
2.17.1


