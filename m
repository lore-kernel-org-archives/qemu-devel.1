Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C0C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1252A20753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dbq1S3e+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1252A20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYkh-0004gr-2s
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYht-0007V7-N8; Thu, 07 May 2020 01:04:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52449 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhr-00070N-G7; Thu, 07 May 2020 01:04:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFn268fz9sRY; Thu,  7 May 2020 15:04:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827853;
 bh=m9jI1TLvGlY1glLjzeD6ysxs6fYmaEobrj3tLK7VEls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dbq1S3e+PaYw53mw8bYwG6V87MhTcRKmvGEAbKQU7+jSApL8kmSLt2VRgxOBwa5EC
 HQ5CY2UtvwBr3azlVVjvh/lrgaKJajYrFed7DNwiBBntpfS4VQ42x/BeyHalIjwRZ9
 8V2XGnX4BB8HV4Tn2u+u7Kq5h1E5T6UPZBjnVRO0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/18] target/ppc: Improve syscall exception logging
Date: Thu,  7 May 2020 15:02:11 +1000
Message-Id: <20200507050228.802395-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 01:04:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

system calls (at least in Linux) use registers r3-r8 for inputs, so
include those registers in the dump.

This also adds a mode for PAPR hcalls, which have a different calling
convention.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200317054918.199161-1-npiggin@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 08bc885ca6..81ee19ebae 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -57,12 +57,29 @@ static void ppc_hw_interrupt(CPUPPCState *env)
 #else /* defined(CONFIG_USER_ONLY) */
 static inline void dump_syscall(CPUPPCState *env)
 {
-    qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64 " r3=%016" PRIx64
-                  " r4=%016" PRIx64 " r5=%016" PRIx64 " r6=%016" PRIx64
+    qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64
+                  " r3=%016" PRIx64 " r4=%016" PRIx64 " r5=%016" PRIx64
+                  " r6=%016" PRIx64 " r7=%016" PRIx64 " r8=%016" PRIx64
                   " nip=" TARGET_FMT_lx "\n",
                   ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
                   ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
-                  ppc_dump_gpr(env, 6), env->nip);
+                  ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
+                  ppc_dump_gpr(env, 8), env->nip);
+}
+
+static inline void dump_hcall(CPUPPCState *env)
+{
+    qemu_log_mask(CPU_LOG_INT, "hypercall r3=%016" PRIx64
+		  " r4=%016" PRIx64 " r5=%016" PRIx64 " r6=%016" PRIx64
+		  " r7=%016" PRIx64 " r8=%016" PRIx64 " r9=%016" PRIx64
+		  " r10=%016" PRIx64 " r11=%016" PRIx64 " r12=%016" PRIx64
+                  " nip=" TARGET_FMT_lx "\n",
+                  ppc_dump_gpr(env, 3), ppc_dump_gpr(env, 4),
+		  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
+		  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
+		  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
+		  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
+		  env->nip);
 }
 
 static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
@@ -379,9 +396,14 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         }
         break;
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
-        dump_syscall(env);
         lev = env->error_code;
 
+        if ((lev == 1) && cpu->vhyp) {
+            dump_hcall(env);
+        } else {
+            dump_syscall(env);
+        }
+
         /*
          * We need to correct the NIP which in this case is supposed
          * to point to the next instruction
-- 
2.26.2


