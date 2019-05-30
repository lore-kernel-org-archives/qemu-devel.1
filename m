Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF91C072B1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1BA2489A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Bp4Omv7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1BA2489A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWDvm-0005mp-U9
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 01:48:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWDm3-0006Z6-QT
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWDm2-0004EK-TP
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:38:47 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hWDm2-00049q-HF; Thu, 30 May 2019 01:38:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DxFl5GqGz9s9N; Thu, 30 May 2019 15:38:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559194715;
	bh=Dc4e87KbcUk5ty+IGSWNE2GcGV1SyAd7CLeN6PnTLas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bp4Omv7xoDFa6FwoOEWmlCBt5y2lBUpGX8G35NnccmBbN1aJJ61lGUVW94P2xVryh
	D6/sux+9Ce7Am99LHSDwKWb9jx5FlJwVkuQkPiWnox/aJSmHX96HT5dd8H5CNfJAwN
	mRH2OQandfD9X15HmiatmtPNzh78CFU5/XDDHB2I=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Date: Thu, 30 May 2019 15:38:30 +1000
Message-Id: <20190530053831.22115-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530053831.22115-1-david@gibson.dropbear.id.au>
References: <20190530053831.22115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v2 7/8] spapr: Direct all PCI hotplug to host
 bridge, rather than P2P bridge
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
Cc: mdroth@linux.ibm.com, mst@redhat.com, groug@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A P2P bridge will attempt to handle the hotplug with SHPC, which doesn't
work in the PAPR environment.  Instead we want to direct all PCI hotplug
actions to the PAPR specific host bridge which will use the PAPR hotplug
mechanism.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 507fd50dd5..6dd8aaac33 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4094,6 +4094,17 @@ static HotplugHandler *spapr_get_hotplug_handler(M=
achineState *machine,
         object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
         return HOTPLUG_HANDLER(machine);
     }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        PCIDevice *pcidev =3D PCI_DEVICE(dev);
+        PCIBus *root =3D pci_device_root_bus(pcidev);
+        SpaprPhbState *phb =3D
+            (SpaprPhbState *)object_dynamic_cast(OBJECT(BUS(root)->paren=
t),
+                                                 TYPE_SPAPR_PCI_HOST_BRI=
DGE);
+
+        if (phb) {
+            return HOTPLUG_HANDLER(phb);
+        }
+    }
     return NULL;
 }
=20
--=20
2.21.0


