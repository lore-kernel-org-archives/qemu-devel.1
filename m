Received: from eggs.gnu.org ([209.51.188.92]:34706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldM-0006Fr-0L
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldK-0002MP-58
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:11 +0100
Message-Id: <20190218161822.3573-2-kwolf@redhat.com>
In-Reply-To: <20190218161822.3573-1-kwolf@redhat.com>
References: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/12] block-backend: Make
 blk_inc/dec_in_flight public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

For some users of BlockBackends, just increasing the in_flight counter
is easier than implementing separate handlers in BlockDevOps. Make the
helper functions for this public.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend.h | 2 ++
 block/block-backend.c          | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 832a4bf168..e2066eb06b 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -156,6 +156,8 @@ int blk_co_pdiscard(BlockBackend *blk, int64_t offset=
, int bytes);
 int blk_co_flush(BlockBackend *blk);
 int blk_flush(BlockBackend *blk);
 int blk_commit_all(void);
+void blk_inc_in_flight(BlockBackend *blk);
+void blk_dec_in_flight(BlockBackend *blk);
 void blk_drain(BlockBackend *blk);
 void blk_drain_all(void);
 void blk_set_on_error(BlockBackend *blk, BlockdevOnError on_read_error,
diff --git a/block/block-backend.c b/block/block-backend.c
index f6ea824308..0219555f89 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1262,12 +1262,12 @@ int blk_make_zero(BlockBackend *blk, BdrvRequestF=
lags flags)
     return bdrv_make_zero(blk->root, flags);
 }
=20
-static void blk_inc_in_flight(BlockBackend *blk)
+void blk_inc_in_flight(BlockBackend *blk)
 {
     atomic_inc(&blk->in_flight);
 }
=20
-static void blk_dec_in_flight(BlockBackend *blk)
+void blk_dec_in_flight(BlockBackend *blk)
 {
     atomic_dec(&blk->in_flight);
     aio_wait_kick();
--=20
2.20.1
