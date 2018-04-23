Received: from eggs.gnu.org ([2001:4830:134:3::10]:53957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fAbGS-000246-Qa
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fAbGN-0001aX-Rb
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fAbGN-0001ZW-Kr
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:11 -0400
Date: Mon, 23 Apr 2018 15:12:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180423131202.zcyam25lkh7khbil@sirius.home.kraxel.org>
References: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
	<1524471278-22546-3-git-send-email-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524471278-22546-3-git-send-email-tina.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ui: introduce vfio_display_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tina Zhang <tina.zhang@intel.com>
Cc: alex.williamson@redhat.com, zhenyuw@linux.intel.com, hang.yuan@intel.com, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org

> +    surface = qemu_console_surface(vdev->dpy->con);

> +    dpy_gl_scanout_disable(vdev->dpy->con);
> +    dpy_gfx_switch_surface(vdev->dpy->con, surface);

Hmm, so you ask which surface is active, then switch to it.
Why?

Maybe you just need a full display update after disabling the gl
scanout?

cheers,
  Gerd

PS: maybe adding a dpy_gfx_update_full() helper is useful:

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
