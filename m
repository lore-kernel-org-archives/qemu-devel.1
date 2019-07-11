Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3DDC74A3F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186FE21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKkKrWU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186FE21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlNXa-0002Pw-Bw
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 21:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hlNW0-0000jo-LB
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hlNVr-0003HG-1j
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:04:52 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1hlNVn-0003By-0m; Wed, 10 Jul 2019 21:04:41 -0400
Received: by mail-pl1-x641.google.com with SMTP id m9so2076302pls.8;
 Wed, 10 Jul 2019 18:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0H/wqK+97+E7/2C0v0UlAlXLSe6WYFo3pbcBcwLAanY=;
 b=TKkKrWU+Kb1jOXUT4fBnOKQ743ll9oSB18RPAPppLMpb/MqSnCttH6vFKidKCi0DvP
 hiNUq09WyAIuFUb7sdeerCjOo9B8QCYoQT+YwxaVG7xl95Sszt0G5SBPDYGk9/x0LK5P
 4PGonh7jrIdjXh3Fy4gQd5vPauFv7vcchdFEbYysW8B3gcNyzpCXhXqcloRyQRkmH+9g
 UgJgD0rDbCCo2TM3INP1oiREgvZgrVAU5HlKkyIcz8GZA+7DNqN09N2rm/xEV35THxGK
 G9rvq61C5IdYLOSXVHVZeShavn17rFsbYc3RKEZRqw4ez9JMgH/yOp8Wlb6Edi5U+do+
 4Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=0H/wqK+97+E7/2C0v0UlAlXLSe6WYFo3pbcBcwLAanY=;
 b=ati77gmmU1vfH2S4NJod42xLwbJBmc+H7siACAY9QHOUiFeDe0KuURoFn8qvffaaAe
 5qtgfeQmgaDrn4YESaLEOJnQTTGgCxk0BEGOryZuuzuwdauaOKPHjxyYL4KETLrvL152
 bNfAGBquHbS+sz2G5gOYzXU6bryDozrzno2r4MTPQdGsGXKLkHMqW0QqQ/OF325BkBOt
 77d4uL/hvHY+NwkomIxNtHZPTFxj5BHtY12mNlyEMJtHSc7xQSkfxTkBHpyDrG7rGIKf
 S+v4xVVeTKWnzm65tHHhg2+Nu4snbcqVj9wst5xpmAKEuVsINgwNNN28X+knAkpLgUqu
 n31w==
X-Gm-Message-State: APjAAAVGAymiCYz68q3MpUppSxtIlvx9GeZs2hliq94b/6TUi+Bx+0wd
 VWVrdIhLiyX3FqN8vMUrOVE=
X-Google-Smtp-Source: APXvYqx9auy8CdD6sckmozg1E6nkGJMMj8DQnd0s0bSiRVeCnHpIoJxWjUn6qs0S2JZR65FnPK3S5w==
X-Received: by 2002:a17:902:d81:: with SMTP id 1mr1357461plv.323.1562807074855; 
 Wed, 10 Jul 2019 18:04:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id t11sm2954909pgp.1.2019.07.10.18.04.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 18:04:33 -0700 (PDT)
Date: Wed, 10 Jul 2019 18:04:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20190711010432.GB707@roeck-us.net>
References: <cover.1562803960.git.alistair.francis@wdc.com>
 <1ef8cbbcf0c74fe423019eb91d58543b7778e062.1562803960.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef8cbbcf0c74fe423019eb91d58543b7778e062.1562803960.git.alistair.francis@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v2 1/2] roms: Add OpenSBI version 0.4
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
Cc: peter.maydell@linaro.org, qemu-riscv@nongnu.org, codyprime@gmail.com,
 anup@brainfault.org, palmer@sifive.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com, alistair23@gmail.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 10, 2019 at 05:14:04PM -0700, Alistair Francis wrote:
