Received: from eggs.gnu.org ([209.51.188.92]:51183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1guM94-0003Am-Ig
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1guM93-0007rp-QH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:54:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1guM93-0007qD-KB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:54:01 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Feb 2019 18:53:51 +0000
Message-Id: <20190214185351.5927-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration/rdma: Fix qemu_rdma_cleanup null
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, peter.maydell@linaro.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

If the migration fails before the channel is open (e.g. a bad
address) we end up in the cleanup with rdma->channel=3D=3DNULL.

Spotted by Coverity: CID 1398634
Fixes: fbbaacab2758cb3f32a0
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 54a3c11540..9fa3b176eb 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2321,7 +2321,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
         rdma->connected =3D false;
     }
=20
-    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
+    if (rdma->channel) {
+        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
+    }
     g_free(rdma->dest_blocks);
     rdma->dest_blocks =3D NULL;
=20
--=20
2.20.1
