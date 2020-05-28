Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF34C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2F82078C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="I7zbaMRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2F82078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOR9-0000Zw-BV
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOMB-0000j5-Ao
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:23 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35562 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOM9-000765-Vr
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:23 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id CA6E54C86D;
 Thu, 28 May 2020 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694687; x=1592509088; bh=T0t6gbTnmCkqEgp2YRNFtSbij8dlok9p59/
 5W+zsOyI=; b=I7zbaMRlwixKbtNZ10K7gkK1GQz4S0Qt6KhvBKKg8UpC/ovJX+J
 feMgiDj2bNDcRjfXLSR+4fGodjgSEbYN+qzCWsEaeJw4eoJcKTAS2kNyWvk7mz/P
 9NJfulgmljg2uHWQOternHHDVt6VpQokPfYScE/8i5e+w7CQu+I3IDBI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3q_noxyg_Lx; Thu, 28 May 2020 22:38:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 5EBF04C864;
 Thu, 28 May 2020 22:38:05 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:07 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 11/13] i386: hvf: Move lazy_flags into CPUX86State
Date: Thu, 28 May 2020 22:37:56 +0300
Message-ID: <20200528193758.51454-12-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200528193758.51454-1-r.bolshakov@yadro.com>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:38:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The lazy flags are still needed for instruction decoder.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 include/sysemu/hvf.h        |  7 +++++
 target/i386/cpu.h           |  2 ++
 target/i386/hvf/x86.h       |  6 ----
 target/i386/hvf/x86_flags.c | 57 ++++++++++++++++++-------------------
 4 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index cf579e1592..41f5470c96 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -15,9 +15,16 @@
 
 extern bool hvf_allowed;
 #ifdef CONFIG_HVF
+#include "exec/cpu-defs.h"
+
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                                  int reg);
 #define hvf_enabled() (hvf_allowed)
+
+typedef struct hvf_lazy_flags {
+    target_ulong result;
+    target_ulong auxbits;
+} hvf_lazy_flags;
 #else
 #define hvf_enabled() 0
 #define hvf_get_supported_cpuid(func, idx, reg) 0
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 408392dbf6..7e6566565a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -20,6 +20,7 @@
 #ifndef I386_CPU_H
 #define I386_CPU_H
 
+#include "sysemu/hvf.h"
 #include "sysemu/tcg.h"
 #include "cpu-qom.h"
 #include "hyperv-proto.h"
@@ -1591,6 +1592,7 @@ typedef struct CPUX86State {
     struct kvm_nested_state *nested_state;
 #endif
 #if defined(CONFIG_HVF)
+    hvf_lazy_flags hvf_lflags;
     HVFX86EmulatorState *hvf_emul;
 #endif
 
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 6048b5cc74..2363616c07 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -228,14 +228,8 @@ typedef struct x68_segment_selector {
     };
 } __attribute__ ((__packed__)) x68_segment_selector;
 
-typedef struct lazy_flags {
-    target_ulong result;
-    target_ulong auxbits;
-} lazy_flags;
-
 /* Definition of hvf_x86_state is here */
 struct HVFX86EmulatorState {
-    struct lazy_flags   lflags;
     uint8_t mmio_buf[4096];
 };
 
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 1152cd7234..5ca4f41f5c 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -63,7 +63,7 @@
 #define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
     target_ulong temp = ((lf_carries) & (LF_MASK_AF)) | \
     (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
-    env->hvf_emul->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    env->hvf_lflags.result = (target_ulong)(int##size##_t)(lf_result); \
     if ((size) == 32) { \
         temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
     } else if ((size) == 16) { \
@@ -73,7 +73,7 @@
     } else { \
         VM_PANIC("unimplemented");  \
     } \
-    env->hvf_emul->lflags.auxbits = (target_ulong)(uint32_t)temp; \
+    env->hvf_lflags.auxbits = (target_ulong)(uint32_t)temp; \
 }
 
 /* carries, result */
@@ -100,10 +100,10 @@
     } else { \
         VM_PANIC("unimplemented");      \
     } \
-    env->hvf_emul->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
-    target_ulong delta_c = (env->hvf_emul->lflags.auxbits ^ temp) & LF_MASK_CF; \
+    env->hvf_lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    target_ulong delta_c = (env->hvf_lflags.auxbits ^ temp) & LF_MASK_CF; \
     delta_c ^= (delta_c >> 1); \
-    env->hvf_emul->lflags.auxbits = (target_ulong)(uint32_t)(temp ^ delta_c); \
+    env->hvf_lflags.auxbits = (target_ulong)(uint32_t)(temp ^ delta_c); \
 }
 
 /* carries, result */
