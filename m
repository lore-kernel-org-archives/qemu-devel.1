Received: from eggs.gnu.org ([2001:4830:134:3::10]:48970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCD-0000R2-0Z
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC9-0000Kz-Rg
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55874
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC9-0000KV-LZ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:25 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFTLu011800
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:25 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epphvr2q8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:24 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:24 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:15 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-23-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 22/55] memory: trace FlatView creation and
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
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 02d9651d6a46479e9d70b72dca34e43605d06cda)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/exec/memory.h   | 1 -
 include/qemu/typedefs.h | 1 +
 memory.c                | 3 +++
 trace-events            | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 631daf0cce..234c71d975 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -48,7 +48,6 @@
 
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
-typedef struct FlatView FlatView;
 
 struct MemoryRegionMmio {
     CPUReadMemoryFunc *read[3];
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 39bc8351a3..d44dfc75ec 100644
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
index c1a64a9ca2..774a17f60a 100644
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
@@ -314,6 +316,7 @@ static bool flatview_ref(FlatView *view)
 static void flatview_unref(FlatView *view)
 {
     if (atomic_fetch_dec(&view->ref) == 1) {
+        trace_flatview_destroy_rcu(view, view->root);
         call_rcu(view, flatview_destroy, rcu);
     }
 }
diff --git a/trace-events b/trace-events
index 1f50f56d9d..1d2eb5d3e4 100644
--- a/trace-events
+++ b/trace-events
@@ -64,6 +64,9 @@ memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, unsigned siz
 memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+flatview_new(FlatView *view, MemoryRegion *root) "%p (root %p)"
+flatview_destroy(FlatView *view, MemoryRegion *root) "%p (root %p)"
+flatview_destroy_rcu(FlatView *view, MemoryRegion *root) "%p (root %p)"
 
 ### Guest events, keep at bottom
 
-- 
2.11.0
