Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411A9C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0637420714
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="qikbPez5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="elCRV2YX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0637420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkNdG-0004Fl-8J
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 04:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jkNcS-0002tM-CE
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:03:56 -0400
Received: from relay1.mymailcheap.com ([149.56.97.132]:45992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jkNcP-0004nC-3f
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:03:56 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id ED8D63F1C5;
 Sun, 14 Jun 2020 04:03:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id C4D782A3B1;
 Sun, 14 Jun 2020 04:03:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1592121829;
 bh=mdmYydToiMZ54x34/5NlXcOMMXrGcl1A4CvrtAn7GVw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qikbPez5jrtDksAGQrU1tt2x1qbkobaOdqDycACms2B0iOL/nPk0BkVKIjsO5cqev
 Nyp/oBCKKyQR8nCHuAgFWaqXhqpE7kbdSNgxnmNDUlcJT0PgeP+yU7OiGDd1+xweOy
 L7MICtanuJdMO2X4kLYeTflzjsmDn4IGlgNHWLlI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wIH9KwZCgv_K; Sun, 14 Jun 2020 04:03:48 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Sun, 14 Jun 2020 04:03:48 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id B8C5140EF3;
 Sun, 14 Jun 2020 08:03:47 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="elCRV2YX"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from halation.202.net.flygoat.com (unknown [183.157.45.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 03F41403B5;
 Sun, 14 Jun 2020 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1592121671;
 bh=mdmYydToiMZ54x34/5NlXcOMMXrGcl1A4CvrtAn7GVw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=elCRV2YXRLTiPLaqUNnKJ8J7DruqtN0/1/qkvfsyfXGCykJbKloyc7OU+3tNm/SMZ
 B+CW08fJkskVkVluV6cmsd3w257qWVHWcr3QUYQd7Ro3Y1NRJe0emWhRU9+19py/W/
 v+9L6jjfHoAHisgoDX3S23zNVPzDSCxA4dcKVSpg=
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: aleksandar.qemu.devel@gmail.com
Subject: [PATCH 1/4] target/mips: Legalize Loongson insn flags
Date: Sun, 14 Jun 2020 16:00:46 +0800
Message-Id: <20200614080049.31134-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
References: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8C5140EF3
X-Spamd-Result: default: False [6.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 RCPT_COUNT_FIVE(0.00)[5]; ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RECEIVED_SPAMHAUS_PBL(0.00)[183.157.45.207:received];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_CONTAINS_FROM(1.00)[];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam: Yes
Received-SPF: pass client-ip=149.56.97.132;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 04:03:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, aleksandar.rikalo@syrmia.com,
 qemu-devel@nongnu.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To match the actual status of Loongson insn, we split flags
for LMMI and LEXT from INSN_LOONGSON2F.

As Loongson-2F only implemented interger part of LEXT, we'll
not enable LEXT for the processor, but instead we're still using
INSN_LOONGSON2F as switch flag of these instructions.

All multimedia instructions have been moved to LMMI flag. Loongson-2F
and Loongson-3A are sharing these instructions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/mips-defs.h |  4 ++--
 target/mips/translate.c | 13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 0c129106c8..f1b833f947 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -70,7 +70,7 @@
 #define CPU_VR54XX      (CPU_MIPS4 | INSN_VR54XX)
 #define CPU_R5900       (CPU_MIPS3 | INSN_R5900)
 #define CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
-#define CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
+#define CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F | ASE_LMMI)
 
 #define CPU_MIPS5       (CPU_MIPS4 | ISA_MIPS5)
 
@@ -97,7 +97,7 @@
 /* Wave Computing: "nanoMIPS" */
 #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
 
-#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
+#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A | ASE_LMMI | ASE_LEXT)
 
 /*
  * Strictly follow the architecture standard:
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2caf4cba5a..e49f32f6ae 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1046,7 +1046,7 @@ enum {
     OPC_BC2NEZ  = (0x0D << 21) | OPC_CP2,
 };
 
-#define MASK_LMI(op)    (MASK_OP_MAJOR(op) | (op & (0x1F << 21)) | (op & 0x1F))
+#define MASK_LMMI(op)    (MASK_OP_MAJOR(op) | (op & (0x1F << 21)) | (op & 0x1F))
 
 enum {
     OPC_PADDSH      = (24 << 21) | (0x00) | OPC_CP2,
@@ -3421,7 +3421,8 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     TCGv t0, t1, t2;
     int mem_idx = ctx->mem_idx;
 
-    if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F)) {
+    if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F |
+                                      INSN_LOONGSON3A)) {
         /*
          * Loongson CPU uses a load to zero register for prefetch.
          * We emulate it as a NOP. On other CPU we must perform the
@@ -5531,7 +5532,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
     TCGv_i64 t0, t1;
     TCGCond cond;
 
-    opc = MASK_LMI(ctx->opcode);
+    opc = MASK_LMMI(ctx->opcode);
     switch (opc) {
     case OPC_ADD_CP2:
     case OPC_SUB_CP2:
@@ -27161,7 +27162,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MULTU_G_2F:
     case OPC_MOD_G_2F:
     case OPC_MODU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
     case OPC_CLO:
@@ -27194,7 +27195,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_DDIVU_G_2F:
     case OPC_DMOD_G_2F:
     case OPC_DMODU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
 #endif
@@ -30641,7 +30642,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_CP2:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, ASE_LMMI);
         /* Note that these instructions use different fields.  */
         gen_loongson_multimedia(ctx, sa, rd, rt);
         break;
-- 
2.27.0

