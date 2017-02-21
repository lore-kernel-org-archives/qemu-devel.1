Received: from eggs.gnu.org ([2001:4830:134:3::10]:55769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBDu-0000np-DZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBDp-0003q0-Dm
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBDp-0003ph-7E
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:17 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B6C28048A
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:15:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:26 +0400
Message-Id: <20170221141451.28305-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/30] glib-compat: add
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
index d8fba6647a..93b5deac23 100644
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
2.11.0.295.gd7dffce1c.dirty
