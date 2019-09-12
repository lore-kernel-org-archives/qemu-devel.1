Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BBBC49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 01:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B6F20863
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 01:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="UmLqJ0u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B6F20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8EH3-00040S-LU
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 21:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i8EGF-0003SV-W4
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i8EGC-0001Ol-UE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:51:02 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1i8EGC-0001O6-C3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:51:00 -0400
Received: by mail-pf1-x443.google.com with SMTP id x127so14857807pfb.7
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 18:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1J3YEsbnvO+qjR2692vg6Ouu/nr+TQBVTKgMTftNCAM=;
 b=UmLqJ0u2Fmxm7Y995Q3IQ6JAS0zv3qECRgoLMdvyoXuvDmWqJxgYQnxTekndYGsL1S
 pZwTgjmktC9834keFBI97JqdaazhQNJyd9AJ5WMFEHDFgwsf6RqW6IXN0ZtIWdaSSfhM
 AUzWzSzTNA0Jg0LqoOpvKQ0II9Ex9J2YCwtzfZhXxaDI2lIhIaukN+RFxZlwyv11sI54
 KBCByqyME8WSUGZtRgWxOUVegouof5dIcqUXV3pgptA3ypZIPtRIBuUj4KDSSSjy9HEG
 2f3e0WfOnNUeiIOrk2VeMWWG8XmA7x1Ezca+PhdQoiUnjn+J1VHwg8VfpXz/9bJFzg4H
 wX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1J3YEsbnvO+qjR2692vg6Ouu/nr+TQBVTKgMTftNCAM=;
 b=EsDts7IuvfgmDkc+UiAzM8/9HiD81KR65CQlrkJ2WH9vVbsFMkIBWq9Tfy1ut48tX6
 snnxP94ujmmzBJ5eGroJssytWCpqOG/cFmrlMrjhFtB741V2h9v5hEAbaGRXkBlJa+hd
 XrST/eynN6hyIWtlew2Jj0slOz4R9EcKeK3mL5b5bjHydXeW3XfVv6goOYboIpVfLgDF
 ohSIUNYaWUxNK7DdYNvkiKFda/bikFo/cNWV4Jag+zXGdNErDagSpASVO6Vtfxqvj4Li
 1cxzc7eBR1jTczdmahJHMPw93kQqbS7vwVscLBw3YcwevJp8Nhb82B+sSb9pmmUM3uja
 Up7w==
X-Gm-Message-State: APjAAAWKmsXjRIQU1+nZCMXQkh7OlInge7RqkM250OCk/oEjVeeph7HH
 wMGu+XIp8vc1iBygYthgIht0FA==
X-Google-Smtp-Source: APXvYqwkpeQCZvUW9D7G8udDhhbO8wkX2WkFAVElBVCoYuLyKKyp1kFKLaze6TH6ydraY3ByNcU3dQ==
X-Received: by 2002:a17:90a:ba96:: with SMTP id
 t22mr9038462pjr.104.1568253058932; 
 Wed, 11 Sep 2019 18:50:58 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 127sm42983470pfy.56.2019.09.11.18.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2019 18:50:58 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
 <20190911040452.8341-7-david@gibson.dropbear.id.au>
 <20190911111617.7352aa60@bahia.lan>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <3a8b285e-3b3e-0e76-175f-b20cbf258d22@ozlabs.ru>
