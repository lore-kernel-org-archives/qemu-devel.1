Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DA6C47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D316620657
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ete+61wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D316620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdor-0005NU-Gy
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWT-0004K8-0O
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWL-0004YZ-NG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fS4QHngTj254VtqntLPVcQidXyVTgWogTo9uzaV/pVM=;
 b=Ete+61wb8HizrmmouMpefal6du+TKPgEimcJCuW/ULB29J42PhEE/6UqW7O0+JrNPkO3Cx
 Aw2ZJOMJJRWXiCG9c1RGBxoUI+gYwuCFT/lbGcnsGtJq6zS3DM3l2EEVDIw13htCVqyDnY
 PBRGdppIiUb05uwncdfV2Ji/ldt7huo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-BRDRSrUXNLiWIES5DIwMGg-1; Wed, 30 Sep 2020 10:55:51 -0400
X-MC-Unique: BRDRSrUXNLiWIES5DIwMGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF94E1021208;
 Wed, 30 Sep 2020 14:55:49 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AEED5C1C4;
 Wed, 30 Sep 2020 14:55:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/20] s390x/tcg: Implement 32/128 bit for VECTOR FP
 COMPARE (AND SIGNAL) SCALAR
Date: Wed, 30 Sep 2020 16:55:11 +0200
Message-Id: <20200930145523.71087-9-david@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/s390x/helper.h           |  4 +++
 target/s390x/translate_vx.c.inc | 38 +++++++++++++++-----
 target/s390x/vec_fpu_helper.c   | 64 +++++++++++++++++++--------------
 3 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index ab41555764..6bf4d3e7d0 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -252,8 +252,12 @@ DEF_HELPER_FLAGS_5(gvec_vfa32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfa64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfa64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfa128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_4(gvec_wfc32, void, cptr, cptr, env, i32)
+DEF_HELPER_4(gvec_wfk32, void, cptr, cptr, env, i32)
 DEF_HELPER_4(gvec_wfc64, void, cptr, cptr, env, i32)
 DEF_HELPER_4(gvec_wfk64, void, cptr, cptr, env, i32)
+DEF_HELPER_4(gvec_wfc128, void, cptr, cptr, env, i32)
+DEF_HELPER_4(gvec_wfk128, void, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfce64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfce64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfce64_cc, void, ptr, cptr, cptr, env, i32)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index 91d4e74a68..cc745784e5 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2601,19 +2601,41 @@ static DisasJumpType op_wfc(DisasContext *s, DisasOps *o)
 {
     const uint8_t fpf = get_field(s, m3);
     const uint8_t m4 = get_field(s, m4);
+    gen_helper_gvec_2_ptr *fn = NULL;
 
-    if (fpf != FPF_LONG || m4) {
+    switch (fpf) {
+    case FPF_SHORT:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            fn = gen_helper_gvec_wfk32;
+            if (s->fields.op2 == 0xcb) {
+                fn = gen_helper_gvec_wfc32;
+            }
+        }
+        break;
+    case FPF_LONG:
+        fn = gen_helper_gvec_wfk64;
+        if (s->fields.op2 == 0xcb) {
+            fn = gen_helper_gvec_wfc64;
+        }
+        break;
+    case FPF_EXT:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            fn = gen_helper_gvec_wfk128;
+            if (s->fields.op2 == 0xcb) {
+                fn = gen_helper_gvec_wfc128;
+            }
+        }
+        break;
+    default:
+        break;
+    };
+
+    if (!fn || m4) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
 
-    if (s->fields.op2 == 0xcb) {
-        gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2),
-                       cpu_env, 0, gen_helper_gvec_wfc64);
-    } else {
-        gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2),
-                       cpu_env, 0, gen_helper_gvec_wfk64);
-    }
+    gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env, 0, fn);
     set_cc_static(s);
     return DISAS_NEXT;
 }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index 799e7f793e..1b78b6c088 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -183,37 +183,49 @@ void HELPER(gvec_vfa##BITS##s)(void *v1, const void *v2, const void *v3,       \
 DEF_GVEC_FVA_S(32)
 DEF_GVEC_FVA_S(64)
 
-static int wfc64(const S390Vector *v1, const S390Vector *v2,
-                 CPUS390XState *env, bool signal, uintptr_t retaddr)
-{
-    /* only the zero-indexed elements are compared */
-    const float64 a = s390_vec_read_element64(v1, 0);
-    const float64 b = s390_vec_read_element64(v2, 0);
-    uint8_t vxc, vec_exc = 0;
-    int cmp;
-
-    if (signal) {
-        cmp = float64_compare(a, b, &env->fpu_status);
-    } else {
-        cmp = float64_compare_quiet(a, b, &env->fpu_status);
-    }
-    vxc = check_ieee_exc(env, 0, false, &vec_exc);
-    handle_ieee_exc(env, vxc, vec_exc, retaddr);
-
-    return float_comp_to_cc(env, cmp);
+#define DEF_WFC(BITS)                                                          \
+static int wfc##BITS(const S390Vector *v1, const S390Vector *v2,               \
+                     CPUS390XState *env, bool signal, uintptr_t retaddr)       \
+{                                                                              \
+    /* only the zero-indexed elements are compared */                          \
+    const float##BITS a = s390_vec_read_float##BITS(v1, 0);                    \
+    const float##BITS b = s390_vec_read_float##BITS(v2, 0);                    \
+    uint8_t vxc, vec_exc = 0;                                                  \
+    int cmp;                                                                   \
+                                                                               \
+    if (signal) {                                                              \
+        cmp = float##BITS##_compare(a, b, &env->fpu_status);                   \
+    } else {                                                                   \
+        cmp = float##BITS##_compare_quiet(a, b, &env->fpu_status);             \
+    }                                                                          \
+    vxc = check_ieee_exc(env, 0, false, &vec_exc);                             \
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);                               \
+                                                                               \
+    return float_comp_to_cc(env, cmp);                                         \
 }
+DEF_WFC(32)
+DEF_WFC(64)
+DEF_WFC(128)
 
-void HELPER(gvec_wfc64)(const void *v1, const void *v2, CPUS390XState *env,
-                        uint32_t desc)
-{
-    env->cc_op = wfc64(v1, v2, env, false, GETPC());
+#define DEF_GVEC_WFC(BITS)                                                     \
+void HELPER(gvec_wfc##BITS)(const void *v1, const void *v2, CPUS390XState *env,\
+                            uint32_t desc)                                     \
+{                                                                              \
+    env->cc_op = wfc##BITS(v1, v2, env, false, GETPC());                       \
 }
+DEF_GVEC_WFC(32)
+DEF_GVEC_WFC(64)
+DEF_GVEC_WFC(128)
 
-void HELPER(gvec_wfk64)(const void *v1, const void *v2, CPUS390XState *env,
-                        uint32_t desc)
-{
-    env->cc_op = wfc64(v1, v2, env, true, GETPC());
+#define DEF_GVEC_WFK(BITS)                                                     \
+void HELPER(gvec_wfk##BITS)(const void *v1, const void *v2, CPUS390XState *env,\
+                            uint32_t desc)                                     \
+{                                                                              \
+    env->cc_op = wfc##BITS(v1, v2, env, true, GETPC());                        \
 }
+DEF_GVEC_WFK(32)
+DEF_GVEC_WFK(64)
+DEF_GVEC_WFK(128)
 
 typedef bool (*vfc64_fn)(float64 a, float64 b, float_status *status);
 static int vfc64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
-- 
2.26.2


