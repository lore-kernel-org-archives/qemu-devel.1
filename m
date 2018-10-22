Received: from eggs.gnu.org ([2001:4830:134:3::10]:34051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEekl-0006ef-KE
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEekg-0006KN-Mj
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:16:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEekg-0006IH-8s
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:16:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id w186-v6so55215wmf.0
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 11:16:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 22 Oct 2018 19:16:23 +0100
Message-Id: <20181022181623.8810-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH, build fix] osdep: Work around MinGW assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

In several places we use assert(FEATURE), and assume that if FEATURE
is disabled, all following code is removed as unreachable.  Which allows
us to compile-out functions that are only present with FEATURE, and
have a link-time failure if the functions remain used.

MinGW does not mark its internal function _assert() as noreturn, so the
compiler cannot see when code is unreachable, which leads to link errors
for this host that are not present elsewhere.

The current build-time failure concerns 62823083b8a2, but I remember
having seen this same error before.  Fix it once and for all for MinGW.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4f8559e550..0c1e335a43 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -122,6 +122,18 @@ extern int daemon(int, int);
 #include "glib-compat.h"
 #include "qemu/typedefs.h"
 
+/*
+ * For mingw, as of v6.0.0, the function implementing the assert macro is
+ * not marked a noreturn, so the compiler cannot delete code following an
+ * assert(false) as unused.  We rely on this within the code base to delete
+ * code that is unreachable when features are disabled.
+ * All supported versions of Glib's g_assert() satisfy this requirement.
+ */
+#ifdef __MINGW32__
+#undef assert
+#define assert(x)  g_assert(x)
+#endif
+
 /*
  * According to waitpid man page:
  * WCOREDUMP
-- 
2.17.2
