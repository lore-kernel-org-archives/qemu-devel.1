Received: from eggs.gnu.org ([2001:4830:134:3::10]:35721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhuz-00006O-Ja
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhuy-0001AH-4L
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fIhux-0001A5-Qi
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 15 May 2018 18:54:36 -0300
Message-Id: <20180515215436.6457-8-ehabkost@redhat.com>
In-Reply-To: <20180515215436.6457-1-ehabkost@redhat.com>
References: <20180515215436.6457-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] i386: Add new property to control cache info
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

The property legacy-cache will be used to control the cache information.
If user passes "-cpu legacy-cache" then older information will
be displayed even if the hardware supports new information. Otherwise
use the statically loaded cache definitions if available.

Renamed the previous cache structures to legacy_*. If there is any change in
the cache information, then it needs to be initialized in builtin_x86_defs.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Message-Id: <20180514164156.27034-3-babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  5 +++
 target/i386/cpu.h    |  5 +++
 target/i386/cpu.c    | 97 ++++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 81 insertions(+), 26 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d4fe073cb8..a0c269fc34 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -298,6 +298,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_12 \
     HW_COMPAT_2_12 \
+    {\
+        .driver   = TYPE_X86_CPU,\
+        .property = "legacy-cache",\
+        .value    = "on",\
+    },
 
 #define PC_COMPAT_2_11 \
     HW_COMPAT_2_11 \
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ac94013c4a..8bc54d70bf 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1399,6 +1399,11 @@ struct X86CPU {
      */
     bool enable_l3_cache;
 
+    /* Compatibility bits for old machine types.
+     * If true present the old cache topology information
+     */
+    bool legacy_cache;
+
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 174a8f434b..e5e66a75d4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -336,10 +336,14 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
     }
 }
 
-/* Definitions of the hardcoded cache entries we expose: */
+/*
+ * Definitions of the hardcoded cache entries we expose:
+ * These are legacy cache values. If there is a need to change any
+ * of these values please use builtin_x86_defs
+ */
 
 /* L1 data cache: */
