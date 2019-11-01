Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF310CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7CE204FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VViZHBHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7CE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQSkc-00071d-My
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSez-0001Bx-KN
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSex-0000YM-E0
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSex-0000Ui-5t
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id q70so8592108wme.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GsD3QQxbEUJRJc4Np7QQU7K8ZouwI6xXEaEwME4AcL8=;
 b=VViZHBHOAXkznGeBpvV3TrDjbhhWy6bTtz5Mto/Ho++Zs4qSI7y53ABT58xIgPUimJ
 9yIYS54womdYT70Zhte3kFAhEdbm1yH3H02mviwQGgVNSAGH/4kvW9fRED9fYE14ZXOL
 M9xC9vNBv2I4sm8Mf/DDoBm2wCZAtWIwOzok/GzxqmY5+t5XWsUGUbcV1OLmk/K9gSvg
 ShaivVfhQ9K0NcWS9fJHOAKc7PQ6fjQB0gEPsK5Kf7M9J1D1HXwgLlKMhMgnG4KpyDsQ
 Kir9p/T7zKxwIpG9l6gJgoRB23fJnvm9b6m+Mz5JqNYa756ioxoxE+ba/pubUcKLHEw8
 obkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GsD3QQxbEUJRJc4Np7QQU7K8ZouwI6xXEaEwME4AcL8=;
 b=SqnT7r0oEOzdX22xht8Xlhbct6g8NuBYmmTuxb8joo9unjSx1/7gIIs2ZQtcM6c0IH
 bYwbbfxPRjMgT5DcV/SGT0ubnVwtElA/NbA6tM6nYchFZIR77uYgzyeSoYTIENm7o+RL
 UpcVZwYYMVYZ5ER9dQ4SWkBC9RrIXb18hMNBK3LMdABJcLuIEstVUZi61R1nAhLi8GmY
 dsIObVpoo5/MrlP8uxMsmFjobULvoGzP2hurV60kpLa+0Um/XbBvqXpoJQreQGwR9/GU
 IlDsXTz2MlNx5dX1JJfBxd744FqOx5DvXkpnXpesvj6ECmZjSNBfrckETh+sZubvDWjZ
 cGRg==
X-Gm-Message-State: APjAAAV0L/QcoUwSCCtWvyxbzO1Ygd6Z59PrQiR7HKge6DflpD3oFEah
 l9NNTTWHDfRiQkLvcL8QZ1ABlUPNuEWCvP+c
X-Google-Smtp-Source: APXvYqzCGTTRSRurd3h+rtwzzQmOKopoALJSeeoo6Tf0LUwwXTfoJhUp8UQyu0l20cZRd872dvcPcw==
X-Received: by 2002:a05:600c:1150:: with SMTP id
 z16mr9541358wmz.153.1572598313714; 
 Fri, 01 Nov 2019 01:51:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d20sm8818922wra.4.2019.11.01.01.51.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:51:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] target/arm/kvm: host cpu: Add support for sve<N>
 properties
Date: Fri,  1 Nov 2019 08:51:38 +0000
Message-Id: <20191101085140.5205-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101085140.5205-1-peter.maydell@linaro.org>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

From: Andrew Jones <drjones@redhat.com>

Allow cpu 'host' to enable SVE when it's available, unless the
user chooses to disable it with the added 'sve=off' cpu property.
Also give the user the ability to select vector lengths with the
sve<N> properties. We don't adopt 'max' cpu's other sve property,
sve-max-vq, because that property is difficult to use with KVM.
That property assumes all vector lengths in the range from 1 up
to and including the specified maximum length are supported, but
there may be optional lengths not supported by the host in that
range. With KVM one must be more specific when enabling vector
lengths.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Message-id: 20191031142734.8590-10-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          |  2 ++
 target/arm/cpu.c          |  3 +++
 target/arm/cpu64.c        | 33 +++++++++++++++++----------------
 target/arm/kvm64.c        | 14 +++++++++++++-
 tests/arm-cpu-features.c  | 17 ++++++++---------
 docs/arm-cpu-features.rst | 19 ++++++++++++-------
 6 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a044d6028b6..e1a66a2d1cc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -977,11 +977,13 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
