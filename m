Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798AC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83D323888
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2gOfWUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83D323888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJI7I-0000CZ-Iv
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxt-0006Zu-4d
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxm-0000YD-4B
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LWfXGcJUqmqnQm73g6R37Nb0eDstIXJBzwfXH66PjOk=;
 b=V2gOfWUFNZkiJQnO3r51bSxbX3aFMxBonJeDKSwYJorTF2K0vgKwsvLhJFZpoHJVzQ+oPm
 SVfRce7dFBIafdEDnl9i8xqWCmB/tXE/QgJElGCxGNF08TcqvCrbws0TIEvW0y7TNgKoHd
 qHEPip/id7IHJDOkLp+ygQ534Cpwx1o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-_3IXzmXCMxCoUgFuTC7Uow-1; Fri, 18 Sep 2020 11:06:09 -0400
X-MC-Unique: _3IXzmXCMxCoUgFuTC7Uow-1
Received: by mail-wr1-f69.google.com with SMTP id g6so2249190wrv.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LWfXGcJUqmqnQm73g6R37Nb0eDstIXJBzwfXH66PjOk=;
 b=ANRlnFfVmBPWprFWCmf93mYAZl4MudZKDwLZf4dRK1f0/ZnHlMnx49ih8WLfMJy1X6
 A/jcXUNHYLMgtVuFxvFHBfyCKyiMVE4CLGw2AQjfjMRJy2Yfkh9m9l8cUp84xt7BOwrt
 xYZX8YMRsPcTmaauNUNKtyqsn1MwPk7MInhZhLewvyXAZm2v1Bv9/tQP8Tojnb8Att3z
 sF4K5ePb4/QxZUCu/KUj3uoAsjrwlO7lLVE06FtbJUCMPetVOHVpjBQmIwpGjyhRhbAG
 jsmJhaQ4Ylk0ts2VZOBmZrcUzd8KENTjOGG6Xxg9mjfuuHzVNuUAzLlLuNlsVqGtfX64
 B18w==
X-Gm-Message-State: AOAM5313inGwblYsQjz0WzlBjAv1HibTqlhV7kTpSxAJfyZkv+s3kmGm
 AG7IDvWe685oFrVd3CVkNt+jC+UE0l11wdhkUTtRyGHYOm03DrZDpnkqIuF5bkGk6dkh9gcu/C4
 I/M9N8W9n0hxbwZQ=
X-Received: by 2002:adf:e449:: with SMTP id t9mr38873724wrm.154.1600441567795; 
 Fri, 18 Sep 2020 08:06:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtDPhEUn/srHYg56WnUxmYX/I45sCVEYiTgFggwfovQJkuDLEUKbNk9mDYI52djlCKO0CE6g==
X-Received: by 2002:adf:e449:: with SMTP id t9mr38873697wrm.154.1600441567535; 
 Fri, 18 Sep 2020 08:06:07 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id u12sm5626173wrt.81.2020.09.18.08.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:06:06 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:06:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] vhost: recheck dev state in the vhost_migration_log
 routine
Message-ID: <20200918150506.286890-7-mst@redhat.com>
References: <20200918150506.286890-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918150506.286890-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 08:09:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

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
Update the vhost-user-blk device with the internal started_vu field which
will be used for initialization (vhost_user_blk_start) and clean up
(vhost_user_blk_stop). This additional flag in the VhostUserBlk structure
will be used to track whether the device really needs to be stopped and
cleaned up on a vhost-user level.
The disconnect event will set the overall VHOST device (not vhost-user) to
the stopped state, so it can be used by the general vhost_migration_log
routine.
Such approach could be propogated to the other vhost-user devices, but
better idea is just to make the same connect/disconnect code for all the
vhost-user devices.

This migration issue was slightly discussed earlier:
  - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
  - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <a35178fe9e90d2552990a6b359a626e0a40d8b17.1598865610.git.dimastep@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h | 10 ++++++++++
 hw/block/vhost-user-blk.c          | 19 ++++++++++++++++---
 hw/virtio/vhost.c                  | 27 ++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index dc40ab6f11..5d86ff2e87 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -42,7 +42,17 @@ struct VHostUserBlk {
     VhostUserState vhost_user;
     struct vhost_virtqueue *vhost_vqs;
     VirtQueue **virtqs;
+
+    /*
+     * There are at least two steps of initialization of the
+     * vhost-user device. The first is a "connect" step and
+     * second is a "start" step. Make a separation between
+     * those initialization phases by using two fields.
+     */
+    /* vhost_user_blk_connect/vhost_user_blk_disconnect */
     bool connected;
+    /* vhost_user_blk_start/vhost_user_blk_stop */
+    bool started_vu;
 };
 
 #endif
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 39aec42dae..a076b1e54d 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -150,6 +150,7 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
         error_report("Error starting vhost: %d", -ret);
         goto err_guest_notifiers;
     }
+    s->started_vu = true;
 
     /* guest_notifier_mask/pending not used yet, so just unmask
      * everything here. virtio-pci will do the right thing by
@@ -175,6 +176,11 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
 
+    if (!s->started_vu) {
+        return;
+    }
+    s->started_vu = false;
+
     if (!k->set_guest_notifiers) {
         return;
     }
@@ -341,9 +347,7 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
     }
     s->connected = false;
 
-    if (s->dev.started) {
-        vhost_user_blk_stop(vdev);
-    }
+    vhost_user_blk_stop(vdev);
 
     vhost_dev_cleanup(&s->dev);
 }
@@ -399,6 +403,15 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
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
index e986bf53e4..1b2d735b54 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -871,21 +871,42 @@ static int vhost_migration_log(MemoryListener *listener, bool enable)
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
-- 
MST


