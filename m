Received: from eggs.gnu.org ([2001:4830:134:3::10]:57032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFo-00037w-RR
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFn-0004C2-EN
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cPZFn-0004Bj-81
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68D4A2E8354
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 18:28:39 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  6 Jan 2017 18:28:18 +0000
Message-Id: <20170106182823.1960-11-dgilbert@redhat.com>
In-Reply-To: <20170106182823.1960-1-dgilbert@redhat.com>
References: <20170106182823.1960-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 10/15] postcopy: Mask fault addresses to huge
 page boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Currently the fault address received by userfault is rounded to
the host page boundary and a host page is requested from the source.
Use the current RAMBlock page size instead of the general host page
size so that for RAMBlocks backed by huge pages we request the whole
huge page.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/exec/memory.h    | 1 -
 migration/postcopy-ram.c | 7 +++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 64560f6..b9e877c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1610,7 +1610,6 @@ MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, uint8_t *buf, int len);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
-
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
     if (is_write) {
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4c736d2..03cbd6e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -403,7 +403,6 @@ static void *postcopy_ram_fault_thread(void *opaque)
     MigrationIncomingState *mis = opaque;
     struct uffd_msg msg;
     int ret;
-    size_t hostpagesize = getpagesize();
     RAMBlock *rb = NULL;
     RAMBlock *last_rb = NULL; /* last RAMBlock we sent part of */
 
@@ -470,7 +469,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
             break;
         }
 
-        rb_offset &= ~(hostpagesize - 1);
+        rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
         trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset);
@@ -482,11 +481,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
         if (rb != last_rb) {
             last_rb = rb;
             migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
-                                     rb_offset, hostpagesize);
+                                     rb_offset, qemu_ram_pagesize(rb));
         } else {
             /* Save some space */
             migrate_send_rp_req_pages(mis, NULL,
-                                     rb_offset, hostpagesize);
+                                     rb_offset, qemu_ram_pagesize(rb));
         }
     }
     trace_postcopy_ram_fault_thread_exit();
-- 
2.9.3
