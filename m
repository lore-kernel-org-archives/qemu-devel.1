Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A47C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CCF206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUNrgMkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CCF206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjVqd-0000pP-65
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 18:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mbDiXgsKCoInyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com>)
 id 1jjVit-0004MR-OC
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:31:01 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:38275)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mbDiXgsKCoInyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com>)
 id 1jjViq-0004JL-Uy
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:59 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id f16so8310135ybp.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=8qcB9xOvPcuAny70mDIQDKyEJFo9RDirgwMbJw47Z1w=;
 b=sUNrgMkhiG9FAN623jrZZ9uR2oB6sFHVVjYWWryhaD7DvcmEAlaNJOrPPNo+zjU387
 Dro4s78fwK+O2Ml5jwNdC+JjlbhTMc2zbHNVzHtT8Hc/kEixlSmaLPx6LdQzY46abw/o
 I0Ew6erkb6jd3PJJXcv6pAuawUgyaDeNHton/aFmsDKObvAUVXnckAKTcnw67WPr5PpM
 PXrPsQazbuI2uwh13OAhY/peohbAXMtSywE5V0IiBo13kzXvU6WfnaixrjXb5ESkylsU
 mjNNgkQGmcc16INa8hMO5ETIr6id8HwppCXKmpVIun/0hEP8sjJsonznGN+UkLqXuIhO
 NqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=8qcB9xOvPcuAny70mDIQDKyEJFo9RDirgwMbJw47Z1w=;
 b=Fsim8YmbY8zen6JZ9ZSlBkjEQ2TuV5IzcI//AesNVC71ifWzou7trhJdeXLHzm/U1P
 TB7B3ihldjsNMYH0fJYHssll/c176xEAf7ew3eoAjo/4XaVuF3HlwLq0x1LDf7M11zAD
 up3S6m3AuU0Y3NAir+Y75eqF6yAKRfUHLIxDAsABB5MMxNdiCKwWhfjeLyTTxT0cD/c2
 xX5ctRY7Xd25qg3x4XGKE9O8Cnjzpo887gVC5j5/RX8GLXQslzJiFWvQgu29PpEq/FIC
 DBx0wgcjHfDPfs7WJY9zAxW3aCUbRhJ4xFfPN0Hkfirk9rf1JDNnaec5mkthjQLfHKtL
 Xb3w==
X-Gm-Message-State: AOAM531bmgCFwmnmoI5xke+C/HTrdumrpSPbzZL+15PWG5MOwkPQVOaF
 fkqkg+qk6vAPOpBYkpZqZrt4sNbrCLYiwAJiaQ==
X-Google-Smtp-Source: ABdhPJwCcLmKBCjdxbeRrblEgpV1tCZAJqRB8eUCHF79DOqi1ahJVEo81QgbTUD23wbrsJi0O0+6LsKNhQJw/0Pt/Q==
X-Received: by 2002:a25:ba4f:: with SMTP id z15mr17548372ybj.113.1591914649739; 
 Thu, 11 Jun 2020 15:30:49 -0700 (PDT)
Date: Thu, 11 Jun 2020 15:30:16 -0700
In-Reply-To: <20200611223016.259837-1-hskinnemoen@google.com>
Message-Id: <20200611223016.259837-13-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH v2 12/12] docs/system: Add Nuvoton machine documentation
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3mbDiXgsKCoInyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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

Change-Id: I88e437cb22a8441e0c0e672dfb57568ac81172d8
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 docs/system/arm/nuvoton.rst | 89 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst  |  1 +
 2 files changed, 90 insertions(+)
 create mode 100644 docs/system/arm/nuvoton.rst

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
new file mode 100644
index 0000000000..1ca34c0051
--- /dev/null
+++ b/docs/system/arm/nuvoton.rst
@@ -0,0 +1,89 @@
+Nuvoton iBMC boards (``npcm750-evb``, ``quanta-gsj``)
+=====================================================
+
+The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
+designed to be used as Baseboard Management Controllers (BMCs) in various
+servers. They all feature one or two ARM Cortex A9 CPU cores, as well as an
+assortment of peripherals targeted for either Enterprise or Data Center /
+Hyperscale applications. The former is a superset of the latter, so NPCM750 has
+all the peripherals of NPCM730 and more.
+
+.. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
+
+The NPCM750 SoC has two Cortex A9 cores and is targeted for the Enterprise
+segment. The following machines are based on this chip :
+
+- ``npcm750-evb``       Nuvoton NPCM750 Evaluation board
+
+The NPCM730 SoC has two Cortex A9 cores and is targeted for Data Center and
+Hyperscale applications. The following machines are based on this chip :
+
+- ``quanta-gsj``        Quanta GSJ server BMC
+
+There are also two more SoCs, NPCM710 and NPCM705, which are single-core
+variants of NPCM750 and NPCM730, respectively. These are currently not
+supported by QEMU.
+
+Supported devices
+-----------------
+
+ * SMP (Dual Core Cortex-A9)
+ * Cortex-A9MPCore built-in peripherals: SCU, GIC, Global Timer, Private Timer
+   and Watchdog.
+ * SRAM, ROM and DRAM mappings
+ * System Global Control Registers (GCR)
+ * Clock and reset controller (CLK)
+ * Timer controller (TIM)
+ * Serial ports (16550-based)
+ * DDR4 memory controller (dummy interface indicating memory training is done)
+ * OTP controllers (no protection features)
+ * Flash Interface Unit (FIU; no protection features)
+
+Missing devices
+---------------
+
+ * GPIO controller
+ * LPC/eSPI host-to-BMC interface, including
+
+   * Keyboard and mouse controller interface (KBCI)
+   * Keyboard Controller Style (KCS) channels
+   * BIOS POST code FIFO
+   * System Wake-up Control (SWC)
+   * Shared memory (SHM)
+   * eSPI slave interface
+
+ * Ethernet controllers (GMAC and EMC)
+ * USB host (USBH)
+ * USB device (USBD)
+ * SMBus controller (SMBF)
+ * Peripheral SPI controller (PSPI)
+ * Analog to Digital Converter (ADC)
+ * SD/MMC host
+ * Random Number Generator (RNG)
+ * PECI interface
+ * Pulse Width Modulation (PWM)
+ * Tachometer
+ * PCI and PCIe root complex and bridges
+ * VDM and MCTP support
+ * Serial I/O expansion
+ * LPC/eSPI host
+ * Coprocessor
+ * Graphics
+ * Video capture
+ * Encoding compression engine
+ * Security features
+
+Boot options
+------------
+
+The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
+a kernel using the ``-kernel`` option.
+
+Booting a full firmware image requires a Boot ROM specified via the ``-bios``
+option to QEMU. The firmware image should be attached as an MTD drive. Example :
+
+.. code-block:: bash
+
+  $ qemu-system-arm -machine quanta-gsj -nographic \
+      -bios npcm7xx_bootrom.bin \
+      -drive file=image-bmc,if=mtd,bus=0,unit=0,format=raw
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 1bd477a293..38a9daa9b9 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -84,6 +84,7 @@ undocumented; you can get a complete list by running
    arm/aspeed
    arm/musicpal
    arm/nseries
+   arm/nuvoton
    arm/orangepi
    arm/palm
    arm/xscale
-- 
2.27.0.290.gba653c62da-goog


