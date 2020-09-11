Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC354C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5027C207EA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vv5ranGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5027C207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGbWe-00007A-FG
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 01:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3UQlbXwsKCtA3E649908A092AA270.yA8C08G-z0H079A929G.AD2@flex--hskinnemoen.bounces.google.com>)
 id 1kGbUz-0006RZ-Ld
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:25 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:53200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3UQlbXwsKCtA3E649908A092AA270.yA8C08G-z0H079A929G.AD2@flex--hskinnemoen.bounces.google.com>)
 id 1kGbUx-0002NW-MI
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:21:25 -0400
Received: by mail-pg1-x54a.google.com with SMTP id o5so5338921pgm.19
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=+vJajan9iFSw63pjy2rYQz72B1iTtE9JyjPJhajZgis=;
 b=vv5ranGjD6tYhbUdCwISfn6RnRMIAnOFn3Y6sukOplJ5XX0AeLNzkZe8bGFvRnx+BB
 ecOfF2qX5i/k4eYjfHzx4Oob7ZS9vt5mCY55v0CJpjjAUUEc1ezuQMzYZ8ELvgvxTXSi
 Dcvwr9w7J+cUnsl45XEI1rP9QMZERpCjwEKLDgBkwd2Q7Abcgx1yCWWUmryaxUaeOdBd
 KH8CC9u1rsZuSvNzNLInH6y2kapoMVa/zmGqmElxV9MVmoxmMvK7knhqfYAOI3k2nqd9
 pXUG8F79zTURjW239ousBT0/oNDWaKvzbRjaK/4SAzp2433iY86WIHZ1WswiYsojUwgz
 wI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=+vJajan9iFSw63pjy2rYQz72B1iTtE9JyjPJhajZgis=;
 b=m/z4WSK/+SfwFp89HrY6709fliHJqKn/qPA41NSPmVZQUv7Pxin+RdtLsnTnaznebp
 hqmu/jwd9ZoxstHtlQtEjbW8Mde5e37uOHiUWq+B8N3Z9fb65qOA/9NgXUD2itGZFXCz
 TanYIeZCA3XY9DpbV/9U7G1yyUj6tPP/Hho0cQ6/aGIsD140bjGcKZTVN+o1K5xImfbC
 xImV6HsezSjcZ5NI+ds5BFs0Iq5GXsqbEZvkro70i+T7/7wozby1QSZv1N/SIs4QBoKu
 e6USGjv/OpatVz+u+9q3gZBp9LG/pMZXnbVWfuCl8jRSDbw0Fsh/iHYGIRYmGxL5mynt
 8N3Q==
X-Gm-Message-State: AOAM533OE8XpFfT8qaB4KnEwJ0LUfCbugVeFnWift5bstbGFGo3b0ec3
 py3byPyrnNiHRbxa2KX63kNDFyqAE4CgnJAObA==
X-Google-Smtp-Source: ABdhPJxO3aV1yBb0lFFyh7UIBdadBYq+L5s/0QU4RPaSsAOeOdJfCIu2BrPpOUMNOCXkkZUbZHkiznZ35Xag8dn47A==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:a62:1c81:0:b029:13e:d13d:a0fa with
 SMTP id c123-20020a621c810000b029013ed13da0famr586584pfc.22.1599801681930;
 Thu, 10 Sep 2020 22:21:21 -0700 (PDT)
Date: Thu, 10 Sep 2020 22:20:53 -0700
In-Reply-To: <20200911052101.2602693-1-hskinnemoen@google.com>
Message-Id: <20200911052101.2602693-7-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200911052101.2602693-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v9 06/14] roms: Add virtual Boot ROM for NPCM7xx SoCs
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3UQlbXwsKCtA3E649908A092AA270.yA8C08G-z0H079A929G.AD2@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This is a minimalistic boot ROM written specifically for use with QEMU.
It supports loading the second-stage loader from SPI flash into RAM, SMP
boot, and not much else.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 .gitmodules                 |   3 +++
 MAINTAINERS                 |   2 ++
 pc-bios/README              |   6 ++++++
 pc-bios/meson.build         |   1 +
 pc-bios/npcm7xx_bootrom.bin | Bin 0 -> 768 bytes
 roms/Makefile               |   7 +++++++
 roms/vbootrom               |   1 +
 7 files changed, 20 insertions(+)
 create mode 100644 pc-bios/npcm7xx_bootrom.bin
 create mode 160000 roms/vbootrom

diff --git a/.gitmodules b/.gitmodules
index ce979398a8..9ffb9f3f4f 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -61,3 +61,6 @@
 [submodule "meson"]
 	path =3D meson
 	url =3D https://github.com/mesonbuild/meson/
