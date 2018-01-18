Received: from eggs.gnu.org ([2001:4830:134:3::10]:45794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzeh-0000Dx-PD
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzeg-0004KL-8R
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzef-0004JZ-Vd
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:14 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:09:42 -0200
Message-Id: <20180118021000.27203-2-ehabkost@redhat.com>
In-Reply-To: <20180118021000.27203-1-ehabkost@redhat.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/19] memfd: split qemu_memfd_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Add a function to only create a memfd, without mmap. The function is
used in the following memory backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20171023141815.17709-2-marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qemu/memfd.h |  1 +
 util/memfd.c         | 61 +++++++++++++++++++++++++++++++---------------=
------
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 745a8c501e..41c24d807c 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -16,6 +16,7 @@
 #define F_SEAL_WRITE    0x0008  /* prevent writes */
 #endif
=20
+int qemu_memfd_create(const char *name, size_t size, unsigned int seals)=
;
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
                        int *fd);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
diff --git a/util/memfd.c b/util/memfd.c
index 412e94a405..3a82505f8d 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -53,6 +53,38 @@ static int memfd_create(const char *name, unsigned int=
 flags)
 #define MFD_ALLOW_SEALING 0x0002U
 #endif
=20
+int qemu_memfd_create(const char *name, size_t size, unsigned int seals)
+{
+    int mfd =3D -1;
+
+#ifdef CONFIG_LINUX
+    unsigned int flags =3D MFD_CLOEXEC;
+
+    if (seals) {
+        flags |=3D MFD_ALLOW_SEALING;
+    }
+
+    mfd =3D memfd_create(name, flags);
+    if (mfd < 0) {
+        return -1;
+    }
+
+    if (ftruncate(mfd, size) =3D=3D -1) {
+        perror("ftruncate");
+        close(mfd);
+        return -1;
+    }
+
+    if (seals && fcntl(mfd, F_ADD_SEALS, seals) =3D=3D -1) {
+        perror("fcntl");
+        close(mfd);
+        return -1;
+    }
+#endif
+
+    return mfd;
+}
+
 /*
  * This is a best-effort helper for shared memory allocation, with
  * optional sealing. The helper will do his best to allocate using
@@ -63,35 +95,14 @@ void *qemu_memfd_alloc(const char *name, size_t size,=
 unsigned int seals,
                        int *fd)
 {
     void *ptr;
-    int mfd =3D -1;
-
-    *fd =3D -1;
-
-#ifdef CONFIG_LINUX
-    if (seals) {
-        mfd =3D memfd_create(name, MFD_ALLOW_SEALING | MFD_CLOEXEC);
-    }
+    int mfd =3D qemu_memfd_create(name, size, seals);
=20
+    /* some systems have memfd without sealing */
     if (mfd =3D=3D -1) {
-        /* some systems have memfd without sealing */
-        mfd =3D memfd_create(name, MFD_CLOEXEC);
-        seals =3D 0;
+        mfd =3D qemu_memfd_create(name, size, 0);
     }
-#endif
-
-    if (mfd !=3D -1) {
-        if (ftruncate(mfd, size) =3D=3D -1) {
-            perror("ftruncate");
-            close(mfd);
-            return NULL;
-        }
=20
-        if (seals && fcntl(mfd, F_ADD_SEALS, seals) =3D=3D -1) {
-            perror("fcntl");
-            close(mfd);
-            return NULL;
-        }
-    } else {
+    if (mfd =3D=3D -1) {
         const char *tmpdir =3D g_get_tmp_dir();
         gchar *fname;
=20
--=20
2.14.3
