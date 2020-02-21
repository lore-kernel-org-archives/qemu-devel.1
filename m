Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C3FC35663
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A02020722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgsr4LGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A02020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5EKq-0005uU-HT
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 14:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j5EJf-0005Eq-4J
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j5EJe-0000kO-4y
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:50:27 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j5EJa-0000gx-R7; Fri, 21 Feb 2020 14:50:23 -0500
Received: by mail-lj1-x241.google.com with SMTP id r19so3426868ljg.3;
 Fri, 21 Feb 2020 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e7yQi9nP2asxPUQmGdkA+cRJRSqMHpSgq9NdA1/8I2U=;
 b=Fgsr4LGwRMrmpaP1F+ser+RYZvYpoz/v2TL1PK83soVscdwQgpc7ZAjavJQ9xZQ6WV
 n4EMTYBnyvl5/OJ8y9ubQRmZYdbsRSTa9f7+A2jpSAhZ1WcjGpV4HqxmsPJLtGAkFJMe
 YSjrKCipVHhkmXUHSl3fr/dAq8eqpxfVbhW1CskpzvZ6xqzc8bQHoc7p31e58RJTUHZX
 juMFSnbWDyHQHpJbnqAT4lETJUVdUOz392ae+dUcpO0Nw4R8ZT+Rr5N8BiYYN3qycalK
 NUACztg2bVV0ewNBUrCnx4kIlYryYBMYOA7gYAZ1yCPkVyIDUvitsLwAEsIeN9tRWJln
 Ya9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e7yQi9nP2asxPUQmGdkA+cRJRSqMHpSgq9NdA1/8I2U=;
 b=PA4x5/UY6LlkiOyyQQI75xgn/PM9rZhunV78XZLcm/7XDp/1abLcTCXSISLYNOGXoc
 kkwZdpBUAGvJJuZQOhn5FRMZXtbu+wKO7r0PBqI0rF+A943atS5DRddQLTANHjk9c+GP
 WrQKaPKXx9x20rF1E5lETFpiMWioyQZsKJg1Ib2ZJ6bmrkcbyvmXplt6M3zKgk0z+6pS
 notL9GHusk7pyqfFJcuRtz3JKnM7hFP+OBEmAUYk9Dopm8rECKO4amVHgQVpeIPCXk2X
 3c2hOVIRGDjVSLZpeUhylrlmgE7zDAILPe6+ziwGduxoFEC233rVlEZ31EZumnIIdlO8
 W2Fw==
X-Gm-Message-State: APjAAAXuqHBOWjXmI5cTbB6C+BcQb+RhMGssSMhrGKmVnFSzsjYaKGLd
 3UKz9p+Vv8bocUcVM+Gr1ZROJtGuGO5vy08a7so=
X-Google-Smtp-Source: APXvYqyqVrjDMFjAZFy4oLf3qMpWedXJJCzqK/Ox1RYA0uPhHzpcwzXn6S3qG/djQkXuArw7KlS/L2+IcAbe5/8lLDo=
X-Received: by 2002:a2e:8119:: with SMTP id d25mr23310850ljg.76.1582314621239; 
 Fri, 21 Feb 2020 11:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20200214072127.64330-1-anup.patel@wdc.com>
 <20200214072127.64330-3-anup.patel@wdc.com>
In-Reply-To: <20200214072127.64330-3-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Feb 2020 11:49:54 -0800
Message-ID: <CAKmqyKPAg67F8G7=QmBD6VzZMv-KQFh3HbFT0tjTPufixwfG7Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/riscv/spike: Allow loading firmware separately
 using -bios option
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 11:22 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> This patch extends Spike machine support to allow loading OpenSBI
> firmware (fw_jump.elf) separately using -bios option.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Can you add something in the commit message adding that you also
support adding an initrd with this patch?

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/spike.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 8823681783..060a86f922 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -45,6 +45,12 @@
>
>  #include <libfdt.h>
>
> +#if defined(TARGET_RISCV32)
> +# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
> +#else
> +# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
> +#endif
> +
>  static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
> @@ -183,8 +189,24 @@ static void spike_board_init(MachineState *machine)
>      memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
>                                  mask_rom);
>
> +    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> +                                 memmap[SPIKE_DRAM].base,
> +                                 htif_symbol_callback);
> +
>      if (machine->kernel_filename) {
> -        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
> +        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
> +                                                  htif_symbol_callback);
> +
> +        if (machine->initrd_filename) {
> +            hwaddr start;
> +            hwaddr end = riscv_load_initrd(machine->initrd_filename,
> +                                           machine->ram_size, kernel_entry,
> +                                           &start);
> +            qemu_fdt_setprop_cell(s->fdt, "/chosen",
> +                                  "linux,initrd-start", start);
> +            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
> +                                  end);
> +        }
>      }
>
>      /* reset vector */
> --
> 2.17.1
>
>

