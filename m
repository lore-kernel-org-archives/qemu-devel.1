Received: from eggs.gnu.org ([2001:4830:134:3::10]:50538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=847f9958e=marcolso@amazon.com>)
	id 1gM6Jd-00085E-8R
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 02:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=847f9958e=marcolso@amazon.com>)
	id 1gM6JZ-0004DZ-Hl
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 02:07:18 -0500
From: Marc Olson <marcolso@amazon.com>
Date: Sun, 11 Nov 2018 23:06:36 -0800
Message-Id: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
Subject: [Qemu-devel] [PATCH v3 1/3] blkdebug: fix one shot rule processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Marc Olson <marcolso@amazon.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

If 'once' is specified, the rule should execute just once, regardless if
it is supposed to return an error or not. Take the example where you
want the first IO to an LBA to succeed, but subsequent IOs to fail. You
could either use state transitions, or create two rules, one with
error = 0 and once set to true, and one with a non-zero error.

Signed-off-by: Marc Olson <marcolso@amazon.com>
---
 block/blkdebug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 0759452..327049b 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -488,7 +488,7 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
         }
     }
 
-    if (!rule || !rule->options.inject.error) {
+    if (!rule) {
         return 0;
     }
 
@@ -500,7 +500,7 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
         remove_rule(rule);
     }
 
-    if (!immediately) {
+    if (error && !immediately) {
         aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
         qemu_coroutine_yield();
     }
-- 
2.7.4
