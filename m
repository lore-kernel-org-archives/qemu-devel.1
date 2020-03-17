Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5344C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA2B20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj05tBN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA2B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFSP-0002VF-Lc
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCh-0003oo-EL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCf-0003RF-GJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCf-0003HF-7p
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id g62so22780941wme.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8H31Kuq83wCqOybbZslqXDuQ3rjWt6eVyrdWP3O9Tt4=;
 b=Zj05tBN4m1B4KoT/wmoCrgGzodfDvKiFchX1wty7xjDCPM0uPocYEnMz/0B6upbJ8L
 3cu1MKBTxB7ZDDR7CQPRuxskHBeO+I//ZKmbGnzKwsVN/0qa0HHel1vOa24rOQZommhv
 i7zaA5vEnEbYO86U0CD/dJdEECs/cEBBt5GZYWKX9txQmhjesBNLex539bWcDQ7t0BhA
 8DM9+Mx4HTgUhtUJvrOheAF/5QW17VL3GirbAJWNE5wjzIIrx/EiykMw9vhELjSSOCza
 ODpl/L9HGNM1rmRtj/F1wJwcUhAPAaGVdSZopEu3Sj9ID/OCEk4wwilVbk3dai33Hv/m
 GBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8H31Kuq83wCqOybbZslqXDuQ3rjWt6eVyrdWP3O9Tt4=;
 b=K57AOkY9m0BCxFUqEE8Vz6NvzOyy9JcpbHEUWgzIeontwjbX+uPOPpZwClgclK6N5W
 T43/CcspSrJxmPdDkhrJ4I8FITjfBcZ5tA7VkC1+uUGusNsiG6C8bnPqnn0bAK/b6Mwp
 UgYKEoLy4sV4CTzRMa+DFtjP0ggUBRQnxFD3DMC0LK84i7z9H2pXkrOjaKp0hHbYBLKs
 ++zKsd+rfA7npYX90lhEDXSpyQCZpVfXIr8oKBuOnoqpIMulBWqyOLV/G4rS0nZmSj0k
 FsYXPHmTMGEzYObEwdjnGtcYXnbCjFlwIdX/30anyZYMYocLELrggHj1rtQSWEFKlZb9
 U50w==
X-Gm-Message-State: ANhLgQ1J4JymtEPAQFI2GcCqn70SxfqSMO45CP6n44pOBjXKd4POCfGV
 roQQclyou4u6p8h/9pb/bOTiZj/Q
X-Google-Smtp-Source: ADFU+vv0XNXomYy7ylVwZpjkONIvfJK2JM1ZZEri40EGda5Rjt5x1k5bB4+pBDC8JJrlR+9CweQVAA==
X-Received: by 2002:a7b:c854:: with SMTP id c20mr120961wml.99.1584462987441;
 Tue, 17 Mar 2020 09:36:27 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b202sm4618697wmd.15.2020.03.17.09.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 09:36:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/13] target/rx: Disassemble rx_index_addr into a string
Date: Tue, 17 Mar 2020 17:36:10 +0100
Message-Id: <20200317163616.30027-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317163616.30027-1-f4bug@amsat.org>
References: <20200317163616.30027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

We were eliding all zero indexes.  It is only ld==0 that does
not have an index in the instruction.  This also allows us to
avoid breaking the final print into multiple pieces.

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-19-richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
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


