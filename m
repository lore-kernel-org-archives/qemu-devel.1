Received: from eggs.gnu.org ([2001:4830:134:3::10]:41932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dc7QV-0001Cs-Tt
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dc7QV-0005Yj-5K
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:55:51 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Mon, 31 Jul 2017 12:54:39 +0300
Message-Id: <20170731095443.28211-4-el13635@mail.ntua.gr>
In-Reply-To: <20170731095443.28211-1-el13635@mail.ntua.gr>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 3/7] block: tidy ThrottleGroupMember
 initializations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

Move the CoMutex and CoQueue inits inside throttle_group_register_tgm()
which is called whenever a ThrottleGroupMember is initialized. There's
no need for them to be separate.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/block-backend.c   | 3 ---
 block/throttle-groups.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6687a90660..df0200fc49 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -215,9 +215,6 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
-    qemu_co_mutex_init(&blk->public.throttle_group_member.throttled_reqs_lock);
-    qemu_co_queue_init(&blk->public.throttle_group_member.throttled_reqs[0]);
-    qemu_co_queue_init(&blk->public.throttle_group_member.throttled_reqs[1]);
     block_acct_init(&blk->stats);
 
     notifier_list_init(&blk->remove_bs_notifiers);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index a979e86243..f711a3dc62 100644
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
2.11.0
