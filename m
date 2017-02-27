Received: from eggs.gnu.org ([2001:4830:134:3::10]:53264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZT-0001bH-WB
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZT-0001ZL-75
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ciLZT-0001ZD-0r
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:35 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2890083F45
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:42:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 17:41:45 +0400
Message-Id: <20170227134202.2991-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-1-marcandre.lureau@redhat.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/21] container: don't leak container
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
2.12.0.rc2.3.gc93709801
