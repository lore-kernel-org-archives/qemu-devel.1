Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75D5C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9372D21721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9372D21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNpW-00050T-2l
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50324)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLl0-0002uL-S1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLko-0007pA-3v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:35:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59819 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hiLkn-0007jV-OJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:35:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 788E41A204A;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 54EB01A2161;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:35:20 +0200
Message-Id: <1562085328-5126-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 04/12] hw/mips: Express dependencies of the Jazz
 machine with Kconfig
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The Jazz use the RC4030 Asic to provide an EISA bus and DMA/IRQ.
The framebuffer display is managed by a G364, the network card is
a Sonic DP83932. A QLogic ESP216 provides a SCSI bus.

None, for the both machine variants (PICA-61 and Magnum 4000),
the DP83932 chipset is soldered on the board, and is MMIO-mapped
(selected via Chip Select). Therefore we have to enforce the
'select' Kconfig rule (we can not use the 'imply' rule helpful
when devices are connected on a bus).

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190701112612.14758-4-philmd@redhat.com>
---
 default-configs/mips-softmmu-common.mak |  1 -
 default-configs/mips64-softmmu.mak      |  5 -----
 default-configs/mips64el-softmmu.mak    |  5 -----
 hw/mips/Kconfig                         | 17 +++++++++++++++++
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index 63ed293..d545987 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -6,7 +6,6 @@ CONFIG_SEMIHOSTING=3Dy
 CONFIG_ISA_BUS=3Dy
 CONFIG_PCI=3Dy
 CONFIG_PCI_DEVICES=3Dy
-CONFIG_ESP=3Dy
 CONFIG_VGA_ISA=3Dy
 CONFIG_VGA_ISA_MM=3Dy
 CONFIG_VGA_CIRRUS=3Dy
diff --git a/default-configs/mips64-softmmu.mak b/default-configs/mips64-=
softmmu.mak
index bad7496..a169738 100644
--- a/default-configs/mips64-softmmu.mak
+++ b/default-configs/mips64-softmmu.mak
@@ -1,9 +1,4 @@
 # Default configuration for mips64-softmmu
=20
 include mips-softmmu-common.mak
-CONFIG_RC4030=3Dy
-CONFIG_DP8393X=3Dy
-CONFIG_DS1225Y=3Dy
 CONFIG_JAZZ=3Dy
-CONFIG_G364FB=3Dy
-CONFIG_JAZZ_LED=3Dy
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index a67c951..8b0c9b1 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -2,15 +2,10 @@
=20
 include mips-softmmu-common.mak
 CONFIG_IDE_VIA=3Dy
-CONFIG_RC4030=3Dy
-CONFIG_DP8393X=3Dy
-CONFIG_DS1225Y=3Dy
 CONFIG_FULONG=3Dy
 CONFIG_ATI_VGA=3Dy
 CONFIG_RTL8139_PCI=3Dy
 CONFIG_JAZZ=3Dy
-CONFIG_G364FB=3Dy
-CONFIG_JAZZ_LED=3Dy
 CONFIG_VT82C686=3Dy
 CONFIG_AHCI=3Dy
 CONFIG_MIPS_BOSTON=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 3433e97..ab00647 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -12,6 +12,23 @@ config MIPSSIM
=20
 config JAZZ
     bool
+    select ISA_BUS
+    select RC4030
+    select I8259
+    select I8254
+    select I8257
+    select PCSPK
+    select VGA_ISA_MM
+    select G364FB
+    select DP8393X
+    select ESP
+    select FDC
+    select MC146818RTC
+    select PCKBD
+    select SERIAL
+    select PARALLEL
+    select DS1225Y
+    select JAZZ_LED
=20
 config FULONG
     bool
--=20
2.7.4


