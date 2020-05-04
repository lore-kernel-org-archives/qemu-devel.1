Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A47DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BAD20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm/DKl2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BAD20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVesN-0005dW-3G
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVeqA-0002TU-Pw
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVeq9-0005PC-SC
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588613113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eji01/SBPkfeU3Z/BdrMTnTdR9yItWqYRqGxG9pfew4=;
 b=Qm/DKl2lvNhNVm3DSzBuzmQkY5qtNu/YQsg75NAedaHjrI+/wjkFuZsXV5Hi8Duts/SK3J
 cu8j/d3Eb3c9qZz7XLtOUSV/lZkM7vMLgkIpLFG7w7kve/X2eWSBhvw1+a5QZFQ4aYnEnL
 De9qq5cOIiyE9TcD6R1bsihnQZvtc9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-pnn2eaeKNieCe_BPyUC4wQ-1; Mon, 04 May 2020 13:25:07 -0400
X-MC-Unique: pnn2eaeKNieCe_BPyUC4wQ-1
Received: by mail-wr1-f71.google.com with SMTP id y4so221515wrt.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ns/oosgPvEQDCh0mvkSvxQ2e1s0FFrQb4T4+vlueLeQ=;
 b=K7wzGTovf5IaU0ABc459ULTY6zu2lCw/Iws56MPQa5Q6vqh2X88Mjj83TUokINIYmY
 nnuolMsJssBop9TDPnnJIWLe9BtxD7A6vyGVCVWmoRpYTVwYQLMXuiaLnI9ibVIbEdgY
 mmClBUL6Qb/mz2dS2XTtHiezCPXPH05V0L+XYVrfLDnIVHRyyBB2K5RYcC9SekH7gp45
 GaP/PpFA8Pwj6SKXAymrps66EDA+jZJA5u+4adRnye/aM++0BhgZ7294YcPF0TvEMoTQ
 2wXjeIE6Ff/xNtIGUOiZDxvMYL6LomANoS+JsmCuZNm7zFraYhJS+S0hGBk9eXTg7DIu
 l84A==
X-Gm-Message-State: AGi0PuY5vIq8WiQI+iWfv7z5r06kdgZf9+kgVtCP/rduXH/KRlU36nZ/
 aipqiPBoEwemnpGDcIWMyT47wXsZVtK2e/8eD7RXsoUGiNjiTT1Y6/c21/dPKzp+L1JOteG3le1
 1H0Hpk8yxGwDsFtk=
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr15538324wmf.60.1588613103929; 
 Mon, 04 May 2020 10:25:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypKTqYOS5s3AcQ8q6h/AX9iBLHJQKHc+rSJ9aOh3VxyWLp00Ca5QccicV0Fdm+dFxXvKRybQ0w==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr15538304wmf.60.1588613103651; 
 Mon, 04 May 2020 10:25:03 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id b66sm179291wmh.12.2020.05.04.10.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 10:25:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] target/arm/cpu: Use ARRAY_SIZE() to iterate over
 ARMCPUInfo[]
Date: Mon,  4 May 2020 19:24:46 +0200
Message-Id: <20200504172448.9402-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504172448.9402-1-philmd@redhat.com>
References: <20200504172448.9402-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Use ARRAY_SIZE() to iterate over ARMCPUInfo[].

Since on the aarch64-linux-user build, arm_cpus[] is empty, add
the cpu_count variable and only iterate when it is non-zero.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Without using cpu_count we get:

target/arm/cpu.c:2904:19: error: comparison of unsigned expression < 0 is a=
lways false [-Werror=3Dtype-limits]
 2904 |     for (i =3D 0; i < ARRAY_SIZE(arm_cpus); ++i) {
      |                   ^
cc1: all warnings being treated as errors
---
 target/arm/cpu.c   | 16 +++++++++-------
 target/arm/cpu64.c |  8 +++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 13959cb643..b4d73dd47c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2739,7 +2739,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "any",         .initfn =3D arm_max_initfn },
 #endif
 #endif
-    { .name =3D NULL }
 };
=20
 static Property arm_cpu_properties[] =3D {
@@ -2887,19 +2886,22 @@ static const TypeInfo idau_interface_type_info =3D =
{
=20
 static void arm_cpu_register_types(void)
 {
-    const ARMCPUInfo *info =3D arm_cpus;
+    const size_t cpu_count =3D ARRAY_SIZE(arm_cpus);
=20
     type_register_static(&arm_cpu_type_info);
     type_register_static(&idau_interface_type_info);
=20
-    while (info->name) {
-        arm_cpu_register(info);
-        info++;
-    }
-
 #ifdef CONFIG_KVM
     type_register_static(&host_arm_cpu_type_info);
 #endif
+
+    if (cpu_count) {
+        size_t i;
+
+        for (i =3D 0; i < cpu_count; ++i) {
+            arm_cpu_register(&arm_cpus[i]);
+        }
+    }
 }
=20
 type_init(arm_cpu_register_types)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index cbaa5ed228..f5c49ee32d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -734,7 +734,6 @@ static const ARMCPUInfo aarch64_cpus[] =3D {
     { .name =3D "cortex-a53",         .initfn =3D aarch64_a53_initfn },
     { .name =3D "cortex-a72",         .initfn =3D aarch64_a72_initfn },
     { .name =3D "max",                .initfn =3D aarch64_max_initfn },
-    { .name =3D NULL }
 };
=20
 static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
@@ -840,13 +839,12 @@ static const TypeInfo aarch64_cpu_type_info =3D {
=20
 static void aarch64_cpu_register_types(void)
 {
-    const ARMCPUInfo *info =3D aarch64_cpus;
+    size_t i;
=20
     type_register_static(&aarch64_cpu_type_info);
=20
-    while (info->name) {
-        aarch64_cpu_register(info);
-        info++;
+    for (i =3D 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
+        aarch64_cpu_register(&aarch64_cpus[i]);
     }
 }
=20
--=20
2.21.3


