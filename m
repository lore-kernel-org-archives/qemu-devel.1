Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D774EC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEFC20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMO4+tRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEFC20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7yk-0007dD-ME
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jk-0003Ow-Nu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7ji-0000Rt-Ie
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7ji-0000RY-0l
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id d17so6484964wrg.11
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pPIQv9n40IDAcbCAwAaYgpIvcVu9gJFTvPCQZjCwLHE=;
 b=kMO4+tRCX2FfHRngSazbYawNYtRKNqa3v3pg8RwZyda2QpkQB97DAmelmA36n8fokw
 FC29oQbcrEkda2i/lu1jUrz5MAqxK0UpppwXK5T/a6mliZw06wPLYBp2L0k9Mv30lf0C
 0qTYVIT1E3jns/xHOHOj4HPZGMqi2MaKYg/4mBfKQzk1956pzL2MkB+I++jCPqKKXKnz
 arzw6mQKQoC4z7UjxoxBIScqhLyY8XlfTANT+ZkLprO+PO0a45UVd83UH02sK9YNkJcc
 Rro21S7dXcl7qMOe6c1i7ZWkWSYJSlPRoli1EtA9K8CPLGE3fM1tQpLwZpiRxsXbCRfv
 ig7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pPIQv9n40IDAcbCAwAaYgpIvcVu9gJFTvPCQZjCwLHE=;
 b=Zr6X7286Q/rTp9hlJXGn2WnqFQBVuZbPKe7M8uEByq0PsHe9C3OhqL0Zs5yhaCNc57
 X+A0R2xuSwCOZ3dB/9qp8LELF2P+9RHRh9QWz7eWrXiuAiwlSg3ioHksfFNd2Sij48+B
 /WCDtM62hCvbsF9QKiZFd3R33UbgUxVk77WsaEs9PWdkBy5mE860xgpReS/FWUvSkRM4
 haIeHzIQjwHqihbBBkfzIWAp5VF5Fh1KPv6ZxhyuIRoYBwNkp9Ss836cfseuGUYSNa3W
 ywDDDrizrBUhenH4U/xW0vjYwCYEtJ/wt5jDpWD4QgVRiU2KqS6v1NICYT1aSI1i+hVQ
 GMRw==
X-Gm-Message-State: AGi0PuZh9ol3szb+itWwQQZfQsSuDdc6/kYzHkv61SwiBOUf01tuKzGG
 cTUKFcBTPt4LqDoaZQyHYCiRR8XDvlKLGQ==
X-Google-Smtp-Source: APiQypKd4cJlafn55Qk+POaK96pQ5lyCcmUTTjbYTXx/HrrOkOn314wGFgL4YIyg13Qz0Jv3wjadKw==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr3392889wrt.290.1588247532356; 
 Thu, 30 Apr 2020 04:52:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/31] target/arm: Make cpu_register() available for other files
Date: Thu, 30 Apr 2020 12:51:36 +0100
Message-Id: <20200430115142.13430-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::435
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

From: Thomas Huth <thuth@redhat.com>

Make cpu_register() (renamed to arm_cpu_register()) available
from internals.h so we can register CPUs also from other files
in the future.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200423073358.27155-3-philmd@redhat.com
Message-ID: <20190921150420.30743-2-thuth@redhat.com>
[PMD: Only take cpu_register() from Thomas's patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-qom.h |  9 ++++++++-
 target/arm/cpu.c     | 10 ++--------
 target/arm/cpu64.c   |  8 +-------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index d95568bf052..56395b87f62 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -35,7 +35,14 @@ struct arm_boot_info;
 
 #define TYPE_ARM_MAX_CPU "max-" TYPE_ARM_CPU
 
-typedef struct ARMCPUInfo ARMCPUInfo;
+typedef struct ARMCPUInfo {
+    const char *name;
+    void (*initfn)(Object *obj);
+    void (*class_init)(ObjectClass *oc, void *data);
+} ARMCPUInfo;
+
+void arm_cpu_register(const ARMCPUInfo *info);
+void aarch64_cpu_register(const ARMCPUInfo *info);
 
 /**
  * ARMCPUClass:
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a79f233b170..47e35400da2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2693,12 +2693,6 @@ static void arm_max_initfn(Object *obj)
 
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
@@ -2864,7 +2858,7 @@ static void cpu_register_class_init(ObjectClass *oc, void *data)
     acc->info = data;
 }
 
-static void cpu_register(const ARMCPUInfo *info)
+void arm_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
         .parent = TYPE_ARM_CPU,
@@ -2905,7 +2899,7 @@ static void arm_cpu_register_types(void)
     type_register_static(&idau_interface_type_info);
 
     while (info->name) {
-        cpu_register(info);
+        arm_cpu_register(info);
         info++;
     }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 95d0c8c101a..74afc28d537 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -737,12 +737,6 @@ static void aarch64_max_initfn(Object *obj)
                         cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
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
@@ -825,7 +819,7 @@ static void cpu_register_class_init(ObjectClass *oc, void *data)
     acc->info = data;
 }
 
-static void aarch64_cpu_register(const ARMCPUInfo *info)
+void aarch64_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
         .parent = TYPE_AARCH64_CPU,
-- 
2.20.1


