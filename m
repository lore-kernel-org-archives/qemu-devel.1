Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1038C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B673206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I4ZfteFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B673206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igrTx-00038O-L3
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 09:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2465856dc=pdurrant@amazon.com>)
 id 1igrT1-0002Z3-SM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2465856dc=pdurrant@amazon.com>)
 id 1igrT0-0002p3-Ea
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:35:23 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=2465856dc=pdurrant@amazon.com>)
 id 1igrSv-0002nZ-Bo; Mon, 16 Dec 2019 09:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1576506918; x=1608042918;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mo5tkH2WlUm0uRAeRwD/f8E6x/WRLfP+Q3QUirldoBo=;
 b=I4ZfteFXWS7YhFRafp+xo4VqYowJwG0aJbcNTkWXqSUu1y+egSsBtNz8
 83+NhQ246oMdtiu2xSt/t2qEnr0IBHUnYUti0l2MGjatRCIHYKKWnqRA8
 vonariUkh730NqGw5NCeSa14GIDCWuQzq6s2foJHx2i8O3uj0Dsn6k/WB A=;
IronPort-SDR: HvceauYoX5O6jdFTstyRE1PiDVuS1O9t0RZUEsmrZNMeHtOkokM5ubMiT+imvBBTZd44HJOFlB
 7Qd0Fug4EkVw==
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="5372634"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 16 Dec 2019 14:35:05 +0000
Received: from EX13MTAUEA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS
 id 16CDAA27C5; Mon, 16 Dec 2019 14:35:02 +0000 (UTC)
Received: from EX13D32EUB001.ant.amazon.com (10.43.166.125) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 14:35:01 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D32EUB001.ant.amazon.com (10.43.166.125) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 14:35:00 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 16 Dec 2019 14:34:57 +0000
From: Paul Durrant <pdurrant@amazon.com>
To: <xen-devel@lists.xenproject.org>, <qemu-block@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: Paul Durrant <pdurrant@amazon.com>, Julien Grall <jgrall@amazon.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Kevin
 Wolf" <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Subject: [PATCH] xen-bus/block: explicitly assign event channels to an
 AioContext
Date: Mon, 16 Dec 2019 14:34:51 +0000
Message-ID: <20191216143451.19024-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 207.171.184.25
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not safe to close an event channel from the QEMU main thread when
that channel's poller is running in IOThread context.

This patch adds a new xen_device_set_event_channel_context() function
to explicitly assign the channel AioContext, and modifies
xen_device_bind_event_channel() to initially assign the channel's poller
to the QEMU main thread context. The code in xen-block's dataplane is
then modified to assign the channel to IOThread context during
xen_block_dataplane_start() and de-assign it during in
xen_block_dataplane_stop(), such that the channel is always assigned
back to main thread context before it is closed. aio_set_fd_handler()
already deals with all the necessary synchronization when moving an fd
between AioContext-s so no extra code is needed to manage this.

Reported-by: Julien Grall <jgrall@amazon.com>
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

Tested against an HVM debian guest with a QCOW2 image as system disk, and
as a hot-plugged/unplgged secondary disk.
---
 hw/block/dataplane/xen-block.c | 20 ++++++++++++++++++--
 hw/xen/xen-bus.c               | 27 +++++++++++++++++++++++----
 include/hw/xen/xen-bus.h       |  5 ++++-
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 3b9caeb2fa..288a87a814 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -685,12 +685,24 @@ void xen_block_dataplane_stop(XenBlockDataPlane *dataplane)
         return;
     }
 
+    xendev = dataplane->xendev;
+
     aio_context_acquire(dataplane->ctx);
+    if (dataplane->event_channel) {
+        /* Only reason for failure is a NULL channel */
+        xen_device_set_event_channel_context(xendev, dataplane->event_channel,
+                                             qemu_get_aio_context(),
+                                             &error_abort);
+    }
     /* Xen doesn't have multiple users for nodes, so this can't fail */
     blk_set_aio_context(dataplane->blk, qemu_get_aio_context(), &error_abort);
     aio_context_release(dataplane->ctx);
 
-    xendev = dataplane->xendev;
+    /*
+     * Now that the context has been moved onto the main thread, cancel
+     * further processing.
+     */
+    qemu_bh_cancel(dataplane->bh);
 
     if (dataplane->event_channel) {
         Error *local_err = NULL;
@@ -807,7 +819,7 @@ void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
     }
 
     dataplane->event_channel =
-        xen_device_bind_event_channel(xendev, dataplane->ctx, event_channel,
+        xen_device_bind_event_channel(xendev, event_channel,
                                       xen_block_dataplane_event, dataplane,
                                       &local_err);
     if (local_err) {
@@ -818,7 +830,11 @@ void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
     aio_context_acquire(dataplane->ctx);
     /* If other users keep the BlockBackend in the iothread, that's ok */
     blk_set_aio_context(dataplane->blk, dataplane->ctx, NULL);
+    /* Only reason for failure is a NULL channel */
+    xen_device_set_event_channel_context(xendev, dataplane->event_channel,
+                                         dataplane->ctx, &error_abort);
     aio_context_release(dataplane->ctx);
+
     return;
 
 stop:
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index c2ad22a42d..349856b32b 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1089,8 +1089,26 @@ static void xen_device_event(void *opaque)
     }
 }
 
+void xen_device_set_event_channel_context(XenDevice *xendev,
+                                          XenEventChannel *channel,
+                                          AioContext *ctx,
+                                          Error **errp)
+{
+    if (!channel) {
+        error_setg(errp, "bad channel");
+        return;
+    }
+
+    if (channel->ctx)
+        aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
+                           NULL, NULL, NULL, NULL);
+
+    channel->ctx = ctx;
+    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
+                       xen_device_event, NULL, xen_device_poll, channel);
+}
+
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
-                                               AioContext *ctx,
                                                unsigned int port,
                                                XenEventHandler handler,
                                                void *opaque, Error **errp)
@@ -1116,9 +1134,10 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
     channel->handler = handler;
     channel->opaque = opaque;
 
-    channel->ctx = ctx;
-    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
-                       xen_device_event, NULL, xen_device_poll, channel);
+    /* Only reason for failure is a NULL channel */
+    xen_device_set_event_channel_context(xendev, channel,
+                                         qemu_get_aio_context(),
+                                         &error_abort);
 
     QLIST_INSERT_HEAD(&xendev->event_channels, channel, list);
 
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3d5532258d..c18c1372af 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -128,10 +128,13 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
 typedef bool (*XenEventHandler)(void *opaque);
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
-                                               AioContext *ctx,
                                                unsigned int port,
                                                XenEventHandler handler,
                                                void *opaque, Error **errp);
+void xen_device_set_event_channel_context(XenDevice *xendev,
+                                          XenEventChannel *channel,
+                                          AioContext *ctx,
+                                          Error **errp);
 void xen_device_notify_event_channel(XenDevice *xendev,
                                      XenEventChannel *channel,
                                      Error **errp);
-- 
2.20.1


