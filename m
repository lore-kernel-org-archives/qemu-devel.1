Received: from eggs.gnu.org ([209.51.188.92]:40638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW1L-0002wV-1P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW1J-00024M-Sm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:15 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 8 Apr 2019 16:16:16 +0100
Message-ID: <20190408151617.13025-3-paul.durrant@citrix.com>
In-Reply-To: <20190408151617.13025-1-paul.durrant@citrix.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] xen-bus: allow AioContext to be specified
 for each event channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

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
