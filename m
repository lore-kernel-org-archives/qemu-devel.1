Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB2C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C98207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh2KY9iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C98207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QnJ-0002BY-LO
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1j4Qls-0000fk-PA
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1j4Qlr-0004r7-2O
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:56:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60896
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1j4Qlq-0004qI-Uw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582124173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HR2XT7gC89iPyG5V6Y+EvgjwK8TZ/ZRNtm7LW3nGxk8=;
 b=Lh2KY9iLlBoSTdNJXlvUwbaN07xp+1o3tTcD81VT9+tKJbqAQIIyTGn9ob76x7fBaK1Ozi
 wJARIHt2Cr0Slthwbi357Ov49aYvvYZSiCkFl4DgQGFRC+oW3UXeD/n07q80Nq7EpyES7+
 c9nf5cF9ZbPMxWzSVqyQru2fOeQVQV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-RHDzYcc2PHSdbyBh7SFJ5Q-1; Wed, 19 Feb 2020 09:56:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E65C4DB63
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 14:56:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-205-220.brq.redhat.com
 [10.40.205.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56DA562660;
 Wed, 19 Feb 2020 14:55:55 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] pcie_root_port: Add enable_hotplug option
Date: Wed, 19 Feb 2020 15:55:40 +0100
Message-Id: <20200219145540.648365-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: RHDzYcc2PHSdbyBh7SFJ5Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
    -device pcie-root-port,enable-hotplug=3Dfalse,...

If you want to disable hot-unplug on some downstream ports of one
switch, disable hot-unplug on PCIe Root Port connected to the upstream
port as well as on the selected downstream ports.

Discussion related:
    https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00530.html

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
v1: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04868.html

v2:
    * change name of the option to 'enable-hotplug' [Laine]
    * change order of enabling capability bits [Igor]
    * enable HPS bit [Igor]
    * add option to xio3130_downstream [J=C3=A1n]

 hw/pci-bridge/pcie_root_port.c     |  3 ++-
 hw/pci-bridge/xio3130_downstream.c |  3 ++-
 hw/pci/pcie.c                      | 11 +++++++----
 include/hw/pci/pcie.h              |  2 +-
 include/hw/pci/pcie_port.h         |  1 +
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.=
c
index 0ba4e4dea4..6eb2bc4564 100644
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
@@ -147,6 +147,7 @@ static Property rp_props[] =3D {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
+    DEFINE_PROP_BOOL("enable-hotplug", PCIESlot, enable_hotplug, true),
     DEFINE_PROP_END_OF_LIST()
 };
=20
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_dow=
nstream.c
index 153a4acad2..e8c388c547 100644
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
@@ -136,6 +136,7 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static Property xio3130_downstream_props[] =3D {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_BOOL("enable-hotplug", PCIESlot, enable_hotplug, true),
     DEFINE_PROP_END_OF_LIST()
 };
=20
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 08718188bb..a963c0f82e 100644
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
+    if (s->enable_hotplug) {
+        pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
+                                   PCI_EXP_SLTCAP_HPS |
+                                   PCI_EXP_SLTCAP_HPC);
+    }
=20
     if (dev->cap_present & QEMU_PCIE_SLTCAP_PCP) {
         pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
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
index 4b3d254b08..71be598dda 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -55,6 +55,7 @@ struct PCIESlot {
=20
     /* Disable ACS (really for a pcie_root_port) */
     bool        disable_acs;
+    bool        enable_hotplug;
     QLIST_ENTRY(PCIESlot) next;
 };
=20
--=20
2.24.1


