Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2504EC04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1FB2070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1FB2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0aH-0006j4-Vu
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:33:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yh-0005oI-EH
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yf-0002Cj-IG
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hR0Yd-0002Ag-KP; Wed, 15 May 2019 16:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B43DF0D14;
	Wed, 15 May 2019 20:31:21 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DDA2E6266C;
	Wed, 15 May 2019 20:31:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:31:09 +0200
Message-Id: <20190515203112.506-3-david@redhat.com>
In-Reply-To: <20190515203112.506-1-david@redhat.com>
References: <20190515203112.506-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 15 May 2019 20:31:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 2/5] s390x/tcg: Implement VECTOR FIND
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

Implement it similar to VECTOR FIND ANY ELEMENT EQUAL.

The zero-check seems to have precedence in case we have
"data1 =3D=3D data2 =3D=3D 0". The description in the PoP is a little bi
confusing.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h            |  6 ++++
 target/s390x/insn-data.def       |  2 ++
 target/s390x/translate_vx.inc.c  | 31 +++++++++++++++++
 target/s390x/vec_string_helper.c | 59 ++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index c45328cf73..a1b169b666 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -218,6 +218,12 @@ DEF_HELPER_FLAGS_4(gvec_vfae32, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, i32)
 DEF_HELPER_5(gvec_vfae_cc8, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfae_cc16, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfae_cc32, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfee8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vfee16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vfee32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_5(gvec_vfee_cc8, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfee_cc16, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfee_cc32, void, ptr, cptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 070ce2a471..d8907ef6a5 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1195,6 +1195,8 @@
=20
 /* VECTOR FIND ANY ELEMENT EQUAL */
     F(0xe782, VFAE,    VRR_b, V,   0, 0, 0, 0, vfae, 0, IF_VEC)
+/* VECTOR FIND ELEMENT EQUAL */
+    F(0xe780, VFEE,    VRR_b, V,   0, 0, 0, 0, vfee, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 022990dda3..848f6d7163 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2384,3 +2384,34 @@ static DisasJumpType op_vfae(DisasContext *s, Disa=
sOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfee(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    static gen_helper_gvec_3_ptr * const cc[3] =3D {
+        gen_helper_gvec_vfee_cc8,
+        gen_helper_gvec_vfee_cc16,
+        gen_helper_gvec_vfee_cc32,
+    };
+    static gen_helper_gvec_3 * const nocc[3] =3D {
+        gen_helper_gvec_vfee8,
+        gen_helper_gvec_vfee16,
+        gen_helper_gvec_vfee32,
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
index 8a4e65b70f..6a5d05271c 100644
--- a/target/s390x/vec_string_helper.c
+++ b/target/s390x/vec_string_helper.c
@@ -95,3 +95,62 @@ void HELPER(gvec_vfae_cc##BITS)(void *v1, const void *=
v2, const void *v3,      \
 DEF_VFAE_CC_HELPER(8)
 DEF_VFAE_CC_HELPER(16)
 DEF_VFAE_CC_HELPER(32)
+
+#define DEF_VFEE(BITS)                                                  =
       \
+static int vfee##BITS(void *v1, const void *v2, const void *v3, uint8_t =
m5)    \
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
+        if (zs && !data1) {                                             =
       \
+            if (cc =3D=3D 3) {                                          =
           \
+                first_byte =3D i * (BITS / 8);                          =
         \
+                cc =3D 0; /* match for zero */                          =
         \
+            } else {                                                    =
       \
+                cc =3D 2; /* matching elements before match for zero */ =
         \
+            }                                                           =
       \
+            break;                                                      =
       \
+        }                                                               =
       \
+                                                                        =
       \
+        if (cc =3D=3D 3 && data1 =3D=3D data2) {                        =
               \
+            first_byte =3D i * (BITS / 8);                              =
         \
+            cc =3D 1; /* matching elements, no match for zero */        =
         \
+            if (!zs) {                                                  =
       \
+                break;                                                  =
       \
+            }                                                           =
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
+DEF_VFEE(8)
+DEF_VFEE(16)
+DEF_VFEE(32)
+
+#define DEF_VFEE_HELPER(BITS)                                           =
       \
+void HELPER(gvec_vfee##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             uint32_t desc)                             =
       \
+{                                                                       =
       \
+    vfee##BITS(v1, v2, v3, simd_data(desc));                            =
       \
+}
+DEF_VFEE_HELPER(8)
+DEF_VFEE_HELPER(16)
+DEF_VFEE_HELPER(32)
+
+#define DEF_VFEE_CC_HELPER(BITS)                                        =
       \
+void HELPER(gvec_vfee_cc##BITS)(void *v1, const void *v2, const void *v3=
,      \
+                                CPUS390XState *env, uint32_t desc)      =
       \
+{                                                                       =
       \
+    env->cc_op =3D vfee##BITS(v1, v2, v3, simd_data(desc));             =
         \
+}
+DEF_VFEE_CC_HELPER(8)
+DEF_VFEE_CC_HELPER(16)
+DEF_VFEE_CC_HELPER(32)
--=20
2.20.1


