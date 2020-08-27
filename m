Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC1322B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVcAZt49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC1322B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIEM-0002gu-1c
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI9D-0001sw-Iy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46730
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI9B-0006S5-CC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eeTgRITWczaxOM8QLYLDDpc4gdXDBgE13i+Oq96xfDM=;
 b=GVcAZt49BFkS3ucIe6C+bNhKrCXMqWwqK/OdNaJ2OqBsMvLjKSsX/opwfEjHwmMkxOPULI
 mg8zU8bYGqUBfUPuZbQuIFachxaJEEff3huGGl9jDlF7lWq4cgBjFFYZjxU+vfz2+LQsu3
 CRgqziGZqlpTzSKnAOv59vFL2TtFFdo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-bJzFqk6JMoqejOMxobftIg-1; Thu, 27 Aug 2020 09:40:51 -0400
X-MC-Unique: bJzFqk6JMoqejOMxobftIg-1
Received: by mail-wm1-f70.google.com with SMTP id p23so2156336wmc.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eeTgRITWczaxOM8QLYLDDpc4gdXDBgE13i+Oq96xfDM=;
 b=XspNLo3fVQNcyYsGHm+0thyJwbz57a2FTwQPIGPPBPAEMl1TzNOb6fGPfMcZX/nG99
 DE2e5yP8BmyNuF3SEPiO0kUyXPa+Jy6zncdPWrNdzZqI6QLOde2k9WUtDkKq3AT+MdkP
 lLZM+aadd3q9mTRXTl+oAkYqUg96Qk/LXQ15ouGsTeMrVbub4COzUK0nk//sMGRgVa5r
 4PtRVwCCQkYla3wXKe77dqZStQ0Z+tAZ3WDKOoGFENUkF9SIqIH8/mQUZjDXla036Unp
 42BXBBHdGecQBae2KfboQsoCfK1V9fiK/Y4MLmZlkwYaUmegEVfFeio8F16O41zhKpS2
 MjvQ==
X-Gm-Message-State: AOAM532A9PTXUXKDebV4qRMqS/v7bmL6dTGNBVJeGXyGENYiH5isKRIj
 WQ9Apg+hvfaRepnMPFdOZkS3TexLWOkC3/GRdfIi27TgWh2Sm4TkWqrYFrver+N2yDyLoaHDMId
 CqI0KXCEyNDM13o4=
X-Received: by 2002:a1c:16:: with SMTP id 22mr11761318wma.75.1598535650169;
 Thu, 27 Aug 2020 06:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBPqe6surZDr/kpUkY46n0krlW4IizizpUH1kCpWfC8UpTuUda5Oi9jcQkDJX4hnDkjFyOSw==
X-Received: by 2002:a1c:16:: with SMTP id 22mr11761302wma.75.1598535649920;
 Thu, 27 Aug 2020 06:40:49 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id d6sm1703515wrq.67.2020.08.27.06.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:49 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] virtio-scsi-pci: default num_queues to -smp N
Message-ID: <20200827133954.2118749-10-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Automatically size the number of virtio-scsi-pci, vhost-scsi-pci, and
vhost-user-scsi-pci request virtqueues to match the number of vCPUs.
Other transports continue to default to 1 request virtqueue.

A 1:1 virtqueue:vCPU mapping ensures that completion interrupts are
handled on the same vCPU that submitted the request.  No IPI is
necessary to complete an I/O request and performance is improved.  The
maximum number of MSI-X vectors and virtqueues limit are respected.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200818143348.310613-6-stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-scsi.h |  2 ++
 hw/core/machine.c               |  6 +++++-
 hw/scsi/vhost-scsi.c            |  3 ++-
 hw/scsi/vhost-user-scsi.c       |  3 ++-
 hw/scsi/virtio-scsi.c           |  6 +++++-
 hw/virtio/vhost-scsi-pci.c      | 10 +++++++---
 hw/virtio/vhost-user-scsi-pci.c | 10 +++++++---
 hw/virtio/virtio-scsi-pci.c     | 10 +++++++---
 8 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 9f293bcb80..c0b8e4dd7e 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -39,6 +39,8 @@
 /* Number of virtqueues that are always present */
 #define VIRTIO_SCSI_VQ_NUM_FIXED    2
 
+#define VIRTIO_SCSI_AUTO_NUM_QUEUES UINT32_MAX
+
 typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
 typedef struct virtio_scsi_cmd_resp VirtIOSCSICmdResp;
 typedef struct virtio_scsi_ctrl_tmf_req VirtIOSCSICtrlTMFReq;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index cf5f2dfaeb..9ee2aa0f7b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,7 +28,11 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
 
-GlobalProperty hw_compat_5_1[] = {};
+GlobalProperty hw_compat_5_1[] = {
+    { "vhost-scsi", "num_queues", "1"},
+    { "vhost-user-scsi", "num_queues", "1"},
+    { "virtio-scsi-device", "num_queues", "1"},
+};
 const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
 
 GlobalProperty hw_compat_5_0[] = {
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 13b05af29b..a83ffeefc8 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -270,7 +270,8 @@ static Property vhost_scsi_properties[] = {
     DEFINE_PROP_STRING("vhostfd", VirtIOSCSICommon, conf.vhostfd),
     DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
-    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
+    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
+                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
                        128),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adjust,
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a8b821466f..7c0631656c 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -162,7 +162,8 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
 static Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
-    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
+    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
+                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
                        128),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index eecdd05af5..3a71ea7097 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -891,6 +891,9 @@ void virtio_scsi_common_realize(DeviceState *dev,
     virtio_init(vdev, "virtio-scsi", VIRTIO_ID_SCSI,
                 sizeof(VirtIOSCSIConfig));
 
+    if (s->conf.num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
+        s->conf.num_queues = 1;
+    }
     if (s->conf.num_queues == 0 ||
             s->conf.num_queues > VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIXED) {
         error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
@@ -964,7 +967,8 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
 }
 
 static Property virtio_scsi_properties[] = {
-    DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
+    DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues,
+                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
                                          parent_obj.conf.virtqueue_size, 256),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 06e814d30e..a6bb0dc60d 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -47,11 +47,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostSCSIPCI *dev = VHOST_SCSI_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
+    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.parent_obj.conf;
+
+    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
+        conf->num_queues =
+            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+    }
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues +
-                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
+        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;
     }
 
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index ab6dfb71a9..25e97ca54e 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -53,11 +53,15 @@ static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserSCSIPCI *dev = VHOST_USER_SCSI_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
+    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.parent_obj.conf;
+
+    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
+        conf->num_queues =
+            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+    }
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues +
-                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
+        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;
     }
 
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index 3ff9eb7ef6..fa4b3bfb50 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -46,13 +46,17 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOSCSIPCI *dev = VIRTIO_SCSI_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
     DeviceState *proxy = DEVICE(vpci_dev);
+    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.conf;
     char *bus_name;
 
+    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
+        conf->num_queues =
+            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+    }
+
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues +
-                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
+        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;
     }
 
     /*
-- 
MST


