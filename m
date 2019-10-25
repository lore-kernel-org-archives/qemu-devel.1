Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D42CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1499E21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozOmE6t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1499E21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy51-0001dd-Gk
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwV-0006qU-VL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwP-0006fz-5E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:40 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:43269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwO-0006et-VU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:37 -0400
Received: by mail-qt1-x841.google.com with SMTP id t20so2674389qtr.10
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JmqIvZXJ/Mi2RAVnN1+8tsju3fqmNrpX/0K0AAbqa0w=;
 b=ozOmE6t8mQEVMKWSKssY6MJpkE306wwcipCWm7YPvjKlPZShJc5dyAFlKIMvt2sCzx
 7ZL5adq5lrl/RrcnG8wBLc2TUdyCVYKiSrGojTnb4NvtmCDNb2YZHOBMfDEQP3Jj4oon
 z7UobQjtqsCUtUBbk1CV7asmxHtD6tazX9BwmdfS3wj0ol/j2kL5P7zRpvih6CcV7T4e
 MUq/2zsoz2WVNQpspB9J+rvIOnpWMDRQ961JmuJ1Z5hN/ZJMHHxUAY9oSADOjnkV+d5E
 5+8x9fLUDW1qZLmFznjUdv87BNVl8FXmlxGfZ8VbkB0GN7vysWDppu77n0kWRrTO/t1G
 vHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JmqIvZXJ/Mi2RAVnN1+8tsju3fqmNrpX/0K0AAbqa0w=;
 b=CZCFV1y8YPW7u/xN94OTvV24CBOyqf0LabAKLee/Uqwn+0dtvVX6qcvk+yPrtBEVt5
 vbED9wnOLZcTJmJJERhNIzgXzhUum3ikC8zw0FOrVvnp+rHmYLdbSy2EqRVblI++yL3J
 8UZXjcZL1WcCdKUrU7LYtZrS6yQwkHQBkq9d3H5NlhXGizVeNC2aVzYEb9ogYWnUOgbh
 nOVIMF86hJfOdDWQm+PUtdPxoA7/dVHTFf3I3I8/GpiBoBg/1bBPlVmAixRkHXEns94X
 6BakgrhnATLTL51zDKYWmfoiblrcgUcfhOOhQHNJ9MvXnCL15Xx76yaQvUePZotnfLkj
 RTbQ==
X-Gm-Message-State: APjAAAXiOcxhAEDT85+s+Ous+wlA48Gx1kEYKWjRVz+V2U0Lba76M1ZP
 CLVB9uQzbZ4z7aZrIBSzHY+vev3a3qY=
X-Google-Smtp-Source: APXvYqxZPEIf9oVUuk50PUQq7NTii7BjgFItV2f/bsjKNAegDUUfxgXtJBNNON3HGkVm88FZDw+MSw==
X-Received: by 2002:ac8:65cf:: with SMTP id t15mr2535078qto.357.1572003574981; 
 Fri, 25 Oct 2019 04:39:34 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/12] linux-user/sparc: Fix cpu_clone_regs_*
Date: Fri, 25 Oct 2019 07:39:20 -0400
Message-Id: <20191025113921.9412-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We failed to set the secondary return value in %o1
we failed to advance the PC past the syscall,
we failed to adjust regwptr into the new structure,
we stored the stack pointer into the wrong register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Take CLONE_VM into account when performing syscall return.
---
 linux-user/sparc/target_cpu.h | 47 ++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 8ff706adce..14b2158969 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -23,22 +23,51 @@
 static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
                                         unsigned flags)
 {
-    if (newsp) {
-        env->regwptr[22] = newsp;
-    }
-    /* syscall return for clone child: 0, and clear CF since
-     * this counts as a success return value.
+    /*
+     * After cpu_copy, env->regwptr is pointing into the old env.
+     * Update the new cpu to use its own register window.
      */
-    env->regwptr[0] = 0;
-#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-    env->xcc &= ~PSR_CARRY;
+    env->regwptr = env->regbase + (env->cwp * 16);
+
+    if (newsp) {
+        /* When changing stacks, do it with clean register windows.  */
+#ifdef TARGET_SPARC64
+        env->cansave = env->nwindows - 2;
+        env->cleanwin = env->nwindows - 2;
+        env->canrestore = 0;
 #else
-    env->psr &= ~PSR_CARRY;
+        env->wim = 1 << env->cwp;
 #endif
+        /* ??? The kernel appears to copy one stack frame to the new stack. */
+        /* ??? The kernel force aligns the new stack. */
+        env->regwptr[WREG_SP] = newsp;
+    }
+
+    if (flags & CLONE_VM) {
+        /*
+         * Syscall return for clone child: %o0 = 0 and clear CF since this
+         * counts as a success return value.  Advance the PC past the syscall.
+         * For fork child, all of this happens in cpu_loop, and we must not
+         * do the pc advance twice.
+         */
+        env->regwptr[WREG_O0] = 0;
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+        env->xcc &= ~PSR_CARRY;
+#else
+        env->psr &= ~PSR_CARRY;
+#endif
+        env->pc = env->npc;
+        env->npc = env->npc + 4;
+    }
+
+    /* Set the second return value for the child: %o1 = 1.  */
+    env->regwptr[WREG_O1] = 1;
 }
 
 static inline void cpu_clone_regs_parent(CPUSPARCState *env, unsigned flags)
 {
+    /* Set the second return value for the parent: %o1 = 0.  */
+    env->regwptr[WREG_O1] = 0;
 }
 
 static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
-- 
2.17.1


