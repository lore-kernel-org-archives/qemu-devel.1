Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E6AC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E05F2087F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E05F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDW3Q-00048B-GV
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:19:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW1L-0002wX-5K
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW1J-00024D-Rn
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:15 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:43190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW19-0000tN-A5; Mon, 08 Apr 2019 11:17:03 -0400
X-IronPort-AV: E=Sophos;i="5.60,325,1549929600"; d="scan'208";a="83016903"
From: Paul Durrant <paul.durrant@citrix.com>
To: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>,
	<xen-devel@lists.xenproject.org>
Date: Mon, 8 Apr 2019 16:16:17 +0100
Message-ID: <20190408151617.13025-4-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
In-Reply-To: <20190408151617.13025-1-paul.durrant@citrix.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 162.221.156.55
Subject: [Qemu-devel] [PATCH 3/3] xen-bus / xen-block: add support for event
 channel polling
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
Message-ID: <20190408151617.GDEuwQ03Z4AhGN93TlReZT8abHrZdbE9YuBhJyn5HSQ@z>

This patch introduces a poll callback for event channel fd-s and uses
this to invoke the channel callback function.

To properly support polling, it is necessary for the event channel callback
function to return a boolean saying whether it has done any useful work or
not. Thus xen_block_dataplane_event() is modified to directly invoke
xen_block_handle_requests() and the latter only returns true if it actually
processes any requests. This also means that the call to qemu_bh_schedule()
is moved into xen_block_complete_aio(), which is more intuitive since the
only reason for doing a deferred poll of the shared ring should be because
there were previously insufficient resources to fully complete a previous
poll.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-block.c | 17 +++++++++--------
 hw/xen/xen-bus.c               | 11 +++++++++--
 include/hw/xen/xen-bus.h       |  2 +-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 1046f965c4..908bd27bbd 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -317,7 +317,9 @@ static void xen_block_complete_aio(void *opaque, int ret)
     }
     xen_block_release_request(request);
 
-    qemu_bh_schedule(dataplane->bh);
+    if (dataplane->more_work) {
+        qemu_bh_schedule(dataplane->bh);
+    }
 
 done:
     aio_context_release(dataplane->ctx);
@@ -514,12 +516,13 @@ static int xen_block_get_request(XenBlockDataPlane *dataplane,
  */
 #define IO_PLUG_THRESHOLD 1
 
-static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
+static bool xen_block_handle_requests(XenBlockDataPlane *dataplane)
 {
     RING_IDX rc, rp;
     XenBlockRequest *request;
     int inflight_atstart = dataplane->requests_inflight;
     int batched = 0;
+    bool done_something = false;
 
     dataplane->more_work = 0;
 
@@ -551,6 +554,7 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
         }
         xen_block_get_request(dataplane, request, rc);
         dataplane->rings.common.req_cons = ++rc;
+        done_something = true;
 
         /* parse them */
         if (xen_block_parse_request(request) != 0) {
@@ -602,10 +606,7 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
         blk_io_unplug(dataplane->blk);
     }
 
-    if (dataplane->more_work &&
-        dataplane->requests_inflight < dataplane->max_requests) {
-        qemu_bh_schedule(dataplane->bh);
-    }
+    return done_something;
 }
 
 static void xen_block_dataplane_bh(void *opaque)
@@ -617,11 +618,11 @@ static void xen_block_dataplane_bh(void *opaque)
     aio_context_release(dataplane->ctx);
 }
 
-static void xen_block_dataplane_event(void *opaque)
+static bool xen_block_dataplane_event(void *opaque)
 {
     XenBlockDataPlane *dataplane = opaque;
 
-    qemu_bh_schedule(dataplane->bh);
+    return xen_block_handle_requests(dataplane);
 }
 
 XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 4f634d1291..c90fc62a8d 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -931,13 +931,20 @@ struct XenEventChannel {
     void *opaque;
 };
 
+static bool xen_device_poll(void *opaque)
+{
+    XenEventChannel *channel = opaque;
+
+    return channel->handler(channel->opaque);
+}
+
 static void xen_device_event(void *opaque)
 {
     XenEventChannel *channel = opaque;
     unsigned long port = xenevtchn_pending(channel->xeh);
 
     if (port == channel->local_port) {
-        channel->handler(channel->opaque);
+        xen_device_poll(channel);
 
         xenevtchn_unmask(channel->xeh, port);
     }
@@ -972,7 +979,7 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
 
     channel->ctx = ctx;
     aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), false,
-                       xen_device_event, NULL, NULL, channel);
+                       xen_device_event, NULL, xen_device_poll, channel);
 
     QLIST_INSERT_HEAD(&xendev->event_channels, channel, list);
 
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 8183b98c7d..1c2d9dfdb8 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -119,7 +119,7 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
                                 XenDeviceGrantCopySegment segs[],
                                 unsigned int nr_segs, Error **errp);
 
-typedef void (*XenEventHandler)(void *opaque);
+typedef bool (*XenEventHandler)(void *opaque);
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
                                                AioContext *ctx,
-- 
2.20.1.2.gb21ebb6


