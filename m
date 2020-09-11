Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3D0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8782087C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bcJdW7xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8782087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGbZT-0006rX-HE
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 01:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XQlbXwsKCtwFQIGLLCKMCLEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--hskinnemoen.bounces.google.com>)
 id 1kGbVB-0006vF-4N
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:37 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049]:58313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XQlbXwsKCtwFQIGLLCKMCLEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--hskinnemoen.bounces.google.com>)
 id 1kGbV9-0002Pu-4X
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:36 -0400
Received: by mail-pj1-x1049.google.com with SMTP id i23so1426335pju.7
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=liTapuC83RP7pRfq/k3FrIdgT8TxzNl6M4ltibeisdU=;
 b=bcJdW7xJUy+m3oSHF3SJ7VO5xMfA0Bny3++0b3F9WTANgE1n6sDrHEtTmSIzRqraNQ
 cpqm/lJO6s8aI0jCZVX/m4XzXOdM9gC66Y8/9D8ATt4p3AVC04NP21swjrvb+ugyxZf2
 hM/Amzp+c0UC+47y+imbD8DYdHkRKoBvG3OVo17ooBS2qgA4OHxNo5XJ1ONYublY45gI
 dsV4G0Z6T5e7wLA4Sp58eBjdTHKF93YuhftTx2cVdDGwLgJ8PBry6iIFaZPlIHzCgfM8
 NmoAIiLXMRtyxZHXog3oylOOaLzuUQEs+S35qRIjYtAlf0r154K14NQygrFjMFl9sH+q
 O4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=liTapuC83RP7pRfq/k3FrIdgT8TxzNl6M4ltibeisdU=;
 b=V609jT2w/w101p3ETY75AZa0fOuGZc61LIQPY/V6yGY2fIpz40uZwcxh7i6lwcwrCk
 YPhfVEYTIt1ObVHgIIIRnbduz2/qFgirlFdR0q6M/0Z+NwpgKUeD0gA0KgkH8fzwdETC
 9rfYVrOR3bGEmFYxsoGABjPvpD1jlhp9u21/GwLvQD/GeGpU2QDAgsXz7J2hUszrghtW
 qdsyM7GEB4qpNF/Oow6uiqGs4FbGTYVxGYM2vMa7r8jQLQ10WZL44yYr1436atXaC5MZ
 eTm2BM8sSo14EmqsTk2Yk9dIUEBUE9e3Q+rkjcGfZnwEbtU4YAbHUROJRVIy5aasQkRh
 IRXg==
X-Gm-Message-State: AOAM532BQBiINgNE0gRUkV1oFVjA0nfKRn/7ueCsmIhErXm8S0/+UFXC
 xAJWB2ZGbVlAO6usPKfsaPPP9qFdTJOFlrNZxg==
X-Google-Smtp-Source: ABdhPJzZ/ttpK4sQGJ6KwkIKbcTZDH3P7zqL3dBIAz9Ovq0oezSbYZ+xkLAAIpeRyiR3ZBJxx6ahGx2R693n1EC9Fw==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:a17:902:c3d2:b029:d1:9bc8:15f8 with
 SMTP id j18-20020a170902c3d2b02900d19bc815f8mr577506plj.29.1599801693439;
 Thu, 10 Sep 2020 22:21:33 -0700 (PDT)
Date: Thu, 10 Sep 2020 22:21:00 -0700
In-Reply-To: <20200911052101.2602693-1-hskinnemoen@google.com>
Message-Id: <20200911052101.2602693-14-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200911052101.2602693-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v9 13/14] docs/system: Add Nuvoton machine documentation
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3XQlbXwsKCtwFQIGLLCKMCLEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--hskinnemoen.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 docs/system/arm/nuvoton.rst | 92 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst  |  1 +
 2 files changed, 93 insertions(+)
 create mode 100644 docs/system/arm/nuvoton.rst

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
new file mode 100644
index 0000000000..e3e1a3a3a7
--- /dev/null
+++ b/docs/system/arm/nuvoton.rst
@@ -0,0 +1,92 @@
+Nuvoton iBMC boards (``npcm750-evb``, ``quanta-gsj``)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that ar=
e
+designed to be used as Baseboard Management Controllers (BMCs) in various
+servers. They all feature one or two ARM Cortex A9 CPU cores, as well as a=
n
+assortment of peripherals targeted for either Enterprise or Data Center /
+Hyperscale applications. The former is a superset of the latter, so NPCM75=
0 has
+all the peripherals of NPCM730 and more.
+
+.. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
+
+The NPCM750 SoC has two Cortex A9 cores and is targeted for the Enterprise
+segment. The following machines are based on this chip :
+
+- ``npcm750-evb``       Nuvoton NPCM750 Evaluation board
+
+The NPCM730 SoC has two Cortex A9 cores and is targeted for Data Center an=
d
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
+ * Cortex-A9MPCore built-in peripherals: SCU, GIC, Global Timer, Private T=
imer
+   and Watchdog.
+ * SRAM, ROM and DRAM mappings
+ * System Global Control Registers (GCR)
+ * Clock and reset controller (CLK)
+ * Timer controller (TIM)
+ * Serial ports (16550-based)
+ * DDR4 memory controller (dummy interface indicating memory training is d=
one)
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
+The Nuvoton machines can boot from an OpenBMC firmware image, or directly =
into
+a kernel using the ``-kernel`` option. OpenBMC images for `quanta-gsj` and
+possibly others can be downloaded from the OpenPOWER jenkins :
+
+   https://openpower.xyz/
+
+The firmware image should be attached as an MTD drive. Example :
+
+.. code-block:: bash
+
+  $ qemu-system-arm -machine quanta-gsj -nographic \
+      -drive file=3Dimage-bmc,if=3Dmtd,bus=3D0,unit=3D0,format=3Draw
+
+The default root password for test images is usually ``0penBmc``.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index afdb37e738..fdcf25c237 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -86,6 +86,7 @@ undocumented; you can get a complete list by running
    arm/musicpal
    arm/gumstix
    arm/nseries
+   arm/nuvoton
    arm/orangepi
    arm/palm
    arm/xscale
--=20
2.28.0.526.ge36021eeef-goog


