Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77611C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497EC20747
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzZ57H36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497EC20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZ4B-0006JA-KA
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqZ34-0004s5-SA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:28:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqZ33-0005P4-6J
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593595736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wucbBw00c2V1/vl8huKUxgbZY/HPysQg4R/6AvM6MCw=;
 b=gzZ57H36eGt71XHxQcntfF5tFpmkpELzfHfhiVYGEjCIwzbMaUJ4jMg2UNIlTBTHmp61tG
 GydM4llKk+QS9gl8T3NQH5/GmLM+3WsXBJkBr3Gi6Y7XqqVazoMqCT1kxpMIf8AzhrZka3
 LW0pbDabYMdkVeVVCawvjXIsduq0Y4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-F5AoMBHmPK6_koTaF0qujw-1; Wed, 01 Jul 2020 05:28:55 -0400
X-MC-Unique: F5AoMBHmPK6_koTaF0qujw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B05B118FE872;
 Wed,  1 Jul 2020 09:28:52 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 259C7100164D;
 Wed,  1 Jul 2020 09:28:34 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v3 07/13] vhost: implement vhost_dev_start method
Date: Wed,  1 Jul 2020 17:24:43 +0800
Message-Id: <20200701092449.17451-8-lulu@redhat.com>
In-Reply-To: <20200701092449.17451-1-lulu@redhat.com>
References: <20200701092449.17451-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

use the vhost_dev_start callback to send the status to backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/vhost.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 10304b583e..32809e54b5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1685,7 +1685,12 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
             goto fail_log;
         }
     }
-
+    if (hdev->vhost_ops->vhost_dev_start) {
+        r = hdev->vhost_ops->vhost_dev_start(hdev, true);
+        if (r) {
+            goto fail_log;
+        }
+    }
     if (vhost_dev_has_iommu(hdev) &&
         hdev->vhost_ops->vhost_set_iotlb_callback) {
             hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
@@ -1723,6 +1728,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
 
+    if (hdev->vhost_ops->vhost_dev_start) {
+        hdev->vhost_ops->vhost_dev_start(hdev, false);
+    }
     for (i = 0; i < hdev->nvqs; ++i) {
         vhost_virtqueue_stop(hdev,
                              vdev,
-- 
2.21.1


