Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB0BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B9F2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWTVAKb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B9F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisjs-0003Ft-Pw
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLF-0000mk-Sk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLE-0008KY-Vp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NYIzPHnTVGrlqldKcyFGJ1nv5lf4gt4t0AfJyHtJ8o=;
 b=KWTVAKb2E0ve1UY33bYS7S529sA9cHfhFg5jbFwjHAz8lg0SIAQgg/nAxwxqWti1KjwZoe
 MNX1jt+tG9pHb3FXe2lMPQlgz/ti6v7wiOf2GgfLy13B4hELMhkrzFQ2E6j0ZK0goajj9O
 3r4DQnebOglK9YKq/qoC65X+jmdr87g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-m8VbW_98MX2FcwVkd6YCbw-1; Wed, 10 Jun 2020 00:27:54 -0400
X-MC-Unique: m8VbW_98MX2FcwVkd6YCbw-1
Received: by mail-wr1-f70.google.com with SMTP id j16so491625wre.22
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2NYIzPHnTVGrlqldKcyFGJ1nv5lf4gt4t0AfJyHtJ8o=;
 b=cuTm1tWWbJEwqGD231hD1Yrw+zpLjYVF2PaKrGGNU6xy2ORzjVTzNb4IO6+0TQDzZl
 ilbg5IvY1GMP0Mm5FSkN+GbKSvuRC3viCNeQxpuSeroKfLo0cfYR8gQ70/QHKEREl8dS
 XHa2MtK8u6oTyr5k5MGa5kLI9O+NrHx6lBs0WWIvvuUNRLaWj18niXH0B8//pzLYYto0
 yeISIjY+AyKa5fQofb23Zt8tEiH9N3jKGyVV4OnOie6MSIRGmcNo05MyIUx74akvRH7u
 MNVREp7iBzC2fY1v1L1tn78gR6dqfMaOVQMgJCXu3TlHrqkKTGCK9fm5ECgk2KDkeZZ6
 CF0w==
X-Gm-Message-State: AOAM531RA29lOmE6h73tL2vMnEOVRTDorqFeFep8e9qKt6Jk24m/NsYQ
 Z9VxGV9O8i07o7zoSJoC/cqc2vaxmG69cex4O3uA6MnsKhPMqii8xQk6S5bc5bEHskpVP6VzWc1
 mdOCZJ969A4UsWrY=
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr1420691wrq.153.1591763273003; 
 Tue, 09 Jun 2020 21:27:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZc8jeOXxopUdkJ1qo/UY+m1QqcYUQj4xgs5kIQURzApNLs95VedY0LOv+9cEzCHcw1Te6qg==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr1420669wrq.153.1591763272813; 
 Tue, 09 Jun 2020 21:27:52 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id w17sm6177997wra.71.2020.06.09.21.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:52 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/56] vhost-user-blk: delay vhost_user_blk_disconnect
Message-ID: <20200610042613.1459309-36-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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


