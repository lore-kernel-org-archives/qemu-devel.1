Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C711AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93338216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXKcBXfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93338216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SNB-00049q-Ky
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFT-00025l-VD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFS-0002cm-Rd
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:07 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFS-0002be-Lo
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:06 -0400
Received: by mail-pf1-x443.google.com with SMTP id y9so1252467pfl.4
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZP36MWl36L5FPh2wCUJ4QcBKHAXy0KIiyF1zKso3XCo=;
 b=WXKcBXfwNlqeX6FD1XEOaWgDLMNKHX3hX9cP+k/GI8VKvXopFbEKcParbOdxyCP2ZL
 ru1EKVly50mjG3GDhDXPqMiWxvQ/+frXkBGgD9ZUuxw52g+KkPqIXIPInWaiiXCsR6bt
 lOPr9s+Xxpjb651cnPUGgcYCnwh/2cn0TiB/FyEJ3WCvrDuAZDUmvefJKcdjnAycfaiM
 ReHNAzYwBT5hwljmK+gLLXJQl+lvPSnGnfVj9qjD2cwsEuILq814KJIVREOd8zY9eQom
 X6/81W+MtU9hhO7UAyUwnn8KMB30WtEBzK69KQffgCfOiQxyFVAnvA5zBtszy6w2Cru9
 xu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZP36MWl36L5FPh2wCUJ4QcBKHAXy0KIiyF1zKso3XCo=;
 b=seUKhU1SLUbsY6Q0iEpe7NaDe8Rhua9I1b7pv4AXRNbso9RKAIuxDBAestGQ4hgXvr
 9cJPwhby1gqs/KPUWeud3rTNwWLxdVvTJh2KKw6cIMA0zFakZkTnvw+KUNgbWKBucgD0
 ol5r6+Zhpk1ZCZ5oTQA0B+1LG8jbqez5aX6PlEVL5hwKwRN5yXFxu64gH7wK6Hc3sBj0
 QBnOfh1zXs+NfEiNmISOe5sF37eRZ21cCU7s7bubrwJW320tw7ecRWd2gp0vy48MpGlM
 xKX4uAIEIrdOTopi7EKHyayClJFOi8AxdsjVYhFJOq5fsXpru0etb/N7JLA32i+OVfFC
 V48g==
X-Gm-Message-State: APjAAAVzvTvWCVHw4I7N6Rc0Ks7kOOuNS9ztSGAaKtsZWw8nMdMorYw4
 I8j0aHUrzLNPHfP2YsZL2604qK6Qz0U=
X-Google-Smtp-Source: APXvYqxZU2ehYZQwEzV0/C4eWXK7JZ3G88ZH8q7xARXtZjiALjpMJ10Awkj9esUE8fG+bnRAmOPBdA==
X-Received: by 2002:a62:1808:: with SMTP id 8mr36365278pfy.177.1566400205601; 
 Wed, 21 Aug 2019 08:10:05 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:05 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:02 +1000
Message-Id: <957abc2c2db1cf073c9407276bc4e2ea6ad0473d.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v8 08/21] hw/vfio: Access MemoryRegion with
 MemOp
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
Cc: Tony Nguyen <tony.nguyen.git@gmail.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Convert interfaces by using no-op size_memop.

After all interfaces are converted, size_memop will be implemented
and the memory_region_dispatch_{read|write} operand "unsigned size"
will be converted into a "MemOp op".

As size_memop is a no-op, this patch does not change any behaviour.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/pci-quirks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f71aace156..a4e1d2abb5 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/memop.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -1073,7 +1074,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
 
                 /* Write to the proper guest MSI-X table instead */
                 memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
-                                             offset, val, size,
+                                             offset, val, size_memop(size),
                                              MEMTXATTRS_UNSPECIFIED);
             }
             return; /* Do not write guest MSI-X data to hardware */
@@ -1104,7 +1105,8 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
     if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
         hwaddr offset = rtl->addr & 0xfff;
         memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
-                                    &data, size, MEMTXATTRS_UNSPECIFIED);
+                                    &data, size_memop(size),
+                                    MEMTXATTRS_UNSPECIFIED);
         trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, data);
     }
 
-- 
2.23.0


