Received: from eggs.gnu.org ([2001:4830:134:3::10]:51702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUvA-0001h2-80
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUv7-00087b-5t
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:16 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:59698)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUv6-00087C-UD
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:13 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 21 Dec 2016 01:38:04 +0100
Message-Id: <20161221003806.22412-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20161221003806.22412-1-samuel.thibault@ens-lyon.org>
References: <20161221003806.22412-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH 1/3] console: add API to get underlying gui
 window ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

This adds two console functions, qemu_console_set_window_id and
qemu_graphic_console_get_window_id, to let graphical backend record the
window id in the QemuConsole structure, and let the baum driver read it.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
Difference from v4: select console with a QemuConsole* parameter instead
of an integer index.
---
 include/ui/console.h |  4 ++++
 ui/console.c         | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index e2589e2134..ee8c407cac 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -394,6 +394,10 @@ uint32_t qemu_console_get_head(QemuConsole *con);
 QemuUIInfo *qemu_console_get_ui_info(QemuConsole *con);
 int qemu_console_get_width(QemuConsole *con, int fallback);
 int qemu_console_get_height(QemuConsole *con, int fallback);
+/* Return the low-level window id for the console */
+int qemu_console_get_window_id(QemuConsole *con);
+/* Set the low-level window id for the console */
+void qemu_console_set_window_id(QemuConsole *con, int window_id);
 
 void console_select(unsigned int index);
 void qemu_console_resize(QemuConsole *con, int width, int height);
diff --git a/ui/console.c b/ui/console.c
index ed888e55ea..b9575f2ee5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -124,6 +124,7 @@ struct QemuConsole {
     int dcls;
     DisplayChangeListener *gl;
     bool gl_block;
+    int window_id;
 
     /* Graphic console state.  */
     Object *device;
@@ -273,6 +274,16 @@ void graphic_hw_gl_block(QemuConsole *con, bool block)
     }
 }
 
+int qemu_console_get_window_id(QemuConsole *con)
+{
+    return con->window_id;
+}
+
+void qemu_console_set_window_id(QemuConsole *con, int window_id)
+{
+    con->window_id = window_id;
+}
+
 void graphic_hw_invalidate(QemuConsole *con)
 {
     if (!con) {
-- 
2.11.0
