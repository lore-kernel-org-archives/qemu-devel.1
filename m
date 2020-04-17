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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB55C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C630A2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU5LuAPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C630A2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWVi-0002aN-1U
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNo-0002kd-88
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNm-0005Sd-Jp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:36 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPWNm-0005OB-98
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:34 -0400
Received: by mail-lf1-x141.google.com with SMTP id j14so2674037lfg.9
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b0T2/yc1VAw0adGUFTBuH3ADGJB4Oe5EFs26KUSMiuM=;
 b=iU5LuAPEAiAcKmCa5oMGgOhjsHU3rwQm7FNmnqvT8wimQz1CfftyGGtszKRvmsZk8t
 gmLiHKUMNYYi1izmtNmKqE4V7IE6NYp7M5jI9OIWxxZgcBNPW8+Ab6CbY1Wn0hF7mlwe
 4KxOUMQOBR+vEPFnkfoxxT9+mBVJ6kuB/t3px9m4l/KtkRzunhl8VFNvieEx1Bk05CWz
 XkIldc5BJUCn/x88x1IGKYBT9YxuIQ1kSpFa5xT2KgnAKg7rJpP7j/9AaTJobMZqLczJ
 Edkpuc1XqDeUJX0sYx29CbHg2x2VivUW9LMsxrUa5pPnjaWVgN7U2As691cFg0kFNZSJ
 B3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b0T2/yc1VAw0adGUFTBuH3ADGJB4Oe5EFs26KUSMiuM=;
 b=SLHl2BY/c/sDn7od4DujAb22SWpHk7twoeXNs2rTSd/ptCPqSaoKAO11X/uOQOWAe6
 BmIwM5zbb5g1/NULb1X6qAlZpnNfJvsjUjwZQQJFn5+FP9QilHfGQVNpLe1xi4iqxEF5
 dzqM698VzMLw0YG/rbNPeqWDd3knLCB3/t2VGj86EWb5gWJaG6DNKTrORPdtdyCF2Lq5
 zQDnrGg0tzhPpwwphU0fc8/xVwvAjJypTB60vUVGpDLXWNnxJRRlq4Fpv4fy/X9wdUWG
 4a2fo8J/bVMAS7AC0BL/KL8p2ZOKPTaGeySgYaiTmnm82RZo8PhYOKmvlXLpvqmWLIAy
 vDjg==
X-Gm-Message-State: AGi0PuYqqiBT80CjGxNiHDMQI36eu4MVnfQ9VwlvdgP58uCedaI9krmq
 QeM30hjmRu5mgop6xbLvB4x1YGLjKrpvhA==
X-Google-Smtp-Source: APiQypJZFjRkH7WKP1XTv60yjUL5kUhmpFEbJ+6izpKRd2JgIISgjkSxYnskUuebf8ZBkQwDnNXi0A==
X-Received: by 2002:a19:224e:: with SMTP id i75mr3019832lfi.22.1587150631056; 
 Fri, 17 Apr 2020 12:10:31 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id t3sm10315665ljo.51.2020.04.17.12.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 12:10:29 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/6] target/microblaze: Add the pvr-user1 property
Date: Fri, 17 Apr 2020 21:10:21 +0200
Message-Id: <20200417191022.5247-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417191022.5247-1-edgar.iglesias@gmail.com>
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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

Add the pvr-user1 property to control the user-defined
PVR0 User1 field.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 4 +++-
 target/microblaze/cpu.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index a850c7b23c..0759b23a83 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -193,7 +193,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
                         (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
                         (version_code << PVR0_VERSION_SHIFT) |
-                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0);
+                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
+                        cpu->cfg.pvr_user1;
 
     env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
                         (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
@@ -290,6 +291,7 @@ static Property mb_properties[] = {
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
     DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
+    DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index ef9081db40..7bb5a3d6c6 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -307,6 +307,7 @@ struct MicroBlazeCPU {
         bool opcode_0_illegal;
         bool div_zero_exception;
         bool unaligned_exceptions;
+        uint8_t pvr_user1;
         char *version;
         uint8_t pvr;
     } cfg;
-- 
2.20.1


