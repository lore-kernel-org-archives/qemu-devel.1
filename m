Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEDAC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64324205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW1I5K+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64324205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTSk-0007Es-EP
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJg-00086T-AZ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJd-0003Dc-37
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJb-00038j-8q
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id a132so14755372wme.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dU3gpjX3Posol9xmmDMnWL1NqczANAwUTw9txeOeohk=;
 b=aW1I5K+EX0G0MhRGm1zO7+wj2FJisphAR0piH/Dt/DVcyG3t7am1ehzldY0ITZLD51
 95uApHUdd/ZVZyPJd+rFkCuryOQsTufnocbi9kpszT7FCEqfie2Z8wBpK92ZsSy7h9gD
 Os+wH0XXtYVjY5yn6EKqtYDW6nxB77/lCH6EffWEXhR0NLSbXQ81e54EhY5GyWHE/pzA
 FZkxAZOTUUgWgYGeIO7NxbMRPPHVZWyYHtR83nthPIcd9U4oUj/OV0Q08zy4EKLjhDI7
 XcBhUlkdENLhY11S/OP4Ms8pn87g6XMSKZc3iLeWDFnOJNOILJIlCrCQ85cMPH4yZZAC
 XyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dU3gpjX3Posol9xmmDMnWL1NqczANAwUTw9txeOeohk=;
 b=olyYrD9sqhJC6/Uj1MHLjSS2dN1m1Vwj/fPha+wm+3L5oR5egF4Zv5n/czdGoDG42p
 nDvLprC2vDXmYoJdMHJXlV+7zyU5cF1aZRusQj/ifZGtqZWuA2o2Vi2jXwTXw9Es99Cz
 tQokqIV2oRBMxOmtHfDQIyGDLlnkemkv/ikQlWWZXPqgXCWyEruU6mIkS+103dfUhPFS
 UmpthMJz4Hiuii9fHLN/eup3o4AmT1bVc0noz8yVgEvBcjN66AbS5pfSJu1+l55rPTXA
 FVf0FmDRcIGQuBjzpaj/yGYfPXk+9Xz3lkUFIPPtkjFlo2stcMknDbhg/VUMHSrAap60
 Ei8g==
X-Gm-Message-State: ANhLgQ1ry5U5vgPsFrwPuH+YLbydBsvsHtV01qrModwxM8criPp6qtLB
 7oV+4tRX8xQp0LP6rgRjYP4AUB16
X-Google-Smtp-Source: ADFU+vvYlkTMDtYtBqniaz+oe6JY7hZn7H6qDyIAbXSsWfUbNyLBqZw24CPVPFjbFVsTOxUIGTiF0A==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr23203819wmi.129.1584278905773; 
 Sun, 15 Mar 2020 06:28:25 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/13] target/rx: Disassemble rx_index_addr into a string
Date: Sun, 15 Mar 2020 14:28:03 +0100
Message-Id: <20200315132810.7022-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
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

We were eliding all zero indexes.  It is only ld==0 that does
not have an index in the instruction.  This also allows us to
avoid breaking the final print into multiple pieces.

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-19-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/disas.c | 154 +++++++++++++++++-----------------------------
 1 file changed, 55 insertions(+), 99 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 04cdfdc567..7abb53d776 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -107,49 +107,42 @@ static const char psw[] = {
     'i', 'u', 0, 0, 0, 0, 0, 0,
 };
 
-static uint32_t rx_index_addr(int ld, int size, DisasContext *ctx)
+static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
 {
-    bfd_byte buf[2];
+    uint32_t addr = ctx->addr;
+    uint8_t buf[2];
+    uint16_t dsp;
+
     switch (ld) {
     case 0:
-        return 0;
+        /* No index; return empty string.  */
+        out[0] = '\0';
+        return;
     case 1:
-        ctx->dis->read_memory_func(ctx->addr, buf, 1, ctx->dis);
         ctx->addr += 1;
-        return ((uint8_t)buf[0]) << size;
+        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
+        dsp = buf[0];
+        break;
     case 2:
-        ctx->dis->read_memory_func(ctx->addr, buf, 2, ctx->dis);
         ctx->addr += 2;
-        return lduw_le_p(buf) << size;
+        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
+        dsp = lduw_le_p(buf);
+        break;
+    default:
+        g_assert_not_reached();
     }
-    g_assert_not_reached();
+
+    sprintf(out, "%u", dsp << (mi < 3 ? mi : 4 - mi));
 }
 
 static void operand(DisasContext *ctx, int ld, int mi, int rs, int rd)
 {
-    int dsp;
     static const char sizes[][4] = {".b", ".w", ".l", ".uw", ".ub"};
+    char dsp[8];
+
     if (ld < 3) {
-        switch (mi) {
-        case 4:
-            /* dsp[rs].ub */
-            dsp = rx_index_addr(ld, RX_MEMORY_BYTE, ctx);
-            break;
-        case 3:
-            /* dsp[rs].uw */
-            dsp = rx_index_addr(ld, RX_MEMORY_WORD, ctx);
-            break;
-        default:
-            /* dsp[rs].b */
-            /* dsp[rs].w */
-            /* dsp[rs].l */
-            dsp = rx_index_addr(ld, mi, ctx);
-            break;
-        }
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]%s", rs, sizes[mi]);
+        rx_index_addr(ctx, dsp, ld, mi);
+        prt("%s[r%d]%s", dsp, rs, sizes[mi]);
     } else {
         prt("r%d", rs);
     }
