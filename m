Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDF8C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6C422305
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nZ2GP2LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6C422305
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHsN-00043J-6B
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50347)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHru-0003KF-LS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHrt-00051H-9S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:04:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hvHrs-00050m-N3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:04:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id x21so8108962otq.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JSywJq/uk7DlIuNSp1YJQO69w6sCtKmOtpr9rDm7AC0=;
 b=nZ2GP2LY/qLcc5Z2Hf7UEM1NBnaEhweuBZxae8J3l6IverIp17mJCm0i+NNc/9N1P0
 0GhvkEiiFW2xKxqwBIYmgfb6jT1od5h2sYGBZt/PNaUlW6PN7QlE4e92KrasvCeHL69R
 neO6IAhZTL2XQOVEShHkRbPSf/ykI72fuDC/jRq3HJaRhbpELI1bFtfxfVmY1cEjzplO
 jrHBzxKR4BEuVyiaj/DIyaS/3lyBIaIU8BKbw7OmWIKkey+rDDZ/VFFyptvlZ/M+fsCX
 uk5LGqxWdwFHmbw1iqE990O89CBgL89XeuG2T59GpUEr6IYhq/8su6/LKj6OSSLzVT2K
 UrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JSywJq/uk7DlIuNSp1YJQO69w6sCtKmOtpr9rDm7AC0=;
 b=o7emwbVcwEXo2G7PIllcUc7XmN1kkfuASWDJNTB9c2uw7xVCn6QjeLaG6cyr90Nox7
 4WinPhc0pEVqNz6fagVbtgujNVLy1SX0f0T4kLh3Fp2YD7vF1cyb3FF1E+B1uHRbnpd9
 q0Eac19t9GC+mzKK2p+aJ6/caTfVPaWtI1QcQ5zVDOvtz4JlDHeWMt2525gZM/o8m37D
 8eQ6l8L/cssVnKxcKbyikdvRa4CjFgmz8B1MTrzMJQKR3CdoaTYd0KYGNEhrGDkKRrjr
 DXsYt3T0Hep7O/Za/XD5bW4ukUtHBrOIxrChqG6XgdKJBgGTSNrrdXBNgH7HkWSVU1WM
 pxoQ==
X-Gm-Message-State: APjAAAV/N1gMsMziFkE1ZcrTxK50tU1ST3mN6rkluZLwa6R9xEtUOdSO
 3quKUr1bd08Ys9dTJUweMkxMCzjpYz4kIrOmYjumIA==
X-Google-Smtp-Source: APXvYqwNpwUQ+BrgxmmnHHP+/T46SS3huN19+qpIMEGzPi703fSKP87jd4qgzOn419nqxckuVtkGsqnQwCopi+f2s64=
X-Received: by 2002:a6b:d008:: with SMTP id x8mr7735405ioa.129.1565168663924; 
 Wed, 07 Aug 2019 02:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-25-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565163924-18621-25-git-send-email-bmeng.cn@gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 7 Aug 2019 17:04:12 +0800
Message-ID: <CAEiOBXU5La=+Q6ZQ+BQZEjVkE1Ga=-m3_B0EJbRVwCrgSobRBw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 24/28] riscv: sifive_u: Support loading
 initramfs
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 3:56 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> The loading of initramfs is currently not supported on 'sifive_u'.
> Add the support to make '-initrd' command line parameter useful.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
> Changes in v2: None
>
>  hw/riscv/sifive_u.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ce6eba5..30e6c43 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -328,7 +328,18 @@ static void riscv_sifive_u_init(MachineState *machine)
>                                   memmap[SIFIVE_U_DRAM].base);
>
>      if (machine->kernel_filename) {
> -        riscv_load_kernel(machine->kernel_filename);
> +        uint64_t kernel_entry =
> riscv_load_kernel(machine->kernel_filename);
> +
> +        if (machine->initrd_filename) {
> +            hwaddr start;
> +            hwaddr end = riscv_load_initrd(machine->initrd_filename,
> +                                           machine->ram_size,
> kernel_entry,
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
> 2.7.4
>
>
>
virt also does the same thing.

Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
