Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D75DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687A52077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687A52077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifULg-0006Si-JP
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 14:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ifUKX-0005WE-VG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ifUKW-00019h-Lr
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:40:57 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:60751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ifUKS-000101-CB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:40:56 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1INQ-1ih91W05nO-002siR; Thu, 12 Dec 2019 20:40:48 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/m68k: only change valid bits in CACR
Date: Thu, 12 Dec 2019 20:40:45 +0100
Message-Id: <20191212194045.12882-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yozRRqaLw1zXvx3bLY+piiPVA8r1Z5yVhMB0a/Cn0SOI85RS/1x
 iWIfEm5dLsyFT8MqXZG0XZFSLNrF+iozBOSRKEFNPZIJEm13TV/kBWEAgpF2wka1Tpw7uPD
 PrBlOdcTlsmgoDwwTNz0dS5n1bFDpByqm/NEpUZWQ6DYWHbt1cNFJIWtzyLM/rzNC6QstGp
 59NgIMppt6ehKRZm+1Vqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xtZ0CctKWak=:yhaW4BbiU8ipJ5oTQ2qd12
 z1W2V+q/YjyUGwYID/CHZB32Tdz0S5DUt5bRw7a0nwOuwPw6ecQZLufYwxu5hGLB9isa28qRE
 QeNrzk26vG9PQ5WiVvkaB3BJVyN76HEzvm3FQn59SPSwC2Y6oQbW1Id0Hqs5iIGrNwF7zx5X9
 HTmAWR8lzKQYRt28maN3SyGXeqdzyIYZZzbTZyN4LMy1OaAo/ForYbJs6uCmNFua+jfGI9m6c
 NOFJFC6rB45D8EXdUWmxhUxq7EiU638JQ0PN7ppg4r5DEzYBo/KMz7NddnwImr4p2JM2vucNd
 +trqYMqYDEqzxCCEveAY6/B30IFcwvP27pg/LquAg7+BbbmU+YLY5CG0uHbImb2cY7cAGv86O
 s7pJ+L3A6Dx27koZwchaV/A8seWoVRnasTKjK2nIbQ5JS65zbvTFcEDuvKzkvqiGpfTJGQjgt
 NoUUA1uF600fuc+Tf8J2HvRtTl26UVeOrYjSD2HSnehG8lJX8E7BvvLE9ZiYqyZvoS+g6P9oE
 4FEIOLYt6xcRXiVp3Yub+UZzKji2yOEOa++JRuWaPFLNxjkzqRYy3QHYrz5CeOn+XTXkEu8T0
 fXMu+QbEL7g9KQC6nt1J4+STw9ZHeVDvs1togmsMuIjVcYkXFS2Qo9xfplsTD+8duVQJBZTwi
 gj9+sdsqZGLWxbdwaO+T5zcxWpGQDFwr5zcawmEsodtSeaEFk+XpZu6cvWE7iglneQLWLoadc
 T2b0DQcrJLFL249KnmA6PeBal4cUJuyoVLJLJuysloGYa8pv/mzuTvESo5m99H21l++KYVlq6
 /sdj6kzh7+Ao+LmWR9hI8QlYgHttmn+hjQroHvJxsMZMaGJUl7gJmRLIDFEKf19yX98Fmnu6a
 /tByyNQRtE11SfrDaXCg==
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 212.227.17.10
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
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used by netBSD (and MacOS ROM) to detect the MMU type

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.c    | 28 ++++++++++++++++++++++------
 target/m68k/cpu.h    |  4 ++++
 target/m68k/helper.c | 16 ++++++++++++++--
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index e6596de29c..1d202cec49 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -114,11 +114,8 @@ static void m68000_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
 
-static void m68020_cpu_initfn(Object *obj)
+static void m680x0_cpu_common(CPUM68KState *env)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
-
     m68k_set_feature(env, M68K_FEATURE_M68000);
     m68k_set_feature(env, M68K_FEATURE_USP);
     m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
@@ -136,14 +133,32 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CHK2);
     m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
-#define m68030_cpu_initfn m68020_cpu_initfn
+
+static void m68020_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m680x0_cpu_common(env);
+    m68k_set_feature(env, M68K_FEATURE_MMU68851);
+}
+
+static void m68030_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m680x0_cpu_common(env);
+    m68k_set_feature(env, M68K_FEATURE_MMU68030);
+}
 
 static void m68040_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
-    m68020_cpu_initfn(obj);
+    m680x0_cpu_common(env);
+    m68k_set_feature(env, M68K_FEATURE_MMU68040);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
@@ -166,6 +181,7 @@ static void m68060_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_BKPT);
     m68k_set_feature(env, M68K_FEATURE_RTD);
     m68k_set_feature(env, M68K_FEATURE_CHK2);
+    m68k_set_feature(env, M68K_FEATURE_MMU68060);
 }
 
 static void m5208_cpu_initfn(Object *obj)
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 20de3c379a..36e4353b44 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -483,6 +483,10 @@ enum m68k_features {
     M68K_FEATURE_CHK2,
     M68K_FEATURE_M68040, /* instructions specific to MC68040 */
     M68K_FEATURE_MOVEP,
+    M68K_FEATURE_MMU68851,
+    M68K_FEATURE_MMU68030,
+    M68K_FEATURE_MMU68040,
+    M68K_FEATURE_MMU68060,
 };
 
 static inline int m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index ae766a6cb0..b5758bbd7d 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -205,7 +205,13 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
         return;
     /* MC680[234]0 */
     case M68K_CR_CACR:
-        env->cacr = val;
+        if (m68k_feature(env, M68K_FEATURE_MMU68040)) {
+            env->cacr = val & 0x80008000;
+        } else if (m68k_feature(env, M68K_FEATURE_MMU68030)) {
+            env->cacr = val & 0x00003fff;
+        } else if (m68k_feature(env, M68K_FEATURE_MMU68851)) {
+            env->cacr = val & 0x0000000f;
+        }
         m68k_switch_sp(env);
         return;
     /* MC680[34]0 */
@@ -261,7 +267,13 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
         return env->vbr;
     /* MC680[234]0 */
     case M68K_CR_CACR:
-        return env->cacr;
+        if (m68k_feature(env, M68K_FEATURE_MMU68040)) {
+            return env->cacr & 0x80008000;
+        } else if (m68k_feature(env, M68K_FEATURE_MMU68030)) {
+            return env->cacr & 0x00003fff;
+        } else if (m68k_feature(env, M68K_FEATURE_MMU68851)) {
+            return env->cacr & 0x0000000f;
+        }
     /* MC680[34]0 */
     case M68K_CR_TC:
         return env->mmu.tcr;
-- 
2.23.0


