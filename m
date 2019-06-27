Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B2CC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C828208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C828208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWve-0000u1-0z
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWI0-0003XZ-AV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHy-0000eR-Nl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHy-0007RL-Ek
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so1409652pfa.4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Ll0IfljzezEKYOWEmbGf9wV1tOe7NCSXkPQeobGClJk=;
 b=ES5im7OofQhXD18ilIcpUCr4f3PoQuivhzlW0y/rAne+gGA4mO6kyKgahZ6pYRatXq
 Dd4SnevWZoxvM2XHfd1MvXoc8BoRR9cJRN+S5LCRxbLv7CBdOu7fRD2DD145XOBOdpyO
 SSqr7c3dR2vzPCSxeqeB+WIKVg4dI8QwXtVT55otT8UE+gbEbEvTJUyGWilu1Jb8JXz5
 wkPBsaKR7C7SiwzIGGGq5GuKmd7Sbsc/HAA2X/OpHkgkCNY7OyGXHiXZuJLTghUhE+2T
 bZRoCVEhJO119Wv0Ve8OKtnsk1/jkmHaicdrHLlrOK+QBK09FxswZiQA6fbzL3ux9sXQ
 vprg==
X-Gm-Message-State: APjAAAXM7+SPGBFrCjIA1UEe9iI4H5m0sEfr8xRmZivNRUOavo7qihOr
 SWBoYGsly9fOpo0XGDsr9hn56A==
X-Google-Smtp-Source: APXvYqz5wVrouuxE15mqeXUlOn6ssM6cUIxlUE12cqlIIkDNu8mqI3+lGFWABMMIi309vDqdD0MvDQ==
X-Received: by 2002:a63:4006:: with SMTP id n6mr4086210pga.403.1561649081832; 
 Thu, 27 Jun 2019 08:24:41 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id f88sm6614731pjg.5.2019.06.27.08.24.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:41 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:20:09 -0700
Message-Id: <20190627152011.18686-33-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
Subject: [Qemu-devel] [PULL 32/34] hw/riscv: Extend the kernel loading
 support
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Extend the RISC-V kernel loader to support Image and uImage files.
A Linux kernel can now be booted with:

    qemu-system-riscv64 -machine virt -bios fw_jump.bin -kernel Image

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/boot.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 883df49a0c65..ff023f42d01d 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -56,12 +56,22 @@ target_ulong riscv_load_kernel(const char *kernel_filename)
     uint64_t kernel_entry, kernel_high;
 
     if (load_elf(kernel_filename, NULL, NULL, NULL,
-                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) < 0) {
-        error_report("could not load kernel '%s'", kernel_filename);
-        exit(1);
+                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) > 0) {
+        return kernel_entry;
     }
 
-    return kernel_entry;
+    if (load_uimage_as(kernel_filename, &kernel_entry, NULL, NULL,
+                       NULL, NULL, NULL) > 0) {
+        return kernel_entry;
+    }
+
+    if (load_image_targphys_as(kernel_filename, KERNEL_BOOT_ADDRESS,
+                               ram_size, NULL) > 0) {
+        return KERNEL_BOOT_ADDRESS;
+    }
+
+    error_report("could not load kernel '%s'", kernel_filename);
+    exit(1);
 }
 
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
-- 
2.21.0


