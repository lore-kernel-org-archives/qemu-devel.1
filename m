Received: from eggs.gnu.org ([2001:4830:134:3::10]:47004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbM-00045I-IX
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbL-0000E8-P8
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRbL-0000Dx-It
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2375C0099E9
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:21:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:04 +0400
Message-Id: <20170316092121.25672-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 04/21] container: don't leak container
 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

object_property_add_child() references the child, unref it after to
avoid ref leaks.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
