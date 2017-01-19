Received: from eggs.gnu.org ([2001:4830:134:3::10]:35752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvj-00074H-Ac
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvi-0004zf-Hl
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:35 -0500
Received: from mail.kernel.org ([198.145.29.136]:56210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvi-0004yf-Bf
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:34 -0500
Date: Thu, 19 Jan 2017 23:07:29 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484859998-25074-3-git-send-email-mst@redhat.com>
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484859998-25074-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] compiler: rework BUG_ON using a struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

There are theoretical concerns that some compilers might not trigger
build failures on attempts to define an array of size -1 and make it a
variable sized array instead. Let rewrite using a struct with a negative
bit field size instead as there are no dynamic bit field sizes.  This is
similar to what Linux does.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/compiler.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 7512082..c6f673e 100644
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
+        int qemu_build_bug_on : (x) ? -1 : 1; \
+    }
+#define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
+    glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
 
 #if defined __GNUC__
 # if !QEMU_GNUC_PREREQ(4, 4)
-- 
MST
