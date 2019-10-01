Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B7EECE58A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00272086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="MMQnpSS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00272086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFILY-0006mi-KP
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFH7D-0008MD-Sq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFH75-0004jy-3D
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:18:47 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFH74-0004hy-Qp
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:18:43 -0400
Received: by mail-ed1-x544.google.com with SMTP id y91so11658460ede.9
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=25onto/LTkLxgqKF/wBKkgi24fKgK/f0z5Hk8aT4U+0=;
 b=MMQnpSS+H3Tth3PtFwUWYKDc3MSrz59FYWVuwJmugM4TLkH4WEArVm1yl83jm7V+SN
 g3Lca9hQex7/SDsh75fybjYJxZ7IlYmKqqd4JBXK2riH9+F3+5g8vRwsj2DfV/Idnaxg
 0j96oMg4sXHRs8WC8DRcJJJc7TmCEdKPcPcWKD9RGRcrGUS4egkHvu2zfHJbJ2Ool4Dw
 I1EgemLYHe2IsH44ZxLAT0d6gyU6D4lo2MnQy2PF9/BfubVbQgVWRR44bqPr1ln5l+Rj
 GipLJWJddjOA2OYIaGXli22TyUzJ0ZlvzVMRn0RA+vbg/VRlx2gLcLxifyjOHkDZaF2g
 QKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=25onto/LTkLxgqKF/wBKkgi24fKgK/f0z5Hk8aT4U+0=;
 b=Oslds6KyZlaZOZ4GCrV3KGIAOeu/B35WgeGx06D1+YBuZZXkag0NdjnukxpTdhtEoK
 eFMM2a4BEU0phXt9JBnRr78pMHpZPVdkCnMNy9xtsJGv0e/aOq+5jELWlpVyOK2Pcyfz
 gHmgpMMnauVDY00incNJD2tzvJH5Uc1kEzzk+tRRefzD3gcuU/5LJITSCLpTDNM1lsbx
 cY6npVWZ8mvw/gzhNbmQQx/uUFqgfiCBroJN+oqFWBG7OqAugFgU74K64P2976L67mvd
 +kFAnhY45h3n2z4jf/bwhBzKEeVBuMMCrnGndlghPaWYokWZsVIOUW7gvdJWSs0dSGX/
 jW9w==
X-Gm-Message-State: APjAAAXMXqBkCBVG37TdMIj+C0QBPTreCbzlvGB03CiiM9sxu99IL3LJ
 NR5xtKn4WfB1R+no1Etl5vRkLRtZIr4=
X-Google-Smtp-Source: APXvYqy/N8o+/bBaiZHOgru4qli3LTuv58lqBbPwR9AFtoe+OAShZ3rXQZ7NIg74mMJ4iaiT/fJI1Q==
X-Received: by 2002:a50:95c1:: with SMTP id x1mr24879683eda.180.1569932320732; 
 Tue, 01 Oct 2019 05:18:40 -0700 (PDT)
Received: from msennikovskii2.pb.local
 ([2001:1438:4010:2558:d098:3701:97c4:7b4e])
 by smtp.googlemail.com with ESMTPSA id u22sm1824156eja.23.2019.10.01.05.18.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 01 Oct 2019 05:18:39 -0700 (PDT)
From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-net: prevent offloads reset on migration
Date: Tue,  1 Oct 2019 14:18:28 +0200
Message-Id: <1569932308-30478-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569932308-30478-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
References: <1569932308-30478-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
X-Mailman-Approved-At: Tue, 01 Oct 2019 09:36:01 -0400
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
Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET
command are not preserved on VM migration.
Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_FEATURES)
get enabled.
What happens is: first the VirtIONet::curr_guest_offloads gets restored and offloads
are getting set correctly:

 #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=0, tso6=0, ecn=0, ufo=0) at net/net.c:474
 #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
 #2  virtio_net_post_load_device (opaque=0x555557701ca0, version_id=11) at hw/net/virtio-net.c:2334
 #3  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577c80 <vmstate_virtio_net_device>, opaque=0x555557701ca0, version_id=11)
     at migration/vmstate.c:168
 #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2197
 #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
 #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
 #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
 #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
 #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
 #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
 #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449

