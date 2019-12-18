Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD756C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FC821D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnR4Jk1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FC821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUsK-0003aM-FI
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUbq-0005GL-SL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUbn-0003so-25
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:23:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22304
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUbm-0003qk-Sv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJkfHcaxEpYm5hhWlCXM/SGv2lErq8lQvcIGyEnWk0o=;
 b=MnR4Jk1gKHfsXdEIhZ95mdYmJ5Kb8xU6yUWX8Kl7U2eVl/rfpasQm76ACS3kPL6LMrnPZ0
 nRX8V1U5+zNUJC/CEH5s3Psr7dnc9Y3+MPPGvveL96rfXUgKW9+HPLbxEeX7C1TrGotPfN
 iPpa/B8UiYoW+cEqoWCUtkWqa7XHCfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-z9CALGMjPMKswouCZ8xO_g-1; Wed, 18 Dec 2019 03:17:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCB5185432F;
 Wed, 18 Dec 2019 08:17:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E98D1001281;
 Wed, 18 Dec 2019 08:17:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FC8811384AA; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/35] hw/ipmi: Fix realize() error API violations
Date: Wed, 18 Dec 2019 09:16:55 +0100
Message-Id: <20191218081721.23520-10-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: z9CALGMjPMKswouCZ8xO_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

isa_ipmi_bt_realize(), ipmi_isa_realize(), pci_ipmi_bt_realize(), and
pci_ipmi_kcs_realize() dereference @errp when IPMIInterfaceClass
method init() fails.  That's wrong; see the big comment in error.h.
Introduced in commit 0719029c47 "ipmi: Add an ISA KCS low-level
interface", then imitated in commit a9b74079cb "ipmi: Add a BT
low-level interface" and commit 12f983c6aa "ipmi: Add PCI IPMI
interfaces".

No caller actually passes null.

Fix anyway: splice in a local Error *err, and error_propagate().

Cc: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191204093625.14836-9-armbru@redhat.com>
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


