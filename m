Received: from eggs.gnu.org ([2001:4830:134:3::10]:60418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cW6NH-0006gq-8c
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cW6ND-0004OH-4c
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:03:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cW6NC-0004Nc-Uo
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:03:19 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B477C05AA40
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 19:03:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Jan 2017 23:02:58 +0400
Message-Id: <20170124190258.14354-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv2] vhost-user: delete chardev on cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Remove the chardev implicitely when cleaning up the netdev. This
prevents from reusing the chardev since it would be in an incorrect
state with the slave.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1256618

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/vhost-user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 7aff77ee4a..179939f5c1 100644
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
2.11.0.295.gd7dffce1c
