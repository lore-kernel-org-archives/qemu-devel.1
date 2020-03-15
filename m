Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0842EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7370205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJGxvo5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7370205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTVP-0000zt-PJ
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJg-00086k-TI
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJd-0003GJ-Cc
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJd-0003Cj-2y
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id f3so10871563wrw.7
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1VvzifdAgPN+wvhMY9eGYoS7NUwS+hDqsCqV0xhxGYU=;
 b=eJGxvo5M8B4k8MIxS6jYQCXmCALn+u+1Rz03Iom6+owf5KyV/P0vRYBYyNgolTXanh
 uR8MSq2chkW83sba27ycV+t1hn1Vf7OY3dueW+m2q0YxYA5F/fe+IBIcaVohyCw1+j9U
 F5S2a1WPa5uXrlKCxVEBMEp0/+xspP+fCHhrHCm7D/O4DlJ0Iegt7P8zuG7sNISAQXeK
 jTkRft9GWoicPRfL5jWlF3bFw+yMV1EnlLWfLBB27IDmiEl5IZWmlCrq+aerqgDGdkL7
 dylywTrBJAUFhp5f6SrwTHg/qyNQgl9OeE0S8vT81CJScxUmWIdG/65Z4VFA9T7rTQ49
 Xwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1VvzifdAgPN+wvhMY9eGYoS7NUwS+hDqsCqV0xhxGYU=;
 b=gu06nHxGxnxp12ueXdql/2Ga8iMstLOEfkYvXRlE3rli8MJOsSOTRYeAocdt48nqjv
 XPzfnzXwlrShs1elthuYG0Kfrk9V6V/BbsNDyBT/r/xz61IM2RmM2pNng6jpSmNcuQiK
 LTX1xfrDO4j532+SOvG9g0Jt/zibxGmuyT6gQ8cvnD4u5+TVXF7U0iOcuvJmk2+hxljm
 45aHx/gqKyZ8lO/h6Da6hvJl2wYiufqFApm/5mMt5R3wMRmQ3IaxHHrHWlzpblw28bHu
 oKHhQtEdovFEnmubvwOLa0minjH1tLIXcmnzrkzRmfwDgXUJ9YOH2+Qbexnmher3qC9a
 D2IA==
X-Gm-Message-State: ANhLgQ3/Nh4X2SYWpl0MCkmhq5XY+w6vfqdXNE641x/7tsOBrRNlXfaf
 L5mrVguwU8EVfrG2wzyZwQZ6EEJh
X-Google-Smtp-Source: ADFU+vtXRuQYWbUj+CWvC2i+DJDmt4Jvye6P6WTZ+RKZPQMLrh5owi/eAIo2yw/Xai+DH1TljNjykw==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr22734163wrs.119.1584278907253; 
 Sun, 15 Mar 2020 06:28:27 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/13] target/rx: Replace operand with prt_ldmi in disassembler
Date: Sun, 15 Mar 2020 14:28:04 +0100
Message-Id: <20200315132810.7022-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This has consistency with prt_ri().  It loads all data before
beginning output.  It uses exactly one call to prt() to emit
the full instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-20-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/disas.c | 77 +++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 50 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 7abb53d776..0c4115669d 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -135,18 +135,18 @@ static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
     sprintf(out, "%u", dsp << (mi < 3 ? mi : 4 - mi));
 }
 
-static void operand(DisasContext *ctx, int ld, int mi, int rs, int rd)
+static void prt_ldmi(DisasContext *ctx, const char *insn,
+                     int ld, int mi, int rs, int rd)
 {
     static const char sizes[][4] = {".b", ".w", ".l", ".uw", ".ub"};
     char dsp[8];
 
     if (ld < 3) {
         rx_index_addr(ctx, dsp, ld, mi);
-        prt("%s[r%d]%s", dsp, rs, sizes[mi]);
+        prt("%s\t%s[r%d]%s, r%d", insn, dsp, rs, sizes[mi], rd);
     } else {
-        prt("r%d", rs);
+        prt("%s\tr%d, r%d", insn, rs, rd);
     }
-    prt(", r%d", rd);
 }
 
 static void prt_ir(DisasContext *ctx, const char *insn, int imm, int rd)
