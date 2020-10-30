Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B4C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C79F22273
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgRfTVVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C79F22273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYoN-0006p7-71
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmr-00059C-VL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:37654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmj-0004qj-92
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id c16so3755205wmd.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CcqYYL+qDjoLJPUdpp6J8eO2OBjnLk8kyGHylqAsx/4=;
 b=IgRfTVVWoxTFkqJnX3D3RFI9lwDRshD+Ef3rxGCo7sBeRdJjXpqoXxSzJE8sgs/WmE
 Z5L2X3yXCSonnPdPOdFb6JWn7Q3ExZaJV7HxXWDborLoPUxoWrKHniGL9HOrPzWqpznU
 4Juorja+br0h3jKNNjyTb9z1v1NAaaim+/lMaHQdlLUJH7MLhjl4ReJfSxK+a9pDKy9L
 MTPx8SoKHRj1cDtQV6Rvg/9z43q59zQJmz9txOIoOdhxI42PQ7PoaEDGwV7Cc5otLjIz
 1MfFh9HjKco7T3yjUEZR4rGIcIoSB1yzqybW2ZF0YR1Dvw33S/RG9heqRu8UUGnE4V/G
 pGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CcqYYL+qDjoLJPUdpp6J8eO2OBjnLk8kyGHylqAsx/4=;
 b=ipePdVsm9QpN6vWKdOl8xdggYg8x/R8FpdX3Yxxk+RjQJRq701sAVrgik+Prx1wjOJ
 UzcDmDbrCB5m6nk1YnV01u8F+Klc+/ir5HkmxO0NYIXZXoZXplJ0YdGWg5fhBXoqvsKq
 guts13GUr6KtZ48DopJDjOhBB1eIbQ+h7wR55XPhG41RZc+yX3wO7BN8cJwDGuxvCGtA
 9luYYxb4Lp4IPQUzyuYibfuE6a6GV0RyEm/5gxmwCPhOxPahiV8koGJdX+2j4Bboe1bN
 EPFmALV/xX1AMHOBnpQIndAhezqhqf3k3UzGu0XHCA7Iij54ymd0Xt0vcfvFAlagZKzT
 Pl8g==
X-Gm-Message-State: AOAM531neQD+BL3WptKMrh0DOIjiokTwRLkTdnDUVIo/xbJd8XLifPQA
 MFMxwgZS7FENJWUwR3ylGQT/yg==
X-Google-Smtp-Source: ABdhPJya4irfSZJRDCkzpFm7tEZrkFmRZi94s59f3BkhZn0L+LftDSGq2fk/Hx/u8mDKGAbjikiv1Q==
X-Received: by 2002:a05:600c:22cc:: with SMTP id
 12mr2040903wmg.9.1604081153958; 
 Fri, 30 Oct 2020 11:05:53 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:53 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 06/10] virtio-iommu: Add notify_flag_changed() memory
 region callback
Date: Fri, 30 Oct 2020 19:05:06 +0100
Message-Id: <20201030180510.747225-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Add notify_flag_changed() to notice when memory listeners are added and
removed.

Acked-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v11: improve tracepoint string
---
 hw/virtio/virtio-iommu.c | 14 ++++++++++++++
 hw/virtio/trace-events   |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 985257c88fd..78e07aa40a5 100644
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
index ea3c3b25ad7..982d0002a65 100644
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
2.29.1


