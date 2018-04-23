Received: from eggs.gnu.org ([2001:4830:134:3::10]:49053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fAWhm-0006xR-Rp
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fAWhj-0001On-N6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:41385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1fAWhj-0001Ng-9J
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:07 -0400
From: Tina Zhang <tina.zhang@intel.com>
Date: Mon, 23 Apr 2018 16:14:37 +0800
Message-Id: <1524471278-22546-2-git-send-email-tina.zhang@intel.com>
In-Reply-To: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
References: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 1/2] console: introduce dpy_gfx_switch_surface
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

dpy_gfx_switch_surface is used to ask each valid DisplayChangeListener
of a QemuConsole to switch to another DisplaySurface.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/ui/console.h |  2 ++
 ui/console.c         | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 37a8d68..434033d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -293,6 +293,8 @@ int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info);
 void dpy_gfx_update(QemuConsole *con, int x, int y, int w, int h);
 void dpy_gfx_replace_surface(QemuConsole *con,
                              DisplaySurface *surface);
+void dpy_gfx_switch_surface(QemuConsole *con,
+                             DisplaySurface *surface);
 void dpy_text_cursor(QemuConsole *con, int x, int y);
 void dpy_text_update(QemuConsole *con, int x, int y, int w, int h);
 void dpy_text_resize(QemuConsole *con, int w, int h);
diff --git a/ui/console.c b/ui/console.c
index 3fb2f4e..2deb38b 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1595,6 +1595,22 @@ void dpy_gfx_replace_surface(QemuConsole *con,
     qemu_free_displaysurface(old_surface);
 }
 
+void dpy_gfx_switch_surface(QemuConsole *con,
+                             DisplaySurface *surface)
+{
+    DisplayState *s = con->ds;
+    DisplayChangeListener *dcl;
+
+    QLIST_FOREACH(dcl, &s->listeners, next) {
+        if (con != (dcl->con ? dcl->con : active_console)) {
+            continue;
+        }
+        if (dcl->ops->dpy_gfx_switch) {
+            dcl->ops->dpy_gfx_switch(dcl, surface);
+        }
+    }
+}
+
 bool dpy_gfx_check_format(QemuConsole *con,
                           pixman_format_code_t format)
 {
-- 
2.7.4
