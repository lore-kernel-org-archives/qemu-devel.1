Received: from eggs.gnu.org ([2001:4830:134:3::10]:41703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d8Df7-0001jL-25
	for qemu-devel@nongnu.org; Tue, 09 May 2017 18:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d8Df1-0002LD-Su
	for qemu-devel@nongnu.org; Tue, 09 May 2017 18:31:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:36913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1d8Df1-0002Kr-KO
	for qemu-devel@nongnu.org; Tue, 09 May 2017 18:31:15 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Tue,  9 May 2017 15:37:12 -0700
Message-Id: <1494369432-15418-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH] trace: add sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, Anthony Xu <anthony.xu@intel.com>

If trace backend is set to TRACE_NOP, trace_get_vcpu_event_count
returns 0, cause bitmap_new call abort.

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
---
 qom/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index f02e9c0..f9111a0 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -382,6 +382,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
 
 static void cpu_common_initfn(Object *obj)
 {
+    uint32_t count;
     CPUState *cpu = CPU(obj);
     CPUClass *cc = CPU_GET_CLASS(obj);
 
@@ -396,7 +397,10 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
-    cpu->trace_dstate = bitmap_new(trace_get_vcpu_event_count());
+    count = trace_get_vcpu_event_count();
+    if (count) {
+        cpu->trace_dstate = bitmap_new(count);
+    }
 
     cpu_exec_initfn(cpu);
 }
-- 
1.8.3.1
