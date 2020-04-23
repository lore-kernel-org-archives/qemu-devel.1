Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D98BC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AEC20704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="yYbBu7FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AEC20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgpm-0007HK-7L
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRgmB-0001Hq-2O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRgm9-0004W6-Vv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:42 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:46980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jRgm6-0004EK-Hx; Thu, 23 Apr 2020 14:40:38 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 46DE32E150B;
 Thu, 23 Apr 2020 21:40:36 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 WNXL47K6ek-eXHeXm5I; Thu, 23 Apr 2020 21:40:36 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1587667236; bh=/03BgTwU/psEMUgiBdmqNYh7VlIfn2pdgG96rmbifE4=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=yYbBu7FWt+zJ+GVyTZuw4ERXVRJm6Bxpcz84NOQaz5eu9S451HXTVJKPYNxoOez19
 Me7mjeDqe9tq7XXBzoiCv3riPhipup/k4JdvHrYer8KXddILJ4/o4sYlb+roPF7xdN
 xBJ1N+hrWOhdp/U11fbw/Y/e/NN+URRT8EsMVOW0=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1313::1:e])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 7hClKENKMK-eXXeVA3o; Thu, 23 Apr 2020 21:40:33 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 4/7] vhost: introduce wrappers to set guest notifiers
 for virtio device
Date: Thu, 23 Apr 2020 21:39:35 +0300
Message-Id: <f35a5f9e688bd7d5628c59d203b5d002183f65b7.1587667007.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587667007.git.dimastep@yandex-team.ru>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1587667007.git.dimastep@yandex-team.ru>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 14:40:14
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
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce new wrappers to set/reset guest notifiers for the virtio
device in the vhost device module:
  vhost_dev_assign_guest_notifiers
    ->set_guest_notifiers(..., ..., true);
  vhost_dev_drop_guest_notifiers
    ->set_guest_notifiers(..., ..., false);
This is a preliminary step to refactor code, so the set_guest_notifiers
methods could be called based on the vhost device state.
Update all vhost used devices to use these wrappers instead of direct
method call.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 backends/cryptodev-vhost.c  | 26 +++++++++++++++-----------
 backends/vhost-user.c       | 16 +++++-----------
 hw/block/vhost-user-blk.c   | 15 +++++----------
 hw/net/vhost_net.c          | 30 +++++++++++++++++-------------
 hw/scsi/vhost-scsi-common.c | 15 +++++----------
 hw/virtio/vhost-user-fs.c   | 17 +++++++----------
 hw/virtio/vhost-vsock.c     | 18 ++++++++----------
 hw/virtio/vhost.c           | 38 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio.c          | 13 +++++++++++++
 include/hw/virtio/vhost.h   |  4 ++++
 include/hw/virtio/virtio.h  |  1 +
 11 files changed, 118 insertions(+), 75 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 8337c9a..4522195 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -169,16 +169,13 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
 int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
 {
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
-    VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
     int r, e;
     int i;
     CryptoDevBackend *b = vcrypto->cryptodev;
     CryptoDevBackendVhost *vhost_crypto;
     CryptoDevBackendClient *cc;
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(dev)) {
         error_report("binding does not support guest notifiers");
         return -ENOSYS;
     }
@@ -198,9 +195,13 @@ int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
         }
      }
 
-    r = k->set_guest_notifiers(qbus->parent, total_queues, true);
+    /*
+     * Since all the states are handled by one vhost device,
+     * use the first one in array.
+     */
+    vhost_crypto = cryptodev_get_vhost(b->conf.peers.ccs[0], b, 0);
+    r = vhost_dev_assign_guest_notifiers(&vhost_crypto->dev, dev, total_queues);
     if (r < 0) {
-        error_report("error binding guest notifier: %d", -r);
         goto err;
     }
 
@@ -232,7 +233,8 @@ err_start:
         vhost_crypto = cryptodev_get_vhost(cc, b, i);
         cryptodev_vhost_stop_one(vhost_crypto, dev);
     }
-    e = k->set_guest_notifiers(qbus->parent, total_queues, false);
+    vhost_crypto = cryptodev_get_vhost(b->conf.peers.ccs[0], b, 0);
+    e = vhost_dev_drop_guest_notifiers(&vhost_crypto->dev, dev, total_queues);
     if (e < 0) {
         error_report("vhost guest notifier cleanup failed: %d", e);
     }
