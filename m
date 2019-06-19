Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77300C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9CD21881
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBZzIIJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9CD21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcNv-00079N-GB
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdcM6-0005fh-AD
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdcM5-0006Pc-4z
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:18:34 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hdcLu-0006Be-SA; Wed, 19 Jun 2019 11:18:24 -0400
Received: by mail-ed1-x544.google.com with SMTP id m10so27773611edv.6;
 Wed, 19 Jun 2019 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7U8x15Ygol6ToivrArynOYp6txXvxaeGK2YxgLl1UGM=;
 b=RBZzIIJLHxR3QRg2He2ht8kioDjZcw4E96Gf0zEYayXwIHgHWo8GWlLygqHWhAUglU
 qcgM2/nKNprbF7s3ANOOj068R7l8DzPHGGG5zReaI3GqvbeZXdyp01FhJ+AgSOguSzKf
 0o1346JTsNKu9UxzkKZc4pQSgnl+UZ5yRKbFsMCrtKsnW95JKsXbDx76GSxpp935Yyq+
 BQ8EJ4B3RDLaTVSXXCDcsiWcH7bg0pSfeQ9k0DD4/13IgR3QoJTkMULqZXZVSCsYmXvW
 fVnJ3qBhTanIhfNFXhF+bTJlVODaf+Y8WQ9xB5zTUlW3KLfywwGK6CZj1jAM7LKe+d43
 aW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7U8x15Ygol6ToivrArynOYp6txXvxaeGK2YxgLl1UGM=;
 b=ZulNYlGGVQK3KZk1pcRVFiVPJnVQlIZhfLP026/lZ5qklU4vSM1B0JEyIKOnhFftw1
 JvxwxXrCqjwuD73R/AgMyGGLSDlu5+LXO39vJ4tov0NmZaDT60f+1lSY0I7et/H6pNar
 zRUeiekPwVwn8d4t8HWM5WCJKcniVtJdR1MfbO0bvdeMjVQDh3uTE0OvVDx/rU0ZplZW
 cKC1iC/YuXuh7/ATe8Epg0zNLNrFiBfuZd/S2vnJxhiu/8CKu5fh2zWZDlRFMimcv/fF
 d/9YrOcat2ZmJalcCkX0+6OFx0MWa6VXrL8o/xkpsuvkC+Y3+Ozm5f2dhDMcOYsjn/p+
 b15g==
X-Gm-Message-State: APjAAAUDJ6sqOipNtqG5zyZjyKt/7Tzz60B01oLh5SxYE3I8V7ncfSMR
 mh3Ds9FrdmVQ2PNxCCFgeTyIlS1LcGuVkK3+FK0=
X-Google-Smtp-Source: APXvYqx7ongO0sh29usVxUbFne6vb7//im0Dx97b3A1jUFueAQbvquon2ni+3SnEx6GJdAZLrbxVnLYmA4ORybh6cSc=
X-Received: by 2002:a50:94e6:: with SMTP id t35mr94208723eda.137.1560957496029; 
 Wed, 19 Jun 2019 08:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <2fd2fa66cf561d8041f75351c28ed025828c56ff.1560904640.git.alistair.francis@wdc.com>
 <CAAhSdy12uKV14cdxvUniSLFw_iF5WNKjoLCanS3Bs=33w-c9xA@mail.gmail.com>
In-Reply-To: <CAAhSdy12uKV14cdxvUniSLFw_iF5WNKjoLCanS3Bs=33w-c9xA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 19 Jun 2019 23:18:05 +0800
Message-ID: <CAEUhbmXYfdAojDtNxXz8XYRk0X1jt+qLB6oVP1pFKNcjWjeh5w@mail.gmail.com>
To: Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [Qemu-riscv] [RFC v1 4/5] roms: Add OpenSBI
 version 0.3
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 1:14 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Jun 19, 2019 at 6:24 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  .gitmodules                         |   3 +++
> >  Makefile                            |   3 ++-
> >  configure                           |   1 +
> >  pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
> >  pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes
> >  roms/Makefile                       |  17 +++++++++++++++++
> >  roms/opensbi                        |   1 +
> >  7 files changed, 24 insertions(+), 1 deletion(-)
> >  create mode 100644 pc-bios/opensbi-riscv32-fw_jump.elf
> >  create mode 100644 pc-bios/opensbi-riscv64-fw_jump.elf
> >  create mode 160000 roms/opensbi
> >
>
> The OpenSBI firmwares are platform specific so we should have
> machine directory under pc-bios/ directory
>
> So for virt machine we will have:
> pc-bios/riscv32/virt/fw_jump.elf
> pc-bios/riscv64/virt/fw_jump.elf

And we should only integrate plain binary image for "bios" images here.

pc-bios/riscv32/virt/fw_jump.bin
pc-bios/riscv64/virt/fw_jump.bin

Regards,
Bin

