Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92203CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A22820659
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1fVGwd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A22820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDu4-0003cP-8K
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDXf-0005Bp-Uu
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDXc-0002yt-Kl
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29890
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDXc-0002v6-GM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I08VkzUsgrtyia93/HmDZ76VepZd8lI7Z6RdTDxbgFU=;
 b=Y1fVGwd97pSdo8UHlwG+ylMohXg8ml0UvbA8pwe99wLUM0kCxH9EWPnWA9NFHsATaXdhlL
 y4rICzVIqHedA08xc18TJiuqpV+APfBKABs4MhK/JKj9f3vKqowHZ+8fs/embuJvAszNcq
 NBmUU4WhM157+xZTaP47Nw8gt6RgKso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-BJcQctWxPkmGZfzXumwSAQ-1; Wed, 23 Oct 2019 06:06:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5687A107AD31;
 Wed, 23 Oct 2019 10:06:46 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 680DE1001E75;
 Wed, 23 Oct 2019 10:06:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/16] libqos: add iteration support to
 qpci_find_capability()
Date: Wed, 23 Oct 2019 11:04:19 +0100
Message-Id: <20191023100425.12168-11-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BJcQctWxPkmGZfzXumwSAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VIRTIO 1.0 PCI devices have multiple PCI_CAP_ID_VNDR capabilities so we
need a way to iterate over them.  Extend qpci_find_capability() to take
the last address.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
--
v3:
 * Document qpci_find_capability()
---
 tests/libqos/pci.h |  2 +-
 tests/libqos/pci.c | 30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index a5389a5845..590c175190 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -86,7 +86,7 @@ bool qpci_has_buggy_msi(QPCIDevice *dev);
 bool qpci_check_buggy_msi(QPCIDevice *dev);
=20
 void qpci_device_enable(QPCIDevice *dev);
-uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id);
+uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_ad=
dr);
 void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 662ee7a517..2309a724e4 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -115,10 +115,28 @@ void qpci_device_enable(QPCIDevice *dev)
     g_assert_cmphex(cmd & PCI_COMMAND_MASTER, =3D=3D, PCI_COMMAND_MASTER);
 }
=20
-uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id)
+/**
+ * qpci_find_capability:
+ * @dev: the PCI device
+ * @id: the PCI Capability ID (PCI_CAP_ID_*)
+ * @start_addr: 0 to begin iteration or the last return value to continue
+ *              iteration
+ *
+ * Iterate over the PCI Capabilities List.
+ *
+ * Returns: PCI Configuration Space offset of the capabililty structure or
+ *          0 if no further matching capability is found
+ */
+uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_ad=
dr)
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
@@ -138,7 +156,7 @@ void qpci_msix_enable(QPCIDevice *dev)
     uint8_t bir_table;
     uint8_t bir_pba;
=20
-    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=3D, 0);
=20
     val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
@@ -167,7 +185,7 @@ void qpci_msix_disable(QPCIDevice *dev)
     uint16_t val;
=20
     g_assert(dev->msix_enabled);
-    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=3D, 0);
     val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
     qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
@@ -203,7 +221,7 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     uint64_t vector_off =3D dev->msix_table_off + entry * PCI_MSIX_ENTRY_S=
IZE;
=20
     g_assert(dev->msix_enabled);
-    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX);
+    addr =3D qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=3D, 0);
     val =3D qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
=20
@@ -221,7 +239,7 @@ uint16_t qpci_msix_table_size(QPCIDevice *dev)
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


