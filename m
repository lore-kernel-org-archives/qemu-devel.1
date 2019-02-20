Received: from eggs.gnu.org ([209.51.188.92]:52027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwW07-0005fU-9L
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwW05-0005Wh-1A
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:49:43 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Feb 2019 18:48:39 +0100
Message-Id: <20190220174843.8847-10-kwolf@redhat.com>
In-Reply-To: <20190220174843.8847-1-kwolf@redhat.com>
References: <20190220174843.8847-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/13] block: Don't poll in
 bdrv_set_aio_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

The explicit aio_poll() call in bdrv_set_aio_context() was added in
commit c2b6428d388 as a workaround for bdrv_drain() failing to achieve
to actually quiesce everything (specifically the NBD client code to
switch AioContext).

Now that the NBD client has been fixed to complete this operation during
bdrv_drain(), we don't need the workaround any more.

It was wrong anyway: aio_poll() must always be run in the home thread of
the AioContext.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block.c b/block.c
index 0c12632661..17bc1d3dca 100644
--- a/block.c
+++ b/block.c
@@ -5273,10 +5273,6 @@ void bdrv_set_aio_context(BlockDriverState *bs, Ai=
oContext *new_context)
     bdrv_parent_drained_begin(bs, NULL, false);
     bdrv_drain(bs); /* ensure there are no in-flight requests */
=20
-    while (aio_poll(ctx, false)) {
-        /* wait for all bottom halves to execute */
-    }
-
     bdrv_detach_aio_context(bs);
=20
     /* This function executes in the old AioContext so acquire the new o=
ne in
--=20
2.20.1
