Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1FCC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89126208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwnq9VSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89126208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUaoi-0002ko-L1
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 14:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jUao3-0001xl-2h
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jUao2-0006fb-JH
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:54:38 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jUao0-0006bU-R5; Fri, 01 May 2020 14:54:36 -0400
Received: by mail-io1-xd41.google.com with SMTP id j8so1543025iog.13;
 Fri, 01 May 2020 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0w3nKjunJ8GNKXy2bQC0CWSvuliH+rFVMaO14uxFNps=;
 b=iwnq9VShZ4qf9W4oUXMnfh9qYvCsQaXiPiQwS/cV8SmW3Sg41065bKClUQgFLA8phf
 icqNTY9FwhzniGBOcBqt4PQc2zKQMfqZjlRz4rgoMuV5z41eSZkrgxeFIz9LVOzPuL6I
 Ztin1BhwQW3P4LWPWq0ZXwomRbCcWbNnwoCdXag0Z/0sBcMdsjSQdGBExplHC/6yGwjd
 cSd7dcnCCOHYLSo+W27A6ki6ljATb3hiJn/fmqtz4dKQbeBbiVQkx4aF3zy4yvfmvmym
 aYDvxsPGRUIfLC4Ris/RbAp6LvoitDTLzg8XSVftdK5bGWETHivNZi9zKYc0EMrezeal
 K95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0w3nKjunJ8GNKXy2bQC0CWSvuliH+rFVMaO14uxFNps=;
 b=ojVsmsClRx6FH+bzWLpQ3Mn3M5dRNhGTQHraoAFDt4/koOZ0IwBrBTwPdsHq0gotR5
 cD5sx4xw5h+zptEj5IdqCaCNx1dBDxR8VkYUuEBBQ0KIS++GXIE5qBpwzmIFljuv7q/N
 qioUpXmEQprBGtUfEL8qYFR0sKqSESi3crqQ6ENL/i5xt+w1+VlJ7jtVm/pSCVzpYIxV
 OcvhfnzA8/yWGUL5dWt5zcT4itVxrm0y/+jgVr6kfITTaLS9UJ6Yyf115lqr/MCzN6/T
 gjuvThiM2J320tpoILtpEDNYC9fTt3BruRrbSBcXLHsrsVV9N1KHA8z6CTu+kdC0c7aQ
 2K/w==
X-Gm-Message-State: AGi0PuZ5AJOSB3HsuzR65amJE/w+1hvre027PWAc8dEWBFItpBetvsqi
 YnASXesBg6en5I1HFmwURIqdk8/mMJZEML20s0Y=
X-Google-Smtp-Source: APiQypJq2m+gWv5W9KBQKU+erYQ3BJbTIP3T+CnPq0kj+Q90x9ekUUaWB0yaeRnMzQfxvV8NDLVEdI8l9+1tPzmYm74=
X-Received: by 2002:a5e:c318:: with SMTP id a24mr5058192iok.166.1588359274501; 
 Fri, 01 May 2020 11:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2LfTQZnor5haAgBg=h34qv50xf8Bs1bgSeGESfr-E2ng@mail.gmail.com>
 <CAKmqyKNMiD6VJ1D-ty-q_HMyiZ7oj7F0XraKTaYy78-xjhAN4A@mail.gmail.com>
 <CAKmqyKO=edmrotcVa_tMO-VcTpdWEq7=0=EYiQquVhqwkS2F=g@mail.gmail.com>
In-Reply-To: <CAKmqyKO=edmrotcVa_tMO-VcTpdWEq7=0=EYiQquVhqwkS2F=g@mail.gmail.com>
From: Jose Martins <josemartins90@gmail.com>
Date: Fri, 1 May 2020 19:54:23 +0100
Message-ID: <CAC41xo1uOy4XVtZqfjAohNHJUfNfDcMKaxGv7dD5uDediQjxiw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix check of guest pa top bits
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=josemartins90@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just resubmitted version 2. Sorry. Not really used to this. I actually
wasn't using git send-email. I was copying the patch to my email
client which was causing the weird wrapping. I think I also fixed the
issues raised by checkpatch. Hope everything is correct now.

Jose

On Thu, 30 Apr 2020 at 22:36, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Apr 30, 2020 at 12:45 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Fri, Apr 24, 2020 at 8:10 AM Jose Martins <josemartins90@gmail.com> wrote:
> > >
> > > The spec states that on sv39x4 guest physical  "address bits 63:41
> > > must all be zeros, or else a guest-page-fault exception occurs.".
> > > However, the check performed for these top bits of the virtual address
> > > on the second stage is the same as the one performed for virtual
> > > addresses on the first stage except with the 2-bit extension,
> > > effectively creating the same kind of "hole" in the guest's physical
> > > address space. I believe the following patch fixes this issue:
> > >
> > > Signed-off-by: Jose Martins <josemartins90@gmail.com>
> >
> > Thanks for the patch.
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > > ---
> > >  target/riscv/cpu_helper.c | 20 +++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > index d3ba9efb02..da879f5656 100644
> > > --- a/target/riscv/cpu_helper.c
> > > +++ b/target/riscv/cpu_helper.c
> > > @@ -421,15 +421,21 @@ static int get_physical_address(CPURISCVState
> > > *env, hwaddr *physical,
> >
> > There seems to be a strange wrapping here, that corrupts the patch.
> > For future patches can you please check your git send-email setup?
> >
> > Applied to the RISC-V tree with the above line fixed up.
>
> This patch also fails checkpatch.
>
> Do you mind resending a v2 with the check patch issues fixed?
>
> Alistair
>
> >
> > Alistair
> >
> > >      int va_bits = PGSHIFT + levels * ptidxbits + widened;
> > >      target_ulong mask, masked_msbs;
> > >
> > > -    if (TARGET_LONG_BITS > (va_bits - 1)) {
> > > -        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> > > +    if(!first_stage){
> > > +        if ((addr >> va_bits) != 0) {
> > > +            return TRANSLATE_FAIL;
> > > +        }
> > >      } else {
> > > -        mask = 0;
> > > -    }
> > > -    masked_msbs = (addr >> (va_bits - 1)) & mask;
> > > +        if (TARGET_LONG_BITS > (va_bits - 1)) {
> > > +            mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> > > +        } else {
> > > +            mask = 0;
> > > +        }
> > > +        masked_msbs = (addr >> (va_bits - 1)) & mask;
> > >
> > > -    if (masked_msbs != 0 && masked_msbs != mask) {
> > > -        return TRANSLATE_FAIL;
> > > +        if (masked_msbs != 0 && masked_msbs != mask) {
> > > +            return TRANSLATE_FAIL;
> > > +        }
> > >      }
> > >
> > >      int ptshift = (levels - 1) * ptidxbits;
> > > --
> > > 2.17.1
> > >
> > > Jose
> > >

