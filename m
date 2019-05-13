Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D511C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E3220989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZMeXejUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E3220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4QN-0000aQ-CF
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:26:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ4JT-0002hP-Dn
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ4JS-0004NR-22
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:19:51 -0400
Received: from ozlabs.org ([203.11.71.1]:43219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQ4JR-0004Lb-Ms; Mon, 13 May 2019 02:19:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 452Vz30kjtz9sNC; Mon, 13 May 2019 16:19:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557728383;
	bh=mybf5FDA6IImZhZVbU1H3yLsmp5YpbEYQgGyqUuw+t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMeXejUachaIiRBjZKphqRAm/Ew0gW4tDTV4cutULxCDmMRdzbFJi9fI+gWKLkh5I
	G/5xXpwUmsndvImUAcZO5Q6xvzK41bYyVsDNpTMCasEsD+EQJLzlbQ2B5yc3t2owOm
	b2kuAiqXMD+XIfvsarjbWxiMBi1HcCzQsaEqw2G4=
From: David Gibson <david@gibson.dropbear.id.au>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Date: Mon, 13 May 2019 16:19:39 +1000
Message-Id: <20190513061939.3464-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513061939.3464-1-david@gibson.dropbear.id.au>
References: <20190513061939.3464-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH v4 5/5] pci: Fold pci_get_bus_devfn() into its
 sole caller
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
Cc: aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	groug@kaod.org, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only remaining caller of pci_get_bus_devfn() is pci_nic_init_nofail()=
,
itself an old compatibility function.  Fold the two together to avoid
re-using the stale interface.

While we're there replace the explicit fprintf()s with error_report().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pci.c | 60 ++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 7e5f8d001b..d3893bdfe1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -723,37 +723,6 @@ static int pci_parse_devaddr(const char *addr, int *=
domp, int *busp,
     return 0;
 }
=20
-static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root,
-                                 const char *devaddr)
-{
-    int dom, bus;
-    unsigned slot;
-
-    if (!root) {
-        fprintf(stderr, "No primary PCI bus\n");
-        return NULL;
-    }
-
-    assert(!root->parent_dev);
-
-    if (!devaddr) {
-        *devfnp =3D -1;
-        return pci_find_bus_nr(root, 0);
-    }
-
-    if (pci_parse_devaddr(devaddr, &dom, &bus, &slot, NULL) < 0) {
-        return NULL;
-    }
-
-    if (dom !=3D 0) {
-        fprintf(stderr, "No support for non-zero PCI domains\n");
-        return NULL;
-    }
-
-    *devfnp =3D PCI_DEVFN(slot, 0);
-    return pci_find_bus_nr(root, bus);
-}
-
 static void pci_init_cmask(PCIDevice *dev)
 {
     pci_set_word(dev->cmask + PCI_VENDOR_ID, 0xffff);
@@ -1895,6 +1864,8 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus =
*rootbus,
     DeviceState *dev;
     int devfn;
     int i;
+    int dom, busnr;
+    unsigned slot;
=20
     if (nd->model && !strcmp(nd->model, "virtio")) {
         g_free(nd->model);
@@ -1928,7 +1899,32 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus=
 *rootbus,
         exit(1);
     }
=20
-    bus =3D pci_get_bus_devfn(&devfn, rootbus, devaddr);
+    if (!rootbus) {
+        error_report("No primary PCI bus");
+        exit(1);
+    }
+
+    assert(!rootbus->parent_dev);
+
+    if (!devaddr) {
+        devfn =3D -1;
+        busnr =3D 0;
+    } else {
+        if (pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) < 0) {
+            error_report("Invalid PCI device address %s for device %s",
+                         devaddr, nd->model);
+            exit(1);
+        }
+
+        if (dom !=3D 0) {
+            error_report("No support for non-zero PCI domains");
+            exit(1);
+        }
+
+        devfn =3D PCI_DEVFN(slot, 0);
+    }
+
+    bus =3D pci_find_bus_nr(rootbus, busnr);
     if (!bus) {
         error_report("Invalid PCI device address %s for device %s",
                      devaddr, nd->model);
--=20
2.21.0