@@ -117,9 +117,8 @@
 void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf)
 {
     uint32_t temp_po = new_of ^ new_cf;
-    env->hvf_emul->lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
-    env->hvf_emul->lflags.auxbits |= (temp_po << LF_BIT_PO) |
-                                     (new_cf << LF_BIT_CF);
+    env->hvf_lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
+    env->hvf_lflags.auxbits |= (temp_po << LF_BIT_PO) | (new_cf << LF_BIT_CF);
 }
 
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
@@ -215,27 +214,27 @@ void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
 
 bool get_PF(CPUX86State *env)
 {
-    uint32_t temp = (255 & env->hvf_emul->lflags.result);
-    temp = temp ^ (255 & (env->hvf_emul->lflags.auxbits >> LF_BIT_PDB));
+    uint32_t temp = (255 & env->hvf_lflags.result);
+    temp = temp ^ (255 & (env->hvf_lflags.auxbits >> LF_BIT_PDB));
     temp = (temp ^ (temp >> 4)) & 0x0F;
     return (0x9669U >> temp) & 1;
 }
 
 void set_PF(CPUX86State *env, bool val)
 {
-    uint32_t temp = (255 & env->hvf_emul->lflags.result) ^ (!val);
-    env->hvf_emul->lflags.auxbits &= ~(LF_MASK_PDB);
-    env->hvf_emul->lflags.auxbits |= (temp << LF_BIT_PDB);
+    uint32_t temp = (255 & env->hvf_lflags.result) ^ (!val);
+    env->hvf_lflags.auxbits &= ~(LF_MASK_PDB);
+    env->hvf_lflags.auxbits |= (temp << LF_BIT_PDB);
 }
 
 bool get_OF(CPUX86State *env)
 {
-    return ((env->hvf_emul->lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
+    return ((env->hvf_lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
 }
 
 bool get_CF(CPUX86State *env)
 {
-    return (env->hvf_emul->lflags.auxbits >> LF_BIT_CF) & 1;
+    return (env->hvf_lflags.auxbits >> LF_BIT_CF) & 1;
 }
 
 void set_OF(CPUX86State *env, bool val)
@@ -252,45 +251,45 @@ void set_CF(CPUX86State *env, bool val)
 
 bool get_AF(CPUX86State *env)
 {
-    return (env->hvf_emul->lflags.auxbits >> LF_BIT_AF) & 1;
+    return (env->hvf_lflags.auxbits >> LF_BIT_AF) & 1;
 }
 
 void set_AF(CPUX86State *env, bool val)
 {
-    env->hvf_emul->lflags.auxbits &= ~(LF_MASK_AF);
-    env->hvf_emul->lflags.auxbits |= val << LF_BIT_AF;
+    env->hvf_lflags.auxbits &= ~(LF_MASK_AF);
+    env->hvf_lflags.auxbits |= val << LF_BIT_AF;
 }
 
 bool get_ZF(CPUX86State *env)
 {
-    return !env->hvf_emul->lflags.result;
+    return !env->hvf_lflags.result;
 }
 
 void set_ZF(CPUX86State *env, bool val)
 {
     if (val) {
-        env->hvf_emul->lflags.auxbits ^=
-         (((env->hvf_emul->lflags.result >> LF_SIGN_BIT) & 1) << LF_BIT_SD);
+        env->hvf_lflags.auxbits ^=
+         (((env->hvf_lflags.result >> LF_SIGN_BIT) & 1) << LF_BIT_SD);
         /* merge the parity bits into the Parity Delta Byte */
-        uint32_t temp_pdb = (255 & env->hvf_emul->lflags.result);
-        env->hvf_emul->lflags.auxbits ^= (temp_pdb << LF_BIT_PDB);
+        uint32_t temp_pdb = (255 & env->hvf_lflags.result);
+        env->hvf_lflags.auxbits ^= (temp_pdb << LF_BIT_PDB);
         /* now zero the .result value */
-        env->hvf_emul->lflags.result = 0;
+        env->hvf_lflags.result = 0;
     } else {
-        env->hvf_emul->lflags.result |= (1 << 8);
+        env->hvf_lflags.result |= (1 << 8);
     }
 }
 
 bool get_SF(CPUX86State *env)
 {
-    return ((env->hvf_emul->lflags.result >> LF_SIGN_BIT) ^
-            (env->hvf_emul->lflags.auxbits >> LF_BIT_SD)) & 1;
+    return ((env->hvf_lflags.result >> LF_SIGN_BIT) ^
+            (env->hvf_lflags.auxbits >> LF_BIT_SD)) & 1;
 }
 
 void set_SF(CPUX86State *env, bool val)
 {
     bool temp_sf = get_SF(env);
-    env->hvf_emul->lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
+    env->hvf_lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
 }
 
 void lflags_to_rflags(CPUX86State *env)
@@ -305,7 +304,7 @@ void lflags_to_rflags(CPUX86State *env)
 
 void rflags_to_lflags(CPUX86State *env)
 {
-    env->hvf_emul->lflags.auxbits = env->hvf_emul->lflags.result = 0;
+    env->hvf_lflags.auxbits = env->hvf_lflags.result = 0;
     set_OF(env, env->eflags & CC_O);
     set_SF(env, env->eflags & CC_S);
     set_ZF(env, env->eflags & CC_Z);
-- 
2.26.1


