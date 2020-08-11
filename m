Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC396C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F03420768
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOE+ZPhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F03420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5YWu-0008C3-QS
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5YWJ-0007j3-8R
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:57:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59439
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5YWH-0002hp-JX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597168624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYEEP14C5WlkW+SS4rYd/knvFEwd2psk69Sxjq/E9Bs=;
 b=OOE+ZPhyoX2cYhDriYccI0w54/Bvr9fck+wIiBVQJS4kLPBeiK7eC+KjLywe4KDYX8CIDK
 kv7mQim1Te9+SIjYsUz0J4rAcsLScCSpgmJ5c0mxuqdH8N5JIJW2MGHy18W6oBL7RAtzJu
 IEtxIOs9yqeKJ4AlQLfrOetI9J1qz48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Ga5uz8cyMAC1xGnvsKdNyg-1; Tue, 11 Aug 2020 13:55:58 -0400
X-MC-Unique: Ga5uz8cyMAC1xGnvsKdNyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B89E919;
 Tue, 11 Aug 2020 17:55:53 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-112-202.ams2.redhat.com
 [10.36.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18AA51A91D;
 Tue, 11 Aug 2020 17:55:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Peter Xu <peterx@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC v3 1/1] memory: Skip bad range assertion if notifier supports
 arbitrary masks
Date: Tue, 11 Aug 2020 19:55:33 +0200
Message-Id: <20200811175533.7359-2-eperezma@redhat.com>
In-Reply-To: <20200811175533.7359-1-eperezma@redhat.com>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost.c     |  2 +-
 include/exec/memory.h |  2 ++
 softmmu/memory.c      | 10 ++++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e7a6..e74ad9e09b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
                                                    MEMTXATTRS_UNSPECIFIED);
     iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
-                        IOMMU_NOTIFIER_UNMAP,
+                        IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_IOTLB,
                         section->offset_within_region,
                         int128_get64(end),
                         iommu_idx);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 307e527835..4d94c1e984 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -87,6 +87,8 @@ typedef enum {
     IOMMU_NOTIFIER_UNMAP = 0x1,
     /* Notify entry changes (newly created entries) */
     IOMMU_NOTIFIER_MAP = 0x2,
+    /* Notify changes on IOTLB entries */
+    IOMMU_NOTIFIER_IOTLB = 0x04,
 } IOMMUNotifierFlag;
 
 #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
diff --git a/softmmu/memory.c b/softmmu/memory.c
index af25987518..e2c5f6d0e7 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1895,6 +1895,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
 {
     IOMMUNotifierFlag request_flags;
     hwaddr entry_end = entry->iova + entry->addr_mask;
+    IOMMUTLBEntry tmp = *entry;
 
     /*
      * Skip the notification if the notification does not overlap
@@ -1904,7 +1905,12 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
         return;
     }
 
-    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
+    if (notifier->notifier_flags & IOMMU_NOTIFIER_IOTLB) {
+        tmp.iova = MAX(tmp.iova, notifier->start);
+        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
+    } else {
+        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
+    }
 
     if (entry->perm & IOMMU_RW) {
         request_flags = IOMMU_NOTIFIER_MAP;
@@ -1913,7 +1919,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
     }
 
     if (notifier->notifier_flags & request_flags) {
-        notifier->notify(notifier, entry);
+        notifier->notify(notifier, &tmp);
     }
 }
 
-- 
2.18.1


