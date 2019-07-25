Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9902C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9102D2171F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9102D2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZOR-0006xk-Rs
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50247)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMq-0000kB-0y
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMo-0000Ch-PP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:51 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57068)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMo-0000CT-DY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:50 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 9717354006B;
 Thu, 25 Jul 2019 11:44:49 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 11:44:49 +0300
Message-ID: <156404428943.18669.15747009371169578935.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
References: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [for-4.2 PATCH v2 7/8] icount: clean up cpu_can_io at
 the entry to the block
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Most of IO instructions can be executed only at the end of the block in
icount mode. Therefore translator can set cpu_can_io flag when translating
the last instruction.
But when the blocks are chained, then this flag is not reset and may
remain set at the beginning of the next block.
This patch resets the flag at the entry of any translation block,
making I/O operations impossible by default.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2 changes:
 - reset can_do_io at the start of every TB (suggested by Paolo Bonzini)
---
 accel/tcg/cpu-exec.c      |    1 -
 include/exec/gen-icount.h |   38 ++++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6c85c3ee1e..48272c781b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -169,7 +169,6 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
     }
 #endif /* DEBUG_DISAS */
 
-    cpu->can_do_io = !use_icount;
     ret = tcg_qemu_tb_exec(env, tb_ptr);
     cpu->can_do_io = 1;
     last_tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f7669b6841..4004e6c9d0 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -7,6 +7,24 @@
 
 static TCGOp *icount_start_insn;
 
+static inline void gen_io_start(void)
+{
+    TCGv_i32 tmp = tcg_const_i32(1);
+    tcg_gen_st_i32(tmp, cpu_env,
+                   offsetof(ArchCPU, parent_obj.can_do_io) -
+                   offsetof(ArchCPU, env));
+    tcg_temp_free_i32(tmp);
+}
+
+static inline void gen_io_end(void)
+{
+    TCGv_i32 tmp = tcg_const_i32(0);
+    tcg_gen_st_i32(tmp, cpu_env,
+                   offsetof(ArchCPU, parent_obj.can_do_io) -
+                   offsetof(ArchCPU, env));
+    tcg_temp_free_i32(tmp);
+}
+
 static inline void gen_tb_start(TranslationBlock *tb)
 {
     TCGv_i32 count, imm;
@@ -40,6 +58,8 @@ static inline void gen_tb_start(TranslationBlock *tb)
         tcg_gen_st16_i32(count, cpu_env,
                          offsetof(ArchCPU, neg.icount_decr.u16.low) -
                          offsetof(ArchCPU, env));
+        /* Disable I/O by default */
+        gen_io_end();
     }
 
     tcg_temp_free_i32(count);
@@ -57,22 +77,4 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
     tcg_gen_exit_tb(tb, TB_EXIT_REQUESTED);
 }
 
-static inline void gen_io_start(void)
-{
-    TCGv_i32 tmp = tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, cpu_env,
-                   offsetof(ArchCPU, parent_obj.can_do_io) -
-                   offsetof(ArchCPU, env));
-    tcg_temp_free_i32(tmp);
-}
-
-static inline void gen_io_end(void)
-{
-    TCGv_i32 tmp = tcg_const_i32(0);
-    tcg_gen_st_i32(tmp, cpu_env,
-                   offsetof(ArchCPU, parent_obj.can_do_io) -
-                   offsetof(ArchCPU, env));
-    tcg_temp_free_i32(tmp);
-}
-
 #endif


