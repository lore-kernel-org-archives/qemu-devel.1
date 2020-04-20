Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E1CC38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26104205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbx3Uu14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26104205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQagj-0007QM-6V
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabR-0006n2-2H
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:05 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabO-00045a-4R
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:04 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36172)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQabN-00043N-Nm
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:01 -0400
Received: by mail-lj1-x242.google.com with SMTP id u15so11023106ljd.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/DrXlXCXCjcKxXaL3UynOI4aoP3LB9wkYq+IB5RRGYY=;
 b=sbx3Uu148od2PhVUlI0IFX9GYw3j0gFxWulYVrKsBZT5ZfuB3gy0FAQqLL/uSrxahx
 itYj7icQWe0XB8NqDOPySKW+9L/ljHuHHy+ketJOewy+t80v9wsOz0LhLrjiDEQT0Edp
 E7vd/kSsyGSl8jgE5vRAydkfoChxWp4V+SEwrUvnADdYemz36AysBxlT/l8hEf3195cj
 wUbsBqdbRQyrmphrdrMhMT7UL4Uh+d12yPGeotM8m48nA+bFP5egXRm3sDdonqe839TI
 RdiW7b2ezv4mfDKClxga3h8W5oV8vYjkKRQug8CKSxzmsdA4wAsHBm2ekqrxqX3jIwDd
 9EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/DrXlXCXCjcKxXaL3UynOI4aoP3LB9wkYq+IB5RRGYY=;
 b=UBbVoCOR2W/qCChPE8UI/YYBP81T//XL28z6Xqs2S/QpvyeoHeRPZZsFoZrAG4N6uW
 jQmW15hnPC9Ba5A3vcStttm6AKYSwoJSUCU22mzvQpV7J0FYxHH3n23yJuvXCv0zjiAi
 FjKn9p6Spn1xo5duPcRtQQfxd5UsvYbhW1nxZNcKRM8hHo4GxLo55pf7ZUHRRP3SGRH6
 Tnqsy5RIF3rIpthKF73yQZRbhTRiyFKtMuRM15O59YINwOYZxZOPZhd02hr7G+5MpZ0N
 2vm1Sa5sxGoOaema7m+uHQFCIc6hxP4xHTcu48g7G0zFWxDkF8Lw4l4BTooUlIsoI/1L
 L3FQ==
X-Gm-Message-State: AGi0Puaf/qdfFa9DqxwEDeymOiUdfwQVQP2ik+0lr/1X0JncFVuLPPny
 ZzGmsuxXX48deAsTmwrRS2J1kb4d6HY=
X-Google-Smtp-Source: APiQypKq25z8WYE/aRkch683i5iyuTbIfI0TVx0ph7gblDlRnCgn3y7XwVWXOQBimhp3i069YWPgMw==
X-Received: by 2002:a2e:9886:: with SMTP id b6mr11205677ljj.237.1587405179944; 
 Mon, 20 Apr 2020 10:52:59 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id s7sm79548lfb.40.2020.04.20.10.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 10:52:59 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] target/microblaze: Add the pvr-user2 property
Date: Mon, 20 Apr 2020 19:52:50 +0200
Message-Id: <20200420175250.25777-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420175250.25777-1-edgar.iglesias@gmail.com>
References: <20200420175250.25777-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::242
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 2 ++
 target/microblaze/cpu.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 53027846c4..22d08dc8cb 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -196,6 +196,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
                         cpu->cfg.pvr_user1;
 
+    env->pvr.regs[1] = cpu->cfg.pvr_user2;
     env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
                         (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
                         (cpu->cfg.use_hw_mul ? PVR2_USE_HW_MUL_MASK : 0) |
@@ -294,6 +295,7 @@ static Property mb_properties[] = {
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


