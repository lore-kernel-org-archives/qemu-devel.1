Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D92C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F93A20675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F93A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlwM-0004tJ-LH
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:19:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlmq-0004sZ-RJ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlmo-0004cV-WD
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlmo-0004bd-NB; Mon, 20 May 2019 13:09:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83631307D869;
	Mon, 20 May 2019 17:09:11 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1952C46E62;
	Mon, 20 May 2019 17:09:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:42 +0200
Message-Id: <20190520170302.13643-35-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 20 May 2019 17:09:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 34/54] s390x/tcg: Implement VECTOR SHIFT LEFT
 (BY BYTE)
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

We can reuse the existing 128-bit shift utility function.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 20 ++++++++++++++++++++
 target/s390x/vec_int_helper.c   |  6 ++++++
 4 files changed, 31 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index d570f763d94a..b4ddc8a7225e 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -204,6 +204,7 @@ DEF_HELPER_FLAGS_4(gvec_verll8, TCG_CALL_NO_RWG, void=
, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_verll16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, =
i32)
 DEF_HELPER_FLAGS_4(gvec_verim8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f4b67bda7eb2..2621e433cd03 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1160,6 +1160,10 @@
 /* VECTOR ELEMENT SHIFT RIGHT LOGICAL */
     F(0xe778, VESRLV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
     F(0xe738, VESRL,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
+/* VECTOR SHIFT LEFT */
+    F(0xe774, VSL,     VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
+/* VECTOR SHIFT LEFT BY BYTE */
+    F(0xe775, VSLB,    VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 15353096c0b8..734c022b3610 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -188,6 +188,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
 #define gen_gvec_2s(v1, v2, c, gen) \
     tcg_gen_gvec_2s(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                     16, 16, c, gen)
+#define gen_gvec_2i_ool(v1, v2, c, data, fn) \
+    tcg_gen_gvec_2i_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2)=
, \
+                        c, 16, 16, data, fn)
 #define gen_gvec_3(v1, v2, v3, gen) \
     tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    vec_full_reg_offset(v3), 16, 16, gen)
@@ -2040,3 +2043,20 @@ static DisasJumpType op_ves(DisasContext *s, Disas=
Ops *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsl(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 shift =3D tcg_temp_new_i64();
+
+    read_vec_element_i64(shift, get_field(s->fields, v3), 7, ES_8);
+    if (s->fields->op2 =3D=3D 0x74) {
+        tcg_gen_andi_i64(shift, shift, 0x7);
+    } else {
+        tcg_gen_andi_i64(shift, shift, 0x78);
+    }
+
+    gen_gvec_2i_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+                    shift, 0, gen_helper_gvec_vsl);
+    tcg_temp_free_i64(shift);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index b881fb722de2..3df069f03319 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -529,3 +529,9 @@ void HELPER(gvec_verim##BITS)(void *v1, const void *v=
2, const void *v3,        \
 }
 DEF_VERIM(8)
 DEF_VERIM(16)
+
+void HELPER(gvec_vsl)(void *v1, const void *v2, uint64_t count,
+                      uint32_t desc)
+{
+    s390_vec_shl(v1, v2, count);
+}
--=20
2.20.1


