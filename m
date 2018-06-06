Received: from eggs.gnu.org ([2001:4830:134:3::10]:50551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fQZYf-0004Uk-80
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fQZYb-0004ES-A6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:37:05 -0400
Received: from mail-by2nam01on0074.outbound.protection.outlook.com
	([104.47.34.74]:28608
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fQZYb-0004E6-0A
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:37:01 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Wed,  6 Jun 2018 10:36:44 -0400
Message-Id: <1528295806-90593-3-git-send-email-babu.moger@amd.com>
In-Reply-To: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v12 2/4] i386: Verify if topoext feature can be
 supported
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

topoext feature cannot be supported in certain cases
with large number of cores or threads. Add the check.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 86fb1a4..fc5c66d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -509,6 +509,20 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
 }
 
 /*
+ * Check if we can support this topology
+ * Fail if number of cores are beyond the supported config
+ * or nr_threads is more than 2
+ */
+static int topology_supports_topoext(int nr_cores, int nr_threads)
+{
+    if ((nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET)) ||
+        (nr_threads > 2)) {
+        return 0;
+    }
+    return 1;
+}
+
+/*
  * Definitions of the hardcoded cache entries we expose:
  * These are legacy cache values. If there is a need to change any
  * of these values please use builtin_x86_defs
@@ -4941,6 +4955,19 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
+    /* On AMD systems, check if we can support topoext feature */
+    if (IS_AMD_CPU(env) &&
+        (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT)) {
+        if (!topology_supports_topoext(cs->nr_cores, cs->nr_threads)) {
+                /* Cannot support topoext */
+                error_setg(errp, "CPU model does not support topoext feature "
+                                 "with number of cores(%d) and threads(%d). "
+                                 "Please configure -smp options properly.",
+                                 cs->nr_cores, cs->nr_threads);
+                return;
+        }
+    }
+
     /* Only Intel CPUs support hyperthreading. Even though QEMU fixes this
      * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
      * based on inputs (sockets,cores,threads), it is still better to gives
-- 
1.8.3.1
