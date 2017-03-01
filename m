Received: from eggs.gnu.org ([2001:4830:134:3::10]:41273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0CI-0002rH-CJ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cj0CE-0001Hd-8p
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:05:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cj0CE-0001HO-2y
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:05:18 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46E5D3B71F
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 09:05:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  1 Mar 2017 13:04:30 +0400
Message-Id: <20170301090453.11075-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170301090453.11075-1-marcandre.lureau@redhat.com>
References: <20170301090453.11075-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/28] glib-compat: add
 g_test_add_data_func_full fallback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Move the fallback from qtest_add_data_func_full() to glib-compat.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/glib-compat.h | 21 +++++++++++++++++++++
 tests/libqtest.c      | 10 ----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 0cd24ffbe9..863c8cf73d 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -328,4 +328,25 @@ static inline void g_source_set_name_by_id(guint tag=
, const char *name)
 #define g_test_subprocess() (0)
 #endif
=20
+
+#if !GLIB_CHECK_VERSION(2, 34, 0)
+static inline void
+g_test_add_data_func_full(const char *path,
+                          gpointer data,
+                          gpointer fn,
+                          gpointer data_free_func)
+{
+#if GLIB_CHECK_VERSION(2, 26, 0)
+    /* back-compat casts, remove this once we can require new-enough gli=
b */
+    g_test_add_vtable(path, 0, data, NULL,
+                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_free=
_func);
+#else
+    /* back-compat casts, remove this once we can require new-enough gli=
b */
+    g_test_add_vtable(path, 0, data, NULL,
+                      (void (*)(void)) fn, (void (*)(void)) data_free_fu=
nc);
+#endif
+}
+#endif
+
+
 #endif
diff --git a/tests/libqtest.c b/tests/libqtest.c
index e54354de8a..3a0e0d63a7 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -805,17 +805,7 @@ void qtest_add_data_func_full(const char *str, void =
*data,
                               GDestroyNotify data_free_func)
 {
     gchar *path =3D g_strdup_printf("/%s/%s", qtest_get_arch(), str);
-#if GLIB_CHECK_VERSION(2, 34, 0)
     g_test_add_data_func_full(path, data, fn, data_free_func);
-#elif GLIB_CHECK_VERSION(2, 26, 0)
-    /* back-compat casts, remove this once we can require new-enough gli=
b */
-    g_test_add_vtable(path, 0, data, NULL,
-                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_free=
_func);
-#else
-    /* back-compat casts, remove this once we can require new-enough gli=
b */
-    g_test_add_vtable(path, 0, data, NULL,
-                      (void (*)(void)) fn, (void (*)(void)) data_free_fu=
nc);
-#endif
     g_free(path);
 }
=20
--=20
2.12.0.rc2.3.gc93709801
