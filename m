Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F2C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5BA208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="0f+p6v60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5BA208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSy5-0006Kz-9w
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36844)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anup@brainfault.org>) id 1hdSxZ-0005uv-Gp
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1hdSxY-0006b3-AZ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:16:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1hdSxY-0006ax-43
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:16:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so1758554wrw.13
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7YAqiUl6uSINL5uEYTnIeDoMbPv9H58bnHIi8s6YMAU=;
 b=0f+p6v60jfi8yXqmjKaxc6E2FcY9YqqMehu8EzL/CIbjps3cKvwN9Et2dti6w4qs4E
 SwCFQoblpqRcpYiGGnPVOJbBzUjHcoFUjUnekK4fwfCx0AkS/qE9v+xKQWjr115XAWaw
 bKyjAPMhvQI33okFf3sZayHyDMbbVTAb+0/509m61m8ayRalZicB0RpZWHlniV9fW7Ev
 aFKzE62k7P98EMEMz4e08dJz0SPdeHCnG2FIbnpFB6f0CSB7e3NEKp9g0Q/QCWEX5urk
 SLA1LfSrIJUrzRgLWroYhDmloWXd3sQvjIzfUnn4RIFGcHxw+BJWllDOk7gxfGDmbYzv
 zt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7YAqiUl6uSINL5uEYTnIeDoMbPv9H58bnHIi8s6YMAU=;
 b=gOGUIK8uyZbwFmZEt/j/p28HzLsZ5FmVLMZqRodtk9sz6tq+i1SRLuEUPaDV3s2PCH
 wkpizIK4RFQfIfAi2CZR57U0B+TPG8q2GZ4O/Zij2qsl++Tvg3jXxs8JyZwAkH+/rhaX
 uYtfe5rrnNhcsUQYAdF4RKgHB2Ub6kay8heSHc+j4clO3Isi2xL+xMfpiMgmQnVQf0ax
 6Sh9tvVWTk4p1ci22n1S4mn6nhpcH4MJdmK5W3NjSEnC5iAlNISGN5EwF6ky2817pz6x
 x0wmdmcA2ExUlhVVQE4Jlo95A7LBNA9VN7hnzqqN1X6xGC0yIk3+klv16R9Z04RbXQsz
 el2g==
X-Gm-Message-State: APjAAAULI/Rh9aNlLfww+qxRlNojMV+7GI50jKQ1ZCvqGS2f5kOP4r3U
 h5p1ASRPhJ4mMRyWq7pUDIDNjtvnOGDxqIGJZhtIWQ==
X-Google-Smtp-Source: APXvYqzgXfnadi7pegyG3voglb6f839RM32b+VNaKQCmfURYcNR7+SMyAHgI0ytWsqW7seDb5pOlI6nIXzi1SQyolz8=
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr33260266wrt.227.1560921394994; 
 Tue, 18 Jun 2019 22:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <3d7dd8bc94dbfddf0c01cfc7f3bebc937d1e6894.1560904640.git.alistair.francis@wdc.com>
In-Reply-To: <3d7dd8bc94dbfddf0c01cfc7f3bebc937d1e6894.1560904640.git.alistair.francis@wdc.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 19 Jun 2019 10:46:24 +0530
Message-ID: <CAAhSdy289EV2S2pYZP-VQNoiVHcV_stdgFYEj5Y01FsuZ+9E4A@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-riscv] [RFC v1 5/5] hw/riscv: Load OpenSBI
 as the default firmware
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
Cc: alistair23@gmail.com, Palmer Dabbelt <palmer@sifive.com>,
 qemu-riscv@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 6:21 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> If the user hasn't specified a firmware to load (with -bios) or
> specified no bios (with -bios none) then load OpenSBI by default. This
> allows users to boot a RISC-V kernel with just -kernel.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c         | 28 ++++++++++++++++++++++++++++
>  hw/riscv/sifive_u.c     |  4 +---
>  hw/riscv/virt.c         |  4 +---
>  include/hw/riscv/boot.h |  1 +
>  4 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 7f68035a3f..5f021591ed 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -18,6 +18,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu-common.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "exec/cpu-defs.h"
> @@ -32,6 +33,12 @@
>  # define KERNEL_BOOT_ADDRESS 0x80200000
>  #endif
>
> +#if defined(TARGET_RISCV32)
> +# define BIOS_FILENAME "opensbi-riscv32-fw_jump.elf"
> +#else
> +# define BIOS_FILENAME "opensbi-riscv64-fw_jump.elf"
> +#endif

Based on my comment on PATCH4, BIOS_FILENAME should
be derived from QEMU machine name and TARGET_RISCVx

Agree ??

Regards,
Anup

> +
>  static uint64_t kernel_translate(void *opaque, uint64_t addr)
>  {
>      MachineState *machine = opaque;
> @@ -47,6 +54,27 @@ static uint64_t kernel_translate(void *opaque, uint64_t addr)
>      }
>  }
>
> +void riscv_find_and_load_firmware(MachineState *machine)
> +{
> +    char *firmware_filename;
> +
> +    if (!machine->firmware) {
> +        /* The user didn't specify a firmware, default to OpenSBI */
> +        firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BIOS_FILENAME);
> +    } else {
> +        firmware_filename = machine->firmware;
> +    }
> +
> +    if (strcmp(firmware_filename, "none")) {
> +        /* If not "none" load the firmware */
> +        riscv_load_firmware(firmware_filename);
> +    }
> +
> +    if (!machine->firmware) {
> +        g_free(firmware_filename);
> +    }
> +}
> +
>  target_ulong riscv_load_firmware(const char *firmware_filename)
>  {
>      uint64_t firmware_entry, firmware_start, firmware_end;
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 03a6c64d04..77666d0f4d 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -266,9 +266,7 @@ static void riscv_sifive_u_init(MachineState *machine)
>      /* create device tree */
>      create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>
> -    if (machine->firmware) {
> -        riscv_load_firmware(machine->firmware);
> -    }
> +    riscv_find_and_load_firmware(machine);
>
>      if (machine->kernel_filename) {
>          riscv_load_kernel(machine, machine->kernel_filename);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d3670b5a7c..2a7e850666 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -380,9 +380,7 @@ static void riscv_virt_board_init(MachineState *machine)
>      memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>                                  mask_rom);
>
> -    if (machine->firmware) {
> -        riscv_load_firmware(machine->firmware);
> -    }
> +    riscv_find_and_load_firmware(machine);
>
>      if (machine->kernel_filename) {
>          uint64_t kernel_entry = riscv_load_kernel(machine,
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 6f586939c7..df2e2480e6 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -20,6 +20,7 @@
>  #ifndef RISCV_BOOT_H
>  #define RISCV_BOOT_H
>
> +void riscv_find_and_load_firmware(MachineState *machine);
>  target_ulong riscv_load_firmware(const char *firmware_filename);
>  target_ulong riscv_load_kernel(MachineState *machine,
>                                 const char *kernel_filename);
> --
> 2.22.0
>
>

