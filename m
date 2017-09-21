Received: from eggs.gnu.org ([2001:4830:134:3::10]:39281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0Gt-0002H9-G9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0Gp-00023t-CH
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv0Gp-000225-5o
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:07:55 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Sep 2017 14:07:49 +0200
Message-Id: <20170921120751.3027-2-pbonzini@redhat.com>
In-Reply-To: <20170921120751.3027-1-pbonzini@redhat.com>
References: <20170921120751.3027-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] memory: trace FlatView creation and
 destruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h   | 1 -
 include/qemu/typedefs.h | 1 +
 memory.c                | 3 +++
 trace-events            | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 402824c6f2..5ed4042f87 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -48,7 +48,6 @@
 
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
-typedef struct FlatView FlatView;
 
 struct MemoryRegionMmio {
     CPUReadMemoryFunc *read[3];
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 163550214c..980d2b330e 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -30,6 +30,7 @@ typedef struct DisplaySurface DisplaySurface;
 typedef struct DriveInfo DriveInfo;
 typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
+typedef struct FlatView FlatView;
 typedef struct FWCfgEntry FWCfgEntry;
 typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
diff --git a/memory.c b/memory.c
index a26adca4d3..4952cc5d84 100644
--- a/memory.c
+++ b/memory.c
@@ -270,6 +270,7 @@ static FlatView *flatview_new(MemoryRegion *mr_root)
     view->ref = 1;
     view->root = mr_root;
     memory_region_ref(mr_root);
+    trace_flatview_new(view, mr_root);
 
     return view;
 }
@@ -295,6 +296,7 @@ static void flatview_destroy(FlatView *view)
 {
     int i;
 
+    trace_flatview_destroy(view, view->root);
     if (view->dispatch) {
         address_space_dispatch_free(view->dispatch);
     }
diff --git a/trace-events b/trace-events
index 1f50f56d9d..1d2eb5d3e4 100644
--- a/trace-events
+++ b/trace-events
@@ -64,6 +64,8 @@ memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, unsigned siz
 memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+flatview_new(FlatView *view, MemoryRegion *root) "%p (root %p)"
+flatview_destroy(FlatView *view, MemoryRegion *root) "%p (root %p)"
 
 ### Guest events, keep at bottom
 
-- 
2.13.5
