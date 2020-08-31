Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59042C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAEB2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/N8Y1oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAEB2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmeC-0005FW-7i
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLM-0006ca-MT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:41753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLK-0006AO-SE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:40 -0400
Received: by mail-pl1-x631.google.com with SMTP id l9so1612307plt.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QDTm4Rd7QGp1CLW4zO3AZdAzuiw+MvOs5jtCeQIlMUE=;
 b=b/N8Y1oaLN/rI99/xNazNhszo83o8gaSFxcoLxtu9Obdb97RfUbv7/W/ewpeRdp2ka
 3b0cLjvh9+OXpN4nXNWndE2lJsYX+aYEK7cUo0s2e+3QPT6Q0Hmq1aW0IemCU5ONxSiD
 GmdZ9dN9KheLxXbSF9f9TP+shu0FlLtCo6SllBYFr8NH+iQwLg+vr8ZznYS3sprQ4+fW
 JztSeOFUrdMq9kRPSnjg8Nh68y/vPLoBOfSZ8OG6aQFPTR5JsSO+JZ06/J8Jyf4pbUl3
 2r1Z3s5s1jdfzLxsQFf5Gwh215kXc3ANep8nlxnCBbeKRLeMhCT8W6Z+l8SVUFSmjLpr
 VQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QDTm4Rd7QGp1CLW4zO3AZdAzuiw+MvOs5jtCeQIlMUE=;
 b=Eb/4Wkz2IeJMH28mRCf389rhMlLU1y1TNiGfuXdxqcDTJjutn0Hw7+LAWd8C+YFycM
 n0kRWZItEWPul1zcY437tVwrYnUm0C8Y0ZzFd5A0sXdnhlqLinvzplKfnZx6NhRn/f0K
 9MKrh0j6plyzgjkPyG662f7UmwTQjJW8UTN35h/QhaQMXUiE8Z578dYF6uwHcvsR4W+u
 W4YxymcWFStZzoI6urIG6pWkOKGnGmVU+SANSp+xCDQaL5uGYI537qqXivcynx4K+/W4
 SCMjVCKAc82Arud6Bvn9lLHxxybeft2CuCyAsKPZgENzWm/wVdw4WO+erMrn35CX5bJV
 2pnw==
X-Gm-Message-State: AOAM533AO6owdo/e0bDlc+K5vc4lRFMBlZeNukMrO28rVKRLmL5ZqMrG
 inEOrTj2s0AvAL4tFdPa+Pz5uR1UV1h3dQ==
X-Google-Smtp-Source: ABdhPJx9hNM7993mtMy9ExFT7Vko0QsGhUhn5xxbjURvpMopkPDibIC+f/OI0tGAELXGSmd+wr1Imw==
X-Received: by 2002:a17:902:6ac3:: with SMTP id
 i3mr1595395plt.21.1598890057109; 
 Mon, 31 Aug 2020 09:07:37 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 69/76] target/microblaze: Tidy do_rti, do_rtb, do_rte
Date: Mon, 31 Aug 2020 09:05:54 -0700
Message-Id: <20200831160601.833692-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Since cpu_msr is no longer a 64-bit quantity, we can simplify
the arithmetic in these functions.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 65 ++++++++++++++---------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6c1855b29a..0872795038 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1494,59 +1494,44 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-static inline void do_rti(DisasContext *dc)
+static void do_rti(DisasContext *dc)
 {
-    TCGv_i32 t0, t1;
-    t0 = tcg_temp_new_i32();
-    t1 = tcg_temp_new_i32();
-    tcg_gen_mov_i32(t1, cpu_msr);
-    tcg_gen_shri_i32(t0, t1, 1);
-    tcg_gen_ori_i32(t1, t1, MSR_IE);
-    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_i32(t1, t1, t0);
-    msr_write(dc, t1);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
+    tcg_gen_shri_i32(tmp, cpu_msr, 1);
+    tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_IE);
+    tcg_gen_andi_i32(tmp, tmp, MSR_VM | MSR_UM);
+    tcg_gen_andi_i32(cpu_msr, cpu_msr, ~(MSR_VM | MSR_UM));
+    tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
+
+    tcg_temp_free_i32(tmp);
     dc->tb_flags &= ~DRTI_FLAG;
 }
 
-static inline void do_rtb(DisasContext *dc)
+static void do_rtb(DisasContext *dc)
 {
-    TCGv_i32 t0, t1;
-    t0 = tcg_temp_new_i32();
-    t1 = tcg_temp_new_i32();
-    tcg_gen_mov_i32(t1, cpu_msr);
-    tcg_gen_andi_i32(t1, t1, ~MSR_BIP);
-    tcg_gen_shri_i32(t0, t1, 1);
-    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_i32(t1, t1, t0);
-    msr_write(dc, t1);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
+    tcg_gen_shri_i32(tmp, cpu_msr, 1);
+    tcg_gen_andi_i32(cpu_msr, cpu_msr, ~(MSR_VM | MSR_UM | MSR_BIP));
+    tcg_gen_andi_i32(tmp, tmp, (MSR_VM | MSR_UM));
+    tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
+
+    tcg_temp_free_i32(tmp);
     dc->tb_flags &= ~DRTB_FLAG;
 }
 
-static inline void do_rte(DisasContext *dc)
+static void do_rte(DisasContext *dc)
 {
-    TCGv_i32 t0, t1;
-    t0 = tcg_temp_new_i32();
-    t1 = tcg_temp_new_i32();
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_mov_i32(t1, cpu_msr);
-    tcg_gen_ori_i32(t1, t1, MSR_EE);
-    tcg_gen_andi_i32(t1, t1, ~MSR_EIP);
-    tcg_gen_shri_i32(t0, t1, 1);
-    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
+    tcg_gen_shri_i32(tmp, cpu_msr, 1);
+    tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_EE);
+    tcg_gen_andi_i32(tmp, tmp, (MSR_VM | MSR_UM));
+    tcg_gen_andi_i32(cpu_msr, cpu_msr, ~(MSR_VM | MSR_UM | MSR_EIP));
+    tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
 
-    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_i32(t1, t1, t0);
-    msr_write(dc, t1);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(tmp);
     dc->tb_flags &= ~DRTE_FLAG;
 }
 
-- 
2.25.1


