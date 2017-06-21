Received: from eggs.gnu.org ([2001:4830:134:3::10]:55882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dNgDL-0005Da-1n
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dNgDF-0004YA-4w
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:02:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dNgDE-0004Xx-T6
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:02:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF2227F6B6
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 14:02:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Jun 2017 16:02:17 +0200
Message-Id: <20170621140219.4568-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170621140219.4568-1-marcandre.lureau@redhat.com>
References: <20170621140219.4568-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/3] memfd: split qemu_memfd_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a function to only create a memfd, without mmap. The function is
used in the following memory backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/memfd.h |  2 ++
 util/memfd.c         | 42 +++++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 745a8c501e..30c1ab1d91 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -16,6 +16,8 @@
 #define F_SEAL_WRITE    0x0008  /* prevent writes */
 #endif
=20
+int qemu_memfd_create(const char *name, size_t size, unsigned int seals,
+                      bool must_seal);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
                        int *fd);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
diff --git a/util/memfd.c b/util/memfd.c
index 4571d1aba8..e6476df083 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -55,45 +55,53 @@ static int memfd_create(const char *name, unsigned in=
t flags)
 #define MFD_ALLOW_SEALING 0x0002U
 #endif
=20
-/*
- * This is a best-effort helper for shared memory allocation, with
- * optional sealing. The helper will do his best to allocate using
- * memfd with sealing, but may fallback on other methods without
- * sealing.
- */
-void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
-                       int *fd)
+int qemu_memfd_create(const char *name, size_t size, unsigned int seals,
+    bool must_seal)
 {
-    void *ptr;
     int mfd =3D -1;
=20
-    *fd =3D -1;
-
 #ifdef CONFIG_LINUX
     if (seals) {
         mfd =3D memfd_create(name, MFD_ALLOW_SEALING | MFD_CLOEXEC);
     }
=20
-    if (mfd =3D=3D -1) {
+    if (mfd =3D=3D -1 && !must_seal) {
         /* some systems have memfd without sealing */
         mfd =3D memfd_create(name, MFD_CLOEXEC);
         seals =3D 0;
     }
-#endif
=20
-    if (mfd !=3D -1) {
+    if (mfd >=3D 0) {
         if (ftruncate(mfd, size) =3D=3D -1) {
             perror("ftruncate");
             close(mfd);
-            return NULL;
+            return -1;
         }
=20
         if (seals && fcntl(mfd, F_ADD_SEALS, seals) =3D=3D -1) {
             perror("fcntl");
             close(mfd);
-            return NULL;
+            return -1;
         }
-    } else {
+    }
+#endif
+
+    return mfd;
+}
+
+/*
+ * This is a best-effort helper for shared memory allocation, with
+ * optional sealing. The helper will do his best to allocate using
+ * memfd with sealing, but may fallback on other methods without
+ * sealing.
+ */
+void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
+                       int *fd)
+{
+    void *ptr;
+    int mfd =3D qemu_memfd_create(name, size, seals, false);
+
+    if (mfd =3D=3D -1) {
         const char *tmpdir =3D g_get_tmp_dir();
         gchar *fname;
=20
--=20
2.13.1.395.gf7b71de06
