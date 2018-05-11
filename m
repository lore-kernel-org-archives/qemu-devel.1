Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHEqU-0005r4-Q8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHEqQ-0007Ip-TE
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fHEqQ-0007Ho-Hn
	for qemu-devel@nongnu.org; Fri, 11 May 2018 16:40:50 -0400
Date: Fri, 11 May 2018 17:40:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180511204044.GW25013@localhost.localdomain>
References: <20180510204148.11687-1-babu.moger@amd.com>
	<20180510204148.11687-4-babu.moger@amd.com>
	<20180511192145.GV25013@localhost.localdomain>
	<BL0PR12MB24682473432EF64021381FAB959F0@BL0PR12MB2468.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR12MB24682473432EF64021381FAB959F0@BL0PR12MB2468.namprd12.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/8] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "geoff@hostfission.com" <geoff@hostfission.com>, "kash@tripleback.net" <kash@tripleback.net>

On Fri, May 11, 2018 at 08:21:50PM +0000, Moger, Babu wrote:
> 
> > -----Original Message-----
> > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > Sent: Friday, May 11, 2018 2:22 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > kvm@vger.kernel.org; geoff@hostfission.com; kash@tripleback.net
> > Subject: Re: [PATCH v8 3/8] i386: Add new property to control cache info
> > 
> > On Thu, May 10, 2018 at 03:41:43PM -0500, Babu Moger wrote:
> > > The property legacy-cache will be used to control the cache information.
> > > If user passes "-cpu legacy-cache" then older information will
> > > be displayed even if the hardware supports new information. Otherwise
> > > use the statically loaded cache definitions if available.
> > >
> > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > > ---
> > >  include/hw/i386/pc.h |  8 ++++
> > >  target/i386/cpu.c    | 97 ++++++++++++++++++++++++++++++++-----------
> > -
> > >  target/i386/cpu.h    |  5 +++
> > >  3 files changed, 84 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index 2e834e6ded..df15deefca 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -304,6 +304,14 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
> > >  int e820_get_num_entries(void);
> > >  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> > >
> > > +#define PC_COMPAT_2_12 \
> > > +    HW_COMPAT_2_12 \
> > > +    {\
> > > +        .driver   = TYPE_X86_CPU,\
> > > +        .property = "legacy-cache",\
> > > +        .value    = "on",\
> > > +    },
> > 
> > This isn't enough if the pc-*-2.12 machine-type isn't using the
> > macro.
> > 
> > Before we do this, we need a commit similar to commit
> > df47ce8af4a5, but adding pc-*-2.13 machine-types.
> 
> Ok. Sure. I think I got it. Will add pc-*-2.13 machine-types in v9 series. 
> 
> > 
> > The rest of the patch looks good to me, but I will suggest a
> > clean up (that can be submitted a separate patch later, or
> > included in v9) in a separate reply.
> 
> Either way is works for me.  If it is simple enough we can add here.  

This is the clean up I was working on.  Feel free to include it,
or leave this to be applied as a follow-up later.

>From b98b82dde371e850c65623f48bdb24df31a99b5d Mon Sep 17 00:00:00 2001
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 11 May 2018 16:59:34 -0300
Subject: [PATCH] Clean up cache CPUID code

Always initialize CPUCaches structs with cache information, even
if legacy_cache=true.  Use different CPUCaches struct for
CPUID[2], CPUID[4], and the AMD CPUID leaves.

This will simplify a lot the logic inside cpu_x86_cpuid().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |  14 ++++---
 target/i386/cpu.c | 117 +++++++++++++++++++++++++++---------------------------
 2 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 31715d167d..88fdf80d56 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1097,10 +1097,10 @@ typedef struct CPUCacheInfo {
 
 
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
@@ -1288,7 +1288,11 @@ typedef struct CPUX86State {
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
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b20b8691a7..18ea5e3547 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1113,7 +1113,7 @@ struct X86CPUDefinition {
 };
 
 static CPUCaches epyc_cache_info = {
-    .l1d_cache = {
+    .l1d_cache = &(CPUCacheInfo) {
         .type = DCACHE,
         .level = 1,
         .size = 32 * KiB,
@@ -1125,7 +1125,7 @@ static CPUCaches epyc_cache_info = {
         .self_init = 1,
         .no_invd_sharing = true,
     },
-    .l1i_cache = {
+    .l1i_cache = &(CPUCacheInfo) {
         .type = ICACHE,
         .level = 1,
         .size = 64 * KiB,
@@ -1137,7 +1137,7 @@ static CPUCaches epyc_cache_info = {
         .self_init = 1,
         .no_invd_sharing = true,
     },
-    .l2_cache = {
+    .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
         .level = 2,
         .size = 512 * KiB,
@@ -1147,7 +1147,7 @@ static CPUCaches epyc_cache_info = {
         .sets = 1024,
         .lines_per_tag = 1,
     },
-    .l3_cache = {
+    .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
         .level = 3,
         .size = 8 * MiB,
@@ -3299,9 +3299,8 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
         env->features[w] = def->features[w];
     }
 
-    /* Store Cache information from the X86CPUDefinition if available */
-    env->cache_info = def->cache_info;
-    cpu->legacy_cache = def->cache_info ? 0 : 1;
+    /* legacy-cache defaults to 'off' if CPU model provides cache info */
+    cpu->legacy_cache = !def->cache_info;
 
     /* Special cases not set in the X86CPUDefinition structs: */
     /* TODO: in-kernel irqchip for hvf */
@@ -3652,21 +3651,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -3679,35 +3668,27 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -3920,13 +3901,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -3942,17 +3918,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -4649,6 +4618,37 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
@@ -5131,11 +5131,10 @@ static Property x86_cpu_properties[] = {
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
-- 
2.14.3

-- 
Eduardo
