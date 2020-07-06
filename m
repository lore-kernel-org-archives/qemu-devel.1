Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2009C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D033206BE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErlRAyw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D033206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUY2-0007gj-Ru
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCO-0003kV-SB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCK-00038O-0F
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waFFuaiZ7wPfC/nzV327aHNRxP/Wwk9Pt0g/LfKKdgo=;
 b=ErlRAyw9zOVzl4fSwVkZwCemCOUX+28R8oCVieDGxeE3xP5FOphgemAKPIQ7Z8ExXyWaJO
 gTWT22uX7wh9snsefF2N6aOhkPYV/MsICaRuoyF3gTyFGxEWN4l2wMjSmYsL6tFlGdq9fD
 31jJfxc/K0H078mIaU8XilrarES2yvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-XHbT8Z5kMrCm5VfBGDCINA-1; Mon, 06 Jul 2020 12:42:22 -0400
X-MC-Unique: XHbT8Z5kMrCm5VfBGDCINA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F40F980183C;
 Mon,  6 Jul 2020 16:42:21 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A45A671667;
 Mon,  6 Jul 2020 16:42:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/53] target/i386: remove gen_io_end
Date: Mon,  6 Jul 2020 12:41:31 -0400
Message-Id: <20200706164155.24696-30-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Force the end of a translation block after an I/O instruction in
icount mode.  For consistency, all CF_USE_ICOUNT code is kept in
disas_insn instead of having it in gen_ins and gen_outs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index b3fea54411..5ef72ff401 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1128,9 +1128,6 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
 
 static inline void gen_ins(DisasContext *s, MemOp ot)
 {
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
     gen_string_movl_A0_EDI(s);
     /* Note: we must do this dummy write first to be restartable in
        case of page fault. */
@@ -1143,16 +1140,10 @@ static inline void gen_ins(DisasContext *s, MemOp ot)
     gen_op_movl_T0_Dshift(s, ot);
     gen_op_add_reg_T0(s, s->aflag, R_EDI);
     gen_bpt_io(s, s->tmp2_i32, ot);
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
 }
 
 static inline void gen_outs(DisasContext *s, MemOp ot)
 {
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
 
@@ -1163,9 +1154,6 @@ static inline void gen_outs(DisasContext *s, MemOp ot)
     gen_op_movl_T0_Dshift(s, ot);
     gen_op_add_reg_T0(s, s->aflag, R_ESI);
     gen_bpt_io(s, s->tmp2_i32, ot);
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
 }
 
 /* same method as Valgrind : we generate jumps to current or next
@@ -6400,8 +6388,12 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base, 
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes) | 4);
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_ins(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            /* jump generated by gen_repz_ins */
         } else {
             gen_ins(s, ot);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6415,8 +6407,12 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      svm_is_rep(prefixes) | 4);
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_outs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            /* jump generated by gen_repz_outs */
         } else {
             gen_outs(s, ot);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -8039,7 +8035,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     gen_helper_read_crN(s->T0, cpu_env, tcg_const_i32(reg));
                     gen_op_mov_reg_v(s, ot, rm, s->T0);
                     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                        gen_io_end();
+                        gen_jmp(s, s->pc - s->cs_base);
                     }
                 }
                 break;
-- 
2.26.2



