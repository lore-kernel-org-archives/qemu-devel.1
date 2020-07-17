Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB69BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F10206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPSTAZEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F10206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJZV-0006Eg-QT
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3OD8RXwsKCvkitljoofnpfohpphmf.dpnrfnv-efwfmopohov.psh@flex--hskinnemoen.bounces.google.com>)
 id 1jwJTA-0003xA-O8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:40 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:43532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3OD8RXwsKCvkitljoofnpfohpphmf.dpnrfnv-efwfmopohov.psh@flex--hskinnemoen.bounces.google.com>)
 id 1jwJT8-0005K1-8k
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:40 -0400
Received: by mail-pg1-x54a.google.com with SMTP id s1so7183150pgq.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 23:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=WJHL2RP44qCbss7g+JVirS3Ai2qR2QDTEKM2FUYBsXc=;
 b=rPSTAZEEnJFFlS9nxAmAJbo2rnYRy805xv0Vmxg0h56mLiD9Y2rSI/5T5NK0C3Tx/k
 F4bHAc3HzCrriaKBmsKkyyz2bTgDT2YUp8bZOlSqta2gMtpNaTRuqqm3V3MuNJ/+WzXL
 qNwW932hkJ/P57oLpwSyVdFcbwskJ+41JL2NCW+qMPv+2p+BfDztHzF/OeKYHk5bxt/o
 dEri+Uk3lxVd0bnTUaf3mdp20DgpKzg4TngTPTSYV4BdlxOdkbbeKvlTFiZhYCMvgpQN
 XXtuzdG+5K+Dm4qvE9eNlmkMJKT4swZ+/VTYYoYdXTI8g9yONg7xSv8y3IsNwSkyfFEz
 R7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=WJHL2RP44qCbss7g+JVirS3Ai2qR2QDTEKM2FUYBsXc=;
 b=T6zb54poN3yEprxuET8XhiJGYL0ruiv3YvNK8sYo9G9smW59+4ZtrVDMBkgGnsXUvV
 E17zvdbamnR3XFzZLZyYFVLq1owmScPymjkutNBHcrIZ1qthsUAJoLpX1gakexhcrAjB
 WExq2WrshmNOvpj7b+V7HwD4hhbgqwnKZW8ySIMCy2wvx6dwYHseUxNq7fspPQtHdibn
 u66VHhNiieT4ABiYxK9Bvz6PhlKde2g/wjMo0Kd5ZSotVs15Dpqgg4QKMR4h0NJPJTAV
 7vAcBZe659wynYGsatmdxB7XuALpdLSLexaCobDxAhxobz4q15nPM8tOSEcoYWqLF2aP
 fOSQ==
X-Gm-Message-State: AOAM530crV2WnHlbokUbDLB0N5aVq7BOvUK0CRE9bFXzG0PMwzShf9sX
 qhThnT6aR0Pik+S1fDZk6ToIDWM7Qu1W+HTijk2PEhe2SFAi/51n1zHacUSJf4raqCO9/YjOx2p
 xWMl0zWANvK93VwdFdWZNrqOL6XMH8HSvGT8OMyci7/OLDZZ0HPDGEdnAzKbH7O5uUk1nCJ6F8Q
 ==
X-Google-Smtp-Source: ABdhPJwtyHoqz+6ND2K9RPjOQsytC1rJ0+fEOe019Dbo/Bk8GLmQ9l1ZGMFXF29qzmYQuinXJNxvWs9cbMalxVloAQ==
X-Received: by 2002:a63:135b:: with SMTP id 27mr7564767pgt.37.1594965816178;
 Thu, 16 Jul 2020 23:03:36 -0700 (PDT)
Date: Thu, 16 Jul 2020 23:02:57 -0700
In-Reply-To: <20200717060258.1602319-1-hskinnemoen@google.com>
Message-Id: <20200717060258.1602319-13-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v6 12/13] docs/system: Add Nuvoton machine documentation
From: Havard Skinnemoen <hskinnemoen@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3OD8RXwsKCvkitljoofnpfohpphmf.dpnrfnv-efwfmopohov.psh@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 docs/system/arm/nuvoton.rst | 90 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst  |  1 +
 2 files changed, 91 insertions(+)
 create mode 100644 docs/system/arm/nuvoton.rst

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
new file mode 100644
index 0000000000..36bf901122
--- /dev/null
+++ b/docs/system/arm/nuvoton.rst
@@ -0,0 +1,90 @@
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
--=20
2.28.0.rc0.105.gf9edc3c819-goog


