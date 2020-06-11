Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191ADC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E2620720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeKNZprr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E2620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUOA-00019P-UT
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAP-0001tQ-7c
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAM-0001Pv-N4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQIWOhTCDVHiTyMJn0+EqEwqVEfH0zb1TnfAOMSKdac=;
 b=MeKNZprrnoZfrSj5hpZI6/hQEgB8g0xhmg0g50Q0NaJnt8+01CIBjpo5Gf3pdWgQqyEBQc
 xFIV6IzPrA2JMA6r3j2/gJHZU9EP+yMP3cs5PjL5Hu4Tnldl7tQPwnPAieP6XDYnxYh9UR
 LhxCFYx0obKp5d0ir05N35vL0naFACU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-FRmbtqxCNsaCilv7E3QbrA-1; Thu, 11 Jun 2020 15:47:04 -0400
X-MC-Unique: FRmbtqxCNsaCilv7E3QbrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921B8801503;
 Thu, 11 Jun 2020 19:47:03 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A54E10013D0;
 Thu, 11 Jun 2020 19:47:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 096/115] i386: hvf: Move lazy_flags into CPUX86State
Date: Thu, 11 Jun 2020 15:44:30 -0400
Message-Id: <20200611194449.31468-97-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

The lazy flags are still needed for instruction decoder.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-12-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/sysemu/hvf.h        |  7 +++++
 target/i386/cpu.h           |  2 ++
 target/i386/hvf/x86.h       |  6 ----
 target/i386/hvf/x86_flags.c | 57 ++++++++++++++++++-------------------
 4 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 2af32e505e..9e09144a64 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -21,10 +21,17 @@
 #include <Hypervisor/hv_vmx.h>
 #include <Hypervisor/hv_error.h>
 #include "target/i386/cpu.h"
+#include "exec/cpu-defs.h"
+
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                                  int reg);
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
+
+typedef struct hvf_lazy_flags {
+    target_ulong result;
+    target_ulong auxbits;
+} hvf_lazy_flags;
 #else /* !CONFIG_HVF */
 #define hvf_enabled() 0
 #define hvf_get_supported_cpuid(func, idx, reg) 0
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c2b8bdcbde..86f4da1b66 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -20,6 +20,7 @@
 #ifndef I386_CPU_H
 #define I386_CPU_H
 
+#include "sysemu/hvf.h"
 #include "sysemu/tcg.h"
 #include "cpu-qom.h"
 #include "hyperv-proto.h"
@@ -1597,6 +1598,7 @@ typedef struct CPUX86State {
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
2.26.2



