Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4338FC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173BF20989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173BF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53167 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6P2-00080U-8O
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 04:33:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQ6Lj-0005iz-1n
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQ6Le-0005c4-43
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:30:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hQ6LX-0005O9-IC; Mon, 13 May 2019 04:30:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C18781DFE;
	Mon, 13 May 2019 08:29:46 +0000 (UTC)
Received: from thuth.com (ovpn-116-122.ams2.redhat.com [10.36.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF13B60856;
	Mon, 13 May 2019 08:29:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Mon, 13 May 2019 10:29:40 +0200
Message-Id: <20190513082940.30295-3-thuth@redhat.com>
In-Reply-To: <20190513082940.30295-1-thuth@redhat.com>
References: <20190513082940.30295-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 13 May 2019 08:29:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 03/29] hw/ide/ahci: Add a Kconfig switch for
 the AHCI-ICH9 device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of our machines (like the ARM cubieboard) use CONFIG_AHCI for an AHC=
I
sysbus device, but do not use CONFIG_PCI since they do not feature a PCI
bus. With CONFIG_AHCI but without CONFIG_PCI, currently linking fails:

    ../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
    hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
    hw/ide/ich.c:126: undefined reference to `pci_register_bar'
    hw/ide/ich.c:128: undefined reference to `pci_register_bar'
    hw/ide/ich.c:131: undefined reference to `pci_add_capability'
    hw/ide/ich.c:147: undefined reference to `msi_init'
    ../hw/ide/ich.o: In function `pci_ich9_uninit':
    hw/ide/ich.c:158: undefined reference to `msi_uninit'
    ../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_pci=
_device'

We must only compile ich.c if CONFIG_PCI is available, too, so introduce =
a
new config switch for this device.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/Kconfig      | 2 +-
 hw/ide/Kconfig       | 6 +++++-
 hw/ide/Makefile.objs | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a6aed7c131..9817888216 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -80,7 +80,7 @@ config Q35
     select PC_ACPI
     select PCI_EXPRESS_Q35
     select LPC_ICH9
-    select AHCI
+    select AHCI_ICH9
     select DIMM
     select SMBIOS
     select VMPORT
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index ab47b6a7a3..5d9106b1ac 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -43,10 +43,14 @@ config MICRODRIVE
     select IDE_QDEV
=20
 config AHCI
+    bool
+    select IDE_QDEV
+
+config AHCI_ICH9
     bool
     default y if PCI_DEVICES
     depends on PCI
-    select IDE_QDEV
+    select AHCI
=20
 config IDE_SII3112
     bool
diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
index a142add90e..faf04e0209 100644
--- a/hw/ide/Makefile.objs
+++ b/hw/ide/Makefile.objs
@@ -9,6 +9,6 @@ common-obj-$(CONFIG_IDE_MMIO) +=3D mmio.o
 common-obj-$(CONFIG_IDE_VIA) +=3D via.o
 common-obj-$(CONFIG_MICRODRIVE) +=3D microdrive.o
 common-obj-$(CONFIG_AHCI) +=3D ahci.o
-common-obj-$(CONFIG_AHCI) +=3D ich.o
+common-obj-$(CONFIG_AHCI_ICH9) +=3D ich.o
 common-obj-$(CONFIG_ALLWINNER_A10) +=3D ahci-allwinner.o
 common-obj-$(CONFIG_IDE_SII3112) +=3D sii3112.o
--=20
2.21.0


