Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B46C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D0320658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMWlN1cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D0320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3XX-0004pk-QV
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3Uh-0008HO-UE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3UZ-0002ju-9O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:19 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:33038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1jE3UY-0002XU-U7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id m5so10982645pgg.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=vZQwpuX/IFS5FAluT+MzHjryR0UmdbeKAblD4NmMACc=;
 b=nMWlN1cEs00n5jg8Bh4TWmG3QsI6TSpqYgiDSl3ywDjQDfv6WGiUGB7aQ4FO25CgUr
 aPTr3q9a9pgSMgNcIj5QcrG2Y4XZfMn3/FGhXJdhZjPq4+9OR1NHreE4VfNAM9JiKNSP
 D4SV3GfVjKpO75Ymt9P7zFusnhtlcUPsB6LkYE1rja9uL36x+D79risehbFRKZ/1GiKd
 fQr6yZvGG42dU544atyzYz8jnleHenNgt7OXUd4nN4FV+6ltoovLF0Vqj6+S1MpbJt3g
 oHa7ExcFISjFVlzijmzSyY9V8BsGctgao8C94e2/dOfH+FaOzbA8G6u7DZfCFNEbH1h5
 l/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=vZQwpuX/IFS5FAluT+MzHjryR0UmdbeKAblD4NmMACc=;
 b=CcwGz38rZB9Hr+eulJIAkORwwxTmchwLE1pzLE+7ewpgP+eTYLzKOo8PxowzBsOS7c
 824qFbwmzBUJ5yLzW0B2O8fH33dDg5zYWy4DBE4ANfLjxGAvgKioqxT9qKQRT3Ouvkev
 X3qOP1OLmlar2aUSyWk5M7NL0YDfoJVT4zAmdFturTfDjc98uvtbcHiMNwgsgK50k56l
 ZXwJUMSkjHF+dMhsWGI00zwUU0+JMUBsRbnKHAeK9wbhn3X+zLh3adM/luXg+bRsMbvH
 S6TQeUXpMZBWMQJAlJVXC9ACZLT1DcAvmGGorNqwN+MQXKSeKsawmEGI28S/SWAevuUB
 ebzA==
X-Gm-Message-State: ANhLgQ3Dq9P8O29CrBX70yFlg3vA1nMhFZh1+FZOWe98TIidtToIgr2A
 Bv+uTSN421hhpkCbi/jieTshObJPEFR49A==
X-Google-Smtp-Source: ADFU+vs9o7dxaFYDMhuoUFHjA6v+6EdE0VqPqnhw5bgcFUmPSPqWAse0EAbAer1T3p4mlgSN80pVNA==
X-Received: by 2002:a65:460a:: with SMTP id v10mr3070943pgq.370.1584417968524; 
 Mon, 16 Mar 2020 21:06:08 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id k189sm888748pgc.24.2020.03.16.21.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 21:06:07 -0700 (PDT)
Subject: [PULL 3/6] roms: opensbi: Add 32-bit firmware image for sifive_u
 machine
Date: Mon, 16 Mar 2020 21:05:44 -0700
Message-Id: <20200317040547.222501-4-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200317040547.222501-1-palmerdabbelt@google.com>
References: <20200317040547.222501-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

Although the real world SiFive HiFive Unleashed board is a 64-bit
hardware configuration, with QEMU it is possible to test 32-bit
configuration with the same hardware features.

This updates the roms Makefile to add the build rules for creating
the 32-bit OpenSBI firmware image for sifive_u machine. A pre-built
OpenSBI v0.6 image has been added as the default bios for 32-bit
sifive_u machine.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 Makefile                                     |   2 +-
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 0 -> 49472 bytes
 roms/Makefile                                |   7 +++++++
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin

diff --git a/Makefile b/Makefile
index 7df22fcc5d..ea0e08fc57 100644
--- a/Makefile
+++ b/Makefile
@@ -848,7 +848,7 @@ u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
-opensbi-riscv32-virt-fw_jump.bin \
+opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
 opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
 
 
diff --git a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
new file mode 100644
index 0000000000000000000000000000000000000000..bab13f597ac9da31518f0a2bb22c2a1dbd56380d
GIT binary patch
literal 49472
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%0DMiNGf_$WkVuRX&6)lQo8YJYsn*8)V^6}pe
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

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index 28e1e557b0..f9acf39954 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -66,6 +66,7 @@ default help:
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
 	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
 	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
+	@echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
 	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
 	@echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
 	@echo "  clean              -- delete the files generated by the previous" \
@@ -181,6 +182,12 @@ opensbi64-virt:
 		PLATFORM="qemu/virt"
 	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
 
+opensbi32-sifive_u:
+	$(MAKE) -C opensbi \
+		CROSS_COMPILE=$(riscv32_cross_prefix) \
+		PLATFORM="sifive/fu540"
+	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
+
 opensbi64-sifive_u:
 	$(MAKE) -C opensbi \
 		CROSS_COMPILE=$(riscv64_cross_prefix) \
-- 
2.25.1.481.gfbce0eb801-goog


