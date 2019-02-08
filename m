Received: from eggs.gnu.org ([209.51.188.92]:36122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4Gf-0001Qs-CC
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4Ge-0008JT-MT
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:24:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gs4Ge-0008Hy-G9
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:24:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3986159461
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 11:24:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Feb 2019 12:23:45 +0100
Message-Id: <20190208112357.31615-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190208112357.31615-1-marcandre.lureau@redhat.com>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/13] libvhost-user: fix clang
 enum-conversion warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Now that the VhostUserMsg.request field is used for both master &
slave requests, since commit d84599f56c820d8c1ac9928a76500dcdfbbf194d:

contrib/libvhost-user/libvhost-user.c:953:20: error: implicit conversion =
from enumeration type 'enum VhostUserSlaveRequest' to different enumerati=
on type 'VhostUserRequest' (aka 'enum VhostUserRequest') [-Werror,-Wenum-=
conversion]
        .request =3D VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 4aa55b4d2d..c0133b7f3f 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -145,7 +145,7 @@ typedef struct VhostUserVringArea {
 #endif
=20
 typedef struct VhostUserMsg {
-    VhostUserRequest request;
+    int request;
=20
 #define VHOST_USER_VERSION_MASK     (0x3)
 #define VHOST_USER_REPLY_MASK       (0x1 << 2)
--=20
2.20.1.519.g8feddda32c
