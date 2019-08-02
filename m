Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC9CC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783C3216C8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiF8Pgyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783C3216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta4n-0000sq-RM
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hta3I-0006rR-KL
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hta3H-00026c-Gd
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hta3G-00025Z-D1
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id h19so1777819wme.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6pf+/Ei8SJThuyQtu04YRjgRwIND6kl09cbvvwUqAXg=;
 b=hiF8PgyrgiYpewNrug20sSSyPijR5kSUTda7tH4D9fzdife9gSXke30dSMEEIioPso
 cYpk6oGE/Kr+jwGwv4okaMNk7Ft4Bg9CcXhzJme5K8nCwv7nCYTlw1bcNO/OqVz0/oa5
 lC34EFG97yFJGG712mQ5pxexybmOUH6vU2sx9KOCJrR0QG94bgeuiqdXOwCK0mXswAh7
 iDPnvkqXCGDQZqdCfLnIyBg4XMN4PLohsh2/ODCQbE+SvIZR/oVxWi8qqJkwDwvqGnWf
 SeiGLOQXKxpnZJA4sxKRZ5FGjuxGMbz0/SPpNTxq/4u2N6yHVD/5EJuKnfsqOvZ3huow
 QVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6pf+/Ei8SJThuyQtu04YRjgRwIND6kl09cbvvwUqAXg=;
 b=Hu1nw3Osy567LAdEpHxYcM9JOhgkwpE0/sEai2iz52I4kj+fDYtaWZ13nSS+q6ZcpH
 mg0pe56Sz9ai5NGYvETXTAHvkneqy1rkG/MPhOdgSCNdAvEZ2eOvvxYiiw25TN9ahsy1
 qGxfDgRTTAt9ZjtSre0/a2ARO8xg3lns+FwRqq15UuF3WG0ZD7gZvlSIJlwm7+YgPeHy
 r/ROLZvnO9YZStd6qsNprEMHLL2Kk+53FFhDwlN9TGpf66Hf77R6XWziBi75ol5bfuo/
 PRQgmt+7fbeQTcMh9CmFWCAxpf+h6ElX55fg8W2pObrRRITKSwd+slS09qhu5yT39sfv
 LXmQ==
X-Gm-Message-State: APjAAAWYL8k/UBxGq2Xrjpylb1ktToREe6fIOkjCANiE7LD016AWZ3xs
 ZJlFs/sb6ohTOMfSpdKGeOsRI/SJcZ+f4g==
X-Google-Smtp-Source: APXvYqyf5dpeOzKrQZAPP0Ue1CbEHTESCV8v+wXhhac8cluUsmLeN/DcUTuoSoqXtL2D5mM5USGpMA==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr5049177wmf.2.1564761905233;
 Fri, 02 Aug 2019 09:05:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o7sm66200171wmf.43.2019.08.02.09.05.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 02 Aug 2019 09:05:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 17:04:58 +0100
Message-Id: <20190802160458.25681-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802160458.25681-1-peter.maydell@linaro.org>
References: <20190802160458.25681-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 3/3] hw/mips/mips_jazz: Remove
 no-longer-necessary override of do_unassigned_access
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the MIPS CPU implementation uses the new
do_transaction_failed hook, we can remove the old code that handled
the do_unassigned_access hook.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/mips_jazz.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index c64b4c78809..540943932fd 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -111,18 +111,6 @@ static const MemoryRegionOps dma_dummy_ops = {
 #define MAGNUM_BIOS_SIZE_MAX 0x7e000
 #define MAGNUM_BIOS_SIZE (BIOS_SIZE < MAGNUM_BIOS_SIZE_MAX ? BIOS_SIZE : MAGNUM_BIOS_SIZE_MAX)
 
-static CPUUnassignedAccess real_do_unassigned_access;
-static void mips_jazz_do_unassigned_access(CPUState *cpu, hwaddr addr,
-                                           bool is_write, bool is_exec,
-                                           int opaque, unsigned size)
-{
-    if (!is_exec) {
-        /* ignore invalid access (ie do not raise exception) */
-        return;
-    }
-    (*real_do_unassigned_access)(cpu, addr, is_write, is_exec, opaque, size);
-}
-
 static void (*real_do_transaction_failed)(CPUState *cpu, hwaddr physaddr,
                                           vaddr addr, unsigned size,
                                           MMUAccessType access_type,
@@ -184,9 +172,8 @@ static void mips_jazz_init(MachineState *machine,
      * However, we can't simply add a global memory region to catch
      * everything, as this would make all accesses including instruction
      * accesses be ignored and not raise exceptions.
-     * So instead we hijack either the do_unassigned_access method or
-     * the do_transaction_failed method on the CPU, and do not raise exceptions
-     * for data access.
+     * So instead we hijack the do_transaction_failed method on the CPU, and
+     * do not raise exceptions for data access.
      *
      * NOTE: this behaviour of raising exceptions for bad instruction
      * fetches but not bad data accesses was added in commit 54e755588cf1e9
@@ -197,14 +184,8 @@ static void mips_jazz_init(MachineState *machine,
      * memory region that catches all memory accesses, as we do on Malta.
      */
     cc = CPU_GET_CLASS(cpu);
-    if (cc->do_unassigned_access) {
-        real_do_unassigned_access = cc->do_unassigned_access;
-        cc->do_unassigned_access = mips_jazz_do_unassigned_access;
-    }
-    if (cc->do_transaction_failed) {
-        real_do_transaction_failed = cc->do_transaction_failed;
-        cc->do_transaction_failed = mips_jazz_do_transaction_failed;
-    }
+    real_do_transaction_failed = cc->do_transaction_failed;
+    cc->do_transaction_failed = mips_jazz_do_transaction_failed;
 
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
-- 
2.20.1


