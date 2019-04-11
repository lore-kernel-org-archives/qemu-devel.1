Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B59C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B618C2184E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B618C2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46203 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXMm-0005al-VS
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:55:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsh-0003L1-Vi
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdU-00078C-LB
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:08:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWdU-00077t-Al; Thu, 11 Apr 2019 06:08:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AF9083F51;
	Thu, 11 Apr 2019 10:08:47 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14A7A1001E84;
	Thu, 11 Apr 2019 10:08:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:07:58 +0200
Message-Id: <20190411100836.646-4-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 11 Apr 2019 10:08:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411100758.O0JtYPbhTU8Dk7CB47MCnCu6SMxOZ_pr4xQiLimOrI8@z>

Only 64 bit handling is really easy. 128 bit handling is performed
via an ool handler, introducing s390_vec_add() that will be reused later.

8/16/32 bit handling is black magic inspired by gen_addv_mask(). If
there is every a bug detected in there, throw it away and simply use
ool helpers for 8/16 bit handling and something like 64 bit handling for
32 bit handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/Makefile.objs      |  2 +-
 target/s390x/helper.h           |  3 ++
 target/s390x/insn-data.def      |  2 +
 target/s390x/translate_vx.inc.c | 74 +++++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 47 +++++++++++++++++++++
 5 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 target/s390x/vec_int_helper.c

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 68eeee3d2f..993ac93ed6 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,7 +1,7 @@
 obj-y +=3D cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helpe=
r.o
 obj-$(CONFIG_TCG) +=3D translate.o cc_helper.o excp_helper.o fpu_helper.=
o
 obj-$(CONFIG_TCG) +=3D int_helper.o mem_helper.o misc_helper.o crypto_he=
lper.o
-obj-$(CONFIG_TCG) +=3D vec_helper.o
+obj-$(CONFIG_TCG) +=3D vec_helper.o vec_int_helper.o
 obj-$(CONFIG_SOFTMMU) +=3D machine.o ioinst.o arch_dump.o mmu_helper.o d=
iag.o
 obj-$(CONFIG_SOFTMMU) +=3D sigp.o
 obj-$(CONFIG_KVM) +=3D kvm.o
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 0b494a2fd2..2c1b223248 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -145,6 +145,9 @@ DEF_HELPER_5(gvec_vpkls_cc64, void, ptr, cptr, cptr, =
env, i32)
 DEF_HELPER_FLAGS_5(gvec_vperm, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, c=
ptr, i32)
 DEF_HELPER_FLAGS_4(vstl, TCG_CALL_NO_WG, void, env, cptr, i64, i64)
=20
+/* =3D=3D=3D Vector Integer Instructions =3D=3D=3D */
+DEF_HELPER_FLAGS_4(gvec_vacc128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
 DEF_HELPER_4(diag, void, env, i32, i32, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 74a0ccc770..f0e62b9aa8 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1058,6 +1058,8 @@
=20
 /* VECTOR ADD */
     F(0xe7f3, VA,      VRR_c, V,   0, 0, 0, 0, va, 0, IF_VEC)
+/* VECTOR ADD COMPUTE CARRY */
+    F(0xe7f1, VACC,    VRR_c, V,   0, 0, 0, 0, vacc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 2f84ea0511..c3bc47f1a9 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -136,6 +136,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
     tcg_temp_free_i64(tmp);
 }
=20
+#define gen_gvec_3(v1, v2, v3, gen) \
+    tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                   vec_full_reg_offset(v3), 16, 16, gen)
 #define gen_gvec_3_ool(v1, v2, v3, data, fn) \
     tcg_gen_gvec_3_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2),=
 \
                        vec_full_reg_offset(v3), 16, 16, data, fn)
@@ -985,3 +988,74 @@ static DisasJumpType op_va(DisasContext *s, DisasOps=
 *o)
                   get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static void gen_acc(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, uint8_t es)
+{
+    const uint8_t msb_bit_nr =3D NUM_VEC_ELEMENT_BITS(es) - 1;
+    TCGv_i64 msb_mask =3D tcg_const_i64(dup_const(es, 1ull << msb_bit_nr=
));
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    TCGv_i64 t3 =3D tcg_temp_new_i64();
+
+    /* Calculate the carry into the MSB, ignoring the old MSBs */
+    tcg_gen_andc_i64(t1, a, msb_mask);
+    tcg_gen_andc_i64(t2, b, msb_mask);
+    tcg_gen_add_i64(t1, t1, t2);
+    /* Calculate the MSB without any carry into it */
+    tcg_gen_xor_i64(t3, a, b);
+    /* Calculate the carry out of the MSB in the MSB bit position */
+    tcg_gen_and_i64(d, a, b);
+    tcg_gen_and_i64(t1, t1, t3);
+    tcg_gen_or_i64(d, d, t1);
+    /* Isolate and shift the carry into position */
+    tcg_gen_and_i64(d, d, msb_mask);
+    tcg_gen_shri_i64(d, d, msb_bit_nr);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
+}
+
+static void gen_acc8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_8);
+}
+
+static void gen_acc16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_16);
+}
+
+static void gen_acc32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_32);
+}
+
+static void gen_acc_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t =3D tcg_temp_new_i64();
+
+    tcg_gen_add_i64(t, a, b);
+    tcg_gen_setcond_i64(TCG_COND_LTU, d, t, b);
+    tcg_temp_free_i64(t);
+}
+
+static DisasJumpType op_vacc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[5] =3D {
+        { .fni8 =3D gen_acc8_i64, },
+        { .fni8 =3D gen_acc16_i64, },
+        { .fni8 =3D gen_acc32_i64, },
+        { .fni8 =3D gen_acc_i64, },
+        { .fno =3D gen_helper_gvec_vacc128, },
+    };
+
+    if (es > ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
new file mode 100644
index 0000000000..0b232571bc
--- /dev/null
+++ b/target/s390x/vec_int_helper.c
@@ -0,0 +1,47 @@
+/*
+ * QEMU TCG support -- s390x vector integer instruction support
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
+#include "vec.h"
+#include "exec/helper-proto.h"
+
+/*
+ * Add two 128 bit vectors, returning the carry.
+ */
+static bool s390_vec_add(S390Vector *d, const S390Vector *a,
+                         const S390Vector *b)
+{
+    bool low_carry =3D false, high_carry =3D false;
+
+    if (a->doubleword[0] + b->doubleword[0] < a->doubleword[0]) {
+        high_carry =3D true;
+    }
+    if (a->doubleword[1] + b->doubleword[1] < a->doubleword[1]) {
+        low_carry =3D true;
+        if (a->doubleword[0] =3D=3D b->doubleword[0]) {
+            high_carry =3D true;
+        }
+    }
+    d->doubleword[0] =3D a->doubleword[0] + b->doubleword[0] + low_carry=
;
+    d->doubleword[1] =3D a->doubleword[1] + b->doubleword[1];
+    return high_carry;
+}
+
+void HELPER(gvec_vacc128)(void *v1, const void *v2, const void *v3,
+                          uint32_t desc)
+{
+    S390Vector tmp, *dst =3D v1;
+
+    dst->doubleword[0] =3D 0;
+    dst->doubleword[1] =3D s390_vec_add(&tmp, v2, v3);
+}
--=20
2.20.1


