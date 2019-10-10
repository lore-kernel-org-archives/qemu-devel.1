Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE97C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CB6206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CB6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWvd-0002tP-LE
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWiY-000415-39
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWiW-0005uf-Nj
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWiW-0005uE-FH; Thu, 10 Oct 2019 07:34:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7A6A10C0925;
 Thu, 10 Oct 2019 11:34:47 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1A6F5C1B5;
 Thu, 10 Oct 2019 11:34:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 13/31] target/s390x: Add ilen to unwind data
Date: Thu, 10 Oct 2019 13:33:38 +0200
Message-Id: <20191010113356.5017-14-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 10 Oct 2019 11:34:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

Use ILEN_UNWIND to signal that we have in fact that cpu_restore_state
will have been called by the time we arrive in do_program_interrupt.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20191001171614.8405-2-richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h       |  4 +++-
 target/s390x/interrupt.c |  5 ++++-
 target/s390x/translate.c | 20 +++++++++++++++++---
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b907741858..1a5b1397da 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -34,7 +34,7 @@
 /* The z/Architecture has a strong memory model with some store-after-lo=
ad re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
=20
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
=20
 #define MMU_MODE0_SUFFIX _primary
 #define MMU_MODE1_SUFFIX _secondary
@@ -804,6 +804,8 @@ int cpu_s390x_signal_handler(int host_signum, void *p=
info, void *puc);
 void s390_crw_mchk(void);
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
+/* instruction length set by unwind info */
+#define ILEN_UNWIND                 0
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 #define RA_IGNORED                  0
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index a841f7187d..30a9fb8852 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -28,7 +28,10 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_=
t code, uint32_t ilen)
=20
     cs->exception_index =3D EXCP_PGM;
     env->int_pgm_code =3D code;
-    env->int_pgm_ilen =3D ilen;
+    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
+    if (ilen !=3D ILEN_UNWIND) {
+        env->int_pgm_ilen =3D ilen;
+    }
 }
=20
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a3e43ff9ec..151dfa91fb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6309,6 +6309,9 @@ static DisasJumpType translate_one(CPUS390XState *e=
nv, DisasContext *s)
     /* Search for the insn in the table.  */
     insn =3D extract_insn(env, s, &f);
=20
+    /* Emit insn_start now that we know the ILEN.  */
+    tcg_gen_insn_start(s->base.pc_next, s->cc_op, s->ilen);
+
     /* Not found means unimplemented/illegal opcode.  */
     if (insn =3D=3D NULL) {
         qemu_log_mask(LOG_UNIMP, "unimplemented opcode 0x%02x%02x\n",
@@ -6463,9 +6466,6 @@ static void s390x_tr_tb_start(DisasContextBase *db,=
 CPUState *cs)
=20
 static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
-    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
-
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
 }
=20
 static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState=
 *cs,
@@ -6473,6 +6473,14 @@ static bool s390x_tr_breakpoint_check(DisasContext=
Base *dcbase, CPUState *cs,
 {
     DisasContext *dc =3D container_of(dcbase, DisasContext, base);
=20
+    /*
+     * Emit an insn_start to accompany the breakpoint exception.
+     * The ILEN value is a dummy, since this does not result in
+     * an s390x exception, but an internal qemu exception which
+     * brings us back to interact with the gdbstub.
+     */
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 2);
+
     dc->base.is_jmp =3D DISAS_PC_STALE;
     dc->do_debug =3D true;
     /* The address covered by the breakpoint must be included in
@@ -6567,8 +6575,14 @@ void restore_state_to_opc(CPUS390XState *env, Tran=
slationBlock *tb,
                           target_ulong *data)
 {
     int cc_op =3D data[1];
+
     env->psw.addr =3D data[0];
+
+    /* Update the CC opcode if it is not already up-to-date.  */
     if ((cc_op !=3D CC_OP_DYNAMIC) && (cc_op !=3D CC_OP_STATIC)) {
         env->cc_op =3D cc_op;
     }
+
+    /* Record ILEN.  */
+    env->int_pgm_ilen =3D data[2];
 }
--=20
2.21.0


