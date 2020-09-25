Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51ADB2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkrWq1Cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51ADB2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnG7-0003Zh-6v
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCk-0007b9-G4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:02 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCi-0001OV-CN
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id x23so2927024wmi.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XCceP6Edp7P+SbIMUL/HUpL1UYE1lgoGhcHsF49MNZU=;
 b=xkrWq1Cgr+Bj+7+g3Nsr1J0dGpvBwK6/soDxBuin8vmQu03hos6U4PAOcTMjmMKRL7
 053HDpQ9gKsC4gqYY+hhtpxiQgwtpPVev+YAkW9hgL6wkv9kWCiGCvJi8zl30d0e+KN6
 RS79a41HZOeJk5EJB/LJFupJXSDYjkWE5/BHvYqdnpz5FFFXI9c4VXoh0AzDfu1bROCy
 DrU82EgjSbMCg5u/pXqXgBA5BFgug2JbKSIkxQNuWFzUZNsEqPaDmHBbwtW9VVjt6cHu
 OZhTEVNxe8LVkTWgxAbD1ep09yeMIbCDKH+dOq7JOm9Rk8Y/y9Vl87jYYCaRIXmzaAQt
 nxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XCceP6Edp7P+SbIMUL/HUpL1UYE1lgoGhcHsF49MNZU=;
 b=JPpJ88tNRrV4YgRvbDd10oQZqaueYKmwS/mExqTI6XFq8vPKx/tZ8AusY2PAIa9rk/
 aZEGA7nQZwZy/NaAFUvJEBzZEHFcpzhf48Y0GuOaO5ycpECXjhqHd5fN83eCIOmN/l/5
 y6gLPffo7qOJZx4MoyKa1vdH3/29BzLBkvGJL2EHK7QPpD/XtEwOJXHgIN0rdl3KpLaC
 ycQjrZJNQAga0oICm1Ov3LuHavLiK9WTVLH40J839O3dqBuHsTA8owWRNo5GpDACuD+O
 ZjY6lrhf8GejB4v7mlUibqBpUSKD8BtuZgCHomWYnBKp5Fh2w4LTWj7Q4hft7CZAZz9e
 JgVQ==
X-Gm-Message-State: AOAM531iL0ju1nDOqAMVSPu8yKMvmIPhxRNOXBwtgxxP0V1SJNtfX50v
 6yg9GOS0wy+cEojQnmOo0TmE+Q==
X-Google-Smtp-Source: ABdhPJxbsS2HesAWoB4xN00MHkBIOSc+8lw3iA/LUtk3G3s0NUGb1qyDjlBEXfv2nmJedBiuG7Rhjw==
X-Received: by 2002:a1c:dd87:: with SMTP id u129mr2979946wmg.172.1601038318896; 
 Fri, 25 Sep 2020 05:51:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm2756361wme.11.2020.09.25.05.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A74381FF91;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  05/19] virtio-pci: add notification trace points
Date: Fri, 25 Sep 2020 13:51:33 +0100
Message-Id: <20200925125147.26943-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: jean-philippe@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 takahiro.akashi@linaro.org, virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/virtio-pci.c | 3 +++
 hw/virtio/trace-events | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 507cb57c410f..33a40e31d955 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -36,6 +36,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/visitor.h"
+#include "trace.h"
 
 #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
 
@@ -1340,6 +1341,7 @@ static void virtio_pci_notify_write(void *opaque, hwaddr addr,
     unsigned queue = addr / virtio_pci_queue_mem_mult(proxy);
 
     if (vdev != NULL && queue < VIRTIO_QUEUE_MAX) {
+        trace_virtio_pci_notify_write(addr, val, size);
         virtio_queue_notify(vdev, queue);
     }
 }
@@ -1353,6 +1355,7 @@ static void virtio_pci_notify_write_pio(void *opaque, hwaddr addr,
     unsigned queue = val;
 
     if (vdev != NULL && queue < VIRTIO_QUEUE_MAX) {
+        trace_virtio_pci_notify_write_pio(addr, val, size);
         virtio_queue_notify(vdev, queue);
     }
 }
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 845200bf109d..189972b9213a 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -55,7 +55,12 @@ virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 "
 virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write 0x%" PRIx64 " max %d"
 virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
 
-# virtio-iommu.c
+# virtio-pci.c
+virtio_pci_notify(uint16_t vector) "virtio_pci_notify vec 0x%x"
+virtio_pci_notify_write(uint64_t addr, uint64_t val, unsigned int size) "0x%" PRIx64" = 0x%" PRIx64 " (%d)"
+virtio_pci_notify_write_pio(uint64_t addr, uint64_t val, unsigned int size) "0x%" PRIx64" = 0x%" PRIx64 " (%d)"
+
+# hw/virtio/virtio-iommu.c
 virtio_iommu_device_reset(void) "reset!"
 virtio_iommu_get_features(uint64_t features) "device supports features=0x%"PRIx64
 virtio_iommu_device_status(uint8_t status) "driver status = %d"
-- 
2.20.1


