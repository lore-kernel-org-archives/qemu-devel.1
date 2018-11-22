Received: from eggs.gnu.org ([2001:4830:134:3::10]:50820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPmjS-0005j9-TS
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPmjR-0004w3-Pm
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:01:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPmjR-0004tj-Kc
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:01:13 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 15:00:38 +0400
Message-Id: <20181122110039.15972-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181122110039.15972-1-marcandre.lureau@redhat.com>
References: <20181122110039.15972-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 3/4] build-sys: build with Vista API by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, samuel.thibault@ens-lyon.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Both qemu & qga build with Vista API by default already, by defining
_WIN32_WINNT 0x0600. Set it globally in osdep.h instead.

This replaces WINVER by _WIN32_WINNT in osdep.h. WINVER doesn't seem
to be really useful these days.
(see also https://blogs.msdn.microsoft.com/oldnewthing/20070411-00/?p=3D2=
7283)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/osdep.h     | 4 ++--
 qga/commands-win32.c     | 6 +-----
 util/qemu-thread-win32.c | 4 ----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 7b6e5db9d0..80df7253db 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -76,8 +76,8 @@ extern int daemon(int, int);
=20
 #ifdef _WIN32
 /* as defined in sdkddkver.h */
-#ifndef WINVER
-#define WINVER 0x0501 /* XP */
+#ifndef _WIN32_WINNT
+#define _WIN32_WINNT 0x0600 /* Vista */
 #endif
 /* reduces the number of implicitly included headers */
 #ifndef WIN32_LEAN_AND_MEAN
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 62e1b51dfe..f03b9c1d89 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -10,12 +10,8 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
-
-#ifndef _WIN32_WINNT
-#   define _WIN32_WINNT 0x0600
-#endif
-
 #include "qemu/osdep.h"
+
 #include <wtypes.h>
 #include <powrprof.h>
 #include <winsock2.h>
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 4a363ca675..572f88535d 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -11,10 +11,6 @@
  *
  */
=20
-#ifndef _WIN32_WINNT
-#define _WIN32_WINNT 0x0600
-#endif
-
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
--=20
2.20.0.rc1
