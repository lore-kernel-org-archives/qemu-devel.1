Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681B8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F6C20B80
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="xAdn6nKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F6C20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEbk-00087Z-AL
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jeEZy-0005Ok-Ty; Thu, 28 May 2020 05:11:58 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jeEZx-0000sQ-GD; Thu, 28 May 2020 05:11:58 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 428212E1469;
 Thu, 28 May 2020 12:11:54 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 eYJ3mP7Ezr-BqfWrCTK; Thu, 28 May 2020 12:11:54 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590657114; bh=8CYEV8+lHbj8NJw/iCRDr9munqh9L4yXSxGeHJAhlEM=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=xAdn6nKab7X8m6jk+gHwlFMucgGBr9xrreIEW8okAQqUq+ZKyMCMW7eJ4fixWPUUe
 TVehZjsUztsRQq7FhB+og4wBxk8YYx/PT/15UJop6QufNE4SDaSHkTlvwS0HqShDl8
 dZSGH2Zgx/+mi7evFtjQ0ZTXIjbPva7YCBVir3GY=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8219::1:5])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 YZCPcdHrH5-BqWqnWQf; Thu, 28 May 2020 12:11:52 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
Date: Thu, 28 May 2020 12:11:19 +0300
Message-Id: <69b73b94dcd066065595266c852810e0863a0895.1590396396.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1590396396.git.dimastep@yandex-team.ru>
References: <cover.1590396396.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1590396396.git.dimastep@yandex-team.ru>
References: <cover.1590396396.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:11:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A socket write during vhost-user communication may trigger a disconnect
event, calling vhost_user_blk_disconnect() and clearing all the
vhost_dev structures holding data that vhost-user functions expect to
remain valid to roll back initialization correctly. Delay the cleanup to
keep vhost_dev structure valid.
There are two possible states to handle:
1. RUN_STATE_PRELAUNCH: skip bh oneshot call and perform disconnect in
the caller routine.
2. RUN_STATE_RUNNING: delay by using bh

BH changes are based on the similar changes for the vhost-user-net
device:
  commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
  "vhost-user: delay vhost_user_stop"

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9d8c0b3..76838e7 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -349,6 +349,19 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
     vhost_dev_cleanup(&s->dev);
 }
 
+static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
+
+static void vhost_user_blk_chr_closed_bh(void *opaque)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    vhost_user_blk_disconnect(dev);
+    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_event,
+            NULL, opaque, NULL, true);
+}
+
 static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
 {
     DeviceState *dev = opaque;
@@ -363,7 +376,30 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
         }
         break;
     case CHR_EVENT_CLOSED:
-        vhost_user_blk_disconnect(dev);
+        /*
+         * A close event may happen during a read/write, but vhost
+         * code assumes the vhost_dev remains setup, so delay the
+         * stop & clear. There are two possible paths to hit this
+         * disconnect event:
+         * 1. When VM is in the RUN_STATE_PRELAUNCH state. The
+         * vhost_user_blk_device_realize() is a caller.
+         * 2. In tha main loop phase after VM start.
+         *
+         * For p2 the disconnect event will be delayed. We can't
+         * do the same for p1, because we are not running the loop
+         * at this moment. So just skip this step and perform
+         * disconnect in the caller function.
+         *
+         * TODO: maybe it is a good idea to make the same fix
+         * for other vhost-user devices.
+         */
+        if (runstate_is_running()) {
+            AioContext *ctx = qemu_get_current_aio_context();
+
+            qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL, NULL,
+                    NULL, NULL, false);
+            aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
+        }
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
-- 
2.7.4


