Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4ADC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731F0267BF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731F0267BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWfA7-0005Eg-Jl
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 06:53:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1o-0006qJ-25
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1l-0001L6-Si
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hWf1j-0001Dg-UE
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F376B302451A;
	Fri, 31 May 2019 10:44:43 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7DCC473DB;
	Fri, 31 May 2019 10:44:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 12:44:13 +0200
Message-Id: <20190531104432.29379-5-david@redhat.com>
In-Reply-To: <20190531104432.29379-1-david@redhat.com>
References: <20190531104432.29379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 31 May 2019 10:44:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 04/23] s390x/tcg: Implement VECTOR FP ADD
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

1. We'll reuse op_vfa() for similar instructions later, prepare for
   that.
2. We'll reuse vop64_3() for other instructions later.
3. Take care of modifying the vector register only if no trap happened.
 - on traps, flags are not updated and no elements are modified
 - traps don't modify the fpc flags
 - without traps, all exceptions of all elements are merged
4. We'll reuse check_ieee_exc() later when we need the XxC flag.

We have to check for exceptions after processing each element.
Provide separate handlers for single/all element processing. We'll do
the same for all applicable FP instructions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/Makefile.objs      |   1 +
 target/s390x/helper.h           |   4 ++
 target/s390x/insn-data.def      |   5 ++
 target/s390x/translate_vx.inc.c |  29 ++++++++
 target/s390x/vec_fpu_helper.c   | 119 ++++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+)
 create mode 100644 target/s390x/vec_fpu_helper.c

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index ffdd484ef0..3e2745594a 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -2,6 +2,7 @@ obj-y +=3D cpu.o cpu_models.o cpu_features.o gdbstub.o in=
terrupt.o helper.o
 obj-$(CONFIG_TCG) +=3D translate.o cc_helper.o excp_helper.o fpu_helper.=
o
 obj-$(CONFIG_TCG) +=3D int_helper.o mem_helper.o misc_helper.o crypto_he=
lper.o
 obj-$(CONFIG_TCG) +=3D vec_helper.o vec_int_helper.o vec_string_helper.o
+obj-$(CONFIG_TCG) +=3D vec_fpu_helper.o
 obj-$(CONFIG_SOFTMMU) +=3D machine.o ioinst.o arch_dump.o mmu_helper.o d=
