Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE44C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99AD208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chlioOrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99AD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwdE-00071O-0b
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kAwZz-0000CS-Hg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kAwZx-0006MK-Rl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598452749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3dbNdcxxhQJeQFXVm5XbSPMbQBlA/yaWTXFikvO7So=;
 b=chlioOrU+Z19cBzDq/eSManqKyCycUr3OcqJpRgcLb2mvziEQNOlCJvTNnzs0luMB4QS3t
 fF2a8rVlDGdgCeoI4QKVEuU4Nwxw9vQh2OFVNt8NaUYJ+DCvA9Wl/lx4rG8zAZCfUm0VCI
 fH0aINCZtN+Qa5l/EiDgTHFNzVEjU3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-boRpaYidMAWIyRUdxiGzbw-1; Wed, 26 Aug 2020 10:39:05 -0400
X-MC-Unique: boRpaYidMAWIyRUdxiGzbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A71C425D1;
 Wed, 26 Aug 2020 14:39:04 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-115-59.ams2.redhat.com [10.36.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6917776E00;
 Wed, 26 Aug 2020 14:38:52 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Xu <peterx@redhat.com>
Subject: [RFC v6 10/13] memory: Notify IOMMU IOTLB based on entry type,
 not permissions
Date: Wed, 26 Aug 2020 16:36:48 +0200
Message-Id: <20200826143651.7915-11-eperezma@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This way the intention is much clearer.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 softmmu/memory.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 961c25b42f..3e68442ca6 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1890,10 +1890,27 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
     memory_region_update_iommu_notify_flags(iommu_mr, NULL);
 }
 
+static IOMMUNotifierFlag notifier_type_iommu(const IOMMUNotifier *notifier)
+{
+    return notifier->notifier_flags & IOMMU_NOTIFIER_ALL;
+}
+
+static bool memory_region_notify(const IOMMUNotifier *notifier,
+                                 const IOMMUTLBEntry *entry)
+{
+    switch(entry->type) {
+    case IOMMU_IOTLB_MAP:
+        return notifier_type_iommu(notifier) == IOMMU_NOTIFIER_MAP;
+    case IOMMU_IOTLB_UNMAP:
+        return notifier_type_iommu(notifier) == IOMMU_NOTIFIER_UNMAP;
+    default:
+        return false;
+    };
+}
+
 void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
                                     IOMMUTLBEntry *entry)
 {
-    IOMMUNotifierFlag request_flags;
     hwaddr entry_end = entry->iova + entry->addr_mask;
 
     /*
@@ -1906,13 +1923,7 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
 
     assert(entry->iova >= notifier->start && entry_end <= notifier->end);
 
-    if (entry->perm & IOMMU_RW) {
-        request_flags = IOMMU_NOTIFIER_MAP;
-    } else {
-        request_flags = IOMMU_NOTIFIER_UNMAP;
-    }
-
-    if (notifier->notifier_flags & request_flags) {
+    if (memory_region_notify(notifier, entry)) {
         notifier->notify(notifier, entry);
     }
 }
-- 
2.18.1


