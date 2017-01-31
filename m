Received: from eggs.gnu.org ([2001:4830:134:3::10]:50304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYZf6-00081I-S0
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYZf2-0008Ol-UZ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:44:00 -0500
Received: from mail.kernel.org ([198.145.29.136]:55598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYZf2-0008Of-OU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:43:56 -0500
Date: Tue, 31 Jan 2017 16:43:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485873796-15095-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

Some headers use QEMU_BUILD_BUG_ON. This causes a problem
if the C file including that header happens to have
QEMU_BUILD_BUG_ON at the same line number.

Fix using a widely available extension: __COUNTER__.
If unavailable, provide a stub.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/compiler.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index e0fb18b..bad25a9 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -89,8 +89,12 @@
     struct { \
         int:(x) ? -1 : 1; \
     }
+#ifdef __COUNTER__
 #define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
-    glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
+    glue(qemu_build_bug_on__, __COUNTER__) __attribute__((unused))
+#else
+#define QEMU_BUILD_BUG_ON(x)
+#endif
 
 #define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
                                    sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
-- 
MST
