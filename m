Received: from eggs.gnu.org ([2001:4830:134:3::10]:47548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGK6-00010H-8V
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGK4-0001ls-UR
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:06 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eNGK4-0001lk-NI
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:04 -0500
Received: by mail-wr0-x243.google.com with SMTP id a41so10423483wra.6
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 02:56:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  8 Dec 2017 11:55:49 +0100
Message-Id: <20171208105553.12249-2-pbonzini@redhat.com>
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
References: <20171208105553.12249-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] compiler: add a helper for C99 inline
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

C99 inline functions are useful whenever a function provide an
abstraction that is generally expected to be inlined away, but
yet a function pointer might be needed.  One such case is function
passed to GCC's cleanup attribute.

Unfortunately, C99 inline functions clash a bit with -Wredundant-decls.
Provide a helper macro to hide the ugliness.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/compiler.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 340e5fdc09..e02b73b9e2 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -94,6 +94,21 @@
 #define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
                                    sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
 
+/* Provide an extern declaration for a C99 inline function.  This can
+ * be simply placed in a C file but, unfortunately, this means the
+ * declaration comes after the inline definition, and GCC thus
+ * stubbornly raises a -Wredundant-decls warning.
+ *
+ * Putting the declaration before the header would be uglier (it couldn't
+ * just use typeof) and not always possible if the function requires types
+ * that are defined in the header.  Therefore, we just shut up the warning.
+ */
+#define QEMU_EXTERN_INLINE(func)                             \
+    _Pragma("GCC diagnostic push");                          \
+    _Pragma("GCC diagnostic ignored \"-Wredundant-decls\""); \
+    extern typeof(func) func;                                \
+    _Pragma("GCC diagnostic pop")                            \
+
 #if defined __GNUC__
 # if !QEMU_GNUC_PREREQ(4, 4)
    /* gcc versions before 4.4.x don't support gnu_printf, so use printf. */
-- 
2.14.3
