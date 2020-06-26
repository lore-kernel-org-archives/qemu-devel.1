Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8854FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B0820709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaGMFLVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B0820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofGQ-0002vr-Hu
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof65-0008WC-Vz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:14 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof62-0001sE-Hy
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:13 -0400
Received: by mail-pj1-x1041.google.com with SMTP id f6so351962pjq.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qDKnE6CQ1+e8GKFB2CRQQ8tPHOtJCQQxxuNXqwNntCM=;
 b=jaGMFLVAxbTIUtc6DIUX+CwzqFpY7FZhyGacm7ZN3yS+gMkFSyJYEhS+52R+8jAiPi
 ieo2zrRz1HajivQxqxLC2Himl9evv7EOszoFBSM8HSozUAgrs2IxVDBc6Zy5EOrM8a85
 WtU0SD8d6noD4T6qwWYg6R6gWLpUrgDD6AqQvFiVQCVPBzSrIYVrtxaKXmyeWa66Rr6i
 WN+uUWFPMlNLEGLf1sVHhuQGs6DrDlsPRUTw3tuL+mFkXn3Jk8BZ0eiCFHUMFFjPPHQa
 baG9JhGew9Ln7YhKzmPpRrjUt1Tz6Wz1prENJMbmoyV0de+VYHMIcxtbv3HEQ2iVjVOS
 F1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qDKnE6CQ1+e8GKFB2CRQQ8tPHOtJCQQxxuNXqwNntCM=;
 b=pqI7MHuN4UvFTHMnB4q9RVznxmv00sB2/dIiAyiWNwoUYsrvlp6RHPBxZ1W4Z4k3zA
 OARZ4QH/EdzxckB7U1cxgyw1NhPctpdaBQuMUVcj79wLbuP/5jCx4kRIYIemWVszcWK1
 Vu3JK75mGIdN3h86p5wh3yaVWGV81OQTBfWeOydhbWI7Wc5edirXc04wBEUgQkIZBrA7
 8Z/AoY76UgSwGK0NOuG2ksE7I6cJEvoYZVxR+M1kRn9TVc7JEWhU9j7G+dVnWNdeYneB
 kqsGMzMjPdnJZFswo37Sa02ceSm2BlqJRE1+z9i8mhNBoYvcWut0VhCmHtYVBTPZSMha
 B2jg==
X-Gm-Message-State: AOAM531eeSsAPDa29tYjAy4vP6Aga5M+n5X1zMhQewyVMXf+0FC4IfrM
 18x9CE9bZGqQb6PPzzYL12TZw1EiEd8=
X-Google-Smtp-Source: ABdhPJwaaGOp/hNhKe7YGxvgE4DsqDtu4Ty+br0aci61+MMPQYhpqHyM6Jbo0YbJ+OkGIvrZC2V62g==
X-Received: by 2002:a17:90a:e983:: with SMTP id
 v3mr1165562pjy.71.1593142328916; 
 Thu, 25 Jun 2020 20:32:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 17/46] target/arm: Restrict the values of DCZID.BS under TCG
Date: Thu, 25 Jun 2020 20:31:15 -0700
Message-Id: <20200626033144.790098-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can simplify our DC_ZVA if we recognize that the largest BS
that we actually use in system mode is 64.  Let us just assert
that it fits within TARGET_PAGE_SIZE.

For DC_GVA and STZGM, we want to be able to write whole bytes
of tag memory, so assert that BS is >= 2 * TAG_GRANULE, or 32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d9b8ec791e..d9876337c0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1758,6 +1758,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
+    if (tcg_enabled()) {
+        int dcz_blocklen = 4 << cpu->dcz_blocksize;
+
+        /*
+         * We only support DCZ blocklen that fits on one page.
+         *
+         * Architectually this is always true.  However TARGET_PAGE_SIZE
+         * is variable and, for compatibility with -machine virt-2.7,
+         * is only 1KiB, as an artifact of legacy ARMv5 subpage support.
+         * But even then, while the largest architectural DCZ blocklen
+         * is 2KiB, no cpu actually uses such a large blocklen.
+         */
+        assert(dcz_blocklen <= TARGET_PAGE_SIZE);
+
+        /*
+         * We only support DCZ blocksize >= 2*TAG_GRANULE, which is to say
+         * both nibbles of each byte storing tag data may be written at once.
+         * Since TAG_GRANULE is 16, this means that blocklen must be >= 32.
+         */
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            assert(dcz_blocklen >= 2 * TAG_GRANULE);
+        }
+    }
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
-- 
2.25.1


