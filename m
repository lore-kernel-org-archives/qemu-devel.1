Received: from eggs.gnu.org ([209.51.188.92]:50005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h2G88-0000zr-6f
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h2G7y-0001om-Vv
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1h2G7y-0001Yf-OW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 554223087BAF
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 14:05:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Mar 2019 15:04:46 +0100
Message-Id: <20190308140454.32437-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190308140454.32437-1-marcandre.lureau@redhat.com>
References: <20190308140454.32437-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 04/12] libvhost-user: exit by default on
 VHOST_USER_NONE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com

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
index 3f14b4138b..fcf5014240 100644
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
2.21.0.4.g36eb1cb9cf
