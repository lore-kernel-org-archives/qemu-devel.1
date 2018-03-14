Received: from eggs.gnu.org ([2001:4830:134:3::10]:36344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5j-0000Mw-TH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5j-0006Pb-0G
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:28906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@hotmail.com>)
	id 1evv5i-0006Hx-Jt
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:30 -0400
From: junyan.he@hotmail.com
Date: Wed, 14 Mar 2018 09:20:12 +0800
Message-Id: <1520990418-28258-5-git-send-email-junyan.he@hotmail.com>
In-Reply-To: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
References: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
Subject: [Qemu-devel] [PATCH 04/10] RFC: Set memory_region_set_log available
 for more client.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

We need to collect dirty log for nvdimm kind memory, need to enable
memory_region_set_log for more clients rather than just VGA.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 memory.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/memory.c b/memory.c
index e70b64b..4a8a2fe 100644
--- a/memory.c
+++ b/memory.c
@@ -1921,11 +1921,12 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
     uint8_t mask = 1 << client;
     uint8_t old_logging;
 
-    assert(client == DIRTY_MEMORY_VGA);
-    old_logging = mr->vga_logging_count;
-    mr->vga_logging_count += log ? 1 : -1;
-    if (!!old_logging == !!mr->vga_logging_count) {
-        return;
+    if (client == DIRTY_MEMORY_VGA) {
+        old_logging = mr->vga_logging_count;
+        mr->vga_logging_count += log ? 1 : -1;
+        if (!!old_logging == !!mr->vga_logging_count) {
+            return;
+        }
     }
 
     memory_region_transaction_begin();
-- 
2.7.4
