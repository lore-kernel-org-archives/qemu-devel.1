Received: from eggs.gnu.org ([2001:4830:134:3::10]:53815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHJs-0003kh-Mx
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHJr-0000cV-IO
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZHJq-0000bk-Vh
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:25:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0917E50F58
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 14:25:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Jan 2018 15:25:15 +0100
Message-Id: <20180110142515.13242-3-pbonzini@redhat.com>
In-Reply-To: <20180110142515.13242-1-pbonzini@redhat.com>
References: <20180110142515.13242-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] find_ram_offset: Align ram_addr_t
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
Cc: dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com

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
index 829f9d8d1a..c543b54094 100644
--- a/exec.c
+++ b/exec.c
@@ -1679,7 +1679,11 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
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
2.14.3
