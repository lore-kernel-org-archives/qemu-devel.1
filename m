Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137A1207D8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JR3b8t6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137A1207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9Ax-0000LZ-BZ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97d-0003ey-7B
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97c-0007dP-38
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so3922732wrp.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ieiufg3+rZeSqlWjO6C+srZMnCXRrjzqU0qc19RSOzQ=;
 b=JR3b8t6FMRb/PPNshBv9i/pSevLTzh4toO8FfG9UYFX+85SPBuOe2SoKFsC0UaZ3h2
 VssMokhms1MhCLF6Swp20D8M2WrCjg2WOnMQUK70RTqvBKmFGMd+TTX7fkOu3mN5Wfay
 MS+MdyLS6OWErZZtSBz/M7W7E5qnp9bEHDqxhBHOjb5phOue+gGb6K9Dv62U4YdCWar/
 PsbVYsqRniPR5fAx4sXYHE00GuIKDYgSO+Uppsri7sCaiOjo7bXfYjGOWoi6VZbIxoGw
 Lf6Ep95SEXwiBrTY2XAOqqDCgNf3TbLzSEwesvd4Bg4BkuwVHRJorLu95rmo5z+LJ0LW
 6gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ieiufg3+rZeSqlWjO6C+srZMnCXRrjzqU0qc19RSOzQ=;
 b=Zrw2YfwrImY8U1/uV85jtIXKiXSPsbOW2aNBsXFmK0URXj8r6yppeaj3pthD+WY2Dd
 x6CNv5phq5/YzSIFUvPwxc+RBpf7qpfqsO/tUnhsTV7uL0rAIJQaCSG53ViawTIkO2R0
 yKIakQXfMBCtztqlVBv0iaXUZ30HAYvtUj7aacrvcREM6Sk1VVIxoTmjNjiR1wZnDe19
 g1FXIVmVlFSYfNfWzpKE3uVQ2zzQIW7jCe7xcYoP4TrO9BjndfDNXpaLTdLoPSNkIW1A
 aRQRaHbopeyTB8lXasMSJL3ZMD2Dlj4n/HYptHwCYUJJKmyDkbvHVY8m+758hDQDx7Uf
 WegA==
X-Gm-Message-State: AOAM5316MtKO6gLx7qkpJwdGGbLQIOy3rvIQAatbUAdYhXWKi/j9s2cM
 4/7foDckslaEbVBybScH8xNd6g==
X-Google-Smtp-Source: ABdhPJwNxdFcw8xWzgyALv1S9aKur2516yAV57PV4KK+iJl767vJDmewMdKPeNfgP0DckEf316MAxQ==
X-Received: by 2002:adf:f0d2:: with SMTP id x18mr26578126wro.250.1591112794706; 
 Tue, 02 Jun 2020 08:46:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i10sm4421436wrw.51.2020.06.02.08.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 08:46:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C157E1FF92;
 Tue,  2 Jun 2020 16:46:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 6/9] hw/virtio/pci: include vdev name in registered PCI
 sections
Date: Tue,  2 Jun 2020 16:46:21 +0100
Message-Id: <20200602154624.4460-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200602154624.4460-1-alex.bennee@linaro.org>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: robert.foley@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When viewing/debugging memory regions it is sometimes hard to figure
out which PCI device something belongs to. Make the names unique by
including the vdev name in the name string.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/virtio-pci.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d028c17c240..9ee4ab26cfe 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1390,7 +1390,7 @@ static void virtio_pci_device_write(void *opaque, hwaddr addr,
     }
 }
 
-static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
+static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy, const char *vdev_name)
 {
     static const MemoryRegionOps common_ops = {
         .read = virtio_pci_common_read,
@@ -1437,36 +1437,41 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
         },
         .endianness = DEVICE_LITTLE_ENDIAN,
     };
+    g_autoptr(GString) name = g_string_new(NULL);
 
-
+    g_string_printf(name, "virtio-pci-common(%s)", vdev_name);
     memory_region_init_io(&proxy->common.mr, OBJECT(proxy),
                           &common_ops,
                           proxy,
-                          "virtio-pci-common",
+                          name->str,
                           proxy->common.size);
 
+    g_string_printf(name, "virtio-pci-isr(%s)", vdev_name);
     memory_region_init_io(&proxy->isr.mr, OBJECT(proxy),
                           &isr_ops,
                           proxy,
-                          "virtio-pci-isr",
+                          name->str,
                           proxy->isr.size);
 
+    g_string_printf(name, "virtio-pci-device(%s)", vdev_name);
     memory_region_init_io(&proxy->device.mr, OBJECT(proxy),
                           &device_ops,
                           virtio_bus_get_device(&proxy->bus),
-                          "virtio-pci-device",
+                          name->str,
                           proxy->device.size);
 
+    g_string_printf(name, "virtio-pci-notify(%s)", vdev_name);
     memory_region_init_io(&proxy->notify.mr, OBJECT(proxy),
                           &notify_ops,
                           virtio_bus_get_device(&proxy->bus),
-                          "virtio-pci-notify",
+                          name->str,
                           proxy->notify.size);
 
+    g_string_printf(name, "virtio-pci-notify-pio(%s)", vdev_name);
     memory_region_init_io(&proxy->notify_pio.mr, OBJECT(proxy),
                           &notify_pio_ops,
                           virtio_bus_get_device(&proxy->bus),
-                          "virtio-pci-notify-pio",
+                          name->str,
                           proxy->notify_pio.size);
 }
 
@@ -1607,7 +1612,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 
         struct virtio_pci_cfg_cap *cfg_mask;
 
-        virtio_pci_modern_regions_init(proxy);
+        virtio_pci_modern_regions_init(proxy, vdev->name);
 
         virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
-- 
2.20.1


