Received: from eggs.gnu.org ([2001:4830:134:3::10]:35165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcG-0004NT-C8
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcF-0004T4-Jz
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:04 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Mar 2018 09:36:53 +0100
Message-Id: <20180305083655.6186-6-pbonzini@redhat.com>
In-Reply-To: <20180305083655.6186-1-pbonzini@redhat.com>
References: <20180305083655.6186-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] address_space_access_valid:
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
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-stable@nongnu.org

address_space_access_valid is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, push the rcu_read_lock/unlock
pair up from flatview_access_valid to address_space_access_valid.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 55b7452bd7..177583c2ee 100644
--- a/exec.c
+++ b/exec.c
@@ -3391,7 +3391,6 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
     MemoryRegion *mr;
     hwaddr l, xlat;
 
-    rcu_read_lock();
     while (len > 0) {
         l = len;
         mr = flatview_translate(fv, addr, &xlat, &l, is_write);
@@ -3406,15 +3405,20 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
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
2.14.3
