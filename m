Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFC2C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B9B20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmPpHWY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B9B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFPq-0006nx-Kz
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCl-0003vW-Ur
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCk-0003wQ-7T
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCj-0003p5-VD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id a141so22755406wme.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yyb54Z5z/ykNOhXoH1gOKUFqMaavHpOhkHDAz9vguSE=;
 b=XmPpHWY8AVuixOtR7Jk3RVcJQehHWonDGm4s4ahpCkV99AG0nHBngUrUej8ekOScGt
 3qFBo2aPFMlgnZVwQAxJLz0De2sqKKVpT3Yo/GilQYizRPs9huD/Tf3EFo+y4X05hPxM
 xSEiHKtr2OsqPUvSwjPA9XGgHsl0N3S48SwkgdYbuQR2ylolWPliBXUG9fH/MhAdWsDO
 U1huhqlUFOa8ruyqT7QnLl95GN28Sjg/Gd9X+Uv6ajZww9aB2bsavlOw9/vf7cz6K1M+
 Bdnqu9zmYrNTKEqaFrYf/bw4ghy2Kk3BR1PxZaJTcRIQHvQiIfpkdBfI7KVDNpbYKShM
 upXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Yyb54Z5z/ykNOhXoH1gOKUFqMaavHpOhkHDAz9vguSE=;
 b=RQOePulKvfiFcGgFuat84xFY6v9hkrpLirjuL1GdIXoeeg7ti2yzfo64lE6KgNi+IO
 m1QwohjRnDsus+MQ0oMRE5jih0hmyACZq7D/k6tFVU+esBzXJa4XJeluu0PQi8lgGbfx
 uckuFT/yoB+6Gd9V0e0ups32mxxLJdKIBMaIpUdwmkInN5/0ZEhNQZlss71eMfPeaU/3
 TnBwoTDoavH23OWkyF5Xg5llbbvHICSgw8MXyK0vbVATpx8OwIIMFnIt1fNPLbtX/8hq
 8FjJXuCnXa8p4XnZkxKsKLwRm/rkiOS/T0RUoqfy3/UmxV4BRSngQFpF7c6WS2o9Dx5r
 zemA==
X-Gm-Message-State: ANhLgQ3WdsDRPVg+yNxQ7OLfyfKrHgPIlxRqzeM+O8es4Q6HXKMjJCyM
 Gj8jeol4dQFPQMwDH7XFsuZGTTP3
X-Google-Smtp-Source: ADFU+vuzYqL++3BHW+1n6N76CohnDXGU4NOmfBe/Cu+GlNvR5+eYfdnTFzXzZT6AfktwxZb2ANgZPA==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr169207wml.110.1584462992162; 
 Tue, 17 Mar 2020 09:36:32 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b202sm4618697wmd.15.2020.03.17.09.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 09:36:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/13] target/rx: Emit all disassembly in one prt()
Date: Tue, 17 Mar 2020 17:36:13 +0100
Message-Id: <20200317163616.30027-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317163616.30027-1-f4bug@amsat.org>
References: <20200317163616.30027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Many of the multi-part prints have been eliminated by previous
patches.  Eliminate the rest of them.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-22-richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/disas.c | 75 ++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index a0c444020c..814ef97480 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -228,24 +228,21 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 /* mov.[bwl] rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    char dspd[8], dsps[8];
+    char dspd[8], dsps[8], szc = size[a->sz];
 
-    prt("mov.%c\t", size[a->sz]);
     if (a->lds == 3 && a->ldd == 3) {
         /* mov.[bwl] rs,rd */
-        prt("r%d, r%d", a->rs, a->rd);
-        return true;
-    }
-    if (a->lds == 3) {
+        prt("mov.%c\tr%d, r%d", szc, a->rs, a->rd);
+    } else if (a->lds == 3) {
         rx_index_addr(ctx, dspd, a->ldd, a->sz);
-        prt("r%d, %s[r%d]", a->rs, dspd, a->rd);
+        prt("mov.%c\tr%d, %s[r%d]", szc, a->rs, dspd, a->rd);
     } else if (a->ldd == 3) {
         rx_index_addr(ctx, dsps, a->lds, a->sz);
-        prt("%s[r%d], r%d", dsps, a->rs, a->rd);
+        prt("mov.%c\t%s[r%d], r%d", szc, dsps, a->rs, a->rd);
     } else {
         rx_index_addr(ctx, dsps, a->lds, a->sz);
         rx_index_addr(ctx, dspd, a->ldd, a->sz);
-        prt("%s[r%d], %s[r%d]", dsps, a->rs, dspd, a->rd);
+        prt("mov.%c\t%s[r%d], %s[r%d]", szc, dsps, a->rs, dspd, a->rd);
     }
     return true;
 }
