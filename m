Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E821C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3542082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3542082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he40P-0002Ew-RC
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 16:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1he3xl-00010h-Uc
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1he3nE-0004nb-TE
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:36:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1he3nE-0004mT-K1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49E6030C1AD5;
 Thu, 20 Jun 2019 20:36:22 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA48F1001E69;
 Thu, 20 Jun 2019 20:36:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 17:36:16 -0300
Message-Id: <20190620203616.22715-3-ehabkost@redhat.com>
In-Reply-To: <20190620203616.22715-1-ehabkost@redhat.com>
References: <20190620203616.22715-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 20 Jun 2019 20:36:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] i386: Introduce X86CPUCacheCPUID struct
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Babu Moger <babu.moger@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new struct will be used to simplify the code that deals with
legacy cache information.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |   7 +---
 target/i386/cpu.c | 100 ++++++++++++++++++++++++++++------------------
 2 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2f03489bf0..86cf04d441 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1306,11 +1306,8 @@ typedef struct CPUX86State {
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
-    /* Cache information for CPUID.  When legacy-cache=on, the cache data
-     * on each CPUID leaf will be different, because we keep compatibility
-     * with old QEMU versions.
-     */
-    CPUCaches cache_info_cpuid2, cache_info_cpuid4, cache_info_amd;
+    /* Cache information for CPUID */
+    const struct X86CPUCacheCPUID *caches;
 
     /* MTRRs */
     uint64_t mtrr_fixed[11];
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a6acd71911..e9f301f9ea 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1412,6 +1412,10 @@ static char *x86_cpu_class_get_model_name(X86CPUClass *cc)
                      strlen(class_name) - strlen(X86_CPU_TYPE_SUFFIX));
 }
 
+typedef struct X86CPUCacheCPUID {
+    CPUCaches cpuid2, cpuid4, amd;
+} X86CPUCacheCPUID;
+
 struct X86CPUDefinition {
     const char *name;
     uint32_t level;
@@ -1423,7 +1427,7 @@ struct X86CPUDefinition {
     int stepping;
     FeatureWordArray features;
     const char *model_id;
-    const CPUCaches *cache_info;
+    const X86CPUCacheCPUID *cache_cpuid;
 };
 
 static const CPUCaches epyc_cache_info = {
@@ -1476,6 +1480,39 @@ static const CPUCaches epyc_cache_info = {
     },
 };
 
+static X86CPUCacheCPUID epyc_cache_cpuid = {
+    .cpuid2 = epyc_cache_info,
+    .cpuid4 = epyc_cache_info,
+    .amd = epyc_cache_info,
+};
+
+/*
+ * Legacy cache template.  When legacy-cache=on, the cache data
+ * on each CPUID leaf will be different, because we keep compatibility
+ * with old QEMU versions.
+ */
+static X86CPUCacheCPUID legacy_cache_cpuid = {
+    .cpuid2 = {
+        .l1d_cache = &legacy_l1d_cache,
+        .l1i_cache = &legacy_l1i_cache,
+        .l2_cache = &legacy_l2_cache_cpuid2,
+        .l3_cache = &legacy_l3_cache,
+    },
+    .cpuid4 = {
+        .l1d_cache = &legacy_l1d_cache,
+        .l1i_cache = &legacy_l1i_cache,
+        .l2_cache = &legacy_l2_cache,
+        .l3_cache = &legacy_l3_cache,
+    },
+    .amd = {
+        .l1d_cache = &legacy_l1d_cache_amd,
+        .l1i_cache = &legacy_l1i_cache_amd,
+        .l2_cache = &legacy_l2_cache_amd,
+        .l3_cache = &legacy_l3_cache,
+    },
+};
+
+
 static X86CPUDefinition builtin_x86_defs[] = {
     {
         .name = "qemu64",
@@ -2886,7 +2923,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor",
-        .cache_info = &epyc_cache_info,
+        .cache_cpuid = &epyc_cache_cpuid,
     },
     {
         .name = "EPYC-IBPB",
@@ -2936,7 +2973,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor (with IBPB)",
-        .cache_info = &epyc_cache_info,
+        .cache_cpuid = &epyc_cache_cpuid,
     },
     {
         .name = "Dhyana",
@@ -2986,7 +3023,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel = 0x8000001E,
         .model_id = "Hygon Dhyana Processor",
-        .cache_info = &epyc_cache_info,
+        .cache_cpuid = &epyc_cache_cpuid,
     },
 };
 
@@ -3951,7 +3988,7 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
     }
 
     /* legacy-cache defaults to 'off' if CPU model provides cache info */
