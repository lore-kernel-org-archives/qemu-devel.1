Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3452FC468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110A320840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110A320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZGRT-0005gV-RT
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53671)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZFiE-0004cY-OO
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZFiD-0004s3-30
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZFiC-0004X5-RM; Fri, 07 Jun 2019 10:19:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD11E2E95B0;
 Fri,  7 Jun 2019 14:19:08 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 786727FD0B;
 Fri,  7 Jun 2019 14:19:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 16:17:18 +0200
Message-Id: <20190607141727.29018-26-cohuck@redhat.com>
In-Reply-To: <20190607141727.29018-1-cohuck@redhat.com>
References: <20190607141727.29018-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 07 Jun 2019 14:19:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 25/34] s390x/tcg: Implement VECTOR FP
 MULTIPLY AND (ADD|SUBTRACT)
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  4 +++
 target/s390x/insn-data.def      |  4 +++
 target/s390x/translate_vx.inc.c | 23 ++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 48 +++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 22e02a01784c..bcaabb91a510 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -284,6 +284,10 @@ DEF_HELPER_FLAGS_4(gvec_vflr64, TCG_CALL_NO_WG, void=
, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vflr64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
 DEF_HELPER_FLAGS_5(gvec_vfm64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+DEF_HELPER_FLAGS_6(gvec_vfma64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, c=
ptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfma64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, =
cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfms64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, c=
ptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfms64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, =
cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index e56059ac345f..e86ade9e443e 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1236,6 +1236,10 @@
     F(0xe7c5, VFLR,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
 /* VECTOR FP MULTIPLY */
     F(0xe7e7, VFM,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
+/* VECTOR FP MULTIPLY AND ADD */
+    F(0xe78f, VFMA,    VRR_e, V,   0, 0, 0, 0, vfma, 0, IF_VEC)
+/* VECTOR FP MULTIPLY AND SUBTRACT */
+    F(0xe78e, VFMS,    VRR_e, V,   0, 0, 0, 0, vfma, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index ae31a327cf8e..b624c7a8aa6b 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2704,3 +2704,26 @@ static DisasJumpType op_vfll(DisasContext *s, Disa=
sOps *o)
                    0, fn);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfma(DisasContext *s, DisasOps *o)
+{
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint8_t fpf =3D get_field(s->fields, m6);
+    const bool se =3D extract32(m5, 3, 1);
+    gen_helper_gvec_4_ptr *fn;
+
+    if (fpf !=3D FPF_LONG || extract32(m5, 0, 3)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (s->fields->op2 =3D=3D 0x8f) {
+        fn =3D se ? gen_helper_gvec_vfma64s : gen_helper_gvec_vfma64;
+    } else {
+        fn =3D se ? gen_helper_gvec_vfms64s : gen_helper_gvec_vfms64;
+    }
+    gen_gvec_4_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+                   get_field(s->fields, v3), get_field(s->fields, v4), c=
pu_env,
+                   0, fn);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 57b7fe4affce..7993a6fafa41 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -504,3 +504,51 @@ void HELPER(gvec_vfm64s)(void *v1, const void *v2, c=
onst void *v3,
 {
     vop64_3(v1, v2, v3, env, true, vfm64, GETPC());
 }
+
+static void vfma64(S390Vector *v1, const S390Vector *v2, const S390Vecto=
r *v3,
+                   const S390Vector *v4, CPUS390XState *env, bool s, int=
 flags,
+                   uintptr_t retaddr)
+{
+    uint8_t vxc, vec_exc =3D 0;
+    S390Vector tmp =3D {};
+    int i;
+
+    for (i =3D 0; i < 2; i++) {
+        const uint64_t a =3D s390_vec_read_element64(v2, i);
+        const uint64_t b =3D s390_vec_read_element64(v3, i);
+        const uint64_t c =3D s390_vec_read_element64(v4, i);
+        uint64_t ret =3D float64_muladd(a, b, c, flags, &env->fpu_status=
);
+
+        s390_vec_write_element64(&tmp, i, ret);
+        vxc =3D check_ieee_exc(env, i, false, &vec_exc);
+        if (s || vxc) {
+            break;
+        }
+    }
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);
+    *v1 =3D tmp;
+}
+
+void HELPER(gvec_vfma64)(void *v1, const void *v2, const void *v3,
+                         const void *v4, CPUS390XState *env, uint32_t de=
sc)
+{
+    vfma64(v1, v2, v3, v4, env, false, 0, GETPC());
+}
+
+void HELPER(gvec_vfma64s)(void *v1, const void *v2, const void *v3,
+                         const void *v4, CPUS390XState *env, uint32_t de=
sc)
+{
+    vfma64(v1, v2, v3, v4, env, true, 0, GETPC());
+}
+
+void HELPER(gvec_vfms64)(void *v1, const void *v2, const void *v3,
+                         const void *v4, CPUS390XState *env, uint32_t de=
sc)
+{
+    vfma64(v1, v2, v3, v4, env, false, float_muladd_negate_c, GETPC());
+}
+
+void HELPER(gvec_vfms64s)(void *v1, const void *v2, const void *v3,
+                         const void *v4, CPUS390XState *env, uint32_t de=
sc)
+{
+    vfma64(v1, v2, v3, v4, env, true, float_muladd_negate_c, GETPC());
+}
--=20
2.20.1


