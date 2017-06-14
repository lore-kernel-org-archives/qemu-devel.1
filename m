Received: from eggs.gnu.org ([2001:4830:134:3::10]:34393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvr-00014v-4a
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvn-0005nS-Ul
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dLEvn-0005n5-PA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB44E3DEEB
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 20:30:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Jun 2017 17:29:58 -0300
Message-Id: <20170614203000.19984-4-ehabkost@redhat.com>
In-Reply-To: <20170614203000.19984-1-ehabkost@redhat.com>
References: <20170614203000.19984-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] memory: Add RAM_NONPERSISTENT flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The new flag will make qemu_ram_free() discard the contents of the
block.  It will be used to let QEMU be configured to avoid flushing file
contents to disk when exiting.  As MADV_REMOVE is not always supported,
the new code will try MADV_NOTNEEDED in case MADV_REMOVE fails.

The new flag will also indicate that ram_block_discard_range() can use
MADV_REMOVE when discarding memory pages.  I have considered calling
MADV_REMOVE unconditionally (as destroying the RAM contents seems to be
OK every time ram_block_discard_range() is called), but for safety I
decided to restrict the new code to blocks having RAM_NONPERSISTENT set.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 exec.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 585d6ed6d7..a6e9ed4ece 100644
--- a/exec.c
+++ b/exec.c
@@ -102,6 +102,11 @@ static MemoryRegion io_mem_unassigned;
  */
 #define RAM_RESIZEABLE (1 << 2)
 
+/* RAMBlock contents are not persistent, and we can discard memory contents
+ * when freeing the memory block.
+ */
+#define RAM_NONPERSISTENT (1 << 3)
+
 #endif
 
 #ifdef TARGET_PAGE_BITS_VARY
@@ -2061,6 +2066,10 @@ void qemu_ram_free(RAMBlock *block)
         ram_block_notify_remove(block->host, block->max_length);
     }
 
+    if (block->flags & RAM_NONPERSISTENT) {
+        ram_block_discard_range(block, 0, block->max_length);
+    }
+
     qemu_mutex_lock_ramlist();
     QLIST_REMOVE_RCU(block, next);
     ram_list.mru_block = NULL;
@@ -3537,7 +3546,13 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             /* Note: We need the madvise MADV_DONTNEED behaviour of definitely
              * freeing the page.
              */
-            ret = madvise(host_startaddr, length, MADV_DONTNEED);
+            if (rb->flags & RAM_NONPERSISTENT) {
+                ret = madvise(host_startaddr, length, MADV_REMOVE);
+            }
+            /* Fallback to MADV_DONTNEED if MADV_REMOVE fails */
+            if (ret || !(rb->flags & RAM_NONPERSISTENT)) {
+                ret = madvise(host_startaddr, length, MADV_DONTNEED);
+            }
 #endif
         } else {
             /* Huge page case  - unfortunately it can't do DONTNEED, but
-- 
2.11.0.259.g40922b1
