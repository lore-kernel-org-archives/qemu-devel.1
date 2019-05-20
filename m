Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EC2C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7107B20675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7107B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlwG-0004pG-Ds
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:19:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSljx-0002NH-Jr
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSljv-0003bZ-3L
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:06:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlju-0003aC-GY; Mon, 20 May 2019 13:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DF0C3680B;
	Mon, 20 May 2019 17:06:17 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E2EA4608A7;
	Mon, 20 May 2019 17:06:11 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:24 +0200
Message-Id: <20190520170302.13643-17-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 20 May 2019 17:06:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/54] s390x/tcg: Implement VECTOR COUNT LEADING
 ZEROS
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

For 8/16, use the 32 bit variant and properly subtract the added
leading zero bits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 31 +++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 14 ++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 21921397fe00..670677427c10 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -150,6 +150,8 @@ DEF_HELPER_FLAGS_4(gvec_vavg8, TCG_CALL_NO_RWG, void,=
 ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vavg16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vavgl8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vavgl16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_3(gvec_vclz8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vclz16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 1d159cb20111..be3c07aafb75 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1084,6 +1084,8 @@
     E(0xe7fb, VCH,     VRR_b, V,   0, 0, 0, 0, vc, 0, TCG_COND_GT, IF_VE=
C)
 /* VECTOR COMPARE HIGH LOGICAL */
     E(0xe7f9, VCHL,    VRR_b, V,   0, 0, 0, 0, vc, 0, TCG_COND_GTU, IF_V=
EC)
+/* VECTOR COUNT LEADING ZEROS */
+    F(0xe753, VCLZ,    VRR_a, V,   0, 0, 0, 0, vclz, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 199742fad095..948c9fbbb10f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -182,6 +182,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
     tcg_temp_free_i64(tmp);
 }
=20
+#define gen_gvec_2(v1, v2, gen) \
+    tcg_gen_gvec_2(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                   16, 16, gen)
 #define gen_gvec_3(v1, v2, v3, gen) \
     tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    vec_full_reg_offset(v3), 16, 16, gen)
@@ -1417,3 +1420,31 @@ static DisasJumpType op_vc(DisasContext *s, DisasO=
ps *o)
     }
     return DISAS_NEXT;
 }
+
+static void gen_clz_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    tcg_gen_clzi_i32(d, a, 32);
+}
+
+static void gen_clz_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    tcg_gen_clzi_i64(d, a, 64);
+}
+
+static DisasJumpType op_vclz(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+    static const GVecGen2 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vclz8, },
+        { .fno =3D gen_helper_gvec_vclz16, },
+        { .fni4 =3D gen_clz_i32, },
+        { .fni8 =3D gen_clz_i64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es=
]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 8f97d3f466ee..016512547cc4 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -46,3 +46,17 @@ void HELPER(gvec_vavgl##BITS)(void *v1, const void *v2=
, const void *v3,        \
 }
 DEF_VAVGL(8)
 DEF_VAVGL(16)
+
+#define DEF_VCLZ(BITS)                                                  =
       \
+void HELPER(gvec_vclz##BITS)(void *v1, const void *v2, uint32_t desc)   =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, clz32(a) - 32 + BITS);      =
       \
+    }                                                                   =
       \
+}
+DEF_VCLZ(8)
+DEF_VCLZ(16)
--=20
2.20.1


