Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEACCC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7968320724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBKs+WbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7968320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFL5M-0003U9-IH
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFL0m-00056O-7t
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFL0k-0005I4-Jf
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:00:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42439)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFL0k-0005Hl-C7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXqZqMdUFIUhWl71MmF8+CJ055zhySGzb9wnV/1DUWQ=;
 b=WBKs+WbUgjVC4n7ch56EzsBMHJFvAphVh1893SLaHWDumE7au3jbeOfMQ8onKmUk8abhgc
 rDYAeMKGkkD8ToQugXgJyZzvccIDuGsux9VY1jW36h/PDBfeg0y4bXgm4NulQ1mpMjkI09
 oN0YEBPEo/suy2CrYgyJK88n4Lm7Xuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-fS9mFgAwPiezxTUfjG5Jkw-1; Fri, 20 Mar 2020 13:00:37 -0400
X-MC-Unique: fS9mFgAwPiezxTUfjG5Jkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33F5518C8C00;
 Fri, 20 Mar 2020 17:00:35 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDDE16D22;
 Fri, 20 Mar 2020 17:00:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 08/24] pci: introduce PCIPASIDOps to PCIDevice
Date: Fri, 20 Mar 2020 17:58:24 +0100
Message-Id: <20200320165840.30057-9-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-1-eric.auger@redhat.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 zhangfei.gao@foxmail.com, peterx@redhat.com,
 shameerali.kolothum.thodi@huawei.com, zhangfei.gao@linaro.org,
 bbhushan2@marvell.com, will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

This patch introduces PCIPASIDOps for IOMMU related operations.

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00078.html
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00940.html

So far, to setup virt-SVA for assigned SVA capable device, needs to
configure host translation structures for specific pasid. (e.g. bind
guest page table to host and enable nested translation in host).
Besides, vIOMMU emulator needs to forward guest's cache invalidation
to host since host nested translation is enabled. e.g. on VT-d, guest
owns 1st level translation table, thus cache invalidation for 1st
level should be propagated to host.

This patch adds two functions: alloc_pasid and free_pasid to support
guest pasid allocation and free. The implementations of the callbacks
would be device passthru modules. Like vfio.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 hw/pci/pci.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e1ed6677e1..67e03b8db1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2695,6 +2695,40 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, v=
oid *opaque)
     bus->iommu_opaque =3D opaque;
 }
=20
+void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops)
+{
+    assert(ops && !dev->pasid_ops);
+    dev->pasid_ops =3D ops;
+}
+
+bool pci_device_is_pasid_ops_set(PCIBus *bus, int32_t devfn)
+{
+    PCIDevice *dev;
+
+    if (!bus) {
+        return false;
+    }
+
+    dev =3D bus->devices[devfn];
+    return !!(dev && dev->pasid_ops);
+}
+
+int pci_device_set_pasid_table(PCIBus *bus, int32_t devfn,
+                               IOMMUConfig *config)
+{
+    PCIDevice *dev;
+
+    if (!bus) {
+        return -EINVAL;
+    }
+
+    dev =3D bus->devices[devfn];
+    if (dev && dev->pasid_ops && dev->pasid_ops->set_pasid_table) {
+        return dev->pasid_ops->set_pasid_table(bus, devfn, config);
+    }
+    return -ENOENT;
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range =3D opaque;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cfedf5a995..2146cb7519 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -8,6 +8,7 @@
 #include "hw/isa/isa.h"
=20
 #include "hw/pci/pcie.h"
+#include "hw/iommu/iommu.h"
=20
 extern bool pci_available;
=20
@@ -264,6 +265,11 @@ struct PCIReqIDCache {
 };
 typedef struct PCIReqIDCache PCIReqIDCache;
=20
+struct PCIPASIDOps {
+    int (*set_pasid_table)(PCIBus *bus, int32_t devfn, IOMMUConfig *config=
);
+};
+typedef struct PCIPASIDOps PCIPASIDOps;
+
 struct PCIDevice {
     DeviceState qdev;
     bool partially_hotplugged;
@@ -357,6 +363,7 @@ struct PCIDevice {
=20
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
+    PCIPASIDOps *pasid_ops;
 };
=20
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
@@ -490,6 +497,10 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *=
, int);
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
=20
+void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops);
+bool pci_device_is_pasid_ops_set(PCIBus *bus, int32_t devfn);
+int pci_device_set_pasid_table(PCIBus *bus, int32_t devfn, IOMMUConfig *co=
nfig);
+
 static inline void
 pci_set_byte(uint8_t *config, uint8_t val)
 {
--=20
2.20.1