+void aarch64_add_sve_properties(Object *obj);
 #else
 static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
 static inline void aarch64_sve_change_el(CPUARMState *env, int o,
                                          int n, bool a)
 { }
+static inline void aarch64_add_sve_properties(Object *obj) { }
 #endif
 
 #if !defined(CONFIG_TCG)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 17d1f2b2894..7a4ac9339bf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2670,6 +2670,9 @@ static void arm_host_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     kvm_arm_set_cpu_features_from_host(cpu);
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        aarch64_add_sve_properties(obj);
+    }
     arm_cpu_post_init(obj);
 }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c161a146ff0..68baf0482ff 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -594,6 +594,21 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
     cpu->isar.id_aa64pfr0 = t;
 }
 
+void aarch64_add_sve_properties(Object *obj)
+{
+    uint32_t vq;
+
+    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
+                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
+
+    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
+        char name[8];
+        sprintf(name, "sve%d", vq * 128);
+        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
+                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
+    }
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -602,17 +617,11 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
 static void aarch64_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    uint32_t vq;
-    uint64_t t;
 
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
-        if (kvm_arm_sve_supported(CPU(cpu))) {
-            t = cpu->isar.id_aa64pfr0;
-            t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
-            cpu->isar.id_aa64pfr0 = t;
-        }
     } else {
+        uint64_t t;
         uint32_t u;
         aarch64_a57_initfn(obj);
 
@@ -712,17 +721,9 @@ static void aarch64_max_initfn(Object *obj)
 #endif
     }
 
-    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
-                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
+    aarch64_add_sve_properties(obj);
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
                         cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
-
-    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
-        char name[8];
-        sprintf(name, "sve%d", vq * 128);
-        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
-                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
-    }
 }
 
 struct ARMCPUInfo {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index c93bbee425a..876184b8fe4 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -488,7 +488,9 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * and then query that CPU for the relevant ID registers.
      */
     int fdarray[3];
+    bool sve_supported;
     uint64_t features = 0;
+    uint64_t t;
     int err;
 
     /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
@@ -578,13 +580,23 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
     }
 
+    sve_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0;
+
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
     if (err < 0) {
         return false;
     }
 
-   /* We can assume any KVM supporting CPU is at least a v8
+    /* Add feature bits that can't appear until after VCPU init. */
+    if (sve_supported) {
+        t = ahcf->isar.id_aa64pfr0;
+        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
+        ahcf->isar.id_aa64pfr0 = t;
+    }
+
+    /*
+     * We can assume any KVM supporting CPU is at least a v8
      * with VFPv4+Neon; this in turn implies most of the other
      * feature bits.
      */
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 40d8395b7f7..b132ed09806 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -458,8 +458,8 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
             "We cannot guarantee the CPU type 'cortex-a15' works "
             "with KVM on this host", NULL);
 
-        assert_has_feature(qts, "max", "sve");
-        resp = do_query_no_props(qts, "max");
+        assert_has_feature(qts, "host", "sve");
+        resp = do_query_no_props(qts, "host");
         kvm_supports_sve = resp_get_feature(resp, "sve");
         vls = resp_get_sve_vls(resp);
         qobject_unref(resp);
@@ -470,7 +470,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
             sprintf(max_name, "sve%d", max_vq * 128);
 
             /* Enabling a supported length is of course fine. */
-            assert_sve_vls(qts, "max", vls, "{ %s: true }", max_name);
+            assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
 
             /* Get the next supported length smaller than max-vq. */
             vq = 64 - __builtin_clzll(vls & ~BIT_ULL(max_vq - 1));
@@ -479,7 +479,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
                  * We have at least one length smaller than max-vq,
                  * so we can disable max-vq.
                  */
