Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509AAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4D0206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGibH+Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4D0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslHd-0000sF-Ak
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jslFu-0005rb-Ky
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:55:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jslFs-0000cO-M4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594119315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kM6g8wl011f7C4nPCBtDKAy9ilTQLzhl2uS1gmBAxjs=;
 b=CGibH+ZkKccKgI7hji6kJL7+c/j7qhcOipgbW1CkkSe7wULikdG0B4OlyEprn5AfTCeprN
 MKzySo75mo9lXxOKk+K+6IrtXA+xeb2E7hmzjQBI6hylG7c/qKV4+ce3w85HaNQE1tN4WA
 QLINoD3FXwbn2IkVZPvkCvGSVRjsdQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-uCKDG2LHNKO9yMo4UAXgKQ-1; Tue, 07 Jul 2020 06:55:14 -0400
X-MC-Unique: uCKDG2LHNKO9yMo4UAXgKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06AEA1054F91;
 Tue,  7 Jul 2020 10:55:13 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0BCF60BF3;
 Tue,  7 Jul 2020 10:55:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 2/2] virtio: verify that legacy support is not accidentally on
Date: Tue,  7 Jul 2020 12:54:46 +0200
Message-Id: <20200707105446.677966-3-cohuck@redhat.com>
In-Reply-To: <20200707105446.677966-1-cohuck@redhat.com>
References: <20200707105446.677966-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
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

If a virtio device does not have legacy support, make sure that
it is actually off, and bail out if not.

For virtio-pci, this means that any device without legacy support
that has been specified to modern-only (or that has been forced
to it) will work.

For virtio-ccw, this duplicates the check that is currently done
prior to realization for any device that explicitly specified no
support for legacy.

This catches devices that have not been fenced properly.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c  | 6 ++++++
 hw/virtio/virtio-pci.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 3c988a000b5b..0e602702971b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1121,6 +1121,12 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
         dev->max_rev = 0;
     }
 
+    if (!virtio_ccw_rev_max(dev) && !virtio_legacy_allowed(vdev)) {
+        error_setg(errp, "Invalid value of property max_rev "
+                   "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
+        return;
+    }
+
     if (virtio_get_num_queues(vdev) > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "The number of virtqueues %d "
                    "exceeds virtio limit %d", n,
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7bc8c1c056e9..d4c4128ea507 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1569,6 +1569,10 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     }
 
     if (legacy) {
+        if (!virtio_legacy_allowed(vdev)) {
+            error_setg(errp, "device is modern-only, use disable-legacy=on");
+            return;
+        }
         if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
             error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported by"
                        " neither legacy nor transitional device");
-- 
2.25.4


