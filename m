Received: from eggs.gnu.org ([2001:4830:134:3::10]:52176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MX-0000mB-Cz
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MW-0000D1-AT
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MU-000088-Br
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:46 -0500
Received: by mail-wr1-x431.google.com with SMTP id x10so18066587wrs.8
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:41 +0100
Message-Id: <1544628195-37728-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/54] build-sys: build with Vista API by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Both qemu & qga build with Vista API by default already, by defining
_WIN32_WINNT 0x0600. Set it globally in osdep.h instead.

This replaces WINVER by _WIN32_WINNT in osdep.h. WINVER doesn't seem
to be really useful these days.
(see also https://blogs.msdn.microsoft.com/oldnewthing/20070411-00/?p=27283)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181122110039.15972-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h     | 4 ++--
 qga/commands-win32.c     | 6 +-----
 util/qemu-thread-win32.c | 4 ----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 7b6e5db..80df725 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -76,8 +76,8 @@ extern int daemon(int, int);
 
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
index 62e1b51..f03b9c1 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -10,12 +10,8 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
index 4a363ca..572f885 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -11,10 +11,6 @@
  *
  */
 
-#ifndef _WIN32_WINNT
-#define _WIN32_WINNT 0x0600
-#endif
-
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
-- 
1.8.3.1
