Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD78DFC6195
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5AF206BA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HsrIFSvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5AF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7j8-0006CP-AB
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iT7fy-0003Vb-Vq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iT7fx-00082N-IM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:03:58 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iT7fw-0007ys-TB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:03:57 -0500
Received: by mail-pg1-x544.google.com with SMTP id 29so4337749pgm.6
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=2HFV5T5YHz0RHL9Vx4v0rUKBOuss5HY1B+DqcpGnOGg=;
 b=HsrIFSvh3S/gnnh+cHhEeLyTHXzS8GzfgqAuuyYVH020rNKecJYRUQAVDIq28+C9yO
 S17QK7jAg5D/ufy9cNtwEtMLDcavXpE/Lm85uctRv+PL2HPY0hX4HOtQ9neaPPpvDii/
 NuZiRLszujiOTNIrTezmLH5vdS1HQoyv8NF2RPN8VkKahazWypbQI+uYswGj0sIPYrq7
 hGYLdQD3InvdxkMl/Uw+X5EQUUvMixAXdntZegaSzvVnarpiDE6hMdb1CilN/T6lUIyC
 Yy1QcZ8IT74m6pMmOT5bbKTWGobGi7NVVmvRlZwHDGAheljH8LsTtf0KhNHZ5SLsZW96
 AkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=2HFV5T5YHz0RHL9Vx4v0rUKBOuss5HY1B+DqcpGnOGg=;
 b=aqXYxBT0onyK8EpLSCS9vpxA/RVtafqUDJz/4tUpBXL/nYhhxI3cyaH7YxLLNkzhxZ
 RBkQSstwwCBZHIXsxn35a5JgAy4ymOiZOjAxAAc0JG9Rw64j+XY1rTMyqYfytVw7/RHq
 j3Rcl8JSgecOZVii9wLoa2ZgL3aXfFAbppi/2glqR6h4d+DP1dDdEyE8tvTqi8fs84aU
 WJ6KnVgpoBDkTuedU/fCj0Rwvgupyz9UGMI3ZGOp0qtuReTRclME40DLfu+Kl/2pXb3+
 QCtRCuRXQzSw8RTwrbjm9h+9LPvhSTfYlzeWPslOR6E+fuFfTfoxjb/91u2bCSiZVSel
 jZHQ==
X-Gm-Message-State: APjAAAWu9rIDNCn1qBwiz7ZlLnU2AZprB9pWClFvrWSqXfEAnB3jQaHf
 PGoY0oXhUlVH6ST5ojVctZOueg==
X-Google-Smtp-Source: APXvYqwU3v74C1gwZKBJ6cYXmMAjwgLORqWmW7qMnZR37rjUZbnDHzKxsVV6V8Y6dMriohOkWEnpvw==
X-Received: by 2002:aa7:9192:: with SMTP id x18mr13438878pfa.229.1573232635334; 
 Fri, 08 Nov 2019 09:03:55 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id r184sm7784147pfc.106.2019.11.08.09.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 09:03:54 -0800 (PST)
Subject: [PATCH] RISC-V: virt: This is a "sifive,test1" test finisher
Date: Thu,  7 Nov 2019 14:25:00 -0800
Message-Id: <20191107222500.8018-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: qemu-riscv@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Christoph Hellwig <hch@infradead.org>, Palmer Dabbelt <palmer@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test finisher implements the reset command, which means it's a
"sifive,test1" device.  This is a backwards compatible change, so it's
also a "sifive,test0" device.  I copied the odd idiom for adding a
two-string compatible field from the ARM virt board.

Fixes: 9a2551ed6f ("riscv: sifive_test: Add reset functionality")
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 hw/riscv/virt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 23f340df19..74f2dce81c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -359,7 +359,10 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     nodename = g_strdup_printf("/test@%lx",
         (long)memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
+    {
+        const char compat[] = "sifive,test1\0sifive,test0";
+        qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
+    }
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_TEST].base,
         0x0, memmap[VIRT_TEST].size);
-- 
2.21.0


