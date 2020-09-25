Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948E0C47420
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAC52072E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTf4LrGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAC52072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnE8-0000ov-6l
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCh-0007To-7D
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:51:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCd-0001Nd-T8
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:51:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id c18so3461981wrm.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SXamygjWRu+l2cZVRdgzhVlVjHli46731VVAeJxcnj0=;
 b=BTf4LrGC9ShJaCd7QstOeBSBNWgniJTYtz1S2uQLBtp8p96nZ8yyrTc3K9Mv8H+dsF
 fLZOMH/bftpHSJUzvmqHbYrkWOdqVHGcGOGD7exgel5zuNfjs5Va+GZUYNZlM+WoV44i
 9EZmKkmmGQ4AXw4IgiDpmILiu97i4YJntdFmugh6Q4EZy1qt3bZMupOTjc9eeWNRaAB5
 yQUwUsXOcOrCAKVIQbmi9A5rw4qwRZMR/EXrN/DuoVE2et5lUQ5S0AHBmJjDQY4rro41
 bOYVP7RsPDfumygm2CtYUvh1AvRML0We4EuWc2RJfar3kFgD5a3WFy6tuMvhNhfdXkpu
 7SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SXamygjWRu+l2cZVRdgzhVlVjHli46731VVAeJxcnj0=;
 b=YfAKra0t5HvkXaMFSrxo/AFZNmBH7Vz+CRNrSa44ONrHfSFaNzlFm+1R2FSvpo5VYK
 9GKpLm01mFPwFE2CEP8ngT3KsXWClJWud7YUg+dp8eJuNzfBRWPH7s3EMsBAIy7zDqrH
 9+smTLLRkWikouZWEqau60wEPf7L8VC0S9WuGT/FLLXIfwuPqcKqw3oW03EmxIB3nvZG
 xigl8JL2sxoQC5jjYCIPGLt26fQqGs4I1bn09RXp8Pd77FzSrwiLDkoQJC2Owhz1kKAX
 nuX/OwVs0sehQ/AJlcp+wj9YeMcxfQe3EtJ8ViRRPTlDYj+N/qlXF2lTNoEPr3/bn38p
 NiBg==
X-Gm-Message-State: AOAM532Qsecl1SQg8l295mg1lmyr988KN/hk7he4chp+L9bfdW0QqsXW
 D2UTBed6GT2R7PjeQLpy3+9MMw==
X-Google-Smtp-Source: ABdhPJwnOxu2IQfb6cc1OdcOPru6ncPuuxtb29c7/Pyq9H42tHlZUVqhjlVWgrmvZyT+1FxRN3Az7A==
X-Received: by 2002:adf:df87:: with SMTP id z7mr4469108wrl.239.1601038314313; 
 Fri, 25 Sep 2020 05:51:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l8sm2824058wrx.22.2020.09.25.05.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B77E1FF8C;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 02/19] hw/block: add boilerplate for vhost-user-rpmb device
Date: Fri, 25 Sep 2020 13:51:30 +0100
Message-Id: <20200925125147.26943-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This creates the QEMU side of the vhost-user-rpmb device which
connects to the remote daemon. It is based of the reasonably modern
vhost-user-fs code with bits from vhost-user-blk as we want the
virtio-config itself to be sourced from the daemon.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/virtio/vhost-user-rpmb.h |  46 ++++
 hw/block/vhost-user-rpmb.c          | 333 ++++++++++++++++++++++++++++
 hw/block/Kconfig                    |   5 +
 hw/block/meson.build                |   1 +
 4 files changed, 385 insertions(+)
 create mode 100644 include/hw/virtio/vhost-user-rpmb.h
 create mode 100644 hw/block/vhost-user-rpmb.c

