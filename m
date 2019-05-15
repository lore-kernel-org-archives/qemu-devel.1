Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBFBC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9BE2070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9BE2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0aL-0006mM-R3
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:33:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yj-0005os-B1
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yh-0002Dl-Fi
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hR0Yf-0002CY-OR; Wed, 15 May 2019 16:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F010130B32DD;
	Wed, 15 May 2019 20:31:24 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84A576266C;
	Wed, 15 May 2019 20:31:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:31:10 +0200
Message-Id: <20190515203112.506-4-david@redhat.com>
In-Reply-To: <20190515203112.506-1-david@redhat.com>
References: <20190515203112.506-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 15 May 2019 20:31:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 3/5] s390x/tcg: Implement VECTOR FIND
 ELEMENT NOT EQUAL
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

Similar to VECTOR FIND ELEMENT EQUAL, however the search also stops on
any inequality. A match for inequality seems to have precedence over
a match for zero, because both elements have to be zero.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h            |  6 ++++
 target/s390x/insn-data.def       |  2 ++
 target/s390x/translate_vx.inc.c  | 31 +++++++++++++++++++
 target/s390x/vec_string_helper.c | 53 ++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a1b169b666..fb50b404db 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -224,6 +224,12 @@ DEF_HELPER_FLAGS_4(gvec_vfee32, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, i32)
 DEF_HELPER_5(gvec_vfee_cc8, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfee_cc16, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfee_cc32, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfene8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vfene16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_vfene32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_5(gvec_vfene_cc8, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfene_cc16, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfene_cc32, void, ptr, cptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d8907ef6a5..d03c1ee0b3 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1197,6 +1197,8 @@
     F(0xe782, VFAE,    VRR_b, V,   0, 0, 0, 0, vfae, 0, IF_VEC)
 /* VECTOR FIND ELEMENT EQUAL */
     F(0xe780, VFEE,    VRR_b, V,   0, 0, 0, 0, vfee, 0, IF_VEC)
+/* VECTOR FIND ELEMENT NOT EQUAL */
+    F(0xe781, VFENE,   VRR_b, V,   0, 0, 0, 0, vfene, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 848f6d7163..e36cc5c401 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2415,3 +2415,34 @@ static DisasJumpType op_vfee(DisasContext *s, Disa=
sOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfene(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    static gen_helper_gvec_3_ptr * const cc[3] =3D {
+        gen_helper_gvec_vfene_cc8,
+        gen_helper_gvec_vfene_cc16,
+        gen_helper_gvec_vfene_cc32,
+    };
+    static gen_helper_gvec_3 * const nocc[3] =3D {
+        gen_helper_gvec_vfene8,
+        gen_helper_gvec_vfene16,
+        gen_helper_gvec_vfene32,
+    };
+
+    if (es > ES_32 || m5 & ~0x3) {
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
index 6a5d05271c..181f044fe5 100644
--- a/target/s390x/vec_string_helper.c
+++ b/target/s390x/vec_string_helper.c
@@ -154,3 +154,56 @@ void HELPER(gvec_vfee_cc##BITS)(void *v1, const void=
 *v2, const void *v3,      \
 DEF_VFEE_CC_HELPER(8)
 DEF_VFEE_CC_HELPER(16)
 DEF_VFEE_CC_HELPER(32)
+
+#define DEF_VFENE(BITS)                                                 =
       \
+static int vfene##BITS(void *v1, const void *v2, const void *v3, uint8_t=
 m5)   \
+{                                                                       =
       \
+    const bool zs =3D extract32(m5, 1, 1);                              =
         \
+    S390Vector tmp =3D {};                                              =
         \
+    int first_byte =3D 16;                                              =
         \
+    int cc =3D 3; /* no match */                                        =
         \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t data1 =3D s390_vec_read_element##BITS(v2, i=
);       \
+        const uint##BITS##_t data2 =3D s390_vec_read_element##BITS(v3, i=
);       \
+                                                                        =
       \
+        if (data1 !=3D data2) {                                         =
         \
+            first_byte =3D i * (BITS / 8);                              =
         \
+            cc =3D data1 < data2 ? 1 : 2; /* inequality found */        =
         \
+            break;                                                      =
       \
+        }                                                               =
       \
+                                                                        =
       \
+        if (zs && !data1) {                                             =
       \
+            first_byte =3D i * (BITS / 8);                              =
         \
+            cc =3D 0; /* match for zero */                              =
         \
+            break;                                                      =
       \
+        }                                                               =
       \
+    }                                                                   =
       \
+    s390_vec_write_element8(&tmp, 7, first_byte);                       =
       \
+    *(S390Vector *)v1 =3D tmp;                                          =
         \
+    return cc;                                                          =
       \
+}
+DEF_VFENE(8)
+DEF_VFENE(16)
+DEF_VFENE(32)
+
+#define DEF_VFENE_HELPER(BITS)                                          =
       \
+void HELPER(gvec_vfene##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                              uint32_t desc)                            =
       \
+{                                                                       =
       \
+    vfene##BITS(v1, v2, v3, simd_data(desc));                           =
       \
+}
+DEF_VFENE_HELPER(8)
+DEF_VFENE_HELPER(16)
+DEF_VFENE_HELPER(32)
+
+#define DEF_VFENE_CC_HELPER(BITS)                                       =
       \
+void HELPER(gvec_vfene_cc##BITS)(void *v1, const void *v2, const void *v=
3,     \
+                                CPUS390XState *env, uint32_t desc)      =
       \
+{                                                                       =
       \
+    env->cc_op =3D vfene##BITS(v1, v2, v3, simd_data(desc));            =
         \
+}
+DEF_VFENE_CC_HELPER(8)
+DEF_VFENE_CC_HELPER(16)
+DEF_VFENE_CC_HELPER(32)
--=20
2.20.1


