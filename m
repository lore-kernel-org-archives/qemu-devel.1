Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56787C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81B12076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuygONO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81B12076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdYH-000634-OV
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWD-00046u-Ek
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWA-0004Vv-Rs
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:55:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iF19ylsb87XOCNhKgDHz3AYQfhUYpcZ9HYPwIBhDaJY=;
 b=HuygONO/h5vI0TCJtJBKfdssv5jte7tFpliemDp9wINHPVeLHX4/oUY57C3XL/ISrp3L0E
 jFgAd33ZwfUrij9E449jsWjBq73w1srCP1WwrshsYz5Cb690FhXnfM5MzGR1czoVpXOOJd
 QTrP7+u+9bS6oYABmkNgsGC9EldJIFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-P9_HiuyWNkuMPzWBtxM2Qg-1; Wed, 30 Sep 2020 10:55:40 -0400
X-MC-Unique: P9_HiuyWNkuMPzWBtxM2Qg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D80805EE3;
 Wed, 30 Sep 2020 14:55:39 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDA655C1C4;
 Wed, 30 Sep 2020 14:55:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/20] s390x/tcg: Implement 32/128 bit for VECTOR FP ADD
Date: Wed, 30 Sep 2020 16:55:07 +0200
Message-Id: <20200930145523.71087-5-david@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
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

In case of 128bit, we always have a single element.

Add some helpers that allow to generically read/write 32/64/128 bit
floats. Convert the existing implementation of vop64_3 into a macro that
deals with float* instead of uint* instead - the other users keep
working as
    typedef uint32_t float32;
    typedef uint64_t float64;

