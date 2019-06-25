Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F06C48BD3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5159F2083D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki67G67N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5159F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfZDn-0004ks-Vb
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 20:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59309)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZCe-0004M8-32
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZCc-00081n-BH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:20:52 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hfZCc-0007xr-2H
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:20:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so15450683otq.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 17:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=/W6AV2imFZqc2JmrNTx2Qp01LOJ2Wywf3ogSnVzwQ7E=;
 b=ki67G67Nh77pNwJlyJKrXIh54qaheNXFzFkH1VqPm7r+OK/iN6ZWcnz4toF+OQTr9C
 k3jqGxQXL0RfehQDLWvx/Qx6YljEiY/j/DrFFvu8n6f83LJUSE3mF7YmeJ3k9M0TfvmQ
 pVdI04btqgaCjezbrCTJ2LUR/9vRPbisYlCjgAZnZJZner+oSXHwX4s3DwcM8q8nXYOj
 Oy10I05T7nJxz/Sc47O4ua+l7j1gXXUtQPLRpuG4RdeD+i/joiAfqupfCsPAqUmjbaGf
 7KaccMIiTOhOXnyhhW7Ic9z+LnF3+onkF1Mc3HwgJfPGhWEO+M+wB4V5DpQUHMIGSR+4
 A2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=/W6AV2imFZqc2JmrNTx2Qp01LOJ2Wywf3ogSnVzwQ7E=;
 b=MUwPZyzCvYejdrX7FP83vwcnkEecJcfOBXAovBsPjxHJlxxhoskYPJQyPSOpL5etHw
 B52vdwYfYVd/1kQbrzL+L9tlaIrzWDPUtxai/q5dPLyzCJYyhFngO2y8lcvtt8oVSatZ
 DqW0DUPiu3TzGYgJLiQFddnIIXUxk7doeX6q6Pgau3vUEd/nOdnh2W5go31i9H1RMtHo
 Bj88G4JP0S518gEQb1shLxjBMVI0BuU3Z+LoojMPyAx+QykmGFOUfvQUFmENjSbRv90y
 sn1reKXDJ7Z0uCXwMFuYRpdFfdzJqWcfhRbjupHDyLMqrWW4It1f7ljCtcy/5KuWCAIy
 s8WQ==
X-Gm-Message-State: APjAAAVG8lMTcyqrwmhKe4T1DbR8vjPUH90TN3Aqnq8ZZhHDuaZLEBCe
 JSyMETB75eKD08vxfMy3kT5BtlvOGMT23aCsCWM=
X-Google-Smtp-Source: APXvYqyxnqstSue7UViDm1pyRupyb0A2aR/VK0X96WXLuS8j7TxPcfdy5OkGFIXyFAdrgp7EEuHQ0tw0xn5gYwv/3N0=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr22943394otq.306.1561422046967; 
 Mon, 24 Jun 2019 17:20:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:20:46
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:20:46
 -0700 (PDT)
