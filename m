Received: from eggs.gnu.org ([2001:4830:134:3::10]:39063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dVGuo-0002Lv-7o
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dVGul-0007oU-75
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:38:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1dVGul-0007o7-0O
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:38:47 -0400
From: P J P <ppandit@redhat.com>
Date: Wed, 12 Jul 2017 18:08:40 +0530
Message-Id: <20170712123840.29328-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] exec: use qemu_ram_ptr_length to access guest
 ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex <broscutamaker@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When accessing guest's ram block during DMA operation, use
'qemu_ram_ptr_length' to get ram block pointer. It ensures
that DMA operation of given length is possible; And avoids
any OOB memory access situations.

Reported-by: Alex <broscutamaker@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index a083ff8..ad103ce 100644
--- a/exec.c
+++ b/exec.c
@@ -2929,7 +2929,7 @@ static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr addr,
             }
         } else {
             /* RAM case */
-            ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+            ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l);
             memcpy(ptr, buf, l);
             invalidate_and_set_dirty(mr, addr1, l);
         }
@@ -3020,7 +3020,7 @@ MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
             }
         } else {
             /* RAM case */
-            ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+            ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l);
             memcpy(buf, ptr, l);
         }
 
-- 
2.9.4
