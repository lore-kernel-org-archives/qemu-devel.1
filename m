Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D6DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC7922254
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kw2upowf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC7922254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKgj-0008Ml-Sd
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKVK-0008Ep-HN
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKVI-0005as-N1
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOkim0c48rgaY5RZkxM0RJgVOyDbnydYfzwOzcFaCyM=;
 b=Kw2upowf0IQxaE3+JknS5Nwqs8u/n2/V96J2sYkIn0bsP3m3sflGwgBVek/30iYGxpSP+z
 kMZ6l7eKHeBrH7O4K2c92ihWWxvGMFuOYC+5e3blam2AcIURUPammzM6WVmU1P7dzt+kVg
 /wn6cN9AM9xUNerQaVsOFTMGNu/iOvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-I4wVAxLBM8-IHMtv_cucXA-1; Sun, 01 Nov 2020 16:03:05 -0500
X-MC-Unique: I4wVAxLBM8-IHMtv_cucXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EDBD8030A6;
 Sun,  1 Nov 2020 21:03:04 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 496391A886;
 Sun,  1 Nov 2020 21:03:01 +0000 (UTC)
Subject: [PULL v3 28/32] s390x/pci: use a PCI Function structure
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 14:03:01 -0700
Message-ID: <160426458154.24886.9872552286950111937.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pierre Morel <pmorel@linux.ibm.com>

We use a ClpRspQueryPci structure to hold the information related to a
zPCI Function.

This allows us to be ready to support different zPCI functions and to
retrieve the zPCI function information from the host.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/s390x/s390-pci-bus.c         |   12 ++++++++++++
 hw/s390x/s390-pci-inst.c        |    8 ++------
 include/hw/s390x/s390-pci-bus.h |    1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 036cf4635a7e..072b56e45ee5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -778,6 +778,17 @@ static void s390_pci_init_default_group(void)
     resgrp->version = 0;
 }
 
+static void set_pbdev_info(S390PCIBusDevice *pbdev)
+{
+    pbdev->zpci_fn.sdma = ZPCI_SDMA_ADDR;
+    pbdev->zpci_fn.edma = ZPCI_EDMA_ADDR;
+    pbdev->zpci_fn.pchid = 0;
+    pbdev->zpci_fn.ug = ZPCI_DEFAULT_FN_GRP;
+    pbdev->zpci_fn.fid = pbdev->fid;
+    pbdev->zpci_fn.uid = pbdev->uid;
+    pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -1000,6 +1011,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
+        set_pbdev_info(pbdev);
 
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             pbdev->fh |= FH_SHM_VFIO;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index c25b2a67efe0..58cd041d17fb 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -281,6 +281,8 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             goto out;
         }
 
+        memcpy(resquery, &pbdev->zpci_fn, sizeof(*resquery));
+
         for (i = 0; i < PCI_BAR_COUNT; i++) {
             uint32_t data = pci_get_long(pbdev->pdev->config +
                 PCI_BASE_ADDRESS_0 + (i * 4));
@@ -294,12 +296,6 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
                     resquery->bar_size[i]);
         }
 
-        stq_p(&resquery->sdma, ZPCI_SDMA_ADDR);
-        stq_p(&resquery->edma, ZPCI_EDMA_ADDR);
-        stl_p(&resquery->fid, pbdev->fid);
-        stw_p(&resquery->pchid, 0);
-        stw_p(&resquery->ug, ZPCI_DEFAULT_FN_GRP);
-        stl_p(&resquery->uid, pbdev->uid);
         stw_p(&resquery->hdr.rsp, CLP_RC_OK);
         break;
     }
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 869c0f254b7f..fe36f163abd4 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -342,6 +342,7 @@ struct S390PCIBusDevice {
     uint16_t maxstbl;
     uint8_t sum;
     S390PCIGroup *pci_group;
+    ClpRspQueryPci zpci_fn;
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;


