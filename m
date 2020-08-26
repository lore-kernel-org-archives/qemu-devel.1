Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA021221E2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="OL6ihpjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA021221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwIH-000450-4J
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAwHT-0002jh-Kj
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:20:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAwHS-0003rc-1r
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:20:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id q14so1973192wrn.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c44qkFlOKXUdKobooSUxe/oVdeOQauF3Q5wyehIPnP8=;
 b=OL6ihpjdeiJpIp8RER8FI64chFnMMjrLnqq6c0vOok2OsVD/axJCg3MT+ZnuMZShA8
 HFPyYd04R1H+TJywjbB6pp1v82Q5/WrA47hRuzpT5HIqpKkXymZ4/nwDyIUgWTgNA2b3
 42g1fgKAY4q1bp9ggR+sfHZNG4odEJDTV+Up1Xqk1iN3KrAIJERyzFr3G0G1huR8KZYm
 orTVwmnTw1bW/pvMsgDDxl333PATy3lqTCW73yttPBVRKzPuZ+aAdqoOZdqzftpBZsDv
 20SKCtocLUYwYQgcY81SZZy1nGFgUnnA0tpgqIlfEecGxOdF9qwl3vAzpCPADBwsrSLA
 8KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c44qkFlOKXUdKobooSUxe/oVdeOQauF3Q5wyehIPnP8=;
 b=b5Ey2maPpYANSM7HdhZpns9GF1GZsBBoTwVZvhzVPABnYF2Q5x93HZsVhW9gBTeORy
 yrhjMDIx2QUgxBKQPNSvla6uh9iqnxHjhckgIq4q/xuqTVTrqPbdbMdSMYNms/eS37T2
 xiTOwSCLbxNmvfTLjPKVrYmTPeR7K9Asu+WY/EdqdeHsoIJB04EVjT/0FPbAeb365ABt
 gXAkSV83eMyX2hB84Fc7Gc/+PTRBXAE5r51GRFQzufS/0Er6BFIbmedIH8V93rNVMfU8
 TQsC0Lit7cKgEUsgL8wfRgQKwwTT64GYeGvlN5PSc47VQRi2t2tjulwLfvlz/HqF8Xl6
 nk2Q==
X-Gm-Message-State: AOAM531Y8LcVFxw7Op1+S9a+A89fOQt+MRHsg/BHh7O0m8yg0lTaOKUe
 Jr9z+Nj5gG+1Vwrsw9C45PbPtg==
X-Google-Smtp-Source: ABdhPJy6Y3TdyoYo5/TuHb1sUHVqYqZ0AM9ICAYfBwWaYTcDzDOG72s32xZZazqCg71vt3GPIsh1Nw==
X-Received: by 2002:a5d:5223:: with SMTP id i3mr13371938wra.58.1598451600622; 
 Wed, 26 Aug 2020 07:20:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id n7sm6604411wrs.2.2020.08.26.07.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 07:20:00 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 2/2] hw/arm/sbsa-ref : Add embedded controller in secure
 memory
Date: Wed, 26 Aug 2020 15:19:52 +0100
Message-Id: <20200826141952.136164-3-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826141952.136164-1-graeme@nuviainc.com>
References: <20200826141952.136164-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 rad@semihalf.com, qemu-devel@nongnu.org, f4bug@amsat.org, leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the previously created sbsa-ec device to the sbsa-ref machine in
secure memory so the PSCI implementation in ARM-TF can access it, but
not expose it to non secure firmware or OS except by via ARM-TF.

Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 2a7d9a61fc..8614709bfb 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -62,6 +62,7 @@ enum {
     SBSA_CPUPERIPHS,
     SBSA_GIC_DIST,
     SBSA_GIC_REDIST,
+    SBSA_SECURE_EC,
     SBSA_SMMU,
     SBSA_UART,
     SBSA_RTC,
@@ -107,6 +108,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
     [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
     [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
+    [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
     [SBSA_UART] =               { 0x60000000, 0x00001000 },
     [SBSA_RTC] =                { 0x60010000, 0x00001000 },
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
@@ -585,6 +587,16 @@ static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
     return board->fdt;
 }
 
+static void create_secure_ec(MemoryRegion *mem)
+{
+    hwaddr base = sbsa_ref_memmap[SBSA_SECURE_EC].base;
+    DeviceState *dev = qdev_new("sbsa-ec");
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+
+    memory_region_add_subregion(mem, base,
+                                sysbus_mmio_get_region(s, 0));
+}
+
 static void sbsa_ref_init(MachineState *machine)
 {
     unsigned int smp_cpus = machine->smp.cpus;
@@ -708,6 +720,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_pcie(sms);
 
+    create_secure_ec(secure_sysmem);
+
     sms->bootinfo.ram_size = machine->ram_size;
     sms->bootinfo.nb_cpus = smp_cpus;
     sms->bootinfo.board_id = -1;
-- 
2.25.1


