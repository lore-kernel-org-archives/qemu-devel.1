Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE5D20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTe0i+4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE5D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmks-0002bI-W5
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLL-0006YW-6e
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:39 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:37066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLJ-0006A7-Ag
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id c15so3249219plq.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EW6QXoswK1mjFJ4YzGZRvNX8K3Up1egTxlK+WSpOGc8=;
 b=uTe0i+4QE+wNYDNwd8a4OJHnZhE9zGm7kovUhOCEwL59ffjPLcuqLYMJZhH32ZOF3x
 5r70z+njDgkknESnkj5NXk9FFkHHgr01ObxBLsAyTjqVDBv0FcQtUTU7fFmjSKHnqSRv
 bEVwvF38icp2J9J1WwMELsnvJqImaW1ZoHOWlNpmhXseC420GIKaXuTMh3WLzuFgpwNS
 fiQA+aM1xbDqA1AIevilz6GRQ3Vseq60erB6z5/+yxDgZVDEGk1ETgRKjWbrKFAs+Ud+
 Us/WmS9Vwsdfuk8H0/D6wg+dCNLSftJsDLxTjwy6tsGXsZRn9PfghC6XBjTGI8IJCfvK
 A85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EW6QXoswK1mjFJ4YzGZRvNX8K3Up1egTxlK+WSpOGc8=;
 b=tLg2MWUCuwlHeAuUmA56MPlSrwfNOLjgQgLQeOY+0BLa8GehBl+cvO6LiRE/AAUilc
 nj/1CFGjF/TJOmLsnPbI6MBXhCvNrsdl4YkccgOCX3HcZ/neNkLlRA+1BnKQ5OETtA01
 wJAdiSb1r0utmthbsIJ2ZLg23fNh1GGBic07HB3Fj06OB7Mv79uFs/XIUWCOndE4dYwY
 C2jHLhZTVfujpfHO5JUfoU4F8Se/Ap8tt3s9EckHscgcbtYIYHD8q2qTgzQXsd2ao82T
 nmadYuoPgj9kGvP8i4+WKobKn5bRoLwkSd20RtXUPky+NyxFuUGvvOOA+OMQqgbkCMR5
 pt6A==
X-Gm-Message-State: AOAM5314hbi5Us+HNTEnDSj3wrZOUqQSfuIlOdghK2lTlum+RPU5Bcnr
 e7JbOdubhcHkRNnFLdm8D/xeJOVYSNlp/g==
X-Google-Smtp-Source: ABdhPJxoWRENEqyUnramlAuAa3GE6kY/kUPgo4LtnIqR8qfMIRUqsrZJY5Fq/HaKdPvQkfaskCr3CA==
X-Received: by 2002:a17:902:720a:: with SMTP id
 ba10mr1552113plb.41.1598890055582; 
 Mon, 31 Aug 2020 09:07:35 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/76] target/microblaze: Convert dec_rts to decodetree
Date: Mon, 31 Aug 2020 09:05:53 -0700
Message-Id: <20200831160601.833692-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  5 ++++
 target/microblaze/translate.c  | 51 +++++++++++++++-------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index e6a61f147a..8906058a29 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -202,6 +202,11 @@ rsubic          001011 ..... ..... ................     @typeb
 rsubik          001101 ..... ..... ................     @typeb
 rsubikc         001111 ..... ..... ................     @typeb
 
+rtbd            101101 10010 ..... ................     @typeb_bc
+rtid            101101 10001 ..... ................     @typeb_bc
+rted            101101 10100 ..... ................     @typeb_bc
+rtsd            101101 10000 ..... ................     @typeb_bc
+
 sb              110100 ..... ..... ..... 0000 000 0000  @typea
 sbr             110100 ..... ..... ..... 0100 000 0000  @typea
 sbea            110100 ..... ..... ..... 0001 000 0000  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b8dcef8f1c..6c1855b29a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1252,6 +1252,29 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
     return true;
 }
 
+static bool do_rts(DisasContext *dc, arg_typeb_bc *arg, int to_set)
+{
+    if (trap_userspace(dc, to_set)) {
+        return true;
+    }
+    dc->tb_flags_to_set |= to_set;
+    setup_dslot(dc, true);
+
+    dc->jmp_cond = TCG_COND_ALWAYS;
+    dc->jmp_dest = -1;
+    tcg_gen_addi_i32(cpu_btarget, reg_for_read(dc, arg->ra), arg->imm);
+    return true;
+}
+
+#define DO_RTS(NAME, IFLAG) \
+    static bool trans_##NAME(DisasContext *dc, arg_typeb_bc *arg) \
+    { return do_rts(dc, arg, IFLAG); }
+
+DO_RTS(rtbd, DRTB_FLAG)
+DO_RTS(rtid, DRTI_FLAG)
+DO_RTS(rted, DRTE_FLAG)
+DO_RTS(rtsd, 0)
+
 static bool trans_zero(DisasContext *dc, arg_zero *arg)
 {
     /* If opcode_0_illegal, trap.  */
@@ -1527,33 +1550,6 @@ static inline void do_rte(DisasContext *dc)
     dc->tb_flags &= ~DRTE_FLAG;
 }
 
-static void dec_rts(DisasContext *dc)
-{
-    unsigned int b_bit, i_bit, e_bit;
-
-    i_bit = dc->ir & (1 << 21);
-    b_bit = dc->ir & (1 << 22);
-    e_bit = dc->ir & (1 << 23);
-
-    if (trap_userspace(dc, i_bit || b_bit || e_bit)) {
-        return;
-    }
-
-    setup_dslot(dc, true);
-
-    if (i_bit) {
-        dc->tb_flags |= DRTI_FLAG;
-    } else if (b_bit) {
-        dc->tb_flags |= DRTB_FLAG;
-    } else if (e_bit) {
-        dc->tb_flags |= DRTE_FLAG;
-    }
-
-    dc->jmp_cond = TCG_COND_ALWAYS;
-    dc->jmp_dest = -1;
-    tcg_gen_add_i32(cpu_btarget, cpu_R[dc->ra], *dec_alu_op_b(dc));
-}
-
 static void dec_null(DisasContext *dc)
 {
     if (trap_illegal(dc, true)) {
@@ -1601,7 +1597,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_RTS, dec_rts},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
-- 
2.25.1


