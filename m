Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C14FC742A5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187F820863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187F820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlq6f-0008IM-63
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 03:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39045)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hlq6O-0007Qe-RC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hlq6N-0000mb-Km
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:36:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hlq6M-0000lJ-2o
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 51877308338F;
 Fri, 12 Jul 2019 07:36:17 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-201.sin2.redhat.com
 [10.67.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2CB060BF4;
 Fri, 12 Jul 2019 07:36:13 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: mst@redhat.com
Date: Fri, 12 Jul 2019 13:05:52 +0530
Message-Id: <20190712073554.21918-2-pagupta@redhat.com>
In-Reply-To: <20190712073554.21918-1-pagupta@redhat.com>
References: <20190712073554.21918-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 12 Jul 2019 07:36:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] virtio pmem: fix wrong mem region condition
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
Cc: pagupta@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity reported memory region returns zero
for non-null value. This is because of wrong
arguments to '?:' , fixing this.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 hw/virtio/virtio-pmem-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
index 8b2d0dbccc..0da6627469 100644
--- a/hw/virtio/virtio-pmem-pci.c
+++ b/hw/virtio/virtio-pmem-pci.c
@@ -57,7 +57,7 @@ static uint64_t virtio_pmem_pci_get_plugged_size(const MemoryDeviceState *md,
     MemoryRegion *mr = vpc->get_memory_region(pmem, errp);
 
     /* the plugged size corresponds to the region size */
-    return mr ? 0 : memory_region_size(mr);
+    return mr ? memory_region_size(mr) : 0;
 }
 
 static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState *md,
-- 
2.14.5


