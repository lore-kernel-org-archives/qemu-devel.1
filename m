Received: from eggs.gnu.org ([2001:4830:134:3::10]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLK-0004QE-I4
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLH-0003u1-EY
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZLH-0003sj-9V
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76A05C05AA5B
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:45:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:55 +0300
Message-Id: <20161212224325.20790-25-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 24/54] char-parallel: convert parallel to
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
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 4d7f82a45b..403b8a3dc7 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2020,17 +2020,6 @@ static int pp_ioctl(Chardev *chr, int cmd, void *a=
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
@@ -4696,18 +4685,33 @@ static void char_parallel_class_init(ObjectClass =
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
2.11.0
