Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A82C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 05:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080A121994
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 05:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="yZpX8z8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080A121994
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpQYW-0006eI-AF
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 01:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hpQYK-00069x-0I
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 01:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hpQYI-00041t-IH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 01:07:59 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hpQYI-0003zr-53
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 01:07:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id c2so18584593plz.13
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2019 22:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ae4QVQrvOWBrExcDiPTcqthskgnE0zOSrlLM33Kmm0U=;
 b=yZpX8z8JhN27lZdHOYdTN4fd/N9rBQdVHdmStcm0p0/8sxlF1FZEQ0lE3Wm65B526Z
 Y9d04r/liflNWAx5H8pfaJ1oLiWJiULuVwAFxqH9wTdkDTA6AKqDZZz9eXE4zDPvdRbH
 fibiXJBm2B6seg/lvVSR+37Wxx4DQVNPSH70JwaYpioXV2y1l8+xk2POiwC74jOkke1B
 913/EBlAm/9E1IiTRthe6ChvrTQAg3NPRCqSNIVaZPtIKaC/Z/5o18j+0oObgpIfTFr6
 L+2Rm6ZsnbggF4spWC7f9jSIq7LQIqFVEZf+MOXbldxwQzjPR7ti6MTj1yAAxshSuJZt
 0LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ae4QVQrvOWBrExcDiPTcqthskgnE0zOSrlLM33Kmm0U=;
 b=c/03mspK4lCYgKrmznCCnJZxd5cTqAsF7w+3pvdZpPqIWDnsRk0OAizOq0TxNvYEV8
 g6BN6g5IRXeLraMOZ4mhYPG6NHgpcfEYzL8OefnJDmx5+lR4VRZNNOVjh08Q556LdmQG
 mO2WhYb4mwPPGoHyCE3b5veum0ZM5xtyVe5dTwVKy6x7tPmf/wIUmkfW2okuAU6p3Zeg
 hNVXt8b89uIU9aK9S006GA1ViGPCBrL1F2oZC7Lopy6GoDSxQL3TUnD+WX8zley91f97
 o6rp5ImlnuuPjqoeaS4/cPep7vGic8xYygg+s40jVe72YyhKWIBqElwH0Yn92dv2rNU1
 3K5g==
X-Gm-Message-State: APjAAAUviR1Yia/aXuKxTunF0dDDl8rEVVzFb+8yMEm3YupqwDA4RrSj
 /347kKTT/I6Y0cQ6ktwf1BI=
X-Google-Smtp-Source: APXvYqw7ZgZ2FAGdbiSSEDMqoXH2AUr9wypD3JVUrLyophJHhEGUXz1MfzzYz2L6Sg7yz7J4o3q/UA==
X-Received: by 2002:a17:902:a03:: with SMTP id
 3mr72318920plo.302.1563772076619; 
 Sun, 21 Jul 2019 22:07:56 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f3sm59104450pfg.165.2019.07.21.22.07.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Jul 2019 22:07:55 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190716053522.78813-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <426ad50f-9b17-d980-4b97-f72c43f4e4ee@ozlabs.ru>
