Received: from eggs.gnu.org ([2001:4830:134:3::10]:54384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1crQ9F-0003Yx-AG
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1crQ9C-00059p-Fn
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1crQ9C-00059Z-2r
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:24:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29AD764A61
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 14:24:58 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 24 Mar 2017 15:24:49 +0100
Message-Id: <1490365490-4854-2-git-send-email-lprosek@redhat.com>
In-Reply-To: <1490365490-4854-1-git-send-email-lprosek@redhat.com>
References: <1490365490-4854-1-git-send-email-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] virtio-input: free event queue when
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
Cc: kraxel@redhat.com

VirtIOInput.queue was never freed. This commit adds an explicit
g_free to virtio_input_finalize and switches the allocation
function from realloc to g_realloc in virtio_input_send.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
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
2.7.4
