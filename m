Received: from eggs.gnu.org ([2001:4830:134:3::10]:41032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0he-0003lf-J0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hc-0005fi-Ho
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ea0hc-0005es-Bu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:04 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 15:52:50 +0100
Message-Id: <20180112145258.10578-2-kraxel@redhat.com>
In-Reply-To: <20180112145258.10578-1-kraxel@redhat.com>
References: <20180112145258.10578-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] input: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linzhecheng <linzhecheng@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>

From: linzhecheng <linzhecheng@huawei.com>

If kbd_queue is not empty and queue_count >= queue_limit,
we should free evt.

Change-Id: Ieeacf90d5e7e370a40452ec79031912d8b864d83
Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Message-id: 20171225023730.5512-1-linzhecheng@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/input.c b/ui/input.c
index 3e2d324278..e5b78aae9e 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -421,6 +421,8 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
     } else if (queue_count < queue_limit) {
         qemu_input_queue_event(&kbd_queue, src, evt);
         qemu_input_queue_sync(&kbd_queue);
+    } else {
+        qapi_free_InputEvent(evt);
     }
 }
 
-- 
2.9.3
