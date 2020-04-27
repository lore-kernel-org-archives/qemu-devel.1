Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3915C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9392054F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7saWXKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9392054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5TE-0002HO-Al
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jT5SI-00007I-7r
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jT5SH-0003zT-Pr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:13:58 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jT5S1-0003ta-1A; Mon, 27 Apr 2020 11:13:41 -0400
Received: by mail-io1-xd44.google.com with SMTP id z2so19176882iol.11;
 Mon, 27 Apr 2020 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ks28PCq+pj3aTSqXSj9GkkzewaCh4tm20nhQOcmABg=;
 b=G7saWXKk+OLzsIbdWpKcOYf08JHgh4UTpaQIqklo2HHZ0HkpFVOKKx15EFNUip6jpP
 rcMVeSHlJpmzUNZaglQlB2eLde08KWrVoJNSxR91yd3EfgrupusGihgoY8RsyoKSwVVo
 VBqWQTIFElhSd9Wd3rzFMT/Gxz/AuAnKf2C9pMMZltmvQ0pLlLwYoHAwF2w1f8SIBv6y
 0OvW8X9CrnFWuTQvQh1/DAOHsBAO/PbPF6AFA25yY+URIODRxW0+2u5TCPKUfS6imK2Q
 UtEZDG+TryB1wnYymCBJaYAn/0Io0dXpv2eKA12bd1oJyKlRefKSTInjx/lvWR82MMpT
 9Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ks28PCq+pj3aTSqXSj9GkkzewaCh4tm20nhQOcmABg=;
 b=P4PE56QUoj/+b+RCiwV5LTZNaA80K7NsHpSjSKHQNxwTLgM8f/qtRpG+wg5+YmMwpa
 5wjZiErSaAY4CmOG2/EUpvwqa+mTBfcm5eF3R62boipBG1eWMasNiXqTuKrosgCpFlsb
 BVQoUuxenefnQEPw35OlmhTUPPZk7eMKxyjQtRznufhnFCDG2+Ixunon3fe8+kdciSeX
 Gu3W9qZNrdfJWU1xIg0E1UXaLAbTZsyRhJEXCxZX36cKIgftrcOeJtIrGDNb3xb4H43l
 Nx0pBfJURPheO/0rb0bnNUooLALfJZHRkzUVfnZLa90214EEElnLaMimHOmhwvHjFwAi
 JaAg==
X-Gm-Message-State: AGi0PuYCu7vHs7oyMtBjBz0sSyiBK4CXGYRA8FuDOHD+OMPj+FkST3gH
 yjaffuZtLzPSCRK8095sM7SBkofB2u1zSmq0NzY=
X-Google-Smtp-Source: APiQypJp1q4vcQ4D3WtNoSiy8uTqy5yh/OTcUkNJ17virB+xLE2KTBW3ubN0At68gB8zHlIQlNZlMMTxmJXQWg+EZiU=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr21520109ioj.42.1588000419440; 
 Mon, 27 Apr 2020 08:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200427080644.168461-1-anup.patel@wdc.com>
 <20200427080644.168461-2-anup.patel@wdc.com>
In-Reply-To: <20200427080644.168461-2-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 08:05:01 -0700
Message-ID: <CAKmqyKO41tE=dw7EVdJtdX_zkB-ymRRPTmgxNO_1iFv71LCDEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/riscv: Add optional symbol callback ptr to
 riscv_load_firmware()
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d44
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

On Mon, Apr 27, 2020 at 1:09 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> This patch adds an optional function pointer, "sym_cb", to
> riscv_load_firmware() which provides the possibility to access
> the symbol table during kernel loading.
>
> The pointer is ignored, if supplied with flat (non-elf) firmware image.
>
> The Spike board requires it locate the HTIF symbols from firmware ELF
> passed via "-bios" option.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c         | 13 ++++++++-----
>  hw/riscv/sifive_u.c     |  2 +-
>  hw/riscv/virt.c         |  2 +-
>  include/hw/riscv/boot.h |  6 ++++--
>  4 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index b8e765277d..726300a171 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -36,7 +36,8 @@
>
>  void riscv_find_and_load_firmware(MachineState *machine,
>                                    const char *default_machine_firmware,
> -                                  hwaddr firmware_load_addr)
> +                                  hwaddr firmware_load_addr,
> +                                  symbol_fn_t sym_cb)
>  {
>      char *firmware_filename = NULL;
>
> @@ -76,7 +77,7 @@ void riscv_find_and_load_firmware(MachineState *machine,
>
>      if (firmware_filename) {
>          /* If not "none" load the firmware */
> -        riscv_load_firmware(firmware_filename, firmware_load_addr);
> +        riscv_load_firmware(firmware_filename, firmware_load_addr, sym_cb);
>          g_free(firmware_filename);
>      }
>  }
> @@ -96,12 +97,14 @@ char *riscv_find_firmware(const char *firmware_filename)
>  }
>
>  target_ulong riscv_load_firmware(const char *firmware_filename,
> -                                 hwaddr firmware_load_addr)
> +                                 hwaddr firmware_load_addr,
> +                                 symbol_fn_t sym_cb)
>  {
>      uint64_t firmware_entry, firmware_start, firmware_end;
>
> -    if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry,
> -                 &firmware_start, &firmware_end, NULL, 0, EM_RISCV, 1, 0) > 0) {
> +    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
> +                         &firmware_entry, &firmware_start, &firmware_end, NULL,
> +                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>          return firmware_entry;
>      }
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 56351c4faa..54bb9eb1bf 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -345,7 +345,7 @@ static void riscv_sifive_u_init(MachineState *machine)
>      create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> -                                 memmap[SIFIVE_U_DRAM].base);
> +                                 memmap[SIFIVE_U_DRAM].base, NULL);
>
>      if (machine->kernel_filename) {
>          uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 85ec9e22aa..24f851e895 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -507,7 +507,7 @@ static void riscv_virt_board_init(MachineState *machine)
>                                  mask_rom);
>
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> -                                 memmap[VIRT_DRAM].base);
> +                                 memmap[VIRT_DRAM].base, NULL);
>
>      if (machine->kernel_filename) {
>          uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index df80051fbc..474a940ad5 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -24,10 +24,12 @@
>
>  void riscv_find_and_load_firmware(MachineState *machine,
>                                    const char *default_machine_firmware,
> -                                  hwaddr firmware_load_addr);
> +                                  hwaddr firmware_load_addr,
> +                                  symbol_fn_t sym_cb);
>  char *riscv_find_firmware(const char *firmware_filename);
>  target_ulong riscv_load_firmware(const char *firmware_filename,
> -                                 hwaddr firmware_load_addr);
> +                                 hwaddr firmware_load_addr,
> +                                 symbol_fn_t sym_cb);
>  target_ulong riscv_load_kernel(const char *kernel_filename,
>                                 symbol_fn_t sym_cb);
>  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> --
> 2.25.1
>
>

