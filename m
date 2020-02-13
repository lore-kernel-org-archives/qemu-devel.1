Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA57EC3B187
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6EC206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+4JnBeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6EC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j22Iu-0003iF-MX
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 19:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j22I6-0002Vk-0J
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j22I4-0005VP-Tp
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:37 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:42972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j22I4-0005UP-OR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:36 -0500
Received: by mail-pl1-x630.google.com with SMTP id e8so1583102plt.9
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 16:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uAQRooIFC1RVgmc7hgLv35x85QYxjKufqRBZQSXx1kU=;
 b=H+4JnBeMPUr2Uy8/74M40WQCNRuLSR+7rf3uOtB1kS0rKIqWegr9mrhTEw2Zgroeny
 k6MC5Tf1aBgCXt45JHeY/eOPoKd1Kqwd8cQio1y35ymzipVnwFEiTXzzqUhEXO6zmtHY
 Ds8NeDnH3i/JSIZZwjhjJNMTSEtfwyZQsj2hcxRp0HNxthclU8TT1k/AW2L2vn2BwExj
 ZDbAJ/N9w6Uq9LwaoWWyzgy36d1JjggwsCajAx8doSZALfKDRg1yWB2DRKO6Y4uUe0xf
 pde/YyN/7d3ZJV7EGtGhNZW5H43oVK8G4gPzKuyDeiN+HvOyjw/B3MEIDXJURdVEVAX1
 /QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uAQRooIFC1RVgmc7hgLv35x85QYxjKufqRBZQSXx1kU=;
 b=ts13ygFEk7S7wULSvAKN8S09oyYcZKrTJ+cXe+et77ADa/LcM7PrI5cuorYtYIew49
 /68Oxcf/fRMtjAQ5KkN7qURcA7vK4JkRtkNfAJS9DFaEQgRaHBNzkj0p8MhnVJSQPXYG
 5Z8v6W8+gBx1cHcXuG/QApcSOWt/o7i2ye9rAysUYciS5hb1gpxqk20H/PmkAO27Z5tw
 kl0RS8qQiqGwFqdEGJxlDkZqTEE24KtTwf17WbTRzeECX81Dn1FSYfByCQjZmKMUniLb
 /3SS+BFqyvJDcG7Dbzqhzv6lC3XOOko8LfGeIkFomq60DaSMUmswaVI2agD/nbEkuckP
 SAfw==
X-Gm-Message-State: APjAAAX57llQ/RUlYBJRVgm1JZVdAgwGIkqL9E8CjaPSqxbVoOx5xg/u
 4pHZwRxeAqGEjNMLlDsdiytYMXJ+ULI=
X-Google-Smtp-Source: APXvYqzWtcWejBVgaY6bmnYutJotS68gtPh1Aso1M34Gk1uPysHhb+o7dnsOyg/KlosxY+YXgjo+sg==
X-Received: by 2002:a17:90a:9c1:: with SMTP id 59mr1877816pjo.65.1581553415251; 
 Wed, 12 Feb 2020 16:23:35 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id j4sm365277pfh.152.2020.02.12.16.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 16:23:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] exec: flush CPU TB cache in breakpoint_invalidate
Date: Wed, 12 Feb 2020 16:23:30 -0800
Message-Id: <20200213002332.31821-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213002332.31821-1-richard.henderson@linaro.org>
References: <20200213002332.31821-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
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
Cc: peter.maydell@linaro.org, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Filippov <jcmvbkbc@gmail.com>

When a breakpoint is inserted at location for which there's currently no
virtual to physical translation no action is taken on CPU TB cache. If a
TB for that virtual address already exists but is not visible ATM the
breakpoint won't be hit next time an instruction at that address will be
executed.

Flush entire CPU TB cache in breakpoint_invalidate to force
re-translation of all TBs for the breakpoint address.

This change fixes the following scenario:
- linux user application is running
- a breakpoint is inserted from QEMU gdbstub for a user address that is
  not currently present in the target CPU TLB
- an instruction at that address is executed, but the external debugger
  doesn't get control.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20191127220602.10827-2-jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d18e..7f4074f95e 100644
--- a/exec.c
+++ b/exec.c
@@ -1019,14 +1019,13 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
 
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
-    MemTxAttrs attrs;
-    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
-    int asidx = cpu_asidx_from_attrs(cpu, attrs);
-    if (phys != -1) {
-        /* Locks grabbed by tb_invalidate_phys_addr */
-        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
-                                phys | (pc & ~TARGET_PAGE_MASK), attrs);
-    }
+    /*
+     * There may not be a virtual to physical translation for the pc
+     * right now, but there may exist cached TB for this pc.
+     * Flush the whole TB cache to force re-translation of such TBs.
+     * This is heavyweight, but we're debugging anyway.
+     */
+    tb_flush(cpu);
 }
 #endif
 
-- 
2.20.1


