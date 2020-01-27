Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784C7206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1/zu/ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784C7206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3WR-0006Ms-I5
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3OH-0000n7-Pq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3O6-0006su-N0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39594
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3O4-0006qk-NZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeV/2SMft5+MEi6Rp97clBVGBEZZtoM2iveVOEwGWB4=;
 b=W1/zu/ZV3IRUgYsETNBsNtoWgk3NKCQUFoFrkST4VhbMG70nJaMLSKA+IUYdhzKTJoXPiB
 by8+0hud+WqPfi2y6rbj8YFEQDuaOCIueJHYzG05X/6ATcTHlLJFeJf9zdsM+M6dyJz/jn
 cSPONEAGK+SyfdFvyQNlp2uqnd7JSbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-k0HXgls_MYixFt5TN2oBXg-1; Mon, 27 Jan 2020 07:20:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C80D1005510;
 Mon, 27 Jan 2020 12:20:58 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 401A31001B08;
 Mon, 27 Jan 2020 12:20:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/15] target/s390x: Pass DisasContext to get_field and
 have_field
Date: Mon, 27 Jan 2020 13:20:12 +0100
Message-Id: <20200127122016.18752-12-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: k0HXgls_MYixFt5TN2oBXg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

All callers pass s->fields, so we might as well pass s directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200123232248.1800-4-richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c        | 534 ++++++++++++++--------------
 target/s390x/translate_vx.inc.c | 609 ++++++++++++++++----------------
 2 files changed, 569 insertions(+), 574 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 7d3dcc4faba9..51a1d865c04e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1092,16 +1092,16 @@ typedef enum {
 #define have_field(S, F)  have_field1((S), FLD_O_##F)
 #define get_field(S, F)   get_field1((S), FLD_O_##F, FLD_C_##F)
=20
-static bool have_field1(const DisasFields *f, enum DisasFieldIndexO c)
+static bool have_field1(const DisasContext *s, enum DisasFieldIndexO c)
 {
-    return (f->presentO >> c) & 1;
+    return (s->fields->presentO >> c) & 1;
 }
=20
-static int get_field1(const DisasFields *f, enum DisasFieldIndexO o,
+static int get_field1(const DisasContext *s, enum DisasFieldIndexO o,
                       enum DisasFieldIndexC c)
 {
-    assert(have_field1(f, o));
-    return f->c[c];
+    assert(have_field1(s, o));
+    return s->fields->c[c];
 }
=20
 /* Describe the layout of each field in each format.  */
@@ -1245,8 +1245,8 @@ struct DisasInsn {
=20
 static void help_l2_shift(DisasContext *s, DisasOps *o, int mask)
 {
-    int b2 =3D get_field(s->fields, b2);
-    int d2 =3D get_field(s->fields, d2);
+    int b2 =3D get_field(s, b2);
+    int d2 =3D get_field(s, d2);
=20
     if (b2 =3D=3D 0) {
         o->in2 =3D tcg_const_i64(d2 & mask);
@@ -1601,18 +1601,18 @@ static DisasJumpType op_bal(DisasContext *s, DisasO=
ps *o)
 static DisasJumpType op_basi(DisasContext *s, DisasOps *o)
 {
     pc_to_link_info(o->out, s, s->pc_tmp);
-    return help_goto_direct(s, s->base.pc_next + 2 * get_field(s->fields, =
i2));
+    return help_goto_direct(s, s->base.pc_next + 2 * get_field(s, i2));
 }
=20
 static DisasJumpType op_bc(DisasContext *s, DisasOps *o)
 {
-    int m1 =3D get_field(s->fields, m1);
-    bool is_imm =3D have_field(s->fields, i2);
-    int imm =3D is_imm ? get_field(s->fields, i2) : 0;
+    int m1 =3D get_field(s, m1);
+    bool is_imm =3D have_field(s, i2);
+    int imm =3D is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
=20
     /* BCR with R2 =3D 0 causes no branching */
-    if (have_field(s->fields, r2) && get_field(s->fields, r2) =3D=3D 0) {
+    if (have_field(s, r2) && get_field(s, r2) =3D=3D 0) {
         if (m1 =3D=3D 14) {
             /* Perform serialization */
             /* FIXME: check for fast-BCR-serialization facility */
@@ -1632,9 +1632,9 @@ static DisasJumpType op_bc(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_bct32(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    bool is_imm =3D have_field(s->fields, i2);
-    int imm =3D is_imm ? get_field(s->fields, i2) : 0;
+    int r1 =3D get_field(s, r1);
+    bool is_imm =3D have_field(s, i2);
+    int imm =3D is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
     TCGv_i64 t;
=20
@@ -1656,8 +1656,8 @@ static DisasJumpType op_bct32(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_bcth(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int imm =3D get_field(s->fields, i2);
+    int r1 =3D get_field(s, r1);
+    int imm =3D get_field(s, i2);
     DisasCompare c;
     TCGv_i64 t;
=20
@@ -1680,9 +1680,9 @@ static DisasJumpType op_bcth(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_bct64(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    bool is_imm =3D have_field(s->fields, i2);
-    int imm =3D is_imm ? get_field(s->fields, i2) : 0;
+    int r1 =3D get_field(s, r1);
+    bool is_imm =3D have_field(s, i2);
+    int imm =3D is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
=20
     c.cond =3D TCG_COND_NE;
@@ -1699,10 +1699,10 @@ static DisasJumpType op_bct64(DisasContext *s, Disa=
sOps *o)
=20
 static DisasJumpType op_bx32(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
-    bool is_imm =3D have_field(s->fields, i2);
-    int imm =3D is_imm ? get_field(s->fields, i2) : 0;
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
+    bool is_imm =3D have_field(s, i2);
+    int imm =3D is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
     TCGv_i64 t;
=20
@@ -1725,10 +1725,10 @@ static DisasJumpType op_bx32(DisasContext *s, Disas=
Ops *o)
=20
 static DisasJumpType op_bx64(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
-    bool is_imm =3D have_field(s->fields, i2);
-    int imm =3D is_imm ? get_field(s->fields, i2) : 0;
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
+    bool is_imm =3D have_field(s, i2);
+    int imm =3D is_imm ? get_field(s, i2) : 0;
     DisasCompare c;
=20
     c.cond =3D (s->insn->data ? TCG_COND_LE : TCG_COND_GT);
@@ -1751,7 +1751,7 @@ static DisasJumpType op_bx64(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_cj(DisasContext *s, DisasOps *o)
 {
-    int imm, m3 =3D get_field(s->fields, m3);
+    int imm, m3 =3D get_field(s, m3);
     bool is_imm;
     DisasCompare c;
=20
@@ -1763,13 +1763,13 @@ static DisasJumpType op_cj(DisasContext *s, DisasOp=
s *o)
     c.u.s64.a =3D o->in1;
     c.u.s64.b =3D o->in2;
=20
-    is_imm =3D have_field(s->fields, i4);
+    is_imm =3D have_field(s, i4);
     if (is_imm) {
-        imm =3D get_field(s->fields, i4);
+        imm =3D get_field(s, i4);
     } else {
         imm =3D 0;
-        o->out =3D get_address(s, 0, get_field(s->fields, b4),
-                             get_field(s->fields, d4));
+        o->out =3D get_address(s, 0, get_field(s, b4),
+                             get_field(s, d4));
     }
=20
     return help_branch(s, &c, is_imm, imm, o->out);
@@ -1800,8 +1800,8 @@ static TCGv_i32 fpinst_extract_m34(DisasContext *s, b=
ool m3_with_fpe,
                                    bool m4_with_fpe)
 {
     const bool fpe =3D s390_has_feat(S390_FEAT_FLOATING_POINT_EXT);
-    uint8_t m3 =3D get_field(s->fields, m3);
-    uint8_t m4 =3D get_field(s->fields, m4);
+    uint8_t m3 =3D get_field(s, m3);
+    uint8_t m4 =3D get_field(s, m4);
=20
     /* m3 field was introduced with FPE */
     if (!fpe && m3_with_fpe) {
@@ -2053,7 +2053,7 @@ static DisasJumpType op_cxlgb(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_cksm(DisasContext *s, DisasOps *o)
 {
-    int r2 =3D get_field(s->fields, r2);
+    int r2 =3D get_field(s, r2);
     TCGv_i64 len =3D tcg_temp_new_i64();
=20
     gen_helper_cksm(len, cpu_env, o->in1, o->in2, regs[r2 + 1]);
@@ -2069,7 +2069,7 @@ static DisasJumpType op_cksm(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
 {
-    int l =3D get_field(s->fields, l1);
+    int l =3D get_field(s, l1);
     TCGv_i32 vl;
=20
     switch (l + 1) {
@@ -2102,8 +2102,8 @@ static DisasJumpType op_clc(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_clcl(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r2 =3D get_field(s->fields, r2);
+    int r1 =3D get_field(s, r1);
+    int r2 =3D get_field(s, r2);
     TCGv_i32 t1, t2;
=20
     /* r1 and r2 must be even.  */
@@ -2123,8 +2123,8 @@ static DisasJumpType op_clcl(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_clcle(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     TCGv_i32 t1, t3;
=20
     /* r1 and r3 must be even.  */
@@ -2144,8 +2144,8 @@ static DisasJumpType op_clcle(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_clclu(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     TCGv_i32 t1, t3;
=20
     /* r1 and r3 must be even.  */
@@ -2165,7 +2165,7 @@ static DisasJumpType op_clclu(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_clm(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 =3D tcg_const_i32(get_field(s->fields, m3));
+    TCGv_i32 m3 =3D tcg_const_i32(get_field(s, m3));
     TCGv_i32 t1 =3D tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t1, o->in1);
     gen_helper_clm(cc_op, cpu_env, t1, m3, o->in2);
@@ -2195,8 +2195,8 @@ static DisasJumpType op_cps(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_cs(DisasContext *s, DisasOps *o)
 {
-    int d2 =3D get_field(s->fields, d2);
-    int b2 =3D get_field(s->fields, b2);
+    int d2 =3D get_field(s, d2);
+    int b2 =3D get_field(s, b2);
     TCGv_i64 addr, cc;
=20
     /* Note that in1 =3D R3 (new value) and
@@ -2220,10 +2220,10 @@ static DisasJumpType op_cs(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_cdsg(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
-    int d2 =3D get_field(s->fields, d2);
-    int b2 =3D get_field(s->fields, b2);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
+    int d2 =3D get_field(s, d2);
+    int b2 =3D get_field(s, b2);
     DisasJumpType ret =3D DISAS_NEXT;
     TCGv_i64 addr;
     TCGv_i32 t_r1, t_r3;
@@ -2250,7 +2250,7 @@ static DisasJumpType op_cdsg(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
 {
-    int r3 =3D get_field(s->fields, r3);
+    int r3 =3D get_field(s, r3);
     TCGv_i32 t_r3 =3D tcg_const_i32(r3);
=20
     if (tb_cflags(s->base.tb) & CF_PARALLEL) {
@@ -2323,7 +2323,7 @@ static DisasJumpType op_cvd(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_ct(DisasContext *s, DisasOps *o)
 {
-    int m3 =3D get_field(s->fields, m3);
+    int m3 =3D get_field(s, m3);
     TCGLabel *lab =3D gen_new_label();
     TCGCond c;
=20
@@ -2342,9 +2342,9 @@ static DisasJumpType op_ct(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_cuXX(DisasContext *s, DisasOps *o)
 {
-    int m3 =3D get_field(s->fields, m3);
-    int r1 =3D get_field(s->fields, r1);
-    int r2 =3D get_field(s->fields, r2);
+    int m3 =3D get_field(s, m3);
+    int r1 =3D get_field(s, r1);
+    int r2 =3D get_field(s, r2);
     TCGv_i32 tr1, tr2, chk;
=20
     /* R1 and R2 must both be even.  */
@@ -2393,9 +2393,9 @@ static DisasJumpType op_cuXX(DisasContext *s, DisasOp=
s *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_diag(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
-    TCGv_i32 func_code =3D tcg_const_i32(get_field(s->fields, i2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
+    TCGv_i32 func_code =3D tcg_const_i32(get_field(s, i2));
=20
     gen_helper_diag(cpu_env, r1, r3, func_code);
=20
@@ -2455,7 +2455,7 @@ static DisasJumpType op_dxb(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_ear(DisasContext *s, DisasOps *o)
 {
-    int r2 =3D get_field(s->fields, r2);
+    int r2 =3D get_field(s, r2);
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, aregs[r2]))=
;
     return DISAS_NEXT;
 }
@@ -2475,8 +2475,8 @@ static DisasJumpType op_efpc(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_epsw(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r2 =3D get_field(s->fields, r2);
+    int r1 =3D get_field(s, r1);
+    int r2 =3D get_field(s, r2);
     TCGv_i64 t =3D tcg_temp_new_i64();
=20
     /* Note the "subsequently" in the PoO, which implies a defined result
@@ -2493,7 +2493,7 @@ static DisasJumpType op_epsw(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_ex(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     TCGv_i32 ilen;
     TCGv_i64 v1;
=20
@@ -2582,7 +2582,7 @@ static DisasJumpType op_flogr(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_icm(DisasContext *s, DisasOps *o)
 {
-    int m3 =3D get_field(s->fields, m3);
+    int m3 =3D get_field(s, m3);
     int pos, len, base =3D s->insn->data;
     TCGv_i64 tmp =3D tcg_temp_new_i64();
     uint64_t ccm;
@@ -2670,7 +2670,7 @@ static DisasJumpType op_idte(DisasContext *s, DisasOp=
s *o)
     TCGv_i32 m4;
=20
     if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
-        m4 =3D tcg_const_i32(get_field(s->fields, m4));
+        m4 =3D tcg_const_i32(get_field(s, m4));
     } else {
         m4 =3D tcg_const_i32(0);
     }
@@ -2684,7 +2684,7 @@ static DisasJumpType op_ipte(DisasContext *s, DisasOp=
s *o)
     TCGv_i32 m4;
=20
     if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
-        m4 =3D tcg_const_i32(get_field(s->fields, m4));
+        m4 =3D tcg_const_i32(get_field(s, m4));
     } else {
         m4 =3D tcg_const_i32(0);
     }
@@ -2702,9 +2702,9 @@ static DisasJumpType op_iske(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D have_field(s->fields, r1) ? get_field(s->fields, r1) : 0;
-    int r2 =3D have_field(s->fields, r2) ? get_field(s->fields, r2) : 0;
-    int r3 =3D have_field(s->fields, r3) ? get_field(s->fields, r3) : 0;
+    int r1 =3D have_field(s, r1) ? get_field(s, r1) : 0;
+    int r2 =3D have_field(s, r2) ? get_field(s, r2) : 0;
+    int r3 =3D have_field(s, r3) ? get_field(s, r3) : 0;
     TCGv_i32 t_r1, t_r2, t_r3, type;
=20
     switch (s->insn->data) {
@@ -2930,7 +2930,7 @@ static DisasJumpType op_ld64(DisasContext *s, DisasOp=
s *o)
 static DisasJumpType op_lat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab =3D gen_new_label();
-    store_reg32_i64(get_field(s->fields, r1), o->in2);
+    store_reg32_i64(get_field(s, r1), o->in2);
     /* The value is stored even in case of trap. */
     tcg_gen_brcondi_i64(TCG_COND_NE, o->in2, 0, lab);
     gen_trap(s);
@@ -2952,7 +2952,7 @@ static DisasJumpType op_lgat(DisasContext *s, DisasOp=
s *o)
 static DisasJumpType op_lfhat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab =3D gen_new_label();
-    store_reg32h_i64(get_field(s->fields, r1), o->in2);
+    store_reg32h_i64(get_field(s, r1), o->in2);
     /* The value is stored even in case of trap. */
     tcg_gen_brcondi_i64(TCG_COND_NE, o->in2, 0, lab);
     gen_trap(s);
@@ -2986,7 +2986,7 @@ static DisasJumpType op_loc(DisasContext *s, DisasOps=
 *o)
 {
     DisasCompare c;
=20
-    disas_jcc(s, &c, get_field(s->fields, m3));
+    disas_jcc(s, &c, get_field(s, m3));
=20
     if (c.is_64) {
         tcg_gen_movcond_i64(c.cond, o->out, c.u.s64.a, c.u.s64.b,
@@ -3015,8 +3015,8 @@ static DisasJumpType op_loc(DisasContext *s, DisasOps=
 *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_lctl(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
     gen_helper_lctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -3026,8 +3026,8 @@ static DisasJumpType op_lctl(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
     gen_helper_lctlg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -3089,8 +3089,8 @@ static DisasJumpType op_lpswe(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_lam(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
     gen_helper_lam(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -3099,8 +3099,8 @@ static DisasJumpType op_lam(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_lm32(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     TCGv_i64 t1, t2;
=20
     /* Only one register to read. */
@@ -3145,8 +3145,8 @@ static DisasJumpType op_lm32(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_lmh(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     TCGv_i64 t1, t2;
=20
     /* Only one register to read. */
@@ -3191,8 +3191,8 @@ static DisasJumpType op_lmh(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_lm64(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     TCGv_i64 t1, t2;
=20
     /* Only one register to read. */
@@ -3244,8 +3244,8 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps=
 *o)
     }
=20
     /* In a serial context, perform the two loads ... */
-    a1 =3D get_address(s, 0, get_field(s->fields, b1), get_field(s->fields=
, d1));
-    a2 =3D get_address(s, 0, get_field(s->fields, b2), get_field(s->fields=
, d2));
+    a1 =3D get_address(s, 0, get_field(s, b1), get_field(s, d1));
+    a2 =3D get_address(s, 0, get_field(s, b2), get_field(s, d2));
     tcg_gen_qemu_ld_i64(o->out, a1, get_mem_index(s), mop | MO_ALIGN);
     tcg_gen_qemu_ld_i64(o->out2, a2, get_mem_index(s), mop | MO_ALIGN);
     tcg_temp_free_i64(a1);
@@ -3273,7 +3273,7 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps=
 *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
 {
-    o->addr1 =3D get_address(s, 0, get_field(s->fields, r2), 0);
+    o->addr1 =3D get_address(s, 0, get_field(s, r2), 0);
     tcg_gen_qemu_ld_tl(o->out, o->addr1, MMU_REAL_IDX, s->insn->data);
     return DISAS_NEXT;
 }
@@ -3287,9 +3287,9 @@ static DisasJumpType op_lzrb(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_lcbb(DisasContext *s, DisasOps *o)
 {
-    const int64_t block_size =3D (1ull << (get_field(s->fields, m3) + 6));
+    const int64_t block_size =3D (1ull << (get_field(s, m3) + 6));
=20
-    if (get_field(s->fields, m3) > 6) {
+    if (get_field(s, m3) > 6) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
@@ -3313,7 +3313,7 @@ static DisasJumpType op_mov2(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
 {
-    int b2 =3D get_field(s->fields, b2);
+    int b2 =3D get_field(s, b2);
     TCGv ar1 =3D tcg_temp_new_i64();
=20
     o->out =3D o->in2;
@@ -3360,7 +3360,7 @@ static DisasJumpType op_movx(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_mvc(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_mvc(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return DISAS_NEXT;
@@ -3368,7 +3368,7 @@ static DisasJumpType op_mvc(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_mvcin(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_mvcin(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return DISAS_NEXT;
@@ -3376,8 +3376,8 @@ static DisasJumpType op_mvcin(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_mvcl(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r2 =3D get_field(s->fields, r2);
+    int r1 =3D get_field(s, r1);
+    int r2 =3D get_field(s, r2);
     TCGv_i32 t1, t2;
=20
     /* r1 and r2 must be even.  */
@@ -3397,8 +3397,8 @@ static DisasJumpType op_mvcl(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_mvcle(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     TCGv_i32 t1, t3;
=20
     /* r1 and r3 must be even.  */
@@ -3418,8 +3418,8 @@ static DisasJumpType op_mvcle(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_mvclu(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     TCGv_i32 t1, t3;
=20
     /* r1 and r3 must be even.  */
@@ -3439,7 +3439,7 @@ static DisasJumpType op_mvclu(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_mvcos(DisasContext *s, DisasOps *o)
 {
-    int r3 =3D get_field(s->fields, r3);
+    int r3 =3D get_field(s, r3);
     gen_helper_mvcos(cc_op, cpu_env, o->addr1, o->in2, regs[r3]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3448,7 +3448,7 @@ static DisasJumpType op_mvcos(DisasContext *s, DisasO=
ps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_mvcp(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, l1);
+    int r1 =3D get_field(s, l1);
     gen_helper_mvcp(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3456,7 +3456,7 @@ static DisasJumpType op_mvcp(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_mvcs(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, l1);
+    int r1 =3D get_field(s, l1);
     gen_helper_mvcs(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3465,7 +3465,7 @@ static DisasJumpType op_mvcs(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_mvn(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_mvn(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return DISAS_NEXT;
@@ -3473,7 +3473,7 @@ static DisasJumpType op_mvn(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_mvo(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_mvo(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return DISAS_NEXT;
@@ -3488,8 +3488,8 @@ static DisasJumpType op_mvpg(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_mvst(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 t1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 t2 =3D tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 t1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 t2 =3D tcg_const_i32(get_field(s, r2));
=20
     gen_helper_mvst(cc_op, cpu_env, t1, t2);
     tcg_temp_free_i32(t1);
@@ -3500,7 +3500,7 @@ static DisasJumpType op_mvst(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_mvz(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_mvz(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return DISAS_NEXT;
@@ -3552,7 +3552,7 @@ static DisasJumpType op_mxdb(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_maeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 r3 =3D load_freg32_i64(get_field(s->fields, r3));
+    TCGv_i64 r3 =3D load_freg32_i64(get_field(s, r3));
     gen_helper_maeb(o->out, cpu_env, o->in1, o->in2, r3);
     tcg_temp_free_i64(r3);
     return DISAS_NEXT;
@@ -3560,7 +3560,7 @@ static DisasJumpType op_maeb(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_madb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 r3 =3D load_freg(get_field(s->fields, r3));
+    TCGv_i64 r3 =3D load_freg(get_field(s, r3));
     gen_helper_madb(o->out, cpu_env, o->in1, o->in2, r3);
     tcg_temp_free_i64(r3);
     return DISAS_NEXT;
@@ -3568,7 +3568,7 @@ static DisasJumpType op_madb(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_mseb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 r3 =3D load_freg32_i64(get_field(s->fields, r3));
+    TCGv_i64 r3 =3D load_freg32_i64(get_field(s, r3));
     gen_helper_mseb(o->out, cpu_env, o->in1, o->in2, r3);
     tcg_temp_free_i64(r3);
     return DISAS_NEXT;
@@ -3576,7 +3576,7 @@ static DisasJumpType op_mseb(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_msdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 r3 =3D load_freg(get_field(s->fields, r3));
+    TCGv_i64 r3 =3D load_freg(get_field(s, r3));
     gen_helper_msdb(o->out, cpu_env, o->in1, o->in2, r3);
     tcg_temp_free_i64(r3);
     return DISAS_NEXT;
@@ -3615,7 +3615,7 @@ static DisasJumpType op_nabsf128(DisasContext *s, Dis=
asOps *o)
=20
 static DisasJumpType op_nc(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_nc(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
@@ -3649,7 +3649,7 @@ static DisasJumpType op_negf128(DisasContext *s, Disa=
sOps *o)
=20
 static DisasJumpType op_oc(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_oc(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
@@ -3701,7 +3701,7 @@ static DisasJumpType op_oi(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_pack(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_pack(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return DISAS_NEXT;
@@ -3709,7 +3709,7 @@ static DisasJumpType op_pack(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_pka(DisasContext *s, DisasOps *o)
 {
-    int l2 =3D get_field(s->fields, l2) + 1;
+    int l2 =3D get_field(s, l2) + 1;
     TCGv_i32 l;
=20
     /* The length must not exceed 32 bytes.  */
@@ -3725,7 +3725,7 @@ static DisasJumpType op_pka(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_pku(DisasContext *s, DisasOps *o)
 {
-    int l2 =3D get_field(s->fields, l2) + 1;
+    int l2 =3D get_field(s, l2) + 1;
     TCGv_i32 l;
=20
     /* The length must be even and should not exceed 64 bytes.  */
@@ -3755,9 +3755,9 @@ static DisasJumpType op_ptlb(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_risbg(DisasContext *s, DisasOps *o)
 {
-    int i3 =3D get_field(s->fields, i3);
-    int i4 =3D get_field(s->fields, i4);
-    int i5 =3D get_field(s->fields, i5);
+    int i3 =3D get_field(s, i3);
+    int i4 =3D get_field(s, i4);
+    int i5 =3D get_field(s, i5);
     int do_zero =3D i4 & 0x80;
     uint64_t mask, imask, pmask;
     int pos, len, rot;
@@ -3845,9 +3845,9 @@ static DisasJumpType op_risbg(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_rosbg(DisasContext *s, DisasOps *o)
 {
-    int i3 =3D get_field(s->fields, i3);
-    int i4 =3D get_field(s->fields, i4);
-    int i5 =3D get_field(s->fields, i5);
+    int i3 =3D get_field(s, i3);
+    int i4 =3D get_field(s, i4);
+    int i5 =3D get_field(s, i5);
     uint64_t mask;
=20
     /* If this is a test-only form, arrange to discard the result.  */
@@ -3988,7 +3988,7 @@ static DisasJumpType op_sam(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_sar(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     tcg_gen_st32_i64(o->in2, cpu_env, offsetof(CPUS390XState, aregs[r1]));
     return DISAS_NEXT;
 }
@@ -4041,8 +4041,8 @@ static DisasJumpType op_servc(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_sigp(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
     gen_helper_sigp(cc_op, cpu_env, o->in2, r1, r3);
     set_cc_static(s);
     tcg_temp_free_i32(r1);
@@ -4058,7 +4058,7 @@ static DisasJumpType op_soc(DisasContext *s, DisasOps=
 *o)
     TCGLabel *lab;
     int r1;
=20
-    disas_jcc(s, &c, get_field(s->fields, m3));
+    disas_jcc(s, &c, get_field(s, m3));
=20
     /* We want to store when the condition is fulfilled, so branch
        out when it's not */
@@ -4072,8 +4072,8 @@ static DisasJumpType op_soc(DisasContext *s, DisasOps=
 *o)
     }
     free_compare(&c);
=20
-    r1 =3D get_field(s->fields, r1);
-    a =3D get_address(s, 0, get_field(s->fields, b2), get_field(s->fields,=
 d2));
+    r1 =3D get_field(s, r1);
+    a =3D get_address(s, 0, get_field(s, b2), get_field(s, d2));
     switch (s->insn->data) {
     case 1: /* STOCG */
         tcg_gen_qemu_st64(regs[r1], a, get_mem_index(s));
@@ -4185,11 +4185,11 @@ static DisasJumpType op_spm(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_ectg(DisasContext *s, DisasOps *o)
 {
-    int b1 =3D get_field(s->fields, b1);
-    int d1 =3D get_field(s->fields, d1);
-    int b2 =3D get_field(s->fields, b2);
-    int d2 =3D get_field(s->fields, d2);
-    int r3 =3D get_field(s->fields, r3);
+    int b1 =3D get_field(s, b1);
+    int d1 =3D get_field(s, d1);
+    int b2 =3D get_field(s, b2);
+    int d2 =3D get_field(s, d2);
+    int r3 =3D get_field(s, r3);
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
     /* fetch all operands first */
@@ -4305,8 +4305,8 @@ static DisasJumpType op_stckc(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_stctg(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
     gen_helper_stctg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -4315,8 +4315,8 @@ static DisasJumpType op_stctg(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_stctl(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
     gen_helper_stctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -4478,7 +4478,7 @@ static DisasJumpType op_stpx(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
 {
-    uint64_t i2 =3D get_field(s->fields, i2);
+    uint64_t i2 =3D get_field(s, i2);
     TCGv_i64 t;
=20
     /* It is important to do what the instruction name says: STORE THEN.
@@ -4502,7 +4502,7 @@ static DisasJumpType op_stnosm(DisasContext *s, Disas=
Ops *o)
=20
 static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
-    o->addr1 =3D get_address(s, 0, get_field(s->fields, r2), 0);
+    o->addr1 =3D get_address(s, 0, get_field(s, r2), 0);
     tcg_gen_qemu_st_tl(o->in1, o->addr1, MMU_REAL_IDX, s->insn->data);
=20
     if (s->base.tb->flags & FLAG_MASK_PER) {
@@ -4546,8 +4546,8 @@ static DisasJumpType op_st64(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_stam(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
     gen_helper_stam(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -4556,7 +4556,7 @@ static DisasJumpType op_stam(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_stcm(DisasContext *s, DisasOps *o)
 {
-    int m3 =3D get_field(s->fields, m3);
+    int m3 =3D get_field(s, m3);
     int pos, base =3D s->insn->data;
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
@@ -4605,8 +4605,8 @@ static DisasJumpType op_stcm(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_stm(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     int size =3D s->insn->data;
     TCGv_i64 tsize =3D tcg_const_i64(size);
=20
@@ -4629,8 +4629,8 @@ static DisasJumpType op_stm(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
-    int r3 =3D get_field(s->fields, r3);
+    int r1 =3D get_field(s, r1);
+    int r3 =3D get_field(s, r3);
     TCGv_i64 t =3D tcg_temp_new_i64();
     TCGv_i64 t4 =3D tcg_const_i64(4);
     TCGv_i64 t32 =3D tcg_const_i64(32);
@@ -4666,8 +4666,8 @@ static DisasJumpType op_stpq(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_srst(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r2 =3D tcg_const_i32(get_field(s, r2));
=20
     gen_helper_srst(cpu_env, r1, r2);
=20
@@ -4679,8 +4679,8 @@ static DisasJumpType op_srst(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_srstu(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r2 =3D tcg_const_i32(get_field(s, r2));
=20
     gen_helper_srstu(cpu_env, r1, r2);
=20
@@ -4729,7 +4729,7 @@ static DisasJumpType op_svc(DisasContext *s, DisasOps=
 *o)
     update_psw_addr(s);
     update_cc_op(s);
=20
-    t =3D tcg_const_i32(get_field(s->fields, i1) & 0xff);
+    t =3D tcg_const_i32(get_field(s, i1) & 0xff);
     tcg_gen_st_i32(t, cpu_env, offsetof(CPUS390XState, int_svc_code));
     tcg_temp_free_i32(t);
=20
@@ -4792,7 +4792,7 @@ static DisasJumpType op_tprot(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_tp(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l1 =3D tcg_const_i32(get_field(s->fields, l1) + 1);
+    TCGv_i32 l1 =3D tcg_const_i32(get_field(s, l1) + 1);
     gen_helper_tp(cc_op, cpu_env, o->addr1, l1);
     tcg_temp_free_i32(l1);
     set_cc_static(s);
@@ -4801,7 +4801,7 @@ static DisasJumpType op_tp(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_tr(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_tr(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
@@ -4818,7 +4818,7 @@ static DisasJumpType op_tre(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_trt(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_trt(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
@@ -4827,7 +4827,7 @@ static DisasJumpType op_trt(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_trtr(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_trtr(cc_op, cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
@@ -4836,11 +4836,11 @@ static DisasJumpType op_trtr(DisasContext *s, Disas=
Ops *o)
=20
 static DisasJumpType op_trXX(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r2 =3D tcg_const_i32(get_field(s, r2));
     TCGv_i32 sizes =3D tcg_const_i32(s->insn->opc & 3);
     TCGv_i32 tst =3D tcg_temp_new_i32();
-    int m3 =3D get_field(s->fields, m3);
+    int m3 =3D get_field(s, m3);
=20
     if (!s390_has_feat(S390_FEAT_ETF2_ENH)) {
         m3 =3D 0;
@@ -4877,7 +4877,7 @@ static DisasJumpType op_ts(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_unpk(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 l =3D tcg_const_i32(get_field(s->fields, l1));
+    TCGv_i32 l =3D tcg_const_i32(get_field(s, l1));
     gen_helper_unpk(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return DISAS_NEXT;
@@ -4885,7 +4885,7 @@ static DisasJumpType op_unpk(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_unpka(DisasContext *s, DisasOps *o)
 {
-    int l1 =3D get_field(s->fields, l1) + 1;
+    int l1 =3D get_field(s, l1) + 1;
     TCGv_i32 l;
=20
     /* The length must not exceed 32 bytes.  */
@@ -4902,7 +4902,7 @@ static DisasJumpType op_unpka(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_unpku(DisasContext *s, DisasOps *o)
 {
-    int l1 =3D get_field(s->fields, l1) + 1;
+    int l1 =3D get_field(s, l1) + 1;
     TCGv_i32 l;
=20
     /* The length must be even and should not exceed 64 bytes.  */
@@ -4920,11 +4920,11 @@ static DisasJumpType op_unpku(DisasContext *s, Disa=
sOps *o)
=20
 static DisasJumpType op_xc(DisasContext *s, DisasOps *o)
 {
-    int d1 =3D get_field(s->fields, d1);
-    int d2 =3D get_field(s->fields, d2);
-    int b1 =3D get_field(s->fields, b1);
-    int b2 =3D get_field(s->fields, b2);
-    int l =3D get_field(s->fields, l1);
+    int d1 =3D get_field(s, d1);
+    int d2 =3D get_field(s, d2);
+    int b1 =3D get_field(s, b1);
+    int b2 =3D get_field(s, b2);
+    int l =3D get_field(s, l1);
     TCGv_i32 t32;
=20
     o->addr1 =3D get_address(s, 0, b1, d1);
@@ -5031,7 +5031,7 @@ static DisasJumpType op_zero2(DisasContext *s, DisasO=
ps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_clp(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 r2 =3D tcg_const_i32(get_field(s, r2));
=20
     gen_helper_clp(cpu_env, r2);
     tcg_temp_free_i32(r2);
@@ -5041,8 +5041,8 @@ static DisasJumpType op_clp(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_pcilg(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r2 =3D tcg_const_i32(get_field(s, r2));
=20
     gen_helper_pcilg(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
@@ -5053,8 +5053,8 @@ static DisasJumpType op_pcilg(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_pcistg(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r2 =3D tcg_const_i32(get_field(s, r2));
=20
     gen_helper_pcistg(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
@@ -5065,8 +5065,8 @@ static DisasJumpType op_pcistg(DisasContext *s, Disas=
Ops *o)
=20
 static DisasJumpType op_stpcifc(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 ar =3D tcg_const_i32(get_field(s->fields, b2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 ar =3D tcg_const_i32(get_field(s, b2));
=20
     gen_helper_stpcifc(cpu_env, r1, o->addr1, ar);
     tcg_temp_free_i32(ar);
@@ -5083,8 +5083,8 @@ static DisasJumpType op_sic(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_rpcit(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r2 =3D tcg_const_i32(get_field(s, r2));
=20
     gen_helper_rpcit(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
@@ -5095,9 +5095,9 @@ static DisasJumpType op_rpcit(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_pcistb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
-    TCGv_i32 ar =3D tcg_const_i32(get_field(s->fields, b2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 r3 =3D tcg_const_i32(get_field(s, r3));
+    TCGv_i32 ar =3D tcg_const_i32(get_field(s, b2));
=20
     gen_helper_pcistb(cpu_env, r1, r3, o->addr1, ar);
     tcg_temp_free_i32(ar);
@@ -5109,8 +5109,8 @@ static DisasJumpType op_pcistb(DisasContext *s, Disas=
Ops *o)
=20
 static DisasJumpType op_mpcifc(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 ar =3D tcg_const_i32(get_field(s->fields, b2));
+    TCGv_i32 r1 =3D tcg_const_i32(get_field(s, r1));
+    TCGv_i32 ar =3D tcg_const_i32(get_field(s, b2));
=20
     gen_helper_mpcifc(cpu_env, r1, o->addr1, ar);
     tcg_temp_free_i32(ar);
@@ -5304,14 +5304,14 @@ static void prep_new_P(DisasContext *s, DisasOps *o=
)
=20
 static void prep_r1(DisasContext *s, DisasOps *o)
 {
-    o->out =3D regs[get_field(s->fields, r1)];
+    o->out =3D regs[get_field(s, r1)];
     o->g_out =3D true;
 }
 #define SPEC_prep_r1 0
=20
 static void prep_r1_P(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     o->out =3D regs[r1];
     o->out2 =3D regs[r1 + 1];
     o->g_out =3D o->g_out2 =3D true;
@@ -5321,8 +5321,8 @@ static void prep_r1_P(DisasContext *s, DisasOps *o)
 /* Whenever we need x1 in addition to other inputs, we'll load it to out/o=
ut2 */
 static void prep_x1(DisasContext *s, DisasOps *o)
 {
-    o->out =3D load_freg(get_field(s->fields, r1));
-    o->out2 =3D load_freg(get_field(s->fields, r1) + 2);
+    o->out =3D load_freg(get_field(s, r1));
+    o->out2 =3D load_freg(get_field(s, r1) + 2);
 }
 #define SPEC_prep_x1 SPEC_r1_f128
=20
@@ -5334,39 +5334,39 @@ static void prep_x1(DisasContext *s, DisasOps *o)
=20
 static void wout_r1(DisasContext *s, DisasOps *o)
 {
-    store_reg(get_field(s->fields, r1), o->out);
+    store_reg(get_field(s, r1), o->out);
 }
 #define SPEC_wout_r1 0
=20
 static void wout_r1_8(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     tcg_gen_deposit_i64(regs[r1], regs[r1], o->out, 0, 8);
 }
 #define SPEC_wout_r1_8 0
=20
 static void wout_r1_16(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     tcg_gen_deposit_i64(regs[r1], regs[r1], o->out, 0, 16);
 }
 #define SPEC_wout_r1_16 0
=20
 static void wout_r1_32(DisasContext *s, DisasOps *o)
 {
-    store_reg32_i64(get_field(s->fields, r1), o->out);
+    store_reg32_i64(get_field(s, r1), o->out);
 }
 #define SPEC_wout_r1_32 0
=20
 static void wout_r1_32h(DisasContext *s, DisasOps *o)
 {
-    store_reg32h_i64(get_field(s->fields, r1), o->out);
+    store_reg32h_i64(get_field(s, r1), o->out);
 }
 #define SPEC_wout_r1_32h 0
=20
 static void wout_r1_P32(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     store_reg32_i64(r1, o->out);
     store_reg32_i64(r1 + 1, o->out2);
 }
@@ -5374,7 +5374,7 @@ static void wout_r1_P32(DisasContext *s, DisasOps *o)
=20
 static void wout_r1_D32(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     store_reg32_i64(r1 + 1, o->out);
     tcg_gen_shri_i64(o->out, o->out, 32);
     store_reg32_i64(r1, o->out);
@@ -5383,7 +5383,7 @@ static void wout_r1_D32(DisasContext *s, DisasOps *o)
=20
 static void wout_r3_P32(DisasContext *s, DisasOps *o)
 {
-    int r3 =3D get_field(s->fields, r3);
+    int r3 =3D get_field(s, r3);
     store_reg32_i64(r3, o->out);
     store_reg32_i64(r3 + 1, o->out2);
 }
@@ -5391,7 +5391,7 @@ static void wout_r3_P32(DisasContext *s, DisasOps *o)
=20
 static void wout_r3_P64(DisasContext *s, DisasOps *o)
 {
-    int r3 =3D get_field(s->fields, r3);
+    int r3 =3D get_field(s, r3);
     store_reg(r3, o->out);
     store_reg(r3 + 1, o->out2);
 }
@@ -5399,19 +5399,19 @@ static void wout_r3_P64(DisasContext *s, DisasOps *=
o)
=20
 static void wout_e1(DisasContext *s, DisasOps *o)
 {
-    store_freg32_i64(get_field(s->fields, r1), o->out);
+    store_freg32_i64(get_field(s, r1), o->out);
 }
 #define SPEC_wout_e1 0
=20
 static void wout_f1(DisasContext *s, DisasOps *o)
 {
-    store_freg(get_field(s->fields, r1), o->out);
+    store_freg(get_field(s, r1), o->out);
 }
 #define SPEC_wout_f1 0
=20
 static void wout_x1(DisasContext *s, DisasOps *o)
 {
-    int f1 =3D get_field(s->fields, r1);
+    int f1 =3D get_field(s, r1);
     store_freg(f1, o->out);
     store_freg(f1 + 2, o->out2);
 }
@@ -5419,16 +5419,16 @@ static void wout_x1(DisasContext *s, DisasOps *o)
=20
 static void wout_cond_r1r2_32(DisasContext *s, DisasOps *o)
 {
-    if (get_field(s->fields, r1) !=3D get_field(s->fields, r2)) {
-        store_reg32_i64(get_field(s->fields, r1), o->out);
+    if (get_field(s, r1) !=3D get_field(s, r2)) {
+        store_reg32_i64(get_field(s, r1), o->out);
     }
 }
 #define SPEC_wout_cond_r1r2_32 0
=20
 static void wout_cond_e1e2(DisasContext *s, DisasOps *o)
 {
-    if (get_field(s->fields, r1) !=3D get_field(s->fields, r2)) {
-        store_freg32_i64(get_field(s->fields, r1), o->out);
+    if (get_field(s, r1) !=3D get_field(s, r2)) {
+        store_freg32_i64(get_field(s, r1), o->out);
     }
 }
 #define SPEC_wout_cond_e1e2 0
@@ -5489,13 +5489,13 @@ static void wout_m2_32(DisasContext *s, DisasOps *o=
)
=20
 static void wout_in2_r1(DisasContext *s, DisasOps *o)
 {
-    store_reg(get_field(s->fields, r1), o->in2);
+    store_reg(get_field(s, r1), o->in2);
 }
 #define SPEC_wout_in2_r1 0
=20
 static void wout_in2_r1_32(DisasContext *s, DisasOps *o)
 {
-    store_reg32_i64(get_field(s->fields, r1), o->in2);
+    store_reg32_i64(get_field(s, r1), o->in2);
 }
 #define SPEC_wout_in2_r1_32 0
=20
@@ -5504,13 +5504,13 @@ static void wout_in2_r1_32(DisasContext *s, DisasOp=
s *o)
=20
 static void in1_r1(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D load_reg(get_field(s->fields, r1));
+    o->in1 =3D load_reg(get_field(s, r1));
 }
 #define SPEC_in1_r1 0
=20
 static void in1_r1_o(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D regs[get_field(s->fields, r1)];
+    o->in1 =3D regs[get_field(s, r1)];
     o->g_in1 =3D true;
 }
 #define SPEC_in1_r1_o 0
@@ -5518,47 +5518,47 @@ static void in1_r1_o(DisasContext *s, DisasOps *o)
 static void in1_r1_32s(DisasContext *s, DisasOps *o)
 {
     o->in1 =3D tcg_temp_new_i64();
-    tcg_gen_ext32s_i64(o->in1, regs[get_field(s->fields, r1)]);
+    tcg_gen_ext32s_i64(o->in1, regs[get_field(s, r1)]);
 }
 #define SPEC_in1_r1_32s 0
=20
 static void in1_r1_32u(DisasContext *s, DisasOps *o)
 {
     o->in1 =3D tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in1, regs[get_field(s->fields, r1)]);
+    tcg_gen_ext32u_i64(o->in1, regs[get_field(s, r1)]);
 }
 #define SPEC_in1_r1_32u 0
=20
 static void in1_r1_sr32(DisasContext *s, DisasOps *o)
 {
     o->in1 =3D tcg_temp_new_i64();
-    tcg_gen_shri_i64(o->in1, regs[get_field(s->fields, r1)], 32);
+    tcg_gen_shri_i64(o->in1, regs[get_field(s, r1)], 32);
 }
 #define SPEC_in1_r1_sr32 0
=20
 static void in1_r1p1(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D load_reg(get_field(s->fields, r1) + 1);
+    o->in1 =3D load_reg(get_field(s, r1) + 1);
 }
 #define SPEC_in1_r1p1 SPEC_r1_even
=20
 static void in1_r1p1_32s(DisasContext *s, DisasOps *o)
 {
     o->in1 =3D tcg_temp_new_i64();
-    tcg_gen_ext32s_i64(o->in1, regs[get_field(s->fields, r1) + 1]);
+    tcg_gen_ext32s_i64(o->in1, regs[get_field(s, r1) + 1]);
 }
 #define SPEC_in1_r1p1_32s SPEC_r1_even
=20
 static void in1_r1p1_32u(DisasContext *s, DisasOps *o)
 {
     o->in1 =3D tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in1, regs[get_field(s->fields, r1) + 1]);
+    tcg_gen_ext32u_i64(o->in1, regs[get_field(s, r1) + 1]);
 }
 #define SPEC_in1_r1p1_32u SPEC_r1_even
=20
 static void in1_r1_D32(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     o->in1 =3D tcg_temp_new_i64();
     tcg_gen_concat32_i64(o->in1, regs[r1 + 1], regs[r1]);
 }
@@ -5566,26 +5566,26 @@ static void in1_r1_D32(DisasContext *s, DisasOps *o=
)
=20
 static void in1_r2(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D load_reg(get_field(s->fields, r2));
+    o->in1 =3D load_reg(get_field(s, r2));
 }
 #define SPEC_in1_r2 0
=20
 static void in1_r2_sr32(DisasContext *s, DisasOps *o)
 {
     o->in1 =3D tcg_temp_new_i64();
-    tcg_gen_shri_i64(o->in1, regs[get_field(s->fields, r2)], 32);
+    tcg_gen_shri_i64(o->in1, regs[get_field(s, r2)], 32);
 }
 #define SPEC_in1_r2_sr32 0
=20
 static void in1_r3(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D load_reg(get_field(s->fields, r3));
+    o->in1 =3D load_reg(get_field(s, r3));
 }
 #define SPEC_in1_r3 0
=20
 static void in1_r3_o(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D regs[get_field(s->fields, r3)];
+    o->in1 =3D regs[get_field(s, r3)];
     o->g_in1 =3D true;
 }
 #define SPEC_in1_r3_o 0
@@ -5593,20 +5593,20 @@ static void in1_r3_o(DisasContext *s, DisasOps *o)
 static void in1_r3_32s(DisasContext *s, DisasOps *o)
 {
     o->in1 =3D tcg_temp_new_i64();
-    tcg_gen_ext32s_i64(o->in1, regs[get_field(s->fields, r3)]);
+    tcg_gen_ext32s_i64(o->in1, regs[get_field(s, r3)]);
 }
 #define SPEC_in1_r3_32s 0
=20
 static void in1_r3_32u(DisasContext *s, DisasOps *o)
 {
     o->in1 =3D tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in1, regs[get_field(s->fields, r3)]);
+    tcg_gen_ext32u_i64(o->in1, regs[get_field(s, r3)]);
 }
 #define SPEC_in1_r3_32u 0
=20
 static void in1_r3_D32(DisasContext *s, DisasOps *o)
 {
-    int r3 =3D get_field(s->fields, r3);
+    int r3 =3D get_field(s, r3);
     o->in1 =3D tcg_temp_new_i64();
     tcg_gen_concat32_i64(o->in1, regs[r3 + 1], regs[r3]);
 }
@@ -5614,41 +5614,39 @@ static void in1_r3_D32(DisasContext *s, DisasOps *o=
)
=20
 static void in1_e1(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D load_freg32_i64(get_field(s->fields, r1));
+    o->in1 =3D load_freg32_i64(get_field(s, r1));
 }
 #define SPEC_in1_e1 0
=20
 static void in1_f1(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D load_freg(get_field(s->fields, r1));
+    o->in1 =3D load_freg(get_field(s, r1));
 }
 #define SPEC_in1_f1 0
=20
 /* Load the high double word of an extended (128-bit) format FP number */
 static void in1_x2h(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D load_freg(get_field(s->fields, r2));
+    o->in1 =3D load_freg(get_field(s, r2));
 }
 #define SPEC_in1_x2h SPEC_r2_f128
=20
 static void in1_f3(DisasContext *s, DisasOps *o)
 {
-    o->in1 =3D load_freg(get_field(s->fields, r3));
+    o->in1 =3D load_freg(get_field(s, r3));
 }
 #define SPEC_in1_f3 0
=20
 static void in1_la1(DisasContext *s, DisasOps *o)
 {
-    o->addr1 =3D get_address(s, 0, get_field(s->fields, b1),
-                           get_field(s->fields, d1));
+    o->addr1 =3D get_address(s, 0, get_field(s, b1), get_field(s, d1));
 }
 #define SPEC_in1_la1 0
=20
 static void in1_la2(DisasContext *s, DisasOps *o)
 {
-    int x2 =3D have_field(s->fields, x2) ? get_field(s->fields, x2) : 0;
-    o->addr1 =3D get_address(s, x2, get_field(s->fields, b2),
-                           get_field(s->fields, d2));
+    int x2 =3D have_field(s, x2) ? get_field(s, x2) : 0;
+    o->addr1 =3D get_address(s, x2, get_field(s, b2), get_field(s, d2));
 }
 #define SPEC_in1_la2 0
=20
@@ -5705,7 +5703,7 @@ static void in1_m1_64(DisasContext *s, DisasOps *o)
=20
 static void in2_r1_o(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D regs[get_field(s->fields, r1)];
+    o->in2 =3D regs[get_field(s, r1)];
     o->g_in2 =3D true;
 }
 #define SPEC_in2_r1_o 0
@@ -5713,20 +5711,20 @@ static void in2_r1_o(DisasContext *s, DisasOps *o)
 static void in2_r1_16u(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext16u_i64(o->in2, regs[get_field(s->fields, r1)]);
+    tcg_gen_ext16u_i64(o->in2, regs[get_field(s, r1)]);
 }
 #define SPEC_in2_r1_16u 0
=20
 static void in2_r1_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in2, regs[get_field(s->fields, r1)]);
+    tcg_gen_ext32u_i64(o->in2, regs[get_field(s, r1)]);
 }
 #define SPEC_in2_r1_32u 0
=20
 static void in2_r1_D32(DisasContext *s, DisasOps *o)
 {
-    int r1 =3D get_field(s->fields, r1);
+    int r1 =3D get_field(s, r1);
     o->in2 =3D tcg_temp_new_i64();
     tcg_gen_concat32_i64(o->in2, regs[r1 + 1], regs[r1]);
 }
@@ -5734,20 +5732,20 @@ static void in2_r1_D32(DisasContext *s, DisasOps *o=
)
=20
 static void in2_r2(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D load_reg(get_field(s->fields, r2));
+    o->in2 =3D load_reg(get_field(s, r2));
 }
 #define SPEC_in2_r2 0
=20
 static void in2_r2_o(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D regs[get_field(s->fields, r2)];
+    o->in2 =3D regs[get_field(s, r2)];
     o->g_in2 =3D true;
 }
 #define SPEC_in2_r2_o 0
=20
 static void in2_r2_nz(DisasContext *s, DisasOps *o)
 {
-    int r2 =3D get_field(s->fields, r2);
+    int r2 =3D get_field(s, r2);
     if (r2 !=3D 0) {
         o->in2 =3D load_reg(r2);
     }
@@ -5757,109 +5755,107 @@ static void in2_r2_nz(DisasContext *s, DisasOps *=
o)
 static void in2_r2_8s(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext8s_i64(o->in2, regs[get_field(s->fields, r2)]);
+    tcg_gen_ext8s_i64(o->in2, regs[get_field(s, r2)]);
 }
 #define SPEC_in2_r2_8s 0
=20
 static void in2_r2_8u(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext8u_i64(o->in2, regs[get_field(s->fields, r2)]);
+    tcg_gen_ext8u_i64(o->in2, regs[get_field(s, r2)]);
 }
 #define SPEC_in2_r2_8u 0
=20
 static void in2_r2_16s(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext16s_i64(o->in2, regs[get_field(s->fields, r2)]);
+    tcg_gen_ext16s_i64(o->in2, regs[get_field(s, r2)]);
 }
 #define SPEC_in2_r2_16s 0
=20
 static void in2_r2_16u(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext16u_i64(o->in2, regs[get_field(s->fields, r2)]);
+    tcg_gen_ext16u_i64(o->in2, regs[get_field(s, r2)]);
 }
 #define SPEC_in2_r2_16u 0
=20
 static void in2_r3(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D load_reg(get_field(s->fields, r3));
+    o->in2 =3D load_reg(get_field(s, r3));
 }
 #define SPEC_in2_r3 0
=20
 static void in2_r3_sr32(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_shri_i64(o->in2, regs[get_field(s->fields, r3)], 32);
+    tcg_gen_shri_i64(o->in2, regs[get_field(s, r3)], 32);
 }
 #define SPEC_in2_r3_sr32 0
=20
 static void in2_r3_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in2, regs[get_field(s->fields, r3)]);
+    tcg_gen_ext32u_i64(o->in2, regs[get_field(s, r3)]);
 }
 #define SPEC_in2_r3_32u 0
=20
 static void in2_r2_32s(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext32s_i64(o->in2, regs[get_field(s->fields, r2)]);
+    tcg_gen_ext32s_i64(o->in2, regs[get_field(s, r2)]);
 }
 #define SPEC_in2_r2_32s 0
=20
 static void in2_r2_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_ext32u_i64(o->in2, regs[get_field(s->fields, r2)]);
+    tcg_gen_ext32u_i64(o->in2, regs[get_field(s, r2)]);
 }
 #define SPEC_in2_r2_32u 0
=20
 static void in2_r2_sr32(DisasContext *s, DisasOps *o)
 {
     o->in2 =3D tcg_temp_new_i64();
-    tcg_gen_shri_i64(o->in2, regs[get_field(s->fields, r2)], 32);
+    tcg_gen_shri_i64(o->in2, regs[get_field(s, r2)], 32);
 }
 #define SPEC_in2_r2_sr32 0
=20
 static void in2_e2(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D load_freg32_i64(get_field(s->fields, r2));
+    o->in2 =3D load_freg32_i64(get_field(s, r2));
 }
 #define SPEC_in2_e2 0
=20
 static void in2_f2(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D load_freg(get_field(s->fields, r2));
+    o->in2 =3D load_freg(get_field(s, r2));
 }
 #define SPEC_in2_f2 0
=20
 /* Load the low double word of an extended (128-bit) format FP number */
 static void in2_x2l(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D load_freg(get_field(s->fields, r2) + 2);
+    o->in2 =3D load_freg(get_field(s, r2) + 2);
 }
 #define SPEC_in2_x2l SPEC_r2_f128
=20
 static void in2_ra2(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D get_address(s, 0, get_field(s->fields, r2), 0);
+    o->in2 =3D get_address(s, 0, get_field(s, r2), 0);
 }
 #define SPEC_in2_ra2 0
=20
 static void in2_a2(DisasContext *s, DisasOps *o)
 {
-    int x2 =3D have_field(s->fields, x2) ? get_field(s->fields, x2) : 0;
-    o->in2 =3D get_address(s, x2, get_field(s->fields, b2),
-                         get_field(s->fields, d2));
+    int x2 =3D have_field(s, x2) ? get_field(s, x2) : 0;
+    o->in2 =3D get_address(s, x2, get_field(s, b2), get_field(s, d2));
 }
 #define SPEC_in2_a2 0
=20
 static void in2_ri2(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D tcg_const_i64(s->base.pc_next +
-                           (int64_t)get_field(s->fields, i2) * 2);
+    o->in2 =3D tcg_const_i64(s->base.pc_next + (int64_t)get_field(s, i2) *=
 2);
 }
 #define SPEC_in2_ri2 0
=20
@@ -5965,38 +5961,38 @@ static void in2_mri2_64(DisasContext *s, DisasOps *=
o)
=20
 static void in2_i2(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D tcg_const_i64(get_field(s->fields, i2));
+    o->in2 =3D tcg_const_i64(get_field(s, i2));
 }
 #define SPEC_in2_i2 0
=20
 static void in2_i2_8u(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D tcg_const_i64((uint8_t)get_field(s->fields, i2));
+    o->in2 =3D tcg_const_i64((uint8_t)get_field(s, i2));
 }
 #define SPEC_in2_i2_8u 0
=20
 static void in2_i2_16u(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D tcg_const_i64((uint16_t)get_field(s->fields, i2));
+    o->in2 =3D tcg_const_i64((uint16_t)get_field(s, i2));
 }
 #define SPEC_in2_i2_16u 0
=20
 static void in2_i2_32u(DisasContext *s, DisasOps *o)
 {
-    o->in2 =3D tcg_const_i64((uint32_t)get_field(s->fields, i2));
+    o->in2 =3D tcg_const_i64((uint32_t)get_field(s, i2));
 }
 #define SPEC_in2_i2_32u 0
=20
 static void in2_i2_16u_shl(DisasContext *s, DisasOps *o)
 {
-    uint64_t i2 =3D (uint16_t)get_field(s->fields, i2);
+    uint64_t i2 =3D (uint16_t)get_field(s, i2);
     o->in2 =3D tcg_const_i64(i2 << s->insn->data);
 }
 #define SPEC_in2_i2_16u_shl 0
=20
 static void in2_i2_32u_shl(DisasContext *s, DisasOps *o)
 {
-    uint64_t i2 =3D (uint32_t)get_field(s->fields, i2);
+    uint64_t i2 =3D (uint32_t)get_field(s, i2);
     o->in2 =3D tcg_const_i64(i2 << s->insn->data);
 }
 #define SPEC_in2_i2_32u_shl 0
@@ -6309,6 +6305,10 @@ static DisasJumpType translate_one(CPUS390XState *en=
v, DisasContext *s)
     /* Search for the insn in the table.  */
     insn =3D extract_insn(env, s, &f);
=20
+    /* Set up the strutures we use to communicate with the helpers. */
+    s->insn =3D insn;
+    s->fields =3D &f;
+
     /* Emit insn_start now that we know the ILEN.  */
     tcg_gen_insn_start(s->base.pc_next, s->cc_op, s->ilen);
=20
@@ -6340,13 +6340,13 @@ static DisasJumpType translate_one(CPUS390XState *e=
nv, DisasContext *s)
         if (!(s->base.tb->flags & FLAG_MASK_AFP)) {
             uint8_t dxc =3D 0;
=20
-            if ((insn->flags & IF_AFP1) && is_afp_reg(get_field(&f, r1))) =
{
+            if ((insn->flags & IF_AFP1) && is_afp_reg(get_field(s, r1))) {
                 dxc =3D 1;
             }
-            if ((insn->flags & IF_AFP2) && is_afp_reg(get_field(&f, r2))) =
{
+            if ((insn->flags & IF_AFP2) && is_afp_reg(get_field(s, r2))) {
                 dxc =3D 1;
             }
-            if ((insn->flags & IF_AFP3) && is_afp_reg(get_field(&f, r3))) =
{
+            if ((insn->flags & IF_AFP3) && is_afp_reg(get_field(s, r3))) {
                 dxc =3D 1;
             }
             if (insn->flags & IF_BFP) {
@@ -6375,20 +6375,16 @@ static DisasJumpType translate_one(CPUS390XState *e=
nv, DisasContext *s)
=20
     /* Check for insn specification exceptions.  */
     if (insn->spec) {
-        if ((insn->spec & SPEC_r1_even && get_field(&f, r1) & 1) ||
-            (insn->spec & SPEC_r2_even && get_field(&f, r2) & 1) ||
-            (insn->spec & SPEC_r3_even && get_field(&f, r3) & 1) ||
-            (insn->spec & SPEC_r1_f128 && !is_fp_pair(get_field(&f, r1))) =
||
-            (insn->spec & SPEC_r2_f128 && !is_fp_pair(get_field(&f, r2))))=
 {
+        if ((insn->spec & SPEC_r1_even && get_field(s, r1) & 1) ||
+            (insn->spec & SPEC_r2_even && get_field(s, r2) & 1) ||
+            (insn->spec & SPEC_r3_even && get_field(s, r3) & 1) ||
+            (insn->spec & SPEC_r1_f128 && !is_fp_pair(get_field(s, r1))) |=
|
+            (insn->spec & SPEC_r2_f128 && !is_fp_pair(get_field(s, r2)))) =
{
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
     }
=20
-    /* Set up the strutures we use to communicate with the helpers. */
-    s->insn =3D insn;
-    s->fields =3D &f;
-
     /* Implement the instruction.  */
     if (insn->help_in1) {
         insn->help_in1(s, &o);
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 71059f9ca0a0..e1a2d25c2fa4 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -355,7 +355,7 @@ static void gen_addi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCG=
v_i64 al, TCGv_i64 ah,
 static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
 {
     const uint8_t es =3D s->insn->data;
-    const uint8_t enr =3D get_field(s->fields, m3);
+    const uint8_t enr =3D get_field(s, m3);
     TCGv_i64 tmp;
=20
     if (!valid_vec_element(enr, es)) {
@@ -364,12 +364,12 @@ static DisasJumpType op_vge(DisasContext *s, DisasOps=
 *o)
     }
=20
     tmp =3D tcg_temp_new_i64();
-    read_vec_element_i64(tmp, get_field(s->fields, v2), enr, es);
+    read_vec_element_i64(tmp, get_field(s, v2), enr, es);
     tcg_gen_add_i64(o->addr1, o->addr1, tmp);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 0);
=20
     tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
-    write_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    write_vec_element_i64(tmp, get_field(s, v1), enr, es);
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
@@ -389,22 +389,22 @@ static uint64_t generate_byte_mask(uint8_t mask)
=20
 static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
 {
-    const uint16_t i2 =3D get_field(s->fields, i2);
+    const uint16_t i2 =3D get_field(s, i2);
=20
     if (i2 =3D=3D (i2 & 0xff) * 0x0101) {
         /*
          * Masks for both 64 bit elements of the vector are the same.
          * Trust tcg to produce a good constant loading.
          */
-        gen_gvec_dup64i(get_field(s->fields, v1),
+        gen_gvec_dup64i(get_field(s, v1),
                         generate_byte_mask(i2 & 0xff));
     } else {
         TCGv_i64 t =3D tcg_temp_new_i64();
=20
         tcg_gen_movi_i64(t, generate_byte_mask(i2 >> 8));
-        write_vec_element_i64(t, get_field(s->fields, v1), 0, ES_64);
+        write_vec_element_i64(t, get_field(s, v1), 0, ES_64);
         tcg_gen_movi_i64(t, generate_byte_mask(i2));
-        write_vec_element_i64(t, get_field(s->fields, v1), 1, ES_64);
+        write_vec_element_i64(t, get_field(s, v1), 1, ES_64);
         tcg_temp_free_i64(t);
     }
     return DISAS_NEXT;
@@ -412,10 +412,10 @@ static DisasJumpType op_vgbm(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_vgm(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     const uint8_t bits =3D NUM_VEC_ELEMENT_BITS(es);
-    const uint8_t i2 =3D get_field(s->fields, i2) & (bits - 1);
-    const uint8_t i3 =3D get_field(s->fields, i3) & (bits - 1);
+    const uint8_t i2 =3D get_field(s, i2) & (bits - 1);
+    const uint8_t i3 =3D get_field(s, i3) & (bits - 1);
     uint64_t mask =3D 0;
     int i;
=20
@@ -432,7 +432,7 @@ static DisasJumpType op_vgm(DisasContext *s, DisasOps *=
o)
         }
     }
=20
-    gen_gvec_dupi(es, get_field(s->fields, v1), mask);
+    gen_gvec_dupi(es, get_field(s, v1), mask);
     return DISAS_NEXT;
 }
=20
@@ -444,8 +444,8 @@ static DisasJumpType op_vl(DisasContext *s, DisasOps *o=
)
     tcg_gen_qemu_ld_i64(t0, o->addr1, get_mem_index(s), MO_TEQ);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
     tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_TEQ);
-    write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
-    write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);
+    write_vec_element_i64(t0, get_field(s, v1), 0, ES_64);
+    write_vec_element_i64(t1, get_field(s, v1), 1, ES_64);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     return DISAS_NEXT;
@@ -453,13 +453,13 @@ static DisasJumpType op_vl(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_vlr(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2));
+    gen_gvec_mov(get_field(s, v1), get_field(s, v2));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vlrep(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t es =3D get_field(s, m3);
     TCGv_i64 tmp;
=20
     if (es > ES_64) {
@@ -469,7 +469,7 @@ static DisasJumpType op_vlrep(DisasContext *s, DisasOps=
 *o)
=20
     tmp =3D tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
-    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
+    gen_gvec_dup_i64(es, get_field(s, v1), tmp);
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
@@ -477,7 +477,7 @@ static DisasJumpType op_vlrep(DisasContext *s, DisasOps=
 *o)
 static DisasJumpType op_vle(DisasContext *s, DisasOps *o)
 {
     const uint8_t es =3D s->insn->data;
-    const uint8_t enr =3D get_field(s->fields, m3);
+    const uint8_t enr =3D get_field(s, m3);
     TCGv_i64 tmp;
=20
     if (!valid_vec_element(enr, es)) {
@@ -487,7 +487,7 @@ static DisasJumpType op_vle(DisasContext *s, DisasOps *=
o)
=20
     tmp =3D tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
-    write_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    write_vec_element_i64(tmp, get_field(s, v1), enr, es);
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
@@ -495,7 +495,7 @@ static DisasJumpType op_vle(DisasContext *s, DisasOps *=
o)
 static DisasJumpType op_vlei(DisasContext *s, DisasOps *o)
 {
     const uint8_t es =3D s->insn->data;
-    const uint8_t enr =3D get_field(s->fields, m3);
+    const uint8_t enr =3D get_field(s, m3);
     TCGv_i64 tmp;
=20
     if (!valid_vec_element(enr, es)) {
@@ -503,15 +503,15 @@ static DisasJumpType op_vlei(DisasContext *s, DisasOp=
s *o)
         return DISAS_NORETURN;
     }
=20
-    tmp =3D tcg_const_i64((int16_t)get_field(s->fields, i2));
-    write_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    tmp =3D tcg_const_i64((int16_t)get_field(s, i2));
+    write_vec_element_i64(tmp, get_field(s, v1), enr, es);
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vlgv(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     TCGv_ptr ptr;
=20
     if (es > ES_64) {
@@ -520,15 +520,15 @@ static DisasJumpType op_vlgv(DisasContext *s, DisasOp=
s *o)
     }
=20
     /* fast path if we don't need the register content */
-    if (!get_field(s->fields, b2)) {
-        uint8_t enr =3D get_field(s->fields, d2) & (NUM_VEC_ELEMENTS(es) -=
 1);
+    if (!get_field(s, b2)) {
+        uint8_t enr =3D get_field(s, d2) & (NUM_VEC_ELEMENTS(es) - 1);
=20
-        read_vec_element_i64(o->out, get_field(s->fields, v3), enr, es);
+        read_vec_element_i64(o->out, get_field(s, v3), enr, es);
         return DISAS_NEXT;
     }
=20
     ptr =3D tcg_temp_new_ptr();
-    get_vec_element_ptr_i64(ptr, get_field(s->fields, v3), o->addr1, es);
+    get_vec_element_ptr_i64(ptr, get_field(s, v3), o->addr1, es);
     switch (es) {
     case ES_8:
         tcg_gen_ld8u_i64(o->out, ptr, 0);
@@ -552,7 +552,7 @@ static DisasJumpType op_vlgv(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
 {
-    uint8_t es =3D get_field(s->fields, m3);
+    uint8_t es =3D get_field(s, m3);
     uint8_t enr;
     TCGv_i64 t;
=20
@@ -585,16 +585,16 @@ static DisasJumpType op_vllez(DisasContext *s, DisasO=
ps *o)
=20
     t =3D tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TE | es);
-    zero_vec(get_field(s->fields, v1));
-    write_vec_element_i64(t, get_field(s->fields, v1), enr, es);
+    zero_vec(get_field(s, v1));
+    write_vec_element_i64(t, get_field(s, v1), enr, es);
     tcg_temp_free_i64(t);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vlm(DisasContext *s, DisasOps *o)
 {
-    const uint8_t v3 =3D get_field(s->fields, v3);
-    uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v3 =3D get_field(s, v3);
+    uint8_t v1 =3D get_field(s, v1);
     TCGv_i64 t0, t1;
=20
     if (v3 < v1 || (v3 - v1 + 1) > 16) {
@@ -633,12 +633,12 @@ static DisasJumpType op_vlm(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_vlbb(DisasContext *s, DisasOps *o)
 {
-    const int64_t block_size =3D (1ull << (get_field(s->fields, m3) + 6));
-    const int v1_offs =3D vec_full_reg_offset(get_field(s->fields, v1));
+    const int64_t block_size =3D (1ull << (get_field(s, m3) + 6));
+    const int v1_offs =3D vec_full_reg_offset(get_field(s, v1));
     TCGv_ptr a0;
     TCGv_i64 bytes;
=20
-    if (get_field(s->fields, m3) > 6) {
+    if (get_field(s, m3) > 6) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
@@ -658,7 +658,7 @@ static DisasJumpType op_vlbb(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_vlvg(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     TCGv_ptr ptr;
=20
     if (es > ES_64) {
@@ -667,15 +667,15 @@ static DisasJumpType op_vlvg(DisasContext *s, DisasOp=
s *o)
     }
=20
     /* fast path if we don't need the register content */
-    if (!get_field(s->fields, b2)) {
-        uint8_t enr =3D get_field(s->fields, d2) & (NUM_VEC_ELEMENTS(es) -=
 1);
+    if (!get_field(s, b2)) {
+        uint8_t enr =3D get_field(s, d2) & (NUM_VEC_ELEMENTS(es) - 1);
=20
-        write_vec_element_i64(o->in2, get_field(s->fields, v1), enr, es);
+        write_vec_element_i64(o->in2, get_field(s, v1), enr, es);
         return DISAS_NEXT;
     }
=20
     ptr =3D tcg_temp_new_ptr();
-    get_vec_element_ptr_i64(ptr, get_field(s->fields, v1), o->addr1, es);
+    get_vec_element_ptr_i64(ptr, get_field(s, v1), o->addr1, es);
     switch (es) {
     case ES_8:
         tcg_gen_st8_i64(o->in2, ptr, 0);
@@ -699,14 +699,14 @@ static DisasJumpType op_vlvg(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_vlvgp(DisasContext *s, DisasOps *o)
 {
-    write_vec_element_i64(o->in1, get_field(s->fields, v1), 0, ES_64);
-    write_vec_element_i64(o->in2, get_field(s->fields, v1), 1, ES_64);
+    write_vec_element_i64(o->in1, get_field(s, v1), 0, ES_64);
+    write_vec_element_i64(o->in2, get_field(s, v1), 1, ES_64);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vll(DisasContext *s, DisasOps *o)
 {
-    const int v1_offs =3D vec_full_reg_offset(get_field(s->fields, v1));
+    const int v1_offs =3D vec_full_reg_offset(get_field(s, v1));
     TCGv_ptr a0 =3D tcg_temp_new_ptr();
=20
     /* convert highest index into an actual length */
@@ -719,10 +719,10 @@ static DisasJumpType op_vll(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_vmr(DisasContext *s, DisasOps *o)
 {
-    const uint8_t v1 =3D get_field(s->fields, v1);
-    const uint8_t v2 =3D get_field(s->fields, v2);
-    const uint8_t v3 =3D get_field(s->fields, v3);
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t v1 =3D get_field(s, v1);
+    const uint8_t v2 =3D get_field(s, v2);
+    const uint8_t v3 =3D get_field(s, v3);
+    const uint8_t es =3D get_field(s, m4);
     int dst_idx, src_idx;
     TCGv_i64 tmp;
=20
@@ -761,10 +761,10 @@ static DisasJumpType op_vmr(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
 {
-    const uint8_t v1 =3D get_field(s->fields, v1);
-    const uint8_t v2 =3D get_field(s->fields, v2);
-    const uint8_t v3 =3D get_field(s->fields, v3);
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t v1 =3D get_field(s, v1);
+    const uint8_t v2 =3D get_field(s, v2);
+    const uint8_t v3 =3D get_field(s, v3);
+    const uint8_t es =3D get_field(s, m4);
     static gen_helper_gvec_3 * const vpk[3] =3D {
         gen_helper_gvec_vpk16,
         gen_helper_gvec_vpk32,
@@ -798,7 +798,7 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *=
o)
=20
     switch (s->fields->op2) {
     case 0x97:
-        if (get_field(s->fields, m5) & 0x1) {
+        if (get_field(s, m5) & 0x1) {
             gen_gvec_3_ptr(v1, v2, v3, cpu_env, 0, vpks_cc[es - 1]);
             set_cc_static(s);
         } else {
@@ -806,7 +806,7 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *=
o)
         }
         break;
     case 0x95:
-        if (get_field(s->fields, m5) & 0x1) {
+        if (get_field(s, m5) & 0x1) {
             gen_gvec_3_ptr(v1, v2, v3, cpu_env, 0, vpkls_cc[es - 1]);
             set_cc_static(s);
         } else {
@@ -816,7 +816,7 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *=
o)
     case 0x94:
         /* If sources and destination dont't overlap -> fast path */
         if (v1 !=3D v2 && v1 !=3D v3) {
-            const uint8_t src_es =3D get_field(s->fields, m4);
+            const uint8_t src_es =3D get_field(s, m4);
             const uint8_t dst_es =3D src_es - 1;
             TCGv_i64 tmp =3D tcg_temp_new_i64();
             int dst_idx, src_idx;
@@ -844,23 +844,23 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_vperm(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
-                   get_field(s->fields, v3), get_field(s->fields, v4),
+    gen_gvec_4_ool(get_field(s, v1), get_field(s, v2),
+                   get_field(s, v3), get_field(s, v4),
                    0, gen_helper_gvec_vperm);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vpdi(DisasContext *s, DisasOps *o)
 {
-    const uint8_t i2 =3D extract32(get_field(s->fields, m4), 2, 1);
-    const uint8_t i3 =3D extract32(get_field(s->fields, m4), 0, 1);
+    const uint8_t i2 =3D extract32(get_field(s, m4), 2, 1);
+    const uint8_t i3 =3D extract32(get_field(s, m4), 0, 1);
     TCGv_i64 t0 =3D tcg_temp_new_i64();
     TCGv_i64 t1 =3D tcg_temp_new_i64();
=20
-    read_vec_element_i64(t0, get_field(s->fields, v2), i2, ES_64);
-    read_vec_element_i64(t1, get_field(s->fields, v3), i3, ES_64);
-    write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
-    write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);
+    read_vec_element_i64(t0, get_field(s, v2), i2, ES_64);
+    read_vec_element_i64(t1, get_field(s, v3), i3, ES_64);
+    write_vec_element_i64(t0, get_field(s, v1), 0, ES_64);
+    write_vec_element_i64(t1, get_field(s, v1), 1, ES_64);
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
     return DISAS_NEXT;
@@ -868,38 +868,38 @@ static DisasJumpType op_vpdi(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
 {
-    const uint8_t enr =3D get_field(s->fields, i2);
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t enr =3D get_field(s, i2);
+    const uint8_t es =3D get_field(s, m4);
=20
     if (es > ES_64 || !valid_vec_element(enr, es)) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
=20
-    tcg_gen_gvec_dup_mem(es, vec_full_reg_offset(get_field(s->fields, v1))=
,
-                         vec_reg_offset(get_field(s->fields, v3), enr, es)=
,
+    tcg_gen_gvec_dup_mem(es, vec_full_reg_offset(get_field(s, v1)),
+                         vec_reg_offset(get_field(s, v3), enr, es),
                          16, 16);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vrepi(DisasContext *s, DisasOps *o)
 {
-    const int64_t data =3D (int16_t)get_field(s->fields, i2);
-    const uint8_t es =3D get_field(s->fields, m3);
+    const int64_t data =3D (int16_t)get_field(s, i2);
+    const uint8_t es =3D get_field(s, m3);
=20
     if (es > ES_64) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
=20
-    gen_gvec_dupi(es, get_field(s->fields, v1), data);
+    gen_gvec_dupi(es, get_field(s, v1), data);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vsce(DisasContext *s, DisasOps *o)
 {
     const uint8_t es =3D s->insn->data;
-    const uint8_t enr =3D get_field(s->fields, m3);
+    const uint8_t enr =3D get_field(s, m3);
     TCGv_i64 tmp;
=20
     if (!valid_vec_element(enr, es)) {
@@ -908,11 +908,11 @@ static DisasJumpType op_vsce(DisasContext *s, DisasOp=
s *o)
     }
=20
     tmp =3D tcg_temp_new_i64();
-    read_vec_element_i64(tmp, get_field(s->fields, v2), enr, es);
+    read_vec_element_i64(tmp, get_field(s, v2), enr, es);
     tcg_gen_add_i64(o->addr1, o->addr1, tmp);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 0);
=20
-    read_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    read_vec_element_i64(tmp, get_field(s, v1), enr, es);
     tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
@@ -920,15 +920,15 @@ static DisasJumpType op_vsce(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_vsel(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_4(bitsel, ES_8, get_field(s->fields, v1),
-                  get_field(s->fields, v4), get_field(s->fields, v2),
-                  get_field(s->fields, v3));
+    gen_gvec_fn_4(bitsel, ES_8, get_field(s, v1),
+                  get_field(s, v4), get_field(s, v2),
+                  get_field(s, v3));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vseg(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t es =3D get_field(s, m3);
     int idx1, idx2;
     TCGv_i64 tmp;
=20
@@ -951,10 +951,10 @@ static DisasJumpType op_vseg(DisasContext *s, DisasOp=
s *o)
     }
=20
     tmp =3D tcg_temp_new_i64();
-    read_vec_element_i64(tmp, get_field(s->fields, v2), idx1, es | MO_SIGN=
);
-    write_vec_element_i64(tmp, get_field(s->fields, v1), 0, ES_64);
-    read_vec_element_i64(tmp, get_field(s->fields, v2), idx2, es | MO_SIGN=
);
-    write_vec_element_i64(tmp, get_field(s->fields, v1), 1, ES_64);
+    read_vec_element_i64(tmp, get_field(s, v2), idx1, es | MO_SIGN);
+    write_vec_element_i64(tmp, get_field(s, v1), 0, ES_64);
+    read_vec_element_i64(tmp, get_field(s, v2), idx2, es | MO_SIGN);
+    write_vec_element_i64(tmp, get_field(s, v1), 1, ES_64);
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
@@ -966,10 +966,10 @@ static DisasJumpType op_vst(DisasContext *s, DisasOps=
 *o)
     /* Probe write access before actually modifying memory */
     gen_helper_probe_write_access(cpu_env, o->addr1, tmp);
=20
-    read_vec_element_i64(tmp,  get_field(s->fields, v1), 0, ES_64);
+    read_vec_element_i64(tmp,  get_field(s, v1), 0, ES_64);
     tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEQ);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
-    read_vec_element_i64(tmp,  get_field(s->fields, v1), 1, ES_64);
+    read_vec_element_i64(tmp,  get_field(s, v1), 1, ES_64);
     tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEQ);
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
@@ -978,7 +978,7 @@ static DisasJumpType op_vst(DisasContext *s, DisasOps *=
o)
 static DisasJumpType op_vste(DisasContext *s, DisasOps *o)
 {
     const uint8_t es =3D s->insn->data;
-    const uint8_t enr =3D get_field(s->fields, m3);
+    const uint8_t enr =3D get_field(s, m3);
     TCGv_i64 tmp;
=20
     if (!valid_vec_element(enr, es)) {
@@ -987,7 +987,7 @@ static DisasJumpType op_vste(DisasContext *s, DisasOps =
*o)
     }
=20
     tmp =3D tcg_temp_new_i64();
-    read_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    read_vec_element_i64(tmp, get_field(s, v1), enr, es);
     tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
@@ -995,8 +995,8 @@ static DisasJumpType op_vste(DisasContext *s, DisasOps =
*o)
=20
 static DisasJumpType op_vstm(DisasContext *s, DisasOps *o)
 {
-    const uint8_t v3 =3D get_field(s->fields, v3);
-    uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v3 =3D get_field(s, v3);
+    uint8_t v1 =3D get_field(s, v1);
     TCGv_i64 tmp;
=20
     while (v3 < v1 || (v3 - v1 + 1) > 16) {
@@ -1025,7 +1025,7 @@ static DisasJumpType op_vstm(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_vstl(DisasContext *s, DisasOps *o)
 {
-    const int v1_offs =3D vec_full_reg_offset(get_field(s->fields, v1));
+    const int v1_offs =3D vec_full_reg_offset(get_field(s, v1));
     TCGv_ptr a0 =3D tcg_temp_new_ptr();
=20
     /* convert highest index into an actual length */
@@ -1039,9 +1039,9 @@ static DisasJumpType op_vstl(DisasContext *s, DisasOp=
s *o)
 static DisasJumpType op_vup(DisasContext *s, DisasOps *o)
 {
     const bool logical =3D s->fields->op2 =3D=3D 0xd4 || s->fields->op2 =
=3D=3D 0xd5;
-    const uint8_t v1 =3D get_field(s->fields, v1);
-    const uint8_t v2 =3D get_field(s->fields, v2);
-    const uint8_t src_es =3D get_field(s->fields, m3);
+    const uint8_t v1 =3D get_field(s, v1);
+    const uint8_t v2 =3D get_field(s, v2);
+    const uint8_t src_es =3D get_field(s, m3);
     const uint8_t dst_es =3D src_es + 1;
     int dst_idx, src_idx;
     TCGv_i64 tmp;
@@ -1076,18 +1076,18 @@ static DisasJumpType op_vup(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_va(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
=20
     if (es > ES_128) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     } else if (es =3D=3D ES_128) {
-        gen_gvec128_3_i64(tcg_gen_add2_i64, get_field(s->fields, v1),
-                          get_field(s->fields, v2), get_field(s->fields, v=
3));
+        gen_gvec128_3_i64(tcg_gen_add2_i64, get_field(s, v1),
+                          get_field(s, v2), get_field(s, v3));
         return DISAS_NEXT;
     }
-    gen_gvec_fn_3(add, es, get_field(s->fields, v1), get_field(s->fields, =
v2),
-                  get_field(s->fields, v3));
+    gen_gvec_fn_3(add, es, get_field(s, v1), get_field(s, v2),
+                  get_field(s, v3));
     return DISAS_NEXT;
 }
=20
@@ -1165,7 +1165,7 @@ static void gen_acc2_i64(TCGv_i64 dl, TCGv_i64 dh, TC=
Gv_i64 al,
=20
 static DisasJumpType op_vacc(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     static const GVecGen3 g[4] =3D {
         { .fni8 =3D gen_acc8_i64, },
         { .fni8 =3D gen_acc16_i64, },
@@ -1177,12 +1177,12 @@ static DisasJumpType op_vacc(DisasContext *s, Disas=
Ops *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     } else if (es =3D=3D ES_128) {
-        gen_gvec128_3_i64(gen_acc2_i64, get_field(s->fields, v1),
-                          get_field(s->fields, v2), get_field(s->fields, v=
3));
+        gen_gvec128_3_i64(gen_acc2_i64, get_field(s, v1),
+                          get_field(s, v2), get_field(s, v3));
         return DISAS_NEXT;
     }
-    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), &g[es]);
+    gen_gvec_3(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), &g[es]);
     return DISAS_NEXT;
 }
=20
@@ -1203,14 +1203,14 @@ static void gen_ac2_i64(TCGv_i64 dl, TCGv_i64 dh, T=
CGv_i64 al, TCGv_i64 ah,
=20
 static DisasJumpType op_vac(DisasContext *s, DisasOps *o)
 {
-    if (get_field(s->fields, m5) !=3D ES_128) {
+    if (get_field(s, m5) !=3D ES_128) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
=20
-    gen_gvec128_4_i64(gen_ac2_i64, get_field(s->fields, v1),
-                      get_field(s->fields, v2), get_field(s->fields, v3),
-                      get_field(s->fields, v4));
+    gen_gvec128_4_i64(gen_ac2_i64, get_field(s, v1),
+                      get_field(s, v2), get_field(s, v3),
+                      get_field(s, v4));
     return DISAS_NEXT;
 }
=20
@@ -1235,28 +1235,28 @@ static void gen_accc2_i64(TCGv_i64 dl, TCGv_i64 dh,=
 TCGv_i64 al, TCGv_i64 ah,
=20
 static DisasJumpType op_vaccc(DisasContext *s, DisasOps *o)
 {
-    if (get_field(s->fields, m5) !=3D ES_128) {
+    if (get_field(s, m5) !=3D ES_128) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
=20
-    gen_gvec128_4_i64(gen_accc2_i64, get_field(s->fields, v1),
-                      get_field(s->fields, v2), get_field(s->fields, v3),
-                      get_field(s->fields, v4));
+    gen_gvec128_4_i64(gen_accc2_i64, get_field(s, v1),
+                      get_field(s, v2), get_field(s, v3),
+                      get_field(s, v4));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vn(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_3(and, ES_8, get_field(s->fields, v1), get_field(s->fields=
, v2),
-                  get_field(s->fields, v3));
+    gen_gvec_fn_3(and, ES_8, get_field(s, v1), get_field(s, v2),
+                  get_field(s, v3));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vnc(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_3(andc, ES_8, get_field(s->fields, v1),
-                  get_field(s->fields, v2), get_field(s->fields, v3));
+    gen_gvec_fn_3(andc, ES_8, get_field(s, v1),
+                  get_field(s, v2), get_field(s, v3));
     return DISAS_NEXT;
 }
=20
@@ -1296,7 +1296,7 @@ static void gen_avg_i64(TCGv_i64 dl, TCGv_i64 al, TCG=
v_i64 bl)
=20
 static DisasJumpType op_vavg(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     static const GVecGen3 g[4] =3D {
         { .fno =3D gen_helper_gvec_vavg8, },
         { .fno =3D gen_helper_gvec_vavg16, },
@@ -1308,8 +1308,8 @@ static DisasJumpType op_vavg(DisasContext *s, DisasOp=
s *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), &g[es]);
+    gen_gvec_3(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), &g[es]);
     return DISAS_NEXT;
 }
=20
@@ -1344,7 +1344,7 @@ static void gen_avgl_i64(TCGv_i64 dl, TCGv_i64 al, TC=
Gv_i64 bl)
=20
 static DisasJumpType op_vavgl(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     static const GVecGen3 g[4] =3D {
         { .fno =3D gen_helper_gvec_vavgl8, },
         { .fno =3D gen_helper_gvec_vavgl16, },
@@ -1356,8 +1356,8 @@ static DisasJumpType op_vavgl(DisasContext *s, DisasO=
ps *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), &g[es]);
+    gen_gvec_3(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), &g[es]);
     return DISAS_NEXT;
 }
=20
@@ -1367,13 +1367,13 @@ static DisasJumpType op_vcksm(DisasContext *s, Disa=
sOps *o)
     TCGv_i32 sum =3D tcg_temp_new_i32();
     int i;
=20
-    read_vec_element_i32(sum, get_field(s->fields, v3), 1, ES_32);
+    read_vec_element_i32(sum, get_field(s, v3), 1, ES_32);
     for (i =3D 0; i < 4; i++) {
-        read_vec_element_i32(tmp, get_field(s->fields, v2), i, ES_32);
+        read_vec_element_i32(tmp, get_field(s, v2), i, ES_32);
         tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);
     }
-    zero_vec(get_field(s->fields, v1));
-    write_vec_element_i32(sum, get_field(s->fields, v1), 1, ES_32);
+    zero_vec(get_field(s, v1));
+    write_vec_element_i32(sum, get_field(s, v1), 1, ES_32);
=20
     tcg_temp_free_i32(tmp);
     tcg_temp_free_i32(sum);
@@ -1382,7 +1382,7 @@ static DisasJumpType op_vcksm(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_vec(DisasContext *s, DisasOps *o)
 {
-    uint8_t es =3D get_field(s->fields, m3);
+    uint8_t es =3D get_field(s, m3);
     const uint8_t enr =3D NUM_VEC_ELEMENTS(es) / 2 - 1;
=20
     if (es > ES_64) {
@@ -1395,14 +1395,14 @@ static DisasJumpType op_vec(DisasContext *s, DisasO=
ps *o)
=20
     o->in1 =3D tcg_temp_new_i64();
     o->in2 =3D tcg_temp_new_i64();
-    read_vec_element_i64(o->in1, get_field(s->fields, v1), enr, es);
-    read_vec_element_i64(o->in2, get_field(s->fields, v2), enr, es);
+    read_vec_element_i64(o->in1, get_field(s, v1), enr, es);
+    read_vec_element_i64(o->in2, get_field(s, v2), enr, es);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vc(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     TCGCond cond =3D s->insn->data;
=20
     if (es > ES_64) {
@@ -1411,15 +1411,15 @@ static DisasJumpType op_vc(DisasContext *s, DisasOp=
s *o)
     }
=20
     tcg_gen_gvec_cmp(cond, es,
-                     vec_full_reg_offset(get_field(s->fields, v1)),
-                     vec_full_reg_offset(get_field(s->fields, v2)),
-                     vec_full_reg_offset(get_field(s->fields, v3)), 16, 16=
);
-    if (get_field(s->fields, m5) & 0x1) {
+                     vec_full_reg_offset(get_field(s, v1)),
+                     vec_full_reg_offset(get_field(s, v2)),
+                     vec_full_reg_offset(get_field(s, v3)), 16, 16);
+    if (get_field(s, m5) & 0x1) {
         TCGv_i64 low =3D tcg_temp_new_i64();
         TCGv_i64 high =3D tcg_temp_new_i64();
=20
-        read_vec_element_i64(high, get_field(s->fields, v1), 0, ES_64);
-        read_vec_element_i64(low, get_field(s->fields, v1), 1, ES_64);
+        read_vec_element_i64(high, get_field(s, v1), 0, ES_64);
+        read_vec_element_i64(low, get_field(s, v1), 1, ES_64);
         gen_op_update2_cc_i64(s, CC_OP_VC, low, high);
=20
         tcg_temp_free_i64(low);
@@ -1440,7 +1440,7 @@ static void gen_clz_i64(TCGv_i64 d, TCGv_i64 a)
=20
 static DisasJumpType op_vclz(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t es =3D get_field(s, m3);
     static const GVecGen2 g[4] =3D {
         { .fno =3D gen_helper_gvec_vclz8, },
         { .fno =3D gen_helper_gvec_vclz16, },
@@ -1452,7 +1452,7 @@ static DisasJumpType op_vclz(DisasContext *s, DisasOp=
s *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es])=
;
+    gen_gvec_2(get_field(s, v1), get_field(s, v2), &g[es]);
     return DISAS_NEXT;
 }
=20
@@ -1468,7 +1468,7 @@ static void gen_ctz_i64(TCGv_i64 d, TCGv_i64 a)
=20
 static DisasJumpType op_vctz(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t es =3D get_field(s, m3);
     static const GVecGen2 g[4] =3D {
         { .fno =3D gen_helper_gvec_vctz8, },
         { .fno =3D gen_helper_gvec_vctz16, },
@@ -1480,20 +1480,20 @@ static DisasJumpType op_vctz(DisasContext *s, Disas=
Ops *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es])=
;
+    gen_gvec_2(get_field(s, v1), get_field(s, v2), &g[es]);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vx(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_3(xor, ES_8, get_field(s->fields, v1), get_field(s->fields=
, v2),
-                 get_field(s->fields, v3));
+    gen_gvec_fn_3(xor, ES_8, get_field(s, v1), get_field(s, v2),
+                 get_field(s, v3));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vgfm(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     static const GVecGen3 g[4] =3D {
         { .fno =3D gen_helper_gvec_vgfm8, },
         { .fno =3D gen_helper_gvec_vgfm16, },
@@ -1505,14 +1505,14 @@ static DisasJumpType op_vgfm(DisasContext *s, Disas=
Ops *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), &g[es]);
+    gen_gvec_3(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), &g[es]);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vgfma(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m5);
+    const uint8_t es =3D get_field(s, m5);
     static const GVecGen4 g[4] =3D {
         { .fno =3D gen_helper_gvec_vgfma8, },
         { .fno =3D gen_helper_gvec_vgfma16, },
@@ -1524,43 +1524,43 @@ static DisasJumpType op_vgfma(DisasContext *s, Disa=
sOps *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    gen_gvec_4(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), get_field(s->fields, v4), &g[es])=
;
+    gen_gvec_4(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), get_field(s, v4), &g[es]);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vlc(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t es =3D get_field(s, m3);
=20
     if (es > ES_64) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
=20
-    gen_gvec_fn_2(neg, es, get_field(s->fields, v1), get_field(s->fields, =
v2));
+    gen_gvec_fn_2(neg, es, get_field(s, v1), get_field(s, v2));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vlp(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t es =3D get_field(s, m3);
=20
     if (es > ES_64) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
=20
-    gen_gvec_fn_2(abs, es, get_field(s->fields, v1), get_field(s->fields, =
v2));
+    gen_gvec_fn_2(abs, es, get_field(s, v1), get_field(s, v2));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vmx(DisasContext *s, DisasOps *o)
 {
-    const uint8_t v1 =3D get_field(s->fields, v1);
-    const uint8_t v2 =3D get_field(s->fields, v2);
-    const uint8_t v3 =3D get_field(s->fields, v3);
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t v1 =3D get_field(s, v1);
+    const uint8_t v2 =3D get_field(s, v2);
+    const uint8_t v3 =3D get_field(s, v3);
+    const uint8_t es =3D get_field(s, m4);
=20
     if (es > ES_64) {
         gen_program_exception(s, PGM_SPECIFICATION);
@@ -1634,7 +1634,7 @@ static void gen_malh_i32(TCGv_i32 d, TCGv_i32 a, TCGv=
_i32 b, TCGv_i32 c)
=20
 static DisasJumpType op_vma(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m5);
+    const uint8_t es =3D get_field(s, m5);
     static const GVecGen4 g_vmal[3] =3D {
         { .fno =3D gen_helper_gvec_vmal8, },
         { .fno =3D gen_helper_gvec_vmal16, },
@@ -1703,8 +1703,8 @@ static DisasJumpType op_vma(DisasContext *s, DisasOps=
 *o)
         g_assert_not_reached();
     }
=20
-    gen_gvec_4(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), get_field(s->fields, v4), fn);
+    gen_gvec_4(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), get_field(s, v4), fn);
     return DISAS_NEXT;
 }
=20
@@ -1726,7 +1726,7 @@ static void gen_mlh_i32(TCGv_i32 d, TCGv_i32 a, TCGv_=
i32 b)
=20
 static DisasJumpType op_vm(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     static const GVecGen3 g_vmh[3] =3D {
         { .fno =3D gen_helper_gvec_vmh8, },
         { .fno =3D gen_helper_gvec_vmh16, },
@@ -1766,8 +1766,8 @@ static DisasJumpType op_vm(DisasContext *s, DisasOps =
*o)
=20
     switch (s->fields->op2) {
     case 0xa2:
-        gen_gvec_fn_3(mul, es, get_field(s->fields, v1),
-                      get_field(s->fields, v2), get_field(s->fields, v3));
+        gen_gvec_fn_3(mul, es, get_field(s, v1),
+                      get_field(s, v2), get_field(s, v3));
         return DISAS_NEXT;
     case 0xa3:
         fn =3D &g_vmh[es];
@@ -1791,49 +1791,49 @@ static DisasJumpType op_vm(DisasContext *s, DisasOp=
s *o)
         g_assert_not_reached();
     }
=20
-    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), fn);
+    gen_gvec_3(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), fn);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vnn(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_3(nand, ES_8, get_field(s->fields, v1),
-                  get_field(s->fields, v2), get_field(s->fields, v3));
+    gen_gvec_fn_3(nand, ES_8, get_field(s, v1),
+                  get_field(s, v2), get_field(s, v3));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vno(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_3(nor, ES_8, get_field(s->fields, v1), get_field(s->fields=
, v2),
-                  get_field(s->fields, v3));
+    gen_gvec_fn_3(nor, ES_8, get_field(s, v1), get_field(s, v2),
+                  get_field(s, v3));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vnx(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_3(eqv, ES_8, get_field(s->fields, v1), get_field(s->fields=
, v2),
-                  get_field(s->fields, v3));
+    gen_gvec_fn_3(eqv, ES_8, get_field(s, v1), get_field(s, v2),
+                  get_field(s, v3));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vo(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_3(or, ES_8, get_field(s->fields, v1), get_field(s->fields,=
 v2),
-                  get_field(s->fields, v3));
+    gen_gvec_fn_3(or, ES_8, get_field(s, v1), get_field(s, v2),
+                  get_field(s, v3));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_voc(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_fn_3(orc, ES_8, get_field(s->fields, v1), get_field(s->fields=
, v2),
-                  get_field(s->fields, v3));
+    gen_gvec_fn_3(orc, ES_8, get_field(s, v1), get_field(s, v2),
+                  get_field(s, v3));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vpopct(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t es =3D get_field(s, m3);
     static const GVecGen2 g[4] =3D {
         { .fno =3D gen_helper_gvec_vpopct8, },
         { .fno =3D gen_helper_gvec_vpopct16, },
@@ -1846,7 +1846,7 @@ static DisasJumpType op_vpopct(DisasContext *s, Disas=
Ops *o)
         return DISAS_NORETURN;
     }
=20
-    gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es])=
;
+    gen_gvec_2(get_field(s, v1), get_field(s, v2), &g[es]);
     return DISAS_NEXT;
 }
=20
@@ -1870,7 +1870,7 @@ static void gen_rll_i64(TCGv_i64 d, TCGv_i64 a, TCGv_=
i64 b)
=20
 static DisasJumpType op_verllv(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     static const GVecGen3 g[4] =3D {
         { .fno =3D gen_helper_gvec_verllv8, },
         { .fno =3D gen_helper_gvec_verllv16, },
@@ -1883,14 +1883,14 @@ static DisasJumpType op_verllv(DisasContext *s, Dis=
asOps *o)
         return DISAS_NORETURN;
     }
=20
-    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), &g[es]);
+    gen_gvec_3(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), &g[es]);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_verll(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     static const GVecGen2s g[4] =3D {
         { .fno =3D gen_helper_gvec_verll8, },
         { .fno =3D gen_helper_gvec_verll16, },
@@ -1902,7 +1902,7 @@ static DisasJumpType op_verll(DisasContext *s, DisasO=
ps *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    gen_gvec_2s(get_field(s->fields, v1), get_field(s->fields, v3), o->add=
r1,
+    gen_gvec_2s(get_field(s, v1), get_field(s, v3), o->addr1,
                 &g[es]);
     return DISAS_NEXT;
 }
@@ -1933,8 +1933,8 @@ static void gen_rim_i64(TCGv_i64 d, TCGv_i64 a, TCGv_=
i64 b, int64_t c)
=20
 static DisasJumpType op_verim(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m5);
-    const uint8_t i4 =3D get_field(s->fields, i4) &
+    const uint8_t es =3D get_field(s, m5);
+    const uint8_t i4 =3D get_field(s, i4) &
                        (NUM_VEC_ELEMENT_BITS(es) - 1);
     static const GVecGen3i g[4] =3D {
         { .fno =3D gen_helper_gvec_verim8, },
@@ -1950,17 +1950,17 @@ static DisasJumpType op_verim(DisasContext *s, Disa=
sOps *o)
         return DISAS_NORETURN;
     }
=20
-    gen_gvec_3i(get_field(s->fields, v1), get_field(s->fields, v2),
-                get_field(s->fields, v3), i4, &g[es]);
+    gen_gvec_3i(get_field(s, v1), get_field(s, v2),
+                get_field(s, v3), i4, &g[es]);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
-    const uint8_t v1 =3D get_field(s->fields, v1);
-    const uint8_t v2 =3D get_field(s->fields, v2);
-    const uint8_t v3 =3D get_field(s->fields, v3);
+    const uint8_t es =3D get_field(s, m4);
+    const uint8_t v1 =3D get_field(s, v1);
+    const uint8_t v2 =3D get_field(s, v2);
+    const uint8_t v3 =3D get_field(s, v3);
=20
     if (es > ES_64) {
         gen_program_exception(s, PGM_SPECIFICATION);
@@ -1985,11 +1985,11 @@ static DisasJumpType op_vesv(DisasContext *s, Disas=
Ops *o)
=20
 static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
-    const uint8_t d2 =3D get_field(s->fields, d2) &
+    const uint8_t es =3D get_field(s, m4);
+    const uint8_t d2 =3D get_field(s, d2) &
                        (NUM_VEC_ELEMENT_BITS(es) - 1);
-    const uint8_t v1 =3D get_field(s->fields, v1);
-    const uint8_t v3 =3D get_field(s->fields, v3);
+    const uint8_t v1 =3D get_field(s, v1);
+    const uint8_t v3 =3D get_field(s, v3);
     TCGv_i32 shift;
=20
     if (es > ES_64) {
@@ -1997,7 +1997,7 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps=
 *o)
         return DISAS_NORETURN;
     }
=20
-    if (likely(!get_field(s->fields, b2))) {
+    if (likely(!get_field(s, b2))) {
         switch (s->fields->op2) {
         case 0x30:
             gen_gvec_fn_2i(shli, es, v1, v3, d2);
@@ -2037,14 +2037,14 @@ static DisasJumpType op_vsl(DisasContext *s, DisasO=
ps *o)
 {
     TCGv_i64 shift =3D tcg_temp_new_i64();
=20
-    read_vec_element_i64(shift, get_field(s->fields, v3), 7, ES_8);
+    read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
     if (s->fields->op2 =3D=3D 0x74) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
     }
=20
-    gen_gvec_2i_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+    gen_gvec_2i_ool(get_field(s, v1), get_field(s, v2),
                     shift, 0, gen_helper_gvec_vsl);
     tcg_temp_free_i64(shift);
     return DISAS_NEXT;
@@ -2052,7 +2052,7 @@ static DisasJumpType op_vsl(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_vsldb(DisasContext *s, DisasOps *o)
 {
-    const uint8_t i4 =3D get_field(s->fields, i4) & 0xf;
+    const uint8_t i4 =3D get_field(s, i4) & 0xf;
     const int left_shift =3D (i4 & 7) * 8;
     const int right_shift =3D 64 - left_shift;
     TCGv_i64 t0 =3D tcg_temp_new_i64();
@@ -2060,18 +2060,18 @@ static DisasJumpType op_vsldb(DisasContext *s, Disa=
sOps *o)
     TCGv_i64 t2 =3D tcg_temp_new_i64();
=20
     if ((i4 & 8) =3D=3D 0) {
-        read_vec_element_i64(t0, get_field(s->fields, v2), 0, ES_64);
-        read_vec_element_i64(t1, get_field(s->fields, v2), 1, ES_64);
-        read_vec_element_i64(t2, get_field(s->fields, v3), 0, ES_64);
+        read_vec_element_i64(t0, get_field(s, v2), 0, ES_64);
+        read_vec_element_i64(t1, get_field(s, v2), 1, ES_64);
+        read_vec_element_i64(t2, get_field(s, v3), 0, ES_64);
     } else {
-        read_vec_element_i64(t0, get_field(s->fields, v2), 1, ES_64);
-        read_vec_element_i64(t1, get_field(s->fields, v3), 0, ES_64);
-        read_vec_element_i64(t2, get_field(s->fields, v3), 1, ES_64);
+        read_vec_element_i64(t0, get_field(s, v2), 1, ES_64);
+        read_vec_element_i64(t1, get_field(s, v3), 0, ES_64);
+        read_vec_element_i64(t2, get_field(s, v3), 1, ES_64);
     }
     tcg_gen_extract2_i64(t0, t1, t0, right_shift);
     tcg_gen_extract2_i64(t1, t2, t1, right_shift);
-    write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
-    write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);
+    write_vec_element_i64(t0, get_field(s, v1), 0, ES_64);
+    write_vec_element_i64(t1, get_field(s, v1), 1, ES_64);
=20
     tcg_temp_free(t0);
     tcg_temp_free(t1);
@@ -2083,14 +2083,14 @@ static DisasJumpType op_vsra(DisasContext *s, Disas=
Ops *o)
 {
     TCGv_i64 shift =3D tcg_temp_new_i64();
=20
-    read_vec_element_i64(shift, get_field(s->fields, v3), 7, ES_8);
+    read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
     if (s->fields->op2 =3D=3D 0x7e) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
     }
=20
-    gen_gvec_2i_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+    gen_gvec_2i_ool(get_field(s, v1), get_field(s, v2),
                     shift, 0, gen_helper_gvec_vsra);
     tcg_temp_free_i64(shift);
     return DISAS_NEXT;
@@ -2100,14 +2100,14 @@ static DisasJumpType op_vsrl(DisasContext *s, Disas=
Ops *o)
 {
     TCGv_i64 shift =3D tcg_temp_new_i64();
=20
-    read_vec_element_i64(shift, get_field(s->fields, v3), 7, ES_8);
+    read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
     if (s->fields->op2 =3D=3D 0x7c) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
     }
=20
-    gen_gvec_2i_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+    gen_gvec_2i_ool(get_field(s, v1), get_field(s, v2),
                     shift, 0, gen_helper_gvec_vsrl);
     tcg_temp_free_i64(shift);
     return DISAS_NEXT;
@@ -2115,18 +2115,18 @@ static DisasJumpType op_vsrl(DisasContext *s, Disas=
Ops *o)
=20
 static DisasJumpType op_vs(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
=20
     if (es > ES_128) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     } else if (es =3D=3D ES_128) {
-        gen_gvec128_3_i64(tcg_gen_sub2_i64, get_field(s->fields, v1),
-                          get_field(s->fields, v2), get_field(s->fields, v=
3));
+        gen_gvec128_3_i64(tcg_gen_sub2_i64, get_field(s, v1),
+                          get_field(s, v2), get_field(s, v3));
         return DISAS_NEXT;
     }
-    gen_gvec_fn_3(sub, es, get_field(s->fields, v1), get_field(s->fields, =
v2),
-                  get_field(s->fields, v3));
+    gen_gvec_fn_3(sub, es, get_field(s, v1), get_field(s, v2),
+                  get_field(s, v3));
     return DISAS_NEXT;
 }
=20
@@ -2162,7 +2162,7 @@ static void gen_scbi2_i64(TCGv_i64 dl, TCGv_i64 dh, T=
CGv_i64 al,
=20
 static DisasJumpType op_vscbi(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     static const GVecGen3 g[4] =3D {
         { .fno =3D gen_helper_gvec_vscbi8, },
         { .fno =3D gen_helper_gvec_vscbi16, },
@@ -2174,12 +2174,12 @@ static DisasJumpType op_vscbi(DisasContext *s, Disa=
sOps *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     } else if (es =3D=3D ES_128) {
-        gen_gvec128_3_i64(gen_scbi2_i64, get_field(s->fields, v1),
-                          get_field(s->fields, v2), get_field(s->fields, v=
3));
+        gen_gvec128_3_i64(gen_scbi2_i64, get_field(s, v1),
+                          get_field(s, v2), get_field(s, v3));
         return DISAS_NEXT;
     }
-    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), &g[es]);
+    gen_gvec_3(get_field(s, v1), get_field(s, v2),
+               get_field(s, v3), &g[es]);
     return DISAS_NEXT;
 }
=20
@@ -2198,14 +2198,14 @@ static void gen_sbi2_i64(TCGv_i64 dl, TCGv_i64 dh, =
TCGv_i64 al, TCGv_i64 ah,
=20
 static DisasJumpType op_vsbi(DisasContext *s, DisasOps *o)
 {
-    if (get_field(s->fields, m5) !=3D ES_128) {
+    if (get_field(s, m5) !=3D ES_128) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
=20
-    gen_gvec128_4_i64(gen_sbi2_i64, get_field(s->fields, v1),
-                      get_field(s->fields, v2), get_field(s->fields, v3),
-                      get_field(s->fields, v4));
+    gen_gvec128_4_i64(gen_sbi2_i64, get_field(s, v1),
+                      get_field(s, v2), get_field(s, v3),
+                      get_field(s, v4));
     return DISAS_NEXT;
 }
=20
@@ -2225,20 +2225,20 @@ static void gen_sbcbi2_i64(TCGv_i64 dl, TCGv_i64 dh=
, TCGv_i64 al, TCGv_i64 ah,
=20
 static DisasJumpType op_vsbcbi(DisasContext *s, DisasOps *o)
 {
-    if (get_field(s->fields, m5) !=3D ES_128) {
+    if (get_field(s, m5) !=3D ES_128) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
=20
-    gen_gvec128_4_i64(gen_sbcbi2_i64, get_field(s->fields, v1),
-                      get_field(s->fields, v2), get_field(s->fields, v3),
-                      get_field(s->fields, v4));
+    gen_gvec128_4_i64(gen_sbcbi2_i64, get_field(s, v1),
+                      get_field(s, v2), get_field(s, v3),
+                      get_field(s, v4));
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vsumg(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     TCGv_i64 sum, tmp;
     uint8_t dst_idx;
=20
@@ -2253,12 +2253,12 @@ static DisasJumpType op_vsumg(DisasContext *s, Disa=
sOps *o)
         uint8_t idx =3D dst_idx * NUM_VEC_ELEMENTS(es) / 2;
         const uint8_t max_idx =3D idx + NUM_VEC_ELEMENTS(es) / 2 - 1;
=20
-        read_vec_element_i64(sum, get_field(s->fields, v3), max_idx, es);
+        read_vec_element_i64(sum, get_field(s, v3), max_idx, es);
         for (; idx <=3D max_idx; idx++) {
-            read_vec_element_i64(tmp, get_field(s->fields, v2), idx, es);
+            read_vec_element_i64(tmp, get_field(s, v2), idx, es);
             tcg_gen_add_i64(sum, sum, tmp);
         }
-        write_vec_element_i64(sum, get_field(s->fields, v1), dst_idx, ES_6=
4);
+        write_vec_element_i64(sum, get_field(s, v1), dst_idx, ES_64);
     }
     tcg_temp_free_i64(sum);
     tcg_temp_free_i64(tmp);
@@ -2267,7 +2267,7 @@ static DisasJumpType op_vsumg(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_vsumq(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     const uint8_t max_idx =3D NUM_VEC_ELEMENTS(es) - 1;
     TCGv_i64 sumh, suml, zero, tmpl;
     uint8_t idx;
@@ -2282,13 +2282,13 @@ static DisasJumpType op_vsumq(DisasContext *s, Disa=
sOps *o)
     zero =3D tcg_const_i64(0);
     tmpl =3D tcg_temp_new_i64();
=20
-    read_vec_element_i64(suml, get_field(s->fields, v3), max_idx, es);
+    read_vec_element_i64(suml, get_field(s, v3), max_idx, es);
     for (idx =3D 0; idx <=3D max_idx; idx++) {
-        read_vec_element_i64(tmpl, get_field(s->fields, v2), idx, es);
+        read_vec_element_i64(tmpl, get_field(s, v2), idx, es);
         tcg_gen_add2_i64(suml, sumh, suml, sumh, tmpl, zero);
     }
-    write_vec_element_i64(sumh, get_field(s->fields, v1), 0, ES_64);
-    write_vec_element_i64(suml, get_field(s->fields, v1), 1, ES_64);
+    write_vec_element_i64(sumh, get_field(s, v1), 0, ES_64);
+    write_vec_element_i64(suml, get_field(s, v1), 1, ES_64);
=20
     tcg_temp_free_i64(sumh);
     tcg_temp_free_i64(suml);
@@ -2299,7 +2299,7 @@ static DisasJumpType op_vsumq(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_vsum(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t es =3D get_field(s, m4);
     TCGv_i32 sum, tmp;
     uint8_t dst_idx;
=20
@@ -2314,12 +2314,12 @@ static DisasJumpType op_vsum(DisasContext *s, Disas=
Ops *o)
         uint8_t idx =3D dst_idx * NUM_VEC_ELEMENTS(es) / 4;
         const uint8_t max_idx =3D idx + NUM_VEC_ELEMENTS(es) / 4 - 1;
=20
-        read_vec_element_i32(sum, get_field(s->fields, v3), max_idx, es);
+        read_vec_element_i32(sum, get_field(s, v3), max_idx, es);
         for (; idx <=3D max_idx; idx++) {
-            read_vec_element_i32(tmp, get_field(s->fields, v2), idx, es);
+            read_vec_element_i32(tmp, get_field(s, v2), idx, es);
             tcg_gen_add_i32(sum, sum, tmp);
         }
-        write_vec_element_i32(sum, get_field(s->fields, v1), dst_idx, ES_3=
2);
+        write_vec_element_i32(sum, get_field(s, v1), dst_idx, ES_32);
     }
     tcg_temp_free_i32(sum);
     tcg_temp_free_i32(tmp);
@@ -2328,7 +2328,7 @@ static DisasJumpType op_vsum(DisasContext *s, DisasOp=
s *o)
=20
 static DisasJumpType op_vtm(DisasContext *s, DisasOps *o)
 {
-    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+    gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2),
                    cpu_env, 0, gen_helper_gvec_vtm);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -2336,8 +2336,8 @@ static DisasJumpType op_vtm(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_vfae(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
-    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint8_t es =3D get_field(s, m4);
+    const uint8_t m5 =3D get_field(s, m5);
     static gen_helper_gvec_3 * const g[3] =3D {
         gen_helper_gvec_vfae8,
         gen_helper_gvec_vfae16,
@@ -2354,20 +2354,20 @@ static DisasJumpType op_vfae(DisasContext *s, Disas=
Ops *o)
     }
=20
     if (extract32(m5, 0, 1)) {
-        gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
-                       get_field(s->fields, v3), cpu_env, m5, g_cc[es]);
+        gen_gvec_3_ptr(get_field(s, v1), get_field(s, v2),
+                       get_field(s, v3), cpu_env, m5, g_cc[es]);
         set_cc_static(s);
     } else {
-        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2),
-                       get_field(s->fields, v3), m5, g[es]);
+        gen_gvec_3_ool(get_field(s, v1), get_field(s, v2),
+                       get_field(s, v3), m5, g[es]);
     }
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vfee(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
-    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint8_t es =3D get_field(s, m4);
+    const uint8_t m5 =3D get_field(s, m5);
     static gen_helper_gvec_3 * const g[3] =3D {
         gen_helper_gvec_vfee8,
         gen_helper_gvec_vfee16,
@@ -2385,20 +2385,20 @@ static DisasJumpType op_vfee(DisasContext *s, Disas=
Ops *o)
     }
=20
     if (extract32(m5, 0, 1)) {
-        gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
-                       get_field(s->fields, v3), cpu_env, m5, g_cc[es]);
+        gen_gvec_3_ptr(get_field(s, v1), get_field(s, v2),
+                       get_field(s, v3), cpu_env, m5, g_cc[es]);
         set_cc_static(s);
     } else {
-        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2),
-                       get_field(s->fields, v3), m5, g[es]);
+        gen_gvec_3_ool(get_field(s, v1), get_field(s, v2),
+                       get_field(s, v3), m5, g[es]);
     }
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vfene(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
-    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint8_t es =3D get_field(s, m4);
+    const uint8_t m5 =3D get_field(s, m5);
     static gen_helper_gvec_3 * const g[3] =3D {
         gen_helper_gvec_vfene8,
         gen_helper_gvec_vfene16,
@@ -2416,20 +2416,20 @@ static DisasJumpType op_vfene(DisasContext *s, Disa=
sOps *o)
     }
=20
     if (extract32(m5, 0, 1)) {
-        gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
-                       get_field(s->fields, v3), cpu_env, m5, g_cc[es]);
+        gen_gvec_3_ptr(get_field(s, v1), get_field(s, v2),
+                       get_field(s, v3), cpu_env, m5, g_cc[es]);
         set_cc_static(s);
     } else {
-        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2),
-                       get_field(s->fields, v3), m5, g[es]);
+        gen_gvec_3_ool(get_field(s, v1), get_field(s, v2),
+                       get_field(s, v3), m5, g[es]);
     }
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vistr(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m4);
-    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint8_t es =3D get_field(s, m4);
+    const uint8_t m5 =3D get_field(s, m5);
     static gen_helper_gvec_2 * const g[3] =3D {
         gen_helper_gvec_vistr8,
         gen_helper_gvec_vistr16,
@@ -2447,11 +2447,11 @@ static DisasJumpType op_vistr(DisasContext *s, Disa=
sOps *o)
     }
=20
     if (extract32(m5, 0, 1)) {
-        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+        gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2),
                        cpu_env, 0, g_cc[es]);
         set_cc_static(s);
     } else {
-        gen_gvec_2_ool(get_field(s->fields, v1), get_field(s->fields, v2),=
 0,
+        gen_gvec_2_ool(get_field(s, v1), get_field(s, v2), 0,
                        g[es]);
     }
     return DISAS_NEXT;
@@ -2459,8 +2459,8 @@ static DisasJumpType op_vistr(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_vstrc(DisasContext *s, DisasOps *o)
 {
-    const uint8_t es =3D get_field(s->fields, m5);
-    const uint8_t m6 =3D get_field(s->fields, m6);
+    const uint8_t es =3D get_field(s, m5);
+    const uint8_t m6 =3D get_field(s, m6);
     static gen_helper_gvec_4 * const g[3] =3D {
         gen_helper_gvec_vstrc8,
         gen_helper_gvec_vstrc16,
@@ -2489,23 +2489,23 @@ static DisasJumpType op_vstrc(DisasContext *s, Disa=
sOps *o)
=20
     if (extract32(m6, 0, 1)) {
         if (extract32(m6, 2, 1)) {
-            gen_gvec_4_ptr(get_field(s->fields, v1), get_field(s->fields, =
v2),
-                           get_field(s->fields, v3), get_field(s->fields, =
v4),
+            gen_gvec_4_ptr(get_field(s, v1), get_field(s, v2),
+                           get_field(s, v3), get_field(s, v4),
                            cpu_env, m6, g_cc_rt[es]);
         } else {
-            gen_gvec_4_ptr(get_field(s->fields, v1), get_field(s->fields, =
v2),
-                           get_field(s->fields, v3), get_field(s->fields, =
v4),
+            gen_gvec_4_ptr(get_field(s, v1), get_field(s, v2),
+                           get_field(s, v3), get_field(s, v4),
                            cpu_env, m6, g_cc[es]);
         }
         set_cc_static(s);
     } else {
         if (extract32(m6, 2, 1)) {
-            gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, =
v2),
-                           get_field(s->fields, v3), get_field(s->fields, =
v4),
+            gen_gvec_4_ool(get_field(s, v1), get_field(s, v2),
+                           get_field(s, v3), get_field(s, v4),
                            m6, g_rt[es]);
         } else {
-            gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, =
v2),
-                           get_field(s->fields, v3), get_field(s->fields, =
v4),
+            gen_gvec_4_ool(get_field(s, v1), get_field(s, v2),
+                           get_field(s, v3), get_field(s, v4),
                            m6, g[es]);
         }
     }
@@ -2514,8 +2514,8 @@ static DisasJumpType op_vstrc(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_vfa(DisasContext *s, DisasOps *o)
 {
-    const uint8_t fpf =3D get_field(s->fields, m4);
-    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint8_t fpf =3D get_field(s, m4);
+    const uint8_t m5 =3D get_field(s, m5);
     const bool se =3D extract32(m5, 3, 1);
     gen_helper_gvec_3_ptr *fn;
=20
@@ -2540,15 +2540,15 @@ static DisasJumpType op_vfa(DisasContext *s, DisasO=
ps *o)
     default:
         g_assert_not_reached();
     }
-    gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
-                   get_field(s->fields, v3), cpu_env, 0, fn);
+    gen_gvec_3_ptr(get_field(s, v1), get_field(s, v2),
+                   get_field(s, v3), cpu_env, 0, fn);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_wfc(DisasContext *s, DisasOps *o)
 {
-    const uint8_t fpf =3D get_field(s->fields, m3);
-    const uint8_t m4 =3D get_field(s->fields, m4);
+    const uint8_t fpf =3D get_field(s, m3);
+    const uint8_t m4 =3D get_field(s, m4);
=20
     if (fpf !=3D FPF_LONG || m4) {
         gen_program_exception(s, PGM_SPECIFICATION);
@@ -2556,10 +2556,10 @@ static DisasJumpType op_wfc(DisasContext *s, DisasO=
ps *o)
     }
=20
     if (s->fields->op2 =3D=3D 0xcb) {
-        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+        gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2),
                        cpu_env, 0, gen_helper_gvec_wfc64);
     } else {
-        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+        gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2),
                        cpu_env, 0, gen_helper_gvec_wfk64);
     }
     set_cc_static(s);
@@ -2568,9 +2568,9 @@ static DisasJumpType op_wfc(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_vfc(DisasContext *s, DisasOps *o)
 {
-    const uint8_t fpf =3D get_field(s->fields, m4);
-    const uint8_t m5 =3D get_field(s->fields, m5);
-    const uint8_t m6 =3D get_field(s->fields, m6);
+    const uint8_t fpf =3D get_field(s, m4);
+    const uint8_t m5 =3D get_field(s, m5);
+    const uint8_t m6 =3D get_field(s, m6);
     const bool se =3D extract32(m5, 3, 1);
     const bool cs =3D extract32(m6, 0, 1);
     gen_helper_gvec_3_ptr *fn;
@@ -2609,8 +2609,8 @@ static DisasJumpType op_vfc(DisasContext *s, DisasOps=
 *o)
             g_assert_not_reached();
         }
     }
-    gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
-                   get_field(s->fields, v3), cpu_env, 0, fn);
+    gen_gvec_3_ptr(get_field(s, v1), get_field(s, v2),
+                   get_field(s, v3), cpu_env, 0, fn);
     if (cs) {
         set_cc_static(s);
     }
@@ -2619,9 +2619,9 @@ static DisasJumpType op_vfc(DisasContext *s, DisasOps=
 *o)
=20
 static DisasJumpType op_vcdg(DisasContext *s, DisasOps *o)
 {
-    const uint8_t fpf =3D get_field(s->fields, m3);
-    const uint8_t m4 =3D get_field(s->fields, m4);
-    const uint8_t erm =3D get_field(s->fields, m5);
+    const uint8_t fpf =3D get_field(s, m3);
+    const uint8_t m4 =3D get_field(s, m4);
+    const uint8_t erm =3D get_field(s, m5);
     const bool se =3D extract32(m4, 3, 1);
     gen_helper_gvec_2_ptr *fn;
=20
@@ -2652,15 +2652,15 @@ static DisasJumpType op_vcdg(DisasContext *s, Disas=
Ops *o)
     default:
         g_assert_not_reached();
     }
-    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), cpu=
_env,
+    gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env,
                    deposit32(m4, 4, 4, erm), fn);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vfll(DisasContext *s, DisasOps *o)
 {
-    const uint8_t fpf =3D get_field(s->fields, m3);
-    const uint8_t m4 =3D get_field(s->fields, m4);
+    const uint8_t fpf =3D get_field(s, m3);
+    const uint8_t m4 =3D get_field(s, m4);
     gen_helper_gvec_2_ptr *fn =3D gen_helper_gvec_vfll32;
=20
     if (fpf !=3D FPF_SHORT || extract32(m4, 0, 3)) {
@@ -2671,15 +2671,15 @@ static DisasJumpType op_vfll(DisasContext *s, Disas=
Ops *o)
     if (extract32(m4, 3, 1)) {
         fn =3D gen_helper_gvec_vfll32s;
     }
-    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), cpu=
_env,
+    gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env,
                    0, fn);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vfma(DisasContext *s, DisasOps *o)
 {
-    const uint8_t m5 =3D get_field(s->fields, m5);
-    const uint8_t fpf =3D get_field(s->fields, m6);
+    const uint8_t m5 =3D get_field(s, m5);
+    const uint8_t fpf =3D get_field(s, m6);
     const bool se =3D extract32(m5, 3, 1);
     gen_helper_gvec_4_ptr *fn;
=20
@@ -2693,19 +2693,19 @@ static DisasJumpType op_vfma(DisasContext *s, Disas=
Ops *o)
     } else {
         fn =3D se ? gen_helper_gvec_vfms64s : gen_helper_gvec_vfms64;
     }
-    gen_gvec_4_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
-                   get_field(s->fields, v3), get_field(s->fields, v4), cpu=
_env,
+    gen_gvec_4_ptr(get_field(s, v1), get_field(s, v2),
+                   get_field(s, v3), get_field(s, v4), cpu_env,
                    0, fn);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vfpso(DisasContext *s, DisasOps *o)
 {
-    const uint8_t v1 =3D get_field(s->fields, v1);
-    const uint8_t v2 =3D get_field(s->fields, v2);
-    const uint8_t fpf =3D get_field(s->fields, m3);
-    const uint8_t m4 =3D get_field(s->fields, m4);
-    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint8_t v1 =3D get_field(s, v1);
+    const uint8_t v2 =3D get_field(s, v2);
+    const uint8_t fpf =3D get_field(s, m3);
+    const uint8_t m4 =3D get_field(s, m4);
+    const uint8_t m5 =3D get_field(s, m5);
     TCGv_i64 tmp;
=20
     if (fpf !=3D FPF_LONG || extract32(m4, 0, 3) || m5 > 2) {
@@ -2753,8 +2753,8 @@ static DisasJumpType op_vfpso(DisasContext *s, DisasO=
ps *o)
=20
 static DisasJumpType op_vfsq(DisasContext *s, DisasOps *o)
 {
-    const uint8_t fpf =3D get_field(s->fields, m3);
-    const uint8_t m4 =3D get_field(s->fields, m4);
+    const uint8_t fpf =3D get_field(s, m3);
+    const uint8_t m4 =3D get_field(s, m4);
     gen_helper_gvec_2_ptr *fn =3D gen_helper_gvec_vfsq64;
=20
     if (fpf !=3D FPF_LONG || extract32(m4, 0, 3)) {
@@ -2765,16 +2765,16 @@ static DisasJumpType op_vfsq(DisasContext *s, Disas=
Ops *o)
     if (extract32(m4, 3, 1)) {
         fn =3D gen_helper_gvec_vfsq64s;
     }
-    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), cpu=
_env,
+    gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env,
                    0, fn);
     return DISAS_NEXT;
 }
=20
 static DisasJumpType op_vftci(DisasContext *s, DisasOps *o)
 {
-    const uint16_t i3 =3D get_field(s->fields, i3);
-    const uint8_t fpf =3D get_field(s->fields, m4);
-    const uint8_t m5 =3D get_field(s->fields, m5);
+    const uint16_t i3 =3D get_field(s, i3);
+    const uint8_t fpf =3D get_field(s, m4);
+    const uint8_t m5 =3D get_field(s, m5);
     gen_helper_gvec_2_ptr *fn =3D gen_helper_gvec_vftci64;
=20
     if (fpf !=3D FPF_LONG || extract32(m5, 0, 3)) {
@@ -2785,8 +2785,7 @@ static DisasJumpType op_vftci(DisasContext *s, DisasO=
ps *o)
     if (extract32(m5, 3, 1)) {
         fn =3D gen_helper_gvec_vftci64s;
     }
-    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), cpu=
_env,
-                   i3, fn);
+    gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env, i3, fn);
     set_cc_static(s);
     return DISAS_NEXT;
 }
--=20
2.21.1


