Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE74C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB9A206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUdqWApC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB9A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAOB-00005j-48
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIl-00060q-U6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIk-0007R9-UV
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id p21so5331777pgm.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v9PYVllY3D8WNVt+/GwKgHsq/9t/7VocWb4hJT0OXq8=;
 b=DUdqWApC0mD3QNG3NHWDAoEp6AeMLviM5Ltzd//uViT8ztuR4zhDiIqWpXr8/67See
 DBbv3ps0XeHWqfy5gDGJKoSe3w0SkUw6rBUX/HcbMMA1UuYVlqL0YPjmsYT1Ygp0SZ/i
 gicj2s4i7z9llKYQXZtGzUiSRxHLHoGsxZAJTt8+Kb5td8eV2pscyBNwTfW05KMG5uxq
 iCMwW9APn96zQABSKcKQrd9xiEdjX8J1Djh5/Qd7bGE27yGlQhX2Zm3Z7yN6T7UiB/xX
 fLp3MljyRaQDUs6opaP3wuWiJUnsyg2l0rpuZx26hMTpLTHNGAMu0RlRM+g/EsWXhSWs
 gmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v9PYVllY3D8WNVt+/GwKgHsq/9t/7VocWb4hJT0OXq8=;
 b=adnptLaXCCpg3TrKqa90JRjmlCJrH5PtgwxD3RxDxcWExqRTv+BTkEar6tDybZZs0k
 2P9IhhFQ9SgEs1GMdY1mtZwjvn9Pb9QmtLXqKlebhNzVAUCZnxbn2+3NmlnGuZqu+4cy
 JMNfha9NFaT3tvtPqReNAtqrL/OOnujankwG9rNAxUhvLvwW11ylqfscehYhC7puWRtM
 X23UECNUZtM9gfayG3/3fFbZwtQvBu++4fpa2yzkqy4LWjLwgKrQZPOHaBw88J5nPUEM
 C2i0Jx99Oc9fSfRe+V+xmvj1C2Rfa1t/MiA6R9a9Sa4qMogJIEIE0fDJsMcfeJuNbWYi
 04ew==
X-Gm-Message-State: AOAM533yVJRc7WBYXYhp091KzKPsLNRFcCsHsdD0A0ZR9zw2atarrK6i
 ukvczWTgGTXYucd50KQYMK/fJrISv2A=
X-Google-Smtp-Source: ABdhPJxoPtaqaA0Y5mlpcLKtnsmfYi2cp5VbxYGp+2HlAU6LEsWJ3NWxdThCpMZSdrSE2iiuNHGFlQ==
X-Received: by 2002:a63:724a:: with SMTP id c10mr24670392pgn.130.1591117328540; 
 Tue, 02 Jun 2020 10:02:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:02:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] accel/tcg: Adjust cpu_signal_handler for NetBSD/arm
Date: Tue,  2 Jun 2020 10:01:50 -0700
Message-Id: <20200602170151.321389-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602170151.321389-1-richard.henderson@linaro.org>
References: <20200602170151.321389-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Nick Hudson <skrll@netbsd.org>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nick Hudson <skrll@netbsd.org>

Fix building on NetBSD/arm by extracting the FSR value from the
correct siginfo_t field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nick Hudson <skrll@netbsd.org>
Message-Id: <20200516154147.24842-1-skrll@netbsd.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 52359949df..bc391eb454 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -517,6 +517,7 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
 #if defined(__NetBSD__)
 #include <ucontext.h>
+#include <sys/siginfo.h>
 #endif
 
 int cpu_signal_handler(int host_signum, void *pinfo,
@@ -525,10 +526,12 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     siginfo_t *info = pinfo;
 #if defined(__NetBSD__)
     ucontext_t *uc = puc;
+    siginfo_t *si = pinfo;
 #else
     ucontext_t *uc = puc;
 #endif
     unsigned long pc;
+    uint32_t fsr;
     int is_write;
 
 #if defined(__NetBSD__)
@@ -539,10 +542,17 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     pc = uc->uc_mcontext.arm_pc;
 #endif
 
-    /* error_code is the FSR value, in which bit 11 is WnR (assuming a v6 or
-     * later processor; on v5 we will always report this as a read).
+#ifdef __NetBSD__
+    fsr = si->si_trap;
+#else
+    fsr = uc->uc_mcontext.error_code;
+#endif
+    /*
+     * In the FSR, bit 11 is WnR, assuming a v6 or
+     * later processor.  On v5 we will always report
+     * this as a read, which will fail later.
      */
-    is_write = extract32(uc->uc_mcontext.error_code, 11, 1);
+    is_write = extract32(fsr, 11, 1);
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
-- 
2.25.1


