Received: from eggs.gnu.org ([209.51.188.92]:44908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz57-0005ii-HC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz56-0007cl-87
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz56-0007cU-2o
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:56 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:16 +0100
Message-Id: <1547460140-1473-22-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 21/25] linux-user: Fix compilation with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

Clang version 3.4.2 does not know the -Wpragmas option yet and bails
out with an error when we try to disable it in linux-user/qemu.h.
Fortunately, clang has a __has_warning() macro which allows us to add
an explicit check for the option that we want to ignore. With that we
can check for the availability of "-Waddress-of-packed-member" properly
and do not need the "-Wpragmas" at all here.

Fixes: 850d5e330a9c68cc998cecc02caf8a3c8d1ee8a3
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/compiler.h | 4 ++++
 linux-user/qemu.h       | 6 +-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 261842b..28fa438 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -113,6 +113,10 @@
 #define GCC_FMT_ATTR(n, m)
 #endif
 
+#ifndef __has_warning
+#define __has_warning(x) 0 /* compatibility with non-clang compilers */
+#endif
+
 #ifndef __has_feature
 #define __has_feature(x) 0 /* compatibility with non-clang compilers */
 #endif
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 069df8f..ef400cb 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -474,17 +474,13 @@ static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
  *   functions than host-endian unaligned load/store plus tswapN.
  * - The pragmas are necessary only to silence a clang false-positive
  *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
- * - We have to disable -Wpragmas warnings to avoid a complaint about
- *   an unknown warning type from older compilers that don't know about
- *   -Waddress-of-packed-member.
  * - gcc has bugs in its _Pragma() support in some versions, eg
  *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
  *   include the warning-suppression pragmas for clang
  */
-#ifdef __clang__
+#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
 #define PRAGMA_DISABLE_PACKED_WARNING                                   \
     _Pragma("GCC diagnostic push");                                     \
-    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
     _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
 
 #define PRAGMA_REENABLE_PACKED_WARNING          \
-- 
1.8.3.1
