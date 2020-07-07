Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBB6206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma/Nz3Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBB6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslHZ-0000jA-6E
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jslFm-0005XX-57
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:55:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jslFj-0000ZA-RY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594119307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+csh8d78jiJ6IpwwA7BaSdmhDgIcAcPvraWjeiPjsaM=;
 b=Ma/Nz3XmzLMBPa2TKTT0EA8imcrQL4j1iqQsEPHOfs/m0mbQZG3DMh/YZI1tKSwCEQ8OA3
 WATj47PUMcXrtXxXhg3o9ZOdpDyNl/4Qbap7PWLPGYEm6fwpxMqvu/I4JaXe3OJTOug3o3
 mxvhNvjKHDg4XYy5SXZRczuVzD7nkos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-BJQINg7FN1WYusmMthhFgg-1; Tue, 07 Jul 2020 06:55:05 -0400
X-MC-Unique: BJQINg7FN1WYusmMthhFgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C201800413;
 Tue,  7 Jul 2020 10:55:04 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5133C7B400;
 Tue,  7 Jul 2020 10:54:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/2] virtio: list legacy-capable devices
Date: Tue,  7 Jul 2020 12:54:45 +0200
Message-Id: <20200707105446.677966-2-cohuck@redhat.com>
In-Reply-To: <20200707105446.677966-1-cohuck@redhat.com>
References: <20200707105446.677966-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Several types of virtio devices had already been around before the
virtio standard was specified. These devices support virtio in legacy
(and transitional) mode.

Devices that have been added in the virtio standard are considered
non-transitional (i.e. with no support for legacy virtio).

Provide a helper function so virtio transports can figure that out
easily.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/virtio/virtio.c         | 25 +++++++++++++++++++++++++
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cc9c9dc1621e..c713698df7ab 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
+#include "standard-headers/linux/virtio_ids.h"
 
 /*
  * The alignment to use between consumer and producer parts of vring.
@@ -3279,6 +3280,30 @@ void virtio_init(VirtIODevice *vdev, const char *name,
     vdev->use_guest_notifier_mask = true;
 }
 
+/*
+ * Only devices that have already been around prior to defining the virtio
+ * standard support legacy mode; this includes devices not specified in the
+ * standard. All newer devices conform to the virtio standard only.
+ */
+bool virtio_legacy_allowed(VirtIODevice *vdev)
+{
+    switch (vdev->device_id) {
+    case VIRTIO_ID_NET:
+    case VIRTIO_ID_BLOCK:
+    case VIRTIO_ID_CONSOLE:
+    case VIRTIO_ID_RNG:
+    case VIRTIO_ID_BALLOON:
+    case VIRTIO_ID_RPMSG:
+    case VIRTIO_ID_SCSI:
+    case VIRTIO_ID_9P:
+    case VIRTIO_ID_RPROC_SERIAL:
+    case VIRTIO_ID_CAIF:
+        return true;
+    default:
+        return false;
+    }
+}
+
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
 {
     return vdev->vq[n].vring.desc;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b69d51749635..198ffc762678 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -396,4 +396,6 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
     return unlikely(vdev->disabled || vdev->broken);
 }
 
+bool virtio_legacy_allowed(VirtIODevice *vdev);
+
 #endif
-- 
2.25.4


