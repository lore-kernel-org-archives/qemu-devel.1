Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC5C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE10208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiR+TA5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE10208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfMQ-0002Nw-1T
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGy-0005Fw-Vz
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37989
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGw-0007Mn-FE
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAYWlJlNOXYE2x9NUnMa1XUzxC4abbZAgb2Lw8TbFdE=;
 b=PiR+TA5+0iKILvADnTDdp2YYSp4vmjxDCDYh2c14+tyV2A/NYDcG6Fkq4MNWUu5IcwA/yo
 xt6UfcAmqign2aPv8GderT6KtatodjiG322MzHKzJwnDR+lhmPzYXLegHyrgUHKVUJ46tX
 56HpuUBtOHxCv1lIKXrbViMEbu8igQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-SFpnapmtNaWeF3AhXKTZRA-1; Sat, 19 Sep 2020 11:59:31 -0400
X-MC-Unique: SFpnapmtNaWeF3AhXKTZRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 214DB1006710;
 Sat, 19 Sep 2020 15:59:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A66501975E;
 Sat, 19 Sep 2020 15:59:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/57] vhost-scsi: support inflight io track
Date: Sat, 19 Sep 2020 11:58:31 -0400
Message-Id: <20200919155916.1046398-13-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:26:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Feng <fengli@smartx.com>

Qemu will send GET_INFLIGHT_FD and SET_INFLIGH_FD to backend, and
the backend setup the inflight memory to track the io.

Change-Id: I805d6189996f7a1b44c65f0b12ef7473b1789510
Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20200909122021.1055174-1-fengli@smartx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 5f0bf73d9d..3be152e45b 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -37,6 +37,8 @@ struct VHostSCSICommon {
     int lun;
     uint64_t host_features;
     bool migratable;
+
+    struct vhost_inflight *inflight;
 };
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc);
-- 
2.26.2



