Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F1FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC321206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCiMVP2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC321206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3Tp-0002ci-3Y
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3OE-0000jN-0E
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3O6-0006tD-RC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3O6-0006se-ME
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3Q48Cgu0nCAAaVqjqrUVHb5nNmpYROWKK2lQRQnhVs=;
 b=FCiMVP2JpvrkaNmkC7YxgJ87aQINFZIUHqBk+O2R4b6nWrjO4BDDv+Qyqsv2GA9aYBbNFw
 9ybQHWwuTV825BEEDneI5fTpLlxMOVqgZ5tMxAB5cgZ3s3lrucI7Kc19n2pyimUh/AgfWj
 BooQ/8hONftPfusjae+LMJwROMG/HSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-mbQNZJ6BOnioo-zkYD0YzQ-1; Mon, 27 Jan 2020 07:21:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98A948017CC;
 Mon, 27 Jan 2020 12:21:00 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10B715DC1E;
 Mon, 27 Jan 2020 12:20:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/15] target/s390x: Move DisasFields into DisasContext
Date: Mon, 27 Jan 2020 13:20:13 +0100
Message-Id: <20200127122016.18752-13-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: mbQNZJ6BOnioo-zkYD0YzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

I believe that the separate allocation of DisasFields from DisasContext
was meant to limit the places from which we could access fields.  But
that plan did not go unchanged, and since DisasContext contains a pointer
to fields, the substructure is accessible everywhere.

By allocating the substructure with DisasContext, we improve the locality
of the accesses by avoiding one level of pointer chasing.  In addition,
we avoid a dangling pointer to stack allocated memory, diagnosed by static
checkers.

