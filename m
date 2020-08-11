Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7643EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE21206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I930Ugsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE21206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5ISf-0001V0-H6
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 20:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3X-oxXwsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com>)
 id 1k5IQu-0007Bo-9q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 20:46:28 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a]:50695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3X-oxXwsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com>)
 id 1k5IQs-0004hl-AE
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 20:46:27 -0400
Received: by mail-pl1-x64a.google.com with SMTP id k1so7894625plk.17
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XwXI+TeoOk/IO0tOFJlS08zlKz9aiNu5PcDpDT/1KCQ=;
 b=I930UgsqK7sxVoKYmDzzNRFSl4AfdHkZwylOEpnSNSOA7cFKb7VxuDglQSA4Hgj9fi
 ZUfXNijz4JHOyjuOoCiJihXKtRMtMlO6keAkpIuSRmbxuqCGUXCTzO3qQIemRAKVKWUM
 ZsXuGcbOXEPMRTPbd8hTx0yg5mzEdTA9IKWMPOrwhYAUiN7khj4L68PXAHoFAKV5TIHE
 dFq38LCqrqYVmt7ixVRYlIg52HYu+7Ktx6cTHJdLobYm+gJrFPcgW6Eh0vHOfyjtah7R
 WMsLOlPeKi9fIhsPEVElFzc7WMbPHLDmM+VmBgpdqiKOHEph+9MH8RyVW9mCkl9ai3kP
 Iqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XwXI+TeoOk/IO0tOFJlS08zlKz9aiNu5PcDpDT/1KCQ=;
 b=fNupBybEBvKoPggtbR6emJx0lpe0CcqtPa7xnap9tU3MHDTi7RRj6t+bEit1/EqfNP
 xSjKTOU/nj4C1/gwAC3KeN/5kw+Mh7Jwq6BSubjMiCfMEhDVJ/hfqbpVfD/T2rfqh2HX
 H5y1l5EhFna+E1ISdDwhU3Cp1X3rf5SKiNs0XY+FiIqIDT4G86AeQ1lZ7NcPG+Ov4uyV
 xMrxX9Hk1JB4+8Po56ikjS8ZNZ97uUwCj0F3QDV1YnZIzs3gPR01XhFJ0O8mcCiaruho
 G2HDQIs70wjf83AehIUTpeWx9f9aK6Wz5uc/Qc252qRd2xAUgsgef43xHwA1kPiOgXBC
 Hd6w==
X-Gm-Message-State: AOAM5317F7fvDKJMQyqa7VbBSPZ+YFkbAMRCRGlDtJoSGXcJHH43MTKQ
 tGa+lfA2fxQV65Ql4xs99Cwl4VIa3wCWmqY0lw==
X-Google-Smtp-Source: ABdhPJzQgdLb7DvVCcmlGySiTzvdg5cQo0zh0+LDRt8gx2OJ7mR2nplAkOrrl8awzSQcJnh9TpKxjpeN+4gwMvaqyw==
X-Received: by 2002:a17:90b:1287:: with SMTP id
 fw7mr1891050pjb.218.1597106783621; 
 Mon, 10 Aug 2020 17:46:23 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:46:00 +0000
In-Reply-To: <20200811004607.2133149-1-hskinnemoen@google.com>
Message-Id: <20200811004607.2133149-7-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200811004607.2133149-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v7 06/13] roms: Add virtual Boot ROM for NPCM7xx SoCs
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, f4bug@amsat.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3X-oxXwsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

This is a minimalistic boot ROM written specifically for use with QEMU.
It supports loading the second-stage loader from SPI flash into RAM, SMP
boot, and not much else.

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 .gitmodules                 |   3 +++
 MAINTAINERS                 |   2 ++
 Makefile                    |   1 +
 pc-bios/README              |   6 ++++++
 pc-bios/npcm7xx_bootrom.bin | Bin 0 -> 768 bytes
 roms/Makefile               |   7 +++++++
 roms/vbootrom               |   1 +
 7 files changed, 20 insertions(+)
 create mode 100644 pc-bios/npcm7xx_bootrom.bin
 create mode 160000 roms/vbootrom

diff --git a/.gitmodules b/.gitmodules
index 9c0501a4d4..c95eaf8284 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -58,3 +58,6 @@
 [submodule "roms/qboot"]
 	path = roms/qboot
 	url = https://github.com/bonzini/qboot
