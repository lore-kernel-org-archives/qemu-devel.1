Received: from eggs.gnu.org ([2001:4830:134:3::10]:58465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evhOD-0000N4-6K
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evhOA-0003iG-1C
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:42:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evhO9-0003hh-TF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:42:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCAD78151D47
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 10:42:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 13 Mar 2018 10:42:35 +0000
Message-Id: <20180313104235.20725-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ui: fix keymap detection under Xwayland
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The X11 code currently detects the keymap by looking for the keycode
name property. Unfortunately due to the way Xwayland handles keyboards,
this property gets unset almost immediately after the first application
starts using Xwayland resulting in

  ** (qemu-system-x86_64:19644): WARNING **: Unknown X11 keycode mapping =
'(unnamed)'.
  Please report to qemu-devel@nongnu.org
  including the following information:

    - Operating system
    - X11 Server
    - xprop -root
    - xdpyinfo

Fortunately people will only see this problem if they built QEMU with
GTK2, or have told GTK3 to prefer X11 by setting the GDK_BACKEND=3Dx11
env variable.

To workaround the problem, we add a heuristic that looks at what
scancode the XK_Page_Up keysymbol maps to, to determine if we've
likely got the X11 kbd or evdev driver.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/x_keymap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ui/x_keymap.c b/ui/x_keymap.c
index 22e0e77c4d..2bc01432e5 100644
--- a/ui/x_keymap.c
+++ b/ui/x_keymap.c
@@ -17,6 +17,7 @@
 #include "ui/input.h"
=20
 #include <X11/XKBlib.h>
+#include <X11/Xutil.h>
=20
 static gboolean check_for_xwin(Display *dpy)
 {
@@ -87,11 +88,13 @@ const guint16 *qemu_xkeymap_mapping_table(Display *dp=
y, size_t *maplen)
         trace_xkeymap_keymap("xquartz");
         *maplen =3D qemu_input_map_xorgxquartz_to_qcode_len;
         return qemu_input_map_xorgxquartz_to_qcode;
-    } else if (keycodes && g_str_has_prefix(keycodes, "evdev")) {
+    } else if ((keycodes && g_str_has_prefix(keycodes, "evdev")) ||
+               (XKeysymToKeycode(dpy, XK_Page_Up) =3D=3D 0x70)) {
         trace_xkeymap_keymap("evdev");
         *maplen =3D qemu_input_map_xorgevdev_to_qcode_len;
         return qemu_input_map_xorgevdev_to_qcode;
-    } else if (keycodes && g_str_has_prefix(keycodes, "xfree86")) {
+    } else if ((keycodes && g_str_has_prefix(keycodes, "xfree86")) ||
+               (XKeysymToKeycode(dpy, XK_Page_Up) =3D=3D 0x63)) {
         trace_xkeymap_keymap("kbd");
         *maplen =3D qemu_input_map_xorgkbd_to_qcode_len;
         return qemu_input_map_xorgkbd_to_qcode;
--=20
2.14.3
