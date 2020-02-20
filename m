Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A7BC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E922068F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzSoTFI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E922068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4n3P-0007m8-0P
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j4n2S-0006KO-0z
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j4n2N-0004CI-H0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:42:51 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j4n2N-0004BK-6r; Thu, 20 Feb 2020 09:42:47 -0500
Received: by mail-pg1-x543.google.com with SMTP id y30so2027484pga.13;
 Thu, 20 Feb 2020 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=eH6ZHmsuk1D2shOXK2Vqe7pUD0m3WtmY70bCnxqjJ7A=;
 b=AzSoTFI2N2/SoH5Cp4z9BvQadlZ7wSHyCV6/KISlJ+iB69secoyzWCf/lVc7K+24jR
 5PvwS72lPfvoQBx9RnbR16os7JX3qvOA8mgonZSGmaUTwUi7nbSrqazSJvbmXE88AV7r
 ouH1Q4Iil834tvWzfoAKjTckBVxOMIScks5I80D6Z4kFAyTWRcx3E00bzhFRsU0Ji/cy
 PpMFdip024Ac/w7SaRDutZZXBC1vQyp1L2hs5HxijtZTFevg3geTXyXMqGjGj95aI8iO
 6rZLj1lzF8lvRsY1IunmPLH4+eRvgcABhsSjfNxbMH0xDTmVyo8GKTF25JJpdUD70CaF
 hl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=eH6ZHmsuk1D2shOXK2Vqe7pUD0m3WtmY70bCnxqjJ7A=;
 b=FmBhQqwpTGzAhwvkAbPJehUfMhp54e4FaZk/tBncfHCFIjqEmqtcENIe6g0i4rA91k
 d1AtMN17JtxIyKqgMTw2yhmxn4iIR0VZSzDIVddyc5kCDJDCJWOcw+Gp/GZJBAjbVoIe
 WpYepoLZtI0g9x0AL/Mw7aKNb0g503fElE4amqXI3dIutklZiVfXXnmmAqUVXnHzHZN6
 UlxbgCydYDethI517/oJ+kKujWPfQXCgqhSHfzkOU4LwKBxzMfEApD7J49oB6KAbQ8WC
 Ck/IiBlvDSYbjUeKMQ9MrKoqE1TbbAHmg+Yy7rWITgRtxRjU9jKNLaPCIMzN446obIpr
 HACQ==
X-Gm-Message-State: APjAAAUguJxpFqHyHUIMR4bV2XH7+hY3cREw6duWXGwJmIYJwldOy4vi
 kQu/SLOYsCxzVcE6xDoixSQ=
X-Google-Smtp-Source: APXvYqyJ58/+psNs8d+q8xya5qoNeRHDlzNI0PF+T6xz4s/nd7h/fBBlFkTL1cxvwysihu33fNEHVw==
X-Received: by 2002:a63:dc02:: with SMTP id s2mr11885919pgg.400.1582209764935; 
 Thu, 20 Feb 2020 06:42:44 -0800 (PST)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v9sm3837140pja.26.2020.02.20.06.42.43
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 20 Feb 2020 06:42:44 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 1/2] riscv: roms: Add 32-bit OpenSBI firmware image for
 sifive_u
Date: Thu, 20 Feb 2020 06:42:37 -0800
Message-Id: <1582209758-2996-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Although the real world SiFive HiFive Unleashed board is a 64-bit
hardware configuration, with QEMU it is possible to test 32-bit
configuration with the same hardware features.

This updates the roms Makefile to add the build rules for creating
the 32-bit OpenSBI firmware image for sifive_u machine. A pre-built
OpenSBI image (built from commit 3e7d666) has been added as the
default bios for 32-bit sifive_u machine.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 Makefile                                     |   2 +-
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 0 -> 49472 bytes
 roms/Makefile                                |   7 +++++++
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin

diff --git a/Makefile b/Makefile
index b5a7377..ee7aa6d 100644
--- a/Makefile
+++ b/Makefile
@@ -804,7 +804,7 @@ u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
-opensbi-riscv32-virt-fw_jump.bin \
+opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
 opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
 
 
diff --git a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
new file mode 100644
index 0000000000000000000000000000000000000000..93e2556baa261bfd796cdc484b345bf958c8afea
GIT binary patch
literal 49472
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

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index 28e1e55..f9acf39 100644
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
2.7.4


