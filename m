Received: from eggs.gnu.org ([209.51.188.92]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O9W-0003FI-Va
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O8E-0007an-3N
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:50:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 11 Mar 2019 17:50:10 +0100
Message-Id: <20190311165017.32247-4-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-1-kwolf@redhat.com>
References: <20190311165017.32247-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/10] block: Avoid useless local_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block.c b/block.c
index ccf008c177..e18bd5eefd 100644
--- a/block.c
+++ b/block.c
@@ -3155,14 +3155,12 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockRe=
openQueue *bs_queue, Error **er
 {
     int ret =3D -1;
     BlockReopenQueueEntry *bs_entry, *next;
-    Error *local_err =3D NULL;
=20
     assert(bs_queue !=3D NULL);
=20
     QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
         assert(bs_entry->state.bs->quiesce_counter > 0);
-        if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, &local_err))=
 {
-            error_propagate(errp, local_err);
+        if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, errp)) {
             goto cleanup;
         }
         bs_entry->prepared =3D true;
--=20
2.20.1
