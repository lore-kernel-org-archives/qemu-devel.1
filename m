Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC181C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C83D2070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C83D2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0cJ-0008Jt-Lp
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:35:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Ym-0005s2-M6
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yl-0002FN-A9
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hR0Yj-0002E5-Du; Wed, 15 May 2019 16:31:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52C9130024A4;
	Wed, 15 May 2019 20:31:28 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 429E162926;
	Wed, 15 May 2019 20:31:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:31:11 +0200
Message-Id: <20190515203112.506-5-david@redhat.com>
In-Reply-To: <20190515203112.506-1-david@redhat.com>
References: <20190515203112.506-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 15 May 2019 20:31:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 4/5] s390x/tcg: Implement VECTOR ISOLATE
 STRING
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h            |  6 +++++
 target/s390x/insn-data.def       |  2 ++
 target/s390x/translate_vx.inc.c  | 34 ++++++++++++++++++++++++++
 target/s390x/vec_string_helper.c | 41 ++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index fb50b404db..1f9f0b463b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -230,6 +230,12 @@ DEF_HELPER_FLAGS_4(gvec_vfene32, TCG_CALL_NO_RWG, vo=
id, ptr, cptr, cptr, i32)
 DEF_HELPER_5(gvec_vfene_cc8, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfene_cc16, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfene_cc32, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_3(gvec_vistr8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vistr16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vistr32, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_4(gvec_vistr_cc8, void, ptr, cptr, env, i32)
+DEF_HELPER_4(gvec_vistr_cc16, void, ptr, cptr, env, i32)
+DEF_HELPER_4(gvec_vistr_cc32, void, ptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d03c1ee0b3..b4a6b59608 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1199,6 +1199,8 @@
     F(0xe780, VFEE,    VRR_b, V,   0, 0, 0, 0, vfee, 0, IF_VEC)
 /* VECTOR FIND ELEMENT NOT EQUAL */
     F(0xe781, VFENE,   VRR_b, V,   0, 0, 0, 0, vfene, 0, IF_VEC)
+/* VECTOR ISOLATE STRING */
+    F(0xe75c, VISTR,   VRR_a, V,   0, 0, 0, 0, vistr, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index e36cc5c401..437b416b4a 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -188,6 +188,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
 #define gen_gvec_2s(v1, v2, c, gen) \
     tcg_gen_gvec_2s(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                     16, 16, c, gen)
+#define gen_gvec_2_ool(v1, v2, data, fn) \
+    tcg_gen_gvec_2_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2),=
 \
+                       16, 16, data, fn)
 #define gen_gvec_2i_ool(v1, v2, c, data, fn) \
     tcg_gen_gvec_2i_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2)=
, \
                         c, 16, 16, data, fn)
@@ -2446,3 +2449,34 @@ static DisasJumpType op_vfene(DisasContext *s, Dis=
asOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vistr(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    static gen_helper_gvec_2_ptr * const cc[3] =3D {
+        gen_helper_gvec_vistr_cc8,
+        gen_helper_gvec_vistr_cc16,
+        gen_helper_gvec_vistr_cc32,
+    };
+    static gen_helper_gvec_2 * const nocc[3] =3D {
+        gen_helper_gvec_vistr8,
+        gen_helper_gvec_vistr16,
+        gen_helper_gvec_vistr32,
+    };
+
+    if (es > ES_32 || m5 & ~0x1) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (m5 & 1) {
+        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       cpu_env, 0, cc[es]);
+        set_cc_static(s);
+    } else {
+        gen_gvec_2_ool(get_field(s->fields, v1), get_field(s->fields, v2=
), 0,
+                       nocc[es]);
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_string_helper.c b/target/s390x/vec_string_h=
elper.c
index 181f044fe5..2e998c21a2 100644
--- a/target/s390x/vec_string_helper.c
+++ b/target/s390x/vec_string_helper.c
@@ -207,3 +207,44 @@ void HELPER(gvec_vfene_cc##BITS)(void *v1, const voi=
d *v2, const void *v3,     \
 DEF_VFENE_CC_HELPER(8)
 DEF_VFENE_CC_HELPER(16)
 DEF_VFENE_CC_HELPER(32)
+
+#define DEF_VISTR(BITS)                                                 =
       \
+static int vistr##BITS(void *v1, const void *v2)                        =
       \
+{                                                                       =
       \
+    S390Vector tmp =3D {};                                              =
         \
+    int i, cc =3D 3;                                                    =
         \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t data =3D s390_vec_read_element##BITS(v2, i)=
;        \
+                                                                        =
       \
+        if (!data) {                                                    =
       \
+            cc =3D 0;                                                   =
         \
+            break;                                                      =
       \
+        }                                                               =
       \
+        s390_vec_write_element##BITS(&tmp, i, data);                    =
       \
+    }                                                                   =
       \
+    *(S390Vector *)v1 =3D tmp;                                          =
         \
+    return cc;                                                          =
       \
+}
+DEF_VISTR(8)
+DEF_VISTR(16)
+DEF_VISTR(32)
+
+#define DEF_VISTR_HELPER(BITS)                                          =
       \
+void HELPER(gvec_vistr##BITS)(void *v1, const void *v2, uint32_t desc)  =
       \
+{                                                                       =
       \
+    vistr##BITS(v1, v2);                                                =
       \
+}
+DEF_VISTR_HELPER(8)
+DEF_VISTR_HELPER(16)
+DEF_VISTR_HELPER(32)
+
+#define DEF_VISTR_CC_HELPER(BITS)                                       =
       \
+void HELPER(gvec_vistr_cc##BITS)(void *v1, const void *v2,              =
       \
+                                 CPUS390XState *env, uint32_t desc)     =
       \
+{                                                                       =
       \
+    env->cc_op =3D vistr##BITS(v1, v2);                                 =
         \
+}
+DEF_VISTR_CC_HELPER(8)
+DEF_VISTR_CC_HELPER(16)
+DEF_VISTR_CC_HELPER(32)
--=20
2.20.1


