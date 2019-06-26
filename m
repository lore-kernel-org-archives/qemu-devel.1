Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE927C48BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CB7208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBp0SL8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CB7208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfx7S-0002Wb-SA
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 21:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfx2L-0006Dq-C7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfx2K-0003Xu-8F
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:47:49 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hfx2H-0003Ql-NC; Tue, 25 Jun 2019 21:47:45 -0400
Received: by mail-ed1-x544.google.com with SMTP id k21so795124edq.3;
 Tue, 25 Jun 2019 18:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aijH6h8Z+aHSNtZKIGH50atEy0CtUTuJRTMmgt215Rc=;
 b=JBp0SL8VU0hVJlwLg22CgU/qyaDPrOJ4QEOorwO+vOJoqdUvZ3gvxGtsRHzw1VfB5r
 SJLidp5fN7k5v0IUOX0bBdDdHp97VAjDrumff2v03jKUFVl5HrpzxTqVVLXh5YS+eIey
 q0ubuCJDb2u1hMw00g72qIGs84KGFG6PsNtvBUHW3FfG5koIddLW4bkcDaOXtN29qTmV
 PVnSCdMPnSgtSNZu8bNAj4ouF0RdvuJvHAFYn5etQE/Enb/5+GbULA8VjQ23LCia8SoN
 +B8D2vacyLI4FEFIFpIAZKfAlnouZmC4eXSfRmyho9ZQB2kxOm3xVa4WV5a9RhncSwZA
 5XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aijH6h8Z+aHSNtZKIGH50atEy0CtUTuJRTMmgt215Rc=;
 b=h7f6WaZCpcfzJ3Xg+EQVPZVF1cIw1ma/mEmiUwFvQIvN0R4a0gp03ycqshsleJx5av
 h5q4YY3JSz2UdqSBiSAVMKgKtZcr2pKO6qLdXbYnTWN3FR2Z+FN5b3ugKBoKQx4HDde1
 v+wUwPtOtiuDtWEOEh0RUek7ev9Fv5lVzV+nocy0XdYoxH5fwpq6i0smKLYSsUfAijHD
 EuXiPfCvKiXi6JWKJpXEyWRrPOdWqhaL48WyStJ+6jFmf3Q/enMrmtPvm8MQsrrklGNM
 uCDrRRjPz9Hz5bZ+ZytCZQKWUs1aQGTa9PnTNrNmE9h+6k+dx4GeiqkHZ4XPjtsPpvY2
 Ej+w==
X-Gm-Message-State: APjAAAVJeWh3mkNBgDASbic05NVbFecJNEOwqQlrqhuJrLFzFld0zGZe
 G7VpQN7Wxsa6f7hPyioTyiSx4slclos5tRhM2cwlyo3Q
X-Google-Smtp-Source: APXvYqznkXPKAe3NnJTOjzzHsdOEUKvhSX2HpycfBdPckCav71KZVHnTXkSb1vDse76SbWpIPQrbe+9C4F76uO9ZPJo=
X-Received: by 2002:a50:b388:: with SMTP id s8mr1795255edd.15.1561513664653;
 Tue, 25 Jun 2019 18:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <1559119921-6098-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKNAL8KtVgfCx6yhaNYEL=_wnZ5Vf1eSjxwtg0x6_q+UHw@mail.gmail.com>
 <CAEUhbmXLr3zXhbphXRvqfyW1FH9qo3yoPwnFoRoYNtbwkrBBKw@mail.gmail.com>
 <CAEUhbmUAKoFPqBLVW4FHmiESaF8fqEtjqDb1LKf4ivG3g2z0ZQ@mail.gmail.com>
 <CAKmqyKPO8CERWMZQEfEM1Q7HBTysB8cG5LsR1wdc334YX5tmgg@mail.gmail.com>
In-Reply-To: <CAKmqyKPO8CERWMZQEfEM1Q7HBTysB8cG5LsR1wdc334YX5tmgg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 26 Jun 2019 09:47:33 +0800
Message-ID: <CAEUhbmVGdeX7j1ep1vJKhZ8a-4K2j-G40LjBJqDkXOi4WM-B9w@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] riscv: virt: Correct pci "bus-range"
 encoding
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Fri, Jun 7, 2019 at 2:46 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jun 6, 2019 at 5:55 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Thu, May 30, 2019 at 11:36 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Alistair,
> > >
> > > On Thu, May 30, 2019 at 11:14 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > >
> > > > On Wed, May 29, 2019 at 1:52 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > The largest pci bus number should be calculated from ECAM size,
> > > > > instead of its base address.
> > > > >
> > > > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > > >
> > > > This seems ok, can you maybe explain what this fixes?
> > > >
> > >
> > > The logic is wrong, as the commit message said. With current wrong
> > > logic, the largest pci bus number encoded in "bus-ranges" property was
> > > wrongly set to 0x2ff in this case. Per pci spec, the bus number should
> > > not exceed 0xff.
> > >
> >
> > Ping?
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Can this go in the 4.1 PR?

Regards,
Bin

