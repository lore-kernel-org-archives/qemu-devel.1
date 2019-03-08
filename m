Received: from eggs.gnu.org ([209.51.188.92]:54985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2Kai-0005Qh-RT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2Kai-0001re-5k
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:51:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2Kah-0001iW-Va
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:51:32 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Mar 2019 18:51:24 +0000
Message-Id: <20190308185124.28467-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration/rdma: Check qemu_rdma_init_one_block
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

Actually it can't fail at the moment, but Coverity moans that
it's the only place it's not checked, and it's an easy check.

Reported-by: Coverity (CID 1399413)
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 63c118af09..c1bcece53b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -641,10 +641,14 @@ static int qemu_rdma_init_one_block(RAMBlock *rb, v=
oid *opaque)
 static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
 {
     RDMALocalBlocks *local =3D &rdma->local_ram_blocks;
+    int ret;
=20
     assert(rdma->blockmap =3D=3D NULL);
     memset(local, 0, sizeof *local);
-    foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
+    ret =3D foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
+    if (ret) {
+        return ret;
+    }
     trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
     rdma->dest_blocks =3D g_new0(RDMADestBlock,
                                rdma->local_ram_blocks.nb_blocks);
--=20
2.20.1
