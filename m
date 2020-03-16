Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D8C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237A020674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOYwMHWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237A020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtsb-00009f-9D
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsH2-0004Lt-Rq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsH1-0001XT-Lh
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsH1-0001Tv-HT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bL2VrSLFEXUirQF2ArCcrNoQCZwZW3hELnT927BBnbQ=;
 b=NOYwMHWvsc5J8eSRREa8Ikv8XGatGP3EXLFJlOiqP1Udf4rJe45WIJ0jxd7d+XXUh+JXiJ
 XxxvhdSRFaUX/o3SHOt5l+kmfM0NZlm/7Hg+xZzE6l/pQSZHDgb2NcGu2cNdK+1C6cALt2
 u6cqt+kPE3xF/L7GHfk2aaS7DUQf66Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-1e58OSg2OVOeFAojKjp9QA-1; Mon, 16 Mar 2020 12:07:19 -0400
X-MC-Unique: 1e58OSg2OVOeFAojKjp9QA-1
Received: by mail-wr1-f70.google.com with SMTP id p2so6715134wrw.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r1sJ64QkUjojSCH6EGfhYUMESaCKLhSIpdoia+8OdJA=;
 b=iEyo8mcJuftS/OK+jGxs2bZJ/YTiI9w9LaN6a0z4EHpazgzboT/8I1EeqcHvq3GjDH
 niV0u2mYTFCDzpoho0+iWfjBNJfyKVBo5CNySfGhR3lL5vYRgyAcXbbfvNpX/kP04T7C
 KfRrcwPcsWaiJzME8RiK2eyILFIuYuGYOVEIfB9ZqGmz60OFKTVZOeJpi/2f7DxWwj4/
 SsHZkDVo9V4mVRDc5YJMvvm2cvdqA3kDnAm6/0WGyz6/Eh8RdnOA6St+BG8qbD4TP53A
 zqCRb+OdyAvtZ8AcCHsRxNVI37kN2lhy4B2/AJdGDqnBLiWh4h0ArvxCjtQgFJYd9VPQ
 lRVg==
X-Gm-Message-State: ANhLgQ2Tu7gDh/fVc9/zf3psV1IxT0K4F6AEz4UcagKhzdvLbzp9gUoQ
 NBXpIdjQ7jefip83KqmEKj5SaheeQLgUrcPQPD6X559+fHeyuhwJFv5KzwKzaR8YEDFdUln4G0W
 k3m6I+OhX7wJDr1c=
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr77281wrx.71.1584374836483; 
 Mon, 16 Mar 2020 09:07:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuudPESzx7lkwiv+yf4OA/xliD4IQtL8C5kEgXeePSGNU/JOytk/Z7I5CpK3n1RCITbf/5TOg==
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr77257wrx.71.1584374836307; 
 Mon, 16 Mar 2020 09:07:16 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id y7sm22973551wmd.1.2020.03.16.09.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/19] target/arm: Make cpu_register() available for other
 files
Date: Mon, 16 Mar 2020 17:06:22 +0100
Message-Id: <20200316160634.3386-8-philmd@redhat.com>
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
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Make cpu_register() (renamed to arm_cpu_register()) available
from internals.h so we can register CPUs also from other files
in the future.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190921150420.30743-2-thuth@redhat.com>
[PMD: Split Thomas's patch in two: set_feature (earlier), cpu_register]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu-qom.h |  9 ++++++++-
 target/arm/cpu.c     | 10 ++--------
 target/arm/cpu64.c   |  8 +-------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 3a9d31ea9d..29c5e2f2c9 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -35,7 +35,14 @@ struct arm_boot_info;
=20
 #define TYPE_ARM_MAX_CPU "max-" TYPE_ARM_CPU
=20
-typedef struct ARMCPUInfo ARMCPUInfo;
+typedef struct ARMCPUInfo {
+    const char *name;
+    void (*initfn)(Object *obj);
+    void (*class_init)(ObjectClass *oc, void *data);
+} ARMCPUInfo;
+
+void arm_cpu_register(const ARMCPUInfo *info);
+void aarch64_cpu_register(const ARMCPUInfo *info);
=20
 /**
  * ARMCPUClass:
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c074364542..d2813eb81a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2698,12 +2698,6 @@ static void arm_max_initfn(Object *obj)
=20
 #endif /* !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64) */
=20
-struct ARMCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
-};
-
 static const ARMCPUInfo arm_cpus[] =3D {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
     { .name =3D "arm926",      .initfn =3D arm926_initfn },
@@ -2869,7 +2863,7 @@ static void cpu_register_class_init(ObjectClass *oc, =
void *data)
     acc->info =3D data;
 }
=20
-static void cpu_register(const ARMCPUInfo *info)
+void arm_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info =3D {
         .parent =3D TYPE_ARM_CPU,
@@ -2910,7 +2904,7 @@ static void arm_cpu_register_types(void)
     type_register_static(&idau_interface_type_info);
=20
     while (info->name) {
-        cpu_register(info);
+        arm_cpu_register(info);
         info++;
     }
=20
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 622082eae2..e89388378b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -728,12 +728,6 @@ static void aarch64_max_initfn(Object *obj)
                         cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
 }
=20
-struct ARMCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
-};
-
 static const ARMCPUInfo aarch64_cpus[] =3D {
     { .name =3D "cortex-a57",         .initfn =3D aarch64_a57_initfn },
     { .name =3D "cortex-a53",         .initfn =3D aarch64_a53_initfn },
@@ -816,7 +810,7 @@ static void cpu_register_class_init(ObjectClass *oc, vo=
id *data)
     acc->info =3D data;
 }
=20
-static void aarch64_cpu_register(const ARMCPUInfo *info)
+void aarch64_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info =3D {
         .parent =3D TYPE_AARCH64_CPU,
--=20
2.21.1


