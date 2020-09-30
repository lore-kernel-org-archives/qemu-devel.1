Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB242C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54ABB206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxGu6beK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54ABB206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdiw-0008St-Bo
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWi-0004ml-HH
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWf-0004cZ-BH
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nPx3FSI4X/Hr5CcoHPYLB9EVSZSLhJX8oA5UyXU4V8=;
 b=DxGu6beKn+VxGVxBjZpzwdAmuWaQKM3yBY0FGuT+tKrL00rUPu7c9lNcmbc/oJRl4ct4SG
 SjH+Saxl6QmiCZmvPEO7BcFj/VK9IhI3xnb4SCgZWuT9ZkS1k0ocdwZKwiUEz5CMZHJNty
 vwGr6nEIT6YCVtI0P1wLuXk6vzuoN6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-XBk9GE-9Nry-ca-JGtHx7g-1; Wed, 30 Sep 2020 10:56:10 -0400
X-MC-Unique: XBk9GE-9Nry-ca-JGtHx7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B6651021200;
 Wed, 30 Sep 2020 14:56:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1F445C1C4;
 Wed, 30 Sep 2020 14:56:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 16/20] s390x/tcg: Implement 32/128bit for VECTOR FP
 MULTIPLY AND (ADD|SUBTRACT)
Date: Wed, 30 Sep 2020 16:55:19 +0200
Message-Id: <20200930145523.71087-17-david@redhat.com>
In-Reply-To: <20200930145523.71087-1-david@redhat.com>
References: <20200930145523.71087-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  6 ++
 target/s390x/translate_vx.c.inc | 48 +++++++++++++---
 target/s390x/vec_fpu_helper.c   | 98 ++++++++++++++++++++-------------
 3 files changed, 107 insertions(+), 45 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index c2ded83669..e4d60299dc 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -317,10 +317,16 @@ DEF_HELPER_FLAGS_5(gvec_vfm32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfma32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfma32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfma64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfma64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfma128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfms32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfms32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfms128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq32, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index 6bd599b319..5d31498cc1 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2847,18 +2847,52 @@ static DisasJumpType op_vfma(DisasContext *s, DisasOps *o)
     const uint8_t m5 = get_field(s, m5);
     const uint8_t fpf = get_field(s, m6);
     const bool se = extract32(m5, 3, 1);
-    gen_helper_gvec_4_ptr *fn;
+    gen_helper_gvec_4_ptr *fn = NULL;
 
-    if (fpf != FPF_LONG || extract32(m5, 0, 3)) {
+    switch (s->fields.op2) {
+    case 0x8f:
+        switch (fpf) {
+        case FPF_SHORT:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = se ? gen_helper_gvec_vfma32s : gen_helper_gvec_vfma32;
+            }
+            break;
+        case FPF_LONG:
+            fn = se ? gen_helper_gvec_vfma64s : gen_helper_gvec_vfma64;
+            break;
+        default:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = gen_helper_gvec_vfma128;
+            }
+            break;
+        }
+        break;
+    case 0x8e:
+        switch (fpf) {
+        case FPF_SHORT:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = se ? gen_helper_gvec_vfms32s : gen_helper_gvec_vfms32;
+            }
+            break;
+        case FPF_LONG:
+            fn = se ? gen_helper_gvec_vfms64s : gen_helper_gvec_vfms64;
+            break;
+        default:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = gen_helper_gvec_vfms128;
+            }
+            break;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (!fn || extract32(m5, 0, 3)) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
 
