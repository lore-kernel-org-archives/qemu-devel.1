Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175DCC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D162070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D162070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0e2-0001Bw-HT
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:36:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yo-0005ty-H6
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Ym-0002Hg-Vu
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hR0Ym-0002Gi-Md; Wed, 15 May 2019 16:31:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0168F3001A77;
	Wed, 15 May 2019 20:31:32 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 983BF62926;
	Wed, 15 May 2019 20:31:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:31:12 +0200
Message-Id: <20190515203112.506-6-david@redhat.com>
In-Reply-To: <20190515203112.506-1-david@redhat.com>
References: <20190515203112.506-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 15 May 2019 20:31:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 5/5] s390x/tcg: Implement VECTOR STRING
 RANGE COMPARE
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Crazy stuff. Implement it similar to VECTOR FIND ANY ELEMENT
EQUAL.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h            |   6 ++
 target/s390x/insn-data.def       |   2 +
 target/s390x/translate_vx.inc.c  |  37 +++++++++++
 target/s390x/vec_string_helper.c | 108 +++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 1f9f0b463b..f2743ccd97 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -236,6 +236,12 @@ DEF_HELPER_FLAGS_3(gvec_vistr32, TCG_CALL_NO_RWG, vo=
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
+DEF_HELPER_6(gvec_vstrc_cc8, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_6(gvec_vstrc_cc16, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_6(gvec_vstrc_cc32, void, ptr, cptr, cptr, cptr, env, i32)
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
index 437b416b4a..62a8d4d738 100644
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
@@ -2480,3 +2484,36 @@ static DisasJumpType op_vistr(DisasContext *s, Dis=
asOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vstrc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m5);
+    const uint8_t m6 =3D get_field(s->fields, m6);
+    static gen_helper_gvec_4_ptr * const cc[3] =3D {
+        gen_helper_gvec_vstrc_cc8,
+        gen_helper_gvec_vstrc_cc16,
+        gen_helper_gvec_vstrc_cc32,
+    };
+    static gen_helper_gvec_4 * const nocc[3] =3D {
+        gen_helper_gvec_vstrc8,
+        gen_helper_gvec_vstrc16,
+        gen_helper_gvec_vstrc32,
+    };
+
+    if (es > ES_32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (m6 & 1) {
+        gen_gvec_4_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       get_field(s->fields, v3), get_field(s->fields, v4=
),
+                       cpu_env, m6, cc[es]);
+        set_cc_static(s);
+    } else {
+        gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       get_field(s->fields, v3), get_field(s->fields, v4=
), m6,
+                       nocc[es]);
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_string_helper.c b/target/s390x/vec_string_h=
elper.c
index 2e998c21a2..6d6dbfa061 100644
--- a/target/s390x/vec_string_helper.c
+++ b/target/s390x/vec_string_helper.c
@@ -248,3 +248,111 @@ void HELPER(gvec_vistr_cc##BITS)(void *v1, const vo=
id *v2,                     \
 DEF_VISTR_CC_HELPER(8)
 DEF_VISTR_CC_HELPER(16)
 DEF_VISTR_CC_HELPER(32)
+
+#define DEF_ELEMENT_COMPARE(BITS)                                       =
       \
+static bool element_compare##BITS(uint##BITS##_t data, uint##BITS##_t l,=
       \
+                                  uint##BITS##_t c)                     =
       \
+{                                                                       =
       \
+    const bool equal =3D extract32(c, BITS - 1, 1);                     =
         \
+    const bool lower =3D extract32(c, BITS - 2, 1);                     =
         \
+    const bool higher =3D extract32(c, BITS - 3, 1);                    =
         \
+                                                                        =
       \
+    if (equal && data =3D=3D l) {                                       =
           \
+        return true;                                                    =
       \
+    } else if (lower && data < l) {                                     =
       \
+        return true;                                                    =
       \
+    } else if (higher && data > l) {                                    =
       \
+        return true;                                                    =
       \
+    }                                                                   =
       \
+    return false;                                                       =
       \
+}
+DEF_ELEMENT_COMPARE(8)
+DEF_ELEMENT_COMPARE(16)
+DEF_ELEMENT_COMPARE(32)
+
+#define DEF_VSTRC(BITS)                                                 =
       \
+static int vstrc##BITS(void *v1, const void *v2, const void *v3,        =
       \
+                       const void *v4, uint8_t m6)                      =
       \
+{                                                                       =
       \
+    const bool in =3D extract32(m6, 3, 1);                              =
         \
+    const bool rt =3D extract32(m6, 2, 1);                              =
         \
+    const bool zs =3D extract32(m6, 1, 1);                              =
         \
+    S390Vector tmp =3D {};                                              =
         \
+    int first_byte =3D 16;                                              =
         \
+    int cc =3D 3; /* no match */                                        =
         \
+    int i, j;                                                           =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t data =3D s390_vec_read_element##BITS(v2, i)=
;        \
+        bool any_comp =3D false;                                        =
         \
+                                                                        =
       \
+        if (zs && !data) {                                              =
       \
+            if (cc =3D=3D 3) {                                          =
           \
+                first_byte =3D i * (BITS / 8);                          =
         \
+                cc =3D 0; /* match for zero */                          =
         \
+            } else if (cc !=3D 0) {                                     =
         \
+                cc =3D 2; /* matching elements before match for zero */ =
         \
+            }                                                           =
       \
+            if (!rt) {                                                  =
       \
+                break;                                                  =
       \
+            }                                                           =
       \
+        }                                                               =
       \
+                                                                        =
       \
+        /* compare against every even-odd range pair */                 =
       \
+        for (j =3D 0; j < (128 / BITS); j +=3D 2) {                     =
           \
+            const uint##BITS##_t l1 =3D s390_vec_read_element##BITS(v3, =
j);      \
+            const uint##BITS##_t c1 =3D s390_vec_read_element##BITS(v4, =
j);      \
+            const uint##BITS##_t l2 =3D s390_vec_read_element##BITS(v3, =
j + 1);  \
+            const uint##BITS##_t c2 =3D s390_vec_read_element##BITS(v4, =
j + 1);  \
+                                                                        =
       \
+            if (element_compare##BITS(data, l1, c1) &&                  =
       \
+                element_compare##BITS(data, l2, c2)) {                  =
       \
+                any_comp =3D true;                                      =
         \
+                break;                                                  =
       \
+            }                                                           =
       \
+        }                                                               =
       \
