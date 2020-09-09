Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92C1C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348582087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="Y8dfvxIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348582087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFv2P-0001JG-CU
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1kFv1L-0000n6-LU
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:59:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1kFv1J-0001OP-IQ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:59:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id 7so1474901pgm.11
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WiShvUgskqykiMOdHsLuoFlNAhgGyPel+lPdGWHOWw4=;
 b=Y8dfvxILFIRlKBeZO4xfcy5PDroS8YHFuc1M6H4S58u3va6vL9bLM+cUOL/CwLkils
 /uB3wNFhotRn91oR4ub7w5bFXvXkbVAx16pjva/hGm/RCXgrxBCRQ4Tl2qO5ZX6klaO9
 uWKt9TffsSu+j2QoGhqOuSLURX+85i3NG87WKLIAOMvmUVvRZc+GrIC0plsFRWYsiRss
 E7b1EmMY7HcvVz7XpSdPA9uZCniYQW3mcYtjeJKqQymjT4XgGcPJMW7abRImySxu6XH3
 0v61Vu9pPa5o6zXt2rsa8v3xCdPdQ7HXfDEjuA0q1QV0vKffh3kEtQxL9fKoUoSj45sw
 R0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WiShvUgskqykiMOdHsLuoFlNAhgGyPel+lPdGWHOWw4=;
 b=PJRzb1420pEvYZtxf+YK24t5Gcy9PziV/bZsfjmn892u1W6v7s8A3vVtzh1b707Tu/
 ltEmEoWAX7qa+zvlvzJUQsB6wAjsP5ylW3CUhBr3GppuWG6JEpW4ElYUpePTzYR0gDVA
 0tjRKgdloWBmAL0jiN7Yh3ETXtw2XLUAHl6JSwGQ5yEtwDFTCx6i8h6fKKQBkmlvct57
 8FdDO0HgAme2M5UEL2spj5nEl/cvr1snxMA7a75eJfb+KRT98EvHfOc2LlnE9Pdx1MGv
 eUgDULl3uqPuMRbqiJoSDnzfgaZifxw3mW6iTr2LvAPF2pMhDXQIiDegnHJSHudZEJco
 YCNg==
X-Gm-Message-State: AOAM530YFErl2SEjP0KZAY4mAJiWTLLsNvYA+ELlouhanhKkVW/mvpSO
 tC9URoWkaEY1eVbcuiiqMAKHpA==
X-Google-Smtp-Source: ABdhPJxgyEdZu0K7g+gJl5J/zMNPMGaoze7DNxnt399qOSjsWy3b/vNd5YOhbWFfuzKAQCCoRewy/A==
X-Received: by 2002:a17:902:8c96:b029:d0:ad87:6668 with SMTP id
 t22-20020a1709028c96b02900d0ad876668mr3100305plo.2.1599638394848; 
 Wed, 09 Sep 2020 00:59:54 -0700 (PDT)
Received: from localhost.localdomain ([47.75.244.237])
 by smtp.gmail.com with ESMTPSA id l2sm1217093pjy.3.2020.09.09.00.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 00:59:54 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: lifeng1519@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] vhost-scsi: support inflight io track
Date: Wed,  9 Sep 2020 20:20:21 +0800
Message-Id: <20200909122021.1055174-1-fengli@smartx.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_03_06=3.027,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Qemu will send GET_INFLIGHT_FD and SET_INFLIGH_FD to backend, and
the backend setup the inflight memory to track the io.

Change-Id: I805d6189996f7a1b44c65f0b12ef7473b1789510
Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/scsi/vhost-scsi-common.c           | 27 +++++++++++++++++++++++++++
 include/hw/virtio/vhost-scsi-common.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 8ec49d7fef..767f827e55 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -32,6 +32,8 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
+    VirtIOSCSICommon *vs = (VirtIOSCSICommon *)vsc;
+
     if (!k->set_guest_notifiers) {
         error_report("binding does not support guest notifiers");
         return -ENOSYS;
@@ -49,6 +51,23 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
     }
 
     vsc->dev.acked_features = vdev->guest_features;
+
+    assert(vsc->inflight == NULL);
+    vsc->inflight = g_new0(struct vhost_inflight, 1);
+    ret = vhost_dev_get_inflight(&vsc->dev,
+                                 vs->conf.virtqueue_size,
+                                 vsc->inflight);
+    if (ret < 0) {
+        error_report("Error get inflight: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
+    ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
+    if (ret < 0) {
+        error_report("Error set inflight: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
     ret = vhost_dev_start(&vsc->dev, vdev);
     if (ret < 0) {
         error_report("Error start vhost dev");
@@ -66,6 +85,9 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
     return ret;
 
 err_guest_notifiers:
+    g_free(vsc->inflight);
+    vsc->inflight = NULL;
+
     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
@@ -89,6 +111,11 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
     }
     assert(ret >= 0);
 
+    if (vsc->inflight) {
+        vhost_dev_free_inflight(vsc->inflight);
+        vsc->inflight = NULL;
+    }
+
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
 }
 
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index 16bf1a73c1..6cd6431d67 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -35,6 +35,8 @@ typedef struct VHostSCSICommon {
     int lun;
     uint64_t host_features;
     bool migratable;
+
+    struct vhost_inflight *inflight;
 } VHostSCSICommon;
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc);
-- 
2.26.2


