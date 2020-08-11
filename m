Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22244C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5D02075D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFFU9F4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5D02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Sk6-0005EW-3w
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 07:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k5Shu-0001xg-9n
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k5Shs-0008LN-1d
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597146278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3JXqjqJElyj06Lz4rtmP2PcYwdH0tRMQK+IE13ukd0=;
 b=eFFU9F4Is9JykixpTuy3cE5kZjpHNcWrgTIrtsQu3MzMWV482DIwVpFuZU3o4yll+NSrbl
 6Nlkj+iTzpjVzggdAAC2LnvDYJHtjnBnaSkXTf2bxuvGkdjnIF9W1SYCSYGFDf8Zq9izeZ
 k5HdWFtiuTt40SeXVlHq6ZIBhmQI/Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-XKnVjypPNCyrciG6Jq9KGQ-1; Tue, 11 Aug 2020 07:44:33 -0400
X-MC-Unique: XKnVjypPNCyrciG6Jq9KGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94819100CCC1;
 Tue, 11 Aug 2020 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF2525FC2F;
 Tue, 11 Aug 2020 11:44:25 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 6/9] spapr_pci: add spapr msi read method
Date: Tue, 11 Aug 2020 17:11:30 +0530
Message-Id: <20200811114133.672647-7-ppandit@redhat.com>
In-Reply-To: <20200811114133.672647-1-ppandit@redhat.com>
References: <20200811114133.672647-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 05:47:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add spapr msi mmio read method to avoid NULL pointer dereference
issue.

Reported-by: Lei Sun <slei.casper@gmail.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ppc/spapr_pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

Update v4: fix multi-line comment and log guest_error
  -> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05311.html

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 363cdb3f7b..53dfd3d8c6 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -52,6 +52,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
+#include "qemu/log.h"
 
 /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
 #define RTAS_QUERY_FN           0
@@ -738,6 +739,12 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(void *opaque, int pin)
     return route;
 }
 
+static uint64_t spapr_msi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid access\n", __func__);
+    return 0;
+}
+
 /*
  * MSI/MSIX memory region implementation.
  * The handler handles both MSI and MSIX.
@@ -755,8 +762,11 @@ static void spapr_msi_write(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps spapr_msi_ops = {
-    /* There is no .read as the read result is undefined by PCI spec */
-    .read = NULL,
+    /*
+     * .read result is undefined by PCI spec.
+     * define .read method to avoid assert failure in memory_region_init_io
+     */
+    .read = spapr_msi_read,
     .write = spapr_msi_write,
     .endianness = DEVICE_LITTLE_ENDIAN
 };
-- 
2.26.2


