Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6665C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C648B20656
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="TmmHyScB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C648B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uNt-0005yz-Uh
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1k2uKL-0000wb-Na; Tue, 04 Aug 2020 06:37:49 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:48142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1k2uKF-0002KQ-7W; Tue, 04 Aug 2020 06:37:48 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net
 (iva8-d077482f1536.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 87DC92E1651;
 Tue,  4 Aug 2020 13:37:35 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net
 (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
 by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Ote9oNWC2p-bUtu0maj; Tue, 04 Aug 2020 13:37:35 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1596537455; bh=byWalZzlV6Kc9WQLv0XUfukdkc8FtZimav1r3Wx+JfY=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=TmmHyScBiFdXsCttXeMDslB+26hTyyxoyPV7xU/hsaS0qt4S2+YZkU1j0iei4poHD
 Zty7zEpwM+tUFr8hrwKCHibudKsnn2Ej6hnnrr2UIZkpcLs/1AzRVQUGeRys0zSrhB
 KjVJP6ru+0TD97x4RkM7sWYZ22+tUy7Xr/ctcufY=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:2::1:a])
 by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 ZZLKBSFEhl-bUiW9ggY; Tue, 04 Aug 2020 13:37:30 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/7] vhost: recheck dev state in the vhost_migration_log
 routine
Date: Tue,  4 Aug 2020 13:36:46 +0300
Message-Id: <723bde710a16a24f4d684d05abf4e61e1ee4138c.1596536559.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1596536559.git.dimastep@yandex-team.ru>
References: <cover.1596536559.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1596536559.git.dimastep@yandex-team.ru>
References: <cover.1596536559.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 06:37:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vhost-user devices can get a disconnect in the middle of the VHOST-USER
handshake on the migration start. If disconnect event happened right
before sending next VHOST-USER command, then the vhost_dev_set_log()
call in the vhost_migration_log() function will return error. This error
will lead to the assert() and close the QEMU migration source process.
For the vhost-user devices the disconnect event should not break the
migration process, because:
  - the device will be in the stopped state, so it will not be changed
    during migration
  - if reconnect will be made the migration log will be reinitialized as
    part of reconnect/init process:
    #0  vhost_log_global_start (listener=0x563989cf7be0)
    at hw/virtio/vhost.c:920
    #1  0x000056398603d8bc in listener_add_address_space (listener=0x563989cf7be0,
        as=0x563986ea4340 <address_space_memory>)
    at softmmu/memory.c:2664
    #2  0x000056398603dd30 in memory_listener_register (listener=0x563989cf7be0,
        as=0x563986ea4340 <address_space_memory>)
    at softmmu/memory.c:2740
    #3  0x0000563985fd6956 in vhost_dev_init (hdev=0x563989cf7bd8,
        opaque=0x563989cf7e30, backend_type=VHOST_BACKEND_TYPE_USER,
        busyloop_timeout=0)
    at hw/virtio/vhost.c:1385
    #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=0x563989cf7990)
    at hw/block/vhost-user-blk.c:315
    #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=0x563989cf7990,
        event=CHR_EVENT_OPENED)
    at hw/block/vhost-user-blk.c:379
Update the vhost-user-blk device with the internal started field which
will be used for initialization and clean up. The disconnect event will
set the overall VHOST device to the stopped state, so it can be used by
the vhost_migration_log routine.
Such approach could be propogated to the other vhost-user devices, but
better idea is just to make the same connect/disconnect code for all the
vhost-user devices.

This migration issue was slightly discussed earlier:
  - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
  - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 hw/block/vhost-user-blk.c          | 13 ++++++++++++-
 hw/virtio/vhost.c                  | 27 ++++++++++++++++++++++++---
 include/hw/virtio/vhost-user-blk.h |  1 +
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index a00b854..9da08ec 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -150,6 +150,7 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
         error_report("Error starting vhost: %d", -ret);
         goto err_guest_notifiers;
     }
+    s->started = true;
 
     /* guest_notifier_mask/pending not used yet, so just unmask
      * everything here. virtio-pci will do the right thing by
@@ -341,8 +342,9 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
     }
     s->connected = false;
 
-    if (s->dev.started) {
+    if (s->started) {
         vhost_user_blk_stop(vdev);
+        s->started = false;
     }
 
     vhost_dev_cleanup(&s->dev);
@@ -399,6 +401,15 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
                     NULL, NULL, false);
             aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
         }
+
+        /*
+         * Move vhost device to the stopped state. The vhost-user device
+         * will be clean up and disconnected in BH. This can be useful in
+         * the vhost migration code. If disconnect was caught there is an
+         * option for the general vhost code to get the dev state without
+         * knowing its type (in this case vhost-user).
+         */
+        s->dev.started = false;
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e..ffef7ab 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -861,21 +861,42 @@ static int vhost_migration_log(MemoryListener *listener, bool enable)
         dev->log_enabled = enable;
         return 0;
     }
+
+    r = 0;
     if (!enable) {
         r = vhost_dev_set_log(dev, false);
         if (r < 0) {
-            return r;
+            goto check_dev_state;
         }
         vhost_log_put(dev, false);
     } else {
         vhost_dev_log_resize(dev, vhost_get_log_size(dev));
         r = vhost_dev_set_log(dev, true);
         if (r < 0) {
-            return r;
+            goto check_dev_state;
         }
     }
+
+check_dev_state:
     dev->log_enabled = enable;
-    return 0;
+    /*
+     * vhost-user-* devices could change their state during log
+     * initialization due to disconnect. So check dev state after
+     * vhost communication.
+     */
+    if (!dev->started) {
+        /*
+         * Since device is in the stopped state, it is okay for
+         * migration. Return success.
+         */
+        r = 0;
+    }
+    if (r) {
+        /* An error is occured. */
+        dev->log_enabled = false;
+    }
+
+    return r;
 }
 
 static void vhost_log_global_start(MemoryListener *listener)
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 34ad6f0..2112a48 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -39,6 +39,7 @@ typedef struct VHostUserBlk {
     struct vhost_virtqueue *vhost_vqs;
     VirtQueue **virtqs;
     bool connected;
+    bool started;
 } VHostUserBlk;
 
 #endif
-- 
2.7.4


