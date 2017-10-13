Received: from eggs.gnu.org ([2001:4830:134:3::10]:57733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e30LW-0007rn-Bc
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e30LT-0006X4-9F
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e30LT-0006Wa-1y
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 13 Oct 2017 14:49:30 +0100
Message-Id: <20171013134930.20200-4-stefanha@redhat.com>
In-Reply-To: <20171013134930.20200-1-stefanha@redhat.com>
References: <20171013134930.20200-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] block/throttle.c: add
 bdrv_co_drain_begin/end callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>

From: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.13.6
