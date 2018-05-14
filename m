Received: from eggs.gnu.org ([2001:4830:134:3::10]:58495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fIGYK-0006ry-0L
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fIGYG-0005hn-Sb
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:24 -0400
Received: from mail-cys01nam02on0088.outbound.protection.outlook.com
	([104.47.37.88]:24800
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fIGYG-0005hU-IC
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:20 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 14 May 2018 11:41:53 -0500
Message-Id: <20180514164156.27034-5-babu.moger@amd.com>
In-Reply-To: <20180514164156.27034-1-babu.moger@amd.com>
References: <20180514164156.27034-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 4/7] i386: Clean up cache CPUID code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com, kash@tripleback.net, babu.moger@amd.com

From: Eduardo Habkost <ehabkost@redhat.com>

Always initialize CPUCaches structs with cache information, even
if legacy_cache=true.  Use different CPUCaches struct for
CPUID[2], CPUID[4], and the AMD CPUID leaves.

This will simplify a lot the logic inside cpu_x86_cpuid().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 145 +++++++++++++++++++++-------------------------
 target/i386/cpu.h |  14 +++--
 2 files changed, 75 insertions(+), 84 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7f40241786..c06a9f5ebe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1156,7 +1156,7 @@ struct X86CPUDefinition {
 };
 
 static CPUCaches epyc_cache_info = {
-    .l1d_cache = {
+    .l1d_cache = &(CPUCacheInfo) {
         .type = DCACHE,
         .level = 1,
         .size = 32 * KiB,
@@ -1168,7 +1168,7 @@ static CPUCaches epyc_cache_info = {
         .self_init = 1,
         .no_invd_sharing = true,
     },
-    .l1i_cache = {
+    .l1i_cache = &(CPUCacheInfo) {
         .type = ICACHE,
         .level = 1,
         .size = 64 * KiB,
@@ -1180,7 +1180,7 @@ static CPUCaches epyc_cache_info = {
         .self_init = 1,
         .no_invd_sharing = true,
     },
-    .l2_cache = {
+    .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
         .level = 2,
         .size = 512 * KiB,
@@ -1190,7 +1190,7 @@ static CPUCaches epyc_cache_info = {
         .sets = 1024,
         .lines_per_tag = 1,
     },
-    .l3_cache = {
+    .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
         .level = 3,
         .size = 8 * MiB,
@@ -3384,9 +3384,8 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
         env->features[w] = def->features[w];
     }
 
-    /* Store Cache information from the X86CPUDefinition if available */
-    env->cache_info = def->cache_info;
-    cpu->legacy_cache = def->cache_info ? 0 : 1;
+    /* legacy-cache defaults to 'off' if CPU model provides cache info */
+    cpu->legacy_cache = !def->cache_info;
 
     /* Special cases not set in the X86CPUDefinition structs: */
     /* TODO: in-kernel irqchip for hvf */
@@ -3737,21 +3736,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (!cpu->enable_l3_cache) {
             *ecx = 0;
         } else {
-            if (env->cache_info && !cpu->legacy_cache) {
-                *ecx = cpuid2_cache_descriptor(&env->cache_info->l3_cache);
-            } else {
-                *ecx = cpuid2_cache_descriptor(&legacy_l3_cache);
-            }
-        }
-        if (env->cache_info && !cpu->legacy_cache) {
-            *edx = (cpuid2_cache_descriptor(&env->cache_info->l1d_cache) << 16) |
-                   (cpuid2_cache_descriptor(&env->cache_info->l1i_cache) <<  8) |
-                   (cpuid2_cache_descriptor(&env->cache_info->l2_cache));
-        } else {
-            *edx = (cpuid2_cache_descriptor(&legacy_l1d_cache) << 16) |
-                   (cpuid2_cache_descriptor(&legacy_l1i_cache) <<  8) |
-                   (cpuid2_cache_descriptor(&legacy_l2_cache_cpuid2));
+            *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
         }
+        *edx = (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1d_cache) << 16) |
+               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
+               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
         break;
     case 4:
         /* cache info: needed for Core compatibility */
@@ -3764,35 +3753,27 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         } else {
             *eax = 0;
-            CPUCacheInfo *l1d, *l1i, *l2, *l3;
-            if (env->cache_info && !cpu->legacy_cache) {
-                l1d = &env->cache_info->l1d_cache;
-                l1i = &env->cache_info->l1i_cache;
-                l2 = &env->cache_info->l2_cache;
-                l3 = &env->cache_info->l3_cache;
-            } else {
-                l1d = &legacy_l1d_cache;
-                l1i = &legacy_l1i_cache;
-                l2 = &legacy_l2_cache;
-                l3 = &legacy_l3_cache;
-            }
             switch (count) {
             case 0: /* L1 dcache info */
-                encode_cache_cpuid4(l1d, 1, cs->nr_cores,
+                encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
+                                    1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
-                encode_cache_cpuid4(l1i, 1, cs->nr_cores,
+                encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
+                                    1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
-                encode_cache_cpuid4(l2, cs->nr_threads, cs->nr_cores,
+                encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
+                                    cs->nr_threads, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 pkg_offset = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
                 if (cpu->enable_l3_cache) {
-                    encode_cache_cpuid4(l3, (1 << pkg_offset), cs->nr_cores,
+                    encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
+                                        (1 << pkg_offset), cs->nr_cores,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -4005,13 +3986,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) | \
                (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
-        if (env->cache_info && !cpu->legacy_cache) {
-            *ecx = encode_cache_cpuid80000005(&env->cache_info->l1d_cache);
-            *edx = encode_cache_cpuid80000005(&env->cache_info->l1i_cache);
-        } else {
-            *ecx = encode_cache_cpuid80000005(&legacy_l1d_cache_amd);
-            *edx = encode_cache_cpuid80000005(&legacy_l1i_cache_amd);
-        }
+        *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
+        *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
         break;
     case 0x80000006:
         /* cache info (L2 cache) */
@@ -4027,17 +4003,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L2_DTLB_4K_ENTRIES << 16) | \
                (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
                (L2_ITLB_4K_ENTRIES);
-        if (env->cache_info && !cpu->legacy_cache) {
-            encode_cache_cpuid80000006(&env->cache_info->l2_cache,
-                                       cpu->enable_l3_cache ?
-                                       &env->cache_info->l3_cache : NULL,
-                                       ecx, edx);
-        } else {
-            encode_cache_cpuid80000006(&legacy_l2_cache_amd,
-                                       cpu->enable_l3_cache ?
-                                       &legacy_l3_cache : NULL,
-                                       ecx, edx);
-        }
+        encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
+                                   cpu->enable_l3_cache ?
+                                   env->cache_info_amd.l3_cache : NULL,
+                                   ecx, edx);
         break;
     case 0x80000007:
         *eax = 0;
@@ -4080,34 +4049,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001D:
         *eax = 0;
-        CPUCacheInfo *l1d, *l1i, *l2, *l3;
-        if (env->cache_info && !cpu->legacy_cache) {
-            l1d = &env->cache_info->l1d_cache;
-            l1i = &env->cache_info->l1i_cache;
-            l2 = &env->cache_info->l2_cache;
-            l3 = &env->cache_info->l3_cache;
-        } else {
-            l1d = &legacy_l1d_cache_amd;
-            l1i = &legacy_l1i_cache_amd;
-            l2 = &legacy_l2_cache_amd;
-            l3 = &legacy_l3_cache;
-        }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(l1d, cs->nr_threads,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
+                                       cs->nr_threads, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(l1i, cs->nr_threads,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
+                                       cs->nr_threads, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(l2, cs->nr_threads,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
+                                       cs->nr_threads, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(l3, cs->nr_threads,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
+                                       cs->nr_threads, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax = *ebx = *ecx = *edx = 0;
@@ -4770,6 +4727,37 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             cpu->phys_bits = 32;
         }
     }
+
+    /* Cache information initialization */
+    if (!cpu->legacy_cache) {
+        if (!xcc->cpu_def || !xcc->cpu_def->cache_info) {
+            char *name = x86_cpu_class_get_model_name(xcc);
+            error_setg(errp,
+                       "CPU model '%s' doesn't support legacy-cache=off", name);
+            g_free(name);
+            return;
+        }
+        env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
+            *xcc->cpu_def->cache_info;
+    } else {
+        /* Build legacy cache information */
+        env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
+        env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
+        env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
+        env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
+
+        env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
+        env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
+        env->cache_info_cpuid4.l2_cache = &legacy_l2_cache;
+        env->cache_info_cpuid4.l3_cache = &legacy_l3_cache;
+
+        env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
+        env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
+        env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
+        env->cache_info_amd.l3_cache = &legacy_l3_cache;
+    }
+
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -5252,11 +5240,10 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     /*
-     * lecacy_cache defaults to CPU model being chosen. This is set in
-     * x86_cpu_load_def based on cache_info which is initialized in
-     * builtin_x86_defs
+     * lecacy_cache defaults to true unless the CPU model provides its
+     * own cache information (see x86_cpu_load_def()).
      */
-    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, false),
+    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
 
     /*
      * From "Requirements for Implementing the Microsoft
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1f9ccd47d9..e64b7da997 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1098,10 +1098,10 @@ typedef struct CPUCacheInfo {
 
 
 typedef struct CPUCaches {
-        CPUCacheInfo l1d_cache;
-        CPUCacheInfo l1i_cache;
-        CPUCacheInfo l2_cache;
-        CPUCacheInfo l3_cache;
+        CPUCacheInfo *l1d_cache;
+        CPUCacheInfo *l1i_cache;
+        CPUCacheInfo *l2_cache;
+        CPUCacheInfo *l3_cache;
 } CPUCaches;
 
 typedef struct CPUX86State {
@@ -1289,7 +1289,11 @@ typedef struct CPUX86State {
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
-    CPUCaches *cache_info;
+    /* Cache information for CPUID.  When legacy-cache=on, the cache data
+     * on each CPUID leaf will be different, because we keep compatibility
+     * with old QEMU versions.
+     */
+    CPUCaches cache_info_cpuid2, cache_info_cpuid4, cache_info_amd;
 
     /* MTRRs */
     uint64_t mtrr_fixed[11];
-- 
2.17.0
