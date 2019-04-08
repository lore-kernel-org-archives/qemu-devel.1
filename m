Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F78C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC6720879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC6720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54717 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDW3F-0003xj-4i
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:19:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW1L-0002wV-1P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW1J-00024M-Sm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:15 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:43196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW1A-00010C-0A; Mon, 08 Apr 2019 11:17:05 -0400
X-IronPort-AV: E=Sophos;i="5.60,325,1549929600"; d="scan'208";a="83016892"
From: Paul Durrant <paul.durrant@citrix.com>
To: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>,
	<xen-devel@lists.xenproject.org>
Date: Mon, 8 Apr 2019 16:16:16 +0100
Message-ID: <20190408151617.13025-3-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
In-Reply-To: <20190408151617.13025-1-paul.durrant@citrix.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 162.221.156.55
Subject: [Qemu-devel] [PATCH 2/3] xen-bus: allow AioContext to be specified
 for each event channel
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
	Max Reitz <mreitz@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Anthony Perard <anthony.perard@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408151616.FYG-HGN0J-phHosDN4ebtgg1czFzvUtA66Qxl0dFm5E@z>

This patch adds an AioContext parameter to xen_device_bind_event_channel()
and then uses aio_set_fd_handler() to set the callback rather than
qemu_set_fd_handler().

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-block.c |  2 +-
 hw/xen/xen-bus.c               | 10 +++++++---
 include/hw/xen/xen-bus.h       |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index bb8f1186e4..1046f965c4 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -802,7 +802,7 @@ void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
     }
 
     dataplane->event_channel =
-        xen_device_bind_event_channel(xendev, event_channel,
+        xen_device_bind_event_channel(xendev, dataplane->ctx, event_channel,
                                       xen_block_dataplane_event, dataplane,
                                       &local_err);
     if (local_err) {
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 9e391492ac..4f634d1291 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -924,6 +924,7 @@ done:
 
 struct XenEventChannel {
     QLIST_ENTRY(XenEventChannel) list;
+    AioContext *ctx;
     xenevtchn_handle *xeh;
     evtchn_port_t local_port;
     XenEventHandler handler;
@@ -943,6 +944,7 @@ static void xen_device_event(void *opaque)
 }
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
+                                               AioContext *ctx,
                                                unsigned int port,
                                                XenEventHandler handler,
                                                void *opaque, Error **errp)
@@ -968,8 +970,9 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
     channel->handler = handler;
     channel->opaque = opaque;
 
-    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event, NULL,
-                        channel);
+    channel->ctx = ctx;
+    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), false,
+                       xen_device_event, NULL, NULL, channel);
 
     QLIST_INSERT_HEAD(&xendev->event_channels, channel, list);
 
@@ -1010,7 +1013,8 @@ void xen_device_unbind_event_channel(XenDevice *xendev,
 
     QLIST_REMOVE(channel, list);
 
-    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), NULL, NULL, NULL);
+    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), false,
+                       NULL, NULL, NULL, NULL);
 
     if (xenevtchn_unbind(channel->xeh, channel->local_port) < 0) {
         error_setg_errno(errp, errno, "xenevtchn_unbind failed");
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3315f0de20..8183b98c7d 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -122,6 +122,7 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
 typedef void (*XenEventHandler)(void *opaque);
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
+                                               AioContext *ctx,
                                                unsigned int port,
                                                XenEventHandler handler,
                                                void *opaque, Error **errp);
-- 
2.20.1.2.gb21ebb6


