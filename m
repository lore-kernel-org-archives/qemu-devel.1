Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D774C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0097208E4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kaqk7hmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0097208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BOw-00036z-39
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMo-00010p-Mk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMk-0003fJ-Ea
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:14 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMi-0003de-ET
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:08 -0400
Received: by mail-pf1-x443.google.com with SMTP id b24so11104232pfp.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o9bye9mVTNv+px71+GweycFouVc7ymKkAXiyz/IcIpw=;
 b=Kaqk7hmJIhkEl7cf8RCqAbkuSeyIhSsLplF/6J5IPLjOE2niCp7CcbEeAnNjzbSBZA
 +mo8LcI1fr2Uvw5V6NCp6UqBtkMrt4MAlGHaEboGLsqYnuTv78cfIqceYQPeYYKagARI
 Yceq0hK5Nh0mdIELb5MWBGS8727HVBj0WFqHwfUgx8wpu8VDSgyyQJ9F/ZCYJBMg2TFf
 nAWKugjLeWVrizVCHgr4XIGL53uhs13s83wB0Bbmg4CalbepIoMsMiwY/DTV5yHg+bhi
 5IdLY4CfWrZUEpjIDpsFlkfO4LY6aZp4bvEOrZ6Jpc4UYuIWp0D3WINW7kmeOBbH7ajt
 nIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o9bye9mVTNv+px71+GweycFouVc7ymKkAXiyz/IcIpw=;
 b=jNGGOo8gtX7AcbC0bjAodpXv848BrpfAJuV66siZ9U6+xU+pKRlRpnpJfI/HJST00v
 ACN+VLhllK78GoQsTkmSoCznVf0XV5RmIltYvbypwnQgGrj7QLYPZrddKQcbQEpkr65D
 hcWORrkJv2BnUnj2Ddyt3e/PNVvpxVec9FL2fz2OP3zAEdPQkK0Yk98KqTTILFmBM17R
 2CSwnOHCvkeX4oPjhYlf0S/SQueb3oZXiRbGCWDHI0kuNLFlJMIs7Dk1sLEpwljc/5kw
 3eDFuZNMp4Aj26ugSaZk1ft1Sy8AjwTUz+L0BoXcbBnNPRWjZ6JJojDFdMfgUk7pw8dd
 JZtg==
X-Gm-Message-State: APjAAAWokr7PEWhBTOD3fxT/dswOtXuTTMWavD8RNS/uxZFeJHgXzP8Q
 YkfwbzhwXC0zbsQoUFpR0BMBsNpnu2I=
X-Google-Smtp-Source: APXvYqxLokP+AJbs4SzEnF3t+v8rnataWX7KJiIdlsp7o/MERKVxkbGQcBpiAJuTPV1xlq0LB9o2kg==
X-Received: by 2002:a17:90a:1202:: with SMTP id f2mr23463pja.39.1567526947019; 
 Tue, 03 Sep 2019 09:09:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:27 -0700
Message-Id: <20190903160858.5296-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 05/36] hw/intc/armv7m_nic: Access MemoryRegion
 with MemOp
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <21113bae2f54b45176701e0bf595937031368ae6.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/armv7m_nvic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 62ab8b7273..7220940133 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -21,6 +21,7 @@
 #include "hw/qdev-properties.h"
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
+#include "exec/memop.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
@@ -2348,7 +2349,8 @@ static MemTxResult nvic_sysreg_ns_write(void *opaque, hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
-        return memory_region_dispatch_write(mr, addr, value, size, attrs);
+        return memory_region_dispatch_write(mr, addr, value, size_memop(size),
+                                            attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2367,7 +2369,8 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
-        return memory_region_dispatch_read(mr, addr, data, size, attrs);
+        return memory_region_dispatch_read(mr, addr, data, size_memop(size),
+                                           attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2393,7 +2396,8 @@ static MemTxResult nvic_systick_write(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_write(mr, addr, value, size, attrs);
+    return memory_region_dispatch_write(mr, addr, value, size_memop(size),
+                                        attrs);
 }
 
 static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
@@ -2405,7 +2409,7 @@ static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_read(mr, addr, data, size, attrs);
+    return memory_region_dispatch_read(mr, addr, data, size_memop(size), attrs);
 }
 
 static const MemoryRegionOps nvic_systick_ops = {
-- 
2.17.1


