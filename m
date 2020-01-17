Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF8FC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBBC20728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXDo7jjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBBC20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWOA-00075j-H5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isWNO-0006Rm-8r
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isWNN-0001Ik-6o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:29:46 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:40151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isWNK-0001Gg-Nq; Fri, 17 Jan 2020 13:29:42 -0500
Received: by mail-yb1-xb43.google.com with SMTP id l197so4917884ybf.7;
 Fri, 17 Jan 2020 10:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ROPyz/f5AhqyNnlV8CsC/MUsp5r48yvDR1ZrQnvMJ4A=;
 b=BXDo7jjrlUZIFGB91S5G7FSKbyYXtU7ZlLi38FuNzLC+wxvfLu4oo6Mi9v+C5ggnlR
 o5tjgX8QI/kA8w9C9+0ba1HL1tn8MgwT3tXFhEBBVIIEa7LQXv9QGl17w/bjrzB4MX8l
 Tnp7kCPbtueIQcYzm3IDTqedMX1USPBaal9RmosuHidzzOcIdGNMY8Zy1rPb0KA9VQBK
 5/aDzir4YHiPKS//6BkMHElyY6BLMQ75gHFDmZ60gNpX1/JFopt5A4stlb7ftw6snneY
 e7QgtW6xxCxL22SpI7+pZ/TlJMtMQAT432GQK9YsGZXhklvLqnkb/cDbPFvy3i/SW7oY
 SOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ROPyz/f5AhqyNnlV8CsC/MUsp5r48yvDR1ZrQnvMJ4A=;
 b=nVQFYwo43uEMdii0sopzTzu3YVGSJDNZlyqTDeeiNs7Cp+7CzMIJWkLXNwTENFE+zJ
 QupHg9XEovEH5lhYjdAjTJ2dnQ6fFKVxRAucjfHOzNhZdVHwgQKZIgxTBToLchFAkNHl
 rWTQ87q00lGtIDrIXIPl1iOQz6BnA4eBzhSgHGTVPUG37McA0NKMmYtp9iHf4n9QnTzV
 lx276lYegIGDYviAgI/TF0e4hSFuiLR7hR0ySJi5bVgwJPCY3KF3LNa20DfktilBfMas
 XyY5ImXGYY+AFH40i1NmtPGeEFhk3Bxyd0MoHqZ24UPZoOX27n1HYXjkHLJEY8AgJAg5
 pSHQ==
X-Gm-Message-State: APjAAAWvU8QIotpgyrVSkXwBcvakko0zCX37ka4NppQ57yd9xrwXAt0q
 QOyoRknukZkHVQRyJYhmHmA=
X-Google-Smtp-Source: APXvYqz2+3hL1okXrBnvSux7iSdsbdB/6q550VxqTxOt/jg9GONqWJ3SzMyUn8RN+Fz9CVhhGM1u1g==
X-Received: by 2002:a25:5a06:: with SMTP id o6mr30345918ybb.384.1579285781654; 
 Fri, 17 Jan 2020 10:29:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id y206sm11930688ywa.102.2020.01.17.10.29.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 10:29:40 -0800 (PST)
Date: Fri, 17 Jan 2020 10:29:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 6/6] hw/arm/exynos4210: Connect serial port DMA busy
 signals with pl330
Message-ID: <20200117182939.GC13396@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-7-linux@roeck-us.net>
 <CAFEAcA_v98GcR06PWfm+=VnteQN_Q7iKK4wobAg6NrVSP1AyDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_v98GcR06PWfm+=VnteQN_Q7iKK4wobAg6NrVSP1AyDg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 01:48:06PM +0000, Peter Maydell wrote:
> On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > The Exynos4210 serial driver uses an interrupt line to signal if receive
> > data is available. Connect that interrupt with the DMA controller's
> > 'peripheral busy' gpio pin.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  hw/arm/exynos4210.c | 39 ++++++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> > index c7b5c587b1..498d79ebb2 100644
> > --- a/hw/arm/exynos4210.c
> > +++ b/hw/arm/exynos4210.c
> > @@ -166,8 +166,8 @@ static uint64_t exynos4210_calc_affinity(int cpu)
> >      return (0x9 << ARM_AFF1_SHIFT) | cpu;
> >  }
> >
> > -static void pl330_create(uint32_t base, qemu_irq irq, int nreq, int nevents,
> > -                         int width)
> > +static DeviceState *pl330_create(uint32_t base, qemu_irq irq, int nreq,
> > +                                 int nevents, int width)
> >  {
> >      SysBusDevice *busdev;
> >      DeviceState *dev;
> > @@ -191,6 +191,7 @@ static void pl330_create(uint32_t base, qemu_irq irq, int nreq, int nevents,
> >      for (i = 0; i < nevents; i++) {
> >          sysbus_connect_irq(busdev, i + 1, irq); /* event irq lines */
> >      }
> > +    return dev;
> >  }
> >
> >  static void exynos4210_realize(DeviceState *socdev, Error **errp)
> > @@ -199,7 +200,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
> >      MemoryRegion *system_mem = get_system_memory();
> >      qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
> >      SysBusDevice *busdev;
> > -    DeviceState *dev;
> > +    DeviceState *dev, *uart[4], *pl330[3];
> 
> Rather than having the uart and pl330 pointers be locals,
> they should be fields in Exynos4210State. (Otherwise technically
> we leak them, though this is unnoticeable in practice because there's
> no way to destroy an Exynos4210State.)
> 
Out of curiosity: Is that a new leak because they are now tied together,
or is it an existing leak ? I don't find many DeviceState entries
in xxxState structures, so find it difficult to determine if/when/why
there is such a leak.

Thanks,
Guenter

