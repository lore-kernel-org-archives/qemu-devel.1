Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF6BC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8892820738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtOr78qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8892820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEINZ-0005Rd-Pb
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEIMz-00051k-7J
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEIMx-0001A0-Ts
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:59:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEIMx-00011n-Mw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584475158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BA84pH+14KS8+bfqCP+c8HyMoCF0oKGQM9994HMIP0Q=;
 b=HtOr78qjV5QRNWQ7qFg7tghWoDYQfBstuNo7OQwutyLFWteYcHBVfV5Etxr/R+0YmDVWT6
 6qXp+naNK61BDB24j8O0YkgRAM1zsJlN2kAvPfQdhq2pXS2p6yyIGO9hzcWWvRxkTAiVlZ
 cKQGViHaqO2gkslGe0JBVEgxH34bZik=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-e_kLb3F4OMenGt4SbT3qxg-1; Tue, 17 Mar 2020 15:59:15 -0400
X-MC-Unique: e_kLb3F4OMenGt4SbT3qxg-1
Received: by mail-wr1-f71.google.com with SMTP id o9so11195942wrw.14
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q4pIB0ZPgJnM9CP3l8CIAYxfpkuox9s63qSN3wKNTTE=;
 b=hQFPKBNSCcJtJ0gbuYYFYJJTk4PIesU3/bqGTc1XRbuNUFRrEk2DQgKFvEgw82L3fH
 TuhaDKqQpeZH0kaP/vk2GotR1+GiN/ajuO+5OWb3Xshq7QLCS79BfElbQiYtC18XuslU
 Kv9u5i1cdisAMTllmdjdv0HzV5h12yUhNVpzB67wgR63xJ6Yy3CPUifQ7pOo+qEKNUoq
 lKORF8xaxDTvjpJ4wfQb7nSuLZx/CdftUErfbLjfFnSVez0EcwHeGftnQ2NyMTE4IIYm
 iJI16VmYUzqRTOLGmWedSvQk1UfCCN2wB4fczYD/04pkhBWjGY2rf513nFfbXMSzucEg
 iXaw==
X-Gm-Message-State: ANhLgQ2oKDWWEHyU53RlA/t13JBUdIHD17QKEtuxxYM40vIAkVGb6abI
 STmwNzEIoqrYJdFgIJx2h5xpJ6YdV8oLRfFqyDyLAd1WQuy1DmKJ3dIO86O6KoRomAIW9Ksw4wc
 IN4N2PTmdDzqIQR4=
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr709701wmj.39.1584475153570;
 Tue, 17 Mar 2020 12:59:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvEuQOBjaw+JZfxvYjLOATQReNb8VZNHd39Qord262DPup+xXNRkDQY340AFncNpKYvg089Ng==
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr709675wmj.39.1584475153207;
 Tue, 17 Mar 2020 12:59:13 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u17sm5110637wra.63.2020.03.17.12.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:59:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] pci: Display PCI IRQ pin in "info pci"
Date: Tue, 17 Mar 2020 15:59:08 -0400
Message-Id: <20200317195908.283800-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes it would be good to be able to read the pin number along
with the IRQ number allocated.  Since we'll dump the IRQ number, no
reason to not dump the pin information.  For example, the vfio-pci
device will overwrite the pin with the hardware pin number.  It would
be nice to know the pin number of one assigned device from QMP/HMP.

CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: Julia Suvorova <jusual@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

This helped me to debug an IRQ sharing issue, so may good to have it
in master too.
---
 hw/pci/pci.c       | 1 +
 monitor/hmp-cmds.c | 3 ++-
 qapi/misc.json     | 6 ++++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e1ed6677e1..7ebf532ac9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1769,6 +1769,7 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevice =
*dev, PCIBus *bus,
     info->regions =3D qmp_query_pci_regions(dev);
     info->qdev_id =3D g_strdup(dev->qdev.id ? dev->qdev.id : "");
=20
+    info->irq_pin =3D dev->config[PCI_INTERRUPT_PIN];
     if (dev->config[PCI_INTERRUPT_PIN] !=3D 0) {
         info->has_irq =3D true;
         info->irq =3D dev->config[PCI_INTERRUPT_LINE];
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 58724031ea..04c86bbb03 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -680,7 +680,8 @@ static void hmp_info_pci_device(Monitor *mon, const Pci=
DeviceInfo *dev)
     }
=20
     if (dev->has_irq) {
-        monitor_printf(mon, "      IRQ %" PRId64 ".\n", dev->irq);
+        monitor_printf(mon, "      IRQ %" PRId64 ", pin %c\n",
+                       dev->irq, (char)('A' + dev->irq_pin - 1));
     }
=20
     if (dev->has_pci_bridge) {
diff --git a/qapi/misc.json b/qapi/misc.json
index c18fe681fb..f8d33ddb4e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -403,6 +403,8 @@
 #
 # @irq: if an IRQ is assigned to the device, the IRQ number
 #
+# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
+#
 # @qdev_id: the device name of the PCI device
 #
 # @pci_bridge: if the device is a PCI bridge, the bridge information
@@ -417,8 +419,8 @@
 { 'struct': 'PciDeviceInfo',
   'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
            'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
-           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo'=
,
-           'regions': ['PciMemoryRegion']} }
+           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
+           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] =
}}
=20
 ##
 # @PciInfo:
--=20
2.24.1