@@ -235,7 +228,7 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 /* mov.[bwl] rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    int dsp;
+    char dspd[8], dsps[8];
 
     prt("mov.%c\t", size[a->sz]);
     if (a->lds == 3 && a->ldd == 3) {
@@ -244,29 +237,15 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
         return true;
     }
     if (a->lds == 3) {
-        prt("r%d, ", a->rd);
-        dsp = rx_index_addr(a->ldd, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]", a->rs);
+        rx_index_addr(ctx, dspd, a->ldd, a->sz);
+        prt("r%d, %s[r%d]", a->rs, dspd, a->rd);
     } else if (a->ldd == 3) {
-        dsp = rx_index_addr(a->lds, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d], r%d", a->rs, a->rd);
+        rx_index_addr(ctx, dsps, a->lds, a->sz);
+        prt("%s[r%d], r%d", dsps, a->rs, a->rd);
     } else {
-        dsp = rx_index_addr(a->lds, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d], ", a->rs);
-        dsp = rx_index_addr(a->ldd, a->sz, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]", a->rd);
+        rx_index_addr(ctx, dsps, a->lds, a->sz);
+        rx_index_addr(ctx, dspd, a->ldd, a->sz);
+        prt("%s[r%d], %s[r%d]", dsps, a->rs, dspd, a->rd);
     }
     return true;
 }
@@ -357,12 +336,10 @@ static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
 /* push dsp[rs] */
 static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
 {
-    prt("push\t");
-    int dsp = rx_index_addr(a->ld, a->sz, ctx);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[r%d]", a->rs);
+    char dsp[8];
+
+    rx_index_addr(ctx, dsp, a->ld, a->sz);
+    prt("push\t%s[r%d]", dsp, a->rs);
     return true;
 }
 
@@ -389,17 +366,13 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
 /* xchg dsp[rs].<mi>,rd */
 static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 {
-    int dsp;
     static const char msize[][4] = {
         "b", "w", "l", "ub", "uw",
     };
+    char dsp[8];
 
-    prt("xchg\t");
-    dsp = rx_index_addr(a->ld, a->mi, ctx);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[r%d].%s, r%d", a->rs, msize[a->mi], a->rd);
+    rx_index_addr(ctx, dsp, a->ld, a->mi);
+    prt("xchg\t%s[r%d].%s, r%d", dsp, a->rs, msize[a->mi], a->rd);
     return true;
 }
 
@@ -552,13 +525,10 @@ static bool trans_ADC_rr(DisasContext *ctx, arg_ADC_rr *a)
 /* adc dsp[rs], rd */
 static bool trans_ADC_mr(DisasContext *ctx, arg_ADC_mr *a)
 {
-    int dsp;
-    prt("adc\t");
-    dsp = rx_index_addr(a->ld, 2, ctx);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[r%d], r%d", a->rs, a->rd);
+    char dsp[8];
+
+    rx_index_addr(ctx, dsp, a->ld, 2);
+    prt("adc\t%s[r%d], r%d", dsp, a->rs, a->rd);
     return true;
 }
 
@@ -1217,25 +1187,17 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
 
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
-        int dsp;                                                \
-        prt("b%s\t#%d, ", #name, a->imm);                       \
-        dsp = rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);        \
-        if (dsp > 0) {                                          \
-            prt("%d", dsp);                                     \
-        }                                                       \
-        prt("[r%d]", reg);                                      \
+        char dsp[8];                                            \
+        rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);         \
+        prt("b%s\t#%d, %s[r%d]", #name, a->imm, dsp, reg);      \
         return true;                                            \
     } while (0)
 
 #define BOP_RM(name)                                            \
     do {                                                        \
-        int dsp;                                                \
-        prt("b%s\tr%d, ", #name, a->rd);                        \
-        dsp = rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);        \
-        if (dsp > 0) {                                          \
-            prt("%d", dsp);                                     \
-        }                                                       \
-        prt("[r%d]", a->rs);                                    \
+        char dsp[8];                                            \
+        rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);         \
+        prt("b%s\tr%d, %s[r%d]", #name, a->rd, dsp, a->rs);     \
         return true;                                            \
     } while (0)
 
@@ -1346,12 +1308,10 @@ static bool trans_BNOT_ir(DisasContext *ctx, arg_BNOT_ir *a)
 /* bmcond #imm, dsp[rd] */
 static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
 {
-    int dsp = rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);
-    prt("bm%s\t#%d, ", cond[a->cd], a->imm);
-    if (dsp > 0) {
-        prt("%d", dsp);
-    }
-    prt("[%d]", a->rd);
+    char dsp[8];
+
+    rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);
+    prt("bm%s\t#%d, %s[r%d]", cond[a->cd], a->imm, dsp, a->rd);
     return true;
 }
 
@@ -1443,16 +1403,12 @@ static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
 /* sccnd.[bwl] dsp:[rd] */
 static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 {
-    int dsp;
-    prt("sc%s.%c\t", cond[a->cd], size[a->sz]);
     if (a->ld < 3) {
-        dsp = rx_index_addr(a->sz, a->ld, ctx);
-        if (dsp > 0) {
-            prt("%d", dsp);
-        }
-        prt("[r%d]", a->rd);
+        char dsp[8];
+        rx_index_addr(ctx, dsp, a->sz, a->ld);
+        prt("sc%s.%c\t%s[r%d]", cond[a->cd], size[a->sz], dsp, a->rd);
     } else {
-        prt("r%d", a->rd);
+        prt("sc%s.%c\tr%d", cond[a->cd], size[a->sz], a->rd);
     }
     return true;
 }
-- 
2.21.1


