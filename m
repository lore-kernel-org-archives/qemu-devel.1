Received: from eggs.gnu.org ([2001:4830:134:3::10]:50189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpavJ-0005eh-3y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpavF-0000zI-6W
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Sep 2017 16:02:42 +0200
Message-Id: <20170906140246.7326-11-kwolf@redhat.com>
In-Reply-To: <20170906140246.7326-1-kwolf@redhat.com>
References: <20170906140246.7326-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/14] block: tidy ThrottleGroupMember
 initializations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Manos Pitsidianakis <el13635@mail.ntua.gr>

Move the CoMutex and CoQueue inits inside throttle_group_register_tgm()
which is called whenever a ThrottleGroupMember is initialized. There's
no need for them to be separate.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c   | 3 ---
 block/throttle-groups.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index b4acd0f2ae..45d9101be3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -273,9 +273,6 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
-    qemu_co_mutex_init(&blk->public.throttle_group_member.throttled_reqs_lock);
-    qemu_co_queue_init(&blk->public.throttle_group_member.throttled_reqs[0]);
-    qemu_co_queue_init(&blk->public.throttle_group_member.throttled_reqs[1]);
     block_acct_init(&blk->stats);
 
     notifier_list_init(&blk->remove_bs_notifiers);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 3b07b25f39..7749cf043f 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -508,6 +508,9 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
                          read_timer_cb,
                          write_timer_cb,
                          tgm);
+    qemu_co_mutex_init(&tgm->throttled_reqs_lock);
+    qemu_co_queue_init(&tgm->throttled_reqs[0]);
+    qemu_co_queue_init(&tgm->throttled_reqs[1]);
 
     qemu_mutex_unlock(&tg->lock);
 }
-- 
2.13.5
