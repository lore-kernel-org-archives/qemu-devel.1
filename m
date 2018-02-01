Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEue-0004dj-Hu
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehEub-00008n-9k
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ehEub-00008S-1m
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A7E8806
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 13:28:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Feb 2018 14:27:51 +0100
Message-Id: <20180201132757.23063-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180201132757.23063-1-marcandre.lureau@redhat.com>
References: <20180201132757.23063-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 1/7] memfd: add error argument,
 instead of perror()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This will allow callers to silence error report when the call is
allowed to failed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/memfd.h |  5 +++--
 hw/virtio/vhost.c    |  8 +++++++-
 util/memfd.c         | 57 +++++++++++++++++++++++++++-------------------=
------
 3 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 41c24d807c..b9d09873b5 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -16,9 +16,10 @@
 #define F_SEAL_WRITE    0x0008  /* prevent writes */
 #endif
=20
-int qemu_memfd_create(const char *name, size_t size, unsigned int seals)=
;
+int qemu_memfd_create(const char *name, size_t size, unsigned int seals,
+                      Error **errp);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
-                       int *fd);
+                       int *fd, Error **errp);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
 bool qemu_memfd_check(void);
=20
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 386aef85be..80dc739b27 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -329,6 +329,7 @@ static uint64_t vhost_get_log_size(struct vhost_dev *=
dev)
=20
 static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
 {
+    Error *err =3D NULL;
     struct vhost_log *log;
     uint64_t logsize =3D size * sizeof(*(log->log));
     int fd =3D -1;
@@ -337,7 +338,12 @@ static struct vhost_log *vhost_log_alloc(uint64_t si=
ze, bool share)
     if (share) {
         log->log =3D qemu_memfd_alloc("vhost-log", logsize,
                                     F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL=
_SEAL,
-                                    &fd);
+                                    &fd, &err);
+        if (err) {
+            error_report_err(err);
+            g_free(log);
+            return NULL;
+        }
         memset(log->log, 0, logsize);
     } else {
         log->log =3D g_malloc0(logsize);
diff --git a/util/memfd.c b/util/memfd.c
index dce61f9d21..8d27307137 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "qapi/error.h"
 #include "qemu/memfd.h"
=20
 #if defined CONFIG_LINUX && !defined CONFIG_MEMFD
@@ -51,11 +52,11 @@ static int memfd_create(const char *name, unsigned in=
t flags)
 #define MFD_ALLOW_SEALING 0x0002U
 #endif
=20
-int qemu_memfd_create(const char *name, size_t size, unsigned int seals)
+int qemu_memfd_create(const char *name, size_t size,
+                      unsigned int seals, Error **errp)
 {
-    int mfd =3D -1;
-
 #ifdef CONFIG_LINUX
+    int mfd =3D -1;
     unsigned int flags =3D MFD_CLOEXEC;
=20
     if (seals) {
@@ -64,23 +65,26 @@ int qemu_memfd_create(const char *name, size_t size, =
unsigned int seals)
=20
     mfd =3D memfd_create(name, flags);
     if (mfd < 0) {
-        return -1;
+        goto err;
     }
=20
     if (ftruncate(mfd, size) =3D=3D -1) {
-        perror("ftruncate");
-        close(mfd);
-        return -1;
+        goto err;
     }
=20
     if (seals && fcntl(mfd, F_ADD_SEALS, seals) =3D=3D -1) {
-        perror("fcntl");
-        close(mfd);
-        return -1;
+        goto err;
     }
-#endif
=20
     return mfd;
+
+err:
+    if (mfd >=3D 0) {
+        close(mfd);
+    }
+#endif
+    error_setg_errno(errp, errno, "failed to create memfd");
+    return -1;
 }
=20
 /*
@@ -90,14 +94,14 @@ int qemu_memfd_create(const char *name, size_t size, =
unsigned int seals)
  * sealing.
  */
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals=
,
-                       int *fd)
+                       int *fd, Error **errp)
 {
     void *ptr;
-    int mfd =3D qemu_memfd_create(name, size, seals);
+    int mfd =3D qemu_memfd_create(name, size, seals, NULL);
=20
     /* some systems have memfd without sealing */
     if (mfd =3D=3D -1) {
-        mfd =3D qemu_memfd_create(name, size, 0);
+        mfd =3D qemu_memfd_create(name, size, 0, NULL);
     }
=20
     if (mfd =3D=3D -1) {
@@ -109,27 +113,26 @@ void *qemu_memfd_alloc(const char *name, size_t siz=
e, unsigned int seals,
         unlink(fname);
         g_free(fname);
=20
-        if (mfd =3D=3D -1) {
-            perror("mkstemp");
-            return NULL;
-        }
-
-        if (ftruncate(mfd, size) =3D=3D -1) {
-            perror("ftruncate");
-            close(mfd);
-            return NULL;
+        if (mfd =3D=3D -1 ||
+            ftruncate(mfd, size) =3D=3D -1) {
+            goto err;
         }
     }
=20
     ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
     if (ptr =3D=3D MAP_FAILED) {
-        perror("mmap");
-        close(mfd);
-        return NULL;
+        goto err;
     }
=20
     *fd =3D mfd;
     return ptr;
+
+err:
+    error_setg_errno(errp, errno, "failed to allocate shared memory");
+    if (mfd >=3D 0) {
+        close(mfd);
+    }
+    return NULL;
 }
=20
 void qemu_memfd_free(void *ptr, size_t size, int fd)
@@ -157,7 +160,7 @@ bool qemu_memfd_check(void)
         int fd;
         void *ptr;
=20
-        ptr =3D qemu_memfd_alloc("test", 4096, 0, &fd);
+        ptr =3D qemu_memfd_alloc("test", 4096, 0, &fd, NULL);
         memfd_check =3D ptr ? MEMFD_OK : MEMFD_KO;
         qemu_memfd_free(ptr, 4096, fd);
     }
--=20
2.16.0.rc1.1.gef27df75a1
