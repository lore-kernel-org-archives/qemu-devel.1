Received: from eggs.gnu.org ([2001:4830:134:3::10]:60716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJf-0006jS-9O
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJb-0000kW-Bg
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csXJb-0000jG-5G
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:19 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Mar 2017 18:16:07 +0200
Message-Id: <20170327161615.19637-2-pbonzini@redhat.com>
In-Reply-To: <20170327161615.19637-1-pbonzini@redhat.com>
References: <20170327161615.19637-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] clear pending status before calling memory
 commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Xu, Anthony" <anthony.xu@intel.com>

From: "Xu, Anthony" <anthony.xu@intel.com>

clear pending status before calling memory commit.
Otherwise when memory_region_finalize is called,
memory_region_transaction_depth is 0 and
memory_region_update_pending is true.
That's wrong.

Signed-off -by: Anthony Xu <anthony.xu@intel.com>

Message-Id: <4712D8F4B26E034E80552F30A67BE0B1A2E3D5@ORSMSX112.amr.corp.intel.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/memory.c b/memory.c
index 64b0a60..4c95aaf 100644
--- a/memory.c
+++ b/memory.c
@@ -906,12 +906,6 @@ void memory_region_transaction_begin(void)
     ++memory_region_transaction_depth;
 }
 
-static void memory_region_clear_pending(void)
-{
-    memory_region_update_pending = false;
-    ioeventfd_update_pending = false;
-}
-
 void memory_region_transaction_commit(void)
 {
     AddressSpace *as;
@@ -927,14 +921,14 @@ void memory_region_transaction_commit(void)
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_update_topology(as);
             }
-
+            memory_region_update_pending = false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
         } else if (ioeventfd_update_pending) {
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_update_ioeventfds(as);
             }
+            ioeventfd_update_pending = false;
         }
-        memory_region_clear_pending();
    }
 }
 
-- 
2.9.3