-    if (s->fields.op2 == 0x8f) {
-        fn = se ? gen_helper_gvec_vfma64s : gen_helper_gvec_vfma64;
-    } else {
-        fn = se ? gen_helper_gvec_vfms64s : gen_helper_gvec_vfms64;
-    }
     gen_gvec_4_ptr(get_field(s, v1), get_field(s, v2),
                    get_field(s, v3), get_field(s, v4), cpu_env,
                    0, fn);
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index f18f0ae8e2..0b25718365 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -699,53 +699,75 @@ void HELPER(gvec_vfm##BITS##s)(void *v1, const void *v2, const void *v3,       \
 DEF_GVEC_FVM_S(32)
 DEF_GVEC_FVM_S(64)
 
-static void vfma64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
-                   const S390Vector *v4, CPUS390XState *env, bool s, int flags,
-                   uintptr_t retaddr)
-{
-    uint8_t vxc, vec_exc = 0;
-    S390Vector tmp = {};
-    int i;
-
-    for (i = 0; i < 2; i++) {
-        const uint64_t a = s390_vec_read_element64(v2, i);
-        const uint64_t b = s390_vec_read_element64(v3, i);
-        const uint64_t c = s390_vec_read_element64(v4, i);
-        uint64_t ret = float64_muladd(a, b, c, flags, &env->fpu_status);
-
-        s390_vec_write_element64(&tmp, i, ret);
-        vxc = check_ieee_exc(env, i, false, &vec_exc);
-        if (s || vxc) {
-            break;
-        }
-    }
-    handle_ieee_exc(env, vxc, vec_exc, retaddr);
-    *v1 = tmp;
+#define DEF_VFMA(BITS)                                                         \
+static void vfma##BITS(S390Vector *v1, const S390Vector *v2,                   \
+                       const S390Vector *v3, const S390Vector *v4,             \
+                       CPUS390XState *env, bool s, int flags,                  \
+                       uintptr_t retaddr)                                      \
+{                                                                              \
+    uint8_t vxc, vec_exc = 0;                                                  \
+    S390Vector tmp = {};                                                       \
+    int i;                                                                     \
+                                                                               \
+    for (i = 0; i < (128 / BITS); i++) {                                       \
+        const float##BITS a = s390_vec_read_float##BITS(v2, i);                \
+        const float##BITS b = s390_vec_read_float##BITS(v3, i);                \
+        const float##BITS c = s390_vec_read_float##BITS(v4, i);                \
+        float##BITS ret = float##BITS##_muladd(a, b, c, flags,                 \
+                                               &env->fpu_status);              \
+                                                                               \
+        s390_vec_write_float##BITS(&tmp, i, ret);                              \
+        vxc = check_ieee_exc(env, i, false, &vec_exc);                         \
+        if (s || vxc) {                                                        \
+            break;                                                             \
+        }                                                                      \
+    }                                                                          \
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);                               \
+    *v1 = tmp;                                                                 \
 }
+DEF_VFMA(32)
+DEF_VFMA(64)
+DEF_VFMA(128)
 
-void HELPER(gvec_vfma64)(void *v1, const void *v2, const void *v3,
-                         const void *v4, CPUS390XState *env, uint32_t desc)
-{
-    vfma64(v1, v2, v3, v4, env, false, 0, GETPC());
+#define DEF_GVEC_VFMA(BITS)                                                    \
+void HELPER(gvec_vfma##BITS)(void *v1, const void *v2, const void *v3,         \
+                             const void *v4, CPUS390XState *env, uint32_t desc)\
+{                                                                              \
+    vfma##BITS(v1, v2, v3, v4, env, false, 0, GETPC());                        \
 }
+DEF_GVEC_VFMA(32)
+DEF_GVEC_VFMA(64)
+DEF_GVEC_VFMA(128)
 
-void HELPER(gvec_vfma64s)(void *v1, const void *v2, const void *v3,
-                         const void *v4, CPUS390XState *env, uint32_t desc)
-{
-    vfma64(v1, v2, v3, v4, env, true, 0, GETPC());
+#define DEF_GVEC_VFMA_S(BITS)                                                  \
+void HELPER(gvec_vfma##BITS##s)(void *v1, const void *v2, const void *v3,      \
+                                const void *v4, CPUS390XState *env,            \
+                                uint32_t desc)                                 \
+{                                                                              \
+    vfma##BITS(v1, v2, v3, v4, env, true, 0, GETPC());                         \
 }
+DEF_GVEC_VFMA_S(32)
+DEF_GVEC_VFMA_S(64)
 
-void HELPER(gvec_vfms64)(void *v1, const void *v2, const void *v3,
-                         const void *v4, CPUS390XState *env, uint32_t desc)
-{
-    vfma64(v1, v2, v3, v4, env, false, float_muladd_negate_c, GETPC());
+#define DEF_GVEC_VFMS(BITS)                                                    \
+void HELPER(gvec_vfms##BITS)(void *v1, const void *v2, const void *v3,         \
+                             const void *v4, CPUS390XState *env, uint32_t desc)\
+{                                                                              \
+    vfma##BITS(v1, v2, v3, v4, env, false, float_muladd_negate_c, GETPC());    \
 }
+DEF_GVEC_VFMS(32)
+DEF_GVEC_VFMS(64)
+DEF_GVEC_VFMS(128)
 
-void HELPER(gvec_vfms64s)(void *v1, const void *v2, const void *v3,
-                         const void *v4, CPUS390XState *env, uint32_t desc)
-{
-    vfma64(v1, v2, v3, v4, env, true, float_muladd_negate_c, GETPC());
+#define DEF_GVEC_VFMS_S(BITS)                                                  \
+void HELPER(gvec_vfms##BITS##s)(void *v1, const void *v2, const void *v3,      \
+                                const void *v4, CPUS390XState *env,            \
+                                uint32_t desc)                                 \
+{                                                                              \
+    vfma##BITS(v1, v2, v3, v4, env, true, float_muladd_negate_c, GETPC());     \
 }
+DEF_GVEC_VFMS_S(32)
+DEF_GVEC_VFMS_S(64)
 
 #define DEF_GVEC_VFSQ(BITS)                                                    \
 void HELPER(gvec_vfsq##BITS)(void *v1, const void *v2, CPUS390XState *env,     \
-- 
2.26.2


