Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e45GH-0006Ah-IC
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e45GG-0004v0-Af
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:16:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e45GG-0004ub-4L
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:16:52 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 16 Oct 2017 15:16:43 +0200
Message-Id: <20171016131644.9565-11-kraxel@redhat.com>
In-Reply-To: <20171016131644.9565-1-kraxel@redhat.com>
References: <20171016131644.9565-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 10/11] ui/gtk: Fix deprecation of
 vte_terminal_copy_clipboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Anthony PERARD <anthony.perard@citrix.com>

vte_terminal_copy_clipboard() is deprecated in VTE 0.50.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 5bd87c265a..342e96fbe9 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1702,7 +1702,12 @@ static void gd_menu_copy(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+#if VTE_CHECK_VERSION(0, 50, 0)
+    vte_terminal_copy_clipboard_format(VTE_TERMINAL(vc->vte.terminal),
+                                       VTE_FORMAT_TEXT);
+#else
     vte_terminal_copy_clipboard(VTE_TERMINAL(vc->vte.terminal));
+#endif
 }
 
 static void gd_vc_adjustment_changed(GtkAdjustment *adjustment, void *opaque)
-- 
2.9.3
