Received: from eggs.gnu.org ([2001:4830:134:3::10]:35232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcL-0004SU-7X
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcI-0004Wb-5F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:09 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Mar 2018 09:36:55 +0100
Message-Id: <20180305083655.6186-8-pbonzini@redhat.com>
In-Reply-To: <20180305083655.6186-1-pbonzini@redhat.com>
References: <20180305083655.6186-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] address_space_rw:
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

address_space_rw is calling address_space_to_flatview but it can
be called outside the RCU lock.  To fix it, transform flatview_rw
into address_space_rw, since flatview_rw is otherwise unused.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/exec.c b/exec.c
index 070eaff3e7..8a99114c69 100644
--- a/exec.c
+++ b/exec.c
@@ -3177,24 +3177,6 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                   addr1, l, mr);
 }
 
-static MemTxResult flatview_rw(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                               uint8_t *buf, int len, bool is_write)
-{
-    if (is_write) {
-        return flatview_write(fv, addr, attrs, (uint8_t *)buf, len);
-    } else {
-        return flatview_read(fv, addr, attrs, (uint8_t *)buf, len);
-    }
-}
-
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
-                             MemTxAttrs attrs, uint8_t *buf,
-                             int len, bool is_write)
-{
-    return flatview_rw(address_space_to_flatview(as),
-                       addr, attrs, buf, len, is_write);
-}
-
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, uint8_t *buf, int len)
 {
@@ -3228,6 +3210,16 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
     return result;
 }
 
+MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
+                             uint8_t *buf, int len, bool is_write)
+{
+    if (is_write) {
+        return address_space_write(as, addr, attrs, buf, len);
+    } else {
+        return address_space_read_full(as, addr, attrs, buf, len);
+    }
+}
+
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write)
 {
-- 
2.14.3