However later on the features are getting restored, and offloads get reset to
everything supported by features:

 #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=1, tso6=1, ecn=0, ufo=0) at net/net.c:474
 #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
 #2  virtio_net_set_features (vdev=0x555557701ca0, features=5104441767) at hw/net/virtio-net.c:773
 #3  virtio_set_features_nocheck (vdev=0x555557701ca0, val=5104441767) at hw/virtio/virtio.c:2052
 #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2220
 #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
 #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
 #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
 #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
 #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
 #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
 #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449

This patch fixes this by adding an extra argument to the set_features callback,
specifying whether the offloads are to be reset, and setting it to false
for the migration case.

Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
---
 hw/display/virtio-gpu-base.c |  3 ++-
 hw/net/virtio-net.c          |  5 +++--
 hw/virtio/virtio.c           | 10 +++++-----
 include/hw/virtio/virtio.h   |  2 +-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 55e0799..04d8a23 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -193,7 +193,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
 }
 
 static void
-virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features)
+virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features,
+                               bool reset_offloads)
 {
     static const uint32_t virgl = (1 << VIRTIO_GPU_F_VIRGL);
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(vdev);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd7..5d108e5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -743,7 +743,8 @@ static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
 }
 
-static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
+static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features,
+                                        bool reset_offloads)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     int i;
@@ -767,7 +768,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     n->rsc6_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
         virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
 
-    if (n->has_vnet_hdr) {
+    if (reset_offloads && n->has_vnet_hdr) {
         n->curr_guest_offloads =
             virtio_net_guest_offloads_by_features(features);
         virtio_net_apply_guest_offloads(n);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a94ea18..b89f7b0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2042,14 +2042,14 @@ const VMStateInfo  virtio_vmstate_info = {
     .put = virtio_device_put,
 };
 
-static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
+static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val, bool reset_offloads)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     bool bad = (val & ~(vdev->host_features)) != 0;
 
     val &= vdev->host_features;
     if (k->set_features) {
-        k->set_features(vdev, val);
+        k->set_features(vdev, val, reset_offloads);
     }
     vdev->guest_features = val;
     return bad ? -1 : 0;
@@ -2065,7 +2065,7 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
         return -EINVAL;
     }
-    ret = virtio_set_features_nocheck(vdev, val);
+    ret = virtio_set_features_nocheck(vdev, val, true);
     if (!ret) {
         if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
             /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
@@ -2217,14 +2217,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
          * host_features.
          */
         uint64_t features64 = vdev->guest_features;
-        if (virtio_set_features_nocheck(vdev, features64) < 0) {
+        if (virtio_set_features_nocheck(vdev, features64, false) < 0) {
             error_report("Features 0x%" PRIx64 " unsupported. "
                          "Allowed features: 0x%" PRIx64,
                          features64, vdev->host_features);
             return -1;
         }
     } else {
-        if (virtio_set_features_nocheck(vdev, features) < 0) {
+        if (virtio_set_features_nocheck(vdev, features, false) < 0) {
             error_report("Features 0x%x unsupported. "
                          "Allowed features: 0x%" PRIx64,
                          features, vdev->host_features);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b189788..fd8cac5 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -128,7 +128,7 @@ typedef struct VirtioDeviceClass {
                              uint64_t requested_features,
                              Error **errp);
     uint64_t (*bad_features)(VirtIODevice *vdev);
-    void (*set_features)(VirtIODevice *vdev, uint64_t val);
+    void (*set_features)(VirtIODevice *vdev, uint64_t val, bool reset_offloads);
     int (*validate_features)(VirtIODevice *vdev);
     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
-- 
2.7.4


