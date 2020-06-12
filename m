Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92A6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754DD20835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMKj2MSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754DD20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlKc-0007mV-Ju
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2l-0007sS-On
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2i-0001VK-W8
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NYIzPHnTVGrlqldKcyFGJ1nv5lf4gt4t0AfJyHtJ8o=;
 b=DMKj2MSmMr5fonhFApprERq2R+8PTkdBv9L+Msx74P5OJRbfku6zEKXjpmNerz3n31KR9A
 BnsPz6Cyq/M52D6Elmntm8VAhcAhaQ/0R/Te+kHhZYYjKFHCOKGAjbOImVpX3gK/rdxRz6
 Y3+uy6VeSlEIcOZmhpqMjt2/goohRGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-seLpiYVpNAytrCL_fMpiqA-1; Fri, 12 Jun 2020 10:52:23 -0400
X-MC-Unique: seLpiYVpNAytrCL_fMpiqA-1
Received: by mail-wm1-f72.google.com with SMTP id p24so2548420wmc.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2NYIzPHnTVGrlqldKcyFGJ1nv5lf4gt4t0AfJyHtJ8o=;
 b=Hs+oZvkGzas7f/KPerBZDQbkxoeFm1K5CkqvobB/li0gs9VAuePP4HFDEucgoFPa4a
 ZtXtPqdPTIXSSV9hnH8SDH7DNXR8biYh8C+OMylJVNOc41QRcWDZRXfuqp8Slb6wLSKJ
 x33vEJl5JnZAxJEqliLoXbeVKyR7AfH1z7rBqUEk3oscjRlmsqCzQtp3gZbusZ3b6acp
 BOr8J4CWUYkKfq1SLMEVc/aqvGMF23gQpB4KAcSrlpCsTP25IXM1zqDE7HEYbA1eSgGO
 3NCnZmbD/DVlALiaVDwCEdE0Sp646wW+RLA+KM/DPfkLKgbJ/gCi0EHkYzWuyr/tIxNQ
 xCWA==
X-Gm-Message-State: AOAM531NGW4UJPzHWLdIRDqBcKXQTG5aepOci5bjwIlAmCpyJbynlCjh
 cOqmGLIDxHzZiCyGL2BiX7gy8SWK9pFVnUJT7c4sSD+5lavuBI/k0Np8o465DNFB6s8Y2Hckrde
 gyBGDtjoszrRyAgw=
X-Received: by 2002:adf:e648:: with SMTP id b8mr15826950wrn.386.1591973542122; 
 Fri, 12 Jun 2020 07:52:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCDx1fHgDc1mCeQmadSyBuNd/uapgEOinEMnmT8jOJCIR0b9tGEH4tCe/IEBKoSdyz64VrFg==
X-Received: by 2002:adf:e648:: with SMTP id b8mr15826931wrn.386.1591973541943; 
 Fri, 12 Jun 2020 07:52:21 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id b143sm2517331wme.20.2020.06.12.07.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:21 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 35/58] vhost-user-blk: delay vhost_user_blk_disconnect
Message-ID: <20200612141917.9446-36-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Li Feng <fengli@smartx.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

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
Message-Id: <69b73b94dcd066065595266c852810e0863a0895.1590396396.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/block/vhost-user-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9d8c0b3909..76838e76d3 100644
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
MST


