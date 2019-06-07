Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CEDC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D852083D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D852083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZG8S-00078q-29
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZFhV-0003oy-3T
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZFhS-0003pO-Bm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:18:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZFhS-0003h5-35; Fri, 07 Jun 2019 10:18:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7C972E95B1;
 Fri,  7 Jun 2019 14:18:28 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 392C260633;
 Fri,  7 Jun 2019 14:18:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 16:17:08 +0200
Message-Id: <20190607141727.29018-16-cohuck@redhat.com>
In-Reply-To: <20190607141727.29018-1-cohuck@redhat.com>
References: <20190607141727.29018-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 07 Jun 2019 14:18:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 15/34] s390x/tcg: Implement VECTOR FP COMPARE
 (EQUAL|HIGH|HIGH OR EQUAL)
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

Provide for all three instructions all four combinations of cc bit and
s bit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  12 ++++
 target/s390x/insn-data.def      |   6 ++
 target/s390x/translate_vx.inc.c |  51 ++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 104 ++++++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index d34d6802a605..33d3bacf746e 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -254,6 +254,18 @@ DEF_HELPER_FLAGS_5(gvec_vfa64, TCG_CALL_NO_WG, void,=
 ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfa64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
 DEF_HELPER_4(gvec_wfc64, void, cptr, cptr, env, i32)
 DEF_HELPER_4(gvec_wfk64, void, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfce64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+DEF_HELPER_FLAGS_5(gvec_vfce64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, =
env, i32)
+DEF_HELPER_5(gvec_vfce64_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfce64s_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfch64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+DEF_HELPER_FLAGS_5(gvec_vfch64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, =
env, i32)
+DEF_HELPER_5(gvec_vfch64_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfch64s_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfche64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, =
env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfche64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr,=
 env, i32)
+DEF_HELPER_5(gvec_vfche64_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfche64s_cc, void, ptr, cptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index c45e101b1056..446552f2510e 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1212,6 +1212,12 @@
     F(0xe7cb, WFC,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
 /* VECTOR FP COMPARE AND SIGNAL SCALAR */
     F(0xe7ca, WFK,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
+/* VECTOR FP COMPARE EQUAL */
+    F(0xe7e8, VFCE,    VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
+/* VECTOR FP COMPARE HIGH */
+    F(0xe7eb, VFCH,    VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
+/* VECTOR FP COMPARE HIGH OR EQUAL */
+    F(0xe7ea, VFCHE,   VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 283e8aa07ae4..5571a71e1a48 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2588,3 +2588,54 @@ static DisasJumpType op_wfc(DisasContext *s, Disas=
Ops *o)
     set_cc_static(s);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t fpf =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint8_t m6 =3D get_field(s->fields, m6);
+    const bool se =3D extract32(m5, 3, 1);
+    const bool cs =3D extract32(m6, 0, 1);
+    gen_helper_gvec_3_ptr *fn;
+
+    if (fpf !=3D FPF_LONG || extract32(m5, 0, 3) || extract32(m6, 1, 3))=
 {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (cs) {
+        switch (s->fields->op2) {
+        case 0xe8:
+            fn =3D se ? gen_helper_gvec_vfce64s_cc : gen_helper_gvec_vfc=
e64_cc;
+            break;
+        case 0xeb:
+            fn =3D se ? gen_helper_gvec_vfch64s_cc : gen_helper_gvec_vfc=
h64_cc;
+            break;
+        case 0xea:
+            fn =3D se ? gen_helper_gvec_vfche64s_cc : gen_helper_gvec_vf=
che64_cc;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        switch (s->fields->op2) {
+        case 0xe8:
+            fn =3D se ? gen_helper_gvec_vfce64s : gen_helper_gvec_vfce64=
;
+            break;
+        case 0xeb:
+            fn =3D se ? gen_helper_gvec_vfch64s : gen_helper_gvec_vfch64=
;
+            break;
+        case 0xea:
+            fn =3D se ? gen_helper_gvec_vfche64s : gen_helper_gvec_vfche=
64;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+                   get_field(s->fields, v3), cpu_env, 0, fn);
+    if (cs) {
+        set_cc_static(s);
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index f9357d922103..e72500d4d55e 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -149,3 +149,107 @@ void HELPER(gvec_wfk64)(const void *v1, const void =
*v2, CPUS390XState *env,
 {
     env->cc_op =3D wfc64(v1, v2, env, true, GETPC());
 }
+
+typedef int (*vfc64_fn)(float64 a, float64 b, float_status *status);
+static int vfc64(S390Vector *v1, const S390Vector *v2, const S390Vector =
*v3,
+                 CPUS390XState *env, bool s, vfc64_fn fn, uintptr_t reta=
ddr)
+{
+    uint8_t vxc, vec_exc =3D 0;
+    S390Vector tmp =3D {};
+    int match =3D 0;
+    int i;
+
+    for (i =3D 0; i < 2; i++) {
+        const float64 a =3D s390_vec_read_element64(v2, i);
+        const float64 b =3D s390_vec_read_element64(v3, i);
+
+        /* swap the order of the parameters, so we can use existing func=
tions */
+        if (fn(b, a, &env->fpu_status)) {
+            match++;
+            s390_vec_write_element64(&tmp, i, -1ull);
+        }
+        vxc =3D check_ieee_exc(env, i, false, &vec_exc);
+        if (s || vxc) {
+            break;
+        }
+    }
+
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);
+    *v1 =3D tmp;
+    if (match) {
+        return s || match =3D=3D 2 ? 0 : 1;
+    }
+    return 3;
+}
+
+void HELPER(gvec_vfce64)(void *v1, const void *v2, const void *v3,
+                         CPUS390XState *env, uint32_t desc)
+{
+    vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
+}
+
+void HELPER(gvec_vfce64s)(void *v1, const void *v2, const void *v3,
+                          CPUS390XState *env, uint32_t desc)
+{
+    vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
+}
+
+void HELPER(gvec_vfce64_cc)(void *v1, const void *v2, const void *v3,
+                            CPUS390XState *env, uint32_t desc)
+{
+    env->cc_op =3D vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC=
());
+}
+
+void HELPER(gvec_vfce64s_cc)(void *v1, const void *v2, const void *v3,
+                            CPUS390XState *env, uint32_t desc)
+{
+    env->cc_op =3D vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC(=
));
+}
+
+void HELPER(gvec_vfch64)(void *v1, const void *v2, const void *v3,
+                         CPUS390XState *env, uint32_t desc)
+{
+    vfc64(v1, v2, v3, env, false, float64_lt_quiet, GETPC());
+}
+
+void HELPER(gvec_vfch64s)(void *v1, const void *v2, const void *v3,
+                          CPUS390XState *env, uint32_t desc)
+{
+    vfc64(v1, v2, v3, env, true, float64_lt_quiet, GETPC());
+}
+
+void HELPER(gvec_vfch64_cc)(void *v1, const void *v2, const void *v3,
+                            CPUS390XState *env, uint32_t desc)
+{
+    env->cc_op =3D vfc64(v1, v2, v3, env, false, float64_lt_quiet, GETPC=
());
+}
+
+void HELPER(gvec_vfch64s_cc)(void *v1, const void *v2, const void *v3,
+                             CPUS390XState *env, uint32_t desc)
+{
+    env->cc_op =3D vfc64(v1, v2, v3, env, true, float64_lt_quiet, GETPC(=
));
+}
+
+void HELPER(gvec_vfche64)(void *v1, const void *v2, const void *v3,
+                          CPUS390XState *env, uint32_t desc)
+{
+    vfc64(v1, v2, v3, env, false, float64_le_quiet, GETPC());
+}
+
+void HELPER(gvec_vfche64s)(void *v1, const void *v2, const void *v3,
+                           CPUS390XState *env, uint32_t desc)
+{
+    vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC());
+}
+
+void HELPER(gvec_vfche64_cc)(void *v1, const void *v2, const void *v3,
+                             CPUS390XState *env, uint32_t desc)
+{
+    env->cc_op =3D vfc64(v1, v2, v3, env, false, float64_le_quiet, GETPC=
());
+}
+
+void HELPER(gvec_vfche64s_cc)(void *v1, const void *v2, const void *v3,
+                              CPUS390XState *env, uint32_t desc)
+{
+    env->cc_op =3D vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC(=
));
+}
--=20
2.20.1


