Received: from eggs.gnu.org ([209.51.188.92]:40151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJy3R-0000hy-5k
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJy3O-0004UT-Py
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:26:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hJy3O-0004Ct-F0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:26:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7381C0AD404
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:25:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Apr 2019 12:24:36 +0200
Message-Id: <20190426102437.16189-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190426102437.16189-1-marcandre.lureau@redhat.com>
References: <20190426102437.16189-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] util: simplify unix_listen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The only caller of unix_listen() left is qga/channel-posix.c.

There is no need to deal with legacy coma-trailing options ",...".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-sockets.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 9705051690..d1664e83d6 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -966,26 +966,12 @@ static int unix_connect_saddr(UnixSocketAddress *sa=
ddr, Error **errp)
 /* compatibility wrapper */
 int unix_listen(const char *str, Error **errp)
 {
-    char *path, *optstr;
-    int sock, len;
     UnixSocketAddress *saddr;
+    int sock;
=20
     saddr =3D g_new0(UnixSocketAddress, 1);
-
-    optstr =3D strchr(str, ',');
-    if (optstr) {
-        len =3D optstr - str;
-        if (len) {
-            path =3D g_malloc(len+1);
-            snprintf(path, len+1, "%.*s", len, str);
-            saddr->path =3D path;
-        }
-    } else {
-        saddr->path =3D g_strdup(str);
-    }
-
+    saddr->path =3D g_strdup(str);
     sock =3D unix_listen_saddr(saddr, errp);
-
     qapi_free_UnixSocketAddress(saddr);
     return sock;
 }
--=20
2.21.0.313.ge35b8cb8e2
