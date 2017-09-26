Received: from eggs.gnu.org ([2001:4830:134:3::10]:32846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkS-0001SC-An
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkO-0005Mx-Ga
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:19 +0200
Message-Id: <20170926142133.2498-11-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/24] block/throttle-groups.c: allocate
 RestartData on the heap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Manos Pitsidianakis <el13635@mail.ntua.gr>

RestartData is the opaque data of the throttle_group_restart_queue_entry
coroutine. By being stack allocated, it isn't available anymore if
aio_co_enter schedules the coroutine with a bottom half and runs after
throttle_group_restart_queue returns.

Cc: qemu-stable@nongnu.org
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/throttle-groups.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 6ba992c8d7..b291a88481 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -403,17 +403,19 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
         schedule_next_request(tgm, is_write);
         qemu_mutex_unlock(&tg->lock);
     }
+
+    g_free(data);
 }
 
 static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write)
 {
     Coroutine *co;
-    RestartData rd = {
-        .tgm = tgm,
-        .is_write = is_write
-    };
+    RestartData *rd = g_new0(RestartData, 1);
+
+    rd->tgm = tgm;
+    rd->is_write = is_write;
 
-    co = qemu_coroutine_create(throttle_group_restart_queue_entry, &rd);
+    co = qemu_coroutine_create(throttle_group_restart_queue_entry, rd);
     aio_co_enter(tgm->aio_context, co);
 }
 
-- 
2.13.5
