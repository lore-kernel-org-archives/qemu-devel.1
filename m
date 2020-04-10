Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD8DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 17:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDE2207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="zdYSOJif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDE2207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=forissier.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37125 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMx3q-0002as-Tu
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 13:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jerome@forissier.org>) id 1jMw7P-0004Hw-J3
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 12:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jerome@forissier.org>) id 1jMw7O-000377-FF
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 12:02:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jerome@forissier.org>)
 id 1jMw7O-00036b-3l
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 12:02:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id f20so3156797wmh.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pePTeeE7h5ir7BgZLzcfutrSaXBXb4kdz/GFrYkYkbA=;
 b=zdYSOJifHlZTMqNFNk+XREK2HRDDzxbjS0rElQPguz11sXfaruI1t5K7B76KAKzZMT
 VhEcLvBUg89/nLrVxQdwkYg4uYg1GOfSPq5iZTRIeGe3924sowVzzvOpAUoSeZnvqvJZ
 ussgcbyg+IhZmiDBLtI2188qedVDqNQEqg7byPwmpzXT/ZUJ5f/LHOc3w7CXlYheAeJt
 qvB7akeg84WxYvHFQUGqr9oSRLPo6Nv4dQDRbffmt0C2MuFocZcqLnOmtJzpZ8aqBbCY
 k1PqNtXRNy2A1WXkNFJPDi/mdzHr6dWNw3i8f0rPm386RuJkZXYuZuwy4/zgdbNq5aEh
 11lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pePTeeE7h5ir7BgZLzcfutrSaXBXb4kdz/GFrYkYkbA=;
 b=khTshb6z10CYwZ24g6GJjJpMb1+YJ3nStWeWHsDPDINm9jcCBQsc//5o0cp/PUcst5
 0ufjQndpItqwOvB3NRkqrhvtX/rzdJ0TW+dit2jUbAM6ZL4oaKSq7e41+M0VOd1/XkmL
 hsTfRfqbkEEGpNEJGs9lHNn/VsFehYGQlOhXWTH01JBdkJGl6UREFe5+qeVflZv0u+/B
 ZkriIo72qR1CNLzOejsD2wk5KVvO51K025YVYJL51UxKuDtZRu50uthTw2WUxNe3ycAw
 Cx7qEr1jZ82M0xkIV7nA63vI0gwkwwdmOWaAVL/avYudPdHqynBcVgo8J1tpYF2PQRsk
 muSQ==
X-Gm-Message-State: AGi0PuZOipnUqBvo9ZmrSQo/hJjdMB0gdg5mlwJeCYwm8atFza3hSg29
 xt8cp3l+jylMMng8VL1LhU+0/g==
X-Google-Smtp-Source: APiQypKEEAesNpAPC9WrImaUMDsJDzoHv4cKfFy3ZsTsJhTVarEjMSt4MVy3Pe9zztPaRqMdpjFq6Q==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr5508968wmi.57.1586534576762; 
 Fri, 10 Apr 2020 09:02:56 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:3cb:7bb0:f902:b48c:6f87:25f2])
 by smtp.gmail.com with ESMTPSA id v21sm3268094wmj.8.2020.04.10.09.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 09:02:56 -0700 (PDT)
From: Jerome Forissier <jerome@forissier.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH] hw/arm/virt: Add DT property /secure-chosen/kaslr-seed
Date: Fri, 10 Apr 2020 18:01:29 +0200
Message-Id: <20200410160129.19748-1-jerome@forissier.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
X-Mailman-Approved-At: Fri, 10 Apr 2020 13:01:30 -0400
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
Cc: Jerome Forissier <jerome@forissier.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit generates a random seed to be used by the secure OS for
ASLR when the machine is secure. The seed is a 64-bit random value
exported via the DT in /secure-chosen/kaslr-seed. This interface is
used by OP-TEE [1].

[1] https://github.com/OP-TEE/optee_os/commit/ef262691fe0e

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 hw/arm/virt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7dc96abf72c..42a6f84086f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -77,6 +77,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "crypto/random.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1635,6 +1636,18 @@ static void finalize_gic_version(VirtMachineState *vms)
     }
 }
 
+static void create_secure_kaslr_seed(VirtMachineState *vms)
+{
+    Error *err = NULL;
+    uint64_t seed;
+
+    if (qcrypto_random_bytes(&seed, sizeof(seed), &err)) {
+        error_free(err);
+        return;
+    }
+    qemu_fdt_setprop_u64(vms->fdt, "/secure-chosen", "kaslr-seed", seed);
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1837,6 +1850,7 @@ static void machvirt_init(MachineState *machine)
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
         create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_secure_kaslr_seed(vms);
     }
 
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
-- 
2.20.1


