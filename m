Received: from eggs.gnu.org ([2001:4830:134:3::10]:46744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99UW-0004hZ-S6
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99UQ-0006LR-Uo
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:20:48 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Apr 2018 15:20:25 +0200
Message-Id: <20180419132026.5494-4-kraxel@redhat.com>
In-Reply-To: <20180419132026.5494-1-kraxel@redhat.com>
References: <20180419132026.5494-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] ui: switch gtk display to qapi parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Drop the gtk option parser from parse_display(), so parse_display_qapi()
will handle it instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/vl.c b/vl.c
index 39303d6b55..1123cd792e 100644
--- a/vl.c
+++ b/vl.c
@@ -2188,38 +2188,6 @@ static void parse_display(const char *p)
             error_report("VNC requires a display argument vnc=<display>");
             exit(1);
         }
-    } else if (strstart(p, "gtk", &opts)) {
-        dpy.type = DISPLAY_TYPE_GTK;
-        while (*opts) {
-            const char *nextopt;
-
-            if (strstart(opts, ",grab_on_hover=", &nextopt)) {
-                opts = nextopt;
-                dpy.u.gtk.has_grab_on_hover = true;
-                if (strstart(opts, "on", &nextopt)) {
-                    dpy.u.gtk.grab_on_hover = true;
-                } else if (strstart(opts, "off", &nextopt)) {
-                    dpy.u.gtk.grab_on_hover = false;
-                } else {
-                    goto invalid_gtk_args;
-                }
-            } else if (strstart(opts, ",gl=", &nextopt)) {
-                opts = nextopt;
-                dpy.has_gl = true;
-                if (strstart(opts, "on", &nextopt)) {
-                    dpy.gl = true;
-                } else if (strstart(opts, "off", &nextopt)) {
-                    dpy.gl = false;
-                } else {
-                    goto invalid_gtk_args;
-                }
-            } else {
-            invalid_gtk_args:
-                error_report("invalid GTK option string");
-                exit(1);
-            }
-            opts = nextopt;
-        }
     } else {
         parse_display_qapi(p);
     }
-- 
2.9.3
