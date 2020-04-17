Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE563C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF07E20780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiYW2rhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF07E20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWR6-0006Z4-Op
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNo-0002kf-8G
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNm-0005Si-Jz
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:36 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPWNm-0005Ps-Ah
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:34 -0400
Received: by mail-lj1-x241.google.com with SMTP id v9so3134520ljk.12
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uErXPxJ2vzEoeE7Q7TmBVLR2V1xZy4c+Qn/k8aZPlVg=;
 b=aiYW2rhMJUm4ZA5Uo7Dv5X5l1Ic1TGm1Ilcptr8T7WdxMoQs415/Woui5qY/N7QzEw
 ivgCYgh7S37p4BHbyH76qkY2/6EdnKH3HxRUCqXSCIBx9JO1yYrU7nyXiESVZbOnnb/p
 A4O0hNl9YnpitdCPLsSrdVwHXng0Ycn6t6kXGYrrjj40spuohyH760ksKwutL0wQE0t8
 8ABCLoGCN2VWF3a8ONCmpR6+zQ1zy7wWdiyFqeHre2qvXsdU8hmsmQ6t7GOpWtvnvMxU
 10k05sLJsI71H/UucBrXXGlpanB31qe4jJnm8T21Xfrq1RckhtQ+dN8noawa5B1C1bx6
 g1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uErXPxJ2vzEoeE7Q7TmBVLR2V1xZy4c+Qn/k8aZPlVg=;
 b=seiZH4krlmRj/jqW27nqBCWR1z8rrtQl/4NVlbaH2CZCDcER+vv0HQQQI7aAgy6sls
 KhvuGH6CXwXmqOCDQskgVqZMapD28q1cLHZAZi3mB2aI/uqmHdmWyN4cS1rjzaR35DKE
 Y7noqN2LQQ5EpIeJZo+oXgMFIJLPYAEk1jq2D0AvdW2pwMN2DvTIfssbULpzYRS3njQ4
 o+8TNdIdqZ5Rv5CMzjjhxlRg7uz0TLfuNoHCu5OZ8NSGWuli9Kq2K++aNLzhsVPNZAjn
 DP9UhhLiLl/6dfHaM+ndr12IlGay032XcrlU/0oj1ELxuNff+ZBcdImLMBBdoAj4GMQO
 44MQ==
X-Gm-Message-State: AGi0PuaYu4NZfX0066zWbRledGEM1/8OjVymAgt0euNkLedZEfXK5iOt
 BTU4gOo8NZi6Lvxb6v8BsTaxeD+bIgPpXA==
X-Google-Smtp-Source: APiQypKLjN2QTbIjOW9Kl4JZKVvzsIwxHP9fJ1mDMTweYUtx5WT8WN746kLB3r2kT2j/Rx2e0jtUrQ==
X-Received: by 2002:a05:651c:1209:: with SMTP id
 i9mr2789556lja.250.1587150632206; 
 Fri, 17 Apr 2020 12:10:32 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id i20sm19545732lfe.15.2020.04.17.12.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 12:10:31 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 6/6] target/microblaze: Add the pvr-user2 property
Date: Fri, 17 Apr 2020 21:10:22 +0200
Message-Id: <20200417191022.5247-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417191022.5247-1-edgar.iglesias@gmail.com>
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the pvr-user2 property to control the user-defined
PVR1 User2 register.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 2 ++
 target/microblaze/cpu.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0759b23a83..d024ec80eb 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -196,6 +196,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
                         cpu->cfg.pvr_user1;
 
+    env->pvr.regs[1] = cpu->cfg.pvr_user2;
     env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
                         (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
                         (cpu->cfg.use_hw_mul ? PVR2_USE_HW_MUL_MASK : 0) |
@@ -292,6 +293,7 @@ static Property mb_properties[] = {
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
     DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
     DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
+    DEFINE_PROP_UINT32("pvr-user2", MicroBlazeCPU, cfg.pvr_user2, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 7bb5a3d6c6..a31134b65c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -308,6 +308,7 @@ struct MicroBlazeCPU {
         bool div_zero_exception;
         bool unaligned_exceptions;
         uint8_t pvr_user1;
+        uint32_t pvr_user2;
         char *version;
         uint8_t pvr;
     } cfg;
-- 
2.20.1


