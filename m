Received: from eggs.gnu.org ([2001:4830:134:3::10]:59532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrT-0004J0-QT
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrR-00079e-IE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:35 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrR-00079O-BL
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:33 -0400
Received: by mail-wr0-x230.google.com with SMTP id k71so8875502wrc.2
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:10 +0200
Message-Id: <1501604245-33460-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/17] cpu_physical_memory_sync_dirty_bitmap:
 Fix alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This code has an optimised, word aligned version, and a boring
unaligned version.  Recently 084140bd498909 fixed a missing offset
addition from the core of both versions.  However, the offset isn't
necessarily aligned and thus the choice between the two versions
needs fixing up to also include the offset.

Symptom:
  A few stuck unsent pages during migration; not normally noticed
unless under very low bandwidth in which case the migration may get
stuck never ending and never performing a 2nd sync; noticed by
a hanging postcopy-test on a very heavily loaded system.

Fixes: 084140bd498909

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Alex BenneÃ© <alex.benee@linaro.org>
Tested-by: Alex BenneÃ© <alex.benee@linaro.org>

--
v2
  Move 'page' inside the if (Comment from Paolo)
Message-Id: <20170724165125.29887-1-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/ram_addr.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index c04f4f6..d017639 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -377,19 +377,20 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                uint64_t *real_dirty_pages)
 {
     ram_addr_t addr;
-    unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
+    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
     unsigned long *dest = rb->bmap;
 
     /* start address is aligned at the start of a word? */
-    if (((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) {
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
+         (start + rb->offset)) {
         int k;
         int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
         unsigned long * const *src;
-        unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
         unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
         unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
                                         DIRTY_MEMORY_BLOCK_SIZE);
+        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
 
         rcu_read_lock();
 
-- 
1.8.3.1
