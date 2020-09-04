Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6954C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A854D206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Y1JISe4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A854D206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE2uf-0000Ze-PB
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 00:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2hb-0002iS-CE; Thu, 03 Sep 2020 23:47:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2hZ-0004wi-9C; Thu, 03 Sep 2020 23:47:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjNsq6f0Qz9sVy; Fri,  4 Sep 2020 13:47:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599191247;
 bh=gMiAtQjsk/Rf8aQpgZPjpS1b6eRF/e1DiGSzGhHBsJ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y1JISe4A0pk3vSHwfvCc5D/S917UE27vRuqXYJkMPiFSBqmM4F1aUfhAleuCP+cBA
 Hq5xGhIxIKPthviG//6dZhBvrTfmdfR62FA6/PdRd66UKtb6YZHlNknEGbX/PQYjdw
 /rSI5wjxde/ZUBhP/UQB/eoOJiXyHjABlEVykTmk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/30] target/arm: Move start-powered-off property to generic
 CPUState
Date: Fri,  4 Sep 2020 13:47:04 +1000
Message-Id: <20200904034719.673626-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904034719.673626-1-david@gibson.dropbear.id.au>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, danielhb413@gmail.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 bauerman@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

There are other platforms which also have CPUs that start powered off, so
generalize the start-powered-off property so that it can be used by them.

Note that ARMv7MState also has a property of the same name but this patch
doesn't change it because that class isn't a subclass of CPUState so it
wouldn't be a trivial change.

This change should not cause any change in behavior.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Message-Id: <20200826055535.951207-2-bauerman@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 exec.c                | 1 +
 include/hw/core/cpu.h | 4 ++++
 target/arm/cpu.c      | 5 ++---
 target/arm/cpu.h      | 3 ---
 target/arm/kvm32.c    | 2 +-
 target/arm/kvm64.c    | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index 7683afb6a8..e34b602bdf 100644
--- a/exec.c
+++ b/exec.c
@@ -899,6 +899,7 @@ Property cpu_common_props[] = {
     DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
 #endif
+    DEFINE_PROP_BOOL("start-powered-off", CPUState, start_powered_off, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8f145733ce..9fc2696db5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -374,6 +374,10 @@ struct CPUState {
     bool created;
     bool stop;
     bool stopped;
+
+    /* Should CPU start in powered-off state? */
+    bool start_powered_off;
+
     bool unplug;
     bool crash_occurred;
     bool exit_request;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c179e0752d..9f814194fb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -174,8 +174,8 @@ static void arm_cpu_reset(DeviceState *dev)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
-    cpu->power_state = cpu->start_powered_off ? PSCI_OFF : PSCI_ON;
-    s->halted = cpu->start_powered_off;
+    cpu->power_state = s->start_powered_off ? PSCI_OFF : PSCI_ON;
+    s->halted = s->start_powered_off;
 
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
         env->iwmmxt.cregs[ARM_IWMMXT_wCID] = 0x69051000 | 'Q';
@@ -2186,7 +2186,6 @@ static const ARMCPUInfo arm_cpus[] = {
 };
 
 static Property arm_cpu_properties[] = {
-    DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, false),
     DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
     DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a1c7d8ebae..6036f61d60 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -817,9 +817,6 @@ struct ARMCPU {
      */
     uint32_t psci_version;
 
-    /* Should CPU start in PSCI powered-off state? */
-    bool start_powered_off;
-
     /* Current power state, access guarded by BQL */
     ARMPSCIState power_state;
 
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 0af46b41c8..1f2b8f8b7a 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -218,7 +218,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
-    if (cpu->start_powered_off) {
+    if (cs->start_powered_off) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
     }
     if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ef1e960285..987b35e33f 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -774,7 +774,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
-    if (cpu->start_powered_off) {
+    if (cs->start_powered_off) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
     }
     if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
-- 
2.26.2


