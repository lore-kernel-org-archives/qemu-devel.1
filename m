Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD3DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579AC2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579AC2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51649 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6bs-0001FW-Im
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:35:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hU6aG-0000EI-7m
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hU6aE-0005rR-PD
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hU6aE-0005r1-HS; Fri, 24 May 2019 05:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D189930C1AE6;
	Fri, 24 May 2019 09:33:45 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-48.ams2.redhat.com [10.36.116.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 825D1620CD;
	Fri, 24 May 2019 09:33:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 11:33:33 +0200
Message-Id: <20190524093335.22241-4-david@redhat.com>
In-Reply-To: <20190524093335.22241-1-david@redhat.com>
References: <20190524093335.22241-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 24 May 2019 09:33:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/5] s390x/tcg: Implement VECTOR FIND
 ELEMENT NOT EQUAL
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

Similar to VECTOR FIND ELEMENT EQUAL. Core logic courtesy of Richard H.

Add s390_vec_read_element() that can deal with element sizes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h            |  6 +++
 target/s390x/insn-data.def       |  2 +
 target/s390x/translate_vx.inc.c  | 31 +++++++++++++
 target/s390x/vec.h               | 19 ++++++++
 target/s390x/vec_string_helper.c | 74 ++++++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a1b169b666..fb50b404db 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -224,6 +224,12 @@ DEF_HELPER_FLAGS_4(gvec_vfee32, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, i32)
 DEF_HELPER_5(gvec_vfee_cc8, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfee_cc16, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfee_cc32, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfene8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vfene16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_vfene32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_5(gvec_vfene_cc8, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfene_cc16, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfene_cc32, void, ptr, cptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d8907ef6a5..d03c1ee0b3 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1197,6 +1197,8 @@
     F(0xe782, VFAE,    VRR_b, V,   0, 0, 0, 0, vfae, 0, IF_VEC)
 /* VECTOR FIND ELEMENT EQUAL */
     F(0xe780, VFEE,    VRR_b, V,   0, 0, 0, 0, vfee, 0, IF_VEC)
+/* VECTOR FIND ELEMENT NOT EQUAL */
+    F(0xe781, VFENE,   VRR_b, V,   0, 0, 0, 0, vfene, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index b25afbc011..1ad0b62517 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2414,3 +2414,34 @@ static DisasJumpType op_vfee(DisasContext *s, Disa=
sOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfene(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    static gen_helper_gvec_3 * const g[3] =3D {
+        gen_helper_gvec_vfene8,
+        gen_helper_gvec_vfene16,
+        gen_helper_gvec_vfene32,
+    };
+    static gen_helper_gvec_3_ptr * const g_cc[3] =3D {
+        gen_helper_gvec_vfene_cc8,
+        gen_helper_gvec_vfene_cc16,
+        gen_helper_gvec_vfene_cc32,
+    };
+
+    if (es > ES_32 || m5 & ~0x3) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (extract32(m5, 0, 1)) {
+        gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       get_field(s->fields, v3), cpu_env, m5, g_cc[es]);
+        set_cc_static(s);
+    } else {
+        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       get_field(s->fields, v3), m5, g[es]);
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec.h b/target/s390x/vec.h
index 3313fb43ee..affc62874c 100644
--- a/target/s390x/vec.h
+++ b/target/s390x/vec.h
@@ -12,6 +12,8 @@
 #ifndef S390X_VEC_H
 #define S390X_VEC_H
=20
+#include "tcg/tcg.h"
+
 typedef union S390Vector {
     uint64_t doubleword[2];
     uint32_t word[4];
@@ -70,6 +72,23 @@ static inline uint64_t s390_vec_read_element64(const S=
390Vector *v, uint8_t enr)
     return v->doubleword[enr];
 }
=20
+static inline uint64_t s390_vec_read_element(const S390Vector *v, uint8_=
t enr,
+                                             uint8_t es)
+{
+    switch (es) {
+    case MO_8:
+        return s390_vec_read_element8(v, enr);
+    case MO_16:
+        return s390_vec_read_element16(v, enr);
+    case MO_32:
+        return s390_vec_read_element32(v, enr);
+    case MO_64:
+        return s390_vec_read_element64(v, enr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static inline void s390_vec_write_element8(S390Vector *v, uint8_t enr,
                                            uint8_t data)
 {
diff --git a/target/s390x/vec_string_helper.c b/target/s390x/vec_string_h=
elper.c
index 05ad99e173..0ee3470112 100644
--- a/target/s390x/vec_string_helper.c
+++ b/target/s390x/vec_string_helper.c
@@ -27,6 +27,15 @@ static inline uint64_t zero_search(uint64_t a, uint64_=
t mask)
     return ~(((a & mask) + mask) | a | mask);
 }
=20
+/*
+ * Returns a bit set in the MSB of each element that is not zero,
+ * as defined by the mask.
+ */
+static inline uint64_t nonzero_search(uint64_t a, uint64_t mask)
+{
+    return (((a & mask) + mask) | a) & ~mask;
+}
+
 /*
  * Returns the byte offset for the first match, or 16 for no match.
  */
@@ -209,3 +218,68 @@ void HELPER(gvec_vfee_cc##BITS)(void *v1, const void=
 *v2, const void *v3,      \
 DEF_VFEE_CC_HELPER(8)
 DEF_VFEE_CC_HELPER(16)
 DEF_VFEE_CC_HELPER(32)
+
+static int vfene(void *v1, const void *v2, const void *v3, bool zs, uint=
8_t es)
+{
+    const uint64_t mask =3D get_element_lsbs_mask(es);
+    uint64_t a0, a1, b0, b1, e0, e1, z0, z1;
+    uint64_t first_zero =3D 16;
+    uint64_t first_inequal;
+    bool smaller =3D false;
+
+    a0 =3D s390_vec_read_element64(v2, 0);
+    a1 =3D s390_vec_read_element64(v2, 1);
+    b0 =3D s390_vec_read_element64(v3, 0);
+    b1 =3D s390_vec_read_element64(v3, 1);
+    e0 =3D nonzero_search(a0 ^ b0, mask);
+    e1 =3D nonzero_search(a1 ^ b1, mask);
+    first_inequal =3D match_index(e0, e1);
+
+    /* identify the smaller element */
+    if (first_inequal < 16) {
+        uint8_t enr =3D first_inequal / (1 << es);
+        uint32_t a =3D s390_vec_read_element(v2, enr, es);
+        uint32_t b =3D s390_vec_read_element(v3, enr, es);
+
+        smaller =3D a < b;
+    }
+
+    if (zs) {
+        z0 =3D zero_search(a0, mask);
+        z1 =3D zero_search(a1, mask);
+        first_zero =3D match_index(z0, z1);
+    }
+
+    s390_vec_write_element64(v1, 0, MIN(first_inequal, first_zero));
+    s390_vec_write_element64(v1, 1, 0);
+    if (first_zero =3D=3D 16 && first_inequal =3D=3D 16) {
+        return 3;
+    } else if (first_zero < first_inequal) {
+        return 0;
+    }
+    return smaller ? 1 : 2;
+}
+
+#define DEF_VFENE_HELPER(BITS)                                          =
       \
+void HELPER(gvec_vfene##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                              uint32_t desc)                            =
       \
+{                                                                       =
       \
+    const bool zs =3D extract32(simd_data(desc), 1, 1);                 =
         \
+                                                                        =
       \
+    vfene(v1, v2, v3, zs, MO_##BITS);                                   =
       \
+}
+DEF_VFENE_HELPER(8)
+DEF_VFENE_HELPER(16)
+DEF_VFENE_HELPER(32)
+
+#define DEF_VFENE_CC_HELPER(BITS)                                       =
       \
+void HELPER(gvec_vfene_cc##BITS)(void *v1, const void *v2, const void *v=
3,     \
+                                 CPUS390XState *env, uint32_t desc)     =
       \
+{                                                                       =
       \
+    const bool zs =3D extract32(simd_data(desc), 1, 1);                 =
         \
+                                                                        =
       \
+    env->cc_op =3D vfene(v1, v2, v3, zs, MO_##BITS);                    =
         \
+}
+DEF_VFENE_CC_HELPER(8)
+DEF_VFENE_CC_HELPER(16)
+DEF_VFENE_CC_HELPER(32)
--=20
2.20.1


