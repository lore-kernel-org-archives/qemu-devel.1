Received: from eggs.gnu.org ([2001:4830:134:3::10]:48257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1deplb-0005Jv-N1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1deplW-0006Xj-RP
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1deplW-0006XM-Ij
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:46 -0400
Date: Tue, 8 Aug 2017 00:40:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1502142009-9370-3-git-send-email-mst@redhat.com>
References: <1502142009-9370-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502142009-9370-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] cpu: add APIs to allocate/free CPU
 environment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>

These will be implemented and then used by follow-up patches.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qom/cpu.h | 31 +++++++++++++++++++++++++++++++
 qom/cpu.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 25eefea..e9d30c5 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -162,6 +162,10 @@ typedef struct CPUClass {
     void (*dump_statistics)(CPUState *cpu, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
     int64_t (*get_arch_id)(CPUState *cpu);
+    void * (*alloc_env)(CPUState *cpu);
+    void (*get_env)(CPUState *cpu, void *env);
+    void (*set_env)(CPUState *cpu, void *env);
+    void (*free_env)(CPUState *cpu, void *env);
     bool (*get_paging_enabled)(const CPUState *cpu);
     void (*get_memory_mapping)(CPUState *cpu, MemoryMappingList *list,
                                Error **errp);
@@ -440,6 +444,33 @@ extern bool mttcg_enabled;
 #define qemu_tcg_mttcg_enabled() (mttcg_enabled)
 
 /**
+ * cpu_alloc_env: allocate CPU environment structure
+ * @cpu: allocate environment structure for this CPU
+ */
+void *cpu_alloc_env(CPUState *cpu);
+
+/**
+ * cpu_get_env: retrieve CPU environment structure
+ * @cpu: CPU to use
+ * @env: environment structure to use
+ */
+void cpu_get_env(CPUState *cpu, void *env);
+
+/**
+ * cpu_set_env: switch to given CPU environment
+ * @cpu: CPU to use
+ * @env: environment structure to use
+ */
+void cpu_set_env(CPUState *cpu, void *env);
+
+/**
+ * cpu_free_env: free CPU environment structure
+ * @cpu: free environment structure for this CPU
+ * @env: structure to free
+ */
+void cpu_free_env(CPUState *cpu, void *env);
+
+/**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
  *
diff --git a/qom/cpu.c b/qom/cpu.c
index 4f38db0..9201fd9 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -89,6 +89,40 @@ out:
     return cpu;
 }
 
+void *cpu_alloc_env(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    return cc->alloc_env ? cc->alloc_env(cpu) : NULL;
+}
+
+void cpu_get_env(CPUState *cpu, void *env)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->get_env) {
+        cc->get_env(cpu, env);
+    }
+}
+
+void cpu_set_env(CPUState *cpu, void *env)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->set_env) {
+        cc->set_env(cpu, env);
+    }
+}
+
+void cpu_free_env(CPUState *cpu, void *env)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->free_env) {
+        cc->free_env(cpu, env);
+    }
+}
+
 bool cpu_paging_enabled(const CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-- 
MST
