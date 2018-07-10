Received: from eggs.gnu.org ([2001:4830:134:3::10]:40812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub0-00039c-I2
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuaz-0003Nr-Nw
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcuaz-0003Nf-Jl
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E7AD7C6A9
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:29 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:08 +0100
Message-Id: <20180710153016.131258-8-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] migration: fix incorrect bitmap size
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

The calculation on size of received bitmap is incorrect for postcopy
recovery.  Here we wanted to let the size to cover all the valid bits in
the bitmap, we should use DIV_ROUND_UP() instead of a division.

For example, a RAMBlock with size=4K (which contains only one single 4K
page) will have nbits=1, then nbits/8=0, then the real bitmap won't be
sent to source at all.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180710091902.28780-4-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 49068e86d3..52dd678092 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -235,7 +235,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
     bitmap_to_le(le_bitmap, block->receivedmap, nbits);
 
     /* Size of the bitmap, in bytes */
-    size = nbits / 8;
+    size = DIV_ROUND_UP(nbits, 8);
 
     /*
      * size is always aligned to 8 bytes for 64bit machines, but it
@@ -3944,7 +3944,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     int ret = -EINVAL;
     QEMUFile *file = s->rp_state.from_dst_file;
     unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
-    uint64_t local_size = nbits / 8;
+    uint64_t local_size = DIV_ROUND_UP(nbits, 8);
     uint64_t size, end_mark;
 
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
-- 
2.17.1
