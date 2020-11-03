Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19276C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F5320757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvIg5Bz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F5320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxhn-0005Ee-J7
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOj-0004Yh-8b
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOh-0006Us-II
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfMG5NPSSgbiHzXp+0EZ66dpqrizcgkZqiSRInNVyXY=;
 b=WvIg5Bz7kWyACPE2Pc5k3ykhKIgK1D6aXpAuzqb604ucSlSeszLE+VJ4SSn7PmPeXUMc81
 ziPnBCRY3uAVgvqugf9Zv+ht7Vh1GqOvCDXrkpX2/oYBeAKT2s1+RWxuZJzVqswh5Dqvvl
 DLlvkxnp9MfA6BTmv+6Z5h7Zid+o77Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-rug7h1QyO064ww2KBJ8oXQ-1; Tue, 03 Nov 2020 09:34:53 -0500
X-MC-Unique: rug7h1QyO064ww2KBJ8oXQ-1
Received: by mail-wm1-f70.google.com with SMTP id u9so1599979wmb.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FfMG5NPSSgbiHzXp+0EZ66dpqrizcgkZqiSRInNVyXY=;
 b=NT92TNFmgxL8SVOR1K29B7byQLqReJGRmo4g7N3XuAbjM+JqF2wYhtmcGhgT4YDOX/
 n1wRwJFw7ofiyQeiI4hBIMNZf5MRSGiz8lXuvIqLIOq02WIIJzfEa0H1oa5Nei1hToV1
 iQI1t0ev8Jm5PEy7RTp3E9TnD2Qyumz5dSEw01Fg86H1ZDpYgCsEHRJbVTK+bRSbiTci
 1uqqtNoZYErDwAA1u6WHaPEh5hMxx8VW44aD2INdQbUm/6HLZCwHtp2LR0lrZYxdqGJT
 6dUixn6jSxpsBh0Esw49U7AIJ3lpV//i76JM5R5QmcC9Wq4AeG5dyuySGaT50j9l4yTM
 846Q==
X-Gm-Message-State: AOAM533VXC0w+r64poEHudvU42QxH/K6df2sym3afUaZXAVLo9mV2IXY
 zfqZoRr8D5b3ilMb/GmCwzdJ60wuMXuH5aO1QSE2NWsZp/1cn/PEX4fH6U5orFfnoqikokkAxBc
 JbetlR4Kgz1mJbRQ=
X-Received: by 2002:a05:600c:21d9:: with SMTP id
 x25mr12704wmj.145.1604414090574; 
 Tue, 03 Nov 2020 06:34:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlVTplgUhn5uNktwrBLUFGSY1jRU5hAmpCQjmumDJbvH5L2Mh+UrjIrVQ8Sbn0IjCYPidcDQ==
X-Received: by 2002:a05:600c:21d9:: with SMTP id
 x25mr12685wmj.145.1604414090391; 
 Tue, 03 Nov 2020 06:34:50 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y201sm3473669wmd.27.2020.11.03.06.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:49 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/38] virtio-iommu: Add notify_flag_changed() memory region
 callback
Message-ID: <20201103142306.71782-19-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Add notify_flag_changed() to notice when memory listeners are added and
removed.

Acked-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-7-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 14 ++++++++++++++
 hw/virtio/trace-events   |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 985257c88f..78e07aa40a 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -886,6 +886,19 @@ unlock:
     qemu_mutex_unlock(&s->mutex);
 }
 
+static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
+                                            IOMMUNotifierFlag old,
+                                            IOMMUNotifierFlag new,
+                                            Error **errp)
+{
+    if (old == IOMMU_NOTIFIER_NONE) {
+        trace_virtio_iommu_notify_flag_add(iommu_mr->parent_obj.name);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        trace_virtio_iommu_notify_flag_del(iommu_mr->parent_obj.name);
+    }
+    return 0;
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1116,6 +1129,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = virtio_iommu_translate;
     imrc->replay = virtio_iommu_replay;
+    imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index ea3c3b25ad..982d0002a6 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -109,6 +109,8 @@ virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start,
 virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64" flags=%d"
 virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
+virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
+virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
MST


