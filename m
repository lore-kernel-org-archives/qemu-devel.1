Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5959DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225CE205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmIE8y0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225CE205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtkC-0001fe-Ca
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsGP-00043U-AP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsGO-0006UU-2d
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsGN-0006SH-Ub
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36JPzoDFwtpu9mZ2fPnU6GKIA7vaoxIQMhsyqosn0aE=;
 b=UmIE8y0uIJJrTiJcThtamZZ+8P5h2Lg70OZFskITG6CSLicKHTxfEjm76j5to4kPZtk6RP
 KOt0jdwGmMNIy7imtt3RtXn3nBAh1e3n47ubIRuNfxHqDVi4Spbi1vntVIzHtOUtwhX3Ak
 I5h390i3Bs3KrIfrB8IHLmHOzKl5Cvo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-f_fmdmO2Oj6KH5MlYH8ihg-1; Mon, 16 Mar 2020 12:06:45 -0400
X-MC-Unique: f_fmdmO2Oj6KH5MlYH8ihg-1
Received: by mail-wr1-f72.google.com with SMTP id 94so4576156wrr.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WUQmK3jX+ITRgjT53gJOYB77qbIWiqXEgYr8J8FbjTA=;
 b=jI/BQtLfu792Uz4cNSkvCpMYXFLGSmkpU8YxCcWk814dhv2HfOQ3GYhnMCSdtd/ZiA
 520JHE55pvC9P8mV0POGFdccMJKG4d6nybIrJPg16MPURiFhyWKmTEiEbT2nE721nu/g
 ohBFN/Z49gTKzQl4J6bskGooyWA0BfrplwOIyIQA0dpo0JBF5rv/oxKSOVQTOh92v4zM
 tFBYtp4jKQFPvLrUpsXU6KCV405u32HQueUWsUgEDNOMEEUEjGahJXClBIyFg1RK7YhQ
 nJ/CHtnBcnVN/azGnDeTDCXh6axBixgAS57X7VDGfEsWa63kqhC1ikBdpw4GS5cxtEa2
 WzeA==
X-Gm-Message-State: ANhLgQ0KbfuTagtOEcCPaZLpgMQ+JDarMqhsN3ypMu7/so7IYc4LjkeV
 J47PRLzjZXCsqcIIfAQdoLsFoMjTomq4YKOixDIUF/25Z8jQNQ3MHh3LLQqBwm4XXY91Mut6msZ
 KGtB1gx452XpFbnY=
X-Received: by 2002:a1c:ab04:: with SMTP id u4mr28378906wme.88.1584374803976; 
 Mon, 16 Mar 2020 09:06:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtV0XnwGOD9HZ+gDhSELi6gG1sO2wgoMuiEbFWxHuGz29Lw9cyiUjcbAj92lhznjafti4kUQw==
X-Received: by 2002:a1c:ab04:: with SMTP id u4mr28378818wme.88.1584374802766; 
 Mon, 16 Mar 2020 09:06:42 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id a10sm480884wrv.89.2020.03.16.09.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:06:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/19] target/arm: Rename KVM set_feature() as
 kvm_set_feature()
Date: Mon, 16 Mar 2020 17:06:16 +0100
Message-Id: <20200316160634.3386-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/kvm32.c | 10 +++++-----
 target/arm/kvm64.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f271181ab8..0ab28b473a 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -22,7 +22,7 @@
 #include "internals.h"
 #include "qemu/log.h"
=20
-static inline void set_feature(uint64_t *features, int feature)
+static inline void kvm_set_feature(uint64_t *features, int feature)
 {
     *features |=3D 1ULL << feature;
 }
@@ -146,14 +146,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures=
 *ahcf)
      * timers; this in turn implies most of the other feature
      * bits, but a few must be tested.
      */
-    set_feature(&features, ARM_FEATURE_V7VE);
-    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
+    kvm_set_feature(&features, ARM_FEATURE_V7VE);
+    kvm_set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
=20
     if (extract32(id_pfr0, 12, 4) =3D=3D 1) {
-        set_feature(&features, ARM_FEATURE_THUMB2EE);
+        kvm_set_feature(&features, ARM_FEATURE_THUMB2EE);
     }
     if (extract32(ahcf->isar.mvfr1, 12, 4) =3D=3D 1) {
-        set_feature(&features, ARM_FEATURE_NEON);
+        kvm_set_feature(&features, ARM_FEATURE_NEON);
     }
=20
     ahcf->features =3D features;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index be5b31c2b0..ad33e048e4 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -447,12 +447,12 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
=20
-static inline void set_feature(uint64_t *features, int feature)
+static inline void kvm_set_feature(uint64_t *features, int feature)
 {
     *features |=3D 1ULL << feature;
 }
=20
-static inline void unset_feature(uint64_t *features, int feature)
+static inline void kvm_unset_feature(uint64_t *features, int feature)
 {
     *features &=3D ~(1ULL << feature);
 }
@@ -648,11 +648,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures=
 *ahcf)
      * with VFPv4+Neon; this in turn implies most of the other
      * feature bits.
      */
-    set_feature(&features, ARM_FEATURE_V8);
-    set_feature(&features, ARM_FEATURE_NEON);
-    set_feature(&features, ARM_FEATURE_AARCH64);
-    set_feature(&features, ARM_FEATURE_PMU);
-    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
+    kvm_set_feature(&features, ARM_FEATURE_V8);
+    kvm_set_feature(&features, ARM_FEATURE_NEON);
+    kvm_set_feature(&features, ARM_FEATURE_AARCH64);
+    kvm_set_feature(&features, ARM_FEATURE_PMU);
+    kvm_set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
=20
     ahcf->features =3D features;
=20
@@ -802,7 +802,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (cpu->has_pmu) {
         cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_PMU_V3;
     } else {
-        unset_feature(&env->features, ARM_FEATURE_PMU);
+        kvm_unset_feature(&env->features, ARM_FEATURE_PMU);
     }
     if (cpu_isar_feature(aa64_sve, cpu)) {
         assert(kvm_arm_sve_supported(cs));
--=20
2.21.1


