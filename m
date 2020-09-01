Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89498C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5461320767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS1Aza8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5461320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Pt-0004Ux-F8
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kD7Fz-0000Qt-OH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:27:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43650
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kD7Fb-0005xd-09
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hL4UU6UW/U1i0rBrax0K1b6/ws7EZEF6wAgUhedS6w0=;
 b=FS1Aza8++lSRRse2zSUtinrMWYz8JKeDJbc7lPSqHiETdzSuySGxeX9sz5FOuBXiz+UaOk
 nrUCDGxZMnPvOA3rERli1A2+ObVTCO4z3OR60SGgeUIYud65/aq0T78FFfTHq9OR3EjuqY
 Fe49zAPG04ewgbHXIBSiu5ozSG9Tyes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-T1Jxi_cSNsC9zGgE9feIZQ-1; Tue, 01 Sep 2020 10:27:04 -0400
X-MC-Unique: T1Jxi_cSNsC9zGgE9feIZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E151DDF3;
 Tue,  1 Sep 2020 14:27:02 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-114-76.ams2.redhat.com [10.36.114.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBA1B672C6;
 Tue,  1 Sep 2020 14:26:51 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Peter Xu <peterx@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC v8 3/5] memory: Add IOMMU_DEVIOTLB_UNMAP IOMMUTLBNotificationType
Date: Tue,  1 Sep 2020 16:26:06 +0200
Message-Id: <20200901142608.24481-4-eperezma@redhat.com>
In-Reply-To: <20200901142608.24481-1-eperezma@redhat.com>
References: <20200901142608.24481-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adapt intel and vhost to use this new notification type

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 hw/virtio/vhost.c     | 2 +-
 include/exec/memory.h | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0c4aef5cb5..cdddb089e7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2468,7 +2468,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
         sz = VTD_PAGE_SIZE;
     }
 
-    event.type = IOMMU_NOTIFIER_UNMAP;
+    event.type = IOMMU_NOTIFIER_DEVIOTLB;
     event.entry.target_as = &vtd_dev_as->as;
     event.entry.addr_mask = sz - 1;
     event.entry.iova = addr;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e7a6..6ca168b47e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
                                                    MEMTXATTRS_UNSPECIFIED);
     iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
-                        IOMMU_NOTIFIER_UNMAP,
+                        IOMMU_NOTIFIER_DEVIOTLB,
                         section->offset_within_region,
                         int128_get64(end),
                         iommu_idx);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8a56707169..215e23973d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -87,6 +87,8 @@ typedef enum {
     IOMMU_NOTIFIER_UNMAP = 0x1,
     /* Notify entry changes (newly created entries) */
     IOMMU_NOTIFIER_MAP = 0x2,
+    /* Notify changes on device IOTLB entries */
+    IOMMU_NOTIFIER_DEVIOTLB = 0x04,
 } IOMMUNotifierFlag;
 
 #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
-- 
2.18.1


