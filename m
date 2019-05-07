Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C62C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E916206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l4zCM5fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E916206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40797 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtaV-0004j1-7d
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:28:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVn-0000o8-4N
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVl-0002i8-CZ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVj-0002eD-9O; Tue, 07 May 2019 02:23:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL311C7z9sNd; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210203;
	bh=dz2Q7CwG/v/yD/CRbvkCBcfDVkRmsvBJoY2i0eKdyM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4zCM5fqMwI1FwVAreLOlAlLWRhQCtpjkBhZdR7wDNs4iLxUZQ6WGv+f5/z9SjGqT
	JQwZr3it1rUbfX1uWqt4gygVcOmGZLXSXX32PqDnrfzfqFeSJeIUtZuRTaXCHPNA5h
	sYrAKXMn/VSQiaJWj9jfGW3MRuPY+yBK/lS/nhOg=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Date: Tue,  7 May 2019 16:23:16 +1000
Message-Id: <20190507062316.20916-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507062316.20916-1-david@gibson.dropbear.id.au>
References: <20190507062316.20916-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v3 5/5] pci: Fold pci_get_bus_devfn() into its
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
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
 hw/pci/pci.c | 61 +++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 7e5f8d001b..90e2743185 100644
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
@@ -1928,7 +1899,33 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus=
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
+        bus =3D pci_find_bus_nr(rootbus, 0);
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


