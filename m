Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5481FC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF37214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVeRAKVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF37214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvP1-0004VO-Ja
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJF-0005sa-7y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJD-00041E-U7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:21 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:39643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJD-000411-Qo
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:19 -0400
Received: by mail-yw1-xc43.google.com with SMTP id n11so3491413ywn.6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WEMDSiZeffhMkxvHyrJteMQDd1U5hLNvnYLKIexyPo8=;
 b=rVeRAKVnAZ6eBAttTCHjEAqlslzMR4eRMile0T6aT4LX1nN1aSX3e5IkfM2a3dTk31
 JrcROaExxmduHX99WOHoThNYgjQ6+jIZsXrh+4fm9fdlmsXtPJWTFL+FLqMwpn8Lprmg
 rmdAuLmFH+ke7ewRVlXi7CX5XzBGJf7qzvUdKEBqPYlKz0/TudxQ3cVGTwL7Ip/E7rCX
 DvlvPjeWhaZBElgiul5MqrLw6S1MGy7Myz8QUssKBII5YK7WhQaXihbgFdTt+c6sogRA
 ThiMMKOTYVsBcRDHGj7Xrnekkf2h7OHw1yDqogayPfe0p94fniBrYLJHnMzlApuHvvdU
 2Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WEMDSiZeffhMkxvHyrJteMQDd1U5hLNvnYLKIexyPo8=;
 b=GcbzxOlaqhbEPVzdETenMJJljYdRMn34hA+W7C0LC+M7XdSGArzby4CHPgWNXihfq8
 eCqQCdTZt+02tlhq4iCabpube8Zcx0XDbCnit5EGQ0zmCa8vteHohwOxr4Y8szygtRbY
 fn/lC4/9ROfcyaNBc+5pTuk6VUxhospMDFQ/pOKq2hY/k601f4Lgdcg+KuAbBJK1UYm+
 XJ7qu9ZY60DzG712RLsQSYfqhpUK1Or11pKArNXt9tfag+1iR49p1ZFBORYW2+uE3g3F
 zpvorIX505KCAebQ3lMRb7U2nGM9ogJCx67RM6KS8LEM8FMuZFd0IONv36DUKr2kIrcc
 n7Hw==
X-Gm-Message-State: APjAAAW+0PkY8YpaSmOt8udmx+SPvZ5BbhoD4UaHbNq1rydSgA70QKq/
 xwJmkKabp1EMOS7M8PqHQfo466V7qbg=
X-Google-Smtp-Source: APXvYqyFKZQ3MZoD3yHbxQiRrkD7SqmWFZmoR16LYjqz/PE7kNvXzKz1YmENtUZkQyNWvgOZ52YZfg==
X-Received: by 2002:a81:a74a:: with SMTP id e71mr2294480ywh.40.1570801818955; 
 Fri, 11 Oct 2019 06:50:18 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/22] target/arm: Implement the STGP instruction
Date: Fri, 11 Oct 2019 09:47:34 -0400
Message-Id: <20191011134744.2477-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Handle atomicity, require pre-cleaned address.
---
 target/arm/translate-a64.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c17b36ebb2..4ecb0a2fb7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2657,7 +2657,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
  * +-----+-------+---+---+-------+---+-------+-------+------+------+
  *
  * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
- *      LDPSW                    01
+ *      LDPSW/STGP               01
  *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
  *   V: 0 -> GPR, 1 -> Vector
  * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
@@ -2682,6 +2682,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     bool postindex = false;
     bool wback = false;
+    bool set_tag = false;
 
     TCGv_i64 clean_addr, dirty_addr;
 
@@ -2694,6 +2695,14 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
 
     if (is_vector) {
         size = 2 + opc;
+    } else if (opc == 1 && !is_load) {
+        /* STGP */
+        if (!dc_isar_feature(aa64_mte_insn_reg, s) || index == 0) {
+            unallocated_encoding(s);
+            return;
+        }
+        size = 3;
+        set_tag = true;
     } else {
         size = 2 + extract32(opc, 1, 1);
         is_signed = extract32(opc, 0, 1);
@@ -2746,6 +2755,15 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     }
     clean_addr = clean_data_tbi(s, dirty_addr, wback || rn != 31);
 
+    if (set_tag) {
+        TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
+        if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+            gen_helper_stg_parallel(cpu_env, clean_addr, tcg_rn);
+        } else {
+            gen_helper_stg(cpu_env, clean_addr, tcg_rn);
+        }
+    }
+
     if (is_vector) {
         if (is_load) {
             do_fp_ld(s, rt, clean_addr, size);
-- 
2.17.1


