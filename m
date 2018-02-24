Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epbwS-0000dH-K0
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epbwR-00053k-NQ
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:40:52 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 24 Feb 2018 16:40:27 +0100
Message-Id: <20180224154033.29559-2-mreitz@redhat.com>
In-Reply-To: <20180224154033.29559-1-mreitz@redhat.com>
References: <20180224154033.29559-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/7] compiler: Add QEMU_BUILD_BUG_MSG() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

_Static_assert() allows us to specify messages, and that may come in
handy.  Even without _Static_assert(), encouraging developers to put a
helpful message next to the QEMU_BUILD_BUG_* may make debugging easier
whenever it breaks.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/compiler.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 2cbe6a4f16..9f762695d1 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -82,15 +82,21 @@
         int:(x) ? -1 : 1; \
     }
 
+/* QEMU_BUILD_BUG_MSG() emits the message given if _Static_assert is
+ * supported; otherwise, it will be omitted from the compiler error
+ * message (but as it remains present in the source code, it can still
+ * be useful when debugging). */
 #if defined(CONFIG_STATIC_ASSERT)
-#define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x)
+#define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
 #elif defined(__COUNTER__)
-#define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
+#define QEMU_BUILD_BUG_MSG(x, msg) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
     glue(qemu_build_bug_on__, __COUNTER__) __attribute__((unused))
 #else
-#define QEMU_BUILD_BUG_ON(x)
+#define QEMU_BUILD_BUG_MSG(x, msg)
 #endif
 
+#define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
+
 #define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
                                    sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
 
-- 
2.14.3
