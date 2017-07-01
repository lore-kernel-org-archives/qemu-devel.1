Received: from eggs.gnu.org ([2001:4830:134:3::10]:35615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benyux.xu@intel.com>) id 1dRJtT-0003s3-D7
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benyux.xu@intel.com>) id 1dRJtP-0003pX-9V
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:46592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benyux.xu@intel.com>) id 1dRJtO-0003nX-Uz
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:03 -0400
From: Benyu Xu <benyux.xu@intel.com>
Date: Sat,  1 Jul 2017 22:57:08 +0800
Message-Id: <1498921030-23255-2-git-send-email-benyux.xu@intel.com>
In-Reply-To: <1498921030-23255-1-git-send-email-benyux.xu@intel.com>
References: <1498921030-23255-1-git-send-email-benyux.xu@intel.com>
Subject: [Qemu-devel] [PATCH 1/3] add some vcpu-pin related functions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, gordon.jin@intel.com, eddie.dong@intel.com, kevin.tian@intel.com, haozhong.zhang@intel.com, hongbo.wang@intel.com, hao.l.li@intel.com, xudong.hao@intel.com, tianyu.lan@intel.com, binx.wu@intel.com, benyux.xu@intel.com, benjamin_xby@163.com

Signed-off-by: Benyu Xu <benyux.xu@intel.com>
---
 cpus.c                | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/qom/cpu.h     |   9 ++++
 include/sysemu/cpus.h |   2 +
 3 files changed, 137 insertions(+)

diff --git a/cpus.c b/cpus.c
index 14bb8d5..40c3abf 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1648,6 +1648,132 @@ void cpu_remove(CPUState *cpu)
     qemu_cpu_kick(cpu);
 }
 
+int get_pcpu_num(bool pin_auto, int *pcpu_id_array)
+{
+    int pcpu_num = 0;
+#ifdef _GNU_SOURCE
+    int pcpu_range = 1024;
+    int pcpu_id = 0;
+    int ret;
+    cpu_set_t *pcpu_set;
+    size_t setsize;
+
+    pcpu_set = CPU_ALLOC(pcpu_range);
+    if (pcpu_set == NULL) {
+        pcpu_num = -1;
+        return pcpu_num;
+    }
+
+    setsize = CPU_ALLOC_SIZE(pcpu_range);
+
+    for ( ; ; ) {
+        CPU_ZERO_S(setsize, pcpu_set);
+        ret = sched_getaffinity(0, setsize, pcpu_set);
+        if (ret < 0 && errno == EINVAL && pcpu_range < 131072) {
+            CPU_FREE(pcpu_set);
+            pcpu_range *= 2;
+            pcpu_set = CPU_ALLOC(pcpu_range);
+            if (pcpu_set == NULL) {
+                pcpu_num = -1;
+                return pcpu_num;
+            }
+            setsize = CPU_ALLOC_SIZE(pcpu_range);
+            continue;
+        }
+
+        if (ret == 0) {
+            for ( ; pcpu_id < 131072; pcpu_id++) {
+                if (CPU_ISSET_S(pcpu_id, setsize, pcpu_set)) {
+                    pcpu_num++;
+                    if (pin_auto == true) {
+                        pcpu_id_array[0] = pcpu_num;
+                        pcpu_id_array[pcpu_num] = pcpu_id;
+                    }
+                }
+            }
+            CPU_FREE(pcpu_set);
+            return pcpu_num;
+        }
+        CPU_FREE(pcpu_set);
+    }
+#else
+    pcpu_num = -2;
+    return pcpu_num;
+#endif
+}
+
+void cpu_pin(CPUState *cpu, int pcpu_id)
+{
+    cpu_set_t *pcpu_id_mask;
+    size_t masksize;
+    pid_t vcpu_pid;
+    int num_cpus;
+
+    if (pcpu_id == 0) {
+        num_cpus = pcpu_id + 1;
+    } else {
+        num_cpus = pcpu_id;
+    }
+
+    pcpu_id_mask = CPU_ALLOC(num_cpus);
+    if (pcpu_id_mask == NULL) {
+        error_report("warning: can not alloc cpu set! pcpu #%d",
+                      pcpu_id);
+        return ;
+    }
+    masksize = CPU_ALLOC_SIZE(num_cpus);
+    CPU_ZERO_S(masksize, pcpu_id_mask);
+    CPU_SET_S(pcpu_id, masksize, pcpu_id_mask);
+
+    vcpu_pid = cpu->thread_id;
+
+    if (sched_setaffinity(vcpu_pid, masksize, pcpu_id_mask) != 0) {
+        error_report("warning: set affinity failed! vcpu pid=%d, pcpu #%d",
+                      vcpu_pid, pcpu_id);
+        CPU_FREE(pcpu_id_mask);
+        return ;
+    }
+
+    if (sched_getaffinity(vcpu_pid, masksize, pcpu_id_mask) != 0) {
+        error_report("warning: get affinity failed! vcpu pid=%d, pcpu #%d",
+                      vcpu_pid, pcpu_id);
+        CPU_FREE(pcpu_id_mask);
+        return ;
+        }
+
+    CPU_FREE(pcpu_id_mask);
+}
+
+/* *
+ * pcpu_id_array: content the host processor's id array to pin
+ * pcpu_id_array[0]: the processor count
+ * pcpu_id_array[1...]: the processor id to pin
+ * */
+void pin_all_vcpus(int smp_cpus_num, const int *pcpu_id_array, Error **errp)
+{
+    int pcpu_id = 0;
+    int pcpu_num = pcpu_id_array[0];
+    int vcpu_id = 0;
+    CPUState *cpu;
+
+    if (pcpu_num <= 0) {
+        return;
+    }
+
+    if (smp_cpus_num > pcpu_num) {
+        error_setg(errp,
+                "pcpu id list only has %d pcpu(s), less than smp_cpus_num %d",
+                 pcpu_num, smp_cpus_num);
+        return;
+    }
+
+    CPU_FOREACH(cpu) {
+        pcpu_id = pcpu_id_array[vcpu_id + 1];
+        cpu_pin(cpu, pcpu_id);
+        vcpu_id++;
+    }
+}
+
 void cpu_remove_sync(CPUState *cpu)
 {
     cpu_remove(cpu);
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 89ddb68..8f14295 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -869,6 +869,15 @@ void cpu_exit(CPUState *cpu);
 void cpu_resume(CPUState *cpu);
 
 /**
+ * cpu_pin:
+ * @cpu: The vitual CPU to pin.
+ * @pcpu_id: The host's physical or logical processor's id.
+ *
+ * pin CPU, i.e. set the CPU's affinity.
+ */
+void cpu_pin(CPUState *cpu, int pcpu_id);
+
+/**
  * cpu_remove:
  * @cpu: The CPU to remove.
  *
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 731756d..513a0c6 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -7,6 +7,8 @@
 bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
 void resume_all_vcpus(void);
+int  get_pcpu_num(bool pin_default, int *pcpu_id_array);
+void pin_all_vcpus(int smp_cpu_num, const int *pcpu_id_array, Error **errp);
 void pause_all_vcpus(void);
 void cpu_stop_current(void);
 void cpu_ticks_init(void);
-- 
1.8.3.1
