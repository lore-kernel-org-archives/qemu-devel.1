Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B05C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F041E208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bC0laIdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F041E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwfD-00029X-8W
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kAwau-0002BZ-HN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:40:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kAwas-0006VF-Do
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598452805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGQyeizi6c03BkZMJryn0YpKUk6Yr5XbAqCcSwva5kE=;
 b=bC0laIduY/xCLHLb4U4ktt5VCqtrfwdyZ3dIDilpIH/6ANBjlqD8PsGbUrADxhtejT/1n2
 4NT+OOUeeXtvaKDLYCn1bPhHYa3purX44yh6Ip1P2pxWczaa+1z/7T7Kb1nQkTALOC8VRx
 R8IKZr133TnEFpJ09SdIrNFCPMtVBFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-8T_E3lobOGGAeIU2wMT3vw-1; Wed, 26 Aug 2020 10:40:01 -0400
X-MC-Unique: 8T_E3lobOGGAeIU2wMT3vw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD4B218BE165;
 Wed, 26 Aug 2020 14:39:57 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-115-59.ams2.redhat.com [10.36.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7577C7E46F;
 Wed, 26 Aug 2020 14:39:04 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Xu <peterx@redhat.com>
Subject: [RFC v6 11/13] memory: Add IOMMU_DEVIOTLB_UNMAP
 IOMMUTLBNotificationType
Date: Wed, 26 Aug 2020 16:36:49 +0200
Message-Id: <20200826143651.7915-12-eperezma@redhat.com>
In-Reply-To: <20200826143651.7915-1-eperezma@redhat.com>
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adapt intel and vhost to use this new notification type

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 hw/virtio/vhost.c     | 2 +-
 include/exec/memory.h | 9 ++++++---
 softmmu/memory.c      | 5 ++++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0b3399874f..ddb828da1f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2467,7 +2467,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     entry.iova = addr;
     entry.perm = IOMMU_NONE;
     entry.translated_addr = 0;
-    entry.type = IOMMU_IOTLB_UNMAP;
+    entry.type = IOMMU_DEVIOTLB_UNMAP;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, entry);
 
 done:
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
index f6d91c54aa..477c3af24c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -60,9 +60,10 @@ struct ReservedRegion {
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
 
 typedef enum {
-    IOMMU_IOTLB_NONE  = 0,
-    IOMMU_IOTLB_UNMAP = 1,
-    IOMMU_IOTLB_MAP   = 2,
+    IOMMU_IOTLB_NONE     = 0,
+    IOMMU_IOTLB_UNMAP    = 1,
+    IOMMU_IOTLB_MAP      = 2,
+    IOMMU_DEVIOTLB_UNMAP = 3,
 } IOMMUTLBNotificationType;
 
 /* See address_space_translate: bit 0 is read, bit 1 is write.  */
@@ -94,6 +95,8 @@ typedef enum {
     IOMMU_NOTIFIER_UNMAP = 0x1,
     /* Notify entry changes (newly created entries) */
     IOMMU_NOTIFIER_MAP = 0x2,
+    /* Notify changes on device IOTLB entries */
+    IOMMU_NOTIFIER_DEVIOTLB = 0x04,
 } IOMMUNotifierFlag;
 
 #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 3e68442ca6..4ed63f4d0d 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1892,7 +1892,8 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
 
 static IOMMUNotifierFlag notifier_type_iommu(const IOMMUNotifier *notifier)
 {
-    return notifier->notifier_flags & IOMMU_NOTIFIER_ALL;
+    return notifier->notifier_flags &
+           (IOMMU_NOTIFIER_ALL | IOMMU_NOTIFIER_DEVIOTLB);
 }
 
 static bool memory_region_notify(const IOMMUNotifier *notifier,
@@ -1903,6 +1904,8 @@ static bool memory_region_notify(const IOMMUNotifier *notifier,
         return notifier_type_iommu(notifier) == IOMMU_NOTIFIER_MAP;
     case IOMMU_IOTLB_UNMAP:
         return notifier_type_iommu(notifier) == IOMMU_NOTIFIER_UNMAP;
+    case IOMMU_DEVIOTLB_UNMAP:
+        return notifier_type_iommu(notifier) == IOMMU_NOTIFIER_DEVIOTLB;
     default:
         return false;
     };
-- 
2.18.1


