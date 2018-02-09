Received: from eggs.gnu.org ([2001:4830:134:3::10]:56707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ekEjC-0001LZ-1g
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ekEj7-0002yN-64
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ekEj7-0002xv-0G
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:53 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Feb 2018 20:52:38 +0100
Message-Id: <20180209195239.16048-3-david@redhat.com>
In-Reply-To: <20180209195239.16048-1-david@redhat.com>
References: <20180209195239.16048-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/3] cpus: wait for CPU creation at central
 place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

We can now also wait for the CPU creation for single-threaded TCG, so we
can move the waiting bits further out.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 cpus.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/cpus.c b/cpus.c
index ade1651032..22ab15840f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1856,9 +1856,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
 #ifdef _WIN32
         cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
-        while (!cpu->created) {
-            qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-        }
     } else {
         /* For non-MTTCG cases we share the thread */
         cpu->thread = single_tcg_cpu_thread;
@@ -1884,9 +1881,6 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
-    while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-    }
 }
 
 static void qemu_kvm_start_vcpu(CPUState *cpu)
@@ -1900,9 +1894,6 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
                        cpu, QEMU_THREAD_JOINABLE);
-    while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-    }
 }
 
 static void qemu_hvf_start_vcpu(CPUState *cpu)
@@ -1921,9 +1912,6 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
                        cpu, QEMU_THREAD_JOINABLE);
-    while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-    }
 }
 
 static void qemu_whpx_start_vcpu(CPUState *cpu)
@@ -1940,9 +1928,6 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
-    while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-    }
 }
 
 static void qemu_dummy_start_vcpu(CPUState *cpu)
@@ -1956,9 +1941,6 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn, cpu,
                        QEMU_THREAD_JOINABLE);
-    while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-    }
 }
 
 void qemu_init_vcpu(CPUState *cpu)
@@ -1988,6 +1970,10 @@ void qemu_init_vcpu(CPUState *cpu)
     } else {
         qemu_dummy_start_vcpu(cpu);
     }
+
+    while (!cpu->created) {
+        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+    }
 }
 
 void cpu_stop_current(void)
-- 
2.14.3