Launchpad: https://bugs.launchpad.net/bugs/1661815
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200123232248.1800-5-richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c        | 22 +++++++++---------
 target/s390x/translate_vx.inc.c | 40 ++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 51a1d865c04e..3674fee10c83 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -139,7 +139,7 @@ struct DisasFields {
 struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
-    DisasFields *fields;
+    DisasFields fields;
     uint64_t ex_value;
     /*
      * During translate_one(), pc_tmp is used to determine the instruction
@@ -1094,14 +1094,14 @@ typedef enum {
=20
 static bool have_field1(const DisasContext *s, enum DisasFieldIndexO c)
 {
-    return (s->fields->presentO >> c) & 1;
+    return (s->fields.presentO >> c) & 1;
 }
=20
 static int get_field1(const DisasContext *s, enum DisasFieldIndexO o,
                       enum DisasFieldIndexC c)
 {
     assert(have_field1(s, o));
-    return s->fields->c[c];
+    return s->fields.c[c];
 }
=20
 /* Describe the layout of each field in each format.  */
@@ -3763,7 +3763,7 @@ static DisasJumpType op_risbg(DisasContext *s, DisasO=
ps *o)
     int pos, len, rot;
=20
     /* Adjust the arguments for the specific insn.  */
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0x55: /* risbg */
     case 0x59: /* risbgn */
         i3 &=3D 63;
@@ -3804,7 +3804,7 @@ static DisasJumpType op_risbg(DisasContext *s, DisasO=
ps *o)
     len =3D i4 - i3 + 1;
     pos =3D 63 - i4;
     rot =3D i5 & 63;
-    if (s->fields->op2 =3D=3D 0x5d) {
+    if (s->fields.op2 =3D=3D 0x5d) {
         pos +=3D 32;
     }
=20
@@ -3873,7 +3873,7 @@ static DisasJumpType op_rosbg(DisasContext *s, DisasO=
ps *o)
     tcg_gen_rotli_i64(o->in2, o->in2, i5);
=20
     /* Operate.  */
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0x55: /* AND */
         tcg_gen_ori_i64(o->in2, o->in2, ~mask);
         tcg_gen_and_i64(o->out, o->out, o->in2);
@@ -4489,7 +4489,7 @@ static DisasJumpType op_stnosm(DisasContext *s, Disas=
Ops *o)
     tcg_gen_qemu_st8(t, o->addr1, get_mem_index(s));
     tcg_temp_free_i64(t);
=20
-    if (s->fields->op =3D=3D 0xac) {
+    if (s->fields.op =3D=3D 0xac) {
         tcg_gen_andi_i64(psw_mask, psw_mask,
                          (i2 << 56) | 0x00ffffffffffffffull);
     } else {
@@ -6000,7 +6000,7 @@ static void in2_i2_32u_shl(DisasContext *s, DisasOps =
*o)
 #ifndef CONFIG_USER_ONLY
 static void in2_insn(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D tcg_const_i64(s->fields->raw_insn);
+    o->in2 =3D tcg_const_i64(s->fields.raw_insn);
 }
 #define SPEC_in2_insn 0
 #endif
@@ -6299,15 +6299,13 @@ static DisasJumpType translate_one(CPUS390XState *e=
nv, DisasContext *s)
 {
     const DisasInsn *insn;
     DisasJumpType ret =3D DISAS_NEXT;
-    DisasFields f;
     DisasOps o =3D {};
=20
     /* Search for the insn in the table.  */
-    insn =3D extract_insn(env, s, &f);
+    insn =3D extract_insn(env, s, &s->fields);
=20
     /* Set up the strutures we use to communicate with the helpers. */
     s->insn =3D insn;
-    s->fields =3D &f;
=20
     /* Emit insn_start now that we know the ILEN.  */
     tcg_gen_insn_start(s->base.pc_next, s->cc_op, s->ilen);
@@ -6315,7 +6313,7 @@ static DisasJumpType translate_one(CPUS390XState *env=
, DisasContext *s)
     /* Not found means unimplemented/illegal opcode.  */
     if (insn =3D=3D NULL) {
         qemu_log_mask(LOG_UNIMP, "unimplemented opcode 0x%02x%02x\n",
-                      f.op, f.op2);
+                      s->fields.op, s->fields.op2);
         gen_illegal_opcode(s);
         return DISAS_NORETURN;
     }
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index e1a2d25c2fa4..24558cce8070 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -732,7 +732,7 @@ static DisasJumpType op_vmr(DisasContext *s, DisasOps *=
o)
     }
=20
     tmp =3D tcg_temp_new_i64();
-    if (s->fields->op2 =3D=3D 0x61) {
+    if (s->fields.op2 =3D=3D 0x61) {
         /* iterate backwards to avoid overwriting data we might need later=
 */
         for (dst_idx =3D NUM_VEC_ELEMENTS(es) - 1; dst_idx >=3D 0; dst_idx=
--) {
             src_idx =3D dst_idx / 2;
@@ -796,7 +796,7 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *=
o)
         return DISAS_NORETURN;
     }
=20
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0x97:
         if (get_field(s, m5) & 0x1) {
             gen_gvec_3_ptr(v1, v2, v3, cpu_env, 0, vpks_cc[es - 1]);
@@ -1038,7 +1038,7 @@ static DisasJumpType op_vstl(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_vup(DisasContext *s, DisasOps *o)
 {
-    const bool logical =3D s->fields->op2 =3D=3D 0xd4 || s->fields->op2 =
=3D=3D 0xd5;
+    const bool logical =3D s->fields.op2 =3D=3D 0xd4 || s->fields.op2 =3D=
=3D 0xd5;
     const uint8_t v1 =3D get_field(s, v1);
     const uint8_t v2 =3D get_field(s, v2);
     const uint8_t src_es =3D get_field(s, m3);
@@ -1052,7 +1052,7 @@ static DisasJumpType op_vup(DisasContext *s, DisasOps=
 *o)
     }
=20
     tmp =3D tcg_temp_new_i64();
-    if (s->fields->op2 =3D=3D 0xd7 || s->fields->op2 =3D=3D 0xd5) {
+    if (s->fields.op2 =3D=3D 0xd7 || s->fields.op2 =3D=3D 0xd5) {
         /* iterate backwards to avoid overwriting data we might need later=
 */
         for (dst_idx =3D NUM_VEC_ELEMENTS(dst_es) - 1; dst_idx >=3D 0; dst=
_idx--) {
             src_idx =3D dst_idx;
@@ -1389,7 +1389,7 @@ static DisasJumpType op_vec(DisasContext *s, DisasOps=
 *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    if (s->fields->op2 =3D=3D 0xdb) {
+    if (s->fields.op2 =3D=3D 0xdb) {
         es |=3D MO_SIGN;
     }
=20
@@ -1567,7 +1567,7 @@ static DisasJumpType op_vmx(DisasContext *s, DisasOps=
 *o)
         return DISAS_NORETURN;
     }
=20
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xff:
         gen_gvec_fn_3(smax, es, v1, v2, v3);
         break;
@@ -1677,7 +1677,7 @@ static DisasJumpType op_vma(DisasContext *s, DisasOps=
 *o)
         return DISAS_NORETURN;
     }
=20
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xaa:
         fn =3D &g_vmal[es];
         break;
@@ -1764,7 +1764,7 @@ static DisasJumpType op_vm(DisasContext *s, DisasOps =
*o)
         return DISAS_NORETURN;
     }
=20
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xa2:
         gen_gvec_fn_3(mul, es, get_field(s, v1),
                       get_field(s, v2), get_field(s, v3));
@@ -1967,7 +1967,7 @@ static DisasJumpType op_vesv(DisasContext *s, DisasOp=
s *o)
         return DISAS_NORETURN;
     }
=20
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0x70:
         gen_gvec_fn_3(shlv, es, v1, v2, v3);
         break;
@@ -1998,7 +1998,7 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps=
 *o)
     }
=20
     if (likely(!get_field(s, b2))) {
-        switch (s->fields->op2) {
+        switch (s->fields.op2) {
         case 0x30:
             gen_gvec_fn_2i(shli, es, v1, v3, d2);
             break;
@@ -2015,7 +2015,7 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps=
 *o)
         shift =3D tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(shift, o->addr1);
         tcg_gen_andi_i32(shift, shift, NUM_VEC_ELEMENT_BITS(es) - 1);
-        switch (s->fields->op2) {
+        switch (s->fields.op2) {
         case 0x30:
             gen_gvec_fn_2s(shls, es, v1, v3, shift);
             break;
@@ -2038,7 +2038,7 @@ static DisasJumpType op_vsl(DisasContext *s, DisasOps=
 *o)
     TCGv_i64 shift =3D tcg_temp_new_i64();
=20
     read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
-    if (s->fields->op2 =3D=3D 0x74) {
+    if (s->fields.op2 =3D=3D 0x74) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
@@ -2084,7 +2084,7 @@ static DisasJumpType op_vsra(DisasContext *s, DisasOp=
s *o)
     TCGv_i64 shift =3D tcg_temp_new_i64();
=20
     read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
-    if (s->fields->op2 =3D=3D 0x7e) {
+    if (s->fields.op2 =3D=3D 0x7e) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
@@ -2101,7 +2101,7 @@ static DisasJumpType op_vsrl(DisasContext *s, DisasOp=
s *o)
     TCGv_i64 shift =3D tcg_temp_new_i64();
=20
     read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
-    if (s->fields->op2 =3D=3D 0x7c) {
+    if (s->fields.op2 =3D=3D 0x7c) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
@@ -2524,7 +2524,7 @@ static DisasJumpType op_vfa(DisasContext *s, DisasOps=
 *o)
         return DISAS_NORETURN;
     }
=20
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xe3:
         fn =3D se ? gen_helper_gvec_vfa64s : gen_helper_gvec_vfa64;
         break;
@@ -2555,7 +2555,7 @@ static DisasJumpType op_wfc(DisasContext *s, DisasOps=
 *o)
         return DISAS_NORETURN;
     }
=20
-    if (s->fields->op2 =3D=3D 0xcb) {
+    if (s->fields.op2 =3D=3D 0xcb) {
         gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2),
                        cpu_env, 0, gen_helper_gvec_wfc64);
     } else {
@@ -2581,7 +2581,7 @@ static DisasJumpType op_vfc(DisasContext *s, DisasOps=
 *o)
     }
=20
     if (cs) {
-        switch (s->fields->op2) {
+        switch (s->fields.op2) {
         case 0xe8:
             fn =3D se ? gen_helper_gvec_vfce64s_cc : gen_helper_gvec_vfce6=
4_cc;
             break;
@@ -2595,7 +2595,7 @@ static DisasJumpType op_vfc(DisasContext *s, DisasOps=
 *o)
             g_assert_not_reached();
         }
     } else {
-        switch (s->fields->op2) {
+        switch (s->fields.op2) {
         case 0xe8:
             fn =3D se ? gen_helper_gvec_vfce64s : gen_helper_gvec_vfce64;
             break;
@@ -2630,7 +2630,7 @@ static DisasJumpType op_vcdg(DisasContext *s, DisasOp=
s *o)
         return DISAS_NORETURN;
     }
=20
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xc3:
         fn =3D se ? gen_helper_gvec_vcdg64s : gen_helper_gvec_vcdg64;
         break;
@@ -2688,7 +2688,7 @@ static DisasJumpType op_vfma(DisasContext *s, DisasOp=
s *o)
         return DISAS_NORETURN;
     }
=20
-    if (s->fields->op2 =3D=3D 0x8f) {
+    if (s->fields.op2 =3D=3D 0x8f) {
         fn =3D se ? gen_helper_gvec_vfma64s : gen_helper_gvec_vfma64;
     } else {
         fn =3D se ? gen_helper_gvec_vfms64s : gen_helper_gvec_vfms64;
--=20
2.21.1


