Received: from eggs.gnu.org ([209.51.188.92]:40983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvV-00075e-0D
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvU-0005XV-74
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvU-0005X6-1Z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:52 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:27 +0000
Message-Id: <20190123155830.8459-7-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] migration/rdma: unregister fd handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, xiaoguangrong@tencent.com, marcandre.lureau@redhat.com, shirley17fei@gmail.com, lifei1214@126.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Unregister the fd handler before we destroy the channel,
otherwise we've got a race where we might land in the
fd handler just as we're closing the device.

(The race is quite data dependent, you just have to have
the right set of devices for it to trigger).

Corresponds to RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D16666=
01

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190122173111.29821-1-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 9b2e7e10aa..54a3c11540 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2321,6 +2321,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
         rdma->connected =3D false;
     }
=20
+    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
     g_free(rdma->dest_blocks);
     rdma->dest_blocks =3D NULL;
=20
--=20
2.20.1