iag.o
 obj-$(CONFIG_SOFTMMU) +=3D sigp.o
 obj-$(CONFIG_KVM) +=3D kvm.o
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 5db67779d3..21658a2771 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -249,6 +249,10 @@ DEF_HELPER_6(gvec_vstrc_cc_rt8, void, ptr, cptr, cpt=
r, cptr, env, i32)
 DEF_HELPER_6(gvec_vstrc_cc_rt16, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_6(gvec_vstrc_cc_rt32, void, ptr, cptr, cptr, cptr, env, i32)
=20
+/* =3D=3D=3D Vector Floating-Point Instructions */
+DEF_HELPER_FLAGS_5(gvec_vfa64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
+DEF_HELPER_FLAGS_5(gvec_vfa64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
 DEF_HELPER_4(diag, void, env, i32, i32, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a2969fab58..79892f6042 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1204,6 +1204,11 @@
 /* VECTOR STRING RANGE COMPARE */
     F(0xe78a, VSTRC,   VRR_d, V,   0, 0, 0, 0, vstrc, 0, IF_VEC)
=20
+/* =3D=3D=3D Vector Floating-Point Instructions */
+
+/* VECTOR FP ADD */
+    F(0xe7e3, VFA,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
+
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL=
, IF_PRIV)
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index f26ffa2895..44da9f2645 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -52,6 +52,11 @@
 #define ES_64   MO_64
 #define ES_128  4
=20
+/* Floating-Point Format */
+#define FPF_SHORT       2
+#define FPF_LONG        3
+#define FPF_EXT         4
+
 static inline bool valid_vec_element(uint8_t enr, TCGMemOp es)
 {
     return !(enr & ~(NUM_VEC_ELEMENTS(es) - 1));
@@ -2538,3 +2543,27 @@ static DisasJumpType op_vstrc(DisasContext *s, Dis=
asOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfa(DisasContext *s, DisasOps *o)
+{
+    const uint8_t fpf =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    const bool se =3D extract32(m5, 3, 1);
+    gen_helper_gvec_3_ptr *fn;
+
+    if (fpf !=3D FPF_LONG || extract32(m5, 0, 3)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0xe3:
+        fn =3D se ? gen_helper_gvec_vfa64s : gen_helper_gvec_vfa64;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+                   get_field(s->fields, v3), cpu_env, 0, fn);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
new file mode 100644
index 0000000000..11dd20b837
--- /dev/null
+++ b/target/s390x/vec_fpu_helper.c
@@ -0,0 +1,119 @@
+/*
+ * QEMU TCG support -- s390x vector floating point instruction support
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
+#include "tcg_s390x.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
+
+#define VIC_INVALID         0x1
+#define VIC_DIVBYZERO       0x2
+#define VIC_OVERFLOW        0x3
+#define VIC_UNDERFLOW       0x4
+#define VIC_INEXACT         0x5
+
+/* returns the VEX. If the VEX is 0, there is no trap */
+static uint8_t check_ieee_exc(CPUS390XState *env, uint8_t enr, bool XxC,
+                              uint8_t *vec_exc)
+{
+    uint8_t vece_exc =3D 0, trap_exc;
+    unsigned qemu_exc;
+
+    /* Retrieve and clear the softfloat exceptions */
+    qemu_exc =3D env->fpu_status.float_exception_flags;
+    if (qemu_exc =3D=3D 0) {
+        return 0;
+    }
+    env->fpu_status.float_exception_flags =3D 0;
+
+    vece_exc =3D s390_softfloat_exc_to_ieee(qemu_exc);
+
+    /* Add them to the vector-wide s390x exception bits */
+    *vec_exc |=3D vece_exc;
+
+    /* Check for traps and construct the VXC */
+    trap_exc =3D vece_exc & env->fpc >> 24;
+    if (trap_exc) {
+        if (trap_exc & S390_IEEE_MASK_INVALID) {
+            return enr << 4 | VIC_INVALID;
+        } else if (trap_exc & S390_IEEE_MASK_DIVBYZERO) {
+            return enr << 4 | VIC_DIVBYZERO;
+        } else if (trap_exc & S390_IEEE_MASK_OVERFLOW) {
+            return enr << 4 | VIC_OVERFLOW;
+        } else if (trap_exc & S390_IEEE_MASK_UNDERFLOW) {
+            return enr << 4 | VIC_UNDERFLOW;
+        } else if (!XxC) {
+            g_assert(trap_exc & S390_IEEE_MASK_INEXACT);
+            /* inexact has lowest priority on traps */
+            return enr << 4 | VIC_INEXACT;
+        }
+    }
+    return 0;
+}
+
+static void handle_ieee_exc(CPUS390XState *env, uint8_t vxc, uint8_t vec=
_exc,
+                            uintptr_t retaddr)
+{
+    if (vxc) {
+        /* on traps, the fpc flags are not updated, instruction is suppr=
essed */
+        tcg_s390_vector_exception(env, vxc, retaddr);
+    }
+    if (vec_exc) {
+        /* indicate exceptions for all elements combined */
+        env->fpc |=3D vec_exc << 16;
+    }
+}
+
+typedef uint64_t (*vop64_3_fn)(uint64_t a, uint64_t b, float_status *s);
+static void vop64_3(S390Vector *v1, const S390Vector *v2, const S390Vect=
or *v3,
+                    CPUS390XState *env, bool s, vop64_3_fn fn,
+                    uintptr_t retaddr)
+{
+    uint8_t vxc, vec_exc =3D 0;
+    S390Vector tmp =3D {};
+    int i;
+
+    for (i =3D 0; i < 2; i++) {
+        const uint64_t a =3D s390_vec_read_element64(v2, i);
+        const uint64_t b =3D s390_vec_read_element64(v3, i);
+
+        s390_vec_write_element64(&tmp, i, fn(a, b, &env->fpu_status));
+        vxc =3D check_ieee_exc(env, i, false, &vec_exc);
+        if (s || vxc) {
+            break;
+        }
+    }
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);
+    *v1 =3D tmp;
+}
+
+static uint64_t vfa64(uint64_t a, uint64_t b, float_status *s)
+{
+    return float64_val(float64_add(make_float64(a), make_float64(b), s))=
;
+}
+
+void HELPER(gvec_vfa64)(void *v1, const void *v2, const void *v3,
+                        CPUS390XState *env, uint32_t desc)
+{
+    vop64_3(v1, v2, v3, env, false, vfa64, GETPC());
+}
+
+void HELPER(gvec_vfa64s)(void *v1, const void *v2, const void *v3,
+                         CPUS390XState *env, uint32_t desc)
+{
+    vop64_3(v1, v2, v3, env, true, vfa64, GETPC());
+}
--=20
2.20.1


