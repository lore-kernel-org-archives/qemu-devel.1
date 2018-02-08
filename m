Received: from eggs.gnu.org ([2001:4830:134:3::10]:47709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ejmBW-0002C7-CG
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ejmBV-0003lO-7V
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:24:18 -0500
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Date: Thu,  8 Feb 2018 16:23:36 +0300
Message-Id: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/1] nbd: increase maximum size of the
 PWRITE_ZERO request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Upstream NBD protocol implementation supports an efficient zero out
mechanism over the wire, along with the ability to check whether a
client allows using a hole.

Accordingly, since PWRITE_ZERO doesn't involve any payload on the wire,
increase a maximum size of the PWRITE_ZERO request up to 1Gb (aligned).
Moreover, such change will decrease the number of PWRITE_ZERO NBD commands
in comparison with the current 32M limit. The benefits of
the larger constraint can be examined in a block mirroring over NBD.

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
---
 block/nbd.c         | 2 +-
 include/block/nbd.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 94220f6d14..3641d9244e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -477,7 +477,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
     uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);

     bs->bl.max_pdiscard = max;
-    bs->bl.max_pwrite_zeroes = max;
+    bs->bl.max_pwrite_zeroes = NBD_MAX_PWRITE_ZERO_SIZE;
     bs->bl.max_transfer = max;

     if (s->info.opt_block &&
diff --git a/include/block/nbd.h b/include/block/nbd.h
index ee74ec391a..e2f18e2332 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -182,6 +182,9 @@ enum {
 /* Maximum size of a single READ/WRITE data buffer */
 #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)

+/* Maximum size of a single PWRITE_ZERO request 1Gb */
+#define NBD_MAX_PWRITE_ZERO_SIZE (1024 * 1024 * 1024)
+
 /* Maximum size of an export name. The NBD spec requires 256 and
  * suggests that servers support up to 4096, but we stick to only the
  * required size so that we can stack-allocate the names, and because
--
2.11.0
