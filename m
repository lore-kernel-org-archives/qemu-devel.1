Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F2C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40634206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpJEUqpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40634206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYt0-0005Pc-3H
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmt-00059Y-Ce
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmn-0004qz-Pc
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id l8so3745943wmg.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dg6KgMRhe+BDU/aQn0+rRvWHE//ly0GmnJbDrG3nhDE=;
 b=HpJEUqpVFuZPcKweNR+djPDKqDFedR/o2qpdMNLvABKExA2TPXSgJ7JxXoWngFAmx3
 V/NSmJrOk5L+nMXKZHqTnYv+KjSjL7i4mQKUT0XxTnuLbGTgDuqpNtkvFrlMb4+fXEHW
 gWZqqQN75cbM0s7SYbg4+gFuxcXN6U7bsyEEbic1jq/ILoMo03CMZa437sZavEXUIUIl
 oDbWFkJ+81nhKA7rZbExldBmTffNe1cyKGk9TwS9zo1btTje3owy1dnTosr3iXWi8PYt
 WdurYylCGWV2unzSmAyVGhGoG1yg+td/zuTI8/h/HmsHk4xX3LFLOyzV9xYNFd5wRL35
 jFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dg6KgMRhe+BDU/aQn0+rRvWHE//ly0GmnJbDrG3nhDE=;
 b=EK94SQTvEhGGojHxfq64a9uSmxPF8+4WGuEmUhBMyNqQtxsus2mxHRkxCfdBazeCUW
 N+E27qviu7bozgpPZsHnY9PtNoYrQxp5jZ6xniwurIXbYM9/Jj/BHuitvRuYaNSTd58/
 oARP6wRBWxo8/JJ0MtnNSAJNGE1ZPI4MQPUrk3X0T3YCJE07k22nusAmFy3aKv6L1VYj
 C+qcOyF6ijnPIJE7XpFvcJhuqswK8lIHLNLkuBEtEnbecUwLqAwSoV14I1rR8uFMzDpM
 R8eqkuKCa3IKt97cm5r1Uo221/9UEsT68eFf4yGAD/d4ONZ0dBZH44XehzxNbWxgy64k
 SLLg==
X-Gm-Message-State: AOAM532Yh+9vKI7ORtv86aicveW/ElgniTPcL7EJ61c1hcd3qh41SCXZ
 RN+L/ovM73jGJcVT+NUSyrnToA==
X-Google-Smtp-Source: ABdhPJy3/qP4TMDnHcXus1pOkM+f0hcMY2/bDgqtnQRcC9NNwauMYaaelvovxL5LYEb6mZDalSqDLw==
X-Received: by 2002:a1c:e006:: with SMTP id x6mr4150190wmg.107.1604081158148; 
 Fri, 30 Oct 2020 11:05:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:57 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 09/10] virtio-iommu: Set supported page size mask
Date: Fri, 30 Oct 2020 19:05:09 +0100
Message-Id: <20201030180510.747225-10-jean-philippe@linaro.org>
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

The virtio-iommu device can deal with arbitrary page sizes for virtual
endpoints, but for endpoints assigned with VFIO it must follow the page
granule used by the host IOMMU driver.

Implement the interface to set the vIOMMU page size mask, called by VFIO
for each endpoint. We assume that all host IOMMU drivers use the same
page granule (the host page granule). Override the page_size_mask field
in the virtio config space.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v11: Simplify the update logic slightly
---
 hw/virtio/virtio-iommu.c | 50 ++++++++++++++++++++++++++++++++++++++++
 hw/virtio/trace-events   |  1 +
 2 files changed, 51 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 78e07aa40a5..fc5c75d6933 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -899,6 +899,55 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
     return 0;
 }
 
+/*
+ * The default mask (TARGET_PAGE_MASK) is the smallest supported guest granule,
+ * for example 0xfffffffffffff000. When an assigned device has page size
+ * restrictions due to the hardware IOMMU configuration, apply this restriction
+ * to the mask.
+ */
+static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
+                                           uint64_t new_mask,
+                                           Error **errp)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    uint64_t cur_mask = s->config.page_size_mask;
+
+    trace_virtio_iommu_set_page_size_mask(mr->parent_obj.name, cur_mask,
+                                          new_mask);
+
+    if ((cur_mask & new_mask) == 0) {
+        error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
+                   " is incompatible with mask 0x%"PRIx64, cur_mask, new_mask);
+        return -1;
+    }
+
+    /*
+     * After the machine is finalized, we can't change the mask anymore. If by
+     * chance the hotplugged device supports the same granule, we can still
+     * accept it. Having a different masks is possible but the guest will use
+     * sub-optimal block sizes, so warn about it.
+     */
+    if (qdev_hotplug) {
+        int new_granule = ctz64(new_mask);
+        int cur_granule = ctz64(cur_mask);
+
+        if (new_granule != cur_granule) {
+            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
+                       " is incompatible with mask 0x%"PRIx64, cur_mask,
+                       new_mask);
+            return -1;
+        } else if (new_mask != cur_mask) {
+            warn_report("virtio-iommu page mask 0x%"PRIx64
+                        " does not match 0x%"PRIx64, cur_mask, new_mask);
+        }
+        return 0;
+    }
+
+    s->config.page_size_mask &= new_mask;
+    return 0;
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1130,6 +1179,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->translate = virtio_iommu_translate;
     imrc->replay = virtio_iommu_replay;
     imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
+    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 982d0002a65..2060a144a2f 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -109,6 +109,7 @@ virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start,
 virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64" flags=%d"
 virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
+virtio_iommu_set_page_size_mask(const char *name, uint64_t old, uint64_t new) "mr=%s old_mask=0x%"PRIx64" new_mask=0x%"PRIx64
 virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
 virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
 
-- 
2.29.1


