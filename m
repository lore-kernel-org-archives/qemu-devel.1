Received: from eggs.gnu.org ([2001:4830:134:3::10]:49483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRGF8-0007Y5-UT
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRGF4-0007JL-Vp
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRGF4-0007IW-R6
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:43:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DC27308FE92
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:43:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Nov 2018 16:42:42 +0400
Message-Id: <20181126124250.29985-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181126124250.29985-1-marcandre.lureau@redhat.com>
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 03/11] libvhost-user: exit by default
 on VHOST_USER_NONE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jens Freimann <jfreimann@redhat.com>

Since commit 2566378d6d13bf4d28c7770bdbda5f7682594bbe, libvhost-user
no longer panics on disconnect (rc =3D=3D 0), and instead silently ignore=
s
an invalid VHOST_USER_NONE message.

Without extra work from the API user, this will simply busy-loop on
HUP events. The obvious thing to do is to exit(0) instead, while
additional or different work can be done by overriding
iface->process_msg().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index a6b46cdc03..41470daf57 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1285,7 +1285,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
     case VHOST_USER_SET_CONFIG:
         return vu_set_config(dev, vmsg);
     case VHOST_USER_NONE:
-        break;
+        /* if you need processing before exit, override iface->process_m=
sg */
+        exit(0);
     case VHOST_USER_POSTCOPY_ADVISE:
         return vu_set_postcopy_advise(dev, vmsg);
     case VHOST_USER_POSTCOPY_LISTEN:
--=20
2.20.0.rc1
