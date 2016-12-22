Received: from eggs.gnu.org ([2001:4830:134:3::10]:37658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D7-0007JY-Np
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D2-000769-Eg
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5D2-00075n-99
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:08 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81EA1C0586AA
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:07 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xG027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:06 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:38 +0100
Message-Id: <20161222152300.32395-4-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/25] exec: introduce
 address_space_extend_translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This extracts the common part of address_space_map and
address_space_cache_init into a new function.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/exec.c b/exec.c
index 8568a6f..d4b3656 100644
--- a/exec.c
+++ b/exec.c
@@ -2938,6 +2938,31 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
     return true;
 }
 
+static hwaddr
+address_space_extend_translation(AddressSpace *as, hwaddr addr, hwaddr target_len,
+                                 MemoryRegion *mr, hwaddr base, hwaddr len,
+                                 bool is_write)
+{
+    hwaddr done = 0;
+    hwaddr xlat;
+    MemoryRegion *this_mr;
+
+    for (;;) {
+        target_len -= len;
+        addr += len;
+        done += len;
+        if (target_len == 0) {
+            return done;
+        }
+
+        len = target_len;
+        this_mr = address_space_translate(as, addr, &xlat, &len, is_write);
+        if (this_mr != mr || xlat != base + done) {
+            return done;
+        }
+    }
+}
+
 /* Map a physical memory region into a host virtual address.
  * May map a subset of the requested range, given by and returned in *plen.
  * May return NULL if resources needed to perform the mapping are exhausted.
@@ -2951,9 +2976,8 @@ void *address_space_map(AddressSpace *as,
                         bool is_write)
 {
     hwaddr len = *plen;
-    hwaddr done = 0;
-    hwaddr l, xlat, base;
-    MemoryRegion *mr, *this_mr;
+    hwaddr l, xlat;
+    MemoryRegion *mr;
     void *ptr;
 
     if (len == 0) {
@@ -2987,26 +3011,10 @@ void *address_space_map(AddressSpace *as,
         return bounce.buffer;
     }
 
-    base = xlat;
-
-    for (;;) {
-        len -= l;
-        addr += l;
-        done += l;
-        if (len == 0) {
-            break;
-        }
-
-        l = len;
-        this_mr = address_space_translate(as, addr, &xlat, &l, is_write);
-        if (this_mr != mr || xlat != base + done) {
-            break;
-        }
-    }
 
     memory_region_ref(mr);
-    *plen = done;
-    ptr = qemu_ram_ptr_length(mr->ram_block, base, plen);
+    *plen = address_space_extend_translation(as, addr, len, mr, xlat, l, is_write);
+    ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen);
     rcu_read_unlock();
 
     return ptr;
-- 
2.9.3
