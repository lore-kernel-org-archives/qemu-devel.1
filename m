Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA445C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BF4215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQflvHP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BF4215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bj0-0000xV-Jx
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN2-0001MU-BW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN1-0003rf-1P
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:28 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BN0-0003rB-S3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:26 -0400
Received: by mail-pl1-x641.google.com with SMTP id y1so8063944plp.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0RIrW/AM/FRCh/5tYMiTNVCjB9dqNOvdf51jrirTikc=;
 b=ZQflvHP2t4RygJOZhx0JN7SS3dQHOq4ACt9/Cfl2uRjYSbxatxpla9hJzc4pKh3VFf
 bY/i/qtg8/RWuz1E28jeXHSAE13J+/6Za1U+jPW6Ys6H/ZNMbTsIIDEMC50AXi7nvS3F
 ArZwZY8iYFc3m9utcSvh/PCpUWnkgUkHfDVmF3EWvALJln3Yxkoi7H8mUAjGGTYdSfUv
 xn0BXaEo/z2dDgDAQkpaY49t3xT94zOvHmGF/+lYuVX0CAbxjGtEyPxhhWlatEsiurV/
 SdXU648lve1Pgv0pic3sisVo3meB2odqGP3PrLMyOtp9bDvJwAAnmVL1zeD6tDwGqQLv
 XC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0RIrW/AM/FRCh/5tYMiTNVCjB9dqNOvdf51jrirTikc=;
 b=Tjml4WpQG04fL2o3zwLbAtLH05M3iLvpdd8vz4cQnBkiAWNDaS9+QpCWNCmc+Z7hdc
 oWNj67yEom7vvdh6nrC3XHmBo0IcpF7ALbrFJAhMeTvjBg+/WPWRb1VWA8gI6Vsf7uU3
 ATr+FWx38am9ZuIOiDf9Jkdls8Ytf4D/cnPMiv6MavtZT9xSKInUj1P4sdHtPGHV8SHO
 vPwiUi0oBR4t+JBf4UNaAOfDZJNj3RhULEOk1h0y9PSIgGARgh9TC5PYpzANeFu8dre8
 uGk/VHTiYo54b6BIFGsnJ0HTesB9NA1pDhPViI1DYWKBMhzwID4wv+JHsdYY/21PsC1P
 qrpA==
X-Gm-Message-State: APjAAAWsP1mcFGR0Wb31pi/0BR6Sl5zmSu3VW/iLTCWQlEVerSLgCzCf
 MO3NvATbzuxJr0ZzzoKKfUxWto4/3Co=
X-Google-Smtp-Source: APXvYqwlQ0w67R4AeKAkixU4N4xUi2UsQglWGDL+BdVhFz4NmmozIcBT7dnTV3fMJL01bzPcLjNaBA==
X-Received: by 2002:a17:902:fe93:: with SMTP id
 x19mr7982879plm.337.1567526965670; 
 Tue, 03 Sep 2019 09:09:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:42 -0700
Message-Id: <20190903160858.5296-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 20/36] exec: Move user-only watchpoint stubs
 inline
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let the user-only watchpoint stubs resolve to empty inline functions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 23 +++++++++++++++++++++++
 exec.c                | 26 ++------------------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77fca95a40..6de688059d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1070,12 +1070,35 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
     return false;
 }
 
+#ifdef CONFIG_USER_ONLY
+static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                                        int flags, CPUWatchpoint **watchpoint)
+{
+    return -ENOSYS;
+}
+
+static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                                        vaddr len, int flags)
+{
+    return -ENOSYS;
+}
+
+static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
+                                                CPUWatchpoint *wp)
+{
+}
+
+static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+{
+}
+#else
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+#endif
 
 /**
  * cpu_get_address_space:
diff --git a/exec.c b/exec.c
index 53a15b7ad7..31fb75901f 100644
--- a/exec.c
+++ b/exec.c
@@ -1062,28 +1062,7 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 }
 #endif
 
-#if defined(CONFIG_USER_ONLY)
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-
-{
-}
-
-int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags)
-{
-    return -ENOSYS;
-}
-
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
-{
-}
-
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint)
-{
-    return -ENOSYS;
-}
-#else
+#ifndef CONFIG_USER_ONLY
 /* Add a watchpoint.  */
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint)
@@ -1173,8 +1152,7 @@ static inline bool cpu_watchpoint_address_matches(CPUWatchpoint *wp,
 
     return !(addr > wpend || wp->vaddr > addrend);
 }
-
-#endif
+#endif /* !CONFIG_USER_ONLY */
 
 /* Add a breakpoint.  */
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
-- 
2.17.1


