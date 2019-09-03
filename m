Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FFFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63D222CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zM7OiUaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63D222CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BXK-00030E-RX
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMi-0000xt-Iz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMh-0003dH-6B
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMh-0003cy-06
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id d1so9401089pgp.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DGv4U4anZuE9DKQ8+bKzeaee27PcHJQcw9+3WBCohIo=;
 b=zM7OiUaQJ3OvQAB2sbiZW42b6F8dj6lfhuv5Mb8Z6LbE7EVCgPBpA018xBcjglrGn4
 Y0PR6diLguNdOor1RXdMtxfAU0qdsD627EFUeW61S7rKlkh4eD+vbtguJUbVm8juN1vI
 ZHDnF7AqK49RanxdMOV/2AHWfD7qLqh7ZIFroPI0rwdmAF4aobQGbB5pYEaYRffrFT6n
 5WJ41qciGEdwOPc5E351d15bvVSRmFE7KkzsnJxUhu/VcsaHud84P50ugB/UIB3/Aq8s
 lHSlVPA0w06ezVCs8wdWLNTQONmDesE76FA+js2CJSSnf+P7BDmmACCnomRcdwuWnMLy
 x/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DGv4U4anZuE9DKQ8+bKzeaee27PcHJQcw9+3WBCohIo=;
 b=c6feMXfx88FCGb/XP1B2MXUfs41k2F1T21Zg+98tugHVvNQTTnu4HPNKTU4NJdUBoV
 c+yw6/z0ACYxe1ZZ2rqlZXQu7THQW7zzj3+/sN6l6bMdus0jx0SUcVCDe7I5Kjruz7m4
 sYNhSNJTysg4RD/PL67yhWrdcQA6GkceWr5UV9kJigR2WDSCWbBSgDsaKPoZz6MY3s+b
 DdCeGfvGE01HxW2m3UeZKLP2PQMqBZc4n8ajKbd1jCbdIoJI1JGJhilleg2eH6aWDZvv
 D1F+zJYI3G5B24ZhH4k7i9DUcD3StDwwbWJn1KrkkgD1Yc7S4nWGxYuWHFXCDmBhocIu
 RUWA==
X-Gm-Message-State: APjAAAUK9Gqmr5IhyCJCXqfwEgh92oFfIJCnycHM9/FSiYqaqKYcTObs
 bsy8moo+ivvj587M4iJmatbHjB+gr0Y=
X-Google-Smtp-Source: APXvYqzfJsChh4C1uxB3phnSRKjyYFgOgwKoMWcY7Xvpmg5G1s7yKoiNnzb5KsAEdpEsKRiWd3a1Yg==
X-Received: by 2002:a62:24a:: with SMTP id 71mr41375948pfc.148.1567526945830; 
 Tue, 03 Sep 2019 09:09:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:26 -0700
Message-Id: <20190903160858.5296-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 04/36] hw/s390x: Access MemoryRegion with MemOp
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

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
Message-Id: <2f41da26201fb9b0339c2b7fde34df864f7f9ea8.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/s390-pci-inst.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 00235148be..0c958fc391 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include "s390-pci-inst.h"
 #include "s390-pci-bus.h"
+#include "exec/memop.h"
 #include "exec/memory-internal.h"
 #include "qemu/error-report.h"
 #include "sysemu/hw_accel.h"
@@ -372,7 +373,7 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
     offset -= mr->addr;
-    return memory_region_dispatch_read(mr, offset, data, len,
+    return memory_region_dispatch_read(mr, offset, data, size_memop(len),
                                        MEMTXATTRS_UNSPECIFIED);
 }
 
@@ -471,7 +472,7 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
     offset -= mr->addr;
-    return memory_region_dispatch_write(mr, offset, data, len,
+    return memory_region_dispatch_write(mr, offset, data, size_memop(len),
                                         MEMTXATTRS_UNSPECIFIED);
 }
 
@@ -780,7 +781,8 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     for (i = 0; i < len / 8; i++) {
         result = memory_region_dispatch_write(mr, offset + i * 8,
-                                              ldq_p(buffer + i * 8), 8,
+                                              ldq_p(buffer + i * 8),
+                                              size_memop(8),
                                               MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
             s390_program_interrupt(env, PGM_OPERAND, 6, ra);
-- 
2.17.1


