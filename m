Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA22EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888CD20702
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjsMuznS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888CD20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joAnW-0001PV-QA
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joAeK-0005BU-Ou
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 15:01:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1joAeH-0004ma-Ut
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 15:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593025289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJsRBGUOb73DHRmjtLDJwi3qY0lfc6VGkHzLnBs0AxE=;
 b=gjsMuznSX648NertV8MqgHzPIREuKDaZhX5F1uvEe9czVyF+RW4kJQ8iWGhgo3bKfC08nx
 HDa8wuMJgcmRYSEfW1APieToPkRTFIf/VS/FC39nkEivn5SSpD6qz21mcI3n7CWnxUvUcV
 PhFXaW9VCm4+QxTD52PZ+0t4+rDiGyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-0O0ggHP6MkinPsI-cYQxMg-1; Wed, 24 Jun 2020 14:58:26 -0400
X-MC-Unique: 0O0ggHP6MkinPsI-cYQxMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EECE310059A6;
 Wed, 24 Jun 2020 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01AAD79305;
 Wed, 24 Jun 2020 18:58:18 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 6/9] spapr_pci: add spapr msi read method
Date: Thu, 25 Jun 2020 00:25:20 +0530
Message-Id: <20200624185523.762240-7-ppandit@redhat.com>
In-Reply-To: <20200624185523.762240-1-ppandit@redhat.com>
References: <20200624185523.762240-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
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
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ppc/spapr_pci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 329002ac04..7033352834 100644
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
+    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
+    return 0;
+}
+
 /*
  * MSI/MSIX memory region implementation.
  * The handler handles both MSI and MSIX.
@@ -755,8 +762,10 @@ static void spapr_msi_write(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps spapr_msi_ops = {
-    /* There is no .read as the read result is undefined by PCI spec */
-    .read = NULL,
+    /* .read result is undefined by PCI spec
+     * define .read method to avoid assert failure in memory_region_init_io
+     */
+    .read = spapr_msi_read,
     .write = spapr_msi_write,
     .endianness = DEVICE_LITTLE_ENDIAN
 };
-- 
2.26.2


