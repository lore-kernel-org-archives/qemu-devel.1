Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDE9C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA2F2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA2F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcjS-0000mN-RH
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:42:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYccZ-00032q-1C
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYccM-0006Z4-Ef
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hYccG-0005tD-Sw; Wed, 05 Jun 2019 16:34:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 332B1C04959F;
	Wed,  5 Jun 2019 20:34:20 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-124.ams2.redhat.com [10.36.116.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC133619A9;
	Wed,  5 Jun 2019 20:34:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 22:33:35 +0200
Message-Id: <20190605203403.29461-6-david@redhat.com>
In-Reply-To: <20190605203403.29461-1-david@redhat.com>
References: <20190605203403.29461-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 05 Jun 2019 20:34:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 05/33] s390x/tcg: Implement
 VECTOR STRING RANGE COMPARE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately, there is no easy way to avoid looping over all elements
in v2. Provide specialized variants for !cc,!rt/!cc,rt/cc,!rt/cc,rt and
all element types. Especially for different values of rt, the compiler
might be able to optimize the code a lot.

Add s390_vec_write_element().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h            |  12 +++
 target/s390x/insn-data.def       |   2 +
 target/s390x/translate_vx.inc.c  |  59 +++++++++++++
 target/s390x/vec.h               |  21 +++++
 target/s390x/vec_string_helper.c | 143 +++++++++++++++++++++++++++++++
 5 files changed, 237 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 1f9f0b463b..5db67779d3 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -236,6 +236,18 @@ DEF_HELPER_FLAGS_3(gvec_vistr32, TCG_CALL_NO_RWG, vo=
id, ptr, cptr, i32)
 DEF_HELPER_4(gvec_vistr_cc8, void, ptr, cptr, env, i32)
 DEF_HELPER_4(gvec_vistr_cc16, void, ptr, cptr, env, i32)
 DEF_HELPER_4(gvec_vistr_cc32, void, ptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vstrc8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vstrc16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vstrc32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vstrc_rt8, TCG_CALL_NO_RWG, void, ptr, cptr, cpt=
r, cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vstrc_rt16, TCG_CALL_NO_RWG, void, ptr, cptr, cp=
tr, cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vstrc_rt32, TCG_CALL_NO_RWG, void, ptr, cptr, cp=
tr, cptr, i32)
+DEF_HELPER_6(gvec_vstrc_cc8, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_6(gvec_vstrc_cc16, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_6(gvec_vstrc_cc32, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_6(gvec_vstrc_cc_rt8, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_6(gvec_vstrc_cc_rt16, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_6(gvec_vstrc_cc_rt32, void, ptr, cptr, cptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index b4a6b59608..a2969fab58 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1201,6 +1201,8 @@
     F(0xe781, VFENE,   VRR_b, V,   0, 0, 0, 0, vfene, 0, IF_VEC)
 /* VECTOR ISOLATE STRING */
     F(0xe75c, VISTR,   VRR_a, V,   0, 0, 0, 0, vistr, 0, IF_VEC)
+/* VECTOR STRING RANGE COMPARE */
+    F(0xe78a, VSTRC,   VRR_d, V,   0, 0, 0, 0, vstrc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 08a62eab52..f26ffa2895 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -217,6 +217,10 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, ui=
nt8_t reg, TCGv_i64 enr,
     tcg_gen_gvec_4_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2),=
 \
                        vec_full_reg_offset(v3), vec_full_reg_offset(v4),=
 \
                        16, 16, data, fn)
+#define gen_gvec_4_ptr(v1, v2, v3, v4, ptr, data, fn) \
+    tcg_gen_gvec_4_ptr(vec_full_reg_offset(v1), vec_full_reg_offset(v2),=
 \
+                       vec_full_reg_offset(v3), vec_full_reg_offset(v4),=
 \
+                       ptr, 16, 16, data, fn)
 #define gen_gvec_dup_i64(es, v1, c) \
     tcg_gen_gvec_dup_i64(es, vec_full_reg_offset(v1), 16, 16, c)
 #define gen_gvec_mov(v1, v2) \
@@ -2479,3 +2483,58 @@ static DisasJumpType op_vistr(DisasContext *s, Dis=
asOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vstrc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m5);
+    const uint8_t m6 =3D get_field(s->fields, m6);
+    static gen_helper_gvec_4 * const g[3] =3D {
+        gen_helper_gvec_vstrc8,
+        gen_helper_gvec_vstrc16,
+        gen_helper_gvec_vstrc32,
+    };
+    static gen_helper_gvec_4 * const g_rt[3] =3D {
+        gen_helper_gvec_vstrc_rt8,
+        gen_helper_gvec_vstrc_rt16,
+        gen_helper_gvec_vstrc_rt32,
+    };
+    static gen_helper_gvec_4_ptr * const g_cc[3] =3D {
+        gen_helper_gvec_vstrc_cc8,
+        gen_helper_gvec_vstrc_cc16,
+        gen_helper_gvec_vstrc_cc32,
+    };
+    static gen_helper_gvec_4_ptr * const g_cc_rt[3] =3D {
+        gen_helper_gvec_vstrc_cc_rt8,
+        gen_helper_gvec_vstrc_cc_rt16,
+        gen_helper_gvec_vstrc_cc_rt32,
+    };
+
+    if (es > ES_32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (extract32(m6, 0, 1)) {
+        if (extract32(m6, 2, 1)) {
+            gen_gvec_4_ptr(get_field(s->fields, v1), get_field(s->fields=
, v2),
+                           get_field(s->fields, v3), get_field(s->fields=
, v4),
+                           cpu_env, m6, g_cc_rt[es]);
+        } else {
+            gen_gvec_4_ptr(get_field(s->fields, v1), get_field(s->fields=
, v2),
+                           get_field(s->fields, v3), get_field(s->fields=
, v4),
+                           cpu_env, m6, g_cc[es]);
+        }
+        set_cc_static(s);
+    } else {
+        if (extract32(m6, 2, 1)) {
+            gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields=
, v2),
+                           get_field(s->fields, v3), get_field(s->fields=
, v4),
+                           m6, g_rt[es]);
+        } else {
+            gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields=
, v2),
+                           get_field(s->fields, v3), get_field(s->fields=
, v4),
+                           m6, g[es]);
+        }
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec.h b/target/s390x/vec.h
index affc62874c..a6e361869b 100644
--- a/target/s390x/vec.h
+++ b/target/s390x/vec.h
@@ -117,4 +117,25 @@ static inline void s390_vec_write_element64(S390Vect=
or *v, uint8_t enr,
     v->doubleword[enr] =3D data;
 }
=20
+static inline void s390_vec_write_element(S390Vector *v, uint8_t enr,
+                                          uint8_t es, uint64_t data)
+{
+    switch (es) {
+    case MO_8:
+        s390_vec_write_element8(v, enr, data);
+        break;
+    case MO_16:
+        s390_vec_write_element16(v, enr, data);
+        break;
+    case MO_32:
+        s390_vec_write_element32(v, enr, data);
+        break;
+    case MO_64:
+        s390_vec_write_element64(v, enr, data);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #endif /* S390X_VEC_H */
diff --git a/target/s390x/vec_string_helper.c b/target/s390x/vec_string_h=
elper.c
index 6bafa23bd7..c516c0ceeb 100644
--- a/target/s390x/vec_string_helper.c
+++ b/target/s390x/vec_string_helper.c
@@ -328,3 +328,146 @@ void HELPER(gvec_vistr_cc##BITS)(void *v1, const vo=
id *v2, CPUS390XState *env, \
 DEF_VISTR_CC_HELPER(8)
 DEF_VISTR_CC_HELPER(16)
 DEF_VISTR_CC_HELPER(32)
+
+static bool element_compare(uint32_t data, uint32_t l, uint8_t c)
+{
+    const bool equal =3D extract32(c, 7, 1);
+    const bool lower =3D extract32(c, 6, 1);
+    const bool higher =3D extract32(c, 5, 1);
+
+    if (data < l) {
+        return lower;
+    } else if (data > l) {
+        return higher;
+    }
+    return equal;
+}
+
+static int vstrc(void *v1, const void *v2, const void *v3, const void *v=
4,
+                 bool in, bool rt, bool zs, uint8_t es)
+{
+    const uint64_t mask =3D get_element_lsbs_mask(es);
+    uint64_t a0 =3D s390_vec_read_element64(v2, 0);
+    uint64_t a1 =3D s390_vec_read_element64(v2, 1);
+    int first_zero =3D 16, first_match =3D 16;
+    S390Vector rt_result =3D {};
+    uint64_t z0, z1;
+    int i, j;
+
+    if (zs) {
+        z0 =3D zero_search(a0, mask);
+        z1 =3D zero_search(a1, mask);
+        first_zero =3D match_index(z0, z1);
+    }
+
+    for (i =3D 0; i < 16 / (1 << es); i++) {
+        const uint32_t data =3D s390_vec_read_element(v2, i, es);
+        const int cur_byte =3D i * (1 << es);
+        bool any_match =3D false;
+
+        /* if we don't need a bit vector, we can stop early */
+        if (cur_byte =3D=3D first_zero && !rt) {
+            break;
+        }
+
+        for (j =3D 0; j < 16 / (1 << es); j +=3D 2) {
+            const uint32_t l1 =3D s390_vec_read_element(v3, j, es);
+            const uint32_t l2 =3D s390_vec_read_element(v3, j + 1, es);
+            /* we are only interested in the highest byte of each elemen=
t */
+            const uint8_t c1 =3D s390_vec_read_element8(v4, j * (1 << es=
));
+            const uint8_t c2 =3D s390_vec_read_element8(v4, (j + 1) * (1=
 << es));
+
+            if (element_compare(data, l1, c1) &&
+                element_compare(data, l2, c2)) {
+                any_match =3D true;
+                break;
+            }
+        }
+        /* invert the result if requested */
+        any_match =3D in ^ any_match;
+
+        if (any_match) {
+            /* indicate bit vector if requested */
+            if (rt) {
+                const uint64_t val =3D -1ull;
+
+                first_match =3D MIN(cur_byte, first_match);
+                s390_vec_write_element(&rt_result, i, es, val);
+            } else {
+                /* stop on the first match */
+                first_match =3D cur_byte;
+                break;
+            }
+        }
+    }
+
+    if (rt) {
+        *(S390Vector *)v1 =3D rt_result;
+    } else {
+        s390_vec_write_element64(v1, 0, MIN(first_match, first_zero));
+        s390_vec_write_element64(v1, 1, 0);
+    }
+
+    if (first_zero =3D=3D 16 && first_match =3D=3D 16) {
+        return 3; /* no match */
+    } else if (first_zero =3D=3D 16) {
+        return 1; /* matching elements, no match for zero */
+    } else if (first_match < first_zero) {
+        return 2; /* matching elements before match for zero */
+    }
+    return 0; /* match for zero */
+}
+
+#define DEF_VSTRC_HELPER(BITS)                                          =
       \
+void HELPER(gvec_vstrc##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                              const void *v4, uint32_t desc)            =
       \
+{                                                                       =
       \
+    const bool in =3D extract32(simd_data(desc), 3, 1);                 =
         \
+    const bool zs =3D extract32(simd_data(desc), 1, 1);                 =
         \
+                                                                        =
       \
+    vstrc(v1, v2, v3, v4, in, 0, zs, MO_##BITS);                        =
       \
+}
+DEF_VSTRC_HELPER(8)
+DEF_VSTRC_HELPER(16)
+DEF_VSTRC_HELPER(32)
+
+#define DEF_VSTRC_RT_HELPER(BITS)                                       =
       \
+void HELPER(gvec_vstrc_rt##BITS)(void *v1, const void *v2, const void *v=
3,     \
+                                 const void *v4, uint32_t desc)         =
       \
+{                                                                       =
       \
+    const bool in =3D extract32(simd_data(desc), 3, 1);                 =
         \
+    const bool zs =3D extract32(simd_data(desc), 1, 1);                 =
         \
+                                                                        =
       \
+    vstrc(v1, v2, v3, v4, in, 1, zs, MO_##BITS);                        =
       \
+}
+DEF_VSTRC_RT_HELPER(8)
+DEF_VSTRC_RT_HELPER(16)
+DEF_VSTRC_RT_HELPER(32)
+
+#define DEF_VSTRC_CC_HELPER(BITS)                                       =
       \
+void HELPER(gvec_vstrc_cc##BITS)(void *v1, const void *v2, const void *v=
3,     \
+                                 const void *v4, CPUS390XState *env,    =
       \
+                                 uint32_t desc)                         =
       \
+{                                                                       =
       \
+    const bool in =3D extract32(simd_data(desc), 3, 1);                 =
         \
+    const bool zs =3D extract32(simd_data(desc), 1, 1);                 =
         \
+                                                                        =
       \
+    env->cc_op =3D vstrc(v1, v2, v3, v4, in, 0, zs, MO_##BITS);         =
         \
+}
+DEF_VSTRC_CC_HELPER(8)
+DEF_VSTRC_CC_HELPER(16)
+DEF_VSTRC_CC_HELPER(32)
+
+#define DEF_VSTRC_CC_RT_HELPER(BITS)                                    =
       \
+void HELPER(gvec_vstrc_cc_rt##BITS)(void *v1, const void *v2, const void=
 *v3,  \
+                                    const void *v4, CPUS390XState *env, =
       \
+                                    uint32_t desc)                      =
       \
+{                                                                       =
       \
+    const bool in =3D extract32(simd_data(desc), 3, 1);                 =
         \
+    const bool zs =3D extract32(simd_data(desc), 1, 1);                 =
         \
+                                                                        =
       \
+    env->cc_op =3D vstrc(v1, v2, v3, v4, in, 1, zs, MO_##BITS);         =
         \
+}
+DEF_VSTRC_CC_RT_HELPER(8)
+DEF_VSTRC_CC_RT_HELPER(16)
+DEF_VSTRC_CC_RT_HELPER(32)
--=20
2.21.0


