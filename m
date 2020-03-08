Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAEAC10F27
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C08020866
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbK58jBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C08020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAw2q-0005at-Os
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAw1b-0004bo-FW
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAw1a-0006XG-2Y
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAw1Z-0006X6-UP
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583674281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9veurr0bVAUl9SJ9izzgqs6lZHPE6eFmxhhkeZd96o=;
 b=ZbK58jBnHAzgVf9IX/yTbscPQxUg99mG/kEiPM52ljk/uSg5DDm8mWNWUHnFIS0N4Bqp16
 27hJBm/jHc1rRthbVBkm9bQly9AOhnFrSuozdAI1hYKOcp1ynOGmRjPfnGv3jUfxCFXpWH
 XpmC4ddNqyqqY5eDUj3jUB7Vdn7zems=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-AGlfgTvfN4qKceF-Fk637w-1; Sun, 08 Mar 2020 09:31:17 -0400
X-MC-Unique: AGlfgTvfN4qKceF-Fk637w-1
Received: by mail-qt1-f198.google.com with SMTP id s5so4974462qtn.7
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sPR7bFwttTJ4CS+d9j33a/ao0m9kS2OHt9GwMOGXMPM=;
 b=OyO2lOHYiwpMFyk/dZw2n9bmfWX2N5f/aj0MUeghd1DawIhu+T0Zu7C5f5lueW52Nh
 UwhYe+no324hBVblzHHpodiofIltp0pW0Yd4msZCSpiBhEVBZivUXTZa0KoyiykoFk8m
 eo6RCT28pZ62VipxVb0HZNbwBG81angIfT+gOkVJjHvGFsXYcYbEf2UmBfwQogZx5G7m
 sL1uNAhXDfJaSAlMrUgCd20xWaSM62ONQ5pFSZ4z6883U9p1yfv90H8rO84brZnHSrMZ
 gA98OdDvJZuQkmLqjgc68x4B6uh39EYNYD+1tp4kbSZ/NedAi2xYe7JzPpiz2MmoyiOB
 OZdA==
X-Gm-Message-State: ANhLgQ3jLv8JVoQIFK2ipdEVUjOHpzBdsRlo28PL5ELXehJznbrXEBHl
 1P2Fi6iY6pAwANFH497skaUS+S0JZDp/hBbwKBPyJE6P97C1/y8qCTBmm+Cm50yVVYIfEuc/tgg
 wqiau1NnnZ7UsiiU=
X-Received: by 2002:ac8:76d7:: with SMTP id q23mr10782870qtr.198.1583674276370; 
 Sun, 08 Mar 2020 06:31:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuznm5b81Jzfxd8BY4vqRaKYllxwO8yuVLSvSd3wlzyFVBMmFPFdfEjTyy7zdLPmaBAb07prw==
X-Received: by 2002:ac8:76d7:: with SMTP id q23mr10782853qtr.198.1583674276108; 
 Sun, 08 Mar 2020 06:31:16 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id o35sm5934707qtk.5.2020.03.08.06.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 06:31:15 -0700 (PDT)
Date: Sun, 8 Mar 2020 09:31:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] pcie_root_port: Add hotplug disabling option
Message-ID: <20200308133054.1563705-2-mst@redhat.com>
References: <20200308133054.1563705-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308133054.1563705-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
 Julia Suvorova <jusual@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julia Suvorova <jusual@redhat.com>

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
Message-Id: <20200226174607.205941-1-jusual@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
---
 include/hw/pci/pcie.h              |  2 +-
 include/hw/pci/pcie_port.h         |  3 +++
 hw/pci-bridge/pcie_root_port.c     |  2 +-
 hw/pci-bridge/xio3130_downstream.c |  2 +-
 hw/pci/pcie.c                      | 11 +++++++----
 hw/pci/pcie_port.c                 |  1 +
 6 files changed, 14 insertions(+), 7 deletions(-)

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
--=20
MST


