Received: from eggs.gnu.org ([2001:4830:134:3::10]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gL9E2-0007nA-LN
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gL9E1-000820-3x
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:01:38 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gL9E0-0007Fk-KM
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:01:36 -0500
Received: by mail-ot1-x341.google.com with SMTP id n46so2018525otb.9
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 08:00:42 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Fri,  9 Nov 2018 10:00:14 -0600
Message-Id: <20181109160014.28646-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] build: qga: add macro to force use of native
 mingw32 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

When building qemu-ga for w32 with VSS support, some parts of qemu-ga
are not linked against glib, specifically the C++ bits used to
create the VSS provider DLL. With 3ebee3b191e, we now define assert()
as g_assert() for all mingw32 builds via osdep.h, which results in the
following build breakage:

  x86_64-w64-mingw32-g++ -o qga/vss-win32/qga-vss.dll qga/vss-win32/requester.o qga/vss-win32/provider.o qga/vss-win32/install.o /home/mdroth/w/qemu4.git/qga/vss-win32/qga-vss.def  -shared -Wl,--add-stdcall-alias,--enable-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
  qga/vss-win32/requester.o: In function `requester_freeze':
  /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:284: undefined reference to `g_assertion_message_expr'
  qga/vss-win32/requester.o: In function `requester_thaw':
  /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:508: undefined reference to `g_assertion_message_expr'
  /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:509: undefined reference to `g_assertion_message_expr'
  collect2: error: ld returned 1 exit status
  make: *** [/home/mdroth/w/qemu4.git/qga/vss-win32/Makefile.objs:10: qga/vss-win32/qga-vss.dll] Error 1
  make: *** Waiting for unfinished jobs....

Fix this by introducing a USE_NATIVE_MINGW32_ASSERT macro that can
be defined prior to inclusion of osdep.h in individual C/C++ files
that don't link against glib.

Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/qemu/osdep.h        | 2 +-
 qga/vss-win32/install.cpp   | 2 +-
 qga/vss-win32/provider.cpp  | 2 +-
 qga/vss-win32/requester.cpp | 2 +-
 qga/vss-win32/vss-common.h  | 2 ++
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bcdec..59364bfeb0 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -129,7 +129,7 @@ extern int daemon(int, int);
  * code that is unreachable when features are disabled.
  * All supported versions of Glib's g_assert() satisfy this requirement.
  */
-#ifdef __MINGW32__
+#if defined(__MINGW32__) && !defined(USE_NATIVE_MINGW32_ASSERT)
 #undef assert
 #define assert(x)  g_assert(x)
 #endif
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 6713e58670..6ed2d5930c 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -10,9 +10,9 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "vss-common.h"
 #include "qemu/osdep.h"
 
-#include "vss-common.h"
 #include <inc/win2003/vscoordint.h>
 #include "install.h"
 #include <wbemidl.h>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 72d8b0e19d..d298af91b2 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -10,8 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "qemu/osdep.h"
 #include "vss-common.h"
+#include "qemu/osdep.h"
 #include <inc/win2003/vscoordint.h>
 #include <inc/win2003/vsprov.h>
 
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 5378c55d23..d239bd9598 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -10,8 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "qemu/osdep.h"
 #include "vss-common.h"
+#include "qemu/osdep.h"
 #include "requester.h"
 #include "install.h"
 #include <inc/win2003/vswriter.h>
diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
index 61c170b52e..275cbb59c5 100644
--- a/qga/vss-win32/vss-common.h
+++ b/qga/vss-win32/vss-common.h
@@ -13,6 +13,8 @@
 #ifndef VSS_COMMON_H
 #define VSS_COMMON_H
 
+#define USE_NATIVE_MINGW32_ASSERT
+
 #define __MIDL_user_allocate_free_DEFINED__
 #include <windows.h>
 #include <shlwapi.h>
-- 
2.17.1
