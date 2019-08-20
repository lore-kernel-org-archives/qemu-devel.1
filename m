Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C05C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2896622CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2896622CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i072e-0004EY-D9
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1i071i-0003lh-Bq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1i071g-0005Y1-Rh
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:30:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1i071g-0005WZ-K9
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:30:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 40BFD102BB36
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 16:30:27 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-111.brq.redhat.com
 [10.40.204.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE6E160BF4;
 Tue, 20 Aug 2019 16:30:17 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 18:30:05 +0200
Message-Id: <20190820163005.1880-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 20 Aug 2019 16:30:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] virtio-pci: Add Function Level Reset support
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using FLR becomes convenient in cases where resetting the bus is
impractical, for example, when debugging the behavior of individual
functions.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
Requires definition of 4.2 machines:
Based-on: <20190724103524.20916-1-cohuck@redhat.com>

v2:
    Add compatibility property "x-pcie-flr-init"

 hw/core/machine.c      |  4 +++-
 hw/virtio/virtio-pci.c | 10 ++++++++++
 hw/virtio/virtio-pci.h |  4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 83cd1bfeec..829ada099e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,7 +27,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
=20
-GlobalProperty hw_compat_4_1[] =3D {};
+GlobalProperty hw_compat_4_1[] =3D {
+    { "virtio-pci", "x-pcie-flr-init", "off" },
+};
 const size_t hw_compat_4_1_len =3D G_N_ELEMENTS(hw_compat_4_1);
=20
 GlobalProperty hw_compat_4_0[] =3D {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8babd92e59..0075b3e2af 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -601,6 +601,10 @@ static void virtio_write_config(PCIDevice *pci_dev, =
uint32_t address,
=20
     pci_default_write_config(pci_dev, address, val, len);
=20
+    if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
+        pcie_cap_flr_write_config(pci_dev, address, val, len);
+    }
+
     if (range_covers_byte(address, len, PCI_COMMAND) &&
         !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
         virtio_pci_stop_ioeventfd(proxy);
@@ -1777,6 +1781,10 @@ static void virtio_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
             pcie_ats_init(pci_dev, 256);
         }
=20
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
+            /* Set Function Level Reset capability bit */
+            pcie_cap_flr_init(pci_dev);
+        }
     } else {
         /*
          * make future invocations of pci_is_express() return false
@@ -1844,6 +1852,8 @@ static Property virtio_pci_properties[] =3D {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 292275acb1..e2eaaa9182 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -44,6 +44,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
     VIRTIO_PCI_FLAG_INIT_PM_BIT,
+    VIRTIO_PCI_FLAG_INIT_FLR_BIT,
 };
=20
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -80,6 +81,9 @@ enum {
 /* Init Power Management */
 #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
=20
+/* Init Function Level Reset capability */
+#define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
--=20
2.21.0


