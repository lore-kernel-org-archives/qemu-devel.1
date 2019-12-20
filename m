Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77AEC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F896206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F896206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiM1J-0004EG-Qt
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iiM0l-0003nI-IH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iiM0k-0001nY-AN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:24:23 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:32777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iiM0k-0001ja-0b
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:24:22 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Ma1sQ-1iCa3h0kBI-00W0Xj; Fri, 20 Dec 2019 18:24:17 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] target/m68k: only change valid bits in CACR
Date: Fri, 20 Dec 2019 18:24:15 +0100
Message-Id: <20191220172415.35838-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ST3+DcYqUfASfMX7m9CxKodRV+pFqZh2guEde6izSDLrJoiT+Ji
 4LryqrKQZyYVh+yhZumJyvP3cmCTYGnwO663AtebA2cwYzHS1NoWnpdLxDL4jU86rdiaJLc
 CWnm7e3kp/sZL01aLlZiqsemZ0Un4iPqNj3tkfcZqnhIvXX+3rSSBon5dwFNQr1lS+Owitd
 IDTvaVJpW6Ny1ZMY6t1Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jVVqPmI67B4=:3hwWXQlcqH0Cspt2RPbpeb
 3Ix5V7kbD3+azwl7tiQ8Eu0E2JhBdJ2e6e5P4zWBXBHH1WFyf5SbZ+plVhd6L+fYcVc4ntm3d
 Vrh+XwHTcb0rx/dEByIMgYHxW4ilmWjrhzL7Y7VP3j77IaxlfqXsanC9yQU9foHNPBC36MrcZ
 dIby2kB1Ng0JCPOn2G+EDlaofbFymfkMTnAgMIKcMb3Ap9D6PvLc5Cjpzr1fcztD1m73cM6lg
 NT9TRoYb3e0yeRjeVEIgubSqk17XI9pcb8HkSRxIeaVIkDD8jw3w+Qyc14Exmkbk+T+OZrMAh
 SG/zvuA9/CdjrYkdYM0vxsRnTtx9CGhw4RJTPM1gY7uOhUDCaCZU29ZQJjEiTGqxq6Zb/Wl4g
 DY8BpM5aShoiCsMlXvsJD/yhbenVP6idRpTCvDzoUadCatBh1xmRAPbYTiWG7VZWyGYHdgaPF
 1GBePQHk/c2IviXwnd4D0ljOX0i69DlvEkTOyNqVP9/oi5ph29DRityw+2975rZCh9gYDxkJG
 fg3gaww8NV0FMAkqLcb0WUaV7epUEYSk8py97Tq/DpYmYo8VhovBUpBHNcSjjdYFEG/Xc6Mho
 zwL/TfL9CxZYaEl7e1C9yrrjHCW8qpvQP/2EwD9nWeu/vizTjcJ26gLRMEI74fVknkOEQzUB3
 UL3/6Tke6VBxt2NP/n/gnl+KaQcHkpNxypyU5KdidnqDLEB+f3udTvSHdhL/SzChTFQBS5s7t
 QSnUH4Wg1uiEDlgI+pPj6WEY+lE2DtjUbaA+3QGAlxhuQuLcZ7CHe09kbqgx3R2uRaoMj+Ebo
 3s+UJIrLFSBkcbYvZCNl1/TEE2t9J/216n+vXc8UBxLZkwl3JpOkgrNtEX2KKendK+luPG9zQ
 q0DiQTebQvV6J8XhY+nw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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

Notes:
    v2: change accordingly to Thomas' comments
      - Replace MMU feature id by a CPU feature id
      - fix 68030 mask
      - add 68060 mask
      - only mask in m68k_movec_to() function

 target/m68k/cpu.c    | 27 +++++++++++++++++++++------
 target/m68k/cpu.h    |  5 ++++-
 target/m68k/helper.c | 10 +++++++++-
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index e6596de29c..f6a46bf2fb 100644
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
@@ -136,14 +133,31 @@ static void m68020_cpu_initfn(Object *obj)
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
+    m68k_set_feature(env, M68K_FEATURE_M68020);
+}
+
+static void m68030_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m680x0_cpu_common(env);
+    m68k_set_feature(env, M68K_FEATURE_M68030);
+}
 
 static void m68040_cpu_initfn(Object *obj)
 {
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
-    m68020_cpu_initfn(obj);
+    m680x0_cpu_common(env);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
@@ -166,6 +180,7 @@ static void m68060_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_BKPT);
     m68k_set_feature(env, M68K_FEATURE_RTD);
     m68k_set_feature(env, M68K_FEATURE_CHK2);
+    m68k_set_feature(env, M68K_FEATURE_M68060);
 }
 
 static void m5208_cpu_initfn(Object *obj)
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 20de3c379a..11c71fa962 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -460,6 +460,10 @@ void do_m68k_semihosting(CPUM68KState *env, int nr);
 
 enum m68k_features {
     M68K_FEATURE_M68000,
+    M68K_FEATURE_M68020,
+    M68K_FEATURE_M68030,
+    M68K_FEATURE_M68040,
+    M68K_FEATURE_M68060,
     M68K_FEATURE_CF_ISA_A,
     M68K_FEATURE_CF_ISA_B, /* (ISA B or C).  */
     M68K_FEATURE_CF_ISA_APLUSC, /* BIT/BITREV, FF1, STRLDSR (ISA A+ or C).  */
@@ -481,7 +485,6 @@ enum m68k_features {
     M68K_FEATURE_BKPT,
     M68K_FEATURE_RTD,
     M68K_FEATURE_CHK2,
-    M68K_FEATURE_M68040, /* instructions specific to MC68040 */
     M68K_FEATURE_MOVEP,
 };
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index ae766a6cb0..4aa13b34ed 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -205,7 +205,15 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
         return;
     /* MC680[234]0 */
     case M68K_CR_CACR:
-        env->cacr = val;
+        if (m68k_feature(env, M68K_FEATURE_M68020)) {
+            env->cacr = val & 0x0000000f;
+        } else if (m68k_feature(env, M68K_FEATURE_M68030)) {
+            env->cacr = val & 0x00003f1f;
+        } else if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->cacr = val & 0x80008000;
+        } else if (m68k_feature(env, M68K_FEATURE_M68060)) {
+            env->cacr = val & 0xf8e0e000;
+        }
         m68k_switch_sp(env);
         return;
     /* MC680[34]0 */
-- 
2.24.1


