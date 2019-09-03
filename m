Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF6FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A451222CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A451222CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B91-0003xD-Js
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i5B2h-0004sj-9z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i5B2f-0005Wa-UV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:48:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i5B2a-0005Pl-Aa; Tue, 03 Sep 2019 11:48:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B3E23082B6D;
 Tue,  3 Sep 2019 15:48:18 +0000 (UTC)
Received: from thuth.com (ovpn-117-51.ams2.redhat.com [10.36.117.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D06D19D7A;
 Tue,  3 Sep 2019 15:48:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  3 Sep 2019 17:48:08 +0200
Message-Id: <20190903154810.27365-2-thuth@redhat.com>
In-Reply-To: <20190903154810.27365-1-thuth@redhat.com>
References: <20190903154810.27365-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 03 Sep 2019 15:48:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 1/3] target/arm: Make cpu_register() and
 set_feature() available for other files
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the common set_feature() and unset_feature() functions from cpu.c and
cpu64.c to cpu.h, and make cpu_register() (renamed to arm_cpu_register())
available from there, too, so we can register CPUs also from other files
in the future.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/arm/cpu.c   | 20 ++------------------
 target/arm/cpu.h   | 18 ++++++++++++++++++
 target/arm/cpu64.c | 16 ----------------
 3 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c14471..f1f9eecdc8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -614,16 +614,6 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 
 #endif
 
-static inline void set_feature(CPUARMState *env, int feature)
-{
-    env->features |= 1ULL << feature;
-}
-
-static inline void unset_feature(CPUARMState *env, int feature)
-{
-    env->features &= ~(1ULL << feature);
-}
-
 static int
 print_insn_thumb1(bfd_vma pc, disassemble_info *info)
 {
@@ -2515,12 +2505,6 @@ static void arm_max_initfn(Object *obj)
 
 #endif /* !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64) */
 
-struct ARMCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
-};
-
 static const ARMCPUInfo arm_cpus[] = {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
     { .name = "arm926",      .initfn = arm926_initfn },
@@ -2681,7 +2665,7 @@ static void cpu_register_class_init(ObjectClass *oc, void *data)
     acc->info = data;
 }
 
-static void cpu_register(const ARMCPUInfo *info)
+void arm_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
         .parent = TYPE_ARM_CPU,
@@ -2722,7 +2706,7 @@ static void arm_cpu_register_types(void)
     type_register_static(&idau_interface_type_info);
 
     while (info->name) {
-        cpu_register(info);
+        arm_cpu_register(info);
         info++;
     }
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0981303170..c5007edf1f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3600,4 +3600,22 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 #define cpu_isar_feature(name, cpu) \
     ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
 
+static inline void set_feature(CPUARMState *env, int feature)
+{
+    env->features |= 1ULL << feature;
+}
+
+static inline void unset_feature(CPUARMState *env, int feature)
+{
+    env->features &= ~(1ULL << feature);
+}
+
+struct ARMCPUInfo {
+    const char *name;
+    void (*initfn)(Object *obj);
+    void (*class_init)(ObjectClass *oc, void *data);
+};
+
+void arm_cpu_register(const ARMCPUInfo *info);
+
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d7f5bf610a..869cec13ca 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -29,16 +29,6 @@
 #include "kvm_arm.h"
 #include "qapi/visitor.h"
 
-static inline void set_feature(CPUARMState *env, int feature)
-{
-    env->features |= 1ULL << feature;
-}
-
-static inline void unset_feature(CPUARMState *env, int feature)
-{
-    env->features &= ~(1ULL << feature);
-}
-
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
@@ -396,12 +386,6 @@ static void aarch64_max_initfn(Object *obj)
     }
 }
 
-struct ARMCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
-};
-
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-- 
2.18.1


