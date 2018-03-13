Received: from eggs.gnu.org ([2001:4830:134:3::10]:46930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robinhe@robinhe-hp.sh.intel.com>) id 1ewSu7-0006cx-PX
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robinhe@robinhe-hp.sh.intel.com>) id 1ewSu4-0004ns-Hu
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:26:47 -0400
Received: from [112.64.68.174] (port=39093 helo=robinhe-hp.sh.intel.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robinhe@robinhe-hp.sh.intel.com>)
	id 1ewSu3-0004ks-KR
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:26:44 -0400
From: junyan.he@intel.com
Date: Tue, 13 Mar 2018 16:33:47 +0800
Message-Id: <1520930033-18885-5-git-send-email-junyan.he@intel.com>
In-Reply-To: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
References: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
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
