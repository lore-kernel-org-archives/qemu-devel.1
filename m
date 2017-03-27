Received: from eggs.gnu.org ([2001:4830:134:3::10]:35630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csWGN-0007uE-38
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csWGM-0000DJ-8o
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1csWGM-0000Ck-3g
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 203FFC04BD4E
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 15:08:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Mar 2017 15:28:33 +0200
Message-Id: <1490621317-25483-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
References: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/5] virtio-input: free event queue when
 finalizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

VirtIOInput.queue was never freed. This commit adds an explicit
g_free to virtio_input_finalize and switches the allocation
function from realloc to g_realloc in virtio_input_send.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-id: 1490365490-4854-2-git-send-email-lprosek@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/virtio-input.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index b678ee9..728832a 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -32,8 +32,8 @@ void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event)
     /* queue up events ... */
     if (vinput->qindex == vinput->qsize) {
         vinput->qsize++;
-        vinput->queue = realloc(vinput->queue, vinput->qsize *
-                                sizeof(virtio_input_event));
+        vinput->queue = g_realloc(vinput->queue, vinput->qsize *
+                                  sizeof(virtio_input_event));
     }
     vinput->queue[vinput->qindex++] = *event;
 
@@ -272,6 +272,8 @@ static void virtio_input_finalize(Object *obj)
         QTAILQ_REMOVE(&vinput->cfg_list, cfg, node);
         g_free(cfg);
     }
+
+    g_free(vinput->queue);
 }
 static void virtio_input_device_unrealize(DeviceState *dev, Error **errp)
 {
-- 
1.8.3.1
