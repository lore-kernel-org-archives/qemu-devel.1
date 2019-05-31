Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D5C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EC6267AA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EC6267AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWf3l-0008GI-IQ
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 06:46:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1n-0006od-1r
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1l-0001LC-TM
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hWf1j-0001Ft-Vc
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57A8030821C0;
	Fri, 31 May 2019 10:44:45 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE32271AE;
	Fri, 31 May 2019 10:44:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 12:44:14 +0200
Message-Id: <20190531104432.29379-6-david@redhat.com>
In-Reply-To: <20190531104432.29379-1-david@redhat.com>
References: <20190531104432.29379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 31 May 2019 10:44:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 05/23] s390x/tcg: Implement VECTOR FP
 COMPARE (AND SIGNAL) SCALAR
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

As far as I can see, there is only a tiny difference.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 21 +++++++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 21658a2771..d34d6802a6 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -252,6 +252,8 @@ DEF_HELPER_6(gvec_vstrc_cc_rt32, void, ptr, cptr, cpt=
r, cptr, env, i32)
 /* =3D=3D=3D Vector Floating-Point Instructions */
 DEF_HELPER_FLAGS_5(gvec_vfa64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
 DEF_HELPER_FLAGS_5(gvec_vfa64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+DEF_HELPER_4(gvec_wfc64, void, cptr, cptr, env, i32)
+DEF_HELPER_4(gvec_wfk64, void, cptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 79892f6042..c45e101b10 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1208,6 +1208,10 @@
=20
 /* VECTOR FP ADD */
     F(0xe7e3, VFA,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
+/* VECTOR FP COMPARE SCALAR */
+    F(0xe7cb, WFC,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
+/* VECTOR FP COMPARE AND SIGNAL SCALAR */
+    F(0xe7ca, WFK,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 44da9f2645..283e8aa07a 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2567,3 +2567,24 @@ static DisasJumpType op_vfa(DisasContext *s, Disas=
Ops *o)
                    get_field(s->fields, v3), cpu_env, 0, fn);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_wfc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t fpf =3D get_field(s->fields, m3);
+    const uint8_t m4 =3D get_field(s->fields, m4);
+
+    if (fpf !=3D FPF_LONG || m4) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (s->fields->op2 =3D=3D 0xcb) {
+        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       cpu_env, 0, gen_helper_gvec_wfc64);
+    } else {
+        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       cpu_env, 0, gen_helper_gvec_wfk64);
+    }
+    set_cc_static(s);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 11dd20b837..3c153d8426 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -117,3 +117,35 @@ void HELPER(gvec_vfa64s)(void *v1, const void *v2, c=
onst void *v3,
 {
     vop64_3(v1, v2, v3, env, true, vfa64, GETPC());
 }
+
+static int wfc64(const S390Vector *v1, const S390Vector *v2,
+                 CPUS390XState *env, bool signal, uintptr_t retaddr)
+{
+    /* only the zero-indexed elements are compared */
+    const float64 a =3D make_float64(s390_vec_read_element64(v1, 0));
+    const float64 b =3D make_float64(s390_vec_read_element64(v2, 0));
+    uint8_t vxc, vec_exc =3D 0;
+    int cmp;
+
+    if (signal) {
+        cmp =3D float64_compare(a, b, &env->fpu_status);
+    } else {
+        cmp =3D float64_compare_quiet(a, b, &env->fpu_status);
+    }
+    vxc =3D check_ieee_exc(env, 0, false, &vec_exc);
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);
+
+    return float_comp_to_cc(env, cmp);
+}
+
+void HELPER(gvec_wfc64)(const void *v1, const void *v2, CPUS390XState *e=
nv,
+                        uint32_t desc)
+{
+    env->cc_op =3D wfc64(v1, v2, env, false, GETPC());
+}
+
+void HELPER(gvec_wfk64)(const void *v1, const void *v2, CPUS390XState *e=
nv,
+                        uint32_t desc)
+{
+    env->cc_op =3D wfc64(v1, v2, env, true, GETPC());
+}
--=20
2.20.1


