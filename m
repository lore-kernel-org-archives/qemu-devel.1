Received: from eggs.gnu.org ([2001:4830:134:3::10]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQcIf-00040R-IU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQcIe-0000mf-BS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQcIe-0000mN-7L
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:44 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  6 Jun 2018 18:32:32 +0100
Message-Id: <20180606173233.28080-3-berrange@redhat.com>
In-Reply-To: <20180606173233.28080-1-berrange@redhat.com>
References: <20180606173233.28080-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] glib: enforce the minimum required
 version and warn about old APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

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
 include/glib-compat.h                    | 67 ++++++++++++++++++++++++
 tests/docker/dockerfiles/centos6.docker  | 30 -----------
 tests/docker/dockerfiles/min-glib.docker |  8 ---
 tests/test-qga.c                         |  2 -
 4 files changed, 67 insertions(+), 40 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/centos6.docker
 delete mode 100644 tests/docker/dockerfiles/min-glib.docker

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 3b340ab33c..cfc3cba751 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -16,8 +16,73 @@
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
+_Pragma("GCC diagnostic push")
+_Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
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
+ * The _Pragma at the top of this file turns off -Wdeprecated-declaratio=
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
@@ -45,4 +110,6 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeo=
ut);
     } while (0)
 #endif
=20
+_Pragma("GCC diagnostic pop")
+
 #endif
diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/docke=
rfiles/centos6.docker
deleted file mode 100644
index ad24319582..0000000000
--- a/tests/docker/dockerfiles/centos6.docker
+++ /dev/null
@@ -1,30 +0,0 @@
-FROM centos:6
-RUN yum install -y epel-release centos-release-xen
-ENV PACKAGES \
-    bison \
-    bzip2-devel \
-    ccache \
-    csnappy-devel \
-    flex \
-    g++ \
-    gcc \
-    gettext \
-    git \
-    glib2-devel \
-    libepoxy-devel \
-    libfdt-devel \
-    librdmacm-devel \
-    lzo-devel \
-    make \
-    mesa-libEGL-devel \
-    mesa-libgbm-devel \
-    pixman-devel \
-    SDL-devel \
-    spice-glib-devel \
-    spice-server-devel \
-    tar \
-    vte-devel \
-    xen-devel \
-    zlib-devel
-RUN yum install -y $PACKAGES
-RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/min-glib.docker b/tests/docker/dock=
erfiles/min-glib.docker
deleted file mode 100644
index f2eed97d35..0000000000
--- a/tests/docker/dockerfiles/min-glib.docker
+++ /dev/null
@@ -1,8 +0,0 @@
-FROM centos:6
-RUN yum install -y \
-    tar gettext git make gcc g++ \
-    zlib-devel SDL-devel pixman-devel \
-    epel-release
-RUN yum install -y libfdt-devel ccache
-RUN yum downgrade -y http://vault.centos.org/6.0/os/x86_64/Packages/glib=
2-2.22.5-5.el6.x86_64.rpm
-RUN yum install -y http://vault.centos.org/6.0/os/x86_64/Packages/glib2-=
devel-2.22.5-5.el6.x86_64.rpm
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
2.17.0
