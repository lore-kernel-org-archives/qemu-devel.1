Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E65C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C04F21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1lGv62/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C04F21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhtC-0006yH-MB
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr6-000577-4k
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr4-000362-Rm
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhr4-00034y-LP
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:51:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id z9so7359954wrl.11
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=s6juWaeJdvbdYfQYOPZtIdvf+1dOdIoXW07/VCUIeko=;
 b=X1lGv62/IOZ2T5DwOQ6jsXT2+wRKDs8M88KMgwD6+md/YRYQ6l8lDOTnsEyHn5e5JB
 +wTw3lDh+8eZ7+eWW39V9F2z3CypXiqZ+pYe9/G3/SyPWlqvSeOjmTmfYHL9KXbUS1WS
 I6BCsxprf8Qxk24p1S61BkdVcmSgMtGAh6BYwqkFwCRXq3d0qJYKVFNQYQvc+wKqjhZ+
 Ga/oOJ1MT31WrJuKToKJhIEaHq8wOM39IncU2rge1jNZFo97zCvsf/sUD4ADMmS6jBzU
 2y8gjnyu6HyzDr71qGXotH04kf29/3AvoTEKWs60hP2hNTUXtdbnfR/697sHdEo+bfqF
 xaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=s6juWaeJdvbdYfQYOPZtIdvf+1dOdIoXW07/VCUIeko=;
 b=FQGVFninbJOHHBj/noV6o0c1q2cbM8Hh86bTq5/Pk4EWuESXmaT3CZ+l5E9hPWLuP6
 S2BwDNpwUoLduNNk1dh8RJRzZDQjXi1+8w6XJz4rslQ03oZrn2TzJ9i566ZSUS0SqfXv
 9uggLzPssXW4XCO1/yYNypPtSLJzI7bs79fde1C2FaV7kwqMWbpq1HrJB79Ii6W43mCK
 X7yoZYql0bk1Nsc834U1Wg3+g3DEdExSD6gWkdU8i67lcCtLXj4h6muxaOdmI3nauXU3
 ZU12BCM+nfCKOZXWQlkBfH8hQ+zY4H+pmEFz9N40+jYD7RBNvStwQCvHGTBeO6KDaiIn
 KuZQ==
X-Gm-Message-State: APjAAAVO9UHF4UmB8fTCA+Ycx1VkCjwPMaudQeOIYwurekhq0QUR/vQb
 OrpjmJgVovEpymV1u8R18GmTZ6hG
X-Google-Smtp-Source: APXvYqyvxcp0nV1xM7ze40fhgo5bnLkStIT36/Ptw8ezXwHTSvoFRG1XZ/JiI80YPJOMqh66NNPZ7A==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr3370327wre.391.1570035117264; 
 Wed, 02 Oct 2019 09:51:57 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.51.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:51:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/30] target/i386: handle filtered_features in a new function
 mark_unavailable_features
Date: Wed,  2 Oct 2019 18:51:25 +0200
Message-Id: <1570035113-56848-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

The next patch will add a different reason for filtering features, unrelated
to host feature support.  Extract a new function that takes care of disabling
the features and optionally reporting them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 87 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9e0bac3..52b3f3e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3096,17 +3096,41 @@ static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
     return NULL;
 }
 
-static void report_unavailable_features(FeatureWord w, uint32_t mask)
+static bool x86_cpu_have_filtered_features(X86CPU *cpu)
 {
+    FeatureWord w;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+         if (cpu->filtered_features[w]) {
+             return true;
+         }
+    }
+
+    return false;
+}
+
+static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
+                                      const char *verbose_prefix)
+{
+    CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
     int i;
     char *feat_word_str;
 
+    if (!cpu->force_features) {
+        env->features[w] &= ~mask;
+    }
+    cpu->filtered_features[w] |= mask;
+
+    if (!verbose_prefix) {
+        return;
+    }
+
     for (i = 0; i < 32; ++i) {
         if ((1UL << i) & mask) {
             feat_word_str = feature_word_description(f, i);
-            warn_report("%s doesn't support requested feature: %s%s%s [bit %d]",
-                        accel_uses_host_cpuid() ? "host" : "TCG",
+            warn_report("%s: %s%s%s [bit %d]",
+                        verbose_prefix,
                         feat_word_str,
                         f->feat_names[i] ? "." : "",
                         f->feat_names[i] ? f->feat_names[i] : "", i);
@@ -3511,7 +3535,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
 }
 
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
-static int x86_cpu_filter_features(X86CPU *cpu);
+static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
 
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
@@ -3576,7 +3600,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         next = &new->next;
     }
 
-    x86_cpu_filter_features(xc);
+    x86_cpu_filter_features(xc, false);
 
     x86_cpu_list_feature_names(xc->filtered_features, next);
 
@@ -3784,15 +3808,6 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
     return r;
 }
 
-static void x86_cpu_report_filtered_features(X86CPU *cpu)
-{
-    FeatureWord w;
-
-    for (w = 0; w < FEATURE_WORDS; w++) {
-        report_unavailable_features(w, cpu->filtered_features[w]);
-    }
-}
-
 static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
 {
     PropValue *pv;
@@ -5154,24 +5169,24 @@ out:
  *
  * Returns: 0 if all flags are supported by the host, non-zero otherwise.
  */
-static int x86_cpu_filter_features(X86CPU *cpu)
+static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
-    int rv = 0;
+    const char *prefix = NULL;
+
+    if (verbose) {
+        prefix = accel_uses_host_cpuid()
+                 ? "host doesn't support requested feature"
+                 : "TCG doesn't support requested feature";
+    }
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         uint32_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
-        uint32_t available_features = requested_features & host_feat;
-        if (!cpu->force_features) {
-            env->features[w] = available_features;
-        }
-        cpu->filtered_features[w] = requested_features & ~available_features;
-        if (cpu->filtered_features[w]) {
-            rv = 1;
-        }
+        uint32_t unavailable_features = requested_features & ~host_feat;
+        mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
@@ -5197,13 +5212,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
              * host can't emulate the capabilities we report on
              * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
              */
-            env->features[FEAT_7_0_EBX] &= ~CPUID_7_0_EBX_INTEL_PT;
-            cpu->filtered_features[FEAT_7_0_EBX] |= CPUID_7_0_EBX_INTEL_PT;
-            rv = 1;
+            mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
         }
     }
-
-    return rv;
 }
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -5244,16 +5255,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
-    if (x86_cpu_filter_features(cpu) &&
-        (cpu->check_cpuid || cpu->enforce_cpuid)) {
-        x86_cpu_report_filtered_features(cpu);
-        if (cpu->enforce_cpuid) {
-            error_setg(&local_err,
-                       accel_uses_host_cpuid() ?
-                           "Host doesn't support requested features" :
-                           "TCG doesn't support requested features");
-            goto out;
-        }
+    x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
+
+    if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
+        error_setg(&local_err,
+                   accel_uses_host_cpuid() ?
+                       "Host doesn't support requested features" :
+                       "TCG doesn't support requested features");
+        goto out;
     }
 
     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
-- 
1.8.3.1



