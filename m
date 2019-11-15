Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EECCC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE12A206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="AMim9xq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE12A206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVTTD-00018P-OF
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 23:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iVTQN-000674-HG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iVTQM-00088W-F1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:35 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:47002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iVTQM-00086f-9G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:34 -0500
Received: by mail-pg1-x541.google.com with SMTP id r18so5169779pgu.13
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 20:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=yJmFGNtNtQHlzjVVr4hwH9M3d1nwvxRmf94Oh4rJpwo=;
 b=AMim9xq815tsn4O5H5tDMqF1UnAhJj5F+zOO2DNu9WEaWGlQbrnXfTswBb0CTO+1SC
 poJkmwKWX1O/v53fNVfE4C5i2zS1qHUvjDfafvdwAPjiqt21s+S+lL6YqHIC9XC97q3L
 o0xOGoMJuymVbcNcqeSVCBhPSvXxUGwKo+ksJtTXjXpPemxprOCagZprkPCWeokYCTRP
 T+ct/oKk/3VbPDQIhBH0SiRmHd4H6SRRNFHZph4yfNTwRM1zdVZT6AM0vW3cY2RIaWCB
 KG0gnAjfvXT6MRQB+Di+hIoagjpzqitsQYeHzycgdHGkJbOesYoRjC9mufxSicy5Uyj2
 kTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=yJmFGNtNtQHlzjVVr4hwH9M3d1nwvxRmf94Oh4rJpwo=;
 b=ilk6jLGhlQS7gwvkwQ2E3LWP9k0MZ21TTYj73+GpMux479kK4704sTWFHJkgFFbz9w
 6tVGp3qvXsrTeLNSIB5FTffZFVxP37nL0yJoL+SUEyVzQkWZIJ3/5vld3a1nOb99H42+
 HYlO0KNrvoMqUI3Y+BsY6ZeJwURwyOHDTz3uNeX10tvuyVOE69TpG1OHrLg22PV0xdck
 8UmRMLnvM2K+8qZ5+QIHi8wKqsnJ9mdXcldFT67h2/Rv4oYwRJaESVqALJQRDo22FQNL
 Yhw6Mx0sNOYipem+v2aLNFxk5sPHHRViFCtV16fk15GQxvBQLaiqLE62cQtvI0zODCGI
 aVsQ==
X-Gm-Message-State: APjAAAXXEa9d4mS8vrLDg6ABkcYN/WU2oc+4aWoYQiDVU+APYEcN1xwK
 qg1hR2cB8vaJAsQp0VLaJcje4zLoMJM=
X-Google-Smtp-Source: APXvYqxbKd1TFdCqMbXM2y9ZJTrDogpyWftF9XsfvMYQKcU88HNWUWIBwXns0RzzyFTe+y3VcxLKIw==
X-Received: by 2002:a62:1c91:: with SMTP id
 c139mr15259349pfc.175.1573792893099; 
 Thu, 14 Nov 2019 20:41:33 -0800 (PST)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id 67sm9182645pjz.27.2019.11.14.20.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 20:41:32 -0800 (PST)
Subject: [PULL 4/4] riscv/virt: Increase flash size
Date: Thu, 14 Nov 2019 20:41:04 -0800
Message-Id: <20191115044104.4197-5-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115044104.4197-1-palmer@dabbelt.com>
References: <20191115044104.4197-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Coreboot developers have requested that they have at least 32MB of flash
to load binaries. We currently have 32MB of flash, but it is split in
two to allow loading two flash binaries. Let's increase the flash size
from 32MB to 64MB to ensure we have a single region that is 32MB.

No QEMU release has include flash in the RISC-V virt machine, so this
isn't a breaking change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cc8f311e6bbb..23f340df193e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -62,7 +62,7 @@ static const struct MemmapEntry {
     [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
     [VIRT_UART0] =       { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
-    [VIRT_FLASH] =       { 0x20000000,     0x2000000 },
+    [VIRT_FLASH] =       { 0x20000000,     0x4000000 },
     [VIRT_DRAM] =        { 0x80000000,           0x0 },
     [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
     [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
-- 
2.21.0