Most of them will get converted next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |   3 +
 target/s390x/translate_vx.c.inc |  31 +++++++--
 target/s390x/vec_fpu_helper.c   | 119 +++++++++++++++++++++-----------
 3 files changed, 107 insertions(+), 46 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index f579fd38a7..3d59f143e0 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -247,8 +247,11 @@ DEF_HELPER_6(gvec_vstrc_cc_rt16, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_6(gvec_vstrc_cc_rt32, void, ptr, cptr, cptr, cptr, env, i32)
 
 /* === Vector Floating-Point Instructions */
+DEF_HELPER_FLAGS_5(gvec_vfa32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfa32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfa64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfa64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfa128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_4(gvec_wfc64, void, cptr, cptr, env, i32)
 DEF_HELPER_4(gvec_wfk64, void, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfce64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index 4c1b430013..2ba2170b16 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2504,16 +2504,27 @@ static DisasJumpType op_vfa(DisasContext *s, DisasOps *o)
     const uint8_t fpf = get_field(s, m4);
     const uint8_t m5 = get_field(s, m5);
     const bool se = extract32(m5, 3, 1);
-    gen_helper_gvec_3_ptr *fn;
-
-    if (fpf != FPF_LONG || extract32(m5, 0, 3)) {
-        gen_program_exception(s, PGM_SPECIFICATION);
-        return DISAS_NORETURN;
-    }
+    gen_helper_gvec_3_ptr *fn = NULL;
 
     switch (s->fields.op2) {
     case 0xe3:
-        fn = se ? gen_helper_gvec_vfa64s : gen_helper_gvec_vfa64;
+        switch (fpf) {
+        case FPF_SHORT:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = se ? gen_helper_gvec_vfa32s : gen_helper_gvec_vfa32;
+            }
+            break;
+        case FPF_LONG:
+            fn = se ? gen_helper_gvec_vfa64s : gen_helper_gvec_vfa64;
+            break;
+        case FPF_EXT:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = gen_helper_gvec_vfa128;
+            }
+            break;
+        default:
+            break;
+        }
         break;
     case 0xe5:
         fn = se ? gen_helper_gvec_vfd64s : gen_helper_gvec_vfd64;
@@ -2527,6 +2538,12 @@ static DisasJumpType op_vfa(DisasContext *s, DisasOps *o)
     default:
         g_assert_not_reached();
     }
+
+    if (!fn || extract32(m5, 0, 3)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
     gen_gvec_3_ptr(get_field(s, v1), get_field(s, v2),
                    get_field(s, v3), cpu_env, 0, fn);
     return DISAS_NEXT;
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index c1564e819b..ae803ba602 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -78,6 +78,40 @@ static void handle_ieee_exc(CPUS390XState *env, uint8_t vxc, uint8_t vec_exc,
     }
 }
 
+static float32 s390_vec_read_float32(const S390Vector *v, uint8_t enr)
+{
+    return make_float32(s390_vec_read_element32(v, enr));
+}
+
+static float64 s390_vec_read_float64(const S390Vector *v, uint8_t enr)
+{
+    return make_float64(s390_vec_read_element64(v, enr));
+}
+
+static float128 s390_vec_read_float128(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr == 0);
+    return make_float128(s390_vec_read_element64(v, 0),
+                         s390_vec_read_element64(v, 1));
+}
+
+static void s390_vec_write_float32(S390Vector *v, uint8_t enr, float32 data)
+{
+    return s390_vec_write_element32(v, enr, data);
+}
+
+static void s390_vec_write_float64(S390Vector *v, uint8_t enr, float64 data)
+{
+    return s390_vec_write_element64(v, enr, data);
+}
+
+static void s390_vec_write_float128(S390Vector *v, uint8_t enr, float128 data)
+{
+    g_assert(enr == 0);
+    s390_vec_write_element64(v, 0, data.high);
+    s390_vec_write_element64(v, 1, data.low);
+}
+
 typedef uint64_t (*vop64_2_fn)(uint64_t a, float_status *s);
 static void vop64_2(S390Vector *v1, const S390Vector *v2, CPUS390XState *env,
                     bool s, bool XxC, uint8_t erm, vop64_2_fn fn,
@@ -102,45 +136,52 @@ static void vop64_2(S390Vector *v1, const S390Vector *v2, CPUS390XState *env,
     *v1 = tmp;
 }
 
-typedef uint64_t (*vop64_3_fn)(uint64_t a, uint64_t b, float_status *s);
-static void vop64_3(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
-                    CPUS390XState *env, bool s, vop64_3_fn fn,
-                    uintptr_t retaddr)
-{
-    uint8_t vxc, vec_exc = 0;
-    S390Vector tmp = {};
-    int i;
-
-    for (i = 0; i < 2; i++) {
-        const uint64_t a = s390_vec_read_element64(v2, i);
-        const uint64_t b = s390_vec_read_element64(v3, i);
-
-        s390_vec_write_element64(&tmp, i, fn(a, b, &env->fpu_status));
-        vxc = check_ieee_exc(env, i, false, &vec_exc);
-        if (s || vxc) {
-            break;
-        }
-    }
-    handle_ieee_exc(env, vxc, vec_exc, retaddr);
-    *v1 = tmp;
-}
-
-static uint64_t vfa64(uint64_t a, uint64_t b, float_status *s)
-{
-    return float64_add(a, b, s);
-}
-
-void HELPER(gvec_vfa64)(void *v1, const void *v2, const void *v3,
-                        CPUS390XState *env, uint32_t desc)
-{
-    vop64_3(v1, v2, v3, env, false, vfa64, GETPC());
-}
-
-void HELPER(gvec_vfa64s)(void *v1, const void *v2, const void *v3,
-                         CPUS390XState *env, uint32_t desc)
-{
-    vop64_3(v1, v2, v3, env, true, vfa64, GETPC());
-}
+#define DEF_VOP_3(BITS)                                                        \
+typedef float##BITS (*vop##BITS##_3_fn)(float##BITS a, float##BITS b,          \
+                                        float_status *s);                      \
+static void vop##BITS##_3(S390Vector *v1, const S390Vector *v2,                \
+                          const S390Vector *v3, CPUS390XState *env, bool s,    \
+                          vop##BITS##_3_fn fn, uintptr_t retaddr)              \
+{                                                                              \
+    uint8_t vxc, vec_exc = 0;                                                  \
+    S390Vector tmp = {};                                                       \
+    int i;                                                                     \
+                                                                               \
+    for (i = 0; i < (128 / BITS); i++) {                                       \
+        const float##BITS a = s390_vec_read_float##BITS(v2, i);                \
+        const float##BITS b = s390_vec_read_float##BITS(v3, i);                \
+                                                                               \
+        s390_vec_write_float##BITS(&tmp, i, fn(a, b, &env->fpu_status));       \
+        vxc = check_ieee_exc(env, i, false, &vec_exc);                         \
+        if (s || vxc) {                                                        \
+            break;                                                             \
+        }                                                                      \
+    }                                                                          \
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);                               \
+    *v1 = tmp;                                                                 \
+}
+DEF_VOP_3(32)
+DEF_VOP_3(64)
+DEF_VOP_3(128)
+
+#define DEF_GVEC_FVA(BITS)                                                     \
+void HELPER(gvec_vfa##BITS)(void *v1, const void *v2, const void *v3,          \
+                            CPUS390XState *env, uint32_t desc)                 \
+{                                                                              \
+    vop##BITS##_3(v1, v2, v3, env, false, float##BITS##_add, GETPC());         \
+}
+DEF_GVEC_FVA(32)
+DEF_GVEC_FVA(64)
+DEF_GVEC_FVA(128)
+
+#define DEF_GVEC_FVA_S(BITS)                                                   \
+void HELPER(gvec_vfa##BITS##s)(void *v1, const void *v2, const void *v3,       \
+                               CPUS390XState *env, uint32_t desc)              \
+{                                                                              \
+    vop##BITS##_3(v1, v2, v3, env, true, float##BITS##_add, GETPC());          \
+}
+DEF_GVEC_FVA_S(32)
+DEF_GVEC_FVA_S(64)
 
 static int wfc64(const S390Vector *v1, const S390Vector *v2,
                  CPUS390XState *env, bool signal, uintptr_t retaddr)
-- 
2.26.2