@@ -416,8 +416,7 @@ static bool trans_AND_ir(DisasContext *ctx, arg_AND_ir *a)
 /* and rs,rd */
 static bool trans_AND_mr(DisasContext *ctx, arg_AND_mr *a)
 {
-    prt("and\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "and", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -440,8 +439,7 @@ static bool trans_OR_ir(DisasContext *ctx, arg_OR_ir *a)
 /* or rs,rd */
 static bool trans_OR_mr(DisasContext *ctx, arg_OR_mr *a)
 {
-    prt("or\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "or", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -463,8 +461,7 @@ static bool trans_XOR_ir(DisasContext *ctx, arg_XOR_ir *a)
 /* xor rs,rd */
 static bool trans_XOR_mr(DisasContext *ctx, arg_XOR_mr *a)
 {
-    prt("xor\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "xor", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -479,8 +476,7 @@ static bool trans_TST_ir(DisasContext *ctx, arg_TST_ir *a)
 /* tst rs, rd */
 static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
 {
-    prt("tst\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "tst", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -548,8 +544,7 @@ static bool trans_ADD_irr(DisasContext *ctx, arg_ADD_irr *a)
 /* add dsp[rs], rd */
 static bool trans_ADD_mr(DisasContext *ctx, arg_ADD_mr *a)
 {
-    prt("add\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "add", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -573,8 +568,7 @@ static bool trans_CMP_ir(DisasContext *ctx, arg_CMP_ir *a)
 /* cmp dsp[rs], rs2 */
 static bool trans_CMP_mr(DisasContext *ctx, arg_CMP_mr *a)
 {
-    prt("cmp\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "cmp", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -589,8 +583,7 @@ static bool trans_SUB_ir(DisasContext *ctx, arg_SUB_ir *a)
 /* sub dsp[rs], rd */
 static bool trans_SUB_mr(DisasContext *ctx, arg_SUB_mr *a)
 {
-    prt("sub\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "sub", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -611,8 +604,7 @@ static bool trans_SBB_rr(DisasContext *ctx, arg_SBB_rr *a)
 /* sbb dsp[rs], rd */
 static bool trans_SBB_mr(DisasContext *ctx, arg_SBB_mr *a)
 {
-    prt("sbb\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "sbb", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -640,8 +632,7 @@ static bool trans_MAX_ir(DisasContext *ctx, arg_MAX_ir *a)
 /* max dsp[rs], rd */
 static bool trans_MAX_mr(DisasContext *ctx, arg_MAX_mr *a)
 {
-    prt("max\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "max", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -656,8 +647,7 @@ static bool trans_MIN_ir(DisasContext *ctx, arg_MIN_ir *a)
 /* min dsp[rs], rd */
 static bool trans_MIN_mr(DisasContext *ctx, arg_MIN_mr *a)
 {
-    prt("max\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "min", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -673,8 +663,7 @@ static bool trans_MUL_ir(DisasContext *ctx, arg_MUL_ir *a)
 /* mul dsp[rs], rd */
 static bool trans_MUL_mr(DisasContext *ctx, arg_MUL_mr *a)
 {
-    prt("mul\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "mul", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -696,8 +685,7 @@ static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
 /* emul dsp[rs], rd */
 static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
 {
-    prt("emul\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "emul", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -712,8 +700,7 @@ static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
 /* emulu dsp[rs], rd */
 static bool trans_EMULU_mr(DisasContext *ctx, arg_EMULU_mr *a)
 {
-    prt("emulu\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "emulu", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -728,8 +715,7 @@ static bool trans_DIV_ir(DisasContext *ctx, arg_DIV_ir *a)
 /* div dsp[rs], rd */
 static bool trans_DIV_mr(DisasContext *ctx, arg_DIV_mr *a)
 {
-    prt("div\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "div", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -744,8 +730,7 @@ static bool trans_DIVU_ir(DisasContext *ctx, arg_DIVU_ir *a)
 /* divu dsp[rs], rd */
 static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
 {
-    prt("divu\t");
-    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    prt_ldmi(ctx, "divu", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
@@ -1089,8 +1074,7 @@ static bool trans_FADD_ir(DisasContext *ctx, arg_FADD_ir *a)
 /* fadd rs, rd */
 static bool trans_FADD_mr(DisasContext *ctx, arg_FADD_mr *a)
 {
-    prt("fadd\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fadd", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1105,8 +1089,7 @@ static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir *a)
 /* fcmp rs, rd */
 static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
 {
-    prt("fcmp\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fcmp", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1121,8 +1104,7 @@ static bool trans_FSUB_ir(DisasContext *ctx, arg_FSUB_ir *a)
 /* fsub rs, rd */
 static bool trans_FSUB_mr(DisasContext *ctx, arg_FSUB_mr *a)
 {
-    prt("fsub\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fsub", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1130,8 +1112,7 @@ static bool trans_FSUB_mr(DisasContext *ctx, arg_FSUB_mr *a)
 /* ftoi rs, rd */
 static bool trans_FTOI(DisasContext *ctx, arg_FTOI *a)
 {
-    prt("ftoi\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "ftoi", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1146,8 +1127,7 @@ static bool trans_FMUL_ir(DisasContext *ctx, arg_FMUL_ir *a)
 /* fmul rs, rd */
 static bool trans_FMUL_mr(DisasContext *ctx, arg_FMUL_mr *a)
 {
-    prt("fmul\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fmul", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1162,8 +1142,7 @@ static bool trans_FDIV_ir(DisasContext *ctx, arg_FDIV_ir *a)
 /* fdiv rs, rd */
 static bool trans_FDIV_mr(DisasContext *ctx, arg_FDIV_mr *a)
 {
-    prt("fdiv\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "fdiv", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1171,8 +1150,7 @@ static bool trans_FDIV_mr(DisasContext *ctx, arg_FDIV_mr *a)
 /* round rs, rd */
 static bool trans_ROUND(DisasContext *ctx, arg_ROUND *a)
 {
-    prt("round\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "round", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
@@ -1180,8 +1158,7 @@ static bool trans_ROUND(DisasContext *ctx, arg_ROUND *a)
 /* itof dsp[rs], rd */
 static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
 {
-    prt("itof\t");
-    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    prt_ldmi(ctx, "itof", a->ld, RX_IM_LONG, a->rs, a->rd);
     return true;
 }
 
-- 
2.21.1


