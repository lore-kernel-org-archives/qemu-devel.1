Received: from eggs.gnu.org ([2001:4830:134:3::10]:47951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVJ-0004kq-Vv
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVJ-0006Bs-1K
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:41 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVI-0006BO-QX
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:40 -0500
Received: by mail-wm0-x244.google.com with SMTP id e194so3743636wmd.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:01 +0100
Message-Id: <1520342370-123606-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/34] cpus: wait for CPU creation at central
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We can now also wait for the CPU creation for single-threaded TCG, so we
can move the waiting bits further out.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180209195239.16048-3-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/cpus.c b/cpus.c
index 970390b..bcfc0a4 100644
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
1.8.3.1
