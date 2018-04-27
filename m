Received: from eggs.gnu.org ([2001:4830:134:3::10]:57307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fBzUL-0005pp-BN
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fBzUK-0006rp-IP
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:31926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1fBzUK-0006nm-8t
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:20 -0400
From: Tina Zhang <tina.zhang@intel.com>
Date: Fri, 27 Apr 2018 17:11:05 +0800
Message-Id: <1524820266-27079-2-git-send-email-tina.zhang@intel.com>
In-Reply-To: <1524820266-27079-1-git-send-email-tina.zhang@intel.com>
References: <1524820266-27079-1-git-send-email-tina.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 1/2] console: introduce dpy_gfx_update_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, kraxel@redhat.com, zhenyuw@linux.intel.com, hang.yuan@intel.com
Cc: Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org

dpy_gfx_update_full is used to do the whole display surface update.

This function is proposed by Gerd Hoffmann.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/ui/console.h |  1 +
 ui/console.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 37a8d68..981b519 100644
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
index 3fb2f4e..b02510c 100644
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
2.7.4