In-Reply-To: <20190624222844.26584-2-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-2-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 25 Jun 2019 02:20:46 +0200
Message-ID: <CAL1e-=j+VjzC62pQ0B3+Yb=Yd4kAhe1haGKtyQGbmQPFoavcxg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 01/10] hw/mips/gt64xxx_pci: Fix multiline
 comment syntax
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 25, 2019 12:36 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> Since commit 8c06fbdf36b checkpatch.pl enforce a new multiline
> comment syntax. Since we'll move this code around, fix its style
> first.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Yes, I find that this a very good practice (this makes make the file moving
in one of subsequent patches pure moving, which is important for future
=E2=80=9Cgit blames=E2=80=9D and similar commands).

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  hw/mips/gt64xxx_pci.c | 64 +++++++++++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 29 deletions(-)
>
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index f707e59c7a..c0924646b5 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -248,10 +248,11 @@ typedef struct GT64120State {
>  } GT64120State;
>
>  /* Adjust range to avoid touching space which isn't mappable via PCI */
> -/* XXX: Hardcoded values for Malta: 0x1e000000 - 0x1f100000
> -                                    0x1fc00000 - 0x1fd00000  */
> -static void check_reserved_space (hwaddr *start,
> -                                  hwaddr *length)
> +/*
> + * XXX: Hardcoded values for Malta: 0x1e000000 - 0x1f100000
> + *                                  0x1fc00000 - 0x1fd00000
> + */
> +static void check_reserved_space(hwaddr *start, hwaddr *length)
>  {
>      hwaddr begin =3D *start;
>      hwaddr end =3D *start + *length;
> @@ -650,8 +651,10 @@ static void gt64120_writel (void *opaque, hwaddr
addr,
>      case GT_SDRAM_B1:
>      case GT_SDRAM_B2:
>      case GT_SDRAM_B3:
> -        /* We don't simulate electrical parameters of the SDRAM.
> -           Accept, but ignore the values. */
> +        /*
> +         * We don't simulate electrical parameters of the SDRAM.
> +         * Accept, but ignore the values.
> +         */
>          s->regs[saddr] =3D val;
>          break;
>
> @@ -674,8 +677,10 @@ static uint64_t gt64120_readl (void *opaque,
>
>      /* CPU Configuration */
>      case GT_MULTI:
> -        /* Only one GT64xxx is present on the CPU bus, return
> -           the initial value */
> +        /*
> +         * Only one GT64xxx is present on the CPU bus, return
> +         * the initial value.
> +         */
>          val =3D s->regs[saddr];
>          break;
>
> @@ -685,17 +690,18 @@ static uint64_t gt64120_readl (void *opaque,
>      case GT_CPUERR_DATALO:
>      case GT_CPUERR_DATAHI:
>      case GT_CPUERR_PARITY:
> -        /* Emulated memory has no error, always return the initial
> -           values */
> +        /* Emulated memory has no error, always return the initial
values. */
>          val =3D s->regs[saddr];
>          break;
>
>      /* CPU Sync Barrier */
>      case GT_PCI0SYNC:
>      case GT_PCI1SYNC:
> -        /* Reading those register should empty all FIFO on the PCI
> -           bus, which are not emulated. The return value should be
> -           a random value that should be ignored. */
> +        /*
> +         * Reading those register should empty all FIFO on the PCI
> +         * bus, which are not emulated. The return value should be
> +         * a random value that should be ignored.
> +         */
>          val =3D 0xc000ffee;
>          break;
>
> @@ -705,8 +711,7 @@ static uint64_t gt64120_readl (void *opaque,
>      case GT_ECC_MEM:
>      case GT_ECC_CALC:
>      case GT_ECC_ERRADDR:
> -        /* Emulated memory has no error, always return the initial
> -           values */
> +        /* Emulated memory has no error, always return the initial
values. */
>          val =3D s->regs[saddr];
>          break;
>
> @@ -785,8 +790,10 @@ static uint64_t gt64120_readl (void *opaque,
>      case GT_SDRAM_B1:
>      case GT_SDRAM_B2:
>      case GT_SDRAM_B3:
> -        /* We don't simulate electrical parameters of the SDRAM.
> -           Just return the last written value. */
> +        /*
> +         * We don't simulate electrical parameters of the SDRAM.
> +         * Just return the last written value.
> +         */
>          val =3D s->regs[saddr];
>          break;
>
> @@ -949,20 +956,20 @@ static int gt64120_pci_map_irq(PCIDevice *pci_dev,
int irq_num)
>      slot =3D (pci_dev->devfn >> 3);
>
>      switch (slot) {
> -      /* PIIX4 USB */
> -      case 10:
> +    /* PIIX4 USB */
> +    case 10:
>          return 3;
> -      /* AMD 79C973 Ethernet */
> -      case 11:
> +    /* AMD 79C973 Ethernet */
> +    case 11:
>          return 1;
> -      /* Crystal 4281 Sound */
> -      case 12:
> +    /* Crystal 4281 Sound */
> +    case 12:
>          return 2;
> -      /* PCI slot 1 to 4 */
> -      case 18 ... 21:
> +    /* PCI slot 1 to 4 */
> +    case 18 ... 21:
>          return ((slot - 18) + irq_num) & 0x03;
> -      /* Unknown device, don't do any translation */
> -      default:
> +    /* Unknown device, don't do any translation */
> +    default:
>          return irq_num;
>      }
>  }
> @@ -980,8 +987,7 @@ static void gt64120_pci_set_irq(void *opaque, int
irq_num, int level)
>      /* XXX: optimize */
>      pic_irq =3D piix4_dev->config[0x60 + irq_num];
>      if (pic_irq < 16) {
> -        /* The pic level is the logical OR of all the PCI irqs mapped
> -           to it */
> +        /* The pic level is the logical OR of all the PCI irqs mapped to
it. */
>          pic_level =3D 0;
>          for (i =3D 0; i < 4; i++) {
>              if (pic_irq =3D=3D piix4_dev->config[0x60 + i])
> --
> 2.19.1
>
>