@@ -242,9 +244,6 @@ err:
 
 void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
 {
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
-    VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
     CryptoDevBackend *b = vcrypto->cryptodev;
     CryptoDevBackendVhost *vhost_crypto;
@@ -259,7 +258,12 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
         cryptodev_vhost_stop_one(vhost_crypto, dev);
     }
 
-    r = k->set_guest_notifiers(qbus->parent, total_queues, false);
+    /*
+     * Since all the states are handled by one vhost device,
+     * use the first one in array.
+     */
+    vhost_crypto = cryptodev_get_vhost(b->conf.peers.ccs[0], b, 0);
+    r = vhost_dev_drop_guest_notifiers(&vhost_crypto->dev, dev, total_queues);
     if (r < 0) {
         error_report("vhost guest notifier cleanup failed: %d", r);
     }
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 2bf3406..e116bc6 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -60,15 +60,13 @@ vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
 void
 vhost_user_backend_start(VhostUserBackend *b)
 {
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret, i ;
 
     if (b->started) {
         return;
     }
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(b->vdev)) {
         error_report("binding does not support guest notifiers");
         return;
     }
@@ -78,9 +76,8 @@ vhost_user_backend_start(VhostUserBackend *b)
         return;
     }
 
-    ret = k->set_guest_notifiers(qbus->parent, b->dev.nvqs, true);
+    ret = vhost_dev_assign_guest_notifiers(&b->dev, b->vdev, b->dev.nvqs);
     if (ret < 0) {
-        error_report("Error binding guest notifier");
         goto err_host_notifiers;
     }
 
@@ -104,7 +101,7 @@ vhost_user_backend_start(VhostUserBackend *b)
     return;
 
 err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false);
+    vhost_dev_drop_guest_notifiers(&b->dev, b->vdev, b->dev.nvqs);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&b->dev, b->vdev);
 }
@@ -112,8 +109,6 @@ err_host_notifiers:
 void
 vhost_user_backend_stop(VhostUserBackend *b)
 {
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret = 0;
 
     if (!b->started) {
@@ -122,9 +117,8 @@ vhost_user_backend_stop(VhostUserBackend *b)
 
     vhost_dev_stop(&b->dev, b->vdev);
 
-    if (k->set_guest_notifiers) {
-        ret = k->set_guest_notifiers(qbus->parent,
-                                     b->dev.nvqs, false);
+    if (virtio_device_guest_notifiers_initialized(b->vdev)) {
+        ret = vhost_dev_drop_guest_notifiers(&b->dev, b->vdev, b->dev.nvqs);
         if (ret < 0) {
             error_report("vhost guest notifier cleanup failed: %d", ret);
         }
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 17df533..70d7842 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -109,11 +109,9 @@ const VhostDevConfigOps blk_ops = {
 static int vhost_user_blk_start(VirtIODevice *vdev)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int i, ret;
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(vdev)) {
         error_report("binding does not support guest notifiers");
         return -ENOSYS;
     }
@@ -124,9 +122,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
         return ret;
     }
 
-    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, true);
+    ret = vhost_dev_assign_guest_notifiers(&s->dev, vdev, s->dev.nvqs);
     if (ret < 0) {
-        error_report("Error binding guest notifier: %d", -ret);
         goto err_host_notifiers;
     }
 
@@ -163,7 +160,7 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
     return ret;
 
 err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
+    vhost_dev_drop_guest_notifiers(&s->dev, vdev, s->dev.nvqs);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&s->dev, vdev);
     return ret;
@@ -172,17 +169,15 @@ err_host_notifiers:
 static void vhost_user_blk_stop(VirtIODevice *vdev)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(vdev)) {
         return;
     }
 
     vhost_dev_stop(&s->dev, vdev);
 
