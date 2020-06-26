Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE8C2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/5+kgSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE8C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqKB-0006DW-KC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4A-0002Yx-Jl
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:58 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq48-0006S9-Rr
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id s10so9823089wrw.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=a0syJ1sIv8i3fVj+GdrHNB0e6D/PFUBhQOSTOV0RdwE=;
 b=b/5+kgSzMRMIlYczvyM8xG6L84sLT371oYCvxYNunM+65D4D+aP4hwdF99kU9oTyMK
 n19roWgs/G5K53rDjtMELB4VzTonGYCCyzjYLyCcCPfhcQQqFjBmo9iaIkNzxQQ4hrXP
 xw1nht7obIj44bCV1EIPj68uVZqg2RYQMbWthKw96WICATxh24k3MMrxUFJI3+yd6P2V
 x6ygnz8JcA7/0pMDu14W3a770VTl7ASC50vqjKS1RvZ1C0ouQvdelpZn8PRNwHmfkIQU
 /LlM6RGYAFd9L+9dvsKWmDoWK7lYBAXnvsJF5UFmBtACuzYyyrkbIwgyb9oXfejQbHSt
 ve7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a0syJ1sIv8i3fVj+GdrHNB0e6D/PFUBhQOSTOV0RdwE=;
 b=jAFHBX9CLY1e3LVwgEHx7ENun8FJy5tTxIWnYYBM/PiLe+VRzO/x5wykzyWJJ0S/yc
 VztJZyhzbp9HBfIm04VmXnN9iLJHWD7xQxpUdRsGnyW252JKV7im+4amd5TpUX33TL/t
 SycXfFvrRlOoVWcG93qVwPdZnO/NugFgItLgeM2nfGR/P27Z1uc5CauIXjPv7PhDYhoX
 ooZ7KTA7N5DTMQ7M0TrXn7tyc6CYXJfe7EFKlSw7n8FytZu1m7DLvp8E9nhTmbhnFYTh
 vH4P5Ot4xPruHwkSvXQkOpXUaOIltk9VZvPx4PLR70h2rrsPm1cAOIZNBc3wRCMFxZBO
 Nr2Q==
X-Gm-Message-State: AOAM530qV4wEqFse+HEVTJpBmvj8AnRNnFpbsBF659SmXhHoWMnsEWHI
 UZGru24xFgOwU+jMFRrr36AJJI8TfcSRTQ==
X-Google-Smtp-Source: ABdhPJwp/l7QtIW51GzCO2pFfqC8U3YlCZwoadq8RwduGWXvcyn53F9LxzBLaf9Zq+dekFsnhid7Cg==
X-Received: by 2002:a5d:670d:: with SMTP id o13mr921948wru.307.1593184494956; 
 Fri, 26 Jun 2020 08:14:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/57] target/arm: Implement the SUBP instruction
Date: Fri, 26 Jun 2020 16:13:52 +0100
Message-Id: <20200626151424.30117-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ee9dfa8e439..abbcdbb53ae 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5315,19 +5315,39 @@ static void handle_crc32(DisasContext *s,
  */
 static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
 {
-    unsigned int sf, rm, opcode, rn, rd;
+    unsigned int sf, rm, opcode, rn, rd, setflag;
     sf = extract32(insn, 31, 1);
+    setflag = extract32(insn, 29, 1);
     rm = extract32(insn, 16, 5);
     opcode = extract32(insn, 10, 6);
     rn = extract32(insn, 5, 5);
     rd = extract32(insn, 0, 5);
 
-    if (extract32(insn, 29, 1)) {
+    if (setflag && opcode != 0) {
         unallocated_encoding(s);
         return;
     }
 
     switch (opcode) {
+    case 0: /* SUBP(S) */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        } else {
+            TCGv_i64 tcg_n, tcg_m, tcg_d;
+
+            tcg_n = read_cpu_reg_sp(s, rn, true);
+            tcg_m = read_cpu_reg_sp(s, rm, true);
+            tcg_gen_sextract_i64(tcg_n, tcg_n, 0, 56);
+            tcg_gen_sextract_i64(tcg_m, tcg_m, 0, 56);
+            tcg_d = cpu_reg(s, rd);
+
+            if (setflag) {
+                gen_sub_CC(true, tcg_d, tcg_n, tcg_m);
+            } else {
+                tcg_gen_sub_i64(tcg_d, tcg_n, tcg_m);
+            }
+        }
+        break;
     case 2: /* UDIV */
         handle_div(s, false, sf, rm, rn, rd);
         break;
-- 
2.20.1


