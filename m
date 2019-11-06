Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDDC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7002077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WABOzADH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7002077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJik-0007XG-U6
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZP-000457-3f
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZM-0007aR-Oo
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZM-0007Zf-HW
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:48 -0500
Received: by mail-wr1-x443.google.com with SMTP id w18so25349001wrt.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sbKKp8L4DTtLJPEKrjfc6knlBHmQBSkQGz/jGwEjATY=;
 b=WABOzADHchxJEGyitvP+N0YSkKanAt2OEt4DwBQGeyv9E/strudqoGBJhTS+fAzjOD
 dlAC6BDK1tUavFyNN208UYl0bcIjwByA6Buh6/W0wcl7fZ9HMbJ4YfSYfYfoVPnGsUvT
 NzzbGG62RLSAboY4rKiYTQU/eq5PlrvACmr1uVf14/OwVvAAx91X9LrqOmdpDdO0+21q
 Mwh+Px8GsLgrajH0PLlD6DhERIfBhJPkZa1QFnyvXUgmJzczh2f8F636PZ6qkAVPf5zg
 akF+Z7lL5P6cDiVeb7Nn6EtfXBbJ2uARrvGXeyH4/R2dy6xEYFVARhjALf+6xLr5CHNB
 Y6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sbKKp8L4DTtLJPEKrjfc6knlBHmQBSkQGz/jGwEjATY=;
 b=D8J0E6+UPIGPv+UKqy95q5J0CcNtONN0K0NXlcSRsT7FkQuDaPEKON5T9fefiEEIHE
 63pZKTgHsvcnTQGTj8IOy78mYWmvt3ycA/pjExFFB6ULFbIV1uurklcHrK+I3dtu3iX+
 e5c+cUd9C2l8pAHdXA5CJ+NfX9H3Icu3RaBmFQRF6azHdnUknpGz5giU3J2JYlcZAP8M
 K3MtaY3w/ICosnzOf3PtLUJXSoNrDYHXYDPqfH7jSVxTU3M15Udyq/UAZ7bE6d9GQWEi
 2ZPyxQ95q0YOFT+g3tDfDlCSIPOyhKbxZXIKaqWMX6olnXpilknWOnz+tRhhAXFGWat7
 U7uQ==
X-Gm-Message-State: APjAAAXGBCyWRNsecGSXKgt9ANZ4wYe77bX2hpoaSlou904FOA0XaCB1
 Sc1dK3uhcrBiENvdknKhg4pyM3xePeKW5Q==
X-Google-Smtp-Source: APXvYqwVtb7LNUCQPiUoL6hx3Ob4C5Y/z11N9exjvy5mWuU0V3SSWU/RJk6WMagveTWRjWjmpfArHw==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr2239807wrv.231.1573040024513; 
 Wed, 06 Nov 2019 03:33:44 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/12] linux-user/sparc: Fix cpu_clone_regs_*
Date: Wed,  6 Nov 2019 12:33:17 +0100
Message-Id: <20191106113318.10226-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We failed to set the secondary return value in %o1
we failed to advance the PC past the syscall,
we failed to adjust regwptr into the new structure,
we stored the stack pointer into the wrong register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191025113921.9412-12-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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


