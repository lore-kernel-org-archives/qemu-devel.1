Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31DDC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B221220787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPUvXuIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B221220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE27-0008O8-CW
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeb-0002fm-HJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe4-0001M5-VA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDe2-0001Ke-Hp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id c12so3038496wrp.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AJuDhNMKtFHxolGAXK2BQLCZ7xRlxZx8fU3lkQGYeGk=;
 b=EPUvXuIJ8oyRZcQqPwItEzbYaRWnPB2oFTqu+9nHKI2BoEXu4zPbv4uaVjfbmm/kIB
 uaeYbxYFxUGNMHiHZ4lifD3MK6LnWNjtxs5rqh3/ElW9Y/IHNyyOA6sTOONw+AzWZg0K
 GECtv553SGXGWSwp7eE9cl0hpqh1XlJ34yFrk/nPF+G+QVtZicZjiQXpFiULD54eERi8
 v1H7nFqNyKvSolj4IC0BnIpr29mvgvkVM8kC/emUzLlUT8FAg8hNlDt4yOaqjeqbZcsP
 mBFoLysDfU4chRmWqUjzGOT2beupkuecP4LrWnCiW/EvLWXzOBRltqztv7CNW1ljFmOd
 Ujww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AJuDhNMKtFHxolGAXK2BQLCZ7xRlxZx8fU3lkQGYeGk=;
 b=B34boaMWomdEkxutuY+1LXmcYzSFK306ZkrLtEZTlbdbeBKcovC0ZwPcbhKggLl6sy
 g2ITg7Jt/SyQH7j3nS4GVHMp0ghiQYO3mqeL3oKNY9z6YjIu8rScw0pJNsIoD3GNoQxG
 18wNHC1j715i7+47sgyucZoQChprgVo49P0svLCMzlUDlu88dtLdqycNV1uAplMp1O2Z
 fP6q1MfkjCNL9bfTDBhkY/XaDdWiEWXc6wY8DEOT6dRKgL5MpV5CK0jRvz9CVL/973yV
 2logoesyJXin3uILUxfozgErrjjWaNtkZEylCJSfXhHwTln2qDzj7VJ9JM5iyqrlXTY4
 mG2A==
X-Gm-Message-State: AGi0Puaw7YIOAlkM1+U5x8dDPTi/Ye1Dft/ppJ4hz38vrdya+DL+xwmX
 +VXct0RCgMu1Wih9hx4M8wXQRw==
X-Google-Smtp-Source: APiQypJ1F13/QGoucm1ONRtftoqAnF3A66cAlgNdUaCymoADT5IHeD+lACwbc715UiMSfahzK36n/w==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr5237716wrp.28.1588270243823;
 Thu, 30 Apr 2020 11:10:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 30/36] target/arm: Convert Neon VQDMULH/VQRDMULH 3-reg-same to
 decodetree
Date: Thu, 30 Apr 2020 19:09:57 +0100
Message-Id: <20200430181003.21682-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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

Convert the Neon VQDMULH and VQRDMULH 3-reg-same insns to
decodetree. These are the last integer operations in the
3-reg-same group.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 44 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 24 +-----------------
 target/arm/neon-dp.decode       |  3 +++
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 31a8e4ef486..2fab547840d 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1277,3 +1277,47 @@ DO_3SAME_PAIR(VPMIN_S, pmin_s)
 DO_3SAME_PAIR(VPMAX_U, pmax_u)
 DO_3SAME_PAIR(VPMIN_U, pmin_u)
 DO_3SAME_PAIR(VPADD, padd_u)
+
+static void gen_VQDMULH_s16(TCGv_i32 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    gen_helper_neon_qdmulh_s16(rd, cpu_env, rn, rm);
+}
+
+static void gen_VQDMULH_s32(TCGv_i32 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    gen_helper_neon_qdmulh_s32(rd, cpu_env, rn, rm);
+}
+
+static bool trans_VQDMULH_3s(DisasContext *s, arg_3same *a)
+{
+    static NeonGenTwoOpFn * const fns[] = {
+        gen_VQDMULH_s16, gen_VQDMULH_s32,
+    };
+
+    if (a->size != 1 && a->size != 2) {
+        return false;
+    }
+    return do_3same_32(s, a, fns[a->size - 1]);
+}
+
+static void gen_VQRDMULH_s16(TCGv_i32 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    gen_helper_neon_qrdmulh_s16(rd, cpu_env, rn, rm);
+}
+
+static void gen_VQRDMULH_s32(TCGv_i32 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    gen_helper_neon_qrdmulh_s32(rd, cpu_env, rn, rm);
+}
+
+static bool trans_VQRDMULH_3s(DisasContext *s, arg_3same *a)
+{
+    static NeonGenTwoOpFn * const fns[] = {
+        gen_VQRDMULH_s16, gen_VQRDMULH_s32,
+    };
+
+    if (a->size != 1 && a->size != 2) {
+        return false;
+    }
+    return do_3same_32(s, a, fns[a->size - 1]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f583cc900e1..9fec1889613 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4784,6 +4784,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VPMAX:
         case NEON_3R_VPMIN:
         case NEON_3R_VPADD_VQRDMLAH:
+        case NEON_3R_VQDMULH_VQRDMULH:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4848,29 +4849,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VQDMULH_VQRDMULH: /* Multiply high.  */
-            if (!u) { /* VQDMULH */
-                switch (size) {
-                case 1:
-                    gen_helper_neon_qdmulh_s16(tmp, cpu_env, tmp, tmp2);
-                    break;
-                case 2:
-                    gen_helper_neon_qdmulh_s32(tmp, cpu_env, tmp, tmp2);
-                    break;
-                default: abort();
-                }
-            } else { /* VQRDMULH */
-                switch (size) {
-                case 1:
-                    gen_helper_neon_qrdmulh_s16(tmp, cpu_env, tmp, tmp2);
-                    break;
-                case 2:
-                    gen_helper_neon_qrdmulh_s32(tmp, cpu_env, tmp, tmp2);
-                    break;
-                default: abort();
-                }
-            }
-            break;
         case NEON_3R_FLOAT_ARITH: /* Floating point arithmetic. */
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index acaf278cc8d..8ceedd8b8d8 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -137,6 +137,9 @@ VPMAX_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 0 .... @3same_q0
 VPMIN_S_3s       1111 001 0 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 VPMIN_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 
+VQDMULH_3s       1111 001 0 0 . .. .... .... 1011 . . . 0 .... @3same
+VQRDMULH_3s      1111 001 1 0 . .. .... .... 1011 . . . 0 .... @3same
+
 VPADD_3s         1111 001 0 0 . .. .... .... 1011 . . . 1 .... @3same_q0
 
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
-- 
2.20.1


