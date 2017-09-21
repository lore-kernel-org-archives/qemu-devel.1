Received: from eggs.gnu.org ([2001:4830:134:3::10]:37456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiW-0004tj-8k
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiV-0004S1-2Z
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:12 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiU-0004Qs-RZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:10 -0400
Received: by mail-wm0-x241.google.com with SMTP id i131so6442735wma.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:10 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	u186sm2596278wmd.19.2017.09.21.16.17.08 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Sep 2017 16:17:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:30 +0200
Message-Id: <1506035800-30509-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/32] memory: trace FlatView creation and
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h   | 1 -
 include/qemu/typedefs.h | 1 +
 memory.c                | 3 +++
 trace-events            | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 402824c..5ed4042 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -48,7 +48,6 @@
 
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
-typedef struct FlatView FlatView;
 
 struct MemoryRegionMmio {
     CPUReadMemoryFunc *read[3];
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 1635502..980d2b3 100644
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
index 706c385..68cdf8b 100644
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
index 1f50f56..1d2eb5d 100644
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
1.8.3.1
