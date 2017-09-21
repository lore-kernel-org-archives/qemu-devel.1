Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiP-0004mF-GJ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiO-0004Ik-LY
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:05 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiO-0004HN-FP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:04 -0400
Received: by mail-wr0-x244.google.com with SMTP id n64so3849050wrb.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:24 +0200
Message-Id: <1506035800-30509-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/32] memory: Move
 address_space_update_ioeventfds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

So it is called (twice) from the same function. This is to make the next
patches a bit simpler.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-12-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 6f6c233..bb582d0 100644
--- a/memory.c
+++ b/memory.c
@@ -952,8 +952,6 @@ static void address_space_update_topology(AddressSpace *as)
      * counting is necessary.
      */
     flatview_unref(old_view);
-
-    address_space_update_ioeventfds(as);
 }
 
 void memory_region_transaction_begin(void)
@@ -976,6 +974,7 @@ void memory_region_transaction_commit(void)
 
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_update_topology(as);
+                address_space_update_ioeventfds(as);
             }
             memory_region_update_pending = false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
-- 
1.8.3.1
