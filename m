Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4C0C47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D432063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Qi+NXMT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D432063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9g2-0006Po-LM
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jU9TM-0001BU-Qb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jU9Qd-0008Fi-E8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:43:28 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:60108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jU9NM-0001jK-CA; Thu, 30 Apr 2020 09:37:16 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 45D5D2E151A;
 Thu, 30 Apr 2020 16:37:12 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 SUWv4Mec3s-b7X4UTL4; Thu, 30 Apr 2020 16:37:12 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588253832; bh=kUkFhpkmkerAUcEO23m978mFXGVV+mbiJpdw3pimI38=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=Qi+NXMT6Ijxlj0zDe0PAUGxzXOWda3qxv7gQmA+ZoORjIW3HqEiIYEnUoqlD4tBPI
 gHfE4/nmIUufy+22SeuwA1PkVA7JXHZZcphUSW4Zh+95uWDEMjSLvNNi219uV8mOCv
 ADGOrjjqNJk6TK2hZvdvNiJoh6loNHp9n0nL/yoQ=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7108::1:9])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 tZ29y7t6r8-b7WKL4mb; Thu, 30 Apr 2020 16:37:07 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] vhost-user-blk: add mechanism to track the guest
 notifiers init state
Date: Thu, 30 Apr 2020 16:36:18 +0300
Message-Id: <d20d6de600837aebbf644666be064f761f764832.1588252862.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1588252861.git.dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1588252861.git.dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:37:12
X-ACL-Warn: Detected OS   = ???
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, arei.gonglei@huawei.com,
 fengli@smartx.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case of the vhost-user devices the daemon can be killed at any
moment. Since QEMU supports the reconnet functionality the guest
notifiers should be reset and disabled after "disconnect" event. The
most issues were found if the "disconnect" event happened during vhost
device initialization step.
The disconnect event leads to the call of the vhost_dev_cleanup()
routine. Which memset to 0 a vhost device structure. Because of this, if
device was not started (dev.started == false) and the connection is
broken, then the set_guest_notifier method will produce assertion error.
Also connection can be broken after the dev.started field is set to
true.
A new notifiers_set field is added to the vhost_dev structure to track
the state of the guest notifiers during the initialization process.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 hw/block/vhost-user-blk.c |  8 ++++----
 hw/virtio/vhost.c         | 11 +++++++++++
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 70d7842..5a3de0f 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -175,7 +175,9 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
         return;
     }
 
-    vhost_dev_stop(&s->dev, vdev);
+    if (s->dev.started) {
+        vhost_dev_stop(&s->dev, vdev);
+    }
 
     ret = vhost_dev_drop_guest_notifiers(&s->dev, vdev, s->dev.nvqs);
     if (ret < 0) {
@@ -337,9 +339,7 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
     }
     s->connected = false;
 
-    if (s->dev.started) {
-        vhost_user_blk_stop(vdev);
-    }
+    vhost_user_blk_stop(vdev);
 
     vhost_dev_cleanup(&s->dev);
 }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index fa3da9c..ddbdc53 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1380,6 +1380,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
             goto fail_vq;
         }
     }
+    hdev->notifiers_set = true;
 
     return 0;
 fail_vq:
@@ -1407,6 +1408,10 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     int i, r;
 
+    if (!hdev->notifiers_set) {
+        return;
+    }
+
     for (i = 0; i < hdev->nvqs; ++i) {
         r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i,
                                          false);
@@ -1417,6 +1422,8 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
         virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
     }
     virtio_device_release_ioeventfd(vdev);
+
+    hdev->notifiers_set = false;
 }
 
 /*
@@ -1449,6 +1456,10 @@ int vhost_dev_drop_guest_notifiers(struct vhost_dev *hdev,
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
 
+    if (!hdev->notifiers_set) {
+        return 0;
+    }
+
     ret = k->set_guest_notifiers(qbus->parent, nvqs, false);
     if (ret < 0) {
         error_report("Error reset guest notifier: %d", -ret);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 4d0d2e2..e3711a7 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -90,6 +90,7 @@ struct vhost_dev {
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
     const VhostDevConfigOps *config_ops;
+    bool notifiers_set;
 };
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
-- 
2.7.4


