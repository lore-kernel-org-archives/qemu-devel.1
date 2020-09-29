Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21DFC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFCB2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Og0KA9CC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFCB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAC8-0006Lk-Lq
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xI-0003Hn-3Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xG-0001dV-0D
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PR4qBN07x4Vimn0/QnAKwqdBvmtmgl6PaVSJGqhqqO8=;
 b=Og0KA9CCQhbzNIdMj20G5JP3+PK4JyX63D2hAXlFvnGKx3gU0kGSfF2Dsu7VjLbnEC5chW
 v+gXm0dhCEANc7PW6m61dQznNxW9KWkK/ZVNjvIo0CpPcz237vMJ8yvMfqh+mmwLNFerW6
 Ba4v3TxPP47+HbrKR+hW/dHJeN7ghs4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-dgsB_uKBOlaoX_sJZmP2AA-1; Tue, 29 Sep 2020 03:21:39 -0400
X-MC-Unique: dgsB_uKBOlaoX_sJZmP2AA-1
Received: by mail-wm1-f70.google.com with SMTP id t8so1350605wmj.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PR4qBN07x4Vimn0/QnAKwqdBvmtmgl6PaVSJGqhqqO8=;
 b=Rtsdu567uN2Egc1mgob/p0TyLKIhCuHqOks8vy9tnqjnoEl8viQDKjLoMVbnp/kJuo
 17y8x+2mOGA1G+Luqm7mWnPcuMfzrF6IG5GwriTO5zY/Qu4bIZ2GYkWWq5mCIbpnArp4
 zl7yKgg3zDhHmQJm8X7aG4ZChMcI0i9afooA0BTFOgFMvKEODVNiw6cHSAjyzhlcQiu0
 pkRbyJdz6ePCbe24pwEc5tJ5sB1Lq7H9JiXmCtgP4Iwa1cgRIjxlcFQOs2n3BwUm6zQ9
 nDL3cCpFjYiyJ4GZWCM5jG2JHFksz9qEk+faWa3OZ78ha8qFV5H7eJDttf8a5am8pu7H
 rm8Q==
X-Gm-Message-State: AOAM5309u6li/qSsQ9R9huAzcVwk0u9AZ9j2bH21DM4XcqBRsnRqrQzz
 Ss8HqxkLaeK19gw5py8tkXjxnGF4BpwUWhV9cwHfY8AW1bRhjvfni8tXO5V1Xwiya74ckFmUh5y
 y+56AmRKOlUTOQPk=
X-Received: by 2002:adf:ff83:: with SMTP id j3mr2603284wrr.135.1601364097307; 
 Tue, 29 Sep 2020 00:21:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6A2FCngV/MxsTJmlORuF1rJtRCg7o7Uju2aFW83BXOtmrM6s02RaDTCvOJKWRrB0ea91yGQ==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr2603255wrr.135.1601364097104; 
 Tue, 29 Sep 2020 00:21:37 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id l126sm4248502wmf.39.2020.09.29.00.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:36 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 16/48] virtio: skip legacy support check on machine types
 less than 5.1
Message-ID: <20200929071948.281157-17-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

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
Message-Id: <20200921122506.82515-2-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  2 ++
 hw/core/machine.c          |  1 +
 hw/s390x/virtio-ccw.c      | 15 ++++++++++++---
 hw/virtio/virtio-pci.c     | 14 ++++++++++++--
 hw/virtio/virtio.c         |  7 +++++++
 5 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 28cf3b9120..b7ece7a6a8 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -101,6 +101,7 @@ struct VirtIODevice
     bool use_started;
     bool started;
     bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
+    bool disable_legacy_check;
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
@@ -394,5 +395,6 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
 }
 
 bool virtio_legacy_allowed(VirtIODevice *vdev);
+bool virtio_legacy_check_disabled(VirtIODevice *vdev);
 
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9b02fb2f5e..d7f4a0d259 100644
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
index 8d140dc50f..4582e94ae7 100644
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
index 02790e3237..36524a5728 100644
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
index 3a3d012d9f..a2edb4f386 100644
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
MST


