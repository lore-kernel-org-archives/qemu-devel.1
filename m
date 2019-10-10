Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5EFC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAA32067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAA32067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbHq-0007ps-Ip
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIaqN-0005LD-Hg
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIaqM-00034p-BM
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iIaqM-00034H-2t
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5AA653084288
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:59:09 +0000 (UTC)
Received: from localhost (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3AD3600C4;
 Thu, 10 Oct 2019 15:59:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] libqos: add iteration support to qpci_find_capability()
Date: Thu, 10 Oct 2019 16:58:48 +0100
Message-Id: <20191010155853.4325-3-stefanha@redhat.com>
In-Reply-To: <20191010155853.4325-1-stefanha@redhat.com>
References: <20191010155853.4325-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 10 Oct 2019 15:59:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VIRTIO 1.0 PCI devices have multiple PCI_CAP_ID_VNDR capabilities so we
need a way to iterate over them.  Extend qpci_find_capability() to take
the last address.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/pci.h |  2 +-
 tests/libqos/pci.c | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index a5389a5845..590c175190 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -86,7 +86,7 @@ bool qpci_has_buggy_msi(QPCIDevice *dev);
 bool qpci_check_buggy_msi(QPCIDevice *dev);
=20
 void qpci_device_enable(QPCIDevice *dev);
-uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id);
+uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_=
addr);
 void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 662ee7a517..b8679dff1d 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -115,10 +115,16 @@ void qpci_device_enable(QPCIDevice *dev)
     g_assert_cmphex(cmd & PCI_COMMAND_MASTER, =3D=3D, PCI_COMMAND_MASTER=
);
 }
=20
-uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id)
+uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_=
addr)
 {
     uint8_t cap;
-    uint8_t addr =3D qpci_config_readb(dev, PCI_CAPABILITY_LIST);
+    uint8_t addr;
+
+    if (start_addr) {
+        addr =3D qpci_config_readb(dev, start_addr + PCI_CAP_LIST_NEXT);
+    } else {
+        addr =3D qpci_config_readb(dev, PCI_CAPABILITY_LIST);
+    }
=20
     do {
         cap =3D qpci_config_readb(dev, addr);
@@ -138,7 +144,7 @@ void qpci_msix_enable(QPCIDevice *dev)
     uint8_t bir_table;
     uint8_t bir_pba;
=20
-    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=3D, 0);
=20
     val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
@@ -167,7 +173,7 @@ void qpci_msix_disable(QPCIDevice *dev)
     uint16_t val;
=20
     g_assert(dev->msix_enabled);
-    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=3D, 0);
     val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
     qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
@@ -203,7 +209,7 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry=
)
     uint64_t vector_off =3D dev->msix_table_off + entry * PCI_MSIX_ENTRY=
_SIZE;
=20
     g_assert(dev->msix_enabled);
-    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=3D, 0);
     val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
=20
@@ -221,7 +227,7 @@ uint16_t qpci_msix_table_size(QPCIDevice *dev)
     uint8_t addr;
     uint16_t control;
=20
-    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=3D, 0);
=20
     control =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
--=20
2.21.0


