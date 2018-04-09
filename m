Received: from eggs.gnu.org ([2001:4830:134:3::10]:50301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5WVy-0002ac-49
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5WVt-0008CB-16
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:07:18 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  9 Apr 2018 15:07:00 +0200
Message-Id: <20180409130700.5692-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] cpus: track calls to
 resume/pause_all_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, David Hildenbrand <david@redhat.com>

If we have parallel calls to resume/pause_all_vcpus() we can get
into trouble because the qemu mutex is temporarily dropped while
waiting for all threads to stop. This can happen e.g. for s390x, where
resume/pause_all_vcpus() can be triggered by a VCPU.

Pause/Resume exactly once, when we leave/hit "0".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 cpus.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/cpus.c b/cpus.c
index 2e6701795b..7c7e0245c5 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1778,17 +1778,26 @@ static bool all_vcpus_paused(void)
     return true;
 }
 
+/* wait for the initial vm_start() call */
+static int vcpus_paused = 1;
+
 void pause_all_vcpus(void)
 {
     CPUState *cpu;
 
-    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
-    CPU_FOREACH(cpu) {
-        if (qemu_cpu_is_self(cpu)) {
-            qemu_cpu_stop(cpu, true);
-        } else {
-            cpu->stop = true;
-            qemu_cpu_kick(cpu);
+    assert(qemu_mutex_iothread_locked());
+    assert(vcpus_paused >= 0);
+
+    vcpus_paused++;
+    if (vcpus_paused == 1) {
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
+        CPU_FOREACH(cpu) {
+            if (qemu_cpu_is_self(cpu)) {
+                qemu_cpu_stop(cpu, true);
+            } else {
+                cpu->stop = true;
+                qemu_cpu_kick(cpu);
+            }
         }
     }
 
@@ -1820,6 +1829,14 @@ void resume_all_vcpus(void)
 {
     CPUState *cpu;
 
+    assert(vcpus_paused >= 0);
+    assert(qemu_mutex_iothread_locked());
+
+    vcpus_paused--;
+    if (vcpus_paused > 0) {
+        return;
+    }
+
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
     CPU_FOREACH(cpu) {
         cpu_resume(cpu);
-- 
2.14.3
