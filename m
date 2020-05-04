Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3BCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855D720721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Htw0BjOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855D720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeru-00050U-Mi
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVepx-0001wU-Aw
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVepv-0005Gd-OY
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588613098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2j0wqUPebHWLfyYz6iL8kkjnw7WfmxM1B0D7mnsKjQ=;
 b=Htw0BjOEG+ZtjtSlrZUgeQOyzy4V8Zd8N5lGvV2tB3mUDysTE2OrvUqg+1IG41mVUS0cqi
 mMBxVS4C3bWdJcFZgN/VYnGx43DSp0n79+tBqbdoMqHmA+GBka2/U+3C+XHBF8Ev62Wy8y
 h6Zy/uhj85Qvz8VlwgWY9w24dJ60E+4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-IQsJ9heSMfmTTtoOmnPrFw-1; Mon, 04 May 2020 13:24:56 -0400
X-MC-Unique: IQsJ9heSMfmTTtoOmnPrFw-1
Received: by mail-wm1-f72.google.com with SMTP id n127so307670wme.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AbBkM/gfj45zJYp9htQMJfg8nUymcXwOX7nX9TXzWm8=;
 b=HR5D61uIa/0MeToqKmOPsSWxSbk47KXZRVi0C9fy5GnUWSt/ZukU/XnnJMf/C9PodX
 G4L23azLdjj7w417xvHvb1lhc1KXvX/o1x4E0F2adu/kJEllyp/q425jBbV7SLpme74h
 HCBrU6Ms7KSDkePdLs2vgwed4ed095A9dXH3nmgPQaxvH2ht5HR6Zx+yA4dcrUJLUdv5
 NqMI1PTKG9Nk0BGQaEOku5s5Bn8AHqgEOde+IxutEQbwshnwUHDybs4C41TxpNGZ9ecq
 /QpU//cvFhLD7kMIIR/rGCzqYcNCckyqKlSK1SvJ0K3kSD6pDn2HAv7RMfwwytazmdYp
 YAdQ==
X-Gm-Message-State: AGi0PuYMt0CNdCCv9rBzcMmlMv3CGDlpdW3qg2pBtLbbpxHjxyf1OXPe
 E74cDKhdVZQBrMktv0AnzfbMY7wMBo1G2eXQvzdnrsSdMjFYVFLTjWlcU0DYD+HaluoPpE9Skhq
 Lr9R94HKL/q5H0lQ=
X-Received: by 2002:adf:ee86:: with SMTP id b6mr98938wro.419.1588613094636;
 Mon, 04 May 2020 10:24:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypL6qG+6FGDCUjOPb4Q0wRZpM/tfdWIRsDeaecX9ryA9ojz6oLYojelvKEPez1N0RgHN5G3Uaw==
X-Received: by 2002:adf:ee86:: with SMTP id b6mr98924wro.419.1588613094449;
 Mon, 04 May 2020 10:24:54 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id k5sm3556196wrx.16.2020.05.04.10.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 10:24:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/5] target/arm/kvm: Inline set_feature() calls
Date: Mon,  4 May 2020 19:24:44 +0200
Message-Id: <20200504172448.9402-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504172448.9402-1-philmd@redhat.com>
References: <20200504172448.9402-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to move the inlined declarations of set_feature()
from cpu*.c to cpu.h. To avoid clashing with the KVM
declarations, inline the few KVM calls.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/kvm32.c | 13 ++++---------
 target/arm/kvm64.c | 22 ++++++----------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f271181ab8..7b3a19e9ae 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -22,11 +22,6 @@
 #include "internals.h"
 #include "qemu/log.h"
=20
-static inline void set_feature(uint64_t *features, int feature)
-{
-    *features |=3D 1ULL << feature;
-}
-
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     struct kvm_one_reg idreg =3D { .id =3D id, .addr =3D (uintptr_t)pret }=
;
@@ -146,14 +141,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures=
 *ahcf)
      * timers; this in turn implies most of the other feature
      * bits, but a few must be tested.
      */
-    set_feature(&features, ARM_FEATURE_V7VE);
-    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
+    features |=3D 1ULL << ARM_FEATURE_V7VE;
+    features |=3D 1ULL << ARM_FEATURE_GENERIC_TIMER;
=20
     if (extract32(id_pfr0, 12, 4) =3D=3D 1) {
-        set_feature(&features, ARM_FEATURE_THUMB2EE);
+        features |=3D 1ULL << ARM_FEATURE_THUMB2EE;
     }
     if (extract32(ahcf->isar.mvfr1, 12, 4) =3D=3D 1) {
-        set_feature(&features, ARM_FEATURE_NEON);
+        features |=3D 1ULL << ARM_FEATURE_NEON;
     }
=20
     ahcf->features =3D features;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index be5b31c2b0..cd8ab6b8ae 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -447,16 +447,6 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
=20
-static inline void set_feature(uint64_t *features, int feature)
-{
-    *features |=3D 1ULL << feature;
-}
-
-static inline void unset_feature(uint64_t *features, int feature)
-{
-    *features &=3D ~(1ULL << feature);
-}
-
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     uint64_t ret;
@@ -648,11 +638,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures=
 *ahcf)
      * with VFPv4+Neon; this in turn implies most of the other
      * feature bits.
      */
-    set_feature(&features, ARM_FEATURE_V8);
-    set_feature(&features, ARM_FEATURE_NEON);
-    set_feature(&features, ARM_FEATURE_AARCH64);
-    set_feature(&features, ARM_FEATURE_PMU);
-    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
+    features |=3D 1ULL << ARM_FEATURE_V8;
+    features |=3D 1ULL << ARM_FEATURE_NEON;
+    features |=3D 1ULL << ARM_FEATURE_AARCH64;
+    features |=3D 1ULL << ARM_FEATURE_PMU;
+    features |=3D 1ULL << ARM_FEATURE_GENERIC_TIMER;
=20
     ahcf->features =3D features;
=20
@@ -802,7 +792,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (cpu->has_pmu) {
         cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_PMU_V3;
     } else {
-        unset_feature(&env->features, ARM_FEATURE_PMU);
+        env->features &=3D ~(1ULL << ARM_FEATURE_PMU);
     }
     if (cpu_isar_feature(aa64_sve, cpu)) {
         assert(kvm_arm_sve_supported(cs));
--=20
2.21.3


