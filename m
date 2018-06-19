Received: from eggs.gnu.org ([2001:4830:134:3::10]:45638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hp-0001Px-Ji
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ho-0008Jd-Mt
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:13 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:57 -0500
Message-Id: <20180619014319.28272-32-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 031/113] address_space_access_valid:
 address_space_to_flatview needs RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

address_space_access_valid is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
pair up from flatview_access_valid to address_space_access_valid.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 11e732a5ed46903f997985bed4c3767ca28a7eb6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 7e3c5c67f0..7c4fb68368 100644
--- a/exec.c
+++ b/exec.c
@@ -3322,7 +3322,6 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
     MemoryRegion *mr;
     hwaddr l, xlat;
 
-    rcu_read_lock();
     while (len > 0) {
         l = len;
         mr = flatview_translate(fv, addr, &xlat, &l, is_write);
@@ -3337,15 +3336,20 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
         len -= l;
         addr += l;
     }
-    rcu_read_unlock();
     return true;
 }
 
 bool address_space_access_valid(AddressSpace *as, hwaddr addr,
                                 int len, bool is_write)
 {
-    return flatview_access_valid(address_space_to_flatview(as),
-                                 addr, len, is_write);
+    FlatView *fv;
+    bool result;
+
+    rcu_read_lock();
+    fv = address_space_to_flatview(as);
+    result = flatview_access_valid(fv, addr, len, is_write);
+    rcu_read_unlock();
+    return result;
 }
 
 static hwaddr
-- 
2.11.0