Date: Thu, 12 Sep 2019 11:50:53 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190911111617.7352aa60@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 6/7] spapr: Stop providing RTAS blob
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
Cc: lvivier@redhat.com, philmd@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/09/2019 19:16, Greg Kurz wrote:
> On Wed, 11 Sep 2019 14:04:51 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> SLOF implements one itself so let's remove it from QEMU. It is one less
>> image and simpler setup as the RTAS blob never stays in its initial place
>> anyway as the guest OS always decides where to put it.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  MAINTAINERS                     |   2 --
>>  Makefile                        |   2 +-
>>  configure                       |   6 +----
>>  hw/ppc/spapr.c                  |  32 ++-----------------------
>>  hw/ppc/spapr_rtas.c             |  41 --------------------------------
>>  include/hw/ppc/spapr.h          |   2 --
>>  pc-bios/spapr-rtas.bin          | Bin 20 -> 0 bytes
>>  pc-bios/spapr-rtas/Makefile     |  27 ---------------------
>>  pc-bios/spapr-rtas/spapr-rtas.S |  37 ----------------------------
>>  9 files changed, 4 insertions(+), 145 deletions(-)
>>  delete mode 100644 pc-bios/spapr-rtas.bin
>>  delete mode 100644 pc-bios/spapr-rtas/Makefile
>>  delete mode 100644 pc-bios/spapr-rtas/spapr-rtas.S
>>
> 
> Nice diffstat :)
> 
> But pwclient fails to apply it :(
> 
> [greg@bahia qemu-spapr]$ pwclient git-am 1160642
> Applying patch #1160642 using 'git am'
> Description: [6/7] spapr: Stop providing RTAS blob
> Applying: spapr: Stop providing RTAS blob
> error: cannot apply binary patch to 'pc-bios/spapr-rtas.bin' without full index line


Some git feature/bug with removing binaries:

https://stackoverflow.com/questions/17152171/git-cannot-apply-binary-patch-without-full-index-line


David posted with this:
===
diff --git a/pc-bios/spapr-rtas.bin b/pc-bios/spapr-rtas.bin
deleted file mode 100644
index fc24c8ed8b..0000000000
Binary files a/pc-bios/spapr-rtas.bin and /dev/null differ
===

And my patch has a bigger chunk:

git format-patch -1 --stdout 1a5efb9283c2
(there is no additional flag needed to my git 2.17.1):

===
diff --git a/pc-bios/spapr-rtas.bin b/pc-bios/spapr-rtas.bin
deleted file mode 100644
index
fc24c8ed8b92a3a441aed6e2bd013b2ccece9229..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 20
bcmb<Pk*=^wU|>i{{=neEz@X&Uz@PvCJTV0q
===

I do not know why are these different.

Thy this one:
https://patchwork.ozlabs.org/patch/1132443/



> error: pc-bios/spapr-rtas.bin: patch does not apply
> Patch failed at 0001 spapr: Stop providing RTAS blob
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 'git am' failed with exit status 128
> 
> and
> 
> [greg@bahia qemu-spapr]$ git am --show-current-patch | patch -p1 --merge 
> patching file MAINTAINERS
> patching file Makefile
> patching file configure
> patching file hw/ppc/spapr.c
> patching file hw/ppc/spapr_rtas.c
> patching file include/hw/ppc/spapr.h
> patching file pc-bios/spapr-rtas.bin
> Not deleting file pc-bios/spapr-rtas.bin as content differs from patch
> 
> Not sure what's happening here...
> 
> patching file pc-bios/spapr-rtas/Makefile
> patching file pc-bios/spapr-rtas/spapr-rtas.S
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 50eaf005f4..9823f40213 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1077,8 +1077,6 @@ F: hw/*/spapr*
>>  F: include/hw/*/spapr*
>>  F: hw/*/xics*
>>  F: include/hw/*/xics*
>> -F: pc-bios/spapr-rtas/*
>> -F: pc-bios/spapr-rtas.bin
>>  F: pc-bios/slof.bin
>>  F: docs/specs/ppc-spapr-hcalls.txt
>>  F: docs/specs/ppc-spapr-hotplug.txt
>> diff --git a/Makefile b/Makefile
>> index ae17a83067..4637f95371 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -764,7 +764,7 @@ qemu-nsis.bmp \
>>  bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
>>  multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
>>  s390-ccw.img s390-netboot.img \
>> -spapr-rtas.bin slof.bin skiboot.lid \
>> +slof.bin skiboot.lid \
>>  palcode-clipper \
>>  u-boot.e500 u-boot-sam460-20100605.bin \
>>  qemu_vga.ndrv \
>> diff --git a/configure b/configure
>> index 95134c0180..b79d38592b 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6211,9 +6211,6 @@ if { test "$cpu" = "i386" || test "$cpu" = "x86_64"; } && \
>>          fi
>>      done
>>  fi
>> -if test "$ARCH" = "ppc64" && test "$targetos" != "Darwin" ; then
>> -  roms="$roms spapr-rtas"
>> -fi
>>  
>>  # Only build s390-ccw bios if we're on s390x and the compiler has -march=z900
>>  if test "$cpu" = "s390x" ; then
>> @@ -7930,14 +7927,13 @@ fi
>>  DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
>>  DIRS="$DIRS tests/fp tests/qgraph"
>>  DIRS="$DIRS docs docs/interop fsdev scsi"
>> -DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>> +DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
>>  DIRS="$DIRS roms/seabios roms/vgabios"
>>  LINKS="Makefile tests/tcg/Makefile"
>>  LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
>>  LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
>>  LINKS="$LINKS tests/fp/Makefile"
>>  LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
>> -LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
>>  LINKS="$LINKS pc-bios/s390-ccw/Makefile"
>>  LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
>>  LINKS="$LINKS pc-bios/qemu-icon.bmp"
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index d18744268f..5a919a6cc1 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -94,7 +94,6 @@
>>   * We load our kernel at 4M, leaving space for SLOF initial image
>>   */
>>  #define FDT_MAX_SIZE            0x100000
>> -#define RTAS_MAX_SIZE           0x10000
>>  #define RTAS_MAX_ADDR           0x80000000 /* RTAS must stay below that */
>>  #define FW_MAX_SIZE             0x400000
>>  #define FW_FILE_NAME            "slof.bin"
>> @@ -1721,8 +1720,7 @@ static void spapr_machine_reset(MachineState *machine)
>>  {
>>      SpaprMachineState *spapr = SPAPR_MACHINE(machine);
>>      PowerPCCPU *first_ppc_cpu;
>> -    uint32_t rtas_limit;
>> -    hwaddr rtas_addr, fdt_addr;
>> +    hwaddr fdt_addr;
>>      void *fdt;
>>      int rc;
>>  
>> @@ -1786,14 +1784,10 @@ static void spapr_machine_reset(MachineState *machine)
>>       * or just below 2GB, whichever is lower, so that it can be
>>       * processed with 32-bit real mode code if necessary
>>       */
>> -    rtas_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR);
>> -    rtas_addr = rtas_limit - RTAS_MAX_SIZE;
>> -    fdt_addr = rtas_addr - FDT_MAX_SIZE;
>> +    fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
>>  
>>      fdt = spapr_build_fdt(spapr);
>>  
>> -    spapr_load_rtas(spapr, fdt, rtas_addr);
>> -
>>      rc = fdt_pack(fdt);
>>  
>>      /* Should only fail if we've built a corrupted tree */
>> @@ -2953,28 +2947,6 @@ static void spapr_machine_init(MachineState *machine)
>>          spapr_create_lmb_dr_connectors(spapr);
>>      }
>>  
>> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, "spapr-rtas.bin");
>> -    if (!filename) {
>> -        error_report("Could not find LPAR rtas '%s'", "spapr-rtas.bin");
>> -        exit(1);
>> -    }
>> -    spapr->rtas_size = get_image_size(filename);
>> -    if (spapr->rtas_size < 0) {
>> -        error_report("Could not get size of LPAR rtas '%s'", filename);
>> -        exit(1);
>> -    }
>> -    spapr->rtas_blob = g_malloc(spapr->rtas_size);
>> -    if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
>> -        error_report("Could not load LPAR rtas '%s'", filename);
>> -        exit(1);
>> -    }
>> -    if (spapr->rtas_size > RTAS_MAX_SIZE) {
>> -        error_report("RTAS too big ! 0x%zx bytes (max is 0x%x)",
>> -                     (size_t)spapr->rtas_size, RTAS_MAX_SIZE);
>> -        exit(1);
>> -    }
>> -    g_free(filename);
>> -
>>      /* Set up RTAS event infrastructure */
>>      spapr_events_init(spapr);
>>  
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index bee3835214..8d8d8cdfcb 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -477,47 +477,6 @@ void spapr_dt_rtas_tokens(void *fdt, int rtas)
>>      }
>>  }
>>  
>> -void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
>> -{
>> -    int rtas_node;
>> -    int ret;
>> -
>> -    /* Copy RTAS blob into guest RAM */
>> -    cpu_physical_memory_write(addr, spapr->rtas_blob, spapr->rtas_size);
>> -
>> -    ret = fdt_add_mem_rsv(fdt, addr, spapr->rtas_size);
>> -    if (ret < 0) {
>> -        error_report("Couldn't add RTAS reserve entry: %s",
>> -                     fdt_strerror(ret));
>> -        exit(1);
>> -    }
>> -
>> -    /* Update the device tree with the blob's location */
>> -    rtas_node = fdt_path_offset(fdt, "/rtas");
>> -    assert(rtas_node >= 0);
>> -
>> -    ret = fdt_setprop_cell(fdt, rtas_node, "linux,rtas-base", addr);
>> -    if (ret < 0) {
>> -        error_report("Couldn't add linux,rtas-base property: %s",
>> -                     fdt_strerror(ret));
>> -        exit(1);
>> -    }
>> -
>> -    ret = fdt_setprop_cell(fdt, rtas_node, "linux,rtas-entry", addr);
>> -    if (ret < 0) {
>> -        error_report("Couldn't add linux,rtas-entry property: %s",
>> -                     fdt_strerror(ret));
>> -        exit(1);
>> -    }
>> -
>> -    ret = fdt_setprop_cell(fdt, rtas_node, "rtas-size", spapr->rtas_size);
>> -    if (ret < 0) {
>> -        error_report("Couldn't add rtas-size property: %s",
>> -                     fdt_strerror(ret));
>> -        exit(1);
>> -    }
>> -}
>> -
>>  static void core_rtas_register_types(void)
>>  {
>>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index dfec8e8e76..cbd1a4c9f3 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -154,8 +154,6 @@ struct SpaprMachineState {
>>  
>>      hwaddr rma_size;
>>      int vrma_adjust;
>> -    ssize_t rtas_size;
>> -    void *rtas_blob;
>>      uint32_t fdt_size;
>>      uint32_t fdt_initial_size;
>>      void *fdt_blob;
>> diff --git a/pc-bios/spapr-rtas.bin b/pc-bios/spapr-rtas.bin
>> deleted file mode 100644
>> index fc24c8ed8b..0000000000
>> Binary files a/pc-bios/spapr-rtas.bin and /dev/null differ
>> diff --git a/pc-bios/spapr-rtas/Makefile b/pc-bios/spapr-rtas/Makefile
>> deleted file mode 100644
>> index 4b9bb12306..0000000000
>> --- a/pc-bios/spapr-rtas/Makefile
>> +++ /dev/null
>> @@ -1,27 +0,0 @@
>> -all: build-all
>> -# Dummy command so that make thinks it has done something
>> -	@true
>> -
>> -include ../../config-host.mak
>> -include $(SRC_PATH)/rules.mak
>> -
>> -$(call set-vpath, $(SRC_PATH)/pc-bios/spapr-rtas)
>> -
>> -.PHONY : all clean build-all
>> -
>> -#CFLAGS += -I$(SRC_PATH)
>> -#QEMU_CFLAGS = $(CFLAGS)
>> -
>> -build-all: spapr-rtas.bin
>> -
>> -%.o: %.S
>> -	$(call quiet-command,$(CCAS) -mbig -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
>> -
>> -%.img: %.o
>> -	$(call quiet-command,$(CC) -nostdlib -mbig -o $@ $<,"Building","$(TARGET_DIR)$@")
>> -
>> -%.bin: %.img
>> -	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"Building","$(TARGET_DIR)$@")
>> -
>> -clean:
>> -	rm -f *.o *.d *.img *.bin *~
>> diff --git a/pc-bios/spapr-rtas/spapr-rtas.S b/pc-bios/spapr-rtas/spapr-rtas.S
>> deleted file mode 100644
>> index 903bec2150..0000000000
>> --- a/pc-bios/spapr-rtas/spapr-rtas.S
>> +++ /dev/null
>> @@ -1,37 +0,0 @@
>> -/*
>> - * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Emulator
>> - *
>> - * Trivial in-partition RTAS implementation, based on a hypercall
>> - *
>> - * Copyright (c) 2010,2011 David Gibson, IBM Corporation.
>> - *
>> - * Permission is hereby granted, free of charge, to any person obtaining a copy
>> - * of this software and associated documentation files (the "Software"), to deal
>> - * in the Software without restriction, including without limitation the rights
>> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> - * copies of the Software, and to permit persons to whom the Software is
>> - * furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice shall be included in
>> - * all copies or substantial portions of the Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> - * THE SOFTWARE.
>> - *
>> - */
>> -
>> -#define KVMPPC_HCALL_BASE       0xf000
>> -#define KVMPPC_H_RTAS           (KVMPPC_HCALL_BASE + 0x0)
>> -
>> -.globl	_start
>> -_start:
>> -	mr	4,3
>> -	lis	3,KVMPPC_H_RTAS@h
>> -	ori	3,3,KVMPPC_H_RTAS@l
>> -	sc	1
>> -	blr
> 

-- 
Alexey

