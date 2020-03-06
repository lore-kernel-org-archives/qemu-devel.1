Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63953C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2638B20801
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvUg4+zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2638B20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57859 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA0Yx-0002cx-4C
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 19:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jA0YG-000281-61
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1jA0YE-00054D-5x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:09:15 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:39446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1jA0YD-000532-MQ; Thu, 05 Mar 2020 19:09:14 -0500
Received: by mail-yw1-xc43.google.com with SMTP id x184so596589ywd.6;
 Thu, 05 Mar 2020 16:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0hpAbpqVVV8Fx1KNiu0bzVflU3RcKR/8lt1WaMqOnzQ=;
 b=cvUg4+ziBDHwwpuEXNWhv3xP043230Fn2yEhT9+U++pubsbWeG1spMVMgyfz5jY9MP
 xNKXGUPL+n8j8Qeu0bPL84pmgzFUhcwXpux29TAbSDOAJ6E44TdV87rBtuOIMZjF5BNV
 3+WQt3c2QDYVA/i2Yi9h4TOS1a0cQM08JnpTJMEsCDHq7l3+W9KUdJvV+yLYmh/ycZMC
 sKcD8rz43VucIpS0wo/9pyOEIkPuYYyiVT6DdZPPcGTbnOJzeSn5il1UUSrR/OJmKNE7
 fMtxLZ9MNavvKRmC7P/NExLUvRufBU9WOS8RPtfwUI6WqQLmL+5paNrKCfEg91rAmlxs
 U84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0hpAbpqVVV8Fx1KNiu0bzVflU3RcKR/8lt1WaMqOnzQ=;
 b=Vpi47JK/dh8G2SDY7WLXPr3Uw7//HmU9mkZr9OjGSNvONQAMaM/6THqdCd3VE5kEKC
 4dZ7jtlaiWTStCFCuzyA2rVLfokTRWf7SBKWLqnAwSqP0Ac4D3+GbCr0q8/7qSz7VyCW
 x9pOOoD2tqF8YcenmuF/2QDJij+w0L3uMOetkI2kvO77lUjUACtMaw8UEj1NaBYliJFC
 /plF1Fjt67mui2bYdkj62g3FC1/9lm9BXZtlSt2CZUe9fe5OguGRSO7uk7ttuUGl4V1N
 EBxfdBEhW9ZUsE0efhADAZJoD7H30+pUjKt/s5hvoS21qBln0N8g8n6hMihU1fQbecg4
 mRag==
X-Gm-Message-State: ANhLgQ3+wGoqqjxS//tk5w0ZXsdA3AWsSsU3+13hmw/Bn9Rd4eiQ4R1w
 BMEL3yLtLcc6XUDNibSmqyCg1c2QrvY14R2Oysg=
X-Google-Smtp-Source: ADFU+vunsyAXrU1idS/uQ7RbeRGptgEscPXeUAqSCh8Fg7nglROykz1yY6VQgdVD4SxcjgqSqB6uJx2ElyX99+0TqKU=
X-Received: by 2002:a25:5b8a:: with SMTP id p132mr977231ybb.11.1583453352462; 
 Thu, 05 Mar 2020 16:09:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583285287.git.alistair.francis@wdc.com>
 <e91f9fccc49a42482d964f380b2ae085de5bfab2.1583285287.git.alistair.francis@wdc.com>
 <CAEUhbmWFPVOZ6Sxjd+VUENqyPxCe89QYKWP-nKSkH3Co-=FYbg@mail.gmail.com>
 <CAKmqyKNrG4Uh_WKwEfiX=HpFoFiforzjKxnY+dZmBQBdKfZceg@mail.gmail.com>
 <CAEUhbmXTzjukKbaXqS+ivxtxbu+tcVFDCg1hcSw5roQjJhx9og@mail.gmail.com>
 <CAKmqyKMLcKKGbA3gJGDMgw77vWNdsU_GhkqC+m9OsN5tBFv0OQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMLcKKGbA3gJGDMgw77vWNdsU_GhkqC+m9OsN5tBFv0OQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 6 Mar 2020 08:09:01 +0800
Message-ID: <CAEUhbmX8ytjiH6JWdvZLveSaN6PS7zHF9wRcDM_yxCA48wn6tQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] riscv/sifive_u: Add a serial property to the
 sifive_u SoC
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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

Hi Alistair,

On Fri, Mar 6, 2020 at 12:53 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 1:31 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Alistair,
> >
> > On Thu, Mar 5, 2020 at 7:13 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Wed, Mar 4, 2020 at 6:47 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > Hi Alistair,
> > > >
> > > > On Wed, Mar 4, 2020 at 9:37 AM Alistair Francis
> > > > <alistair.francis@wdc.com> wrote:
> > > > >
> > > > > At present the board serial number is hard-coded to 1, and passed
> > > > > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > > > > the serial number to generate a unique MAC address for the on-chip
> > > > > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > > > > created and connected to the same subnet, they all have the same
> > > > > MAC address hence it creates a unusable network.
> > > > >
> > > > > A new "serial" property is introduced to the sifive_u SoC to specify
> > > > > the board serial number. When not given, the default serial number
> > > > > 1 is used.
> > > > >
> > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > ---
> > > > >  hw/riscv/sifive_u.c         | 8 +++++++-
> > > > >  include/hw/riscv/sifive_u.h | 2 ++
> > > > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > > > > index 9a0145b5b4..e52f9d0bd4 100644
> > > > > --- a/hw/riscv/sifive_u.c
> > > > > +++ b/hw/riscv/sifive_u.c
> > > > > @@ -488,7 +488,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
> > > > >                            TYPE_SIFIVE_U_PRCI);
> > > > >      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
> > > > >                            TYPE_SIFIVE_U_OTP);
> > > > > -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
> > > > > +    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
> > > > >      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> > > > >                            TYPE_CADENCE_GEM);
> > > > >  }
> > > > > @@ -607,10 +607,16 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> > > > >          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> > > > >  }
> > > > >
> > > > > +static Property riscv_sifive_u_soc_props[] = {
> > > > > +    DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
> > > > > +    DEFINE_PROP_END_OF_LIST()
> > > >
> > > > I am not sure how adding another level of property in the SoC could
> > > > solve the 'make check' error.
> > >
> > > The problem is that you were adding a machine property and then you
> > > had the SoC reach up to the machine object to get the serial value.
> > > This isn't correct and is why the tests fail.
> > >
> >
> > So looks the failure was due to a check in the test codes only? As I
> > did not see QEMU crashed during my normal usage.
>
> No, the bug was in the actual implementation. You were just lucky that
> you didn't see any issues as in your case you could access the machine
> state. The make check probably added the SoC individually and hence
> caught the bug.

That sounds like the difference that caused the crash in the test.
Thanks for helping this!

Regards,
Bin

