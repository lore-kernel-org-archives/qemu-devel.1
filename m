Received: from eggs.gnu.org ([2001:4830:134:3::10]:48740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC3-00086H-MW
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC1-0000AP-TT
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55098
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC1-00009n-MG
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFT62011771
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:15 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epphvr2hy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:15 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:14 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:06 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-14-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 13/55] memory: Cleanup after switching to
 FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

We store AddressSpaceDispatch* in FlatView anyway so there is no need
to carry it from mem_add() to register_subpage/register_multipage.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-8-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 9950322a593ff900a860fb52938159461798a831)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index b561098df3..3e02b82c05 100644
--- a/exec.c
+++ b/exec.c
@@ -1303,9 +1303,9 @@ static void phys_sections_free(PhysPageMap *map)
     g_free(map->nodes);
 }
 
-static void register_subpage(FlatView *fv, AddressSpaceDispatch *d,
-                             MemoryRegionSection *section)
+static void register_subpage(FlatView *fv, MemoryRegionSection *section)
 {
+    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     subpage_t *subpage;
     hwaddr base = section->offset_within_address_space
         & TARGET_PAGE_MASK;
@@ -1334,9 +1334,10 @@ static void register_subpage(FlatView *fv, AddressSpaceDispatch *d,
 }
 
 
-static void register_multipage(AddressSpaceDispatch *d,
+static void register_multipage(FlatView *fv,
                                MemoryRegionSection *section)
 {
+    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     hwaddr start_addr = section->offset_within_address_space;
     uint16_t section_index = phys_section_add(&d->map, section);
     uint64_t num_pages = int128_get64(int128_rshift(section->size,
@@ -1348,7 +1349,6 @@ static void register_multipage(AddressSpaceDispatch *d,
 
 void mem_add(FlatView *fv, MemoryRegionSection *section)
 {
-    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
 
@@ -1357,7 +1357,7 @@ void mem_add(FlatView *fv, MemoryRegionSection *section)
                        - now.offset_within_address_space;
 
         now.size = int128_min(int128_make64(left), now.size);
-        register_subpage(fv, d, &now);
+        register_subpage(fv, &now);
     } else {
         now.size = int128_zero();
     }
@@ -1367,13 +1367,13 @@ void mem_add(FlatView *fv, MemoryRegionSection *section)
         remain.offset_within_region += int128_get64(now.size);
         now = remain;
         if (int128_lt(remain.size, page_size)) {
-            register_subpage(fv, d, &now);
+            register_subpage(fv, &now);
         } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
             now.size = page_size;
-            register_subpage(fv, d, &now);
+            register_subpage(fv, &now);
         } else {
             now.size = int128_and(now.size, int128_neg(page_size));
-            register_multipage(d, &now);
+            register_multipage(fv, &now);
         }
     }
 }
-- 
2.11.0
