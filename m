Received: from eggs.gnu.org ([2001:4830:134:3::10]:60523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1fxYcX-0002ad-2Y
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quan.xu0@gmail.com>) id 1fxYcS-0006uP-4Z
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:17:25 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <quan.xu0@gmail.com>) id 1fxYcR-0006tq-Uu
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:17:20 -0400
Received: by mail-oi0-x244.google.com with SMTP id t68-v6so13845204oie.12
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 07:17:19 -0700 (PDT)
From: Quan Xu <quan.xu0@gmail.com>
Message-ID: <c9da5617-ddd8-d122-20c4-79b0bd92c176@gmail.com>
Date: Wed, 5 Sep 2018 22:17:01 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Subject: [RFC PATCH v2] migration: calculate remaining
 pages accurately during the bulk stage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm <kvm@vger.kernel.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

 From 7de4cc7c944bfccde0ef10992a7ec882fdcf0508 Mon Sep 17 00:00:00 2001
From: Quan Xu <quan.xu0@gmail.com>
Date: Wed, 5 Sep 2018 22:06:58 +0800
Subject: [RFC PATCH v2] migration: calculate remaining pages accurately 
during the bulk stage

Since the bulk stage assumes in (migration_bitmap_find_dirty) that every
page is dirty, initialize the number of dirty pages at the beggining of
the iteration and then decrease it for each processed page.

Signed-off-by: Quan Xu <quan.xu0@gmail.com>
---
  migration/ram.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 79c8942..1a11436 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -290,6 +290,8 @@ struct RAMState {
      uint32_t last_version;
      /* We are in the first round */
      bool ram_bulk_stage;
+    /* Remaining bytes in the first round */
+    uint64_t ram_bulk_bytes;
      /* How many times we have dirty too many pages */
      int dirty_rate_high_cnt;
      /* these variables are used for bitmap sync */
@@ -1540,6 +1542,7 @@ unsigned long migration_bitmap_find_dirty(RAMState 
*rs, RAMBlock *rb,

      if (rs->ram_bulk_stage && start > 0) {
          next = start + 1;
+        rs->ram_bulk_bytes -= TARGET_PAGE_SIZE;
      } else {
          next = find_next_bit(bitmap, size, start);
      }
@@ -2001,6 +2004,7 @@ static bool find_dirty_block(RAMState *rs, 
PageSearchStatus *pss, bool *again)
              /* Flag that we've looped */
              pss->complete_round = true;
              rs->ram_bulk_stage = false;
+            rs->ram_bulk_bytes = 0;
              if (migrate_use_xbzrle()) {
                  /* If xbzrle is on, stop using the data compression at 
this
                   * point. In theory, xbzrle can do better than 
compression.
@@ -2513,6 +2517,7 @@ static void ram_state_reset(RAMState *rs)
      rs->last_page = 0;
      rs->last_version = ram_list.version;
      rs->ram_bulk_stage = true;
+    rs->ram_bulk_bytes = ram_bytes_total();
  }

  #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -3308,7 +3313,7 @@ static void ram_save_pending(QEMUFile *f, void 
*opaque, uint64_t max_size,
          /* We can do postcopy, and all the data is postcopiable */
          *res_compatible += remaining_size;
      } else {
-        *res_precopy_only += remaining_size;
+        *res_precopy_only += remaining_size + rs->ram_bulk_bytes;
      }
  }

--
1.8.3.1
