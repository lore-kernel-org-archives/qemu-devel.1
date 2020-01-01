Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F80C2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 16:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A77C2080A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 16:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="FfqedtF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A77C2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imgg4-00030Z-6y
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 11:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1imgfG-0002V6-78
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 11:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1imgfE-0003OS-G6
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 11:16:05 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1imgfE-0003CI-1E
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 11:16:04 -0500
Received: by mail-oi1-x241.google.com with SMTP id c16so12531417oic.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 08:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=farSUXxp88oWk1zRhqa1mqTL/SABerU4X6E3hdyAXZU=;
 b=FfqedtF8+6jMFF+00JTOeLu7ZZgOtAlFSjmUqbBVJe3gBeQPTFG1BYwQkDQWxATQiF
 YwfHwiLJxBrQwT71yHICOMW5LdqROyqBb47fyh802lAIXdG7wckPzY65VZ3aJNepk3+O
 xtdYZV7IidkxvHBSJDe6krpfVrVy62ygkx3EaJAOixn5EZVhGnqnNo+Ilq26kHPhWhE/
 fXmaO9+KHpK2Sg72KbOdy7Hwz5V8l1yPvEz7oCDiNzgBaFhjvLkiICFOhGYSrfb+KBsS
 7snxAqFdId93UbRf20VcvqiqKegMocO8e9xMBEZasqb+NAE8WVEkRB8jv7Wi47WHs9F6
 bl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=farSUXxp88oWk1zRhqa1mqTL/SABerU4X6E3hdyAXZU=;
 b=EJ2HmbQdOPpkpkMtoF9SNRypktCoGpSgov8Ckk8NyzWc0khZf/Atip6q5c/n/7xzFO
 ctfQhpqWSCJ9AOjb5FpIbb2y602nhsupQQnxspLYk7oxoFDt3JDR1LRKeAxnrH66JXVt
 zq+gkuWURct2i4Zc++FU8gezm5cxSgmMk8mcoEg+ajrmkEoGkRm2EnaIvEuRtZqHhfjo
 LunAlWEFhyLLWOeTYvAbRM9wst+jO6Ks6x6ZbUinFGh1xwibsZlqvqGNgVfIJJWMvN0K
 KxiVjf3VHosh0QrjtWJszByPJR2MhBIqpDYcwum5gY4yu+Go7lOHAa6wnbpwtDFuiJwN
 LkRA==
X-Gm-Message-State: APjAAAX8M7SHajthdCa/NZyO56nIHXHnS5IA6UxwLpkhVtCafnz7AP5I
 GvE0B8oDwq9nev6XBKab4rUyyg==
X-Google-Smtp-Source: APXvYqwSp69gkdG/GLj2Z3SA26h1ZLKNqvqh8LXHcZy256LAKTh2eU2qFHUJxsUC5g7DR7npgn0M0Q==
X-Received: by 2002:a05:6808:4cc:: with SMTP id
 a12mr1974625oie.115.1577895360974; 
 Wed, 01 Jan 2020 08:16:00 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:d193:7acb:1243:c644])
 by smtp.gmail.com with ESMTPSA id e6sm18247823otl.12.2020.01.01.08.15.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 01 Jan 2020 08:16:00 -0800 (PST)
Date: Wed, 1 Jan 2020 10:15:58 -0600
From: Corey Minyard <cminyard@mvista.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 05/14] hw/i2c/Kconfig: Add an entry for the SMBus
Message-ID: <20200101161558.GC6454@minyard.net>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-6-philmd@redhat.com>
 <20191231191600.GB6497@minyard.net>
 <89c243b7-bbd0-78cc-67ba-34e0fb19e1bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89c243b7-bbd0-78cc-67ba-34e0fb19e1bd@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Reply-To: cminyard@mvista.com
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 01, 2020 at 11:25:42AM +0100, Philippe Mathieu-Daudé wrote:
> On 12/31/19 8:16 PM, Corey Minyard wrote:
> > On Tue, Dec 31, 2019 at 07:32:07PM +0100, Philippe Mathieu-Daudé wrote:
> > > The System Management Bus is more or less a derivative of the I2C
> > > bus, thus the Kconfig entry depends of I2C.
> > > Not all boards providing an I2C bus support SMBus.
> > > Use two different Kconfig entries to be able to select I2C without
> > > selecting SMBus.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > > ---
> > > Cc: Corey Minyard <cminyard@mvista.com>
> > > ---
> > >   default-configs/mips-softmmu-common.mak | 1 +
> > >   hw/i2c/Kconfig                          | 8 ++++++--
> > >   hw/i2c/Makefile.objs                    | 3 ++-
> > >   3 files changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
> > > index da29c6c0b2..ac76d944b8 100644
> > > --- a/default-configs/mips-softmmu-common.mak
> > > +++ b/default-configs/mips-softmmu-common.mak
> > > @@ -37,6 +37,7 @@ CONFIG_R4K=y
> > >   CONFIG_MALTA=y
> > >   CONFIG_PCNET_PCI=y
> > >   CONFIG_MIPSSIM=y
> > > +CONFIG_SMBUS=y
> > 
> > Why is the above necessary?  Wouldn't CONFIG_ACPI_SMBUS=y below cause
> > this to be done?
> 
> Yes you are correct!
> 
> > 
> > >   CONFIG_ACPI_SMBUS=y
> > >   CONFIG_SMBUS_EEPROM=y
> > >   CONFIG_TEST_DEVICES=y
> > > diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> > > index 2bbd395813..09642a6dcb 100644
> > > --- a/hw/i2c/Kconfig
> > > +++ b/hw/i2c/Kconfig
> > > @@ -1,9 +1,13 @@
> > >   config I2C
> > >       bool
> > > +config SMBUS
> > > +    bool
> > > +    select I2C
> > > +
> > >   config SMBUS_EEPROM
> > >       bool
> > > -    depends on I2C
> > > +    select SMBUS
> > >   config VERSATILE_I2C
> > >       bool
> > > @@ -11,7 +15,7 @@ config VERSATILE_I2C
> > >   config ACPI_SMBUS
> > >       bool
> > > -    select I2C
> > > +    select SMBUS
> > >   config BITBANG_I2C
> > >       bool
> > > diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> > > index d7073a401f..cbbc8507a3 100644
> > > --- a/hw/i2c/Makefile.objs
> > > +++ b/hw/i2c/Makefile.objs
> > > @@ -1,4 +1,5 @@
> > > -common-obj-$(CONFIG_I2C) += core.o smbus_slave.o smbus_master.o
> > > +common-obj-$(CONFIG_I2C) += core.o
> > > +common-obj-$(CONFIG_SMBUS) += smbus_slave.o smbus_master.o
> > >   common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
> > >   common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
> > >   common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
> > 
> > There is some messiness with ICH, but it appears that everything will
> > work correctly there and this patch is not the right place to fix it.
> 
> I did some cleaning with the ICH9 chipset last year, I need to find some
> time to refresh it.
> 
> > This looks fine and avoids including smbus code when it is not
> > necessary.  With the MIPS config item removed (assuming it is not
> > necessary):
> > 
> > Reviewed-by: Corey Minyard <cminyard@mvista.com>
> 
> Thanks!
> 
> > 
> > I can take it into my tree if you like.
> 
> Sure, do you mind cleaning default-configs/mips-softmmu-common.mak or you
> prefer a respin of this single patch?

I removed that piece and have it queued.

Thanks,

-corey

> 
> > 
> > Thanks,
> > 
> > -corey
> > 
> > > -- 
> > > 2.21.0
> > > 
> > 
> 

