Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5289DC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BDF2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BDF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPvK-0004aJ-6d
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kYPtu-00045w-Ks
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:36:46 -0400
Received: from mail.ispras.ru ([83.149.199.84]:57918)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kYPtr-0002oG-EC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:36:46 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id C87FB40D3BFF;
 Fri, 30 Oct 2020 08:36:37 +0000 (UTC)
Subject: [PATCH] target/s390x: fix execution with icount
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Fri, 30 Oct 2020 11:36:37 +0300
Message-ID: <160404699734.17100.6515653500382355060.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 04:36:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: david@redhat.com, thuth@redhat.com, cohuck@redhat.com,
 pavel.dovgalyuk@ispras.ru, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds some gen_io_start() calls to allow execution
of s390x targets in icount mode with -smp 1.
It enables deterministic timers and record/replay features.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
---
 0 files changed

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ac10f42f10..7b9dfea615 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2398,13 +2398,17 @@ static DisasJumpType op_diag(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s, r3));
     TCGv_i32 func_code = tcg_const_i32(get_field(s, i2));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     gen_helper_diag(cpu_env, r1, r3, func_code);
 
     tcg_temp_free_i32(func_code);
     tcg_temp_free_i32(r3);
     tcg_temp_free_i32(r1);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 #endif
 
@@ -4069,20 +4073,28 @@ static DisasJumpType op_sqxb(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_servc(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_servc(cc_op, cpu_env, o->in2, o->in1);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_sigp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s, r3));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_sigp(cc_op, cpu_env, o->in2, r1, r3);
     set_cc_static(s);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 #endif
 
@@ -4226,6 +4238,10 @@ static DisasJumpType op_ectg(DisasContext *s, DisasOps *o)
     int d2 = get_field(s, d2);
     int r3 = get_field(s, r3);
     TCGv_i64 tmp = tcg_temp_new_i64();
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     /* fetch all operands first */
     o->in1 = tcg_temp_new_i64();
@@ -4245,7 +4261,7 @@ static DisasJumpType op_ectg(DisasContext *s, DisasOps *o)
     tcg_gen_mov_i64(regs[1], o->in2);
 
     tcg_temp_free_i64(tmp);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -4278,10 +4294,15 @@ static DisasJumpType op_stap(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stck(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
+
     gen_helper_stck(o->out, cpu_env);
     /* ??? We don't implement clock states.  */
     gen_op_movi_cc(s, 0);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
@@ -4289,6 +4310,11 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
     TCGv_i64 c1 = tcg_temp_new_i64();
     TCGv_i64 c2 = tcg_temp_new_i64();
     TCGv_i64 todpr = tcg_temp_new_i64();
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_stck(c1, cpu_env);
     /* 16 bit value store in an uint32_t (only valid bits set) */
     tcg_gen_ld32u_i64(todpr, cpu_env, offsetof(CPUS390XState, todpr));
@@ -4308,22 +4334,30 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(todpr);
     /* ??? We don't implement clock states.  */
     gen_op_movi_cc(s, 0);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     gen_helper_sck(cc_op, cpu_env, o->in1);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_sckc(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_sckc(cpu_env, o->in2);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_sckpf(DisasContext *s, DisasOps *o)
@@ -4366,8 +4400,12 @@ static DisasJumpType op_stidp(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_spt(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_spt(cpu_env, o->in2);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_stfl(DisasContext *s, DisasOps *o)
@@ -4378,8 +4416,12 @@ static DisasJumpType op_stfl(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stpt(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_stpt(o->out, cpu_env);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_stsi(DisasContext *s, DisasOps *o)
@@ -4397,56 +4439,88 @@ static DisasJumpType op_spx(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_xsch(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_xsch(cpu_env, regs[1]);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_csch(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_csch(cpu_env, regs[1]);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_hsch(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_hsch(cpu_env, regs[1]);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_msch(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_msch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_rchp(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_rchp(cpu_env, regs[1]);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_rsch(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_rsch(cpu_env, regs[1]);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_sal(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_sal(cpu_env, regs[1]);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_schm(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_schm(cpu_env, regs[1], regs[2], o->in2);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_siga(DisasContext *s, DisasOps *o)
@@ -4464,44 +4538,68 @@ static DisasJumpType op_stcps(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_ssch(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_ssch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_stsch(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_stsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_stcrw(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_stcrw(cpu_env, o->in2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_tpi(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_tpi(cc_op, cpu_env, o->addr1);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_tsch(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_tsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_chsc(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_chsc(cpu_env, o->in2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_stpx(DisasContext *s, DisasOps *o)
@@ -5067,65 +5165,89 @@ static DisasJumpType op_zero2(DisasContext *s, DisasOps *o)
 static DisasJumpType op_clp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r2 = tcg_const_i32(get_field(s, r2));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     gen_helper_clp(cpu_env, r2);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_pcilg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s, r2));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     gen_helper_pcilg(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_pcistg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s, r2));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     gen_helper_pcistg(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_stpcifc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s, r1));
     TCGv_i32 ar = tcg_const_i32(get_field(s, b2));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     gen_helper_stpcifc(cpu_env, r1, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_sic(DisasContext *s, DisasOps *o)
 {
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
     gen_helper_sic(cpu_env, o->in1, o->in2);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_rpcit(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s, r2));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     gen_helper_rpcit(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_pcistb(DisasContext *s, DisasOps *o)
@@ -5133,25 +5255,33 @@ static DisasJumpType op_pcistb(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s, r3));
     TCGv_i32 ar = tcg_const_i32(get_field(s, b2));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     gen_helper_pcistb(cpu_env, r1, r3, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 
 static DisasJumpType op_mpcifc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s, r1));
     TCGv_i32 ar = tcg_const_i32(get_field(s, b2));
+    bool icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
+    if (icount) {
+        gen_io_start();
+    }
 
     gen_helper_mpcifc(cpu_env, r1, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
     set_cc_static(s);
-    return DISAS_NEXT;
+    return icount ? DISAS_PC_STALE : DISAS_NEXT;
 }
 #endif
 


