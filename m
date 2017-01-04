Received: from eggs.gnu.org ([2001:4830:134:3::10]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001hp-GD
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdI-0001sd-Ht
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOjdI-0001sL-CC
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  4 Jan 2017 12:21:16 +0100
Message-Id: <1483528883-1753-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
References: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 04/11] console: add API to get underlying gui
 window ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

This adds two console functions, qemu_console_set_window_id and
qemu_graphic_console_get_window_id, to let graphical backend record the
window id in the QemuConsole structure, and let the baum driver read it.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20161221003806.22412-2-samuel.thibault@ens-lyon.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  4 ++++
 ui/console.c         | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index e2589e2..ee8c407 100644
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
index ed888e5..b9575f2 100644
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
1.8.3.1
