Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF62C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 21:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F18E214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 21:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZEdBg9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F18E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdhnk-0007WM-N1
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 17:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47837)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdhlO-0006AD-5B
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 17:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdhlJ-00050e-8l
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 17:05:01 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdhlI-0004VF-Vc; Wed, 19 Jun 2019 17:04:57 -0400
Received: by mail-lj1-x242.google.com with SMTP id 131so585794ljf.4;
 Wed, 19 Jun 2019 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zVaF0JjBdEd/4wIOWuHmkCNVxJRgNVPs1CRVDceolEU=;
 b=WZEdBg9A8A8XBhIMFfru8hmtsn2zIfdTTkXCuxqy/3HIhY/gIYSc1vpyUqI1nbEkBU
 3O6EDmWDFPQ8dEP4pPN9w0ZOJ5Tuu2N1NiM2/7Sj521cMLgxr+51kSAAThcR+lzfC4ER
 8YjxQy7xBz9Cvc/k5INyRRiTo5478EYM4Qn82M5n3U/R8tco4mtNr+qACRTORQjlGX79
 nRw33XLPjEDdm1CjVFTdvgTzPrJ38GXn0poTE/8bHV7l4fZFHqa9mSdmIXkqDL55z8xt
 JQ6FYfmNbdTTctJnTaR0EUu1mqkLnlDSulWQzOAdVG8TAgYXeaHdNtPl5cC5/KWBg71D
 WM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zVaF0JjBdEd/4wIOWuHmkCNVxJRgNVPs1CRVDceolEU=;
 b=oJ3Md87+7MRzbWn0RnmMEtMaaGDsuWuvqc9LNZGO9qlZcdIHqjitX2IdqwZqGhxxnd
 esqx3cdIkMyIFhE6K18oPbKxOMJ5cL7or22P5TH3+PW17LFbVLV2z3fVhBHjdBN0SqF1
 izlOH40zyi7V54m2Cnw+PALD3njHNIcWxky4+n8MY32U1ZefUQ1l65AfX3p6RNZGDiWs
 FzHA0P+bs3moGaH3/FO7NPy8vr28536aOSPsxkM/c7iUkf/L/rP9IVRfffsWjzawIU7J
 wfP0nxaC12ro2aQgmOoVllk+BHnBE/YsVSNO+HzshTQkFF8JmNOodqp8J2vs/JpprqmE
 a+PA==
X-Gm-Message-State: APjAAAXLQVM7bcwlxsuTlOJhqDZiuupFDrpgxX1RlRMzmX7N3hHUKCXf
 1ZMu8BHxXi/kxecdeRy4IdlR28nloi4OOAzc/34=
X-Google-Smtp-Source: APXvYqxRzG6BY/Y1uS2SBEBulhPxggOSZmwrTXHVrjQUKgFiG+CR/lrjpp/VnV0GB04MUFNHTISjiKpdrbKaH4Hv1Gc=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr42489324ljg.119.1560978270958; 
 Wed, 19 Jun 2019 14:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <99fc8fe28f2a0493f248d50d32d4b1bc649536ab.1560904640.git.alistair.francis@wdc.com>
 <CAEUhbmXKv7-r3KyDGnq8ysmyccy1tVgBDqwLcf46U96BZOiKYw@mail.gmail.com>
In-Reply-To: <CAEUhbmXKv7-r3KyDGnq8ysmyccy1tVgBDqwLcf46U96BZOiKYw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Jun 2019 14:01:41 -0700
Message-ID: <CAKmqyKMqWcx4-EhTrtLMdfLtid742=8exDNSQHmuxPf_7tHkaw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [RFC v1 3/5] hw/riscv: Extend the kernel loading
 support
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 8:16 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 8:56 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Extend the RISC-V kernel loader to support uImage and Image files.
> > A Linux kernel can now be booted with:
> >
> >     qemu-system-riscv64 -machine virt -bios fw_jump.elf -kernel Image
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/boot.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 392ca0cb2e..7f68035a3f 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -67,13 +67,22 @@ target_ulong riscv_load_kernel(MachineState *machine,
> >      uint64_t kernel_entry, kernel_high;
> >
> >      if (load_elf(kernel_filename, NULL, kernel_translate, machine,
> > -                 &kernel_entry, NULL, &kernel_high,
> > -                 0, EM_RISCV, 1, 0) < 0) {
> > -        error_report("could not load kernel '%s'", kernel_filename);
> > -        exit(1);
> > +                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) > 0) {
> > +        return kernel_entry;
> > +    }
> > +
> > +    if (load_uimage_as(kernel_filename, &kernel_entry, NULL, NULL,
> > +                       kernel_translate, machine, NULL) > 0) {
>
> We should not set the 'kernel_translate' here for uImage.
>
> In fact, the whole kernel_translate() is not necessary.

I have removed the kernel_translate() function. I tested loading
uImage files though and they don't seem to work as the image is loaded
at the wrong address.

I have removed uImage loading support from this series. We can look at
it in the future if we decide we want it.

Alistair

>
> > +        return kernel_entry;
> > +    }
> > +
>
> Regards,
> Bin