diff --git a/include/hw/virtio/vhost-user-rpmb.h b/include/hw/virtio/vhost-user-rpmb.h
new file mode 100644
index 000000000000..7e5988127dc2
--- /dev/null
+++ b/include/hw/virtio/vhost-user-rpmb.h
@@ -0,0 +1,46 @@
+/*
+ * vhost-user-rpmb virtio device
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _VHOST_USER_RPMB_H_
+#define _VHOST_USER_RPMB_H_
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "chardev/char-fe.h"
+
+#define TYPE_VHOST_USER_RPMB "vhost-user-rpmb-device"
+#define VHOST_USER_RPMB(obj) \
+        OBJECT_CHECK(VHostUserRPMB, (obj), TYPE_VHOST_USER_RPMB)
+
+/* This is defined in the VIRTIO spec */
+struct virtio_rpmb_config {
+    uint8_t capacity;
+    uint8_t max_wr_cnt;
+    uint8_t max_rd_cnt;
+};
+
+typedef struct {
+    CharBackend chardev;
+    struct virtio_rpmb_config config;
+} VHostUserRPMBConf;
+
+typedef struct {
+    /*< private >*/
+    VirtIODevice parent;
+    VHostUserRPMBConf conf;
+    struct vhost_virtqueue *vhost_vq;
+    struct vhost_dev vhost_dev;
+    VhostUserState vhost_user;
+    VirtQueue *req_vq;
+    bool connected;
+    /*< public >*/
+} VHostUserRPMB;
+
+
+#endif /* _VHOST_USER_RPMB_H_ */
diff --git a/hw/block/vhost-user-rpmb.c b/hw/block/vhost-user-rpmb.c
new file mode 100644
index 000000000000..de243e7a53a0
--- /dev/null
+++ b/hw/block/vhost-user-rpmb.c
@@ -0,0 +1,333 @@
+/*
+ * Vhost-user RPMB virtio device
+ *
+ * This is the boilerplate for instantiating a vhost-user device
+ * implementing a Replay Protected Memory Block (RPMB) device. This is
+ * a type of flash chip that is protected from replay attacks and used
+ * for tamper resistant storage. The actual back-end for this driver
+ * is the vhost-user-rpmb daemon. The code here just connects up the
+ * device in QEMU and allows it to be instantiated.
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user-rpmb.h"
+#include "qemu/error-report.h"
+
+/* currently there is no RPMB driver in Linux */
+#define VIRTIO_ID_RPMB         28 /* virtio RPMB */
+
+static void vurpmb_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    /* this somehow needs to come from the vhost-user daemon */
+}
+
+static void vurpmb_start(VirtIODevice *vdev)
+{
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+    int i;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return;
+    }
+
+    ret = vhost_dev_enable_notifiers(&rpmb->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, rpmb->vhost_dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    rpmb->vhost_dev.acked_features = vdev->guest_features;
+    ret = vhost_dev_start(&rpmb->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error starting vhost-user-rpmb: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
+    /*
+     * guest_notifier_mask/pending not used yet, so just unmask
+     * everything here.  virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < rpmb->vhost_dev.nvqs; i++) {
+        vhost_virtqueue_mask(&rpmb->vhost_dev, vdev, i, false);
+    }
+
+    return;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, rpmb->vhost_dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&rpmb->vhost_dev, vdev);
+}
+
+static void vurpmb_stop(VirtIODevice *vdev)
+{
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&rpmb->vhost_dev, vdev);
+
+    ret = k->set_guest_notifiers(qbus->parent, rpmb->vhost_dev.nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&rpmb->vhost_dev, vdev);
+}
+
+static void vurpmb_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(vdev);
+    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
+
+    if (!vdev->vm_running) {
+        should_start = false;
+    }
+
+    if (rpmb->vhost_dev.started == should_start) {
+        return;
+    }
+
+    if (should_start) {
+        vurpmb_start(vdev);
+    } else {
+        vurpmb_stop(vdev);
+    }
+}
+
+static uint64_t vurpmb_get_features(VirtIODevice *vdev,
+                                      uint64_t requested_features,
+                                      Error **errp)
+{
+    /* No feature bits used yet */
+    return requested_features;
+}
+
+static void vurpmb_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /*
+     * Not normally called; it's the daemon that handles the queue;
+     * however virtio's cleanup path can call this.
+     */
+}
+
+static void vurpmb_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                            bool mask)
+{
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(vdev);
+    vhost_virtqueue_mask(&rpmb->vhost_dev, vdev, idx, mask);
+}
+
+static bool vurpmb_guest_notifier_pending(VirtIODevice *vdev, int idx)
+{
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(vdev);
+    return vhost_virtqueue_pending(&rpmb->vhost_dev, idx);
+}
+
+/*
+ * Chardev connect/disconnect events
+ */
+
+static int vurpmb_handle_config_change(struct vhost_dev *dev)
+{
+    int ret;
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(dev->vdev);
+
+    ret = vhost_dev_get_config(dev, (uint8_t *)&rpmb->conf.config,
+                               sizeof(struct virtio_rpmb_config));
+    if (ret < 0) {
+        error_report("get config space failed");
+        return -1;
+    }
+
+    return 0;
+}
+
+const VhostDevConfigOps rpmb_ops = {
+    .vhost_dev_config_notifier = vurpmb_handle_config_change,
+};
+
+static int vurpmb_connect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(vdev);
+
+    if (rpmb->connected) {
+        return 0;
+    }
+    rpmb->connected = true;
+
+    /* restore vhost state */
+    if (virtio_device_started(vdev, vdev->status)) {
+        vurpmb_start(vdev);
+    }
+
+    return 0;
+}
+
+static void vurpmb_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(vdev);
+
+    if (!rpmb->connected) {
+        return;
+    }
+    rpmb->connected = false;
+
+    if (rpmb->vhost_dev.started) {
+        vurpmb_stop(vdev);
+    }
+
+    vhost_dev_cleanup(&rpmb->vhost_dev);
+}
+
+static void vurpmb_event(void *opaque, QEMUChrEvent event)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(vdev);
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vurpmb_connect(dev) < 0) {
+            qemu_chr_fe_disconnect(&rpmb->conf.chardev);
+            return;
+        }
+        break;
+    case CHR_EVENT_CLOSED:
+        vurpmb_disconnect(dev);
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
+    }
+}
+
+static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserRPMB *rpmb)
+{
+    vhost_user_cleanup(&rpmb->vhost_user);
+    virtio_delete_queue(rpmb->req_vq);
+    virtio_cleanup(vdev);
+    g_free(rpmb->vhost_dev.vqs);
+    rpmb->vhost_dev.vqs = NULL;
+}
+
+
+static void vurpmb_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(dev);
+    int ret;
+
+    if (!rpmb->conf.chardev.chr) {
+        error_setg(errp, "missing chardev");
+        return;
+    }
+
+    if (!vhost_user_init(&rpmb->vhost_user, &rpmb->conf.chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, "vhost-user-rpmb", VIRTIO_ID_RPMB,
+                sizeof(struct virtio_rpmb_config));
+
+    /* One request queue, 4 elements in case we don't do indirect */
+    rpmb->req_vq = virtio_add_queue(vdev, 4, vurpmb_handle_output);
+    rpmb->vhost_dev.nvqs = 1;
+    rpmb->vhost_dev.vqs = g_new0(struct vhost_virtqueue, rpmb->vhost_dev.nvqs);
+    ret = vhost_dev_init(&rpmb->vhost_dev, &rpmb->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vhost_dev_init failed");
+        do_vhost_user_cleanup(vdev, rpmb);
+    }
+
+    /*
+     * At this point the next event we will get is a connection from
+     * the daemon on the control socket.
+     */
+
+    qemu_chr_fe_set_handlers(&rpmb->conf.chardev,  NULL, NULL, vurpmb_event,
+                             NULL, (void *)dev, NULL, true);
+
+    return;
+}
+
+static void vurpmb_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserRPMB *rpmb = VHOST_USER_RPMB(dev);
+
+    /* This will stop vhost backend if appropriate. */
+    vurpmb_set_status(vdev, 0);
+
+    do_vhost_user_cleanup(vdev, rpmb);
+}
+
+static const VMStateDescription vurpmb_vmstate = {
+    .name = "vhost-user-rpmb",
+    .unmigratable = 1,
+};
+
+static Property vurpmb_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserRPMB, conf.chardev),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vurpmb_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vurpmb_properties);
+    dc->vmsd = &vurpmb_vmstate;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    vdc->realize = vurpmb_device_realize;
+    vdc->unrealize = vurpmb_device_unrealize;
+    vdc->get_features = vurpmb_get_features;
+    vdc->get_config = vurpmb_get_config;
+    vdc->set_status = vurpmb_set_status;
+    vdc->guest_notifier_mask = vurpmb_guest_notifier_mask;
+    vdc->guest_notifier_pending = vurpmb_guest_notifier_pending;
+}
+
+static const TypeInfo vurpmb_info = {
+    .name = TYPE_VHOST_USER_RPMB,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostUserRPMB),
+    .class_init = vurpmb_class_init,
+};
+
+static void vurpmb_register_types(void)
+{
+    type_register_static(&vurpmb_info);
+}
+
+type_init(vurpmb_register_types)
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 2d17f481adc6..12e21870847a 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -38,5 +38,10 @@ config VHOST_USER_BLK
     default y if VIRTIO_PCI
     depends on VIRTIO && VHOST_USER && LINUX
 
+config VHOST_USER_RPMB
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
+
 config SWIM
     bool
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 78cad8f7cba1..114222f18424 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -17,5 +17,6 @@ softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('nvme.c'))
 
 specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
+specific_ss.add(when: 'CONFIG_VHOST_USER_RPMB', if_true: files('vhost-user-rpmb.c'))
 
 subdir('dataplane')
-- 
2.20.1


