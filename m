Received: from eggs.gnu.org ([2001:4830:134:3::10]:54110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYetV-0003qp-9z
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYetR-0004H4-DM
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:19:13 -0500
Received: from mail.kernel.org ([198.145.29.136]:52408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYetR-0004Gx-7w
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:19:09 -0500
Date: Tue, 31 Jan 2017 22:19:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485893872-26524-5-git-send-email-mst@redhat.com>
References: <1485893872-26524-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485893872-26524-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v5 04/22] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Some headers use QEMU_BUILD_BUG_ON. This causes a problem
if the C file including that header happens to have
QEMU_BUILD_BUG_ON at the same line number.

Fix using a widely available extension: __COUNTER__.
If unavailable, provide a stub.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/compiler.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 7512082..77b9ce3 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -85,9 +85,13 @@
 #define typeof_field(type, field) typeof(((type *)0)->field)
 #define type_check(t1,t2) ((t1*)0 - (t2*)0)
 
+#ifdef __COUNTER__
 #define QEMU_BUILD_BUG_ON(x) \
-    typedef char glue(qemu_build_bug_on__, __LINE__)[(x) ? -1 : 1] \
+    typedef char glue(qemu_build_bug_on__, __COUNTER__)[(x) ? -1 : 1] \
         __attribute__((unused))
+#else
+#define QEMU_BUILD_BUG_ON(x)
+#endif
 
 #if defined __GNUC__
 # if !QEMU_GNUC_PREREQ(4, 4)
-- 
MST
