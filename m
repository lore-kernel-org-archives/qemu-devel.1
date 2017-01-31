Received: from eggs.gnu.org ([2001:4830:134:3::10]:60533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdPM-0007Wd-Ir
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdPJ-0000fT-3s
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:44:00 -0500
Received: from mail.kernel.org ([198.145.29.136]:38456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdPI-0000fE-Tx
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:57 -0500
Date: Tue, 31 Jan 2017 20:43:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485888144-16531-21-git-send-email-mst@redhat.com>
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485888144-16531-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 20/23] vhost-user: delete chardev on cleanup
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
index b0f0ab6..77b8110 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -151,7 +151,10 @@ static void vhost_user_cleanup(NetClientState *nc)
         s->vhost_net =3D NULL;
     }
     if (nc->queue_index =3D=3D 0) {
+        Chardev *chr =3D qemu_chr_fe_get_driver(&s->chr);
+
         qemu_chr_fe_deinit(&s->chr);
+        qemu_chr_delete(chr);
     }
=20
     qemu_purge_queued_packets(nc);
--=20
MST
