Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01B620734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q96xKJ5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01B620734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiu32-0003va-UI
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jitWy-0004jf-FO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:44:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jitWx-0005co-ID
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iLSWKwKFmkvEPuAZ0OMHKqVNdMxRrgW08SI64pD0Dsk=;
 b=Q96xKJ5WcpZT4YLEfNpzUqTbka4GRfm5I9Fc70Cv/dYuLQ2uRX5y5jke730awBcPrwpSH3
 WxMf1kZ0KM0j7dD2Bfh3DtVXgwpTwubabvqcYKK6wgeaciMGc9TkgblVPmZN60Mq485nVU
 hUKDjWnfqGsluo/A/mxYxeI5RFi6e0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-JwqjBUC5PICS4SUP7Gy-zw-1; Wed, 10 Jun 2020 01:44:02 -0400
X-MC-Unique: JwqjBUC5PICS4SUP7Gy-zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 189AE800053
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:44:02 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-194.pek2.redhat.com [10.72.13.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94B75768AE;
 Wed, 10 Jun 2020 05:43:54 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH V2] virtio-pci: fix queue_enable write
Date: Wed, 10 Jun 2020 13:43:51 +0800
Message-Id: <20200610054351.15811-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jason Wang <jasowang@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Spec said: The driver uses this to selectively prevent the device from
executing requests from this virtqueue. 1 - enabled; 0 - disabled.

Though write 0 to queue_enable is forbidden by the spec, we should not
assume that the value is 1.

Fix this by ignore the write value other than 1.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V1:
- fix typo
- warn wrong value through virtio_error
---
 hw/virtio/virtio-pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d028c17c24..7bc8c1c056 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1273,16 +1273,20 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         virtio_queue_set_vector(vdev, vdev->queue_sel, val);
         break;
     case VIRTIO_PCI_COMMON_Q_ENABLE:
-        virtio_queue_set_num(vdev, vdev->queue_sel,
-                             proxy->vqs[vdev->queue_sel].num);
-        virtio_queue_set_rings(vdev, vdev->queue_sel,
+        if (val == 1) {
+            virtio_queue_set_num(vdev, vdev->queue_sel,
+                                 proxy->vqs[vdev->queue_sel].num);
+            virtio_queue_set_rings(vdev, vdev->queue_sel,
                        ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
                        proxy->vqs[vdev->queue_sel].desc[0],
                        ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
                        proxy->vqs[vdev->queue_sel].avail[0],
                        ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
                        proxy->vqs[vdev->queue_sel].used[0]);
-        proxy->vqs[vdev->queue_sel].enabled = 1;
+            proxy->vqs[vdev->queue_sel].enabled = 1;
+        } else {
+            virtio_error(vdev, "wrong value for queue_enable %"PRIx64, val);
+        }
         break;
     case VIRTIO_PCI_COMMON_Q_DESCLO:
         proxy->vqs[vdev->queue_sel].desc[0] = val;
-- 
2.20.1


