Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD8CC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E819B20787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjbGefJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E819B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Qq-0004Av-19
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IZ-0008Ef-AZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IU-0001BQ-BC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:07 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:46742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jU6IT-00018M-S0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:01 -0400
Received: by mail-lf1-x131.google.com with SMTP id g10so734304lfj.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JgBptNqOPoZTQggyi+6DOXOV2a/1fkdOa8Q/I6vP82s=;
 b=bjbGefJgBdONjOv7DYHErPqlXJeqD4tOyygcruRGTSH8GLO3f7LgpYeF797qHGDwDs
 6AMoL9Kz+3gbQ0arSRRpkl6wuLICZY1CqklEm0mnR5a50jHOQiSww1LnHueZk9BAE5I3
 PLoycvXfkJiUfn/t57BeCb2gmzqKUmJM+iTpe2SLPsaZuV8tdVH/Fy29I9E+8FaMMNZa
 8LkNvTEjV0WU0RzdwX138GkLwNnDn8YnpD7iDZ0g4jngmLkDu53ndTYJUByAltYZjY/E
 +o7gjF49zjn3uMHNx1Vqrol8tPwGcObfa3uH1xXPDZZy7Yb58FQvQrd2nmn3llRCXORD
 p5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JgBptNqOPoZTQggyi+6DOXOV2a/1fkdOa8Q/I6vP82s=;
 b=Cc3QgD8gJMFDpsT6R4jcWpXXW1zYuD7hyp57fzQ7IjWLUOptxTGP5TR/1GJrQQ32iP
 eVQa9N3A1fe4pRcKFtL0fLkgPNuUVQzQ58350Jg6xahLj4M7Ohn4owBKe6Pe46OSgOgj
 WOlseBv2eASfKgAQo3KRo5OSDNF5DnekZeZkuc7Fw0UFvAaJZ+d+TYCiCvcRLGE4JFTi
 aYrTrs6AqgF192TNOahEcxoc6YMItVn/skIisRFpnLBpDlwUCHOI3OT3nTrindj7uWw+
 eapC2Nz+suAKru1brNGN7+Em9j2x9UfWV81pVxqSre/AxAk1AF4Gu9/FJcaLln3SrTi8
 te2g==
X-Gm-Message-State: AGi0Pua3xSeQKZFEnDloPKRpi+ntaScdECoMVdZLf4BjhkKPtWP8iZPN
 FUgymc50j0NZZ5QG/PiKSmuHVqK0fVI=
X-Google-Smtp-Source: APiQypLY1vpWuQk8MZdfmSUuE7FxCiSX56T4rvCpoA+d1ogxiOCVB9gVtIe5X+Hp8inH/nZ5t//6kg==
X-Received: by 2002:a19:6448:: with SMTP id b8mr1654720lfj.18.1588241999997;
 Thu, 30 Apr 2020 03:19:59 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id m22sm4039034lji.75.2020.04.30.03.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 03:19:59 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 6/6] target/microblaze: Add the pvr-user2 property
Date: Thu, 30 Apr 2020 12:19:49 +0200
Message-Id: <20200430101949.7754-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430101949.7754-1-edgar.iglesias@gmail.com>
References: <20200430101949.7754-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x131.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::131
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

Add the pvr-user2 property to control the user-defined
PVR1 User2 register.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h | 1 +
 target/microblaze/cpu.c | 2 ++
 2 files changed, 3 insertions(+)

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
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index df5ee21dd6..aa9983069a 100644
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
 
-- 
2.20.1


