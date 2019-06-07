Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD3AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30802089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30802089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHQo-00079e-5a
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52612)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZFgf-0002ro-1f
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZFgd-0001eN-DC
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZFgd-0001ci-6D; Fri, 07 Jun 2019 10:17:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CE1D51032;
 Fri,  7 Jun 2019 14:17:34 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D667C68C89;
 Fri,  7 Jun 2019 14:17:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 16:16:55 +0200
Message-Id: <20190607141727.29018-3-cohuck@redhat.com>
In-Reply-To: <20190607141727.29018-1-cohuck@redhat.com>
References: <20190607141727.29018-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 14:17:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 02/34] s390x/tcg: Implement VECTOR FIND ANY
 ELEMENT EQUAL
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Complicated stuff. Provide two different helpers for CC an !CC handling.
We might want to add more helpers later.

zero_search() and match_index() are courtesy of Richard H.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/Makefile.objs       |   2 +-
 target/s390x/helper.h            |   8 ++
 target/s390x/insn-data.def       |   5 +
 target/s390x/translate_vx.inc.c  |  30 ++++++
 target/s390x/vec_string_helper.c | 154 +++++++++++++++++++++++++++++++
 5 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 target/s390x/vec_string_helper.c

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 0316457880d8..ffdd484ef05e 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,7 +1,7 @@
 obj-y +=3D cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helpe=
r.o
 obj-$(CONFIG_TCG) +=3D translate.o cc_helper.o excp_helper.o fpu_helper.=
o
 obj-$(CONFIG_TCG) +=3D int_helper.o mem_helper.o misc_helper.o crypto_he=
lper.o
-obj-$(CONFIG_TCG) +=3D vec_helper.o vec_int_helper.o
+obj-$(CONFIG_TCG) +=3D vec_helper.o vec_int_helper.o vec_string_helper.o
 obj-$(CONFIG_SOFTMMU) +=3D machine.o ioinst.o arch_dump.o mmu_helper.o d=
