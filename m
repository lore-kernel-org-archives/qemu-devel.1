Received: from eggs.gnu.org ([2001:4830:134:3::10]:41122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05S-0007OP-AM
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05R-0001ey-JA
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC05R-0001ek-FP
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:41 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 11:54:33 +0200
Message-Id: <20180427095434.14013-6-kraxel@redhat.com>
In-Reply-To: <20180427095434.14013-1-kraxel@redhat.com>
References: <20180427095434.14013-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] console: introduce dpy_gfx_update_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Tina Zhang <tina.zhang@intel.com>

From: Tina Zhang <tina.zhang@intel.com>

dpy_gfx_update_full is used to do the whole display surface update.

This function is proposed by Gerd Hoffmann.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Message-id: 1524820266-27079-2-git-send-email-tina.zhang@intel.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  1 +
 ui/console.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 37a8d68d29..981b519dde 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -291,6 +291,7 @@ bool dpy_ui_info_supported(QemuConsole *con);
 int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info);
 
 void dpy_gfx_update(QemuConsole *con, int x, int y, int w, int h);
+void dpy_gfx_update_full(QemuConsole *con);
 void dpy_gfx_replace_surface(QemuConsole *con,
                              DisplaySurface *surface);
 void dpy_text_cursor(QemuConsole *con, int x, int y);
diff --git a/ui/console.c b/ui/console.c
index 3fb2f4e09f..b02510cdca 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1574,6 +1574,16 @@ void dpy_gfx_update(QemuConsole *con, int x, int y, int w, int h)
     }
 }
 
+void dpy_gfx_update_full(QemuConsole *con)
+{
+    if (!con->surface) {
+        return;
+    }
+    dpy_gfx_update(con, 0, 0,
+                   surface_width(con->surface),
+                   surface_height(con->surface));
+}
+
 void dpy_gfx_replace_surface(QemuConsole *con,
                              DisplaySurface *surface)
 {
-- 
2.9.3