+[submodule "roms/vbootrom"]
+	path = roms/vbootrom
+	url = https://github.com/google/vbootrom.git
diff --git a/MAINTAINERS b/MAINTAINERS
index c1066053d0..00806b6efc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -756,6 +756,8 @@ L: qemu-arm@nongnu.org
 S: Supported
 F: hw/*/npcm7xx*
 F: include/hw/*/npcm7xx*
+F: pc-bios/npcm7xx_bootrom.bin
+F: roms/vbootrom
 
 nSeries
 M: Andrzej Zaborowski <balrogg@gmail.com>
diff --git a/Makefile b/Makefile
index 13dd708c4a..fa14ad3b38 100644
--- a/Makefile
+++ b/Makefile
@@ -839,6 +839,7 @@ s390-ccw.img s390-netboot.img \
 slof.bin skiboot.lid \
 palcode-clipper \
 u-boot.e500 u-boot-sam460-20100605.bin \
+npcm7xx_bootrom.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
diff --git a/pc-bios/README b/pc-bios/README
index fa8b58b797..4d6297fca7 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -71,3 +71,9 @@
   ("Simplified BSD License" or "FreeBSD License", SPDX: BSD-2-Clause). OpenSBI
   source code also contains code reused from other projects desribed here:
   https://github.com/riscv/opensbi/blob/master/ThirdPartyNotices.md.
+
+- npcm7xx_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for Nuvoton
+  NPCM7xx BMC devices. It currently implements the bare minimum to load, parse,
+  initialize and run boot images stored in SPI flash, but may grow more
+  features over time as needed. The source code is available at:
+  https://github.com/google/vbootrom
diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
new file mode 100644
index 0000000000000000000000000000000000000000..38f89d1b97b0c2e133af2a9fbed0521be132065b
GIT binary patch
literal 768
zcmd5)JxClu6n-<aczPbVhZYusb8wKx;7TklHfmuZdYT9pDRLwd1p_t-DFpWpyA+8(
zwKtZg3J4a0aCM3_X(ZL&4g;46VVk5e$K;z;L99|b@aE%v^S$rQ8)h(Vm@cB9IYc+2
z2SHd4^NwTIGE%w>9S05p1#kf90Sj5Z(jG8}+)IZIp~iXK=T&)dL`%d-q*8aR#mq{7
z9`=6;Dr(H0ACe72R5x?!)^86Qj-X%{+!K9iZNA@*wkBAV&iZ(l^I9?!Gz=S2I_*1d
zr+tTQDHjvyzKnw(hu00yX`u!Fv<!~XVcX?@kr#<B0(gGU?$W{gSsQa}CF^8Cfzp2X
z@P}yDV-bci(K9XL$FU!som2C`c)?Uc&294s^}Wzumap{hg1X^jN|V25M5tQZ=<9lN
z%(zKz#t-qCwHKb;HygOCpvCNL_4@1tXV1YGf^XUE_$zr{g8zWh-6gz-teI(eibtxo
z?0OZI4%rU0741PgUD`2xq@H|*4=+Rs?%N)Ox5G+q>C;DilBe_YlkeSUVHA-crNk+k
jtiF_MudA<CB(}8|fqYwCf3re&=&@_s761P#-ID$TwgmBa

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index f9acf39954..97e54fedeb 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -34,6 +34,7 @@ find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld
 # finally strip off path + toolname so we get the prefix
 find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
 
+arm_cross_prefix := $(call find-cross-prefix,arm)
 powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
 powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
 x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
@@ -63,6 +64,7 @@ default help:
 	@echo "  skiboot            -- update skiboot.lid"
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
+	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
 	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
 	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
@@ -198,6 +200,10 @@ bios-microvm:
 	$(MAKE) -C qboot
 	cp qboot/bios.bin ../pc-bios/bios-microvm.bin
 
+npcm7xx_bootrom:
+	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
+	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C sgabios clean
@@ -211,3 +217,4 @@ clean:
 	$(MAKE) -f Makefile.edk2 clean
 	$(MAKE) -C opensbi clean
 	$(MAKE) -C qboot clean
+	$(MAKE) -C vbootrom clean
diff --git a/roms/vbootrom b/roms/vbootrom
new file mode 160000
index 0000000000..0c37a43527
--- /dev/null
+++ b/roms/vbootrom
@@ -0,0 +1 @@
+Subproject commit 0c37a43527f0ee2b9584e7fb2fdc805e902635ac
-- 
2.28.0.236.gb10cc79966-goog


