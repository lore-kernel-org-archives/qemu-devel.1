Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88E7C468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59C621530
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59C621530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZGzj-0002qv-OT
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZFiG-0004hl-CS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZFiE-0004w7-Sl
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZFiE-0004u3-IN; Fri, 07 Jun 2019 10:19:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFB2E30C250E;
 Fri,  7 Jun 2019 14:19:21 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B43A7FE9A;
 Fri,  7 Jun 2019 14:19:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 16:17:20 +0200
Message-Id: <20190607141727.29018-28-cohuck@redhat.com>
In-Reply-To: <20190607141727.29018-1-cohuck@redhat.com>
References: <20190607141727.29018-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 14:19:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 27/34] s390x/tcg: Implement VECTOR FP SQUARE
 ROOT
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

Simulate XxC=3D0 and ERM=3D0 (current mode), so we can use the existing
helper function.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 19 +++++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 17 +++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index bcaabb91a510..23b37af1e492 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -288,6 +288,8 @@ DEF_HELPER_FLAGS_6(gvec_vfma64, TCG_CALL_NO_WG, void,=
 ptr, cptr, cptr, cptr, env
 DEF_HELPER_FLAGS_6(gvec_vfma64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, =
cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, c=
ptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, =
cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfsq64, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
+DEF_HELPER_FLAGS_4(gvec_vfsq64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index fa2e8017470e..354252d57cc0 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1242,6 +1242,8 @@
     F(0xe78e, VFMS,    VRR_e, V,   0, 0, 0, 0, vfma, 0, IF_VEC)
 /* VECTOR FP PERFORM SIGN OPERATION */
     F(0xe7cc, VFPSO,   VRR_a, V,   0, 0, 0, 0, vfpso, 0, IF_VEC)
+/* VECTOR FP SQUARE ROOT */
+    F(0xe7ce, VFSQ,    VRR_a, V,   0, 0, 0, 0, vfsq, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 9b8606ba252c..75f3596c4baa 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2779,3 +2779,22 @@ static DisasJumpType op_vfpso(DisasContext *s, Dis=
asOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfsq(DisasContext *s, DisasOps *o)
+{
+    const uint8_t fpf =3D get_field(s->fields, m3);
+    const uint8_t m4 =3D get_field(s->fields, m4);
+    gen_helper_gvec_2_ptr *fn =3D gen_helper_gvec_vfsq64;
+
+    if (fpf !=3D FPF_LONG || extract32(m4, 0, 3)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (extract32(m4, 3, 1)) {
+        fn =3D gen_helper_gvec_vfsq64s;
+    }
+    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), c=
pu_env,
+                   0, fn);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 7993a6fafa41..18773eb559d4 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -552,3 +552,20 @@ void HELPER(gvec_vfms64s)(void *v1, const void *v2, =
const void *v3,
 {
     vfma64(v1, v2, v3, v4, env, true, float_muladd_negate_c, GETPC());
 }
+
+static uint64_t vfsq64(uint64_t a, float_status *s)
+{
+    return float64_sqrt(a, s);
+}
+
+void HELPER(gvec_vfsq64)(void *v1, const void *v2, CPUS390XState *env,
+                         uint32_t desc)
+{
+    vop64_2(v1, v2, env, false, false, 0, vfsq64, GETPC());
+}
+
+void HELPER(gvec_vfsq64s)(void *v1, const void *v2, CPUS390XState *env,
+                          uint32_t desc)
+{
+    vop64_2(v1, v2, env, true, false, 0, vfsq64, GETPC());
+}
--=20
2.20.1


