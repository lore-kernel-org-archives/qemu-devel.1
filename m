Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C0C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07492071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dl8L0zAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07492071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJZc-0006Sq-Vs
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Kz8RXwsKCuwVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com>)
 id 1jwJSw-0003dQ-SA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:26 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:38519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Kz8RXwsKCuwVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com>)
 id 1jwJSv-0005GZ-8o
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:26 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id 124so10323155ybb.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 23:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=zj8bIibIdnQybBaGQVDBz5aPKtzt2hn+lBo9PsbHCSU=;
 b=dl8L0zAV5p9vyPHtd2jPDRxweLQ0c8kKpugeUt/93A3FJF6Ap9mAi41K3wB9Z6LtLe
 hmsRCp6FtY8Q8t/pD1brTV/92Y2Iur9KiPpJZxh1L5PuRRExEuW4EkUOQQqtK5qobE1f
 eZ/JdG9pIbdr++98CmpHH7GQmE9UhXZs20hHZPNVyp11Jfs/Wq6fi2LTT22m778k0SXA
 xmZshiu5KeL34gASswhlOodTBgxdYPCI+9oy4MFvmXMcXU6veg4QgKWz/BqfiR7xEaZC
 qkRVVHS4ibOLktbJXjRa9LQnuX2iJXqWOCBzp17117liAB3bayOrviIb7f9QrQNo6lVn
 JPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=zj8bIibIdnQybBaGQVDBz5aPKtzt2hn+lBo9PsbHCSU=;
 b=T+43pADCdVNebZZWIstbtQ8mzgaLwguawmk69fE+5abo0qIJ6CevM/4ah7Vqqk2nBb
 r2hOy9w8gl4Q8HtCA8jnKCTjDLQZT4UIak789grbi+1u57Dz7bHK4+cH6rZ2SvtYa4+1
 3vCF4kUz7iuAZ46JzehdYR0+wOTBB/bdYiJOIVHMiUHV+AlPm+2u3LSs223a7WNJXTwS
 X9E1Hom7pizFfGwz6YrkJkLrBYE2tHuA6ErSbY+kqqbDzq22qvY7+tIuLDbRtAaAhOXl
 hvyXCPEF5Oqud6+Iat43wyPrjDYyogPqeqkdQU5WJEAuqYfb7wC+PEawic7Pp6HnpvAP
 wnZA==
X-Gm-Message-State: AOAM532YqnYMA+REm4Cl0zeGOko5kVwYXr7eJli3jeanPwc/C7ie3MDQ
 oWLjIfOWaXHao7cKi4K+/0nSXNAuS/sYAHXQaNePx309FsR/kgWRik0vKsZVKpq6cg0nlIPG/Zy
 +SmRev1BIwKW3nfIWJtdJK2EqINhvkJXwEE35PJFLDecwOC30vzD5odcg8CzMCciOdJxN9oQ8Ew
 ==
X-Google-Smtp-Source: ABdhPJzIPes5ARqBTwRSQh/yiSG/In/XPsoc71cWr3Uyzhbud/7oK1FJ7f/+rkO5VI3TdxWlMhOfF6af5q+ECgcyHg==
X-Received: by 2002:a25:3752:: with SMTP id e79mr11533382yba.263.1594965803184; 
 Thu, 16 Jul 2020 23:03:23 -0700 (PDT)
Date: Thu, 16 Jul 2020 23:02:51 -0700
In-Reply-To: <20200717060258.1602319-1-hskinnemoen@google.com>
Message-Id: <20200717060258.1602319-7-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v6 06/13] roms: Add virtual Boot ROM for NPCM7xx SoCs
From: Havard Skinnemoen <hskinnemoen@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3Kz8RXwsKCuwVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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
 Makefile                    |   1 +
 .gitmodules                 |   3 +++
 pc-bios/npcm7xx_bootrom.bin | Bin 0 -> 768 bytes
 roms/Makefile               |   7 +++++++
 roms/vbootrom               |   1 +
 5 files changed, 12 insertions(+)
 create mode 100644 pc-bios/npcm7xx_bootrom.bin
 create mode 160000 roms/vbootrom

diff --git a/Makefile b/Makefile
index 32345c610e..56473c788d 100644
--- a/Makefile
+++ b/Makefile
@@ -838,6 +838,7 @@ s390-ccw.img s390-netboot.img \
 slof.bin skiboot.lid \
 palcode-clipper \
 u-boot.e500 u-boot-sam460-20100605.bin \
+npcm7xx_bootrom.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
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
2.28.0.rc0.105.gf9edc3c819-goog


