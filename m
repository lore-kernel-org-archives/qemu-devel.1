Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD7C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DAE2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcbWTPqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DAE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGR5r-0005uN-EX
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvW-0007NR-DT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvU-0001uy-Je
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41443)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iGQvU-0001tz-CM
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id q9so8065399wrm.8
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=8doZ0f568w2tn95KQFcE2zGlQBBtDgG2i7tCdSCxDZ0=;
 b=QcbWTPqBCr03hNPgoreh7JTFhIng9SztswvL4bPV1vYhUBsyeQqAswXU9OuIwMdAbV
 bVnKaKm/LFN3Xb52PryC6D9rh6mkvhn0/ec80Q8XmRuXudhkWAgQ60Aoa9QUmO1s82D9
 2sIx5vcip32+pyY+whUKLy8uuqSxHU2kW2Okxqxb1xz47kCQmGuTb7BDQTwp56UCAv4/
 fWi3yVduaDm+Yq5pIW0lNPUVL1jiva/U6Tc6w8u9oapfMvxzRhcszwhlLzsndiv2lDjR
 TsCiPxRerDv2cJGwScq8kKVTyw0OeA5XrhxExoHEH0WOdDqzuXYPxfH8fHksPGdH1gW9
 WjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=8doZ0f568w2tn95KQFcE2zGlQBBtDgG2i7tCdSCxDZ0=;
 b=cptKAjbjZAStZutvTCE7Ew3S6ofxM72q6liro2A0wolPc/7l9CiL/dAyX7fko5Mw6o
 CqZVyiVXDz3V8WTruG+Pizhc3O0+j75xwdptu/pF8S3ntU3aP4fmx0wF3O5y1EWwvFrD
 2H4AROhh32DhX/VqJdQ47V+irpDx4zS0I1CL7YQU3SMZu9zTXySLcO1PFdt1e28YV+Ev
 T1SC8kc6XuU4xSVfYfhX5kYnUOmbdmXnnZvtmsq7YZH3KpmiXyXA84/YvLYaZgz+OyzM
 tlxh/qV9eapFJDuVCqu7DnzkeHP30LwfurLkvwSt7KB917zFMwB4TYLZ7Dvy5rHcyjbH
 BQmA==
X-Gm-Message-State: APjAAAUtV2eUv5SFXj73dS9/gXiLeVHKM5qIKY4F9lpv4iYPBYB8R52m
 YL9GaB18LVRSPatHss3Hpx0SFW/M
X-Google-Smtp-Source: APXvYqwU0fGKCwmGeFlKlqLVdvvKxci4/aLJBx/czzfwXsH+BIWJaYv3UwBE7nOklQJaejdMkhwUug==
X-Received: by 2002:a5d:67c3:: with SMTP id n3mr11657331wrw.294.1570208370635; 
 Fri, 04 Oct 2019 09:59:30 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u7sm7041270wrp.19.2019.10.04.09.59.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 09:59:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/29] target/i386: expand feature words to 64 bits
Date: Fri,  4 Oct 2019 18:59:18 +0200
Message-Id: <1570208363-11948-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
References: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VMX requires 64-bit feature words for the IA32_VMX_EPT_VPID_CAP
and IA32_VMX_BASIC MSRs.  (The VMX control MSRs are 64-bit wide but
actually have only 32 bits of information).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h |  2 +-
 target/i386/cpu.c    | 71 +++++++++++++++++++++++++++-------------------------
 target/i386/cpu.h    |  2 +-
 target/i386/kvm.c    |  2 +-
 4 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fd67477..9d14328 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -462,7 +462,7 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
-uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
+uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
 
 
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 35d868d..0a5d182 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -789,7 +789,7 @@ typedef struct FeatureWordInfo {
      * In cases of disagreement between feature naming conventions,
      * aliases may be added.
      */
-    const char *feat_names[32];
+    const char *feat_names[64];
     union {
         /* If type==CPUID_FEATURE_WORD */
         struct {
@@ -803,11 +803,11 @@ typedef struct FeatureWordInfo {
             uint32_t index;
         } msr;
     };
-    uint32_t tcg_features; /* Feature flags supported by TCG */
-    uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
-    uint32_t migratable_flags; /* Feature flags known to be migratable */
+    uint64_t tcg_features; /* Feature flags supported by TCG */
+    uint64_t unmigratable_flags; /* Feature flags known to be unmigratable */
+    uint64_t migratable_flags; /* Feature flags known to be migratable */
     /* Features that shouldn't be auto-enabled by "-cpu host" */
-    uint32_t no_autoenable_flags;
+    uint64_t no_autoenable_flags;
 } FeatureWordInfo;
 
 static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
@@ -1236,7 +1236,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
 
 typedef struct FeatureMask {
     FeatureWord index;
-    uint32_t mask;
+    uint64_t mask;
 } FeatureMask;
 
 typedef struct FeatureDep {
@@ -1246,11 +1246,11 @@ typedef struct FeatureDep {
 static FeatureDep feature_dependencies[] = {
     {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
-        .to = { FEAT_ARCH_CAPABILITIES,     ~0u },
+        .to = { FEAT_ARCH_CAPABILITIES,     ~0ull },
     },
     {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
-        .to = { FEAT_CORE_CAPABILITY,       ~0u },
+        .to = { FEAT_CORE_CAPABILITY,       ~0ull },
     },
 };
 
@@ -1362,14 +1362,14 @@ const char *get_register_name_32(unsigned int reg)
  * Returns the set of feature flags that are supported and migratable by
  * QEMU, for a given FeatureWord.
  */
-static uint32_t x86_cpu_get_migratable_flags(FeatureWord w)
+static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
-    uint32_t r = 0;
+    uint64_t r = 0;
     int i;
 
-    for (i = 0; i < 32; i++) {
-        uint32_t f = 1U << i;
+    for (i = 0; i < 64; i++) {
+        uint64_t f = 1ULL << i;
 
         /* If the feature name is known, it is implicitly considered migratable,
          * unless it is explicitly set in unmigratable_flags */
@@ -2931,7 +2931,7 @@ void x86_cpu_change_kvm_default(const char *prop, const char *value)
     assert(pv->prop);
 }
 
-static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
+static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only);
 
 static bool lmce_supported(void)
@@ -3117,7 +3117,7 @@ static bool x86_cpu_have_filtered_features(X86CPU *cpu)
     return false;
 }
 
-static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
+static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
                                       const char *verbose_prefix)
 {
     CPUX86State *env = &cpu->env;
@@ -3134,8 +3134,8 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
         return;
     }
 
-    for (i = 0; i < 32; ++i) {
-        if ((1UL << i) & mask) {
+    for (i = 0; i < 64; ++i) {
+        if ((1ULL << i) & mask) {
             feat_word_str = feature_word_description(f, i);
             warn_report("%s: %s%s%s [bit %d]",
                         verbose_prefix,
@@ -3378,7 +3378,7 @@ static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
-    uint32_t *array = (uint32_t *)opaque;
+    uint64_t *array = (uint64_t *)opaque;
     FeatureWord w;
     X86CPUFeatureWordInfo word_infos[FEATURE_WORDS] = { };
     X86CPUFeatureWordInfoList list_entries[FEATURE_WORDS] = { };
@@ -3422,6 +3422,7 @@ static inline void feat2prop(char *s)
 /* Return the feature property name for a feature flag bit */
 static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
 {
+    const char *name;
     /* XSAVE components are automatically enabled by other features,
      * so return the original feature name instead
      */
@@ -3435,9 +3436,11 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
         }
     }
 
-    assert(bitnr < 32);
+    assert(bitnr < 64);
     assert(w < FEATURE_WORDS);
-    return feature_word_info[w].feat_names[bitnr];
+    name = feature_word_info[w].feat_names[bitnr];
+    assert(bitnr < 32 || !(name && feature_word_info[w].type == CPUID_FEATURE_WORD));
+    return name;
 }
 
 /* Compatibily hack to maintain legacy +-feat semantic,
@@ -3553,10 +3556,10 @@ static void x86_cpu_list_feature_names(FeatureWordArray features,
     strList **next = feat_names;
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t filtered = features[w];
+        uint64_t filtered = features[w];
         int i;
-        for (i = 0; i < 32; i++) {
-            if (filtered & (1UL << i)) {
+        for (i = 0; i < 64; i++) {
+            if (filtered & (1ULL << i)) {
                 strList *new = g_new0(strList, 1);
                 new->value = g_strdup(x86_cpu_feature_name(w, i));
                 *next = new;
@@ -3725,7 +3728,7 @@ void x86_cpu_list(void)
     names = NULL;
     for (i = 0; i < ARRAY_SIZE(feature_word_info); i++) {
         FeatureWordInfo *fw = &feature_word_info[i];
-        for (j = 0; j < 32; j++) {
+        for (j = 0; j < 64; j++) {
             if (fw->feat_names[j]) {
                 names = g_list_append(names, (gpointer)fw->feat_names[j]);
             }
@@ -3780,11 +3783,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
+static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
-    uint32_t r = 0;
+    uint64_t r = 0;
 
     if (kvm_enabled()) {
         switch (wi->type) {
@@ -3955,7 +3958,7 @@ static QDict *x86_cpu_static_props(void)
     for (w = 0; w < FEATURE_WORDS; w++) {
         FeatureWordInfo *fi = &feature_word_info[w];
         int bit;
-        for (bit = 0; bit < 32; bit++) {
+        for (bit = 0; bit < 64; bit++) {
             if (!fi->feat_names[bit]) {
                 continue;
             }
@@ -5111,7 +5114,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-            uint32_t unavailable_features = env->features[d->to.index] & d->to.mask;
+            uint64_t unavailable_features = env->features[d->to.index] & d->to.mask;
 
             /* Not an error unless the dependent feature was added explicitly.  */
             mark_unavailable_features(cpu, d->to.index,
@@ -5206,10 +5209,10 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     }
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t host_feat =
+        uint64_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
-        uint32_t requested_features = env->features[w];
-        uint32_t unavailable_features = requested_features & ~host_feat;
+        uint64_t requested_features = env->features[w];
+        uint64_t unavailable_features = requested_features & ~host_feat;
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
@@ -5506,7 +5509,7 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
 
 typedef struct BitProperty {
     FeatureWord w;
-    uint32_t mask;
+    uint64_t mask;
 } BitProperty;
 
 static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
@@ -5514,7 +5517,7 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
 {
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
-    uint32_t f = cpu->env.features[fp->w];
+    uint64_t f = cpu->env.features[fp->w];
     bool value = (f & fp->mask) == fp->mask;
     visit_type_bool(v, name, &value, errp);
 }
@@ -5567,7 +5570,7 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
 {
     BitProperty *fp;
     ObjectProperty *op;
-    uint32_t mask = (1UL << bitnr);
+    uint64_t mask = (1ULL << bitnr);
 
     op = object_property_find(OBJECT(cpu), prop_name, NULL);
     if (op) {
@@ -5701,7 +5704,7 @@ static void x86_cpu_initfn(Object *obj)
     for (w = 0; w < FEATURE_WORDS; w++) {
         int bitnr;
 
-        for (bitnr = 0; bitnr < 32; bitnr++) {
+        for (bitnr = 0; bitnr < 64; bitnr++) {
             x86_cpu_register_feature_bit_props(cpu, w, bitnr);
         }
     }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 98f6ed5..312d70f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -502,7 +502,7 @@ typedef enum FeatureWord {
     FEATURE_WORDS,
 } FeatureWord;
 
-typedef uint32_t FeatureWordArray[FEATURE_WORDS];
+typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 /* cpuid_features bits */
 #define CPUID_FP87 (1U << 0)
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9206909..0a86c8c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -442,7 +442,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     return ret;
 }
 
-uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
+uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
 {
     struct {
         struct kvm_msrs info;
-- 
1.8.3.1



