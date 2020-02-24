Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702E0C35669
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 04:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3296020656
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 04:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHH60lJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3296020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j65BZ-0002Be-Cp
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 23:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j65Am-0001ep-38
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 23:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j65Ak-0007JW-J5
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 23:16:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j65Ak-0007Iq-GE
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 23:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582517805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JC3y6mf5XDOlqH25YUz820mAiH7SqFSX5sGPp3pIDyI=;
 b=iHH60lJp/QAY9k39T6ij3F6FkekC3cowM7m4Rj9NkZD0884dQpTwm3A3Ye2p0EqGxz4b/E
 tICd7CDed01ymbJYN1BvJ8F0SahgGmKQrEC//TYtyPSoSdZE6ORnbs4L2I8046KA1nuOMR
 TWW3Tw1KCZ6cgyV2inzqaf4/CLGj1q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-t_2xYZUuO0m0Xq0sKEb1Lg-1; Sun, 23 Feb 2020 23:16:44 -0500
X-MC-Unique: t_2xYZUuO0m0Xq0sKEb1Lg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E911005510;
 Mon, 24 Feb 2020 04:16:42 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-48.bne.redhat.com
 [10.64.54.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5199039F;
 Mon, 24 Feb 2020 04:16:37 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH] hw/arm: Use TYPE_PL011 to create serial port
Date: Mon, 24 Feb 2020 15:16:33 +1100
Message-Id: <20200224041633.97345-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, radoslaw.biernacki@linaro.org,
 alistair@alistair23.me, shan.gavin@gmail.com, edgar.iglesias@gmail.com,
 leif@nuviainc.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This uses TYPE_PL011 when creating the serial port, to make the code
a bit more atomatic.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/sbsa-ref.c    | 3 ++-
 hw/arm/virt.c        | 3 ++-
 hw/arm/xlnx-versal.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9b5bcb5634..df0a165047 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -39,6 +39,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
+#include "hw/char/pl011.h"
 #include "net/net.h"
=20
 #define RAMLIMIT_GB 8192
@@ -409,7 +410,7 @@ static void create_uart(const SBSAMachineState *sms, in=
t uart,
 {
     hwaddr base =3D sbsa_ref_memmap[uart].base;
     int irq =3D sbsa_ref_irqmap[uart];
-    DeviceState *dev =3D qdev_create(NULL, "pl011");
+    DeviceState *dev =3D qdev_create(NULL, TYPE_PL011);
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
=20
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe27d6..d0da513737 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,6 +71,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/char/pl011.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -724,7 +725,7 @@ static void create_uart(const VirtMachineState *vms, in=
t uart,
     int irq =3D vms->irqmap[uart];
     const char compat[] =3D "arm,pl011\0arm,primecell";
     const char clocknames[] =3D "uartclk\0apb_pclk";
-    DeviceState *dev =3D qdev_create(NULL, "pl011");
+    DeviceState *dev =3D qdev_create(NULL, TYPE_PL011);
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
=20
     qdev_prop_set_chr(dev, "chardev", chr);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 1cf3daaf4f..403fc7b881 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -22,6 +22,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/arm/xlnx-versal.h"
+#include "hw/char/pl011.h"
=20
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define GEM_REVISION        0x40070106
@@ -144,7 +145,7 @@ static void versal_create_uarts(Versal *s, qemu_irq *pi=
c)
         DeviceState *dev;
         MemoryRegion *mr;
=20
-        dev =3D qdev_create(NULL, "pl011");
+        dev =3D qdev_create(NULL, TYPE_PL011);
         s->lpd.iou.uart[i] =3D SYS_BUS_DEVICE(dev);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fat=
al);
--=20
2.23.0


