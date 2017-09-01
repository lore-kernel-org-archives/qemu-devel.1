Received: from eggs.gnu.org ([2001:4830:134:3::10]:40701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTn-0007mw-9l
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTi-0002sM-Mj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnTi-0002s7-HG
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:02:50 -0300
Message-Id: <20170901150317.10380-3-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/29] cpu: cpu_by_arch_id() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

The helper can be used for CPU object lookup using the CPU's
arch-specific ID (the one returned by CPUClass::get_arch_id()).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
[Yi Wang: Added documentation comments]
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
[ehabkost: extracted cpu_by_arch_id() to a separate patch]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/cpu.h | 10 ++++++++++
 qom/cpu.c         | 11 ++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 25eefea7ab..b7ac9491c8 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -755,6 +755,16 @@ CPUState *qemu_get_cpu(int index);
 bool cpu_exists(int64_t id);
 
 /**
+ * cpu_by_arch_id:
+ * @id: Guest-exposed CPU ID of the CPU to obtain.
+ *
+ * Get a CPU with matching @id.
+ *
+ * Returns: The CPU or %NULL if there is no matching CPU.
+ */
+CPUState *cpu_by_arch_id(int64_t id);
+
+/**
  * cpu_throttle_set:
  * @new_throttle_pct: Percent of sleep time. Valid range is 1 to 99.
  *
diff --git a/qom/cpu.c b/qom/cpu.c
index 4f38db0dac..e6210d5949 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -34,7 +34,7 @@
 
 CPUInterruptHandler cpu_interrupt_handler;
 
-bool cpu_exists(int64_t id)
+CPUState *cpu_by_arch_id(int64_t id)
 {
     CPUState *cpu;
 
@@ -42,10 +42,15 @@ bool cpu_exists(int64_t id)
         CPUClass *cc = CPU_GET_CLASS(cpu);
 
         if (cc->get_arch_id(cpu) == id) {
-            return true;
+            return cpu;
         }
     }
-    return false;
+    return NULL;
+}
+
+bool cpu_exists(int64_t id)
+{
+    return !!cpu_by_arch_id(id);
 }
 
 CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
-- 
2.13.5
