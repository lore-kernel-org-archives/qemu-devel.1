Received: from eggs.gnu.org ([2001:4830:134:3::10]:42127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZN-00082u-Lt
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZI-00062p-Ny
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:21 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:43338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZI-00061q-IS
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:16 -0500
Received: by mail-wm0-x241.google.com with SMTP id g1so11401468wmg.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:12 +0100
Message-Id: <1515756676-3860-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 48/52] find_ram_offset: Align ram_addr_t
 allocation on long boundaries
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

The dirty bitmaps are built from 'long's and there is fast-path code
for synchronising the case where the RAMBlock is aligned to the start
of a long boundary.  Align the allocation to this boundary
to cause the fast path to be used.

Offsets before change:
11398@1515169675.018566:find_ram_offset size: 0x1e0000 @ 0x8000000
11398@1515169675.020064:find_ram_offset size: 0x20000 @ 0x81e0000
11398@1515169675.020244:find_ram_offset size: 0x20000 @ 0x8200000
11398@1515169675.024343:find_ram_offset size: 0x1000000 @ 0x8220000
11398@1515169675.025154:find_ram_offset size: 0x10000 @ 0x9220000
11398@1515169675.027682:find_ram_offset size: 0x40000 @ 0x9230000
11398@1515169675.032921:find_ram_offset size: 0x200000 @ 0x9270000
11398@1515169675.033307:find_ram_offset size: 0x1000 @ 0x9470000
11398@1515169675.033601:find_ram_offset size: 0x1000 @ 0x9471000

after change:
10923@1515169108.818245:find_ram_offset size: 0x1e0000 @ 0x8000000
10923@1515169108.819410:find_ram_offset size: 0x20000 @ 0x8200000
10923@1515169108.819587:find_ram_offset size: 0x20000 @ 0x8240000
10923@1515169108.823708:find_ram_offset size: 0x1000000 @ 0x8280000
10923@1515169108.824503:find_ram_offset size: 0x10000 @ 0x9280000
10923@1515169108.827093:find_ram_offset size: 0x40000 @ 0x92c0000
10923@1515169108.833045:find_ram_offset size: 0x200000 @ 0x9300000
10923@1515169108.833504:find_ram_offset size: 0x1000 @ 0x9500000
10923@1515169108.833787:find_ram_offset size: 0x1000 @ 0x9540000

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180105170138.23357-3-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/exec.c b/exec.c
index 5e2fb55..9f4f450 100644
--- a/exec.c
+++ b/exec.c
@@ -1678,7 +1678,11 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
     RAMBLOCK_FOREACH(block) {
         ram_addr_t candidate, next = RAM_ADDR_MAX;
 
+        /* Align blocks to start on a 'long' in the bitmap
+         * which makes the bitmap sync'ing take the fast path.
+         */
         candidate = block->offset + block->max_length;
+        candidate = ROUND_UP(candidate, BITS_PER_LONG << TARGET_PAGE_BITS);
 
         /* Search for the closest following block
          * and find the gap.
-- 
1.8.3.1