iag.o
 obj-$(CONFIG_SOFTMMU) +=3D sigp.o
 obj-$(CONFIG_KVM) +=3D kvm.o
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 7755a96c3371..c45328cf73c1 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -211,6 +211,14 @@ DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_4(gvec_vtm, void, ptr, cptr, env, i32)
=20
+/* =3D=3D=3D Vector String Instructions =3D=3D=3D */
+DEF_HELPER_FLAGS_4(gvec_vfae8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vfae16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vfae32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_5(gvec_vfae_cc8, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfae_cc16, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfae_cc32, void, ptr, cptr, cptr, env, i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
 DEF_HELPER_4(diag, void, env, i32, i32, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index e61475bdc483..070ce2a471e0 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1191,6 +1191,11 @@
 /* VECTOR TEST UNDER MASK */
     F(0xe7d8, VTM,     VRR_a, V,   0, 0, 0, 0, vtm, 0, IF_VEC)
=20
+/* =3D=3D=3D Vector String Instructions =3D=3D=3D */
+
+/* VECTOR FIND ANY ELEMENT EQUAL */
+    F(0xe782, VFAE,    VRR_b, V,   0, 0, 0, 0, vfae, 0, IF_VEC)
+
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL=
, IF_PRIV)
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 7e0bfcb1907c..ebd7a877f17d 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2353,3 +2353,33 @@ static DisasJumpType op_vtm(DisasContext *s, Disas=
Ops *o)
     set_cc_static(s);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfae(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    static gen_helper_gvec_3 * const g[3] =3D {
+        gen_helper_gvec_vfae8,
+        gen_helper_gvec_vfae16,
+        gen_helper_gvec_vfae32,
+    };
+    static gen_helper_gvec_3_ptr * const g_cc[3] =3D {
+        gen_helper_gvec_vfae_cc8,
+        gen_helper_gvec_vfae_cc16,
+        gen_helper_gvec_vfae_cc32,
+    };
+    if (es > ES_32) {
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
diff --git a/target/s390x/vec_string_helper.c b/target/s390x/vec_string_h=
elper.c
new file mode 100644
index 000000000000..56dc89c824de
--- /dev/null
+++ b/target/s390x/vec_string_helper.c
@@ -0,0 +1,154 @@
+/*
+ * QEMU TCG support -- s390x vector string instruction support
+ *
+ * Copyright (C) 2019 Red Hat Inc
+ *
+ * Authors:
+ *   David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "internal.h"
+#include "vec.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "exec/helper-proto.h"
+
+/*
+ * Returns a bit set in the MSB of each element that is zero,
+ * as defined by the mask.
+ */
+static inline uint64_t zero_search(uint64_t a, uint64_t mask)
+{
+    return ~(((a & mask) + mask) | a | mask);
+}
+
+/*
+ * Returns the byte offset for the first match, or 16 for no match.
+ */
+static inline int match_index(uint64_t c0, uint64_t c1)
+{
+    return (c0 ? clz64(c0) : clz64(c1) + 64) >> 3;
+}
+
+/*
+ * Returns the number of bits composing one element.
+ */
+static uint8_t get_element_bits(uint8_t es)
+{
+    return (1 << es) * BITS_PER_BYTE;
+}
+
+/*
+ * Returns the bitmask for a single element.
+ */
+static uint64_t get_single_element_mask(uint8_t es)
+{
+    return -1ull >> (64 - get_element_bits(es));
+}
+
+/*
+ * Returns the bitmask for a single element (excluding the MSB).
+ */
+static uint64_t get_single_element_lsbs_mask(uint8_t es)
+{
+    return -1ull >> (65 - get_element_bits(es));
+}
+
+/*
+ * Returns the bitmasks for multiple elements (excluding the MSBs).
+ */
+static uint64_t get_element_lsbs_mask(uint8_t es)
+{
+    return dup_const(es, get_single_element_lsbs_mask(es));
+}
+
+static int vfae(void *v1, const void *v2, const void *v3, bool in,
+                bool rt, bool zs, uint8_t es)
+{
+    const uint64_t mask =3D get_element_lsbs_mask(es);
+    const int bits =3D get_element_bits(es);
+    uint64_t a0, a1, b0, b1, e0, e1, t0, t1, z0, z1;
+    uint64_t first_zero =3D 16;
+    uint64_t first_equal;
+    int i;
+
+    a0 =3D s390_vec_read_element64(v2, 0);
+    a1 =3D s390_vec_read_element64(v2, 1);
+    b0 =3D s390_vec_read_element64(v3, 0);
+    b1 =3D s390_vec_read_element64(v3, 1);
+    e0 =3D 0;
+    e1 =3D 0;
+    /* compare against equality with every other element */
+    for (i =3D 0; i < 64; i +=3D bits) {
+        t0 =3D rol64(b0, i);
+        t1 =3D rol64(b1, i);
+        e0 |=3D zero_search(a0 ^ t0, mask);
+        e0 |=3D zero_search(a0 ^ t1, mask);
+        e1 |=3D zero_search(a1 ^ t0, mask);
+        e1 |=3D zero_search(a1 ^ t1, mask);
+    }
+    /* invert the result if requested - invert only the MSBs */
+    if (in) {
+        e0 =3D ~e0 & ~mask;
+        e1 =3D ~e1 & ~mask;
+    }
+    first_equal =3D match_index(e0, e1);
+
+    if (zs) {
+        z0 =3D zero_search(a0, mask);
+        z1 =3D zero_search(a1, mask);
+        first_zero =3D match_index(z0, z1);
+    }
+
+    if (rt) {
+        e0 =3D (e0 >> (bits - 1)) * get_single_element_mask(es);
+        e1 =3D (e1 >> (bits - 1)) * get_single_element_mask(es);
+        s390_vec_write_element64(v1, 0, e0);
+        s390_vec_write_element64(v1, 1, e1);
+    } else {
+        s390_vec_write_element64(v1, 0, MIN(first_equal, first_zero));
+        s390_vec_write_element64(v1, 1, 0);
+    }
+
+    if (first_zero =3D=3D 16 && first_equal =3D=3D 16) {
+        return 3; /* no match */
+    } else if (first_zero =3D=3D 16) {
+        return 1; /* matching elements, no match for zero */
+    } else if (first_equal < first_zero) {
+        return 2; /* matching elements before match for zero */
+    }
+    return 0; /* match for zero */
+}
+
+#define DEF_VFAE_HELPER(BITS)                                           =
       \
+void HELPER(gvec_vfae##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             uint32_t desc)                             =
       \
+{                                                                       =
       \
+    const bool in =3D extract32(simd_data(desc), 3, 1);                 =
         \
+    const bool rt =3D extract32(simd_data(desc), 2, 1);                 =
         \
+    const bool zs =3D extract32(simd_data(desc), 1, 1);                 =
         \
+                                                                        =
       \
+    vfae(v1, v2, v3, in, rt, zs, MO_##BITS);                            =
       \
+}
+DEF_VFAE_HELPER(8)
+DEF_VFAE_HELPER(16)
+DEF_VFAE_HELPER(32)
+
+#define DEF_VFAE_CC_HELPER(BITS)                                        =
       \
+void HELPER(gvec_vfae_cc##BITS)(void *v1, const void *v2, const void *v3=
,      \
+                                CPUS390XState *env, uint32_t desc)      =
       \
+{                                                                       =
       \
+    const bool in =3D extract32(simd_data(desc), 3, 1);                 =
         \
+    const bool rt =3D extract32(simd_data(desc), 2, 1);                 =
         \
+    const bool zs =3D extract32(simd_data(desc), 1, 1);                 =
         \
+                                                                        =
       \
+    env->cc_op =3D vfae(v1, v2, v3, in, rt, zs, MO_##BITS);             =
         \
+}
+DEF_VFAE_CC_HELPER(8)
+DEF_VFAE_CC_HELPER(16)
+DEF_VFAE_CC_HELPER(32)
--=20
2.20.1


