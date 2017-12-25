Received: from eggs.gnu.org ([2001:4830:134:3::10]:53144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eTIen-0003n2-Ta
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eTIej-0005aV-9I
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:38:25 -0500
Received: from [45.249.212.35] (port=49358 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1eTIei-0005Yv-Te
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:38:21 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 25 Dec 2017 10:37:30 +0800
Message-ID: <20171225023730.5512-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] input: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, arei.gonglei@huawei.com, linzhecheng <linzhecheng@huawei.com>

If kbd_queue is not empty and queue_count >= queue_limit,
we should free evt.

Change-Id: Ieeacf90d5e7e370a40452ec79031912d8b864d83
Signed-off-by: linzhecheng <linzhecheng@huawei.com>

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
2.12.2.windows.2
