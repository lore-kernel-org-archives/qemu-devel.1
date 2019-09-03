Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570FCC3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27036233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQimXJm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27036233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BrH-0002JH-4l
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMm-000107-LJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMk-0003fe-LB
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:12 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMk-0003eb-FU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id i18so9386937pgl.11
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IUucvckgBKMbyf9pJkZMtE+2aTYnMo7TXpA6BtThwRg=;
 b=wQimXJm+NV1QEGqk24MjKUH5S6jbhOLcLSkMtn7F6olyxzfjZTSQUZmMgb/HqOu4dR
 OHHrEXz9BJf0fdinYZuzipPEVP6HN6Q29VB2akyjxyn7nJfBJuDYUDVJBbkyl/dZy9O7
 ed1OAUyg5COtl/6+E1qjdawBzTI9Z19ywGU1RpBbkrlqqM/KPOcQ1cd25O7k9iLBkbA+
 cE+SMYmGtUzrj+nsj0Q1wr9hUrIT8nTMusB8ckeIguhs4b6G77dkB2YmiqhJGk45pDUP
 FvnQAfUN7tD6QtxyGOV4iF13gM/foWI1uN/09baIX1xzsuJ/un4WoZIeC/MEL4uczIRq
 x5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IUucvckgBKMbyf9pJkZMtE+2aTYnMo7TXpA6BtThwRg=;
 b=GixH0yHYjdQUkvjgu3XJVaVXFRrRdfhSjuHM7DGrfBP4+KqbSSb/N3VDse488/wOb6
 7hD+2C5kFaoGHAfCEhm6U8KmRM/pwhwAs+MGGyx/mcqtakKSlK+QHfk0WxkDL6hL24YK
 fShjhwVWGzJyx29tdBv9oZ/hVc5eypJx8QwaGy2clQCeu0R7o8j1TTHUZ+g/IndXVNdu
 jTC5TofuB7Xn5AY/bnBQJJhvWf/0XBuIpT2zaHXq6jdUgKn5LWP2jVsv5XfOs08whIY3
 vLz1QB8jK6nhxk8D5v+kKb4UCCdCyViaVPPs07dn2PBgCw1nWaYjJnwmQABNtwClRfWw
 kl/g==
X-Gm-Message-State: APjAAAW3/07cF/wZoORSOKD8hFehAoG0zUTXOiUAtJsmruLNMaY2Ibst
 Ye5G6GgqnfF1d7qzDzajn7QE1YedBIc=
X-Google-Smtp-Source: APXvYqylbN2OZp4U0Xt1FAk/P5teYyYaq1fUOs/5WZPP/WV8An+sKTu/JmuyUKhdINYI9vyrCvzL1w==
X-Received: by 2002:a63:3805:: with SMTP id f5mr30721138pga.272.1567526948336; 
 Tue, 03 Sep 2019 09:09:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:28 -0700
Message-Id: <20190903160858.5296-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 06/36] hw/virtio: Access MemoryRegion with MemOp
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
Message-Id: <ebf1f78029d5ac1de1739a11d679740a87a1f02f.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/virtio-pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8babd92e59..82c5e87a44 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 
+#include "exec/memop.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
@@ -552,7 +553,8 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    memory_region_dispatch_write(mr, addr, val, len, MEMTXATTRS_UNSPECIFIED);
+    memory_region_dispatch_write(mr, addr, val, size_memop(len),
+                                 MEMTXATTRS_UNSPECIFIED);
 }
 
 static void
@@ -575,7 +577,8 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));
 
-    memory_region_dispatch_read(mr, addr, &val, len, MEMTXATTRS_UNSPECIFIED);
+    memory_region_dispatch_read(mr, addr, &val, size_memop(len),
+                                MEMTXATTRS_UNSPECIFIED);
     switch (len) {
     case 1:
         pci_set_byte(buf, val);
-- 
2.17.1


