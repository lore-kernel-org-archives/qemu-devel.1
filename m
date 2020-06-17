Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F28FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAC2207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yz28+0n8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAC2207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlQr1-0002R1-5c
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jlQq0-0001Jz-QT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:42:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jlQpy-0002x8-QI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592372534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mwRQvaPxwp78gZwlfE2uirgWSBqcSQCzBEF2uyFkyI=;
 b=Yz28+0n86qMDVmWltDc7RVxgFNUs26O+/ij2804l/KLYhgvOfvnWm4V1I9+ybD6ul3ZzE4
 MD/c6y3HqLZNpod2iKle2LBndSgLlXB0RaLX7r4uo7IOM8cOP0wBnKN9picW7x5qeRCHz1
 KbOPtsSCj3OW34XBU70WaGn9urDDP10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-CGipXDDZOw6LWXyBs5X5Cw-1; Wed, 17 Jun 2020 01:42:12 -0400
X-MC-Unique: CGipXDDZOw6LWXyBs5X5Cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96C39100961D;
 Wed, 17 Jun 2020 05:42:10 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-83.bne.redhat.com [10.64.54.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CA0E19D7B;
 Wed, 17 Jun 2020 05:42:00 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/6] pci-host: add pcie-msi read method
Date: Wed, 17 Jun 2020 11:09:29 +0530
Message-Id: <20200617053934.122642-3-ppandit@redhat.com>
In-Reply-To: <20200617053934.122642-1-ppandit@redhat.com>
References: <20200617053934.122642-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Add pcie-msi mmio read method to avoid NULL pointer dereference
issue.

Reported-by: Lei Sun <slei.casper@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/pci-host/designware.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index dd245516dd..c34c366f36 100644
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
@@ -63,6 +64,13 @@ designware_pcie_root_to_host(DesignwarePCIERoot *root)
     return DESIGNWARE_PCIE_HOST(bus->parent);
 }
 
+static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
+                                              unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
+    return 0;
+}
+
 static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
                                            uint64_t val, unsigned len)
 {
@@ -77,6 +85,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps designware_pci_host_msi_ops = {
+    .read = designware_pcie_root_msi_read,
     .write = designware_pcie_root_msi_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
-- 
2.26.2


