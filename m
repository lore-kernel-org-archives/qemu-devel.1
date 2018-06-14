Received: from eggs.gnu.org ([2001:4830:134:3::10]:48685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTGuX-0001Ij-72
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTGuS-0007jB-RE
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:49 -0400
Received: from mail-eopbgr700047.outbound.protection.outlook.com
	([40.107.70.47]:33423
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTGuS-0007i9-K2
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:44 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Wed, 13 Jun 2018 21:18:25 -0400
Message-Id: <1528939107-17193-5-git-send-email-babu.moger@amd.com>
In-Reply-To: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v14 4/6] cpus: Add new function
 topology_supports_topoext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, babu.moger@amd.com, kash@tripleback.net, geoff@hostfission.com

Add new function topology_supports_topoext to verify
if we can support topoext feature. Will be used to enable/disable
topoext feature.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 accel/tcg/user-exec-stub.c |  5 +++++
 cpus.c                     | 13 +++++++++++++
 include/qom/cpu.h          |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index dbcf1ad..715818a 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -11,6 +11,11 @@ void qemu_init_vcpu(CPUState *cpu)
 {
 }
 
+int topology_supports_topoext(int max_cores, int max_threads)
+{
+    return true;
+}
+
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
diff --git a/cpus.c b/cpus.c
index d1f1629..17f6f4c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1979,6 +1979,19 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
                        QEMU_THREAD_JOINABLE);
 }
 
+/*
+ * Check if we can support topoext feature with this topology
+ * Fail if number of cores are beyond the supported cores
+ * or number of threads are more than supported threads
+ */
+int topology_supports_topoext(int max_cores, int max_threads)
+{
+    if ((smp_cores > max_cores) || (smp_threads > max_threads)) {
+        return false;
+    }
+    return true;
+}
+
 void qemu_init_vcpu(CPUState *cpu)
 {
     cpu->nr_cores = smp_cores;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 9d3afc6..4ac4d49 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1004,6 +1004,15 @@ void end_exclusive(void);
  */
 void qemu_init_vcpu(CPUState *cpu);
 
+/**
+ * topology_supports_topoext:
+ * @max_cores: Max cores topoext feature can support
+ * @max_threads: Max threads topoext feature can support
+ *
+ * Return true if topology can be supported else return false
+ */
+int topology_supports_topoext(int max_cores, int max_threads);
+
 #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
 #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
 #define SSTEP_NOTIMER 0x4  /* Do not Timers while single stepping */
-- 
1.8.3.1
