Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC60C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B8320704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="oqR/GfWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B8320704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgrx-0002Sk-I8
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRgmK-0001Y0-Gk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRgmJ-0004io-TV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:52 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:59924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jRgmH-0004c0-Bt; Thu, 23 Apr 2020 14:40:49 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 8E8A22E15CB;
 Thu, 23 Apr 2020 21:40:46 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 vIyfhVYIID-eiQCVYfP; Thu, 23 Apr 2020 21:40:46 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1587667246; bh=Fv6pZWWviC9Gnz6pDjZHVEUsXW2GPb2wYw220Nlajio=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=oqR/GfWbX7A3DDl+ut8AlJdXeTWoGoZ6mxLR8tsz5wAo6XhSD3pP6BhAmg/26HjZ/
 sSp67J+CeKR/M8QUTiGtxLQWWgkPzud5Cng9m7m/feWaMT4MSkFCQB38DoxUNvUZ6B
 j2BloZ0FlBSaYTnG/gDTd0QHg86CRYYR88azjZNg=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1313::1:e])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 7hClKENKMK-ehXewq95; Thu, 23 Apr 2020 21:40:43 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 7/7] vhost: add device started check in migration set
 log
Date: Thu, 23 Apr 2020 21:39:38 +0300
Message-Id: <b5f659a8c00cf5484ce0b095446761fcdc749609.1587667007.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587667007.git.dimastep@yandex-team.ru>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1587667007.git.dimastep@yandex-team.ru>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 14:40:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 95.108.205.193
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

If vhost-user daemon is used as a backend for the vhost device, then we
should consider a possibility of disconnect at any moment. If such
disconnect happened in the vhost_migration_log() routine the vhost
device structure will be clean up.
At the start of the vhost_migration_log() function there is a check:
  if (!dev->started) {
      dev->log_enabled = enable;
      return 0;
  }
To be consistent with this check add the same check after calling the
vhost_dev_set_log() routine. This in general help not to break a
migration due the assert() message. But it looks like that this code
should be revised to handle these errors more carefully.

In case of vhost-user device backend the fail paths should consider the
state of the device. In this case we should skip some function calls
during rollback on the error paths, so not to get the NULL dereference
errors.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 3ee50c4..d5ab96d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
 static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
 {
     int r, i, idx;
+
+    if (!dev->started) {
+        /*
+         * If vhost-user daemon is used as a backend for the
+         * device and the connection is broken, then the vhost_dev
+         * structure will be reset all its values to 0.
+         * Add additional check for the device state.
+         */
+        return -1;
+    }
+
     r = vhost_dev_set_features(dev, enable_log);
     if (r < 0) {
         goto err_features;
@@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
     }
     return 0;
 err_vq:
-    for (; i >= 0; --i) {
+    /*
+     * Disconnect with the vhost-user daemon can lead to the
+     * vhost_dev_cleanup() call which will clean up vhost_dev
+     * structure.
+     */
+    for (; dev->started && (i >= 0); --i) {
         idx = dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_index + i);
         vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
                                  dev->log_enabled);
     }
-    vhost_dev_set_features(dev, dev->log_enabled);
+    if (dev->started) {
+        vhost_dev_set_features(dev, dev->log_enabled);
+    }
 err_features:
     return r;
 }
@@ -832,7 +850,15 @@ static int vhost_migration_log(MemoryListener *listener, int enable)
     } else {
         vhost_dev_log_resize(dev, vhost_get_log_size(dev));
         r = vhost_dev_set_log(dev, true);
-        if (r < 0) {
+        /*
+         * The dev log resize can fail, because of disconnect
+         * with the vhost-user-blk daemon. Check the device
+         * state before calling the vhost_dev_set_log()
+         * function.
+         * Don't return error if device isn't started to be
+         * consistent with the check above.
+         */
+        if (dev->started && r < 0) {
             return r;
         }
     }
@@ -1739,7 +1765,12 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
 fail_log:
     vhost_log_put(hdev, false);
 fail_vq:
-    while (--i >= 0) {
+    /*
+     * Disconnect with the vhost-user daemon can lead to the
+     * vhost_dev_cleanup() call which will clean up vhost_dev
+     * structure.
+     */
+    while ((--i >= 0) && (hdev->started)) {
         vhost_virtqueue_stop(hdev,
                              vdev,
                              hdev->vqs + i,
-- 
2.7.4