Date: Mon, 22 Jul 2019 15:07:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716053522.78813-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [RFC PATCH qemu] spapr: Stop providing RTAS blob
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 16/07/2019 15:35, Alexey Kardashevskiy wrote:
> SLOF implements one itself so let's remove it from QEMU. It is one less
> image and simpler setup as the RTAS blob never stays in its initial place
> anyway as the guest OS always decides where to put it.
> 
> This totally depends on https://patchwork.ozlabs.org/patch/1132440/ ,
> hence RFC.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   configure                       |   6 +----
>   Makefile                        |   2 +-
>   pc-bios/spapr-rtas/Makefile     |  27 ---------------------
>   include/hw/ppc/spapr.h          |   2 --
>   hw/ppc/spapr.c                  |  32 ++-----------------------
>   hw/ppc/spapr_rtas.c             |  41 --------------------------------
>   MAINTAINERS                     |   2 --
>   pc-bios/spapr-rtas.bin          | Bin 20 -> 0 bytes
>   pc-bios/spapr-rtas/spapr-rtas.S |  37 ----------------------------
>   9 files changed, 4 insertions(+), 145 deletions(-)
>   delete mode 100644 pc-bios/spapr-rtas/Makefile
>   delete mode 100644 pc-bios/spapr-rtas.bin
>   delete mode 100644 pc-bios/spapr-rtas/spapr-rtas.S
> 
> diff --git a/configure b/configure
> index 4983c8b53300..a132d2eb5666 100755
> --- a/configure
> +++ b/configure
> @@ -6205,9 +6205,6 @@ if { test "$cpu" = "i386" || test "$cpu" = "x86_64"; } && \
>           fi
>       done
>   fi
> -if test "$ARCH" = "ppc64" && test "$targetos" != "Darwin" ; then
> -  roms="$roms spapr-rtas"
> -fi
>   
>   # Only build s390-ccw bios if we're on s390x and the compiler has -march=z900
>   if test "$cpu" = "s390x" ; then
> @@ -7919,14 +7916,13 @@ fi
>   DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
>   DIRS="$DIRS tests/fp tests/qgraph"
>   DIRS="$DIRS docs docs/interop fsdev scsi"
> -DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
> +DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
>   DIRS="$DIRS roms/seabios roms/vgabios"
>   LINKS="Makefile tests/tcg/Makefile"
>   LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
>   LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
>   LINKS="$LINKS tests/fp/Makefile"
>   LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
> -LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
>   LINKS="$LINKS pc-bios/s390-ccw/Makefile"
>   LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
>   LINKS="$LINKS pc-bios/qemu-icon.bmp"
> diff --git a/Makefile b/Makefile
> index 1fcbaed62c76..d780f4eebceb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -764,7 +764,7 @@ efi-e1000e.rom efi-vmxnet3.rom \
>   bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
>   multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
>   s390-ccw.img s390-netboot.img \
> -spapr-rtas.bin slof.bin skiboot.lid \
> +slof.bin skiboot.lid \
>   palcode-clipper \
>   u-boot.e500 u-boot-sam460-20100605.bin \
>   qemu_vga.ndrv \
> diff --git a/pc-bios/spapr-rtas/Makefile b/pc-bios/spapr-rtas/Makefile
> deleted file mode 100644
> index 4b9bb1230658..000000000000
> --- a/pc-bios/spapr-rtas/Makefile
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -all: build-all
> -# Dummy command so that make thinks it has done something
> -	@true
> -
> -include ../../config-host.mak
> -include $(SRC_PATH)/rules.mak
> -
> -$(call set-vpath, $(SRC_PATH)/pc-bios/spapr-rtas)
> -
> -.PHONY : all clean build-all
> -
> -#CFLAGS += -I$(SRC_PATH)
> -#QEMU_CFLAGS = $(CFLAGS)
> -
> -build-all: spapr-rtas.bin
> -
> -%.o: %.S
> -	$(call quiet-command,$(CCAS) -mbig -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
> -
> -%.img: %.o
> -	$(call quiet-command,$(CC) -nostdlib -mbig -o $@ $<,"Building","$(TARGET_DIR)$@")
> -
> -%.bin: %.img
> -	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"Building","$(TARGET_DIR)$@")
> -
> -clean:
> -	rm -f *.o *.d *.img *.bin *~
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 60553d32c4fa..b6640370c839 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -152,8 +152,6 @@ struct SpaprMachineState {
>   
>       hwaddr rma_size;
>       int vrma_adjust;
> -    ssize_t rtas_size;
> -    void *rtas_blob;
>       uint32_t fdt_size;
>       uint32_t fdt_initial_size;
>       void *fdt_blob;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8783b433960c..36cd45bd78b3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -89,7 +89,6 @@
>    * We load our kernel at 4M, leaving space for SLOF initial image
>    */
>   #define FDT_MAX_SIZE            0x100000
> -#define RTAS_MAX_SIZE           0x10000
>   #define RTAS_MAX_ADDR           0x80000000 /* RTAS must stay below that */
>   #define FW_MAX_SIZE             0x400000
>   #define FW_FILE_NAME            "slof.bin"
> @@ -1704,8 +1703,7 @@ static void spapr_machine_reset(MachineState *machine)
>   {
>       SpaprMachineState *spapr = SPAPR_MACHINE(machine);
>       PowerPCCPU *first_ppc_cpu;
> -    uint32_t rtas_limit;
> -    hwaddr rtas_addr, fdt_addr;
> +    hwaddr fdt_addr;
>       void *fdt;
>       int rc;
>   
> @@ -1783,14 +1781,10 @@ static void spapr_machine_reset(MachineState *machine)
>        * or just below 2GB, whichever is lower, so that it can be
>        * processed with 32-bit real mode code if necessary
>        */
> -    rtas_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR);
> -    rtas_addr = rtas_limit - RTAS_MAX_SIZE;
> -    fdt_addr = rtas_addr - FDT_MAX_SIZE;
> +    fdt_addr = RTAS_MAX_ADDR - FDT_MAX_SIZE;



Meanwhile a bug is here, should have been:

+    fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;


Appears only on p9 (radix?). Thanks,


-- 
Alexey

