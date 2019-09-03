Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB819C3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80890215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80890215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i52Br-0000c0-AI
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 02:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i529h-0007CJ-DJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i529f-0003Z2-GW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i529e-0003YB-VA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFEF418C4267
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 06:19:01 +0000 (UTC)
Received: from thuth.com (ovpn-116-80.ams2.redhat.com [10.36.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D532600C6;
 Tue,  3 Sep 2019 06:19:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 08:18:45 +0200
Message-Id: <20190903061849.21493-3-thuth@redhat.com>
In-Reply-To: <20190903061849.21493-1-thuth@redhat.com>
References: <20190903061849.21493-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 03 Sep 2019 06:19:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/6] tests/libqos/e1000e: Make e1000e libqos
 functions independent from global_qtest
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libqos library functions should never depend on functions (like memread(),
memwrite() or clock_step()) that require global_qtest to be set, since
library functions might get used in qtests that track multiple states, too.
Thus let's replace the global_qtest-related functions with their independent
counterparts.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/e1000e.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/libqos/e1000e.c b/tests/libqos/e1000e.c
index 1d0592974e..560e7a2bb2 100644
--- a/tests/libqos/e1000e.c
+++ b/tests/libqos/e1000e.c
@@ -85,26 +85,32 @@ static uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
 
 void e1000e_tx_ring_push(QE1000E *d, void *descr)
 {
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
     uint32_t tail = e1000e_macreg_read(d, E1000E_TDT);
     uint32_t len = e1000e_macreg_read(d, E1000E_TDLEN) / E1000E_TXD_LEN;
 
-    memwrite(d->tx_ring + tail * E1000E_TXD_LEN, descr, E1000E_TXD_LEN);
+    qtest_memwrite(d_pci->pci_dev.bus->qts, d->tx_ring + tail * E1000E_TXD_LEN,
+                   descr, E1000E_TXD_LEN);
     e1000e_macreg_write(d, E1000E_TDT, (tail + 1) % len);
 
     /* Read WB data for the packet transmitted */
-    memread(d->tx_ring + tail * E1000E_TXD_LEN, descr, E1000E_TXD_LEN);
+    qtest_memread(d_pci->pci_dev.bus->qts, d->tx_ring + tail * E1000E_TXD_LEN,
+                  descr, E1000E_TXD_LEN);
 }
 
 void e1000e_rx_ring_push(QE1000E *d, void *descr)
 {
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
     uint32_t tail = e1000e_macreg_read(d, E1000E_RDT);
     uint32_t len = e1000e_macreg_read(d, E1000E_RDLEN) / E1000E_RXD_LEN;
 
-    memwrite(d->rx_ring + tail * E1000E_RXD_LEN, descr, E1000E_RXD_LEN);
+    qtest_memwrite(d_pci->pci_dev.bus->qts, d->rx_ring + tail * E1000E_RXD_LEN,
+                   descr, E1000E_RXD_LEN);
     e1000e_macreg_write(d, E1000E_RDT, (tail + 1) % len);
 
     /* Read WB data for the packet received */
-    memread(d->rx_ring + tail * E1000E_RXD_LEN, descr, E1000E_RXD_LEN);
+    qtest_memread(d_pci->pci_dev.bus->qts, d->rx_ring + tail * E1000E_RXD_LEN,
+                  descr, E1000E_RXD_LEN);
 }
 
 static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
@@ -123,7 +129,7 @@ void e1000e_wait_isr(QE1000E *d, uint16_t msg_id)
         if (qpci_msix_pending(&d_pci->pci_dev, msg_id)) {
             return;
         }
-        clock_step(10000);
+        qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);
     } while (g_get_monotonic_time() < end_time);
 
     g_error("Timeout expired");
-- 
2.18.1


