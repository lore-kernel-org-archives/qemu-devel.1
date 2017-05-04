Received: from eggs.gnu.org ([2001:4830:134:3::10]:45872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FA7-00034m-VH
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FA3-0004KF-15
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FA2-0004Jx-R4
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:15 +0400
Message-Id: <20170504114232.20318-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/21] container: don't leak container reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

object_property_add_child() references the child, unref it after to
avoid ref leaks.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 qom/container.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/container.c b/qom/container.c
index c9eb49b01e..f6ccaf7ea7 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -40,6 +40,7 @@ Object *container_get(Object *root, const char *path)
         if (!child) {
             child =3D object_new("container");
             object_property_add_child(obj, parts[i], child, NULL);
+            object_unref(child);
         }
     }
=20
--=20
2.12.0.191.gc5d8de91d
