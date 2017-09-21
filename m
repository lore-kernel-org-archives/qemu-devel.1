Received: from eggs.gnu.org ([2001:4830:134:3::10]:48589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCw-0005Cc-Im
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCv-0001Q2-Jj
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:42 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCv-0001CA-Dp
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:41 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:51:10 +1000
Message-Id: <20170921085110.25598-19-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 18/18] memory: Avoid temporary FlatView
 allocation in a single child case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

The root MR may be enabled but the only child may be not (this is
the case for the PCI bus master address space) so check this and avoid
allocating temporary FV if that nested MR is not enabled.

This does not make any difference though.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/memory.c b/memory.c
index 5c21563745..bf71f19fec 100644
--- a/memory.c
+++ b/memory.c
@@ -748,9 +748,14 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
     int i;
     FlatView *view;
     bool use_empty = false;
+    MemoryRegion *child = QTAILQ_FIRST(&mr->subregions);
 
     if (!mr->enabled) {
         use_empty = true;
+    } else if (child && !child->enabled &&
+               !QTAILQ_NEXT(child, subregions_link) &&
+               !child->addr && int128_eq(child->size, mr->size)) {
+        use_empty = true;
     } else {
         view = flatview_new(mr);
         if (mr) {
-- 
2.11.0
