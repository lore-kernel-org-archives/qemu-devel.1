Received: from eggs.gnu.org ([2001:4830:134:3::10]:35362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cRqRj-0008UK-JP
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cRqRf-0002vh-Fq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:14:23 -0500
Received: from 206-15-90-246.static.twtelecom.net ([206.15.90.246]:46032
	helo=felipe-franciosi.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cRqRf-0002vU-8B
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:14:19 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 12 Jan 2017 17:14:07 -0800
Message-Id: <1484270047-24579-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH] libvhost-user: Start VQs on SET_VRING_CALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Felipe Franciosi <felipe@nutanix.com>

Currently, VQs are started as soon as a SET_VRING_KICK is received. That
is too early in the VQ setup process, as the backend might not yet have
a callfd to notify in case it received a kick and fully processed the
request/command. This patch only starts a VQ when a SET_VRING_CALL is
received.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index af4faad..a46ef90 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -607,19 +607,6 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
         DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
     }
 
-    dev->vq[index].started = true;
-    if (dev->iface->queue_set_started) {
-        dev->iface->queue_set_started(dev, index, true);
-    }
-
-    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
-        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
-                       vu_kick_cb, (void *)(long)index);
-
-        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
-               dev->vq[index].kick_fd, index);
-    }
-
     return false;
 }
 
@@ -661,6 +648,19 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
 
+    dev->vq[index].started = true;
+    if (dev->iface->queue_set_started) {
+        dev->iface->queue_set_started(dev, index, true);
+    }
+
+    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
+        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
+                       vu_kick_cb, (void *)(long)index);
+
+        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
+               dev->vq[index].kick_fd, index);
+    }
+
     return false;
 }
 
-- 
1.9.4
