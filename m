Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE0C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8862076A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmsBvv7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8862076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8LA-00036N-NZ
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JQ-0000CO-3h
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JP-0005He-AY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:16:59 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JO-0005Gk-SQ; Mon, 27 Apr 2020 14:16:58 -0400
Received: by mail-lj1-x242.google.com with SMTP id f18so18631608lja.13;
 Mon, 27 Apr 2020 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K2z7JThC8adf5+0uldYLYFbNNDEmc84sc30GQCEmr/s=;
 b=RmsBvv7gu93sV8OgWI9ydMYrcAl4D+U1GuR6r/mTqOVblnYKomHX7zebyF2hd4Ltfw
 hLturTp6mM6QAy7iPq9fg12rMzjLlY4gh2wdHNQt0OdcuiWilxMBJ0GUsE8tfQmr9Zrb
 l7yTYhEg68sLU/R/O6dgCzynye4I25MDoVWQCHEQW9/YDnFssiGIn8OVVEgeHoAn3aLu
 KhiMRsKRJSHikX6hqigoIcVtOdrVDQrlq36D34/tXFU1oa4y8iDAqvaU6GXv7UcEUBsh
 /F8AL1HNIErxOMT6KIEcucuvVq3byFsy1n7sl+MmADFXzcCl1UR8ea/C1M2822gsoOnz
 mwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K2z7JThC8adf5+0uldYLYFbNNDEmc84sc30GQCEmr/s=;
 b=FlNHyx2weJTDmpIUA9XsP3Ldun/SHmjNcp/TCbsJ3bi4C4PskVKnKkvVK+2mS6fnCh
 8ryjkrIuomQGwSJj9STtVbnm7IFLogsM5HGf2A8p5mclks1JLbNmdWpuAr4wTCG6w9H8
 tuhdlxUUXs9wOi0WV8JHvuQC9R0m34p2NWgbjozPhQ2ShbsCVz+Ktv4959EMEMTWPJvx
 HQNAkNzJLn1YRc3BNCRpTcaTROpGoh0ZvViK/2liW9W+O2kY2gN5uOWCQjyeRRDrkjv5
 WJjeykYxvszJRnryjlmZr76IuTBs8URgjaAzCg5Fgn8fN7B7DCB1trg9ux7jzEtkOkVS
 7PAg==
X-Gm-Message-State: AGi0PuZCSKyLKslsTut5mf9E9rdMMJKtrl2uiwPn0T82InlDQK9VXDzs
 ebLxm1jV/j06ccY0/reMnjrkz1/IbF4=
X-Google-Smtp-Source: APiQypJwvyYhNNX8OLBGenxViC29kn8S2hyVFr5xSA7VyqgRuvOukRKsG/TTv9ZRr+X6SWsGovj6SA==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr14057349lji.77.1588011415595; 
 Mon, 27 Apr 2020 11:16:55 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id l26sm10443350ljc.49.2020.04.27.11.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:16:54 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/11] hw/arm: versal: Embedd the UARTs into the SoC type
Date: Mon, 27 Apr 2020 20:16:42 +0200
Message-Id: <20200427181649.26851-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::242
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Embedd the UARTs into the SoC type.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal.c         | 12 ++++++------
 include/hw/arm/xlnx-versal.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index cc696e44c0..dbde03b7e6 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -21,7 +21,6 @@
 #include "kvm_arm.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
-#include "hw/char/pl011.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define GEM_REVISION        0x40070106
@@ -144,16 +143,17 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        dev = qdev_create(NULL, TYPE_PL011);
-        s->lpd.iou.uart[i] = SYS_BUS_DEVICE(dev);
+        sysbus_init_child_obj(OBJECT(s), name,
+                              &s->lpd.iou.uart[i], sizeof(s->lpd.iou.uart[i]),
+                              TYPE_PL011);
+        dev = DEVICE(&s->lpd.iou.uart[i]);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
         qdev_init_nofail(dev);
 
-        mr = sysbus_mmio_get_region(s->lpd.iou.uart[i], 0);
+        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
 
-        sysbus_connect_irq(s->lpd.iou.uart[i], 0, pic[irqs[i]]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
         g_free(name);
     }
 }
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 6c0a692b2f..a3dfd064b3 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,6 +15,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/intc/arm_gicv3.h"
+#include "hw/char/pl011.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
@@ -49,7 +50,7 @@ typedef struct Versal {
         MemoryRegion mr_ocm;
 
         struct {
-            SysBusDevice *uart[XLNX_VERSAL_NR_UARTS];
+            PL011State uart[XLNX_VERSAL_NR_UARTS];
             SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
             SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
         } iou;
-- 
2.20.1


