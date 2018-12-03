Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqED-0007yK-CE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEB-00045N-JG
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEB-00044f-Dy
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:43 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:21 +0100
Message-Id: <1543851204-41186-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/71] vhost-user: support cross-endian vnet
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

vhost-user already has a way to communicate the endianness of the guest
via the vring endianness messages.  The vring endianness always matches
the vnet header endianness so there is no need to do anything else in
the backend.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 net/vhost-user.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index a39f9c9..cd9659d 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -172,6 +172,17 @@ static void net_vhost_user_cleanup(NetClientState *n=
c)
     qemu_purge_queued_packets(nc);
 }
=20
+static int vhost_user_set_vnet_endianness(NetClientState *nc,
+                                          bool enable)
+{
+    /* Nothing to do.  If the server supports
+     * VHOST_USER_PROTOCOL_F_CROSS_ENDIAN, it will get the
+     * vnet header endianness from there.  If it doesn't, negotiation
+     * fails.
+     */
+    return 0;
+}
+
 static bool vhost_user_has_vnet_hdr(NetClientState *nc)
 {
     assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER);
@@ -193,6 +204,8 @@ static NetClientInfo net_vhost_user_info =3D {
         .cleanup =3D net_vhost_user_cleanup,
         .has_vnet_hdr =3D vhost_user_has_vnet_hdr,
         .has_ufo =3D vhost_user_has_ufo,
+        .set_vnet_be =3D vhost_user_set_vnet_endianness,
+        .set_vnet_le =3D vhost_user_set_vnet_endianness,
 };
=20
 static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond=
,
--=20
1.8.3.1
