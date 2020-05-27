Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CD9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04142078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 04:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFb3nJ7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04142078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdnTi-00036f-4Q
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 00:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jdnS8-00006C-Q8
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:14:04 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:42007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jdnS7-0005Al-Qb
 for qemu-devel@nongnu.org; Wed, 27 May 2020 00:14:04 -0400
Received: by mail-qv1-xf43.google.com with SMTP id l17so239830qvd.9
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 21:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=zoo08bLgWhm2utZU8ZWkRTp3d7EeHaqPtIWuyOgssvM=;
 b=mFb3nJ7gCzOXqA+lKxQNG4OWYO8TfjPeeuKfQAVCX8B7CVmbEP8xQ/TMHMig3qN1Lq
 jjhVWkqx7Xg9/q2ZxITPj1ZhyJ/i7BNrSmFS1InF29li7jNI+kCl/rDoCiDts6HvCAM5
 6TzPlkaJaB5Ojt14eRgVHD8HC+d16eyiet5b7wuJesKemkIm4TDT9GNEx/YoelwB6tXA
 e6GZn5kLp4SThSIv+1rsHxw0ZnW75ch4pv/7vZ1FgH3oRX1GpZ1qbytOvGr/vtVDlFHN
 ybZrWnyVcmZrx62R8FXrr58LNtubWwULhgXJzYRoOXD2WvVaNvK2XqA1fkL5/NAa77i2
 Xq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=zoo08bLgWhm2utZU8ZWkRTp3d7EeHaqPtIWuyOgssvM=;
 b=XJ+A7rPZWiPe65HSPQJQKmnDJn9I/8LfOJaVHrO8nXlHCImYNRbMxP6jXpd9OKiH/d
 wc3sZbX+mXXml00n+1u34a/bvImxdg1OKtcAmmLCWgpnkV+WDLX9P8x+Su1sqmmrLTiX
 7Y1M9AoaTZpR/p3GlP9L4Bquf+wDt5uOthd6PUQK/f5tOHydYoI09UNEsvO5fa7/g+G+
 LvFXMbxcqzAgMLuYnrzn7Aien+911fP80OvH91oXxpE2gWerGx31nDAOcyIymUITe7kN
 DC17qeoXA303XM0faoXLlaqw9ad0wBjZj0Jq6nLZ+4XGw33DDHwtOtUamXxx0XqJKcEw
 hPWg==
X-Gm-Message-State: AOAM533AyLy6y+Nv73I/Sb8smlBBZwjd7KlotXJYiuqLBMutLU1Lq44w
 TAH9zlZ7HpxzKl8j0rEoUqc=
X-Google-Smtp-Source: ABdhPJxBtqHFUyZtWf0L4cYQFDUbZE5mLO1oQwVRzQFrSikFE3JOL0chF8W8k4Wawnx2fNk5zMXZnw==
X-Received: by 2002:a05:6214:14a2:: with SMTP id
 bo2mr23396434qvb.106.1590552842772; 
 Tue, 26 May 2020 21:14:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id n85sm1461863qkn.31.2020.05.26.21.14.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 May 2020 21:14:02 -0700 (PDT)
Subject: [PATCH v25 QEMU 1/3] virtio-balloon: Implement support for page
 poison reporting feature
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Tue, 26 May 2020 21:14:00 -0700
Message-ID: <20200527041400.12700.33251.stgit@localhost.localdomain>
In-Reply-To: <20200527041212.12700.60627.stgit@localhost.localdomain>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qv1-xf43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

We need to make certain to advertise support for page poison reporting if
we want to actually get data on if the guest will be poisoning pages.

Add a value for reporting the poison value being used if page poisoning is
enabled in the guest. With this we can determine if we will need to skip
free page reporting when it is enabled in the future.

The value currently has no impact on existing balloon interfaces. In the
case of existing balloon interfaces the onus is on the guest driver to
reapply whatever poison is in place.

When we add free page reporting the poison value is used to determine if
we can perform in-place page reporting. The expectation is that a reported
page will already contain the value specified by the poison, and the
reporting of the page should not change that value.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/core/machine.c                  |    4 +++-
 hw/virtio/virtio-balloon.c         |   29 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h |    1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index bb3a7b18b193..9eca7d8c9bfe 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,7 +28,9 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
 
-GlobalProperty hw_compat_5_0[] = {};
+GlobalProperty hw_compat_5_0[] = {
+    { "virtio-balloon-device", "page-poison", "false" },
+};
 const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
 
 GlobalProperty hw_compat_4_2[] = {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 065cd450f10f..26f6a7ca2e35 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
+    config.poison_val = cpu_to_le32(dev->poison_val);
 
     if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
         config.free_page_report_cmd_id =
@@ -683,6 +684,14 @@ static ram_addr_t get_current_ram_size(void)
     return size;
 }
 
+static bool virtio_balloon_page_poison_support(void *opaque)
+{
+    VirtIOBalloon *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+}
+
 static void virtio_balloon_set_config(VirtIODevice *vdev,
                                       const uint8_t *config_data)
 {
@@ -697,6 +706,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
     }
+    dev->poison_val = 0;
+    if (virtio_balloon_page_poison_support(dev)) {
+        dev->poison_val = le32_to_cpu(config.poison_val);
+    }
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -755,6 +768,17 @@ static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_balloon_page_poison = {
+    .name = "vitio-balloon-device/page-poison",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_balloon_page_poison_support,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(poison_val, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_balloon_device = {
     .name = "virtio-balloon-device",
     .version_id = 1,
@@ -767,6 +791,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
     },
     .subsections = (const VMStateDescription * []) {
         &vmstate_virtio_balloon_free_page_report,
+        &vmstate_virtio_balloon_page_poison,
         NULL
     }
 };
@@ -854,6 +879,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
         g_free(s->stats_vq_elem);
         s->stats_vq_elem = NULL;
     }
+
+    s->poison_val = 0;
 }
 
 static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
@@ -916,6 +943,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_PAGE_POISON, true),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d2376e..7fe78e5c14d7 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+    uint32_t poison_val;
 } VirtIOBalloon;
 
 #endif


