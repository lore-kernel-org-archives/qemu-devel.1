Received: from eggs.gnu.org ([2001:4830:134:3::10]:33225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gMsr5-0003Ey-3Y
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gMsr1-00083p-Tc
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:57:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <raistlin.df@gmail.com>)
	id 1gMsqz-0007zI-Pz
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:57:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id 124-v6so15068777wmw.0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 02:56:55 -0800 (PST)
From: Dario Faggioli <dfaggioli@suse.com>
Date: Wed, 14 Nov 2018 11:57:09 +0100
Message-ID: <154219302946.19470.14979106134197499918.stgit@wayrath>
In-Reply-To: <154219299016.19470.9372139354280787961.stgit@wayrath>
References: <154219299016.19470.9372139354280787961.stgit@wayrath>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 3/3] i386: custom cache size in AMD's CPUID
 descriptors too
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

If specified on the command line, alter the cache size(s)
properties accordingly, before encoding them in the AMD's
CPUID cache descriptors too (i.e., 80000006 and 8000001d).

Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 0 files changed

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 17aff19561..4949d6b907 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4490,6 +4490,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L2_DTLB_4K_ENTRIES << 16) | \
                (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
                (L2_ITLB_4K_ENTRIES);
+        if (cpu->l2_cache_size > 0)
+            set_custom_cache_size(env->cache_info_amd.l2_cache,
+                                  cpu->l2_cache_size);
+        if (cpu->enable_l3_cache && cpu->l3_cache_size > 0)
+            set_custom_cache_size(env->cache_info_amd.l3_cache,
+                                  cpu->l3_cache_size);
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
                                    env->cache_info_amd.l3_cache : NULL,
@@ -4546,10 +4552,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                        eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
+            if (cpu->l2_cache_size > 0)
+                set_custom_cache_size(env->cache_info_amd.l2_cache,
+                                      cpu->l2_cache_size * MiB);
             encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
                                        eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
+            if (cpu->enable_l3_cache && cpu->l3_cache_size > 0)
+                set_custom_cache_size(env->cache_info_amd.l3_cache,
+                                      cpu->l3_cache_size * MiB);
             encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
                                        eax, ebx, ecx, edx);
             break;
