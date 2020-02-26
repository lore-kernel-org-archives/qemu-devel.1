Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC9C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D880920801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV82peA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D880920801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70mQ-0003UZ-3L
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1j70lb-00032e-9u
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1j70lZ-0006aR-T8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:46:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1j70lZ-0006Zv-PM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582739197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Za2ZogXvn0EvFyVSakbCCBUtcuLatt/efqoSJEvgf2k=;
 b=dV82peA67FKpEfG1BE4HdqUl6voFLkgKhpsV+S1o1wiNi83ikZW8QLKW0PSA2o0QgCHZ4+
 YG0M03yOti+b0pf2+szj0NSaz9/GIds2X5oZ20u1J4edYKLE3z/4XvduDCl7zRK5fWs9Lx
 YMbyYJh48AqDtZ6gVn8YfFcWNX6x0LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-lPtyM1NINdKFkdPm35RoiA-1; Wed, 26 Feb 2020 12:46:31 -0500
X-MC-Unique: lPtyM1NINdKFkdPm35RoiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8126613F7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 17:46:30 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-53.ams2.redhat.com
 [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7C0B92966;
 Wed, 26 Feb 2020 17:46:12 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] pcie_root_port: Add hotplug disabling option
Date: Wed, 26 Feb 2020 18:46:07 +0100
Message-Id: <20200226174607.205941-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
manage it and restrict unplug for the whole machine. This is going to
prevent user-initiated unplug in guests (Windows mostly).
Hotplug is enabled by default.
Usage:
    -device pcie-root-port,hotplug=3Doff,...

If you want to disable hot-unplug on some downstream ports of one
switch, disable hot-unplug on PCIe Root Port connected to the upstream
port as well as on the selected downstream ports.

Discussion related:
    https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00530.html

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
v1: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04868.html

v2: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05192.html
    * change name of the option to 'enable-hotplug' [Laine]
    * change order of enabling capability bits [Igor]
    * enable HPS bit [Igor]
    * add option to xio3130_downstream [J=C3=A1n]

v3:
    * change name of the option to 'hotplug'. Naming is hard! [Laine]
    * move property under TYPE_PCIE_SLOT [Michael]

 hw/pci-bridge/pcie_root_port.c     |  2 +-
 hw/pci-bridge/xio3130_downstream.c |  2 +-
 hw/pci/pcie.c                      | 11 +++++++----
 hw/pci/pcie_port.c                 |  1 +
 include/hw/pci/pcie.h              |  2 +-
 include/hw/pci/pcie_port.h         |  3 +++
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.=
c
index 0ba4e4dea4..f1cfe9d14a 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -94,7 +94,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
=20
     pcie_cap_arifwd_init(d);
     pcie_cap_deverr_init(d);
-    pcie_cap_slot_init(d, s->slot);
+    pcie_cap_slot_init(d, s);
     pcie_cap_root_init(d);
=20
     pcie_chassis_create(s->chassis);
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_dow=
nstream.c
index 153a4acad2..04aae72cd6 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -94,7 +94,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Erro=
r **errp)
     }
     pcie_cap_flr_init(d);
     pcie_cap_deverr_init(d);
-    pcie_cap_slot_init(d, s->slot);
+    pcie_cap_slot_init(d, s);
     pcie_cap_arifwd_init(d);
=20
     pcie_chassis_create(s->chassis);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 08718188bb..0eb3a2a5d2 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -495,7 +495,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
=20
 /* pci express slot for pci express root/downstream port
    PCI express capability slot registers */
-void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
+void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
 {
     uint32_t pos =3D dev->exp.exp_cap;
=20
@@ -505,13 +505,16 @@ void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot=
)
     pci_long_test_and_clear_mask(dev->config + pos + PCI_EXP_SLTCAP,
                                  ~PCI_EXP_SLTCAP_PSN);
     pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
-                               (slot << PCI_EXP_SLTCAP_PSN_SHIFT) |
+                               (s->slot << PCI_EXP_SLTCAP_PSN_SHIFT) |
                                PCI_EXP_SLTCAP_EIP |
-                               PCI_EXP_SLTCAP_HPS |
-                               PCI_EXP_SLTCAP_HPC |
                                PCI_EXP_SLTCAP_PIP |
                                PCI_EXP_SLTCAP_AIP |
                                PCI_EXP_SLTCAP_ABP);
+    if (s->hotplug) {
+        pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
+                                   PCI_EXP_SLTCAP_HPS |
+                                   PCI_EXP_SLTCAP_HPC);
+    }
=20
     if (dev->cap_present & QEMU_PCIE_SLTCAP_PCP) {
         pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index f8263cb306..eb563ad435 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -147,6 +147,7 @@ static const TypeInfo pcie_port_type_info =3D {
 static Property pcie_slot_props[] =3D {
     DEFINE_PROP_UINT8("chassis", PCIESlot, chassis, 0),
     DEFINE_PROP_UINT16("slot", PCIESlot, slot, 0),
+    DEFINE_PROP_BOOL("hotplug", PCIESlot, hotplug, true),
     DEFINE_PROP_END_OF_LIST()
 };
=20
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 7064875835..14c58ebdb6 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -104,7 +104,7 @@ void pcie_cap_deverr_reset(PCIDevice *dev);
 void pcie_cap_lnkctl_init(PCIDevice *dev);
 void pcie_cap_lnkctl_reset(PCIDevice *dev);
=20
-void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
+void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s);
 void pcie_cap_slot_reset(PCIDevice *dev);
 void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_st=
a);
 void pcie_cap_slot_write_config(PCIDevice *dev,
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 4b3d254b08..caae57573b 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -55,6 +55,9 @@ struct PCIESlot {
=20
     /* Disable ACS (really for a pcie_root_port) */
     bool        disable_acs;
+
+    /* Indicates whether hot-plug is enabled on the slot */
+    bool        hotplug;
     QLIST_ENTRY(PCIESlot) next;
 };
=20
--=20
2.24.1


