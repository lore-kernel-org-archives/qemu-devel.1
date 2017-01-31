Received: from eggs.gnu.org ([2001:4830:134:3::10]:58454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYHC-0001zj-JA
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYHB-0000MN-Kl
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:15:14 -0500
Received: from mail.kernel.org ([198.145.29.136]:39864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYHB-0000M0-ET
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:15:13 -0500
Date: Tue, 31 Jan 2017 15:15:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485868446-10587-19-git-send-email-mst@redhat.com>
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485868446-10587-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 18/21] vhost-user: delete chardev on cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Remove the chardev implicitly when cleaning up the netdev. This
prevents from reusing the chardev since it would be in an incorrect
state with the slave.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1256618

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 net/vhost-user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 7aff77e..179939f 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -151,7 +151,10 @@ static void vhost_user_cleanup(NetClientState *nc)
         s->vhost_net =3D NULL;
     }
     if (nc->queue_index =3D=3D 0) {
+        CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->chr);
+
         qemu_chr_fe_deinit(&s->chr);
+        qemu_chr_delete(chr);
     }
=20
     qemu_purge_queued_packets(nc);
--=20
MST
