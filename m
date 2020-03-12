Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD4F20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0f6CdgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD4F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTr0-0003MD-Rf
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj5-0005D9-Ml
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj4-0001uc-L2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTj4-0001te-Eu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id c144so3759906pfb.10
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+pq9oFT7R9IJPpeslQpwFqiLS0a1utLd0OoEdcej/ZM=;
 b=Z0f6CdgRbrkF9SqFjCgN7a+fM09hvkMXdpxNmFJzThEMQUaDC7XLqeqIg6BDO31+lx
 ZoFgzfgx0CJT35KjBo7Yfl2io/0+gcoIZ+wkC+SlhmBLYUelCLumX7MOX8n7j/YGFwbp
 E+K0KP6NXUaOIPP7d/zsKPlnbEuCm14x19KWM4l5SuIlfvbhJiylZMxuE4Hk/OBOlt69
 McDJlI4Y5i5BIOUPhhKShACXfzYaZCVjQdda28G+b6+hzhq60IlD5Ur2We12nNIk511j
 iVFDNX2hBuU0g6dOEXNczsPjIdGRpJmzcuoi3Zox6lbb6GEFdADZhAvi6XPkZEwZA4Rq
 BhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+pq9oFT7R9IJPpeslQpwFqiLS0a1utLd0OoEdcej/ZM=;
 b=BNh2a0c3o89Kabt3Oq+GxrpICR5RADnu1kUzH+4K/awUHz5eX7qcj/Y+PeOGpG3IFH
 vXWgW1XdYQ6AwIMFKMj/VxudVDFXu96zP8rSma+BuwH7tRjs9EPX9TibFKpx9VTWI4OM
 7fF9cgcnamM05P4w/NnwkBrTadNm2sOLslH1PeebXek9Sc6SYA76noH4Wuy4iKraAgmR
 A7wR1cEricgHeKfi1kZGj5HFQqgFNepZTNhr3hPZrQz3YoWClRYJWK7n5P3v0vSccVTm
 Vi/a1eh9kXpiN31+kAyHOZBRhEVpyQPiN29B1Elb+5VEGQJyJEAxELuvsDPGWPkl7l2T
 MgkA==
X-Gm-Message-State: ANhLgQ0SRSDmrk1vh6fOd+pLBEH+f6/699FawRXkeCX3HK2mSSxcSsPo
 ayESrbeF2afo55/a5oWQyCtNMX5wpUY=
X-Google-Smtp-Source: ADFU+vt+C1pnf2FMY/Sg6/BNv5qT6DEle70MB/qOpmEIQvr71Uku5x8JjTbbIqBuUoVBErHDCH96eQ==
X-Received: by 2002:a62:ed19:: with SMTP id u25mr9482465pfh.173.1584042157146; 
 Thu, 12 Mar 2020 12:42:37 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/42] target/arm: Implement the SUBP instruction
Date: Thu, 12 Mar 2020 12:41:49 -0700
Message-Id: <20200312194219.24406-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix extraction length.
---
 target/arm/translate-a64.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9adc259186..49c94bc565 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5348,19 +5348,39 @@ static void handle_crc32(DisasContext *s,
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