-                assert_sve_vls(qts, "max", (vls & ~BIT_ULL(max_vq - 1)),
+                assert_sve_vls(qts, "host", (vls & ~BIT_ULL(max_vq - 1)),
                                "{ %s: false }", max_name);
 
                 /*
@@ -489,7 +489,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
                  */
                 sprintf(name, "sve%d", vq * 128);
                 error = g_strdup_printf("cannot disable %s", name);
-                assert_error(qts, "max", error,
+                assert_error(qts, "host", error,
                              "{ %s: true, %s: false }",
                              max_name, name);
                 g_free(error);
@@ -502,7 +502,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
             vq = __builtin_ffsll(vls);
             sprintf(name, "sve%d", vq * 128);
             error = g_strdup_printf("cannot disable %s", name);
-            assert_error(qts, "max", error, "{ %s: false }", name);
+            assert_error(qts, "host", error, "{ %s: false }", name);
             g_free(error);
 
             /* Get an unsupported length. */
@@ -514,7 +514,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
             if (vq <= SVE_MAX_VQ) {
                 sprintf(name, "sve%d", vq * 128);
                 error = g_strdup_printf("cannot enable %s", name);
-                assert_error(qts, "max", error, "{ %s: true }", name);
+                assert_error(qts, "host", error, "{ %s: true }", name);
                 g_free(error);
             }
         } else {
@@ -523,8 +523,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
     } else {
         assert_has_not_feature(qts, "host", "aarch64");
         assert_has_not_feature(qts, "host", "pmu");
-
-        assert_has_not_feature(qts, "max", "sve");
+        assert_has_not_feature(qts, "host", "sve");
     }
 
     qtest_quit(qts);
diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index bed218d4461..1b367e22e16 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -272,31 +272,36 @@ SVE CPU Property Examples
 
      $ qemu-system-aarch64 -M virt -cpu max
 
-  3) Only enable the 128-bit vector length::
+  3) When KVM is enabled, implicitly enable all host CPU supported vector
+     lengths with the `host` CPU type::
+
+     $ qemu-system-aarch64 -M virt,accel=kvm -cpu host
+
+  4) Only enable the 128-bit vector length::
 
      $ qemu-system-aarch64 -M virt -cpu max,sve128=on
 
-  4) Disable the 512-bit vector length and all larger vector lengths,
+  5) Disable the 512-bit vector length and all larger vector lengths,
      since 512 is a power-of-two.  This results in all the smaller,
      uninitialized lengths (128, 256, and 384) defaulting to enabled::
 
      $ qemu-system-aarch64 -M virt -cpu max,sve512=off
 
-  5) Enable the 128-bit, 256-bit, and 512-bit vector lengths::
+  6) Enable the 128-bit, 256-bit, and 512-bit vector lengths::
 
      $ qemu-system-aarch64 -M virt -cpu max,sve128=on,sve256=on,sve512=on
 
-  6) The same as (5), but since the 128-bit and 256-bit vector
+  7) The same as (6), but since the 128-bit and 256-bit vector
      lengths are required for the 512-bit vector length to be enabled,
      then allow them to be auto-enabled::
 
      $ qemu-system-aarch64 -M virt -cpu max,sve512=on
 
-  7) Do the same as (6), but by first disabling SVE and then re-enabling it::
+  8) Do the same as (7), but by first disabling SVE and then re-enabling it::
 
      $ qemu-system-aarch64 -M virt -cpu max,sve=off,sve512=on,sve=on
 
-  8) Force errors regarding the last vector length::
+  9) Force errors regarding the last vector length::
 
      $ qemu-system-aarch64 -M virt -cpu max,sve128=off
      $ qemu-system-aarch64 -M virt -cpu max,sve=off,sve128=off,sve=on
@@ -308,5 +313,5 @@ The examples in "SVE CPU Property Examples" exhibit many ways to select
 vector lengths which developers may find useful in order to avoid overly
 verbose command lines.  However, the recommended way to select vector
 lengths is to explicitly enable each desired length.  Therefore only
-example's (1), (3), and (5) exhibit recommended uses of the properties.
+example's (1), (4), and (6) exhibit recommended uses of the properties.
 
-- 
2.20.1


