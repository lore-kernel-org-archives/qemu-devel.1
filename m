Received: from eggs.gnu.org ([2001:4830:134:3::10]:44960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBi-0002MG-FY
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBf-0003qB-Qo
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:26 -0400
Received: from mail-bn3nam01on0064.outbound.protection.outlook.com
	([104.47.33.64]:43315
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f0wBf-0003oR-Mk
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:23 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Tue, 27 Mar 2018 17:31:04 -0400
Message-Id: <1522186271-27743-3-git-send-email-babu.moger@amd.com>
In-Reply-To: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
References: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/9] i386: Add cache information in
 X86CPUDefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, babu.moger@amd.com

Add cache information in X86CPUDefinition and CPUX86State.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 4 ++++
 target/i386/cpu.h | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index da59dc4..eec4a97 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1102,6 +1102,7 @@ struct X86CPUDefinition {
     int stepping;
     FeatureWordArray features;
     const char *model_id;
+    CPUCaches cache_info;
 };
 
 static X86CPUDefinition builtin_x86_defs[] = {
@@ -3239,6 +3240,9 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
         env->features[w] = def->features[w];
     }
 
+    /* Load Cache information from the X86CPUDefinition */
+    memcpy(&env->cache_info, &def->cache_info, sizeof(CPUCaches));
+
     /* Special cases not set in the X86CPUDefinition structs: */
     /* TODO: in-kernel irqchip for hvf */
     if (kvm_enabled()) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 79d5ccf..806c34b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1096,6 +1096,13 @@ typedef struct CPUCacheInfo {
 } CPUCacheInfo;
 
 
+typedef struct CPUCaches {
+        bool valid;
+        CPUCacheInfo l1d_cache;
+        CPUCacheInfo l1i_cache;
+        CPUCacheInfo l2_cache;
+        CPUCacheInfo l3_cache;
+} CPUCaches;
 
 typedef struct CPUX86State {
     /* standard registers */
@@ -1282,6 +1289,7 @@ typedef struct CPUX86State {
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
+    CPUCaches cache_info;
 
     /* MTRRs */
     uint64_t mtrr_fixed[11];
-- 
1.8.3.1
