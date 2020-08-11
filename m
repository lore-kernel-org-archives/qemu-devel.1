Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F7DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2E12075D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcxgS2ZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2E12075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Sjb-0004Tm-AV
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 07:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k5ShO-00011i-OY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:44:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41817
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k5ShM-0008H1-VN
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597146248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3rQyYFC2scFIz/XUUni2PfV2OOrFxGCh7tG7NMzdYM=;
 b=KcxgS2ZBnAVfrFryvSWF8bG69j0Yv3usWet1HAJn4PGjDzqwMEvqJgyQOHsteGJKE42AHP
 rZ9Fc0Rhmsr227hZrMmK0gK2C0PZu9jOQiJWb+jpeLWL71FosGL8Qr78xDlfDGb3kLVICD
 nk1MezzrsJryxSO7DZRfpcjcT3ouuRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-zw6DeT4zMQCO7K0OBtWUuA-1; Tue, 11 Aug 2020 07:44:05 -0400
X-MC-Unique: zw6DeT4zMQCO7K0OBtWUuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82121800050;
 Tue, 11 Aug 2020 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 361AD1C4;
 Tue, 11 Aug 2020 11:43:55 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 2/9] pci-host: designware: add pcie-msi read method
Date: Tue, 11 Aug 2020 17:11:26 +0530
Message-Id: <20200811114133.672647-3-ppandit@redhat.com>
In-Reply-To: <20200811114133.672647-1-ppandit@redhat.com>
References: <20200811114133.672647-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Add pcie-msi mmio read method to avoid NULL pointer dereference
issue.

Reported-by: Lei Sun <slei.casper@gmail.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/pci-host/designware.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Update v4: add explanatory comment and Reviewed-by tag
  -> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05315.html

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 8492c18991..db036aac71 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
@@ -63,6 +64,23 @@ designware_pcie_root_to_host(DesignwarePCIERoot *root)
     return DESIGNWARE_PCIE_HOST(bus->parent);
 }
 
+static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
+                                              unsigned size)
+{
+    /*
+     * Attempts to read from the MSI address are undefined in
+     * the PCI specifications. For this hardware, the datasheet
+     * specifies that a read from the magic address is simply not
+     * intercepted by the MSI controller, and will go out to the
+     * AHB/AXI bus like any other PCI-device-initiated DMA read.
+     * This is not trivial to implement in QEMU, so since
+     * well-behaved guests won't ever ask a PCI device to DMA from
+     * this address we just log the missing functionality.
+     */
+    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
+    return 0;
+}
+
 static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
                                            uint64_t val, unsigned len)
 {
@@ -77,6 +95,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps designware_pci_host_msi_ops = {
+    .read = designware_pcie_root_msi_read,
     .write = designware_pcie_root_msi_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
-- 
2.26.2


