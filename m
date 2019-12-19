Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B669C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAD0222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1Wwtpw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAD0222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihthZ-00024b-2a
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihtYj-0006fv-PM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihtYi-0000Ma-5S
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51007
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihtYh-0000IA-Tq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576753291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIeGxDzPPfjt2yoiWN9A5KRxsOXYS9OSgM4V3ajWsN0=;
 b=h1Wwtpw/Gx/fJpQ9b2nXAfo69aNqtRipfqZchh8ilL4ypmeO4X+UOtX3pPfSXf9A6vwlkq
 aGGodlPiw/NysxwU1mLiuETnKatC/Lu/vRJovH6f9V9tikWPRa7djgQkPJ8abPY0aIaGCX
 TSyur5RR4pC8xVYf01XnCpiRbTthdx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-yUnTq2hPMs2h0mOXz6244g-1; Thu, 19 Dec 2019 06:01:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02B57593AB;
 Thu, 19 Dec 2019 11:01:26 +0000 (UTC)
Received: from localhost (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4510363B92;
 Thu, 19 Dec 2019 11:01:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/6] target/s390x: Implement LOAD/STORE TO REAL ADDRESS inline
Date: Thu, 19 Dec 2019 12:01:08 +0100
Message-Id: <20191219110112.8343-3-cohuck@redhat.com>
In-Reply-To: <20191219110112.8343-1-cohuck@redhat.com>
References: <20191219110112.8343-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: yUnTq2hPMs2h0mOXz6244g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

These are trivially done by performing a memory operation
with the correct mmu_idx.  The only tricky part is using
get_address directly in order to get the address wrapped;
we cannot use la2 because of the format.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191211203614.15611-3-richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h      |  4 ----
 target/s390x/insn-data.def |  8 ++++----
 target/s390x/mem_helper.c  | 22 ----------------------
 target/s390x/translate.c   | 21 ++++-----------------
 4 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index f5b4bb6a316b..b5813c2ac2b9 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -324,10 +324,6 @@ DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i=
64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(lra, i64, env, i64)
-DEF_HELPER_FLAGS_2(lura, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_2(lurag, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_3(stura, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 449eee1662d0..2bc77f087102 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1275,8 +1275,8 @@
     F(0xe313, LRAY,    RXY_a, LD,  0, a2, r1, 0, lra, 0, IF_PRIV)
     F(0xe303, LRAG,    RXY_a, Z,   0, a2, r1, 0, lra, 0, IF_PRIV)
 /* LOAD USING REAL ADDRESS */
-    F(0xb24b, LURA,    RRE,   Z,   0, r2, new, r1_32, lura, 0, IF_PRIV)
-    F(0xb905, LURAG,   RRE,   Z,   0, r2, r1, 0, lurag, 0, IF_PRIV)
+    E(0xb24b, LURA,    RRE,   Z,   0, 0, new, r1_32, lura, 0, MO_TEUL, IF_=
PRIV)
+    E(0xb905, LURAG,   RRE,   Z,   0, 0, r1, 0, lura, 0, MO_TEQ, IF_PRIV)
 /* MOVE TO PRIMARY */
     F(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0, IF_PRIV)
 /* MOVE TO SECONDARY */
@@ -1329,8 +1329,8 @@
 /* STORE THEN OR SYSTEM MASK */
     F(0xad00, STOSM,   SI,    Z,   la1, 0, 0, 0, stnosm, 0, IF_PRIV)
 /* STORE USING REAL ADDRESS */
-    F(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0, IF_PRIV)
-    F(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0, IF_PRIV)
+    E(0xb246, STURA,   RRE,   Z,   r1_o, 0, 0, 0, stura, 0, MO_TEUL, IF_PR=
IV)
+    E(0xb925, STURG,   RRE,   Z,   r1_o, 0, 0, 0, stura, 0, MO_TEQ, IF_PRI=
V)
 /* TEST BLOCK */
     F(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0, IF_PRIV)
 /* TEST PROTECTION */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b1b3f406c9e0..2921419c27cd 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2329,28 +2329,6 @@ void HELPER(purge)(CPUS390XState *env)
     tlb_flush_all_cpus_synced(env_cpu(env));
 }
=20
-/* load using real address */
-uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
-{
-    return cpu_ldl_real_ra(env, wrap_address(env, addr), GETPC());
-}
-
-uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
-{
-    return cpu_ldq_real_ra(env, wrap_address(env, addr), GETPC());
-}
-
-/* store using real address */
-void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
-{
-    cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
-}
-
-void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
-{
-    cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
-}
-
 /* load real address */
 uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ef751fefa4e5..4292bb0dd078 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3272,13 +3272,8 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOp=
s *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
 {
-    gen_helper_lura(o->out, cpu_env, o->in2);
-    return DISAS_NEXT;
-}
-
-static DisasJumpType op_lurag(DisasContext *s, DisasOps *o)
-{
-    gen_helper_lurag(o->out, cpu_env, o->in2);
+    o->addr1 =3D get_address(s, 0, get_field(s->fields, r2), 0);
+    tcg_gen_qemu_ld_tl(o->out, o->addr1, MMU_REAL_IDX, s->insn->data);
     return DISAS_NEXT;
 }
 #endif
@@ -4506,17 +4501,9 @@ static DisasJumpType op_stnosm(DisasContext *s, Disa=
sOps *o)
=20
 static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
-    gen_helper_stura(cpu_env, o->in2, o->in1);
-    if (s->base.tb->flags & FLAG_MASK_PER) {
-        update_psw_addr(s);
-        gen_helper_per_store_real(cpu_env);
-    }
-    return DISAS_NEXT;
-}
+    o->addr1 =3D get_address(s, 0, get_field(s->fields, r2), 0);
+    tcg_gen_qemu_st_tl(o->in1, o->addr1, MMU_REAL_IDX, s->insn->data);
=20
-static DisasJumpType op_sturg(DisasContext *s, DisasOps *o)
-{
-    gen_helper_sturg(cpu_env, o->in2, o->in1);
     if (s->base.tb->flags & FLAG_MASK_PER) {
         update_psw_addr(s);
         gen_helper_per_store_real(cpu_env);
--=20
2.21.0


