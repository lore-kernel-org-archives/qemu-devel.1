Received: from eggs.gnu.org ([2001:4830:134:3::10]:45107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJQ-0000ch-8O
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJN-0005rj-3Z
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJM-0005rJ-V8
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E2CC76FB9
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:35:56 -0500
Message-Id: <20180312183628.394722-6-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 05/36] compiler: Add QEMU_BUILD_BUG_MSG() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

_Static_assert() allows us to specify messages, and that may come in
handy.  Even without _Static_assert(), encouraging developers to put a
helpful message next to the QEMU_BUILD_BUG_* may make debugging easier
whenever it breaks.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20180224154033.29559-2-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/compiler.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 2cbe6a4f16e..9f762695d11 100644
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
