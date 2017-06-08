Received: from eggs.gnu.org ([2001:4830:134:3::10]:40587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJF-0004M6-4Y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002EK-V8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:09 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:14895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002D2-Pi
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:04 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Thu, 8 Jun 2017 13:15:33 +0000
Message-ID: <1496927734-29174-4-git-send-email-owen.smith@citrix.com>
In-Reply-To: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
References: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/4] ui/input: Add activate/remove for keyboard
 handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com, xen-devel@lists.xenproject.org, Owen Smith <owen.smith@citrix.com>

Adds missing functions to activate and remove keyboard handlers
* qemu_activate_kbd_event_handler
* qemu_remove_kbd_event_handler

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 include/ui/console.h |  2 ++
 ui/input-legacy.c    | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 7262bef..f5045e1 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -55,6 +55,8 @@ typedef struct QEMUPutLEDEntry QEMUPutLEDEntry;
 
 QEMUPutKbdEntry *qemu_add_kbd_event_handler(QEMUPutKBDEvent *func,
                                             void *opaque);
+void qemu_remove_kbd_event_handler(QEMUPutKbdEntry *entry);
+void qemu_activate_kbd_event_handler(QEMUPutKbdEntry *entry);
 QEMUPutMouseEntry *qemu_add_mouse_event_handler(QEMUPutMouseEvent *func,
                                                 void *opaque, int absolute,
                                                 const char *name);
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 7159747..fbe1ce7 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -142,6 +142,18 @@ QEMUPutKbdEntry *qemu_add_kbd_event_handler(QEMUPutKBDEvent *func, void *opaque)
     return entry;
 }
 
+void qemu_activate_kbd_event_handler(QEMUPutKbdEntry *entry)
+{
+    qemu_input_handler_activate(entry->s);
+}
+
+void qemu_remove_kbd_event_handler(QEMUPutKbdEntry *entry)
+{
+    qemu_input_handler_unregister(entry->s);
+
+    g_free(entry);
+}
+
 static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
                                InputEvent *evt)
 {
-- 
2.1.4
