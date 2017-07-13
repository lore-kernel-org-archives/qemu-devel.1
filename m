Received: from eggs.gnu.org ([2001:4830:134:3::10]:51218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3Q-0000zL-1I
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3L-0002Na-03
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:20 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3K-0002ME-Pf
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:14 -0400
Received: by mail-wr0-x244.google.com with SMTP id k67so9397810wrc.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:14 +0200
Message-Id: <1499955874-10954-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/41] exec: use qemu_ram_ptr_length to access
 guest ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When accessing guest's ram block during DMA operation, use
'qemu_ram_ptr_length' to get ram block pointer. It ensures
that DMA operation of given length is possible; And avoids
any OOB memory access situations.

Reported-by: Alex <broscutamaker@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <20170712123840.29328-1-ppandit@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
