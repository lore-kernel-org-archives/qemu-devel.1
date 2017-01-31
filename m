Received: from eggs.gnu.org ([2001:4830:134:3::10]:58216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYGb-0001Kt-04
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYGa-0000Ag-6h
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:14:37 -0500
Received: from mail.kernel.org ([198.145.29.136]:39188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYGa-0000AI-0K
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:14:36 -0500
Date: Tue, 31 Jan 2017 15:14:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485868446-10587-5-git-send-email-mst@redhat.com>
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485868446-10587-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 04/21] compiler: rework BUG_ON using a struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

There are theoretical concerns that some compilers might not trigger
build failures on attempts to define an array of size (x ? -1 : 1) where
x is a variable and make it a variable sized array instead. Let rewrite
using a struct with a negative bit field size instead as there are no
dynamic bit field sizes.  This is similar to what Linux does.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/compiler.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 7512082..1da500e 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -85,9 +85,12 @@
 #define typeof_field(type, field) typeof(((type *)0)->field)
 #define type_check(t1,t2) ((t1*)0 - (t2*)0)
 
-#define QEMU_BUILD_BUG_ON(x) \
-    typedef char glue(qemu_build_bug_on__, __LINE__)[(x) ? -1 : 1] \
-        __attribute__((unused))
+#define QEMU_BUILD_BUG_ON_STRUCT(x) \
+    struct { \
+        int:(x) ? -1 : 1; \
+    }
+#define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
+    glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
 
 #if defined __GNUC__
 # if !QEMU_GNUC_PREREQ(4, 4)
-- 
MST
