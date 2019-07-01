Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5270C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A876321473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A876321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7aH-0006gv-W4
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47114)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi3xK-0000gV-EM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi3xI-0002Hl-4Q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi3xC-00029M-8Y; Mon, 01 Jul 2019 17:35:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7BFE3082E72;
 Mon,  1 Jul 2019 19:50:17 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8E0D379F;
 Mon,  1 Jul 2019 19:50:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 21:49:39 +0200
Message-Id: <20190701194942.10092-6-philmd@redhat.com>
In-Reply-To: <20190701194942.10092-1-philmd@redhat.com>
References: <20190701194942.10092-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 01 Jul 2019 19:50:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 5/8] RFC target/arm: Do not build pre-ARMv7
 cpus when using KVM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A KVM-only build won't be able to run pre-ARMv7 cpus, disable them.

If KVM is not enabled, they are enabled by default.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Sadly this does not work with --enable-tcg --enable-kvm dual config.
---
 default-configs/arm-softmmu.mak | 33 ++++++++++++++++-----------------
 hw/arm/Kconfig                  | 26 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 1f2e0e7fde..081d507c87 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -9,34 +9,33 @@ CONFIG_ARM_V7M=3Dy
 CONFIG_ARM_VIRT=3Dy
 CONFIG_CUBIEBOARD=3Dy
 CONFIG_EXYNOS4=3Dy
-CONFIG_HIGHBANK=3Dy
-CONFIG_INTEGRATOR=3Dy
 CONFIG_FSL_IMX31=3Dy
-CONFIG_MUSICPAL=3Dy
 CONFIG_MUSCA=3Dy
-CONFIG_CHEETAH=3Dy
-CONFIG_SX1=3Dy
-CONFIG_NSERIES=3Dy
 CONFIG_STELLARIS=3Dy
 CONFIG_REALVIEW=3Dy
-CONFIG_VERSATILE=3Dy
 CONFIG_VEXPRESS=3Dy
 CONFIG_ZYNQ=3Dy
-CONFIG_MAINSTONE=3Dy
-CONFIG_GUMSTIX=3Dy
-CONFIG_SPITZ=3Dy
-CONFIG_TOSA=3Dy
-CONFIG_Z2=3Dy
-CONFIG_COLLIE=3Dy
-CONFIG_ASPEED_SOC=3Dy
 CONFIG_NETDUINO2=3Dy
 CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
-CONFIG_DIGIC=3Dy
 CONFIG_SABRELITE=3Dy
 CONFIG_EMCRAFT_SF2=3Dy
-CONFIG_MICROBIT=3Dy
-CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
 CONFIG_SEMIHOSTING=3Dy
+#CONFIG_CHEETAH=3Dy
+#CONFIG_SX1=3Dy
+#CONFIG_DIGIC=3Dy
+#CONFIG_INTEGRATOR=3Dy
+#CONFIG_MUSICPAL=3Dy
+#CONFIG_MAINSTONE=3Dy
+#CONFIG_GUMSTIX=3Dy
+#CONFIG_SPITZ=3Dy
+#CONFIG_TOSA=3Dy
+#CONFIG_COLLIE=3Dy
+#CONFIG_VERSATILE=3Dy
+#CONFIG_FSL_IMX25=3Dy
+#CONFIG_ASPEED_SOC=3Dy
+#CONFIG_NSERIES=3Dy
+#CONFIG_HIGHBANK=3Dn
+#CONFIG_MICROBIT=3Dn
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ab65ecd216..b4d31c6026 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -1,3 +1,18 @@
+config ARM_V4
+    default y
+    depends on !KVM
+    bool
+
+config ARM_V5
+    default y
+    depends on !KVM
+    bool
+
+config ARM_V6
+    default y
+    depends on !KVM
+    bool
+
 config ARM_VIRT
     bool
     imply PCI_DEVICES
@@ -23,6 +38,7 @@ config ARM_VIRT
=20
 config CHEETAH
     bool
+    select ARM_V4
     select OMAP
     select TSC210X
=20
@@ -32,6 +48,7 @@ config CUBIEBOARD
=20
 config DIGIC
     bool
+    select ARM_V5
     select PTIMER
     select PFLASH_CFI02
=20
@@ -61,6 +78,7 @@ config HIGHBANK
=20
 config INTEGRATOR
     bool
+    select ARM_V5
     select ARM_TIMER
     select INTEGRATOR_DEBUG
     select PL011 # UART
@@ -84,6 +102,7 @@ config MUSCA
=20
 config MUSICPAL
     bool
+    select ARM_V5
     select BITBANG_I2C
     select MARVELL_88W8618
     select PTIMER
@@ -97,6 +116,7 @@ config NETDUINO2
=20
 config NSERIES
     bool
+    select ARM_V6
     select OMAP
     select TMP105   # tempature sensor
     select BLIZZARD # LCD/TV controller
@@ -119,6 +139,7 @@ config OMAP
=20
 config PXA2XX
     bool
+    select ARM_V5
     select FRAMEBUFFER
     select I2C
     select SERIAL
@@ -229,10 +250,12 @@ config COLLIE
=20
 config SX1
     bool
+    select ARM_V4
     select OMAP
=20
 config VERSATILE
     bool
+    select ARM_V5
     select ARM_TIMER # sp804
     select PFLASH_CFI01
     select LSI_SCSI_PCI
@@ -321,6 +344,7 @@ config XLNX_VERSAL
=20
 config FSL_IMX25
     bool
+    select ARM_V5
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -328,6 +352,7 @@ config FSL_IMX25
=20
 config FSL_IMX31
     bool
+    select ARM_V6
     select SERIAL
     select IMX
     select IMX_I2C
@@ -343,6 +368,7 @@ config FSL_IMX6
=20
 config ASPEED_SOC
     bool
+    select ARM_V5
     select DS1338
     select FTGMAC100
     select I2C
--=20
2.20.1


