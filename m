Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52467C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FA8206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFavyLMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FA8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKx1-0007oy-V5
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKKsx-00049d-3W
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:25:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kKKss-0008L7-Sf
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600691128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0p5jI72BV9q9kGL4Bgyc+PLA0efN3Fk3NOXsGKztPwo=;
 b=JFavyLMZ6tTX3uIfFZfi+MRfQ4vdxPFOMcx0hnrburlAhIjjDfy0F7I9i2T4oOdgdNTWtj
 OGSSmeENFg6hhZHR42Gxwo06an6J847qrcRWM2YigeXAzXNk3bcui7MM7fSvcyszUnNPDX
 KRFbjTCalgQ4uceZZ9ADPVttDW8xq88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-kQO_G-s3MvOKKpXX9Yy5OA-1; Mon, 21 Sep 2020 08:25:26 -0400
X-MC-Unique: kQO_G-s3MvOKKpXX9Yy5OA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51372EA323;
 Mon, 21 Sep 2020 12:25:25 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-150.ams2.redhat.com
 [10.36.113.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28B4368432;
 Mon, 21 Sep 2020 12:25:21 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 1/4] virtio: skip legacy support check on machine types
 less than 5.1
Date: Mon, 21 Sep 2020 14:25:03 +0200
Message-Id: <20200921122506.82515-2-sgarzare@redhat.com>
In-Reply-To: <20200921122506.82515-1-sgarzare@redhat.com>
References: <20200921122506.82515-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Qian Cai <caiqian@redhat.com>, qemu-stable@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 9b3a35ec82 ("virtio: verify that legacy support is not accidentally
on") added a check that returns an error if legacy support is on, but the
device does not support legacy.

Unfortunately some devices were wrongly declared legacy capable even if
they were not (e.g vhost-vsock).

To avoid migration issues, we add a virtio-device property
(x-disable-legacy-check) to skip the legacy error, printing a warning
instead, for machine types < 5.1.

Cc: qemu-stable@nongnu.org
Fixes: 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
 - fixed commit message and warning message [Cornelia]
v3:
 - added virtio_legacy_check_disabled() helper
 - moved warning where error was returned [Cornelia]
v2:
 - fixed Cornelia's e-mail address
---
 include/hw/virtio/virtio.h |  2 ++
 hw/core/machine.c          |  1 +
 hw/s390x/virtio-ccw.c      | 15 ++++++++++++---
 hw/virtio/virtio-pci.c     | 14 ++++++++++++--
 hw/virtio/virtio.c         |  7 +++++++
 5 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 807280451b..f90cfb03e3 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -103,6 +103,7 @@ struct VirtIODevice
     bool use_started;
     bool started;
     bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
+    bool disable_legacy_check;
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
@@ -396,5 +397,6 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
 }
 
 bool virtio_legacy_allowed(VirtIODevice *vdev);
+bool virtio_legacy_check_disabled(VirtIODevice *vdev);
 
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea26d61237..b686eab798 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -44,6 +44,7 @@ GlobalProperty hw_compat_5_0[] = {
     { "vmport", "x-signal-unsupported-cmd", "off" },
     { "vmport", "x-report-vmx-type", "off" },
     { "vmport", "x-cmds-v2", "off" },
+    { "virtio-device", "x-disable-legacy-check", "true" },
 };
 const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 8feb3451a0..c534cdf2e5 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1122,9 +1122,18 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
     }
 
     if (!virtio_ccw_rev_max(dev) && !virtio_legacy_allowed(vdev)) {
-        error_setg(errp, "Invalid value of property max_rev "
-                   "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
-        return;
+        /*
+         * To avoid migration issues, we allow legacy mode when legacy
+         * check is disabled in the old machine types (< 5.1).
+         */
+        if (virtio_legacy_check_disabled(vdev)) {
+            warn_report("device requires revision >= 1, but for backward "
+                        "compatibility max_revision=0 is allowed");
+        } else {
+            error_setg(errp, "Invalid value of property max_rev "
+                       "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
+            return;
+        }
     }
 
     if (virtio_get_num_queues(vdev) > VIRTIO_QUEUE_MAX) {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5bc769f685..bb91e34594 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1597,8 +1597,18 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 
     if (legacy) {
         if (!virtio_legacy_allowed(vdev)) {
-            error_setg(errp, "device is modern-only, use disable-legacy=on");
-            return;
+            /*
+             * To avoid migration issues, we allow legacy mode when legacy
+             * check is disabled in the old machine types (< 5.1).
+             */
+            if (virtio_legacy_check_disabled(vdev)) {
+                warn_report("device is modern-only, but for backward "
+                            "compatibility legacy is allowed");
+            } else {
+                error_setg(errp,
+                           "device is modern-only, use disable-legacy=on");
+                return;
+            }
         }
         if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
             error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported by"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e983025217..b85277da67 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3304,6 +3304,11 @@ bool virtio_legacy_allowed(VirtIODevice *vdev)
     }
 }
 
+bool virtio_legacy_check_disabled(VirtIODevice *vdev)
+{
+    return vdev->disable_legacy_check;
+}
+
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
 {
     return vdev->vq[n].vring.desc;
@@ -3713,6 +3718,8 @@ static Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
+    DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
+                     disable_legacy_check, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2


