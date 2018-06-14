Received: from eggs.gnu.org ([2001:4830:134:3::10]:48687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTGuX-0001J1-Li
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTGuT-0007jN-2I
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:49 -0400
Received: from mail-eopbgr700047.outbound.protection.outlook.com
	([40.107.70.47]:33423
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTGuS-0007i9-SX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:44 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Wed, 13 Jun 2018 21:18:26 -0400
Message-Id: <1528939107-17193-6-git-send-email-babu.moger@amd.com>
In-Reply-To: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v14 5/6] i386: Disable TOPOEXT feature if it
 cannot be supported
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

Disable the TOPOEXT feature if it cannot be supported.
We cannot support this feature with more than 2 nr_threads
or more than 32 cores in a socket.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2eb26da..637d8eb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4765,7 +4765,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    static bool ht_warned;
+    static bool ht_warned, topo_warned;
 
     if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
         char *name = x86_cpu_class_get_model_name(xcc);
@@ -4779,6 +4779,21 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Disable TOPOEXT if topology cannot be supported */
+    if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
+        if (!topology_supports_topoext(MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET,
+                                      2)) {
+            env->features[FEAT_8000_0001_ECX] &= !CPUID_EXT3_TOPOEXT;
+            if (!topo_warned) {
+                error_report("TOPOEXT feature cannot be supported with more"
+                             " than %d cores or more than 2 threads per socket."
+                             " Disabling the feature.",
+                             (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
+                topo_warned = true;
+            }
+        }
+    }
+
     x86_cpu_expand_features(cpu, &local_err);
     if (local_err) {
         goto out;
-- 
1.8.3.1
