Received: from eggs.gnu.org ([2001:4830:134:3::10]:59492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBa-0006Rm-4M
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBY-0004F0-Be
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBY-0004EC-6V
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF1E77D83A
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:23 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BED563F50
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:16:06 +0200
Message-Id: <20180531171606.21604-15-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 53/53] memory: Make operations using
 MemoryRegionIoeventfd struct pass by pointer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Tristan Burgess <tburgessdev@gmail.com>

This changes the functions memory_region_ioeventfd_equal, memory_region_ioeventfd_before, and their callers,
to pass the MemoryRegionIoeventfd struct via pointer, instead of directly passing the struct. This saves on stack space
and is considered safe practice.

Signed-off-by: Tristan Burgess <tburgessdev@gmail.com>
Message-Id: <20180529030445.177867-1-tburgessdev@gmail.com>
Fixes: Launchpad bug 1720969
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/memory.c b/memory.c
index e4f484b73e..af88b12bab 100644
--- a/memory.c
+++ b/memory.c
@@ -172,38 +172,38 @@ struct MemoryRegionIoeventfd {
     EventNotifier *e;
 };
 
-static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd a,
-                                           MemoryRegionIoeventfd b)
+static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd *a,
+                                           MemoryRegionIoeventfd *b)
 {
-    if (int128_lt(a.addr.start, b.addr.start)) {
+    if (int128_lt(a->addr.start, b->addr.start)) {
         return true;
-    } else if (int128_gt(a.addr.start, b.addr.start)) {
+    } else if (int128_gt(a->addr.start, b->addr.start)) {
         return false;
-    } else if (int128_lt(a.addr.size, b.addr.size)) {
+    } else if (int128_lt(a->addr.size, b->addr.size)) {
         return true;
-    } else if (int128_gt(a.addr.size, b.addr.size)) {
+    } else if (int128_gt(a->addr.size, b->addr.size)) {
         return false;
-    } else if (a.match_data < b.match_data) {
+    } else if (a->match_data < b->match_data) {
         return true;
-    } else  if (a.match_data > b.match_data) {
+    } else  if (a->match_data > b->match_data) {
         return false;
-    } else if (a.match_data) {
-        if (a.data < b.data) {
+    } else if (a->match_data) {
+        if (a->data < b->data) {
             return true;
-        } else if (a.data > b.data) {
+        } else if (a->data > b->data) {
             return false;
         }
     }
-    if (a.e < b.e) {
+    if (a->e < b->e) {
         return true;
-    } else if (a.e > b.e) {
+    } else if (a->e > b->e) {
         return false;
     }
     return false;
 }
 
-static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd a,
-                                          MemoryRegionIoeventfd b)
+static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd *a,
+                                          MemoryRegionIoeventfd *b)
 {
     return !memory_region_ioeventfd_before(a, b)
         && !memory_region_ioeventfd_before(b, a);
@@ -788,8 +788,8 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
     while (iold < fds_old_nb || inew < fds_new_nb) {
         if (iold < fds_old_nb
             && (inew == fds_new_nb
-                || memory_region_ioeventfd_before(fds_old[iold],
-                                                  fds_new[inew]))) {
+                || memory_region_ioeventfd_before(&fds_old[iold],
+                                                  &fds_new[inew]))) {
             fd = &fds_old[iold];
             section = (MemoryRegionSection) {
                 .fv = address_space_to_flatview(as),
@@ -801,8 +801,8 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
             ++iold;
         } else if (inew < fds_new_nb
                    && (iold == fds_old_nb
-                       || memory_region_ioeventfd_before(fds_new[inew],
-                                                         fds_old[iold]))) {
+                       || memory_region_ioeventfd_before(&fds_new[inew],
+                                                         &fds_old[iold]))) {
             fd = &fds_new[inew];
             section = (MemoryRegionSection) {
                 .fv = address_space_to_flatview(as),
@@ -1440,7 +1440,7 @@ static bool memory_region_dispatch_write_eventfds(MemoryRegion *mr,
         ioeventfd.match_data = mr->ioeventfds[i].match_data;
         ioeventfd.e = mr->ioeventfds[i].e;
 
-        if (memory_region_ioeventfd_equal(ioeventfd, mr->ioeventfds[i])) {
+        if (memory_region_ioeventfd_equal(&ioeventfd, &mr->ioeventfds[i])) {
             event_notifier_set(ioeventfd.e);
             return true;
         }
@@ -2210,7 +2210,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
-        if (memory_region_ioeventfd_before(mrfd, mr->ioeventfds[i])) {
+        if (memory_region_ioeventfd_before(&mrfd, &mr->ioeventfds[i])) {
             break;
         }
     }
@@ -2245,7 +2245,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
-        if (memory_region_ioeventfd_equal(mrfd, mr->ioeventfds[i])) {
+        if (memory_region_ioeventfd_equal(&mrfd, &mr->ioeventfds[i])) {
             break;
         }
     }
-- 
2.17.0
