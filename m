Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E571C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6547720B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6547720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48190 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCML-0008Fg-N2
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZBZ8-0002jI-EZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZBZ6-0001v0-2j
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZBZ2-0001lU-AN; Fri, 07 Jun 2019 05:53:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3218F30862BE;
 Fri,  7 Jun 2019 09:53:34 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7E845BBC8;
 Fri,  7 Jun 2019 09:53:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 11:52:19 +0200
Message-Id: <20190607095237.11364-18-cohuck@redhat.com>
In-Reply-To: <20190607095237.11364-1-cohuck@redhat.com>
References: <20190607095237.11364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 07 Jun 2019 09:53:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/35] s390x/tcg: Implement VECTOR FP CONVERT
 FROM FIXED 64-BIT
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

1. We'll reuse op_vcdg() for similar instructions later, prepare for
   that.
2. We'll reuse vop64_2() later for other instructions.

We have to mangle the erm (effective rounding mode) and the m4 into
the simd_data(), and properly unmangle them again.

Make sure to restore the erm before triggering an exception.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 25 ++++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 47 +++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 33d3bacf746e..a60f4c49fcf5 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -266,6 +266,8 @@ DEF_HELPER_FLAGS_5(gvec_vfche64, TCG_CALL_NO_WG, void=
, ptr, cptr, cptr, env, i32
 DEF_HELPER_FLAGS_5(gvec_vfche64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr,=
 env, i32)
 DEF_HELPER_5(gvec_vfche64_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfche64s_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vcdg64, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
+DEF_HELPER_FLAGS_4(gvec_vcdg64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 446552f2510e..d3386024c8f0 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1218,6 +1218,8 @@
     F(0xe7eb, VFCH,    VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
 /* VECTOR FP COMPARE HIGH OR EQUAL */
     F(0xe7ea, VFCHE,   VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
+/* VECTOR FP CONVERT FROM FIXED 64-BIT */
+    F(0xe7c3, VCDG,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 5571a71e1a48..6741b707ccc4 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2639,3 +2639,28 @@ static DisasJumpType op_vfc(DisasContext *s, Disas=
Ops *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vcdg(DisasContext *s, DisasOps *o)
+{
+    const uint8_t fpf =3D get_field(s->fields, m3);
+    const uint8_t m4 =3D get_field(s->fields, m4);
+    const uint8_t erm =3D get_field(s->fields, m5);
+    const bool se =3D extract32(m4, 3, 1);
+    gen_helper_gvec_2_ptr *fn;
+
+    if (fpf !=3D FPF_LONG || extract32(m4, 0, 2) || erm > 7 || erm =3D=3D=
 2) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0xc3:
+        fn =3D se ? gen_helper_gvec_vcdg64s : gen_helper_gvec_vcdg64;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), c=
pu_env,
+                   deposit32(m4, 4, 4, erm), fn);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index e72500d4d55e..53430c784375 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -78,6 +78,30 @@ static void handle_ieee_exc(CPUS390XState *env, uint8_=
t vxc, uint8_t vec_exc,
     }
 }
=20
+typedef uint64_t (*vop64_2_fn)(uint64_t a, float_status *s);
+static void vop64_2(S390Vector *v1, const S390Vector *v2, CPUS390XState =
*env,
+                    bool s, bool XxC, uint8_t erm, vop64_2_fn fn,
+                    uintptr_t retaddr)
+{
+    uint8_t vxc, vec_exc =3D 0;
+    S390Vector tmp =3D {};
+    int i, old_mode;
+
+    old_mode =3D s390_swap_bfp_rounding_mode(env, erm);
+    for (i =3D 0; i < 2; i++) {
+        const uint64_t a =3D s390_vec_read_element64(v2, i);
+
+        s390_vec_write_element64(&tmp, i, fn(a, &env->fpu_status));
+        vxc =3D check_ieee_exc(env, i, XxC, &vec_exc);
+        if (s || vxc) {
+            break;
+        }
+    }
+    s390_restore_bfp_rounding_mode(env, old_mode);
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);
+    *v1 =3D tmp;
+}
+
 typedef uint64_t (*vop64_3_fn)(uint64_t a, uint64_t b, float_status *s);
 static void vop64_3(S390Vector *v1, const S390Vector *v2, const S390Vect=
or *v3,
                     CPUS390XState *env, bool s, vop64_3_fn fn,
@@ -253,3 +277,26 @@ void HELPER(gvec_vfche64s_cc)(void *v1, const void *=
v2, const void *v3,
 {
     env->cc_op =3D vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC(=
));
 }
+
+static uint64_t vcdg64(uint64_t a, float_status *s)
+{
+    return int64_to_float64(a, s);
+}
+
+void HELPER(gvec_vcdg64)(void *v1, const void *v2, CPUS390XState *env,
+                         uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, false, XxC, erm, vcdg64, GETPC());
+}
+
+void HELPER(gvec_vcdg64s)(void *v1, const void *v2, CPUS390XState *env,
+                          uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, true, XxC, erm, vcdg64, GETPC());
+}
--=20
2.20.1


