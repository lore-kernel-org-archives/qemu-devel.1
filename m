Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13EFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF1920734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CleLf653"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF1920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisa3-0005rW-Jz
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKu-0008KW-6b
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKt-0008I6-49
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aF0LKMRy71gHDwlhWXRGF209K2gRXN1ZQiFOzyLmj+Q=;
 b=CleLf653Zk+ozlSL62BofSORpbx2PMe/D4i7uETsVLgMejtMFJZdOrqPClKNs+pI2e/OJF
 eBw2FBrY0+Z6I2ZvJjtJQf2OVDtgUsta3oof0fGcYervCyGx3Gp07GxcW/BUn+kSj/zJK/
 ghBNTMm1sztqziMUznzUd498S/d5nrE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-tMn6HrtqMjaqQtA8uw2psQ-1; Wed, 10 Jun 2020 00:27:32 -0400
X-MC-Unique: tMn6HrtqMjaqQtA8uw2psQ-1
Received: by mail-wr1-f72.google.com with SMTP id j16so491285wre.22
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aF0LKMRy71gHDwlhWXRGF209K2gRXN1ZQiFOzyLmj+Q=;
 b=j549q8PEcbEEzr1GnX3o5eR8G8AWz0NejggWBvBYozDhhg8O/AJes+Wxt6g20Z5PDW
 yxB/bVQ9BKYHBGU8jtYPWdUqyZqOnqu4JTfeiFtXucpx2DQQhzkwjmSxegCPQ6wdS9tg
 LpSlQOtIXCqhWpeUzeORYo6CcTLP2vTNBAvtl+exzQbwcwZt591dnLngzl58hKgeb5qk
 kRcqsOLRWzXc9019LNkJ3SvFIuuK+RnxXaqmQ+HloMdGNz0guqB5WLajnTYa46YEmFCO
 G1uIhSdoHOWfkgPbCH6r3SamdIxfgfCS+tQFkjUkwa4WD7sRLTpUZYpHRCd5lh4OthdP
 X5KA==
X-Gm-Message-State: AOAM531nfKCs5n2MKn75bh82RgFtpqK6yIWo/vd9rZtdoeN5q+8qONxq
 7NFG+NvcwXY4mYn84L22xz0whfgk+It5FSinWqbuV5q0R2SeIsygnDnp37QYQc+4Y+W/G3XspUH
 KUxgKaR4c73FcjlU=
X-Received: by 2002:a5d:4390:: with SMTP id i16mr1267465wrq.186.1591763251018; 
 Tue, 09 Jun 2020 21:27:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtrO3caGyZ+O3UYtIGzUr32RvAJZ8nr7jIB1lDXHfW3cmaNChBAkIoe5a+yTr8rGIsyAUD/Q==
X-Received: by 2002:a5d:4390:: with SMTP id i16mr1267450wrq.186.1591763250819; 
 Tue, 09 Jun 2020 21:27:30 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id i10sm6030354wrw.51.2020.06.09.21.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:30 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/56] virtio-balloon: Implement support for page poison
 reporting feature
Message-ID: <20200610042613.1459309-26-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>
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
Message-Id: <20200527041400.12700.33251.stgit@localhost.localdomain>
---
 include/hw/virtio/virtio-balloon.h |  1 +
 hw/core/machine.c                  |  4 +++-
 hw/virtio/virtio-balloon.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d237..7fe78e5c14 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+    uint32_t poison_val;
 } VirtIOBalloon;
 
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bb3a7b18b1..9eca7d8c9b 100644
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
index cff8eab6a1..31d3c88482 100644
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
@@ -849,6 +874,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
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
-- 
MST


