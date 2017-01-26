Received: from eggs.gnu.org ([2001:4830:134:3::10]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmhv-0001Jt-4y
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmhq-0003yc-I9
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:31 -0500
Received: from mail.kernel.org ([198.145.29.136]:38464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmhq-0003y4-Br
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:26 -0500
Date: Thu, 26 Jan 2017 18:15:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485447262-27014-6-git-send-email-mst@redhat.com>
References: <1485447262-27014-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485447262-27014-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 05/18] ARRAY_SIZE: check that argument is an
 array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Sergey Fedorov <serge.fdrv@gmail.com>

It's a familiar pattern: some code uses ARRAY_SIZE, then refactoring
changes the argument from an array to a pointer to a dynamically
allocated buffer.  Code keeps compiling but any ARRAY_SIZE calls now
return the size of the pointer divided by element size.

Let's add build time checks to ARRAY_SIZE before we allow more
of these in the code-base.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/osdep.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 689f253..56c9e22 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -198,8 +198,15 @@ extern int daemon(int, int);
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #endif
 
+/*
+ * &(x)[0] is always a pointer - if it's same type as x then the argument is a
+ * pointer, not an array.
+ */
+#define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), \
+                                                        typeof(&(x)[0])))
 #ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
+                       QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
 #endif
 
 int qemu_daemon(int nochdir, int noclose);
-- 
MST
