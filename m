Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730C8C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2562064A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2562064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKAX-0006dv-BH
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2L-0008LQ-2D
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK2I-0001bV-R5
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK2I-0001Zc-Ld
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEAA6308302F;
 Thu, 15 Aug 2019 17:59:41 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 534A81EA;
 Thu, 15 Aug 2019 17:59:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:18 +0200
Message-Id: <20190815175922.3475-6-thuth@redhat.com>
In-Reply-To: <20190815175922.3475-1-thuth@redhat.com>
References: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 17:59:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/9] tests/libqos: Make virtio-pci code
 independent from global_qtest
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The libqos library functions should never depend on global_qtest,
since these functions might be used in tests that track multiple
test states. So let's use the test state of the QPCIDevice instead.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190813093047.27948-3-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index a622ca26ca..3f55c047a0 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -138,9 +138,9 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
-            data = readl(vqpci->msix_addr);
+            data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
             if (data == vqpci->msix_data) {
-                writel(vqpci->msix_addr, 0);
+                qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
                 return true;
             } else {
                 return false;
@@ -162,9 +162,9 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
-            data = readl(dev->config_msix_addr);
+            data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
             if (data == dev->config_msix_data) {
-                writel(dev->config_msix_addr, 0);
+                qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
                 return true;
             } else {
                 return false;
-- 
2.18.1


