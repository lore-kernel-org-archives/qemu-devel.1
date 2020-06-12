Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C5B20801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHlHKS5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C5B20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmEr-0006eN-1O
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmDv-0005OW-Qb
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:08:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmDu-00013b-0l
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591978085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlGv0ColsFzFdBWt58Lk3HnUJTk37xOsT1i8UmuRwiU=;
 b=jHlHKS5p3RxHEJA/WisoEcu/4HsxWLzyV7L9uDx5+iPmkUNQ0LEU68jZijc5o9nOFE8Lc1
 j3eZSrlaHztU3+nsiJ331BFUltzQOMi4IOUCiSa5Lb627ZCqayE0EX7McnWyvRsUMGyD5H
 s/tNPkBZaja1kaRNmtsdFBHc1rSWOWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-psHKMq66NsuGNbnpcc8mkQ-1; Fri, 12 Jun 2020 12:08:00 -0400
X-MC-Unique: psHKMq66NsuGNbnpcc8mkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8AB4800053;
 Fri, 12 Jun 2020 16:07:59 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AD778FF98;
 Fri, 12 Jun 2020 16:07:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 097/116] i386: hvf: Move lazy_flags into CPUX86State
Date: Fri, 12 Jun 2020 12:07:54 -0400
Message-Id: <20200612160755.9597-4-pbonzini@redhat.com>
In-Reply-To: <20200612160755.9597-1-pbonzini@redhat.com>
References: <20200612160755.9597-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

The lazy flags are still needed for instruction decoder.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-12-r.bolshakov@yadro.com>
[Move struct to target/i386/cpu.h - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           |  6 ++++
 target/i386/hvf/x86.h       |  6 ----
 target/i386/hvf/x86_flags.c | 57 ++++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c2b8bdcbde..f742ba933f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1366,6 +1366,11 @@ typedef struct CPUCaches {
         CPUCacheInfo *l3_cache;
 } CPUCaches;
 
+typedef struct HVFX86LazyFlags {
+    target_ulong result;
+    target_ulong auxbits;
+} HVFX86LazyFlags;
+
 typedef struct CPUX86State {
     /* standard registers */
     target_ulong regs[CPU_NB_REGS];
@@ -1597,6 +1602,7 @@ typedef struct CPUX86State {
     struct kvm_nested_state *nested_state;
 #endif
 #if defined(CONFIG_HVF)
+    HVFX86LazyFlags hvf_lflags;
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
2.26.2



