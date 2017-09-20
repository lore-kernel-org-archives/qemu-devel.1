Received: from eggs.gnu.org ([2001:4830:134:3::10]:41731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAV-00024W-Up
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAQ-00010P-DN
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:35:59 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 20 Sep 2017 13:23:11 +0300
Message-Id: <20170920102311.25736-4-el13635@mail.ntua.gr>
In-Reply-To: <20170920102311.25736-1-el13635@mail.ntua.gr>
References: <20170920102311.25736-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 3/3] block/throttle.c: add
 bdrv_co_drain_begin/end callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/throttle.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/throttle.c b/block/throttle.c
index 5bca76300f..833175ac77 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -197,6 +197,21 @@ static bool throttle_recurse_is_first_non_filter(BlockDriverState *bs,
     return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
 }
 
+static void coroutine_fn throttle_co_drain_begin(BlockDriverState *bs)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    if (atomic_fetch_inc(&tgm->io_limits_disabled) == 0) {
+        throttle_group_restart_tgm(tgm);
+    }
+}
+
+static void coroutine_fn throttle_co_drain_end(BlockDriverState *bs)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    assert(tgm->io_limits_disabled);
+    atomic_dec(&tgm->io_limits_disabled);
+}
+
 static BlockDriver bdrv_throttle = {
     .format_name                        =   "throttle",
     .protocol_name                      =   "throttle",
@@ -226,6 +241,9 @@ static BlockDriver bdrv_throttle = {
     .bdrv_reopen_abort                  =   throttle_reopen_abort,
     .bdrv_co_get_block_status           =   bdrv_co_get_block_status_from_file,
 
+    .bdrv_co_drain_begin                =   throttle_co_drain_begin,
+    .bdrv_co_drain_end                  =   throttle_co_drain_end,
+
     .is_filter                          =   true,
 };
 
-- 
2.11.0
