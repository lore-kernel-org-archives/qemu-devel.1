Received: from eggs.gnu.org ([2001:4830:134:3::10]:39528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIk2-0004Dx-6G
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIk0-000429-Ta
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIk0-00040u-ND
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDE74C051665
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:23 +0400
Message-Id: <20170202145141.17138-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/22] container: don't leak container reference
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
2.11.0.295.gd7dffce1c.dirty
