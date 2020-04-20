Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8BFC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFF0206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="qnAXjfSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFF0206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=forissier.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQVQR-0003GQ-1r
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 08:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46296 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jerome@forissier.org>) id 1jQVPY-0001lq-2x
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:20:28 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jerome@forissier.org>) id 1jQVPX-00012q-8v
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:20:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36513)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerome@forissier.org>)
 id 1jQVPW-00011E-Sy
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:20:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id u127so10030233wmg.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aw73xtFklm/Xs1zT9ssg56PFA0LAMfEmVbDCKfcPWjo=;
 b=qnAXjfSnS4Oh2D7anbdo5atylx7dTzg4Y1ylNXoE6Izisclv3nHOZ8i2Mlch5roLic
 rI2D6U2t+zaD88qZnvmtSHHkGvZhgyg+mepxYeBfRd6/EESE2jWPcNbv83eiItPLK0FK
 wNTrsrUmUiYFIz6yFbq4mXIB/nAm+h79oI26BmOOjFaIbjZlih+NogbMQFIL1Kg/+6rI
 s9Ts9KyAeCCQbnXeNK0zRyDwMPW9dNGumvR70wB8jw/Fj7t3sMcdlAfZix7j5VEMF2S/
 kDudDvoE1LEhnJ/0SKFhyBlDRS1sk0LnCR0/Y3+duWfwB9s6Mkg/mrO7CL7zEY15DrRr
 a8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aw73xtFklm/Xs1zT9ssg56PFA0LAMfEmVbDCKfcPWjo=;
 b=KIFcJTxfwCVYMftOkABMo5fny485qJncW8xR/0gSTggwJdJWIRy1pkeo6ObMQ+W8SP
 wOB+YiuCHzLatIShbR7IYAYdqP/TG/+B9c2xGdqkSmHHoxrdjMxAuIHC4RNhQkXOKxx/
 AqWNdsdrebPoqe/p7qZD3Xpgz6n7TqXMXTS/3zPYLfWeps27noyJDamR4dvNqhLy3k8t
 wHfqYZLwmRmn7MjbRcm6LtyK4eeAg43QaBsleCcZSULPTU+Qv9tSKniMUHEG/D7MuV85
 uoVyOmIbpxwOnfrzwzrEeEmqgbGBXF8/wP4iWluWrfdhWmCQPWJ711OpjOeUElVa5mVz
 c05w==
X-Gm-Message-State: AGi0PuaAZHH8PhfG2JgljdbaMZNjYkABAeRt9Rx8emV6LBDwZLFft1Ol
 yYSHJXtqFEH2K0IzKBlSbavKJQ==
X-Google-Smtp-Source: APiQypKijinfrXBCyisJg7Uc6ifbJ+DVBD4HfhBLVeEKFjcImJuQ25fyS+20bjMSoO6gylLe2PAPlQ==
X-Received: by 2002:a05:600c:2a52:: with SMTP id
 x18mr16903684wme.37.1587385225553; 
 Mon, 20 Apr 2020 05:20:25 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:3cb:7bb0:4826:2464:6688:71f6])
 by smtp.gmail.com with ESMTPSA id v16sm1127132wml.30.2020.04.20.05.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 05:20:24 -0700 (PDT)
From: Jerome Forissier <jerome@forissier.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 2/2] hw/arm/virt: dt: add kaslr-seed property
Date: Mon, 20 Apr 2020 14:18:07 +0200
Message-Id: <20200420121807.8204-3-jerome@forissier.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420121807.8204-1-jerome@forissier.org>
References: <20200420121807.8204-1-jerome@forissier.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::343;
 envelope-from=jerome@forissier.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: tee-dev@lists.linaro.org, op-tee@lists.trustedfirmware.org,
 Jerome Forissier <jerome@forissier.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generate random seeds to be used by the non-secure and/or secure OSes
for ASLR. The seeds are 64-bit random values exported via the DT
properties /chosen/kaslr-seed [1] and /secure-chosen/kaslr-seed, the
latter being used by OP-TEE [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5bc0c37c97e1
[2] https://github.com/OP-TEE/optee_os/commit/ef262691fe0e

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 hw/arm/virt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c3073b7cf19..1b6f3971bf7 100644
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


