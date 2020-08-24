Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA706C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D0A2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANIBRops"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D0A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Jx-0000Q5-NO
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HX-00047J-C6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:51 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132]:37434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HV-0006V6-NY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:51 -0400
Received: by mail-lf1-x132.google.com with SMTP id s9so4155704lfs.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tOsYxxOVVUOXw/haaoRA8JuTUt7/rqYWB9o2RGYk5jg=;
 b=ANIBRops0jltDXrngIS0dY3S8GecFcmd5+bmZzcTP5eWRfs3crxqQ2aEa1Ombu3IM9
 UkRHgegzgC6VF3buMokQSLaNgsxYQfp3OT2IvSUpNTIRLm6Y+nZMtoM5mo8gDdNQ+A3I
 TwnSYC1c166W344Z468aWj5E29EnhCeerQ0CC2FsX+oTtSTfkNi+1VpQd+KfDB7WNCbU
 r1u2mn32hjSesUDQi5ksAiiORx7t84nC4t5gRd/SY/yoDmAeoHwzt9ePiCIm0PP2KpGd
 EGlOfEmmnKHL97pEIyOyAnZL2a1C3JvBjZ1RddADMN9F/GXYTRaua8L/ZNubqia/bIrM
 9IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tOsYxxOVVUOXw/haaoRA8JuTUt7/rqYWB9o2RGYk5jg=;
 b=sW6mETLNUFhCqPg8d7B/g1QdEmZyB8z9g7mpvUNAV6z7JY5U3EE1xvuBXWIVyvxyUz
 yFSMbUrCOMD4DyX1Hm0IJaDKwjNqU+lQKJhmZUcRMKrGg8QUnp8YtQCqxXWErTrIFS02
 iFnxff55eIBxL4T1hm14DVPSbMU7aMPljW8YfsILwRuiY/1/q/+HleZkveb+7rdFqHeG
 99QAJlOiVv96m183vEBx0kF+HTLJhG5O8xdVP9u3i8n3Wmfl0k+u4k/I2ZbY2K4dqIVt
 StB8hLYH03Hzb1p2+DBKLu9Uu1mONdFQvawJMCL0oqL7spmpBridKDvxMKzBnZuU3cJc
 ED3Q==
X-Gm-Message-State: AOAM530WPwfhbOiy4NYW4r/bFW733UvfuvrYakbLQGC4xH+kZ9mZCiOH
 K5omz9CDTWUmkyi9WwyDJv+BPXnZo3g=
X-Google-Smtp-Source: ABdhPJyBds09UlW/kAkp/Bj84+y6X8CzaZ09zYqx2ZODbdzB4PueHV9wi98xRl3TR+faa/X1PxRulQ==
X-Received: by 2002:ac2:55b4:: with SMTP id y20mr335362lfg.103.1598263247403; 
 Mon, 24 Aug 2020 03:00:47 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id f3sm2107511ljo.81.2020.08.24.03.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 03:00:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 4/8] target/microblaze: swx: Use atomic_cmpxchg
Date: Mon, 24 Aug 2020 12:00:37 +0200
Message-Id: <20200824100041.1864420-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
References: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x132.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.724, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use atomic_cmpxchg to implement the atomic cmpxchg sequence.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c58f334a0f..530c15e5ad 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1075,14 +1075,16 @@ static void dec_store(DisasContext *dc)
         swx_skip = gen_new_label();
         tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, addr, swx_skip);
 
-        /* Compare the value loaded at lwx with current contents of
-           the reserved location.
-           FIXME: This only works for system emulation where we can expect
-           this compare and the following write to be atomic. For user
-           emulation we need to add atomicity between threads.  */
+        /*
+         * Compare the value loaded at lwx with current contents of
+         * the reserved location.
+         */
         tval = tcg_temp_new_i32();
-        tcg_gen_qemu_ld_i32(tval, addr, cpu_mmu_index(&dc->cpu->env, false),
-                            MO_TEUL);
+
+        tcg_gen_atomic_cmpxchg_i32(tval, addr, env_res_val,
+                                   cpu_R[dc->rd], mem_index,
+                                   mop);
+
         tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
         write_carryi(dc, 0);
         tcg_temp_free_i32(tval);
@@ -1108,7 +1110,10 @@ static void dec_store(DisasContext *dc)
                 break;
         }
     }
-    tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
+
+    if (!ex) {
+        tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
+    }
 
     /* Verify alignment if needed.  */
     if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
-- 
2.25.1


