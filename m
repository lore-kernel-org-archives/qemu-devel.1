Received: from eggs.gnu.org ([2001:4830:134:3::10]:52450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdN-0001ln-44
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001uG-OZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001tC-HF
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:29 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  4 Jan 2017 12:21:23 +0100
Message-Id: <1483528883-1753-12-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
References: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] curses: Fix compiler warnings (Mingw-w64
 redefinition of macro KEY_EVENT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Stefan Weil <sw@weilnetz.de>

For builds with Mingw-w64 as it is included in Cygwin, there are two
header files which define KEY_EVENT with different values.

This results in lots of compiler warnings like this one:

  CC      vl.o
In file included from /qemu/include/ui/console.h:340:0,
                 from /qemu/vl.c:76:
/usr/i686-w64-mingw32/sys-root/mingw/include/curses.h:1522:0: warning: "KEY_EVENT" redefined
 #define KEY_EVENT 0633  /* We were interrupted by an event */

In file included from /usr/share/mingw-w64/include/windows.h:74:0,
                 from /usr/share/mingw-w64/include/winsock2.h:23,
                 from /qemu/include/sysemu/os-win32.h:29,
                 from /qemu/include/qemu/osdep.h:100,
                 from /qemu/vl.c:24:
/usr/share/mingw-w64/include/wincon.h:101:0: note: this is the location of the previous definition
 #define KEY_EVENT 0x1

QEMU only uses the KEY_EVENT macro from wincon.h.
Therefore we can undefine the macro coming from curses.h.

The explicit include statement for curses.h in ui/curses.c is not needed
and was removed.

Those two modifications fix the redefinition warnings.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20161119185318.10564-1-sw@weilnetz.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 3 +++
 ui/curses.c          | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 753ae93..7fb351f 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -334,7 +334,10 @@ static inline pixman_format_code_t surface_format(DisplaySurface *s)
 }
 
 #ifdef CONFIG_CURSES
+/* KEY_EVENT is defined in wincon.h and in curses.h. Avoid redefinition. */
+#undef KEY_EVENT
 #include <curses.h>
+#undef KEY_EVENT
 typedef chtype console_ch_t;
 extern chtype vga_to_curses[];
 #else
diff --git a/ui/curses.c b/ui/curses.c
index 2e132a7..03cefdf 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include <curses.h>
 
 #ifndef _WIN32
 #include <sys/ioctl.h>
-- 
1.8.3.1
