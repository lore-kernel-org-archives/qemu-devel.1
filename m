Received: from eggs.gnu.org ([2001:4830:134:3::10]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrWw-0007eU-Tc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrWv-0001CW-Nd
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrWv-0001Ah-IF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:33 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 29 Jun 2018 12:25:20 +0100
Message-Id: <20180629112520.31358-4-berrange@redhat.com>
In-Reply-To: <20180629112520.31358-1-berrange@redhat.com>
References: <20180629112520.31358-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] glib: enforce the minimum required version
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
Cc: Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

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
compat function is implemented. This workaround is illustrated with the
implementation of the g_strv_contains method to satisfy the test suite.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/glib-compat.h | 68 +++++++++++++++++++++++++++++++++++++++++++
 tests/test-qga.c      |  2 --
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 3b340ab33c..fdf95a255d 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -16,8 +16,74 @@
 #ifndef QEMU_GLIB_COMPAT_H
 #define QEMU_GLIB_COMPAT_H
=20
+/* Ask for warnings for anything that was marked deprecated in
+ * the defined version, or before. It is a candidate for rewrite.
+ */
+#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
+
+/* Ask for warnings if code tries to use function that did not
+ * exist in the defined version. These risk breaking builds
+ */
+#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
+
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 #include <glib.h>
=20
+/*
+ * Note that because of the GLIB_VERSION_MAX_ALLOWED constant above, all=
owing
+ * use of functions from newer GLib via this compat header needs a littl=
e
+ * trickery to prevent warnings being emitted.
+ *
+ * Consider a function from newer glib-X.Y that we want to use
+ *
+ *    int g_foo(const char *wibble)
+ *
+ * We must define a static inline function with the same signature that =
does
+ * what we need, but with a "_qemu" suffix e.g.
+ *
+ * static inline void g_foo_qemu(const char *wibble)
+ * {
+ *     #if GLIB_CHECK_VERSION(X, Y, 0)
+ *        g_foo(wibble)
+ *     #else
+ *        g_something_equivalent_in_older_glib(wibble);
+ *     #endif
+ * }
+ *
+ * The #pragma at the top of this file turns off -Wdeprecated-declaratio=
ns,
+ * ensuring this wrapper function impl doesn't trigger the compiler warn=
ing
+ * about using too new glib APIs. Finally we can do
+ *
+ *   #define g_foo(a) g_foo_qemu(a)
+ *
+ * So now the code elsewhere in QEMU, which *does* have the
+ * -Wdeprecated-declarations warning active, can call g_foo(...) as norm=
al,
+ * without generating warnings.
+ */
+
+static inline gboolean g_strv_contains_qemu(const gchar *const *strv,
+                                            const gchar *str)
+{
+#if GLIB_CHECK_VERSION(2, 44, 0)
+    return g_strv_contains(strv, str);
+#else
+    g_return_val_if_fail(strv !=3D NULL, FALSE);
+    g_return_val_if_fail(str !=3D NULL, FALSE);
+
+    for (; *strv !=3D NULL; strv++) {
+        if (g_str_equal(str, *strv)) {
+            return TRUE;
+        }
+    }
+
+    return FALSE;
+#endif
+}
+#define g_strv_contains(a, b) g_strv_contains_qemu(a, b)
+
+
 #if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
 /*
  * g_poll has a problem on Windows when using
@@ -45,4 +111,6 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeo=
ut);
     } while (0)
 #endif
=20
+#pragma GCC diagnostic pop
+
 #endif
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 18e63cb533..30c9643257 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -744,12 +744,10 @@ static void test_qga_config(gconstpointer data)
=20
     strv =3D g_key_file_get_string_list(kf, "general", "blacklist", &n, =
&error);
     g_assert_cmpint(n, =3D=3D, 2);
-#if GLIB_CHECK_VERSION(2, 44, 0)
     g_assert_true(g_strv_contains((const char * const *)strv,
                                   "guest-ping"));
     g_assert_true(g_strv_contains((const char * const *)strv,
                                   "guest-get-time"));
-#endif
     g_assert_no_error(error);
     g_strfreev(strv);
=20
--=20
2.17.1
