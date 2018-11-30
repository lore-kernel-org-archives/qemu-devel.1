Received: from eggs.gnu.org ([2001:4830:134:3::10]:56875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSg75-0003Wf-Ea
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSg70-0007MR-Ta
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:33:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSg6z-0007Je-7s
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:33:29 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 30 Nov 2018 11:33:23 +0100
Message-Id: <1543574003-25845-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH maybe-for-3.1?] linux-user: Fix compilation
 with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, peter.maydell@linaro.org

Clang version 3.4.2 does not know the -Wpragmas option yet and bails
out with an error when we try to disable it in linux-user/qemu.h.
Fortunately, clang has a __has_warning() macro which allows us to add
an explicit check for this option to fix this issue.

Fixes: 850d5e330a9c68cc998cecc02caf8a3c8d1ee8a3
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Today, I noticed that building the linux-user targets is currently also
 not working with Clang 3.4 anymore ... so in case we will roll out 3.1-rc4,
 I think this patch should be considered, too. Otherwise, this certainly
 does not justify another rc, so it can also be added later via stable.

 include/qemu/compiler.h | 4 ++++
 linux-user/qemu.h       | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 6b92710..ca9bc85 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -119,6 +119,10 @@
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
index dd5771c..c7b3c37 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -481,7 +481,7 @@ static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
  *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
  *   include the warning-suppression pragmas for clang
  */
-#ifdef __clang__
+#if defined(__clang__) && __has_warning("-Wpragmas")
 #define PRAGMA_DISABLE_PACKED_WARNING                                   \
     _Pragma("GCC diagnostic push");                                     \
     _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
-- 
1.8.3.1
