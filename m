Received: from eggs.gnu.org ([2001:4830:134:3::10]:36634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCkRM-0008Pl-Jc
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCkRI-0005mq-0o
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:52:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eCkRH-0005m6-Qr
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:52:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20A787E427
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 10:52:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Nov 2017 11:51:54 +0100
Message-Id: <20171109105154.29414-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] ui: fix dcl unregister
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

register checks for dcl->ds being NULL, to avoid registering
the same dcl twice.

Therefore dcl->ds must be cleared on unregister, otherwise
un-registering and re-registering doesn't work.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1510809
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console.c b/ui/console.c
index eca854cbd5..c4c95abed7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1471,6 +1471,7 @@ void unregister_displaychangelistener(DisplayChange=
Listener *dcl)
         dcl->con->dcls--;
     }
     QLIST_REMOVE(dcl, next);
+    dcl->ds =3D NULL;
     gui_setup_refresh(ds);
 }
=20
--=20
2.9.3
