Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A47C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701192070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701192070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0aG-0006h4-Av
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:33:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yf-0005oF-Np
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yd-0002By-OC
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hR0Yb-0002AH-QU; Wed, 15 May 2019 16:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96EC030B32DD;
	Wed, 15 May 2019 20:31:19 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1D5D66266C;
	Wed, 15 May 2019 20:31:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:31:08 +0200
Message-Id: <20190515203112.506-2-david@redhat.com>
In-Reply-To: <20190515203112.506-1-david@redhat.com>
References: <20190515203112.506-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 15 May 2019 20:31:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 1/5] s390x/tcg: Implement VECTOR FIND ANY
 ELEMENT EQUAL
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

Complicated stuff. Provide two variants, one for the CC and one without
the CC. The CC is returned via cpu_env.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/Makefile.objs       |  2 +-
 target/s390x/helper.h            |  8 +++
 target/s390x/insn-data.def       |  5 ++
 target/s390x/translate_vx.inc.c  | 31 ++++++++++
 target/s390x/vec_string_helper.c | 97 ++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 target/s390x/vec_string_helper.c

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 993ac93ed6..0a38281a14 100644
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
index 7755a96c33..c45328cf73 100644
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
index e61475bdc4..070ce2a471 100644
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
index 7e0bfcb190..022990dda3 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2353,3 +2353,34 @@ static DisasJumpType op_vtm(DisasContext *s, Disas=
Ops *o)
     set_cc_static(s);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfae(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    static gen_helper_gvec_3_ptr * const cc[3] =3D {
+        gen_helper_gvec_vfae_cc8,
+        gen_helper_gvec_vfae_cc16,
+        gen_helper_gvec_vfae_cc32,
+    };
+    static gen_helper_gvec_3 * const nocc[3] =3D {
+        gen_helper_gvec_vfae8,
+        gen_helper_gvec_vfae16,
+        gen_helper_gvec_vfae32,
+    };
+
+    if (es > ES_32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (m5 & 1) {
+        gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       get_field(s->fields, v3), cpu_env, m5, cc[es]);
+        set_cc_static(s);
+    } else {
+        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       get_field(s->fields, v3), m5, nocc[es]);
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_string_helper.c b/target/s390x/vec_string_h=
elper.c
new file mode 100644
index 0000000000..8a4e65b70f
--- /dev/null
+++ b/target/s390x/vec_string_helper.c
@@ -0,0 +1,97 @@
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
+#include "tcg/tcg-gvec-desc.h"
+#include "exec/helper-proto.h"
+
+#define DEF_VFAE(BITS)                                                  =
       \
+static int vfae##BITS(void *v1, const void *v2, const void *v3, uint8_t =
m5)    \
+{                                                                       =
       \
+    const bool in =3D extract32(m5, 3, 1);                              =
         \
+    const bool rt =3D extract32(m5, 2, 1);                              =
         \
+    const bool zs =3D extract32(m5, 1, 1);                              =
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
+        bool any_equal =3D false;                                       =
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
+        /* try to match with any other element from the other vector */ =
       \
+        for (j =3D 0; j < (128 / BITS); j++) {                          =
         \
+            if (data =3D=3D s390_vec_read_element##BITS(v3, j)) {       =
           \
+                any_equal =3D true;                                     =
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
+        any_equal =3D in ^ any_equal;                                   =
         \
+        if (cc =3D=3D 3 && any_equal) {                                 =
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
+        if (rt && any_equal) {                                          =
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
+DEF_VFAE(8)
+DEF_VFAE(16)
+DEF_VFAE(32)
+
+#define DEF_VFAE_HELPER(BITS)                                           =
       \
+void HELPER(gvec_vfae##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             uint32_t desc)                             =
       \
+{                                                                       =
       \
+    vfae##BITS(v1, v2, v3, simd_data(desc));                            =
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
+    env->cc_op =3D vfae##BITS(v1, v2, v3, simd_data(desc));             =
         \
+}
+DEF_VFAE_CC_HELPER(8)
+DEF_VFAE_CC_HELPER(16)
+DEF_VFAE_CC_HELPER(32)
--=20
2.20.1


