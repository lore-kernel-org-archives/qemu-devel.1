Received: from eggs.gnu.org ([2001:4830:134:3::10]:45569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbC5-0008Oa-PC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbC4-0000qv-U6
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbC4-0000qj-Na
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:08 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:51 +0400
Message-Id: <20170131162122.29408-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/41] char-parallel: convert parallel to
 finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 74e78b56d1..1981058f45 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2025,17 +2025,6 @@ static int pp_ioctl(Chardev *chr, int cmd, void *a=
rg)
     return 0;
 }
=20
-static void pp_free(Chardev *chr)
-{
-    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
-    int fd =3D drv->fd;
-
-    pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
-    ioctl(fd, PPRELEASE);
-    close(fd);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-}
-
 static void qemu_chr_open_pp_fd(Chardev *chr,
                                 int fd,
                                 bool *be_opened,
@@ -4699,18 +4688,33 @@ static void char_parallel_class_init(ObjectClass =
*oc, void *data)
 #if defined(__linux__)
     cc->chr_write =3D null_chr_write;
     cc->chr_ioctl =3D pp_ioctl;
-    cc->chr_free =3D pp_free;
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__D=
ragonFly__)
-    /* FIXME: no chr_free */
     cc->chr_write =3D null_chr_write;
     cc->chr_ioctl =3D pp_ioctl;
 #endif
 }
=20
+static void char_parallel_finalize(Object *obj)
+{
+#if defined(__linux__)
+    Chardev *chr =3D CHARDEV(obj);
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
+    int fd =3D drv->fd;
+
+    pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
+    ioctl(fd, PPRELEASE);
+    close(fd);
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__D=
ragonFly__)
+    /* FIXME: close fd? */
+#endif
+}
+
 static const TypeInfo char_parallel_type_info =3D {
     .name =3D TYPE_CHARDEV_PARALLEL,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(ParallelChardev),
+    .instance_finalize =3D char_parallel_finalize,
     .class_init =3D char_parallel_class_init,
 };
 #endif
--=20
2.11.0.295.gd7dffce1c.dirty
