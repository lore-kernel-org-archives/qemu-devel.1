Received: from eggs.gnu.org ([2001:4830:134:3::10]:55384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEd8Q-0003XW-OL
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEd8P-00021n-Bc
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEd8P-00021E-5H
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:37 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  4 May 2018 17:00:26 +0100
Message-Id: <20180504160026.14017-4-berrange@redhat.com>
In-Reply-To: <20180504160026.14017-1-berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] glib: enforce the minimum required version
 and warn about old APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

There are two useful macros that can be defined before including
glib.h that are related to the min required glib version

 - GLIB_VERSION_MIN_REQUIRED

   When this is defined, if code uses an API that was deprecated
   in this version, or older, a compiler warning will be emitted.
   This alerts maintainers to update their code to whatever new
   replacement API is now recommended best practice.

 - GLIB_VERSION_MAX_ALLOWED

   When this is defined, if code uses an API that was introduced
   in a version that is newer than the declared version, a compiler
   warning will be emitted. This alerts maintainers if new code
   accidentally uses functionality that won't be available on some
   supported platforms.

The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
in to using specific new APIs with a GLIB_CHECK_VERSION conditional.
To workaround this Pragmas can be used to temporarily turn off the
-Wdeprecated-declarations compiler warning, while a static inline
compat function is implemented. Nothing needs that at this time,
so just illustrate it in a comment for benefit of future changes.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/glib-compat.h | 49 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 49 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 3b340ab33c..d066f6d257 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -16,8 +16,57 @@
 #ifndef QEMU_GLIB_COMPAT_H
 #define QEMU_GLIB_COMPAT_H
=20
+/* Ask for warnings for anything that was marked deprecated in
+ * the defined version, or before. It is a candidate for rewrite.
+ */
+#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_42
+
+/* Ask for warnings if code tries to use function that did not
+ * exist in the defined version. These risk breaking builds
+ */
+#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_42
+
 #include <glib.h>
=20
+/*
+ * Note that because of the GLIB_VERSION_MAX_ALLOWED constant
+ * above, allowing use of functions from newer GLib via this
+ * compat header needs a little trickery to prevent warnings
+ * being emitted.
+ *
+ * Consider a function from newer glib-X.Y that we want to use
+ *
+ *    int g_foo(const char *wibble)
+ *
+ * We must define a static inline function with the same
+ * signature that does what we need, but with a "_qemu"
+ * suffix eg
+ *
+ * _Pragma("GCC diagnostic push")
+ * _Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
+ * static inline void g_foo_qemu(const char *wibble)
+ * {
+ *     #if GLIB_CHECK_VERSION(X, Y, 0)
+ *        g_foo(wibble)
+ *     #else
+ *        g_something_equivalent_in_older_glib(wibble);
+ *     #endif
+ * }
+ * _Pragma("GCC diagnostic pop")
+ *
+ * The Pragma calls turn off -Wdeprecated-declarations,
+ * ensuring this wrapper function impl doesn't trigger the
+ * compiler warning about using too new glib APIs. Finally
+ * we can do
+ *
+ *   #define g_foo(a) g_foo_qemu(a)
+ *
+ * So now the code elsewhere in QEMU, which *does* have the
+ * -Wdeprecated-declarations warning active, can call
+ * g_foo(...) as normal, without generating warnings.
+ */
+
+
 #if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
 /*
  * g_poll has a problem on Windows when using
--=20
2.14.3
