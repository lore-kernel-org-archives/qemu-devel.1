Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FDBC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA18C2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA18C2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXP6-0007nU-3v
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:58:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWse-00039p-2D
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdh-0007Cw-EU
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWdh-0007Cf-3s; Thu, 11 Apr 2019 06:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 640243082128;
	Thu, 11 Apr 2019 10:09:00 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15C661001E71;
	Thu, 11 Apr 2019 10:08:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:08:04 +0200
Message-Id: <20190411100836.646-10-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 11 Apr 2019 10:09:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 09/41] s390x/tcg: Implement VECTOR CHECKSUM
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411100804.us8XZc86C5-e0ITbGpWxkHEbti6zzuy0N--870no2A4@z>

Time to introduce read_vec_element_i32 and write_vec_element_i32.
Take proper care of properly adding the carry.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 +
 target/s390x/translate_vx.inc.c | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

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
index a190ac57ee..7a7e185d43 100644
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
@@ -1260,3 +1306,24 @@ static DisasJumpType op_vavgl(DisasContext *s, Dis=
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
+        tcg_gen_add_i32(sum, sum, tmp);
+        tcg_gen_setcond_i32(TCG_COND_LTU, tmp, sum, tmp);
+        tcg_gen_add_i32(sum, sum, tmp);
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


