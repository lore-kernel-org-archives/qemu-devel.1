Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A4DC3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76AA20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBw7AzmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76AA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tox-0006lR-U8
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j9tkd-0007QF-L5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j9tkc-00005J-Dv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:53:35 -0500
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:45785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j9tkc-00004s-9H; Thu, 05 Mar 2020 11:53:34 -0500
Received: by mail-ua1-x944.google.com with SMTP id q17so2307040uao.12;
 Thu, 05 Mar 2020 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eUvnCZxBFuUjpGEIJEZ+urciDIEcL24tEwB1z/oDl8M=;
 b=cBw7AzmBg+crvWZE/eR9DdR/cfkLf96R151DyU8ftwWR5hGtryLmlwkB/yZYpsZB16
 N9EcXKR4Myv8eAh2h62UNSjU+9hQqj2ZYy7JSvS4eUqTQDR7sHDfHEX6Y4VoSEU+Fvct
 czQNHtsuf+ts9H5Oj/5AhYUZIJ+Mo2BXkarFjv0FYaBkC0MJimSXIAtPhjPKD444Gr/U
 pUkK7NLgW+TLO/q42dVovIU2dSIiOhOz5W08MNHMapfZYCj1Yv+CHVDTQFk1vHePK65z
 H1wrlC99Tl+to79Ih0SeYqCI3dwCqDifzIIumh0SNXK/UV5d0J5UUQkK5cEg2qq728tL
 N5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eUvnCZxBFuUjpGEIJEZ+urciDIEcL24tEwB1z/oDl8M=;
 b=T7A+bOas8GNP88Ha8Dq9xKR37xK3KGTlXrg/caFFNkSVRFNzNiFlb8IEBu0Wbt60i3
 0GQSszh451UJrdUIvj9MIZggFtf0iglXcR6EfyNu4d//NJVF0mYjhm1XeMq3F1oD26me
 /JbuG/QOEuIM2UDOkkvl8OA17g1uuQ/HO3CsX3osMhYuuFlM3y6YkzJ0h0LETjXyzKvg
 59KEa0+ZmUv6Ug25dvph2JvX5nDvHiUvdl5U977cPi1LXGdUmvkMGTwoaJQ6sq+ok1o+
 vvg3xUuURYZ1vY/WhU5/Kg9X6GDR2lgonZSdfJ3pNc/nlZrHyxP59/9ZACsNajXJgOTm
 PtCg==
X-Gm-Message-State: ANhLgQ2+PqpEsxobiDskKJu1w+x2KHQncPM2r3mSvHYxC32L2H2BIEql
 Lar9PD5CW7RC7eWvXmcV5QktxBAOnZMvL/cy2P4=
X-Google-Smtp-Source: ADFU+vvHkX2m0BWsdgosgikNkyE48PhsUCC3neHXDQxaOGAl+X5zHoCJnMv+lsU3bW6jhWTZOOS00Jgi5/+CDXkbJwQ=
X-Received: by 2002:ab0:2302:: with SMTP id a2mr5149747uao.21.1583427213440;
 Thu, 05 Mar 2020 08:53:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583285287.git.alistair.francis@wdc.com>
 <e91f9fccc49a42482d964f380b2ae085de5bfab2.1583285287.git.alistair.francis@wdc.com>
 <CAEUhbmWFPVOZ6Sxjd+VUENqyPxCe89QYKWP-nKSkH3Co-=FYbg@mail.gmail.com>
 <CAKmqyKNrG4Uh_WKwEfiX=HpFoFiforzjKxnY+dZmBQBdKfZceg@mail.gmail.com>
 <CAEUhbmXTzjukKbaXqS+ivxtxbu+tcVFDCg1hcSw5roQjJhx9og@mail.gmail.com>
In-Reply-To: <CAEUhbmXTzjukKbaXqS+ivxtxbu+tcVFDCg1hcSw5roQjJhx9og@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2020 08:45:51 -0800
Message-ID: <CAKmqyKMLcKKGbA3gJGDMgw77vWNdsU_GhkqC+m9OsN5tBFv0OQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] riscv/sifive_u: Add a serial property to the
 sifive_u SoC
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 1:31 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Thu, Mar 5, 2020 at 7:13 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, Mar 4, 2020 at 6:47 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Alistair,
> > >
> > > On Wed, Mar 4, 2020 at 9:37 AM Alistair Francis
> > > <alistair.francis@wdc.com> wrote:
> > > >
> > > > At present the board serial number is hard-coded to 1, and passed
> > > > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > > > the serial number to generate a unique MAC address for the on-chip
> > > > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > > > created and connected to the same subnet, they all have the same
> > > > MAC address hence it creates a unusable network.
> > > >
> > > > A new "serial" property is introduced to the sifive_u SoC to specify
> > > > the board serial number. When not given, the default serial number
> > > > 1 is used.
> > > >
> > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >  hw/riscv/sifive_u.c         | 8 +++++++-
> > > >  include/hw/riscv/sifive_u.h | 2 ++
> > > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > > > index 9a0145b5b4..e52f9d0bd4 100644
> > > > --- a/hw/riscv/sifive_u.c
> > > > +++ b/hw/riscv/sifive_u.c
> > > > @@ -488,7 +488,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
> > > >                            TYPE_SIFIVE_U_PRCI);
> > > >      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
> > > >                            TYPE_SIFIVE_U_OTP);
> > > > -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
> > > > +    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
> > > >      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> > > >                            TYPE_CADENCE_GEM);
> > > >  }
> > > > @@ -607,10 +607,16 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> > > >          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> > > >  }
> > > >
> > > > +static Property riscv_sifive_u_soc_props[] = {
> > > > +    DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
> > > > +    DEFINE_PROP_END_OF_LIST()
> > >
> > > I am not sure how adding another level of property in the SoC could
> > > solve the 'make check' error.
> >
> > The problem is that you were adding a machine property and then you
> > had the SoC reach up to the machine object to get the serial value.
> > This isn't correct and is why the tests fail.
> >
>
> So looks the failure was due to a check in the test codes only? As I
> did not see QEMU crashed during my normal usage.

No, the bug was in the actual implementation. You were just lucky that
you didn't see any issues as in your case you could access the machine
state. The make check probably added the SoC individually and hence
caught the bug.

Alistair

>
> > This patch series instead adds a property to the machine and the SoC,
> > where the machine sets the SoC property.
> >
>
> Regards,
> Bin

