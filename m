Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6263AC2BB86
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 17:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30ED6207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 17:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="VHqznM83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ED6207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=forissier.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMx2j-0001XL-B0
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 13:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jerome@forissier.org>) id 1jMvkb-00056S-W9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jerome@forissier.org>) id 1jMvka-0003G9-Pv
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:39:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jerome@forissier.org>)
 id 1jMvka-0003Fb-EH
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:39:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id f20so3094954wmh.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pePTeeE7h5ir7BgZLzcfutrSaXBXb4kdz/GFrYkYkbA=;
 b=VHqznM834Q3FGNoDrCU5swGI2/sM2m1H/BjRJmuH27SgGDgZE2jfTpJpjfJ9yVxSUd
 8afJlWJ4/ppMd1rIM27IyDUdr0TGe/m3Yvu6bQchHLJ6QbrxMQdU8G0MIdCUQ1h8iujX
 n76dyg0r8Ca9SVYzdJ8qWU2fLN+iN2unml4bLReuQZhgzVXkCEJqExeyJlIyhfpCSOXS
 tkzVVRnCdAemhpBgy93pAlexTUHiYjPgYv4akk16hnEd0xx6Q5MAmXsC+sXmST5+uO1l
 tci+8uHZs3xtt6HJtCCl3wrsW3y1mvOVaXycsn/6v3adczdnZGq5vqMvzwSXAwnwzDaK
 7AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pePTeeE7h5ir7BgZLzcfutrSaXBXb4kdz/GFrYkYkbA=;
 b=pV7gnKGodda21pY7rz4Q/BSrK0lT/rtahakumm+J8jOJuQdfkchcG14UbZzi0bA9Dc
 p3Yof+oCKdmB0qEHmVe+VNbMUX40oxboSD+D+TB7VX+N13BSHnVy56v5i5aTGnE/huB5
 y45zHpne/MQux++7paVwF9C/Ng/ehHZ3scHadmVrKEHpZRPUI7m4KU8bvhwU1TLZjEFl
 1QMRozaxMSrn2tB7cz2GWK3bSxVe1ftQh2AUk+qDXECOVk/jqecdruO7bbkc8xymvLZA
 lILEUqcopi2WsPDP2E6z31XOVQL85Jl9ksp4Tgty1OOwVnGbS1G2BLiXRkNy+S07ICUb
 SmZw==
X-Gm-Message-State: AGi0PuacQRKd94ySYMgQr7yjzQGidvEp7RgPbTDle4WSF9mZvRxE1f2J
 cSiFkKHlrEmzSYnnBgIct9Nk6XGH3/1wLQ==
X-Google-Smtp-Source: APiQypLlsugc8ej+el5zmekUPIP2QIPzriNKWb60AGoNgQus0cZtKMg/NsnknmpmfAjJ7eRQjSxoYg==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr5462853wmg.1.1586533162428; 
 Fri, 10 Apr 2020 08:39:22 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:3cb:7bb0:f902:b48c:6f87:25f2])
 by smtp.gmail.com with ESMTPSA id k184sm3271699wmf.9.2020.04.10.08.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 08:39:21 -0700 (PDT)
From: Jerome Forissier <jerome@forissier.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/virt: Add DT property /secure-chosen/kaslr-seed
Date: Fri, 10 Apr 2020 17:39:16 +0200
Message-Id: <20200410153916.17718-1-jerome@forissier.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 Jens Wiklander <jens.wiklander@linaro.org>
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