-static CPUCacheInfo l1d_cache = {
+static CPUCacheInfo legacy_l1d_cache = {
     .type = DCACHE,
     .level = 1,
     .size = 32 * KiB,
@@ -352,7 +356,7 @@ static CPUCacheInfo l1d_cache = {
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
-static CPUCacheInfo l1d_cache_amd = {
+static CPUCacheInfo legacy_l1d_cache_amd = {
     .type = DCACHE,
     .level = 1,
     .size = 64 * KiB,
@@ -366,7 +370,7 @@ static CPUCacheInfo l1d_cache_amd = {
 };
 
 /* L1 instruction cache: */
-static CPUCacheInfo l1i_cache = {
+static CPUCacheInfo legacy_l1i_cache = {
     .type = ICACHE,
     .level = 1,
     .size = 32 * KiB,
@@ -379,7 +383,7 @@ static CPUCacheInfo l1i_cache = {
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
-static CPUCacheInfo l1i_cache_amd = {
+static CPUCacheInfo legacy_l1i_cache_amd = {
     .type = ICACHE,
     .level = 1,
     .size = 64 * KiB,
@@ -393,7 +397,7 @@ static CPUCacheInfo l1i_cache_amd = {
 };
 
 /* Level 2 unified cache: */
-static CPUCacheInfo l2_cache = {
+static CPUCacheInfo legacy_l2_cache = {
     .type = UNIFIED_CACHE,
     .level = 2,
     .size = 4 * MiB,
@@ -406,7 +410,7 @@ static CPUCacheInfo l2_cache = {
 };
 
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
-static CPUCacheInfo l2_cache_cpuid2 = {
+static CPUCacheInfo legacy_l2_cache_cpuid2 = {
     .type = UNIFIED_CACHE,
     .level = 2,
     .size = 2 * MiB,
@@ -416,7 +420,7 @@ static CPUCacheInfo l2_cache_cpuid2 = {
 
 
 /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
-static CPUCacheInfo l2_cache_amd = {
+static CPUCacheInfo legacy_l2_cache_amd = {
     .type = UNIFIED_CACHE,
     .level = 2,
     .size = 512 * KiB,
@@ -428,7 +432,7 @@ static CPUCacheInfo l2_cache_amd = {
 };
 
 /* Level 3 unified cache: */
-static CPUCacheInfo l3_cache = {
+static CPUCacheInfo legacy_l3_cache = {
     .type = UNIFIED_CACHE,
     .level = 3,
     .size = 16 * MiB,
@@ -3338,6 +3342,10 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
         env->features[w] = def->features[w];
     }
 
+    /* Store Cache information from the X86CPUDefinition if available */
+    env->cache_info = def->cache_info;
+    cpu->legacy_cache = def->cache_info ? 0 : 1;
+
     /* Special cases not set in the X86CPUDefinition structs: */
     /* TODO: in-kernel irqchip for hvf */
     if (kvm_enabled()) {
@@ -3687,11 +3695,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (!cpu->enable_l3_cache) {
             *ecx = 0;
         } else {
-            *ecx = cpuid2_cache_descriptor(&l3_cache);
+            if (env->cache_info && !cpu->legacy_cache) {
+                *ecx = cpuid2_cache_descriptor(&env->cache_info->l3_cache);
+            } else {
+                *ecx = cpuid2_cache_descriptor(&legacy_l3_cache);
+            }
+        }
+        if (env->cache_info && !cpu->legacy_cache) {
+            *edx = (cpuid2_cache_descriptor(&env->cache_info->l1d_cache) << 16) |
+                   (cpuid2_cache_descriptor(&env->cache_info->l1i_cache) <<  8) |
+                   (cpuid2_cache_descriptor(&env->cache_info->l2_cache));
+        } else {
+            *edx = (cpuid2_cache_descriptor(&legacy_l1d_cache) << 16) |
+                   (cpuid2_cache_descriptor(&legacy_l1i_cache) <<  8) |
+                   (cpuid2_cache_descriptor(&legacy_l2_cache_cpuid2));
         }
-        *edx = (cpuid2_cache_descriptor(&l1d_cache) << 16) |
-               (cpuid2_cache_descriptor(&l1i_cache) <<  8) |
-               (cpuid2_cache_descriptor(&l2_cache_cpuid2));
         break;
     case 4:
         /* cache info: needed for Core compatibility */
@@ -3704,27 +3722,35 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         } else {
             *eax = 0;
+            CPUCacheInfo *l1d, *l1i, *l2, *l3;
+            if (env->cache_info && !cpu->legacy_cache) {
+                l1d = &env->cache_info->l1d_cache;
+                l1i = &env->cache_info->l1i_cache;
+                l2 = &env->cache_info->l2_cache;
+                l3 = &env->cache_info->l3_cache;
+            } else {
+                l1d = &legacy_l1d_cache;
+                l1i = &legacy_l1i_cache;
+                l2 = &legacy_l2_cache;
+                l3 = &legacy_l3_cache;
+            }
             switch (count) {
             case 0: /* L1 dcache info */
-                encode_cache_cpuid4(&l1d_cache,
-                                    1, cs->nr_cores,
+                encode_cache_cpuid4(l1d, 1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
-                encode_cache_cpuid4(&l1i_cache,
-                                    1, cs->nr_cores,
+                encode_cache_cpuid4(l1i, 1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
-                encode_cache_cpuid4(&l2_cache,
-                                    cs->nr_threads, cs->nr_cores,
+                encode_cache_cpuid4(l2, cs->nr_threads, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 pkg_offset = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
                 if (cpu->enable_l3_cache) {
-                    encode_cache_cpuid4(&l3_cache,
-                                        (1 << pkg_offset), cs->nr_cores,
+                    encode_cache_cpuid4(l3, (1 << pkg_offset), cs->nr_cores,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -3937,8 +3963,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) | \
                (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
-        *ecx = encode_cache_cpuid80000005(&l1d_cache_amd);
-        *edx = encode_cache_cpuid80000005(&l1i_cache_amd);
+        if (env->cache_info && !cpu->legacy_cache) {
+            *ecx = encode_cache_cpuid80000005(&env->cache_info->l1d_cache);
+            *edx = encode_cache_cpuid80000005(&env->cache_info->l1i_cache);
+        } else {
+            *ecx = encode_cache_cpuid80000005(&legacy_l1d_cache_amd);
+            *edx = encode_cache_cpuid80000005(&legacy_l1i_cache_amd);
+        }
         break;
     case 0x80000006:
         /* cache info (L2 cache) */
@@ -3954,9 +3985,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L2_DTLB_4K_ENTRIES << 16) | \
                (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
                (L2_ITLB_4K_ENTRIES);
-        encode_cache_cpuid80000006(&l2_cache_amd,
-                                   cpu->enable_l3_cache ? &l3_cache : NULL,
-                                   ecx, edx);
+        if (env->cache_info && !cpu->legacy_cache) {
+            encode_cache_cpuid80000006(&env->cache_info->l2_cache,
+                                       cpu->enable_l3_cache ?
+                                       &env->cache_info->l3_cache : NULL,
+                                       ecx, edx);
+        } else {
+            encode_cache_cpuid80000006(&legacy_l2_cache_amd,
+                                       cpu->enable_l3_cache ?
+                                       &legacy_l3_cache : NULL,
+                                       ecx, edx);
+        }
         break;
     case 0x80000007:
         *eax = 0;
@@ -5135,6 +5174,12 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+    /*
+     * lecacy_cache defaults to CPU model being chosen. This is set in
+     * x86_cpu_load_def based on cache_info which is initialized in
+     * builtin_x86_defs
+     */
+    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, false),
 
     /*
      * From "Requirements for Implementing the Microsoft
-- 
2.14.3