> Add OpenSBI version 0.4 as a git submodule and as a prebult binary.
> 
> OpenSBI (https://github.com/riscv/opensbi) aims to provide an open-source
> reference implementation of the RISC-V Supervisor Binary Interface (SBI)
> specifications for platform-specific firmwares executing in M-mode. For all
> supported platforms, OpenSBI provides several runtime firmware examples.
> These example firmwares can be used to replace the legacy riscv-pk bootloader
> and enable the use of well-known bootloaders such as U-Boot.
> 
> OpenSBI is distributed under the terms of the BSD 2-clause license
> ("Simplified BSD License" or "FreeBSD License", SPDX: BSD-2-Clause). OpenSBI
> source code also contains code reused from other projects desribed here:
> https://github.com/riscv/opensbi/blob/master/ThirdPartyNotices.md.
> 
> In this case all of the code we are using from OpenSBI is BSD 2-clause
> as we aren't using the Kendryte code (Apache-2.0) with QEMU and libfdt
> is dual licensed as BSD 2-clause (and GPL-2.0+). OpenSBI isn't being
> linked with QEMU either it is just being included with QEMU.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .gitmodules                                  |   3 ++
>  LICENSE                                      |  21 ++++----
>  Makefile                                     |   5 +-
>  pc-bios/README                               |  11 +++++
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 36888 bytes
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 40968 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 40968 bytes
>  roms/Makefile                                |  48 ++++++++++++++-----
>  roms/opensbi                                 |   1 +
>  9 files changed, 68 insertions(+), 21 deletions(-)
>  create mode 100755 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  create mode 100755 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  create mode 100755 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>  create mode 160000 roms/opensbi
> 
> diff --git a/.gitmodules b/.gitmodules
> index 2857eec763..7a10e72e09 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -55,3 +55,6 @@
>  [submodule "slirp"]
>  	path = slirp
>  	url = https://git.qemu.org/git/libslirp.git
> +[submodule "roms/opensbi"]
> +	path = roms/opensbi
> +	url = https://github.com/riscv/opensbi.git
> diff --git a/LICENSE b/LICENSE
> index 0e0b4b9553..9389ba614f 100644
> --- a/LICENSE
> +++ b/LICENSE
> @@ -1,13 +1,18 @@
> -The following points clarify the QEMU license:
> +The QEMU distribution includes both the QEMU emulator and
> +various firmware files.  These are separate programs that are
> +distributed together for our users' convenience, and they have
> +separate licenses.
>  
> -1) QEMU as a whole is released under the GNU General Public License,
> -version 2.
> +The following points clarify the license of the QEMU emulator:
>  
> -2) Parts of QEMU have specific licenses which are compatible with the
> -GNU General Public License, version 2. Hence each source file contains
> -its own licensing information.  Source files with no licensing information
> -are released under the GNU General Public License, version 2 or (at your
> -option) any later version.
> +1) The QEMU emulator as a whole is released under the GNU General
> +Public License, version 2.
> +
> +2) Parts of the QEMU emulator have specific licenses which are compatible
> +with the GNU General Public License, version 2. Hence each source file
> +contains its own licensing information.  Source files with no licensing
> +information are released under the GNU General Public License, version
> +2 or (at your option) any later version.
>  
>  As of July 2013, contributions under version 2 of the GNU General Public
>  License (and no later version) are only accepted for the following files
> diff --git a/Makefile b/Makefile
> index 1fcbaed62c..b44e6ae5ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -769,7 +769,10 @@ palcode-clipper \
>  u-boot.e500 u-boot-sam460-20100605.bin \
>  qemu_vga.ndrv \
>  edk2-licenses.txt \
> -hppa-firmware.img
> +hppa-firmware.img \
> +opensbi-riscv32-virt-fw_jump.bin \
> +opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
> +
>  
>  DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
>  60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
> diff --git a/pc-bios/README b/pc-bios/README
> index 180795a55b..eacb97043d 100644
> --- a/pc-bios/README
> +++ b/pc-bios/README
> @@ -63,3 +63,14 @@
>    ARM. Licensing information is given in "edk2-licenses.txt". The image files
>    are described by the JSON documents in the "pc-bios/descriptors" directory,
>    which conform to the "docs/interop/firmware.json" schema.
> +
> +- OpenSBI (https://github.com/riscv/opensbi) aims to provide an open-source
> +  reference implementation of the RISC-V Supervisor Binary Interface (SBI)
> +  specifications for platform-specific firmwares executing in M-mode. For all
> +  supported platforms, OpenSBI provides several runtime firmware examples.
> +  These example firmwares can be used to replace the legacy riscv-pk bootloader
> +  and enable the use of well-known bootloaders such as U-Boot.
> +  OpenSBI is distributed under the terms of the BSD 2-clause license
> +  ("Simplified BSD License" or "FreeBSD License", SPDX: BSD-2-Clause). OpenSBI
> +  source code also contains code reused from other projects desribed here:
> +  https://github.com/riscv/opensbi/blob/master/ThirdPartyNotices.md.
> diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
> new file mode 100755
> index 0000000000000000000000000000000000000000..f5bcaa56954c860d09acc0cb337c1666d88b6efb
> GIT binary patch
> literal 36888
> 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
> aYBNxqf!YlGFEfy=y3vU{B4jIw_JW`98-y+Z
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> new file mode 100755
> index 0000000000000000000000000000000000000000..5d7a1ef6818994bac4a36818ad36043b592ce309
> GIT binary patch
> literal 40968
> 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
> P4$ODpzp?{uKaqa`WWcWt
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
> new file mode 100755
> index 0000000000000000000000000000000000000000..4cec6f0210f31969ac232123ce101ce71bbf9f2b
> GIT binary patch
> literal 40968
> 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
> Z%^;huogUK&q!CCXkVfFY5`n7e$RB^+7N!6I
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 078d3fb705..dc70fb5aea 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -37,6 +37,8 @@ find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
>  powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
>  powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
>  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> +riscv32_cross_prefix := $(call find-cross-prefix,riscv32)
> +riscv64_cross_prefix := $(call find-cross-prefix,riscv64)
>  
>  # tag our seabios builds
>  SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
> @@ -52,18 +54,21 @@ EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
>  default:
>  	@echo "nothing is build by default"
>  	@echo "available build targets:"
> -	@echo "  bios           -- update bios.bin (seabios)"
> -	@echo "  vgabios        -- update vgabios binaries (seabios)"
> -	@echo "  sgabios        -- update sgabios binaries"
> -	@echo "  pxerom         -- update nic roms (bios only)"
> -	@echo "  efirom         -- update nic roms (bios+efi)"
> -	@echo "  slof           -- update slof.bin"
> -	@echo "  skiboot        -- update skiboot.lid"
> -	@echo "  u-boot.e500    -- update u-boot.e500"
> -	@echo "  u-boot.sam460  -- update u-boot.sam460"
> -	@echo "  efi            -- update UEFI (edk2) platform firmware"
> -	@echo "  clean          -- delete the files generated by the previous" \
> -	                          "build targets"
> +	@echo "  bios               -- update bios.bin (seabios)"
> +	@echo "  vgabios            -- update vgabios binaries (seabios)"
> +	@echo "  sgabios            -- update sgabios binaries"
> +	@echo "  pxerom             -- update nic roms (bios only)"
> +	@echo "  efirom             -- update nic roms (bios+efi)"
> +	@echo "  slof               -- update slof.bin"
> +	@echo "  skiboot            -- update skiboot.lid"
> +	@echo "  u-boot.e500        -- update u-boot.e500"
> +	@echo "  u-boot.sam460      -- update u-boot.sam460"
> +	@echo "  efi                -- update UEFI (edk2) platform firmware"
> +	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
> +	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> +	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> +	@echo "  clean              -- delete the files generated by the previous" \
> +	                              "build targets"
>  
>  bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
>  	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
> @@ -162,6 +167,24 @@ skiboot:
>  efi: edk2-basetools
>  	$(MAKE) -f Makefile.edk2
>  
> +opensbi32-virt:
> +	$(MAKE) -C opensbi \
> +		CROSS_COMPILE=$(riscv32_cross_prefix) \
> +		PLATFORM="qemu/virt"
> +	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
> +
> +opensbi64-virt:
> +	$(MAKE) -C opensbi \
> +		CROSS_COMPILE=$(riscv64_cross_prefix) \
> +		PLATFORM="qemu/virt"
> +	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
> +
> +opensbi64-sifive_u:
> +	$(MAKE) -C opensbi \
> +		CROSS_COMPILE=$(riscv64_cross_prefix) \
> +		PLATFORM="qemu/sifive_u"
> +	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> +
>  clean:
>  	rm -rf seabios/.config seabios/out seabios/builds
>  	$(MAKE) -C sgabios clean
> @@ -173,3 +196,4 @@ clean:
>  	$(MAKE) -C u-boot-sam460ex distclean
>  	$(MAKE) -C skiboot clean
>  	$(MAKE) -f Makefile.edk2 clean
> +	$(MAKE) -C opensbi clean
> diff --git a/roms/opensbi b/roms/opensbi
> new file mode 160000
> index 0000000000..ce228ee091
> --- /dev/null
> +++ b/roms/opensbi
> @@ -0,0 +1 @@
> +Subproject commit ce228ee0919deb9957192d723eecc8aaae2697c6
> -- 
> 2.22.0
> 

