Received: from eggs.gnu.org ([2001:4830:134:3::10]:45838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebEHW-0001ak-Vo
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 18:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebEHU-0002zc-EB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 18:35:11 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebEHU-0002yn-6u
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 18:35:08 -0500
Received: by mail-wr0-x242.google.com with SMTP id w50so13387305wrc.11
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 15:35:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 00:35:01 +0100
Message-Id: <1516059302-7169-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/53] cpu_physical_memory_sync_dirty_bitmap:
 Another alignment fix
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
unaligned version. My commit f70d345 fixed one alignment issue, but
there's another.

The optimised version operates on 'longs' dealing with (typically) 64
pages at a time, replacing the whole long by a 0 and counting the bits.
If the Ramblock is less than 64bits in length that long can contain bits
representing two different RAMBlocks, but the code will update the
bmap belinging to the 1st RAMBlock only while having updated the total
dirty page count for both.

This probably didn't matter prior to 6b6712ef which split the dirty
bitmap by RAMBlock, but now they're separate RAMBlocks we end up
with a count that doesn't match the state in the bitmaps.

Symptom:
  Migration showing a few dirty pages left to be sent constantly
  Seen on aarch64 and x86 with x86+ovmf

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Wei Huang <wei@redhat.com>
Fixes: 6b6712efccd383b48a909bee0b29e079a57601ec
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/ram_addr.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 6cbc02a..7633ef6 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -391,9 +391,10 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
     uint64_t num_dirty = 0;
     unsigned long *dest = rb->bmap;
 
-    /* start address is aligned at the start of a word? */
+    /* start address and length is aligned at the start of a word? */
     if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
-         (start + rb->offset)) {
+         (start + rb->offset) &&
+        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
         int k;
         int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
         unsigned long * const *src;
-- 
1.8.3.1
