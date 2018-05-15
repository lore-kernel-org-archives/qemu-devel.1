Received: from eggs.gnu.org ([2001:4830:134:3::10]:35634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhus-0008RL-Df
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhur-00015f-Em
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fIhur-00014N-95
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 15 May 2018 18:54:33 -0300
Message-Id: <20180515215436.6457-5-ehabkost@redhat.com>
In-Reply-To: <20180515215436.6457-1-ehabkost@redhat.com>
References: <20180515215436.6457-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] i386: Add cache information in
 X86CPUDefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Babu Moger <babu.moger@amd.com>

From: Babu Moger <babu.moger@amd.com>

Add cache information in X86CPUDefinition and CPUX86State.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180510204148.11687-3-babu.moger@amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 7 +++++++
 target/i386/cpu.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 512c69dddd..ac94013c4a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1097,6 +1097,12 @@ typedef struct CPUCacheInfo {
 } CPUCacheInfo;
 
 
+typedef struct CPUCaches {
+        CPUCacheInfo l1d_cache;
+        CPUCacheInfo l1i_cache;
+        CPUCacheInfo l2_cache;
+        CPUCacheInfo l3_cache;
+} CPUCaches;
 
 typedef struct CPUX86State {
     /* standard registers */
@@ -1286,6 +1292,7 @@ typedef struct CPUX86State {
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
+    CPUCaches *cache_info;
 
     /* MTRRs */
     uint64_t mtrr_fixed[11];
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 28bb93990e..55685ed19d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1106,6 +1106,7 @@ struct X86CPUDefinition {
     int stepping;
     FeatureWordArray features;
     const char *model_id;
+    CPUCaches *cache_info;
 };
 
 static X86CPUDefinition builtin_x86_defs[] = {
-- 
2.14.3
