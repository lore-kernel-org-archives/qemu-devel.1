Received: from eggs.gnu.org ([2001:4830:134:3::10]:35189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcH-0004Of-Pi
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcG-0004VC-VN
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:05 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Mar 2018 09:36:54 +0100
Message-Id: <20180305083655.6186-7-pbonzini@redhat.com>
In-Reply-To: <20180305083655.6186-1-pbonzini@redhat.com>
References: <20180305083655.6186-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] address_space_map:
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

address_space_map is calling address_space_to_flatview but it can
be called outside the RCU lock.  The function itself is calling
rcu_read_lock/rcu_read_unlock, just in the wrong place, so the
fix is easy.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 177583c2ee..070eaff3e7 100644
--- a/exec.c
+++ b/exec.c
@@ -3464,7 +3464,7 @@ void *address_space_map(AddressSpace *as,
     hwaddr l, xlat;
     MemoryRegion *mr;
     void *ptr;
-    FlatView *fv = address_space_to_flatview(as);
+    FlatView *fv;
 
     if (len == 0) {
         return NULL;
@@ -3472,6 +3472,7 @@ void *address_space_map(AddressSpace *as,
 
     l = len;
     rcu_read_lock();
+    fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write);
 
     if (!memory_access_is_direct(mr, is_write)) {
-- 
2.14.3
