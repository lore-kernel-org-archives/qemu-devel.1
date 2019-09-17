Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF10C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B83B21881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMFQ2Zpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B83B21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAB5r-0001ME-9o
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAot-0001p1-2L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAor-0004zJ-3j
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iAAop-0004xL-BU
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id v17so2494622wml.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FRGhgVOwY1ofv0mbUj5TGM+MvOHQ8R0yf6r9ZTR8PxU=;
 b=sMFQ2Zpz6cdzGz3X5gV3tbRF5GwtbX+fn1jsUNJYKpSaLbLwxxZgeoCF17jHDDBzz3
 ozI8jOJ5VoPJwhnY7UfQb7BfCQ9AjftxqnX03PsDBfDQ0TPuyMJJr6uehl5RE/xbJqBW
 2XTGgh8aHF1pCTGmo+27lC+qmdihjPRpLYzlq6StlO3mo2fQjZUrKC6uki33UJL37v3U
 l8W5jtMLWD1quRGfgNS/pEDOputy8f3erpbUlf0aB0OA5685da02GAJHKMjx220erGt0
 jxKPsnehBI7K8tYSOyA4zylBzg+GNCzQko9zM+ozvxqz0/0XoIjW+NLPqEBb7f4xRAZ1
 mhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=FRGhgVOwY1ofv0mbUj5TGM+MvOHQ8R0yf6r9ZTR8PxU=;
 b=m4Em56CDRI6UDtSdb9zDTKzHX26vWPw1pqd13UPqnLCAwhHYpR+6TfDRjsq/uQ2Uv3
 AwAiXLhQfWj5O4RTRDlh3wQ0rsQdq7qUWDM84VW8fEpFHUDKj/p0qALURYdzh4Krj5Qg
 3094yRu1vxKRBbcWW2HiFng8pvqYFlRusdRLUaLWKWATUSclo08RfpGFy7XSA0VDT15d
 K84NDs6QTHC2G3LQDmGF3gNEuMsSvKvdnJ7juE/6GdY3eF5mBpShIYmiEmPGdSx6Cq7/
 gkx/54ugwlJio84PEtO0jEvfvMBykQVemTuwyZrrpdUDBeqCWFd69k6zFDKmJ5LBSc2t
 s/ig==
X-Gm-Message-State: APjAAAXKFrMn7ACUMQ+jBGdkRhCEhjQ9qU8r5wYLzG18eTecNEIM2png
 6daMi623mHyHiwY283leKPTvDaar
X-Google-Smtp-Source: APXvYqwDarxKJVB3lCqguNzgdCSwryD09t9aYFyRoqYs0k5S9asNV5/5Fz5jj138wYqdTPp1wwLZTw==
X-Received: by 2002:a1c:f602:: with SMTP id w2mr2769497wmc.145.1568716484659; 
 Tue, 17 Sep 2019 03:34:44 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q3sm1985415wrm.86.2019.09.17.03.34.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:34:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:34:35 +0200
Message-Id: <1568716480-9973-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
References: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 2/7] target/i386: introduce generic feature
 dependency mechanism
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

Sometimes a CPU feature does not make sense unless another is
present.  In the case of VMX features, KVM does not even allow
setting the VMX controls to some invalid combinations.

Therefore, this patch adds a generic mechanism that looks for bits
that the user explicitly cleared, and uses them to remove other bits
from the expanded CPU definition.  If these dependent bits were also
explicitly *set* by the user, this will be a warning for "-cpu check"
and an error for "-cpu enforce".  If not, then the dependent bits are
cleared silently, for convenience.

With VMX features, this will be used so that for example
"-cpu host,-rdrand" will also hide support for RDRAND exiting.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 72 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 52b3f3e..fae458c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -801,10 +801,6 @@ typedef struct FeatureWordInfo {
         /* If type==MSR_FEATURE_WORD */
         struct {
             uint32_t index;
-            struct {   /*CPUID that enumerate this MSR*/
-                FeatureWord cpuid_class;
-                uint32_t    cpuid_flag;
-            } cpuid_dep;
         } msr;
     };
     uint32_t tcg_features; /* Feature flags supported by TCG */
@@ -1218,10 +1214,6 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
-            .cpuid_dep = {
-                FEAT_7_0_EDX,
-                CPUID_7_0_EDX_ARCH_CAPABILITIES
-            }
         },
     },
     [FEAT_CORE_CAPABILITY] = {
@@ -1238,14 +1230,30 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_CORE_CAPABILITY,
-            .cpuid_dep = {
-                FEAT_7_0_EDX,
-                CPUID_7_0_EDX_CORE_CAPABILITY,
-            },
         },
     },
 };
 
+typedef struct FeatureMask {
+    FeatureWord index;
+    uint32_t mask;
+} FeatureMask;
+
+typedef struct FeatureDep {
+    FeatureMask from, to;
+} FeatureDep;
+
+static FeatureDep feature_dependencies[] = {
+    {
+        .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
+        .to = { FEAT_ARCH_CAPABILITIES,     ~0u },
+    },
+    {
+        .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
+        .to = { FEAT_CORE_CAPABILITY,       ~0u },
+    },
+};
+
 typedef struct X86RegisterInfo32 {
     /* Name of register */
     const char *name;
@@ -5063,9 +5071,26 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
+    int i;
     GList *l;
     Error *local_err = NULL;
 
+    for (l = plus_features; l; l = l->next) {
+        const char *prop = l->data;
+        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    for (l = minus_features; l; l = l->next) {
+        const char *prop = l->data;
+        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
     /*TODO: Now cpu->max_features doesn't overwrite features
      * set using QOM properties, and we can convert
      * plus_features & minus_features to global properties
@@ -5083,19 +5108,18 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    for (l = plus_features; l; l = l->next) {
-        const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
+    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
+        FeatureDep *d = &feature_dependencies[i];
+        if (!(env->features[d->from.index] & d->from.mask)) {
+            uint32_t unavailable_features = env->features[d->to.index] & d->to.mask;
 
-    for (l = minus_features; l; l = l->next) {
-        const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
-        if (local_err) {
-            goto out;
+            /* Not an error unless the dependent feature was added explicitly.  */
+            mark_unavailable_features(cpu, d->to.index,
+                                      unavailable_features & env->user_features[d->to.index],
+                                      "This feature depends on other features that were not requested");
+
+            env->user_features[d->to.index] |= unavailable_features;
+            env->features[d->to.index] &= ~unavailable_features;
         }
     }
 
-- 
1.8.3.1



