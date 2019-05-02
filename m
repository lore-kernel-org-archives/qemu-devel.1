Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0996AC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12DB206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12DB206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51827 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCXh-0006WQ-Vk
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:18:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQG-000882-53
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQE-0006j0-9x
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hMCQC-0006WY-8r; Thu, 02 May 2019 10:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5699F19D384;
	Thu,  2 May 2019 14:10:46 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-88.ams2.redhat.com [10.36.117.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CF2F7182E6;
	Thu,  2 May 2019 14:10:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:09:47 +0200
Message-Id: <20190502141019.6385-9-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 02 May 2019 14:10:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 08/40] s390x/tcg: Implement VECTOR CHECKSUM
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502140947.dbvWLtQwUzpV-H8UzYsh6vCaoecr-ffX1_VOSwnSges@z>

Time to introduce read_vec_element_i32 and write_vec_element_i32.
Take proper care of properly adding the carry. We can perform both
additions including the carry via tcg_gen_add2_i32().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 +
 target/s390x/translate_vx.inc.c | 65 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 9889dc0b01..64459465c5 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1072,6 +1072,8 @@
     F(0xe7f2, VAVG,    VRR_c, V,   0, 0, 0, 0, vavg, 0, IF_VEC)
 /* VECTOR AVERAGE LOGICAL */
     F(0xe7f0, VAVGL,   VRR_c, V,   0, 0, 0, 0, vavgl, 0, IF_VEC)
+/* VECTOR CHECKSUM */
+    F(0xe766, VCKSM,   VRR_c, V,   0, 0, 0, 0, vcksm, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 7e8418e585..0f90f981b6 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -90,6 +90,33 @@ static void read_vec_element_i64(TCGv_i64 dst, uint8_t=
 reg, uint8_t enr,
     }
 }
=20
+static void read_vec_element_i32(TCGv_i32 dst, uint8_t reg, uint8_t enr,
+                                 TCGMemOp memop)
+{
+    const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);
+
+    switch (memop) {
+    case ES_8:
+        tcg_gen_ld8u_i32(dst, cpu_env, offs);
+        break;
+    case ES_16:
+        tcg_gen_ld16u_i32(dst, cpu_env, offs);
+        break;
+    case ES_8 | MO_SIGN:
+        tcg_gen_ld8s_i32(dst, cpu_env, offs);
+        break;
+    case ES_16 | MO_SIGN:
+        tcg_gen_ld16s_i32(dst, cpu_env, offs);
+        break;
+    case ES_32:
+    case ES_32 | MO_SIGN:
+        tcg_gen_ld_i32(dst, cpu_env, offs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
                                   TCGMemOp memop)
 {
@@ -113,6 +140,25 @@ static void write_vec_element_i64(TCGv_i64 src, int =
reg, uint8_t enr,
     }
 }
=20
+static void write_vec_element_i32(TCGv_i32 src, int reg, uint8_t enr,
+                                  TCGMemOp memop)
+{
+    const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);
+
+    switch (memop) {
+    case ES_8:
+        tcg_gen_st8_i32(src, cpu_env, offs);
+        break;
+    case ES_16:
+        tcg_gen_st16_i32(src, cpu_env, offs);
+        break;
+    case ES_32:
+        tcg_gen_st_i32(src, cpu_env, offs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
=20
 static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 =
enr,
                                     uint8_t es)
@@ -1300,3 +1346,22 @@ static DisasJumpType op_vavgl(DisasContext *s, Dis=
asOps *o)
                get_field(s->fields, v3), &g[es]);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vcksm(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 tmp =3D tcg_temp_new_i32();
+    TCGv_i32 sum =3D tcg_temp_new_i32();
+    int i;
+
+    read_vec_element_i32(sum, get_field(s->fields, v3), 1, ES_32);
+    for (i =3D 0; i < 4; i++) {
+        read_vec_element_i32(tmp, get_field(s->fields, v2), i, ES_32);
+        tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);
+    }
+    zero_vec(get_field(s->fields, v1));
+    write_vec_element_i32(sum, get_field(s->fields, v1), 1, ES_32);
+
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(sum);
+    return DISAS_NEXT;
+}
--=20
2.20.1