+[submodule "roms/vbootrom"]
+	path =3D roms/vbootrom
+	url =3D https://github.com/google/vbootrom.git
diff --git a/MAINTAINERS b/MAINTAINERS
index ec03d213ad..094e0a31d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -757,6 +757,8 @@ L: qemu-arm@nongnu.org
 S: Supported
 F: hw/*/npcm7xx*
 F: include/hw/*/npcm7xx*
+F: pc-bios/npcm7xx_bootrom.bin
+F: roms/vbootrom
=20
 nSeries
 M: Andrzej Zaborowski <balrogg@gmail.com>
diff --git a/pc-bios/README b/pc-bios/README
index fa8b58b797..4d6297fca7 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -71,3 +71,9 @@
   ("Simplified BSD License" or "FreeBSD License", SPDX: BSD-2-Clause). Ope=
nSBI
   source code also contains code reused from other projects desribed here:
   https://github.com/riscv/opensbi/blob/master/ThirdPartyNotices.md.
+
+- npcm7xx_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for Nuvo=
ton
+  NPCM7xx BMC devices. It currently implements the bare minimum to load, p=
arse,
+  initialize and run boot images stored in SPI flash, but may grow more
+  features over time as needed. The source code is available at:
+  https://github.com/google/vbootrom
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 8087e5c0a7..182d5ebb35 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -81,6 +81,7 @@ blobs =3D files(
   'opensbi-riscv64-generic-fw_dynamic.bin',
   'opensbi-riscv32-generic-fw_dynamic.elf',
   'opensbi-riscv64-generic-fw_dynamic.elf',
+  'npcm7xx_bootrom.bin',
 )
=20
 if install_blobs
diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
new file mode 100644
index 0000000000000000000000000000000000000000..38f89d1b97b0c2e133af2a9fbed=
0521be132065b
GIT binary patch
literal 768
zcmd5)JxClu6n-<aczPbVhZYusb8wKx;7TklHfmuZdYT9pDRLwd1p_t-DFpWpyA+8(
zwKtZg3J4a0aCM3_X(ZL&4g;46VVk5e$K;z;L99|b@aE%v^S$rQ8)h(Vm@cB9IYc+2
z2SHd4^NwTIGE%w>9S05p1#kf90Sj5Z(jG8}+)IZIp~iXK=3DT&)dL`%d-q*8aR#mq{7
z9`=3D6;Dr(H0ACe72R5x?!)^86Qj-X%{+!K9iZNA@*wkBAV&iZ(l^I9?!Gz=3DS2I_*1d
zr+tTQDHjvyzKnw(hu00yX`u!Fv<!~XVcX?@kr#<B0(gGU?$W{gSsQa}CF^8Cfzp2X
z@P}yDV-bci(K9XL$FU!som2C`c)?Uc&294s^}Wzumap{hg1X^jN|V25M5tQZ=3D<9lN
z%(zKz#t-qCwHKb;HygOCpvCNL_4@1tXV1YGf^XUE_$zr{g8zWh-6gz-teI(eibtxo
z?0OZI4%rU0741PgUD`2xq@H|*4=3D+Rs?%N)Ox5G+q>C;DilBe_YlkeSUVHA-crNk+k
jtiF_MudA<CB(}8|fqYwCf3re&=3D&@_s761P#-ID$TwgmBa

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index 8cafced348..8a38da7485 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -34,6 +34,7 @@ find-cross-gcc =3D $(firstword $(wildcard $(patsubst %ld,=
%gcc,$(call find-cross-ld
 # finally strip off path + toolname so we get the prefix
 find-cross-prefix =3D $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
=20
+arm_cross_prefix :=3D $(call find-cross-prefix,arm)
 powerpc64_cross_prefix :=3D $(call find-cross-prefix,powerpc64)
 powerpc_cross_prefix :=3D $(call find-cross-prefix,powerpc)
 x86_64_cross_prefix :=3D $(call find-cross-prefix,x86_64)
@@ -63,6 +64,7 @@ default help:
 	@echo "  skiboot            -- update skiboot.lid"
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
+	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
 	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
 	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
@@ -184,6 +186,10 @@ bios-microvm:
 	$(MAKE) -C qboot
 	cp qboot/bios.bin ../pc-bios/bios-microvm.bin
=20
+npcm7xx_bootrom:
+	$(MAKE) -C vbootrom CROSS_COMPILE=3D$(arm_cross_prefix)
+	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C sgabios clean
@@ -197,3 +203,4 @@ clean:
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
--=20
2.28.0.526.ge36021eeef-goog