+                                                                        =
       \
+        /* invert the result if requested */                            =
       \
+        any_comp =3D in ^ any_comp;                                     =
         \
+        if (cc =3D=3D 3 && any_comp) {                                  =
           \
+            first_byte =3D i * (BITS / 8);                              =
         \
+            cc =3D 1; /* matching elements, no match for zero */        =
         \
+            if (!zs && !rt) {                                           =
       \
+                break;                                                  =
       \
+            }                                                           =
       \
+        }                                                               =
       \
+        /* indicate bit vector if requested */                          =
       \
+        if (rt && any_comp) {                                           =
       \
+            s390_vec_write_element##BITS(&tmp, i, (uint##BITS##_t)-1ull)=
;      \
+        }                                                               =
       \
+    }                                                                   =
       \
+    if (!rt) {                                                          =
       \
+        s390_vec_write_element8(&tmp, 7, first_byte);                   =
       \
+    }                                                                   =
       \
+    *(S390Vector *)v1 =3D tmp;                                          =
         \
+    return cc;                                                          =
       \
+}
+DEF_VSTRC(8)
+DEF_VSTRC(16)
+DEF_VSTRC(32)
+
+#define DEF_VSTRC_HELPER(BITS)                                          =
       \
+void HELPER(gvec_vstrc##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                               const void *v4, uint32_t desc)           =
       \
+{                                                                       =
       \
+    vstrc##BITS(v1, v2, v3, v4, simd_data(desc));                       =
       \
+}
+DEF_VSTRC_HELPER(8)
+DEF_VSTRC_HELPER(16)
+DEF_VSTRC_HELPER(32)
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
+    env->cc_op =3D vstrc##BITS(v1, v2, v3, v4, simd_data(desc));        =
         \
+}
+DEF_VSTRC_CC_HELPER(8)
+DEF_VSTRC_CC_HELPER(16)
+DEF_VSTRC_CC_HELPER(32)
--=20
2.20.1


