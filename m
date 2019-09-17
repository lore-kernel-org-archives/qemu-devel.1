Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D9CC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D64321852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+yj1Smt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D64321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAxF-00018f-I3
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAop-0001mh-8n
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAon-0004xH-A7
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iAAon-0004wg-12
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so2570889wrx.5
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s6juWaeJdvbdYfQYOPZtIdvf+1dOdIoXW07/VCUIeko=;
 b=B+yj1SmtCGI/clemc6E3xUgJ5QKLA3T5NhFvCpWor2+JCztY+5LAP5uZUQg+0+52qh
 kfqRmcgzJDi3xXZ6bu1q/tkRJojc6D/x99w+g12QGrCPtAg2Egcn1iTT9+Ft8sEEYkbU
 l7XZvctacAMoxU2939hWxdeYCq0mwFQJ9J0xh1yZoJsx3vGyuY3dfz8DxvJO/rn3r0sO
 oSWS3YKL+Tigf7JYQNv0+KN6+BbWQ6BthttY+vi9Q5GRJLuiiV/DKjU0zjJhIqcO/+nc
 gWinqpwX88VPuhoJg3WEMp5LTaBR/61Hg8+3M+wHaW4EYImwTNg8BGT2oGltuL8HD+0f
 2G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=s6juWaeJdvbdYfQYOPZtIdvf+1dOdIoXW07/VCUIeko=;
 b=nb5Bm2lYYasWZWTfN505VvIRVXpdlYz5SZRH5XwoeZonJQZp7kuMbnCovi8FEbJZci
 ep7zgy4oPmPApz/ygRjQVWK+xrzro8qk9mBbCLl40jMU6/bluYPMnrqJC4eE00k8NXYb
 TcSYY7nRHQjyvFVtFS1cAKJtqDmJiyiBudykDF+1QIYaEU8M/Q/t0LALZS57/2VXAysb
 VG0rUlO1CNGmj6HYBhG8zvqebEm1FPOCQhVsT02ruPYsEZI+W3a+AV5JZz8bx+KR3EXT
 gWfjUfPcK2GgldwQCZ4Rf6RJid7j/bjTgLxSDQLbcvvEKFLysAzQbyRuFL/8AuwMDIuE
 B83w==
X-Gm-Message-State: APjAAAWb+ZbjEoxaIEQXAQJeoGFY8+EmuQklTQkmi5es8oHO5kt4L+qE
 oajJeiv+lSxrUpLmDEGkssktoVh5
X-Google-Smtp-Source: APXvYqw33fJqo93vWETnpnRY06pOLwDoSG7YDqAN5ll6QpFut9UPeXZLombmHVo86GiJUNNyHhg6rQ==
X-Received: by 2002:adf:ead2:: with SMTP id o18mr2337793wrn.107.1568716483687; 
 Tue, 17 Sep 2019 03:34:43 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q3sm1985415wrm.86.2019.09.17.03.34.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:34:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:34:34 +0200
Message-Id: <1568716480-9973-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
References: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 1/7] target/i386: handle filtered_features in a
 new function mark_unavailable_features
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
Cc: liran.alon@oracle.com, ehabkost@redhat.com
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