@@ -254,8 +251,11 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 /* mov.[bwl] rs,[-rd] */
 static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 {
-    prt("mov.%c\tr%d, ", size[a->sz], a->rs);
-    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
+    if (a->ad) {
+        prt("mov.%c\tr%d, [-r%d]", size[a->sz], a->rs, a->rd);
+    } else {
+        prt("mov.%c\tr%d, [r%d+]", size[a->sz], a->rs, a->rd);
+    }
     return true;
 }
 
@@ -263,9 +263,11 @@ static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 /* mov.[bwl] [-rd],rs */
 static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
 {
-    prt("mov.%c\t", size[a->sz]);
-    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
-    prt(", r%d", a->rs);
+    if (a->ad) {
+        prt("mov.%c\t[-r%d], r%d", size[a->sz], a->rd, a->rs);
+    } else {
+        prt("mov.%c\t[r%d+], r%d", size[a->sz], a->rd, a->rs);
+    }
     return true;
 }
 
@@ -299,9 +301,11 @@ static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
 /* movu.[bw] [-rs],rd */
 static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
 {
-    prt("movu.%c\t", size[a->sz]);
-    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
-    prt(", r%d", a->rs);
+    if (a->ad) {
+        prt("movu.%c\t[-r%d], r%d", size[a->sz], a->rd, a->rs);
+    } else {
+        prt("movu.%c\t[r%d+], r%d", size[a->sz], a->rd, a->rs);
+    }
     return true;
 }
 
@@ -478,11 +482,11 @@ static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
 /* not rs, rd */
 static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
 {
-    prt("not\t");
     if (a->rs != a->rd) {
-        prt("r%d, ", a->rs);
+        prt("not\tr%d, r%d", a->rs, a->rd);
+    } else {
+        prt("not\tr%d", a->rs);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
@@ -490,11 +494,11 @@ static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
 /* neg rs, rd */
 static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
 {
-    prt("neg\t");
     if (a->rs != a->rd) {
-        prt("r%d, ", a->rs);
+        prt("neg\tr%d, r%d", a->rs, a->rd);
+    } else {
+        prt("neg\tr%d", a->rs);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
@@ -606,11 +610,10 @@ static bool trans_SBB_mr(DisasContext *ctx, arg_SBB_mr *a)
 /* abs rs, rd */
 static bool trans_ABS_rr(DisasContext *ctx, arg_ABS_rr *a)
 {
-    prt("abs\t");
-    if (a->rs == a->rd) {
-        prt("r%d", a->rd);
+    if (a->rs != a->rd) {
+        prt("abs\tr%d, r%d", a->rs, a->rd);
     } else {
-        prt("r%d, r%d", a->rs, a->rd);
+        prt("abs\tr%d", a->rs);
     }
     return true;
 }
@@ -733,11 +736,11 @@ static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
 /* shll #imm:5, rs, rd */
 static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
 {
-    prt("shll\t#%d, ", a->imm);
     if (a->rs2 != a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shll\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shll\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
@@ -752,11 +755,11 @@ static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
 /* shar #imm:5, rs, rd */
 static bool trans_SHAR_irr(DisasContext *ctx, arg_SHAR_irr *a)
 {
-    prt("shar\t#%d,", a->imm);
     if (a->rs2 != a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shar\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shar\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
@@ -771,11 +774,11 @@ static bool trans_SHAR_rr(DisasContext *ctx, arg_SHAR_rr *a)
 /* shlr #imm:5, rs, rd */
 static bool trans_SHLR_irr(DisasContext *ctx, arg_SHLR_irr *a)
 {
-    prt("shlr\t#%d, ", a->imm);
     if (a->rs2 != a->rd) {
-        prt("r%d, ", a->rs2);
+        prt("shlr\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
+    } else {
+        prt("shlr\t#%d, r%d", a->imm, a->rd);
     }
-    prt("r%d", a->rd);
     return true;
 }
 
-- 
2.21.1