-    cpu->legacy_cache = !def->cache_info;
+    cpu->legacy_cache = !def->cache_cpuid;
 
     /* Special cases not set in the X86CPUDefinition structs: */
     /* TODO: in-kernel irqchip for hvf */
@@ -4301,11 +4338,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (!cpu->enable_l3_cache) {
             *ecx = 0;
         } else {
-            *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
+            *ecx = cpuid2_cache_descriptor(env->caches->cpuid2.l3_cache);
         }
-        *edx = (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1d_cache) << 16) |
-               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
-               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
+        *edx = (cpuid2_cache_descriptor(env->caches->cpuid2.l1d_cache) << 16) |
+               (cpuid2_cache_descriptor(env->caches->cpuid2.l1i_cache) <<  8) |
+               (cpuid2_cache_descriptor(env->caches->cpuid2.l2_cache));
         break;
     case 4:
         /* cache info: needed for Core compatibility */
@@ -4320,24 +4357,24 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = 0;
             switch (count) {
             case 0: /* L1 dcache info */
-                encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
+                encode_cache_cpuid4(env->caches->cpuid4.l1d_cache,
                                     1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
-                encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
+                encode_cache_cpuid4(env->caches->cpuid4.l1i_cache,
                                     1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
-                encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
+                encode_cache_cpuid4(env->caches->cpuid4.l2_cache,
                                     cs->nr_threads, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 pkg_offset = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
                 if (cpu->enable_l3_cache) {
-                    encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
+                    encode_cache_cpuid4(env->caches->cpuid4.l3_cache,
                                         (1 << pkg_offset), cs->nr_cores,
                                         eax, ebx, ecx, edx);
                     break;
@@ -4551,8 +4588,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) | \
                (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
-        *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
-        *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
+        *ecx = encode_cache_cpuid80000005(env->caches->amd.l1d_cache);
+        *edx = encode_cache_cpuid80000005(env->caches->amd.l1i_cache);
         break;
     case 0x80000006:
         /* cache info (L2 cache) */
@@ -4568,9 +4605,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L2_DTLB_4K_ENTRIES << 16) | \
                (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
                (L2_ITLB_4K_ENTRIES);
-        encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
+        encode_cache_cpuid80000006(env->caches->amd.l2_cache,
                                    cpu->enable_l3_cache ?
-                                   env->cache_info_amd.l3_cache : NULL,
+                                   env->caches->amd.l3_cache : NULL,
                                    ecx, edx);
         break;
     case 0x80000007:
@@ -4620,19 +4657,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
+            encode_cache_cpuid8000001d(env->caches->amd.l1d_cache, cs,
                                        eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
+            encode_cache_cpuid8000001d(env->caches->amd.l1i_cache, cs,
                                        eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
+            encode_cache_cpuid8000001d(env->caches->amd.l2_cache, cs,
                                        eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
+            encode_cache_cpuid8000001d(env->caches->amd.l3_cache, cs,
                                        eax, ebx, ecx, edx);
             break;
         default: /* end of info */
@@ -5331,31 +5368,16 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     /* Cache information initialization */
     if (!cpu->legacy_cache) {
-        if (!xcc->cpu_def || !xcc->cpu_def->cache_info) {
+        if (!xcc->cpu_def || !xcc->cpu_def->cache_cpuid) {
             char *name = x86_cpu_class_get_model_name(xcc);
             error_setg(errp,
                        "CPU model '%s' doesn't support legacy-cache=off", name);
             g_free(name);
             return;
         }
-        env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
-            *xcc->cpu_def->cache_info;
+        env->caches = xcc->cpu_def->cache_cpuid;
     } else {
-        /* Build legacy cache information */
-        env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
-        env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
-        env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
-        env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
-
-        env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
-        env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
-        env->cache_info_cpuid4.l2_cache = &legacy_l2_cache;
-        env->cache_info_cpuid4.l3_cache = &legacy_l3_cache;
-
-        env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
-        env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
-        env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
-        env->cache_info_amd.l3_cache = &legacy_l3_cache;
+        env->caches = &legacy_cache_cpuid;
     }
 
 
-- 
2.18.0.rc1.1.g3f1ff2140


