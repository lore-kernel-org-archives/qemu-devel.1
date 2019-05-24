Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB5C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA0A20645
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA0A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51669 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6dq-00039S-5N
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:37:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hU6aG-0000EE-4r
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hU6aE-0005rX-Q1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hU6aE-0005qz-I9; Fri, 24 May 2019 05:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74841C05E760;
	Fri, 24 May 2019 09:33:47 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-48.ams2.redhat.com [10.36.116.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 236B66135E;
	Fri, 24 May 2019 09:33:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 11:33:34 +0200
Message-Id: <20190524093335.22241-5-david@redhat.com>
In-Reply-To: <20190524093335.22241-1-david@redhat.com>
References: <20190524093335.22241-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 24 May 2019 09:33:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/5] s390x/tcg: Implement VECTOR ISOLATE
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

Logic mostly courtesy of Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h            |  6 +++++
 target/s390x/insn-data.def       |  2 ++
 target/s390x/translate_vx.inc.c  | 34 ++++++++++++++++++++++++
 target/s390x/vec_string_helper.c | 45 ++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

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
index 1ad0b62517..08a62eab52 100644
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
@@ -2445,3 +2448,34 @@ static DisasJumpType op_vfene(DisasContext *s, Dis=
asOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vistr(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    static gen_helper_gvec_2 * const g[3] =3D {
+        gen_helper_gvec_vistr8,
+        gen_helper_gvec_vistr16,
+        gen_helper_gvec_vistr32,
+    };
+    static gen_helper_gvec_2_ptr * const g_cc[3] =3D {
+        gen_helper_gvec_vistr_cc8,
+        gen_helper_gvec_vistr_cc16,
+        gen_helper_gvec_vistr_cc32,
+    };
+
+    if (es > ES_32 || m5 & ~0x1) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (extract32(m5, 0, 1)) {
+        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       cpu_env, 0, g_cc[es]);
+        set_cc_static(s);
+    } else {
+        gen_gvec_2_ool(get_field(s->fields, v1), get_field(s->fields, v2=
), 0,
+                       g[es]);
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_string_helper.c b/target/s390x/vec_string_h=
elper.c
index 0ee3470112..6bafa23bd7 100644
--- a/target/s390x/vec_string_helper.c
+++ b/target/s390x/vec_string_helper.c
@@ -283,3 +283,48 @@ void HELPER(gvec_vfene_cc##BITS)(void *v1, const voi=
d *v2, const void *v3,     \
 DEF_VFENE_CC_HELPER(8)
 DEF_VFENE_CC_HELPER(16)
 DEF_VFENE_CC_HELPER(32)
+
+static int vistr(void *v1, const void *v2, uint8_t es)
+{
+    const uint64_t mask =3D get_element_lsbs_mask(es);
+    uint64_t a0 =3D s390_vec_read_element64(v2, 0);
+    uint64_t a1 =3D s390_vec_read_element64(v2, 1);
+    uint64_t z;
+    int cc =3D 3;
+
+    z =3D zero_search(a0, mask);
+    if (z) {
+        a0 &=3D ~(-1ull >> clz64(z));
+        a1 =3D 0;
+        cc =3D 0;
+    } else {
+        z =3D zero_search(a1, mask);
+        if (z) {
+            a1 &=3D ~(-1ull >> clz64(z));
+            cc =3D 0;
+        }
+    }
+
+    s390_vec_write_element64(v1, 0, a0);
+    s390_vec_write_element64(v1, 1, a1);
+    return cc;
+}
+
+#define DEF_VISTR_HELPER(BITS)                                          =
       \
+void HELPER(gvec_vistr##BITS)(void *v1, const void *v2, uint32_t desc)  =
       \
+{                                                                       =
       \
+    vistr(v1, v2, MO_##BITS);                                           =
       \
+}
+DEF_VISTR_HELPER(8)
+DEF_VISTR_HELPER(16)
+DEF_VISTR_HELPER(32)
+
+#define DEF_VISTR_CC_HELPER(BITS)                                       =
       \
+void HELPER(gvec_vistr_cc##BITS)(void *v1, const void *v2, CPUS390XState=
 *env, \
+                                uint32_t desc)                          =
       \
+{                                                                       =
       \
+    env->cc_op =3D vistr(v1, v2, MO_##BITS);                            =
         \
+}
+DEF_VISTR_CC_HELPER(8)
+DEF_VISTR_CC_HELPER(16)
+DEF_VISTR_CC_HELPER(32)
--=20
2.20.1


