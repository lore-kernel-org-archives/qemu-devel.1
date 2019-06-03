Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18948C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D4D21923
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D4D21923
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXj1S-0001HD-MB
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:12:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXiwC-0004qk-7R
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXiwA-00038j-PT
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:07:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hXiwA-00037c-ID; Mon, 03 Jun 2019 05:07:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3B3746202;
	Mon,  3 Jun 2019 09:07:25 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.117.0])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 070D260C7F;
	Mon,  3 Jun 2019 09:07:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:06:29 +0200
Message-Id: <20190603090635.10631-17-david@redhat.com>
In-Reply-To: <20190603090635.10631-1-david@redhat.com>
References: <20190603090635.10631-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 03 Jun 2019 09:07:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 16/22] s390x/tcg: Implement VECTOR FP
 MULTIPLY AND (ADD|SUBTRACT)
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
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  4 +++
 target/s390x/insn-data.def      |  4 +++
 target/s390x/translate_vx.inc.c | 23 ++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 48 +++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 22e02a0178..bcaabb91a5 100644
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
index e56059ac34..e86ade9e44 100644
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
index ae31a327cf..b624c7a8aa 100644
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
index 57b7fe4aff..7993a6fafa 100644
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
2.21.0