-    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
+    ret = vhost_dev_drop_guest_notifiers(&s->dev, vdev, s->dev.nvqs);
     if (ret < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
         return;
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b82803..c13b444 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -303,19 +303,15 @@ static void vhost_net_stop_one(struct vhost_net *net,
 int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
                     int total_queues)
 {
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
-    VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *net;
     int r, e, i;
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(dev)) {
         error_report("binding does not support guest notifiers");
         return -ENOSYS;
     }
 
     for (i = 0; i < total_queues; i++) {
-        struct vhost_net *net;
-
         net = get_vhost_net(ncs[i].peer);
         vhost_net_set_vq_index(net, i * 2);
 
@@ -328,9 +324,13 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
      }
 
-    r = k->set_guest_notifiers(qbus->parent, total_queues * 2, true);
+    /*
+     * Since all the states are handled by one vhost_net device,
+     * use the first one in array.
+     */
+    net = get_vhost_net(ncs[0].peer);
+    r = vhost_dev_assign_guest_notifiers(&net->dev, dev, total_queues * 2);
     if (r < 0) {
-        error_report("Error binding guest notifier: %d", -r);
         goto err;
     }
 
@@ -357,7 +357,8 @@ err_start:
     while (--i >= 0) {
         vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
     }
-    e = k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
+    net = get_vhost_net(ncs[0].peer);
+    e = vhost_dev_drop_guest_notifiers(&net->dev, dev, total_queues * 2);
     if (e < 0) {
         fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
         fflush(stderr);
@@ -369,16 +370,19 @@ err:
 void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
                     int total_queues)
 {
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
-    VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *net;
     int i, r;
 
     for (i = 0; i < total_queues; i++) {
         vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
     }
 
-    r = k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
+    /*
+     * Since all the states are handled by one vhost_net device,
+     * use the first one in array.
+     */
+    net = get_vhost_net(ncs[0].peer);
+    r = vhost_dev_drop_guest_notifiers(&net->dev, dev, total_queues * 2);
     if (r < 0) {
         fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", r);
         fflush(stderr);
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 8ec49d7..8f51ec0 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -29,10 +29,8 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
 {
     int ret, i;
     VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(vdev)) {
         error_report("binding does not support guest notifiers");
         return -ENOSYS;
     }
@@ -42,9 +40,8 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
         return ret;
     }
 
-    ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
+    ret = vhost_dev_assign_guest_notifiers(&vsc->dev, vdev, vsc->dev.nvqs);
     if (ret < 0) {
-        error_report("Error binding guest notifier");
         goto err_host_notifiers;
     }
 
@@ -66,7 +63,7 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
     return ret;
 
 err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
+    vhost_dev_drop_guest_notifiers(&vsc->dev, vdev, vsc->dev.nvqs);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
     return ret;
@@ -75,14 +72,12 @@ err_host_notifiers:
 void vhost_scsi_common_stop(VHostSCSICommon *vsc)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret = 0;
 
     vhost_dev_stop(&vsc->dev, vdev);
 
-    if (k->set_guest_notifiers) {
-        ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
+    if (virtio_device_guest_notifiers_initialized(vdev)) {
+        ret = vhost_dev_drop_guest_notifiers(&vsc->dev, vdev, vsc->dev.nvqs);
         if (ret < 0) {
                 error_report("vhost guest notifier cleanup failed: %d", ret);
         }
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 6136768..6b101fc 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -38,12 +38,10 @@ static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
 static void vuf_start(VirtIODevice *vdev)
 {
     VHostUserFS *fs = VHOST_USER_FS(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
     int i;
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(vdev)) {
         error_report("binding does not support guest notifiers");
         return;
     }
@@ -54,9 +52,9 @@ static void vuf_start(VirtIODevice *vdev)
         return;
     }
 
-    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, true);
+    ret = vhost_dev_assign_guest_notifiers(&fs->vhost_dev, vdev,
+            fs->vhost_dev.nvqs);
     if (ret < 0) {
-        error_report("Error binding guest notifier: %d", -ret);
         goto err_host_notifiers;
     }
 
@@ -79,7 +77,7 @@ static void vuf_start(VirtIODevice *vdev)
     return;
 
 err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
+    vhost_dev_drop_guest_notifiers(&fs->vhost_dev, vdev, fs->vhost_dev.nvqs);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
 }
@@ -87,17 +85,16 @@ err_host_notifiers:
 static void vuf_stop(VirtIODevice *vdev)
 {
     VHostUserFS *fs = VHOST_USER_FS(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(vdev)) {
         return;
     }
 
     vhost_dev_stop(&fs->vhost_dev, vdev);
 
-    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
+    ret = vhost_dev_drop_guest_notifiers(&fs->vhost_dev, vdev,
+            fs->vhost_dev.nvqs);
     if (ret < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
         return;
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 09b6b07..52489dd 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -75,12 +75,10 @@ static int vhost_vsock_set_running(VHostVSock *vsock, int start)
 static void vhost_vsock_start(VirtIODevice *vdev)
 {
     VHostVSock *vsock = VHOST_VSOCK(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
     int i;
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(vdev)) {
         error_report("binding does not support guest notifiers");
         return;
     }
@@ -91,9 +89,9 @@ static void vhost_vsock_start(VirtIODevice *vdev)
         return;
     }
 
-    ret = k->set_guest_notifiers(qbus->parent, vsock->vhost_dev.nvqs, true);
+    ret = vhost_dev_assign_guest_notifiers(&vsock->vhost_dev,
+            vdev, vsock->vhost_dev.nvqs);
     if (ret < 0) {
-        error_report("Error binding guest notifier: %d", -ret);
         goto err_host_notifiers;
     }
 
@@ -123,7 +121,8 @@ static void vhost_vsock_start(VirtIODevice *vdev)
 err_dev_start:
     vhost_dev_stop(&vsock->vhost_dev, vdev);
 err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, vsock->vhost_dev.nvqs, false);
+    vhost_dev_drop_guest_notifiers(&vsock->vhost_dev,
+            vdev, vsock->vhost_dev.nvqs);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&vsock->vhost_dev, vdev);
 }
@@ -131,11 +130,9 @@ err_host_notifiers:
 static void vhost_vsock_stop(VirtIODevice *vdev)
 {
     VHostVSock *vsock = VHOST_VSOCK(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
 
-    if (!k->set_guest_notifiers) {
+    if (!virtio_device_guest_notifiers_initialized(vdev)) {
         return;
     }
 
@@ -147,7 +144,8 @@ static void vhost_vsock_stop(VirtIODevice *vdev)
 
     vhost_dev_stop(&vsock->vhost_dev, vdev);
 
-    ret = k->set_guest_notifiers(qbus->parent, vsock->vhost_dev.nvqs, false);
+    ret = vhost_dev_drop_guest_notifiers(&vsock->vhost_dev,
+            vdev, vsock->vhost_dev.nvqs);
     if (ret < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
         return;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 01ebe12..fa3da9c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1419,6 +1419,44 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
     virtio_device_release_ioeventfd(vdev);
 }
 
+/*
+ * Assign guest notifiers.
+ * Should be called after vhost_dev_enable_notifiers.
+ */
+int vhost_dev_assign_guest_notifiers(struct vhost_dev *hdev,
+                                     VirtIODevice *vdev, int nvqs)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    ret = k->set_guest_notifiers(qbus->parent, nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+    }
+
+    return ret;
+}
+
+/*
+ * Drop guest notifiers.
+ * Should be called before vhost_dev_disable_notifiers.
+ */
+int vhost_dev_drop_guest_notifiers(struct vhost_dev *hdev,
+                                   VirtIODevice *vdev, int nvqs)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    ret = k->set_guest_notifiers(qbus->parent, nvqs, false);
+    if (ret < 0) {
+        error_report("Error reset guest notifier: %d", -ret);
+    }
+
+    return ret;
+}
+
 /* Test and clear event pending status.
  * Should be called after unmask to avoid losing events.
  */
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b6c8ef5..8a95618 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3812,6 +3812,19 @@ bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
     return virtio_bus_ioeventfd_enabled(vbus);
 }
 
+/*
+ * Check if set_guest_notifiers() method is set by the init routine.
+ * Return true if yes, otherwise return false.
+ */
+bool virtio_device_guest_notifiers_initialized(VirtIODevice *vdev)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+
+    return k->set_guest_notifiers;
+}
+
+
 static const TypeInfo virtio_device_info = {
     .name = TYPE_VIRTIO_DEVICE,
     .parent = TYPE_DEVICE,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 085450c..4d0d2e2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -100,6 +100,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev);
 void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev);
 int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev);
 void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev);
+int vhost_dev_assign_guest_notifiers(struct vhost_dev *hdev,
+                                     VirtIODevice *vdev, int nvqs);
+int vhost_dev_drop_guest_notifiers(struct vhost_dev *hdev,
+                                   VirtIODevice *vdev, int nvqs);
 
 /* Test and clear masked event pending status.
  * Should be called after unmask to avoid losing events.
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b69d517..d9a3d72 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -323,6 +323,7 @@ void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
                                                 VirtIOHandleAIOOutput handle_output);
 VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
 VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
+bool virtio_device_guest_notifiers_initialized(VirtIODevice *vdev);
 
 static inline void virtio_add_feature(uint64_t *features, unsigned int fbit)
 {
-- 
2.7.4


