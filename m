Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04E3C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B5322B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SgRYZHcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B5322B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnGT-0003z1-8s
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCi-0007Vm-CK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCf-0001O1-WA
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:51:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so3501974wrt.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qmK72LzpAk+sHPJlMHFLJRJNfxPeFEWb03L+Le08bE4=;
 b=SgRYZHcF/mHGDtqMaPrLM0TYZ4xvkmAnBYe9mEz2RmcztJXqrPMmpSYzj7wQ+6EM+k
 jay8naQYyZIakKg8pCmwg7IMR7/REwAiaWv+57mAuwViVCmZI7kZX2LABNuRTGsKhUJb
 0uHj4sFTab/oGjXCbWlOVulMvO0vGOI1c1KkwHwYVGGs1CpzTQp4yy43A1ydFGsfIIHQ
 J2/SvtegF2jptFk1nfXaABVWoGFr9UoITuVTGBU9wTpoMkbwpiCPL12YRKlOsSwVOjR9
 P1RmA1HPPWwWmf3+WknjmWex3xsp33lqRXlt2IjxCUCSl67xAANBNCdr5cXh01k5471Q
 epdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qmK72LzpAk+sHPJlMHFLJRJNfxPeFEWb03L+Le08bE4=;
 b=XU2F4S0A9H2ClKE+NBhdje7RqrMm3yk28y5/TKV06WOmHwlhWQ+LoxA0LfhSjeiI9u
 /bkE7utJv5HgomDzn+awlfw1T8xQNtgSlkUknnI22p7CGaRcqWKrjjqEcOuLcRUNhs1b
 T1B/rO08SUzs448PvJ1/WXvNDRCty02r5jJxTuPKbqyeS/jmmBtYLxlPyaTU6OnTPh48
 F9ZIxSZ5PkbbiKLAkM+7uqSVUHByuvG5rzXqoQkHIxiAk5O6sK1i7S2RJxtuSz2VHfcx
 6106cxSJtafZFHQfWv+kAyTa+MG5QvMjVl+GL15VRLVsexTeJz6HRe5LYYAXvSBF1MH5
 smpQ==
X-Gm-Message-State: AOAM531hZqlCE5LBBa0+cN3boQGykSBpYoKTEL7xWit62BAdHWywkYbJ
 sPphNTuCK6lydcNsj6g2w9NVyA==
X-Google-Smtp-Source: ABdhPJyVMN0X63SItNReY5JJEsFfyQ3owfll7yNWGpQiY0FQLy7Jdcq4fU/KL11JP3iunvtBLpKjzA==
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr4591930wrm.117.1601038316477; 
 Fri, 25 Sep 2020 05:51:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i6sm3021447wra.1.2020.09.25.05.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D3271FF90;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  04/19] hw/block: add vhost-user-rpmb-pci boilerplate
Date: Fri, 25 Sep 2020 13:51:32 +0100
Message-Id: <20200925125147.26943-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, jean-philippe@linaro.org,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 takahiro.akashi@linaro.org, virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows is to instantiate a vhost-user-rpmb device as part of a
PCI bus. It is mostly boilerplate which looks pretty similar to the
vhost-user-fs-pci device if you squint.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
  - enable use IOEVENTFD flag
  - swap obj set bool args
---
 hw/block/vhost-user-rpmb-pci.c | 82 ++++++++++++++++++++++++++++++++++
 hw/block/meson.build           |  2 +
 2 files changed, 84 insertions(+)
 create mode 100644 hw/block/vhost-user-rpmb-pci.c

diff --git a/hw/block/vhost-user-rpmb-pci.c b/hw/block/vhost-user-rpmb-pci.c
new file mode 100644
index 000000000000..f0518305a1d9
--- /dev/null
+++ b/hw/block/vhost-user-rpmb-pci.c
@@ -0,0 +1,82 @@
+/*
+ * Vhost-user RPMB virtio device PCI glue
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-rpmb.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserRPMBPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserRPMB vdev;
+};
+
+typedef struct VHostUserRPMBPCI VHostUserRPMBPCI;
+
+#define TYPE_VHOST_USER_RPMB_PCI "vhost-user-rpmb-pci-base"
+
+#define VHOST_USER_RPMB_PCI(obj) \
+        OBJECT_CHECK(VHostUserRPMBPCI, (obj), TYPE_VHOST_USER_RPMB_PCI)
+
+static Property vurpmb_pci_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vurpmb_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserRPMBPCI *dev = VHOST_USER_RPMB_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = 1;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
+}
+
+static void vurpmb_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vurpmb_pci_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    device_class_set_props(dc, vurpmb_pci_properties);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_OTHER;
+}
+
+static void vurpmb_pci_instance_init(Object *obj)
+{
+    VHostUserRPMBPCI *dev = VHOST_USER_RPMB_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_RPMB);
+}
+
+static const VirtioPCIDeviceTypeInfo vurpmb_pci_info = {
+    .base_name             = TYPE_VHOST_USER_RPMB_PCI,
+    .non_transitional_name = "vhost-user-rpmb-pci",
+    .instance_size = sizeof(VHostUserRPMBPCI),
+    .instance_init = vurpmb_pci_instance_init,
+    .class_init    = vurpmb_pci_class_init,
+};
+
+static void vurpmb_pci_register(void)
+{
+    virtio_pci_types_register(&vurpmb_pci_info);
+}
+
+type_init(vurpmb_pci_register);
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 114222f18424..0b2d10201e28 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -18,5 +18,7 @@ softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('nvme.c'))
 specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
 specific_ss.add(when: 'CONFIG_VHOST_USER_RPMB', if_true: files('vhost-user-rpmb.c'))
+specific_ss.add(when: ['CONFIG_VHOST_USER_RPMB', 'CONFIG_VIRTIO_PCI' ],
+                if_true: files('vhost-user-rpmb-pci.c'))
 
 subdir('dataplane')
-- 
2.20.1


