Received: from eggs.gnu.org ([2001:4830:134:3::10]:42910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRQJN-0005BH-7E
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRQJJ-0002qh-2r
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:56:49 -0400
Received: from mail-bl2nam02on0076.outbound.protection.outlook.com
	([104.47.38.76]:45120
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fRQJI-0002qK-S2
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:56:45 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Fri,  8 Jun 2018 18:56:20 -0400
Message-Id: <1528498581-131037-5-git-send-email-babu.moger@amd.com>
In-Reply-To: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v13 4/5] i386: Verify and enable topoext
 feature if supported
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

If the CPU model supports topoext feature, enabled the
feature automatically if it can be supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4dd9a82..88bc73d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4763,6 +4763,33 @@ static int x86_cpu_filter_features(X86CPU *cpu)
 #define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
                          (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
                          (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+/*
+ * Check if we can support this topology
+ * Fail if number of cores are beyond the supported config
+ * or nr_threads is more than 2
+ */
+static int topology_supports_topoext(int nr_cores, int nr_threads,
+            Error **errp)
+{
+    if (nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET)) {
+        error_setg(errp, "TOPOEXT unsupported with %d cores per socket",
+                   nr_cores);
+        error_append_hint(errp, "TOPOEXT supports only up to %d cores per"
+                          " socket\n",
+                          (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
+        return false;
+    }
+
+    if (nr_threads > 2) {
+        error_setg(errp, "TOPOEXT unsupported with %d threads per core",
+                   nr_threads);
+        error_append_hint(errp, "TOPOEXT supports only up to 2 threads"
+                          " per core\n");
+        return false;
+    }
+    return true;
+}
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -4953,6 +4980,19 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
+    if (cpu->auto_topoext &&
+        !(env->user_features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT)) {
+        if (cs->nr_cores <= (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET) &&
+            (cs->nr_threads <= 2)) {
+            env->features[FEAT_8000_0001_ECX] |= CPUID_EXT3_TOPOEXT;
+        }
+    }
+
+    if ((env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
+        !topology_supports_topoext(cs->nr_cores, cs->nr_threads, errp)) {
+        return;
+    }
+
     /* Only Intel CPUs support hyperthreading. Even though QEMU fixes this
      * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
      * based on inputs (sockets,cores,threads), it is still better to gives
-- 
1.8.3.1
