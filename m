Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0F7C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CDB267ED
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CDB267ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41057 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWfJH-0004vb-20
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 07:02:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf2W-0007gQ-5o
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf2U-0002OD-83
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hWf2Q-0001xv-8E
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:45:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1590081F0C;
	Fri, 31 May 2019 10:45:17 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 07453473BC;
	Fri, 31 May 2019 10:45:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 12:44:29 +0200
Message-Id: <20190531104432.29379-21-david@redhat.com>
In-Reply-To: <20190531104432.29379-1-david@redhat.com>
References: <20190531104432.29379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 31 May 2019 10:45:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 20/23] s390x/tcg: Implement VECTOR FP TEST
 DATA CLASS IMMEDIATE
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

We can reuse float64_dcmask().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 21 ++++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 39 +++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index c788fc1b7f..e9aff83b05 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -292,6 +292,8 @@ DEF_HELPER_FLAGS_4(gvec_vfsq64, TCG_CALL_NO_WG, void,=
 ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
 DEF_HELPER_FLAGS_5(gvec_vfs64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
 DEF_HELPER_FLAGS_5(gvec_vfs64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+DEF_HELPER_4(gvec_vftci64, void, ptr, cptr, env, i32)
+DEF_HELPER_4(gvec_vftci64s, void, ptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 4426f40250..f421184fcd 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1246,6 +1246,8 @@
     F(0xe7ce, VFSQ,    VRR_a, V,   0, 0, 0, 0, vfsq, 0, IF_VEC)
 /* VECTOR FP SUBTRACT */
     F(0xe7e2, VFS,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
+/* VECTOR FP TEST DATA CLASS IMMEDIATE */
+    F(0xe74a, VFTCI,   VRI_e, V,   0, 0, 0, 0, vftci, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index bc75a147b6..715fcb2cb5 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2791,3 +2791,24 @@ static DisasJumpType op_vfsq(DisasContext *s, Disa=
sOps *o)
                    0, fn);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vftci(DisasContext *s, DisasOps *o)
+{
+    const uint16_t i3 =3D get_field(s->fields, i3);
+    const uint8_t fpf =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    gen_helper_gvec_2_ptr *fn =3D gen_helper_gvec_vftci64;
+
+    if (fpf !=3D FPF_LONG || extract32(m5, 0, 3)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (extract32(m5, 3, 1)) {
+        fn =3D gen_helper_gvec_vftci64s;
+    }
+    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), c=
pu_env,
+                   i3, fn);
+    set_cc_static(s);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 10249c5105..930b6d1db4 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -603,3 +603,42 @@ void HELPER(gvec_vfs64s)(void *v1, const void *v2, c=
onst void *v3,
 {
     vop64_3(v1, v2, v3, env, true, vfs64, GETPC());
 }
+
+static int vftci64(S390Vector *v1, const S390Vector *v2, CPUS390XState *=
env,
+                   bool s, uint16_t i3)
+{
+    int i, match =3D 0;
+
+    for (i =3D 0; i < 2; i++) {
+        float64 a =3D make_float64(s390_vec_read_element64(v2, i));
+
+        if (float64_dcmask(env, a) & i3) {
+            match++;
+            s390_vec_write_element64(v1, i, -1ull);
+        } else {
+            s390_vec_write_element64(v1, i, 0);
+        }
+        if (s) {
+            break;
+        }
+    }
+
+    if (match =3D=3D i + 1) {
+        return 0;
+    } else if (match) {
+        return 1;
+    }
+    return 3;
+}
+
+void HELPER(gvec_vftci64)(void *v1, const void *v2, CPUS390XState *env,
+                          uint32_t desc)
+{
+    env->cc_op =3D vftci64(v1, v2, env, false, simd_data(desc));
+}
+
+void HELPER(gvec_vftci64s)(void *v1, const void *v2, CPUS390XState *env,
+                           uint32_t desc)
+{
+    env->cc_op =3D vftci64(v1, v2, env, true, simd_data(desc));
+}
--=20
2.20.1


