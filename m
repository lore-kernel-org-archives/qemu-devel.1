Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F061D217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F061D217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwRC-0001mK-ID
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvsa-0006Ji-IB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvlN-0000hu-3X
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvlM-0000gp-SW; Thu, 19 Sep 2019 08:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33E7810DCC82;
 Thu, 19 Sep 2019 12:42:20 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83FFF60167;
 Thu, 19 Sep 2019 12:42:17 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:40:55 +0200
Message-Id: <20190919124115.11510-15-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 19 Sep 2019 12:42:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/34] s390x/tcg: MVST: Fix storing back the
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

24 and 31-bit address space handling is wrong when it comes to storing
back the addresses to the register.

While at it, read gprs 0 implicitly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      |  2 +-
 target/s390x/insn-data.def |  2 +-
 target/s390x/mem_helper.c  | 26 +++++++++++---------------
 target/s390x/translate.c   |  8 ++++++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index e9aff83b05d3..56e8149866f4 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32,=
 i64, i64)
 DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvpg, TCG_CALL_NO_WG, i32, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mvz, TCG_CALL_NO_WG, void, env, i32, i64, i64)
-DEF_HELPER_4(mvst, i64, env, i64, i64, i64)
+DEF_HELPER_3(mvst, i32, env, i32, i32)
 DEF_HELPER_4(ex, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(stam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f421184fcd53..449eee1662d0 100644
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
index ec27be174b20..a24506676b8d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -700,18 +700,18 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t =
r0, uint64_t r1, uint64_t r2)
     return 0; /* data moved */
 }
=20
-/* string copy (c is string terminator) */
-uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64=
_t s)
+/* string copy */
+uint32_t HELPER(mvst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
+    const uint64_t d =3D get_address(env, r1);
+    const uint64_t s =3D get_address(env, r2);
+    const uint8_t c =3D env->regs[0];
     uintptr_t ra =3D GETPC();
     uint32_t len;
=20
-    if (c & 0xffffff00ull) {
+    if (env->regs[0] & 0xffffff00ull) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
     }
-    c =3D c & 0xff;
-    d =3D wrap_address(env, d);
-    s =3D wrap_address(env, s);
=20
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  *=
/
@@ -719,17 +719,13 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t =
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
index 2927247c82f5..b0a2500e5f36 100644
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
+    gen_helper_mvst(cc_op, cpu_env, t1, t2);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t2);
     set_cc_static(s);
-    return_low128(o->in2);
     return DISAS_NEXT;
 }
=20
--=20
2.20.1


