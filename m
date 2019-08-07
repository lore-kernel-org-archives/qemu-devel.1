Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B447C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64574217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64574217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHE9-0003XC-MR
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jusual@redhat.com>) id 1hvHDn-000389-FG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1hvHDm-0006H4-FD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:22:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1hvHDm-0006Gl-A3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:22:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0A553086202
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 08:22:56 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ACDF60BE1;
 Wed,  7 Aug 2019 08:22:51 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 10:22:41 +0200
Message-Id: <20190807082241.23984-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 07 Aug 2019 08:22:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] virtio-pci: Add Function Level Reset support
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
Cc: Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using FLR becomes convenient in cases where resetting the bus is
impractical, for example, when debugging the behavior of individual
functions.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 hw/virtio/virtio-pci.c | 10 ++++++++++
 hw/virtio/virtio-pci.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f6d2223e78..37c5d6efbc 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -599,6 +599,10 @@ static void virtio_write_config(PCIDevice *pci_dev, =
uint32_t address,
=20
     pci_default_write_config(pci_dev, address, val, len);
=20
+    if (proxy->has_flr) {
+        pcie_cap_flr_write_config(pci_dev, address, val, len);
+    }
+
     if (range_covers_byte(address, len, PCI_COMMAND) &&
         !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
         virtio_pci_stop_ioeventfd(proxy);
@@ -1718,6 +1722,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, =
Error **errp)
     proxy->notify_pio.size =3D 0x4;
     proxy->notify_pio.type =3D VIRTIO_PCI_CAP_NOTIFY_CFG;
=20
+    proxy->has_flr =3D false;
+
     /* subclasses can enforce modern, so do this unconditionally */
     memory_region_init(&proxy->modern_bar, OBJECT(proxy), "virtio-pci",
                        /* PCI BAR regions must be powers of 2 */
@@ -1749,6 +1755,10 @@ static void virtio_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
=20
         pci_dev->exp.pm_cap =3D pos;
=20
+        /* Set Function Level Reset capability bit */
+        pcie_cap_flr_init(pci_dev);
+        proxy->has_flr =3D true;
+
         /*
          * Indicates that this function complies with revision 1.2 of th=
e
          * PCI Power Management Interface Specification.
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 292275acb1..16d293a6bf 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -152,6 +152,7 @@ struct VirtIOPCIProxy {
     VirtIOIRQFD *vector_irqfd;
     int nvqs_with_notifiers;
     VirtioBusState bus;
+    bool has_flr;
 };
=20
 static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
--=20
2.21.0


