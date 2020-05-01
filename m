Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4A2C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E1C20857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP9Hbrr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E1C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXye-0000QR-JN
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwe-0005mk-Lu
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUXwQ-0006rU-Ad
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:20 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwP-0006nh-Sw; Fri, 01 May 2020 11:51:05 -0400
Received: by mail-pl1-x642.google.com with SMTP id u22so3765440plq.12;
 Fri, 01 May 2020 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WrvmKTGX/CX3RpsyigZdEeijEnWRcSxW4YeYCjRcA5s=;
 b=PP9Hbrr/FqPDEBZUCi1vvua/oqtzpdR806p1kmtmCawzKe1vYke0LGUGPUaaEuZ+PO
 tp/PGfKqHi8lZL/uBzXOuUyV4mwdpAk5K/j4s4/iBzIJ5BsNXuy6DVdnfT947c+rrZWc
 k/DXOzV48fAD+Rg9yIYDbWQZjM3onEh8Wy/MhvCfjA7RySMn5EHX3u39aPO/bgT4rZF2
 RvevVgRwrDaFI/MxtxPZgt6NtPr9dZFPyvCTb74W0VPtKW0GVKhIhFpffgwNgI5/gCzC
 IeQmWCxIDL6+9jQXI5ayufnU6a6TKh9bdA64XVMILFs36py03HlKPm1g7D1BajaECRkj
 x8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WrvmKTGX/CX3RpsyigZdEeijEnWRcSxW4YeYCjRcA5s=;
 b=coGnt3qva15kfUaz53jFexgIweRpyYq3TTCZEbArDggf/mMpwJpXUf1aff/o/1x/CM
 xJod9wUa2xobHctXv9W/KwmyxkkOOJB7XjaZGeJ2/+6MQye0m686sU48qa/I4SFQAtDS
 CBHMRKR6SJ/htH5bRe78mPTuKn5uqS91V8DXSs61AvxtXjDg7Ir2poDh5ryGrFSQ1oqO
 AlcebWKl3qx2c+Q58oHiWZyT45P7PVAA9je3ZTW30/p4uNCDWeue1cw9113n2C++Oq+z
 noyZHez+wgs5T/GFt/mWsaIrmGfD4TzKM3ST83OpCOVp9UEAFetLePLPoFjvDJgz50oz
 K8Pw==
X-Gm-Message-State: AGi0PuYE0VEKSDmMi0TfoM2LVMB2SJh7H/OLZJdQooUEPCNLjhAOBBw9
 IxNVlLYtka041CsbQIykQLc=
X-Google-Smtp-Source: APiQypJTKuL0ox5D3gQO7sAq7oKs6A7YLyJUW3U2IyDEb7wH+UlVJ5K+vPbUYxKi8eL7d8eXz8yVdA==
X-Received: by 2002:a17:90a:a484:: with SMTP id z4mr271357pjp.40.1588348264323; 
 Fri, 01 May 2020 08:51:04 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id e4sm2385968pge.45.2020.05.01.08.51.03
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 01 May 2020 08:51:03 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 4/5] riscv/spike: Change the default bios to use generic
 platform image
Date: Fri,  1 May 2020 08:50:53 -0700
Message-Id: <1588348254-7241-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Bin Meng <bin.meng@windriver.com>, Anup Patel <Anup.Patel@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

To keep sync with other RISC-V machines, change the default bios
to use generic platform image.

While we are here, add some comments to mention that keeping ELF
files here was intentional.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/spike.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d0c4843..6f26fcf 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -45,10 +45,15 @@
 
 #include <libfdt.h>
 
+/*
+ * Not like other RISC-V machines that use plain binary bios images,
+ * keeping ELF files here was intentional because BIN files don't work
+ * for the Spike machine as HTIF emulation depends on ELF parsing.
+ */
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_jump.elf"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_jump.elf"
 #endif
 
 static const struct MemmapEntry {
-- 
2.7.4


