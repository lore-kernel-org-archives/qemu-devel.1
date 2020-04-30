Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB508C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9549B20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNsxh2Gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9549B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7pp-0007sm-LU
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jk-0003NV-21
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jg-0000RL-Ex
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jf-0000Qk-Vh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id u16so1542589wmc.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DnVZE8yCIv33a+1icgwUYG6BXiHGdO/aR7fwaOKWJV4=;
 b=gNsxh2GjbHn4Fk4CkuG/Pays6Bud3qziAXhVj+RnFuuRxKUtHcerToyd4GwwQTekpU
 rF7FLE5M+thgXhPaLxjCuvQ0P6aOzcKg4L8MXY7fF32spJcsRR996+Qdftrapzw7IEiU
 9fdZYQpURHm+LEq50p1OaMBiLOFDAOUxPv5O4aPHgickPJ8yW7Kf6UbVCw0aNQv6QK+z
 FcvJDfSeql9b0Ia58VelJ9GtLVcSWg0uGTXgjhnmVJpnwKRvdZaxu0GBfE3eUUafAiXz
 OEkIeZ7nBa9vJbvta9hYSZqFHmG4VnI84muyFN2hm0vM/mxF3mn3w680+pnOjOINx2td
 qndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DnVZE8yCIv33a+1icgwUYG6BXiHGdO/aR7fwaOKWJV4=;
 b=g8INtj4F4XMJ1l1Ia/Gz0Bnd4ufnkd06mLZnZ2HnMrLBZcRjC19O9Ktgc91IIugJlk
 Wzm267VOmBV+3OPtThxTsNy06UcYFJNcLYnTLaXe/Hpme6DPc7funesY+K2iCeBhng5l
 nG7n+Mf56LTGvkRNvZYFfuzfzVfZ7BkUr0bNSuLjpbGjpzS3AK2Oe+RAtVpAT7CFspPm
 DqJldTrkXajj7LDbKN+ov64Z+JWKvc89yIAQ7+vGKbTsooJmeNJo/9Ta/UVMlPpWutfI
 wuKMd93ZU7qW8COwywyr9RKei5xyqHHCE/xU6gOeasgFxIvUmq1o+idtHS4hlRuorCwC
 jNLQ==
X-Gm-Message-State: AGi0PuaXY9JoDf4R9dk6OfGOB1P0KMbGnPIh40iBBg/04zJcHKBE70v+
 /cd5wd6nT4pcx++NHKEV8Zb1w/GKBzf13A==
X-Google-Smtp-Source: APiQypKke2OcmTsrW5cDqbXyBo9mUH7a/KTfYn7FuBdMpOw5gn5uQs7Ij4n5WVXQLSugSSN4fzmt/g==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr2450037wmt.129.1588247530299; 
 Thu, 30 Apr 2020 04:52:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/31] hw/arm/virt: dt: add kaslr-seed property
Date: Thu, 30 Apr 2020 12:51:34 +0100
Message-Id: <20200430115142.13430-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32e
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

From: Jerome Forissier <jerome@forissier.org>

Generate random seeds to be used by the non-secure and/or secure OSes
for ASLR. The seeds are 64-bit random values exported via the DT
properties /chosen/kaslr-seed [1] and /secure-chosen/kaslr-seed, the
latter being used by OP-TEE [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5bc0c37c97e1
[2] https://github.com/OP-TEE/optee_os/commit/ef262691fe0e

Signed-off-by: Jerome Forissier <jerome@forissier.org>
Message-id: 20200420121807.8204-3-jerome@forissier.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d92674f32b..626822554d5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -77,6 +77,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "qemu/guest-random.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -213,6 +214,18 @@ static bool cpu_type_valid(const char *cpu)
     return false;
 }
 
+static void create_kaslr_seed(VirtMachineState *vms, const char *node)
+{
+    Error *err = NULL;
+    uint64_t seed;
+
+    if (qemu_guest_getrandom(&seed, sizeof(seed), &err)) {
+        error_free(err);
+        return;
+    }
+    qemu_fdt_setprop_u64(vms->fdt, node, "kaslr-seed", seed);
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -233,9 +246,11 @@ static void create_fdt(VirtMachineState *vms)
 
     /* /chosen must exist for load_dtb to fill in necessary properties later */
     qemu_fdt_add_subnode(fdt, "/chosen");
+    create_kaslr_seed(vms, "/chosen");
 
     if (vms->secure) {
         qemu_fdt_add_subnode(fdt, "/secure-chosen");
+        create_kaslr_seed(vms, "/secure-chosen");
     }
 
     /* Clock node, for the benefit of the UART. The kernel device tree
-- 
2.20.1


