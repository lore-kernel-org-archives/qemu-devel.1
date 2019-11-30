Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1543EC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16C220732
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRMgFg7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16C220732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8pu-0003qo-TR
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 14:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8dx-0006aB-SO
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8du-0005Cz-MU
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8ds-000578-Oz
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t/HhgZjzhBdRwBHKCZ+80RD28r4jF7bHY7IRHnb69k=;
 b=eRMgFg7Rq3sdymqbRdb5i9H8x7ri+4DviFyB7XDLKKYxvJkmwQrZLcQtvwCAozcgx1ytJc
 phuwWFdmCA3xxzcW4mmELA2/EY1areFZY/aUpZG2WxQpiBakz0dYpGqr7m7vWkayDoG8lC
 CihwLqJ1R+oSTGMA8MRuDjxXOI9f/ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-YSDmZVBYMWe0y6c7WTE_LQ-1; Sat, 30 Nov 2019 14:42:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A1F210054E3;
 Sat, 30 Nov 2019 19:42:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE96819C58;
 Sat, 30 Nov 2019 19:42:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29B2A11366F2; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/21] hw/ipmi: Fix latent realize() error handling bugs
Date: Sat, 30 Nov 2019 20:42:30 +0100
Message-Id: <20191130194240.10517-12-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YSDmZVBYMWe0y6c7WTE_LQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Corey Minyard <cminyard@mvista.com>, vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

isa_ipmi_bt_realize(), ipmi_isa_realize(), pci_ipmi_bt_realize(), and
pci_ipmi_kcs_realize() crash when IPMIInterfaceClass method init()
fails and their @errp argument is null.  First messed up in commit
0719029c47 "ipmi: Add an ISA KCS low-level interface", then imitated
in commit a9b74079cb "ipmi: Add a BT low-level interface" and commit
12f983c6aa "ipmi: Add PCI IPMI interfaces".

The bug can't bite as no caller actually passes null, and none of the
init() methods can actually fail.  Fix it anyway.

Cc: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ipmi/isa_ipmi_bt.c  | 7 +++++--
 hw/ipmi/isa_ipmi_kcs.c | 7 +++++--
 hw/ipmi/pci_ipmi_bt.c  | 6 ++++--
 hw/ipmi/pci_ipmi_kcs.c | 6 ++++--
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 9a87ffd3f0..9fba5ed383 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -70,6 +70,7 @@ static void isa_ipmi_bt_lower_irq(IPMIBT *ib)
=20
 static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
 {
+    Error *err =3D NULL;
     ISADevice *isadev =3D ISA_DEVICE(dev);
     ISAIPMIBTDevice *iib =3D ISA_IPMI_BT(dev);
     IPMIInterface *ii =3D IPMI_INTERFACE(dev);
@@ -85,9 +86,11 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error =
**errp)
     iib->bt.bmc->intf =3D ii;
     iib->bt.opaque =3D iib;
=20
-    iic->init(ii, 0, errp);
-    if (*errp)
+    iic->init(ii, 0, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
+    }
=20
     if (iib->isairq > 0) {
         isa_init_irq(isadev, &iib->irq, iib->isairq);
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index ca3ea36a3f..cc6bd817f2 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -69,6 +69,7 @@ static void isa_ipmi_kcs_lower_irq(IPMIKCS *ik)
=20
 static void ipmi_isa_realize(DeviceState *dev, Error **errp)
 {
+    Error *err =3D NULL;
     ISADevice *isadev =3D ISA_DEVICE(dev);
     ISAIPMIKCSDevice *iik =3D ISA_IPMI_KCS(dev);
     IPMIInterface *ii =3D IPMI_INTERFACE(dev);
@@ -84,9 +85,11 @@ static void ipmi_isa_realize(DeviceState *dev, Error **e=
rrp)
     iik->kcs.bmc->intf =3D ii;
     iik->kcs.opaque =3D iik;
=20
-    iic->init(ii, 0, errp);
-    if (*errp)
+    iic->init(ii, 0, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
+    }
=20
     if (iik->isairq > 0) {
         isa_init_irq(isadev, &iik->irq, iik->isairq);
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index 6ed925a665..ba9cf016b5 100644
--- a/hw/ipmi/pci_ipmi_bt.c
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -54,6 +54,7 @@ static void pci_ipmi_lower_irq(IPMIBT *ik)
=20
 static void pci_ipmi_bt_realize(PCIDevice *pd, Error **errp)
 {
+    Error *err =3D NULL;
     PCIIPMIBTDevice *pik =3D PCI_IPMI_BT(pd);
     IPMIInterface *ii =3D IPMI_INTERFACE(pd);
     IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
@@ -74,8 +75,9 @@ static void pci_ipmi_bt_realize(PCIDevice *pd, Error **er=
rp)
     pik->bt.raise_irq =3D pci_ipmi_raise_irq;
     pik->bt.lower_irq =3D pci_ipmi_lower_irq;
=20
-    iic->init(ii, 8, errp);
-    if (*errp) {
+    iic->init(ii, 8, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
     pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->bt.io);
diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
index eeba63baa4..99f46152f4 100644
--- a/hw/ipmi/pci_ipmi_kcs.c
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -54,6 +54,7 @@ static void pci_ipmi_lower_irq(IPMIKCS *ik)
=20
 static void pci_ipmi_kcs_realize(PCIDevice *pd, Error **errp)
 {
+    Error *err =3D NULL;
     PCIIPMIKCSDevice *pik =3D PCI_IPMI_KCS(pd);
     IPMIInterface *ii =3D IPMI_INTERFACE(pd);
     IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
@@ -74,8 +75,9 @@ static void pci_ipmi_kcs_realize(PCIDevice *pd, Error **e=
rrp)
     pik->kcs.raise_irq =3D pci_ipmi_raise_irq;
     pik->kcs.lower_irq =3D pci_ipmi_lower_irq;
=20
-    iic->init(ii, 8, errp);
-    if (*errp) {
+    iic->init(ii, 8, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
     pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->kcs.io);
--=20
2.21.0


