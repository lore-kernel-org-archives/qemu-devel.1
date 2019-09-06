Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FCC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31AD0206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AD0206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69JH-0007rr-PF
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i698a-0003zI-6v
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i698X-0003MF-Tp
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i698X-0003Kt-Dx; Fri, 06 Sep 2019 03:58:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6220B875220;
 Fri,  6 Sep 2019 07:58:28 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B689A1001284;
 Fri,  6 Sep 2019 07:58:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:35 +0200
Message-Id: <20190906075750.14791-14-david@redhat.com>
In-Reply-To: <20190906075750.14791-1-david@redhat.com>
References: <20190906075750.14791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 06 Sep 2019 07:58:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 13/28] s390x/tcg: MVST: Fix storing back the
 addresses to registers
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24 and 31-bit address space handling is wrong when it comes to storing
back the addresses to the register.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      |  2 +-
 target/s390x/insn-data.def |  2 +-
 target/s390x/mem_helper.c  | 20 ++++++++------------
 target/s390x/translate.c   |  8 ++++++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index e9aff83b05..b32fce22ca 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32,=
 i64, i64)
 DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvpg, TCG_CALL_NO_WG, i32, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mvz, TCG_CALL_NO_WG, void, env, i32, i64, i64)
-DEF_HELPER_4(mvst, i64, env, i64, i64, i64)
+DEF_HELPER_4(mvst, i32, env, i64, i32, i32)
 DEF_HELPER_4(ex, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(stam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f421184fcd..449eee1662 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -637,7 +637,7 @@
 /* MOVE PAGE */
     C(0xb254, MVPG,    RRE,   Z,   r1_o, r2_o, 0, 0, mvpg, 0)
 /* MOVE STRING */
-    C(0xb255, MVST,    RRE,   Z,   r1_o, r2_o, 0, 0, mvst, 0)
+    C(0xb255, MVST,    RRE,   Z,   0, 0, 0, 0, mvst, 0)
 /* MOVE WITH OPTIONAL SPECIFICATION */
     C(0xc800, MVCOS,   SSF,   MVCOS, la1, a2, 0, 0, mvcos, 0)
 /* MOVE WITH OFFSET */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index afcd452a00..8dd58b3ab1 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -694,8 +694,10 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r=
0, uint64_t r1, uint64_t r2)
 }
=20
 /* string copy (c is string terminator) */
-uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64=
_t s)
+uint32_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint32_t r1, uint3=
2_t r2)
 {
+    const uint64_t d =3D get_address(env, r1);
+    const uint64_t s =3D get_address(env, r2);
     uintptr_t ra =3D GETPC();
     uint32_t len;
=20
@@ -703,8 +705,6 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c,=
 uint64_t d, uint64_t s)
         s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
     }
     c =3D c & 0xff;
-    d =3D wrap_address(env, d);
-    s =3D wrap_address(env, s);
=20
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  *=
/
@@ -712,17 +712,13 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t =
c, uint64_t d, uint64_t s)
         uint8_t v =3D cpu_ldub_data_ra(env, s + len, ra);
         cpu_stb_data_ra(env, d + len, v, ra);
         if (v =3D=3D c) {
-            /* Complete.  Set CC=3D1 and advance R1.  */
-            env->cc_op =3D 1;
-            env->retxl =3D s;
-            return d + len;
+            set_address_zero(env, r1, d + len);
+            return 1;
         }
     }
-
-    /* Incomplete.  Set CC=3D3 and signal to advance R1 and R2.  */
-    env->cc_op =3D 3;
-    env->retxl =3D s + len;
-    return d + len;
+    set_address_zero(env, r1, d + len);
+    set_address_zero(env, r2, s + len);
+    return 3;
 }
=20
 /* load access registers r1 to r3 from memory at a2 */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 2927247c82..b76e10d832 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3488,9 +3488,13 @@ static DisasJumpType op_mvpg(DisasContext *s, Disa=
sOps *o)
=20
 static DisasJumpType op_mvst(DisasContext *s, DisasOps *o)
 {
-    gen_helper_mvst(o->in1, cpu_env, regs[0], o->in1, o->in2);
+    TCGv_i32 t1 =3D tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 t2 =3D tcg_const_i32(get_field(s->fields, r2));
+
+    gen_helper_mvst(cc_op, cpu_env, regs[0], t1, t2);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t2);
     set_cc_static(s);
-    return_low128(o->in2);
     return DISAS_NEXT;
 }
=20
--=20
2.21.0


