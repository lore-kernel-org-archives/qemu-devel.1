Received: from eggs.gnu.org ([2001:4830:134:3::10]:42788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4U-0000b2-TX
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4T-0002Lv-M9
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:55:58 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:18 -0500
Message-Id: <20170313195547.21466-2-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/30] trace: Fix backwards mirror_yield
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>

block/trace-events lists the parameters for mirror_yield
consistently with other mirror events (cnt just after s, like in
mirror_before_sleep; in_flight last, like in mirror_yield_in_flight).
But the callers were passing parameters in the wrong order, leading
to poor trace messages, including type truncation when there are
more than 4G dirty sectors involved.  Broken since its introduction
in commit bd48bde.

While touching this, ensure that all callers use the same type
(uint64_t) for cnt, as a later patch will enable the compiler to do
stricter type-checking.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/mirror.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index a5d30ee..16b4c82 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -632,7 +632,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             }

             if (s->in_flight >= MAX_IN_FLIGHT) {
-                trace_mirror_yield(s, s->in_flight, s->buf_free_count, -1);
+                trace_mirror_yield(s, UINT64_MAX, s->buf_free_count,
+                                   s->in_flight);
                 mirror_wait_for_io(s);
                 continue;
             }
@@ -807,7 +808,7 @@ static void coroutine_fn mirror_run(void *opaque)
             s->common.iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
             if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
                 (cnt == 0 && s->in_flight > 0)) {
-                trace_mirror_yield(s, s->in_flight, s->buf_free_count, cnt);
+                trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight);
                 mirror_wait_for_io(s);
                 continue;
             } else if (cnt != 0) {
-- 
2.9.3
