Received: from eggs.gnu.org ([2001:4830:134:3::10]:33167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gMsqx-00039W-TX
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gMsqm-0007xx-DG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:56:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <raistlin.df@gmail.com>)
	id 1gMsql-0007xS-Si
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:56:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so3876703wrt.13
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 02:56:47 -0800 (PST)
From: Dario Faggioli <dfaggioli@suse.com>
Date: Wed, 14 Nov 2018 11:57:02 +0100
Message-ID: <154219302196.19470.10725052065694275300.stgit@wayrath>
In-Reply-To: <154219299016.19470.9372139354280787961.stgit@wayrath>
References: <154219299016.19470.9372139354280787961.stgit@wayrath>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 2/3] i386: custom cache size in CPUID2 and
 CPUID4 descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

If specified on the command line, alter the cache(s) properties
accordingly, before encoding them in the CPUID descriptors.

Tweak the number of sets (if defined), to retain consistency.

Unless some specific size values are used (either by chance
or voluntarily), we won't find any matching CPUID-2 descriptor,
and 0xFF will be used. This shouldn't be a problem, as we have
CPUID-4.

Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
---
I'm no CPUID expert. I'm not sure I've fully understodd the relationship
between CPUID-2 and CPUID-4. The solution implemented here, is the best
I could come up with, and it worked on all the CPU types that I've tried.
If it's wrong/suboptimal, I'm happy to think to something else/rework.
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 0 files changed

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b8ccb2be04..17aff19561 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -426,6 +426,24 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
 
+static void set_custom_cache_size(CPUCacheInfo *c, uint64_t sz)
+{
+    /*
+     * Descriptors that have 'sets', also have 'partitions' initialized,
+     * so we can compute the new number of sets. For others, just tweak the
+     * size.
+     */
+    assert(c->partitions > 0 || c->sets == 0);
+    if (c->sets > 0) {
+        uint32_t sets = sz / (c->line_size * c->associativity * c->partitions);
+
+        if (sets == 0)
+            return;
+        c->sets = sets;
+    }
+    c->size = sz;
+}
+
 /* Data structure to hold the configuration info for a given core index */
 struct core_topology {
     /* core complex id of the current core index */
@@ -4193,8 +4211,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (!cpu->enable_l3_cache) {
             *ecx = 0;
         } else {
+            if (cpu->l3_cache_size > 0)
+                set_custom_cache_size(env->cache_info_cpuid2.l3_cache,
+                                      cpu->l3_cache_size);
             *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
         }
+        if (cpu->l2_cache_size > 0)
+            set_custom_cache_size(env->cache_info_cpuid2.l2_cache,
+                                  cpu->l2_cache_size);
         *edx = (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1d_cache) << 16) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
@@ -4222,6 +4246,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
+                if (cpu->l2_cache_size > 0)
+                    set_custom_cache_size(env->cache_info_cpuid4.l2_cache,
+                                          cpu->l2_cache_size);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
                                     cs->nr_threads, cs->nr_cores,
                                     eax, ebx, ecx, edx);
@@ -4229,6 +4256,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             case 3: /* L3 cache info */
                 pkg_offset = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
                 if (cpu->enable_l3_cache) {
+                    if (cpu->l3_cache_size > 0)
+                        set_custom_cache_size(env->cache_info_cpuid4.l3_cache,
+                                              cpu->l3_cache_size);
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
                                         (1 << pkg_offset), cs->nr_cores,
                                         eax, ebx, ecx, edx);
