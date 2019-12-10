Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C5EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C82B20652
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="JvOmmlGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C82B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieYGM-00022L-9r
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 00:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ieYFf-0001Vv-Fm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ieYFe-0002oY-8Y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:40:03 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ieYFd-0002o4-TS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:40:02 -0500
Received: by mail-io1-xd41.google.com with SMTP id s2so17459399iog.10
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 21:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XLrIne4hR2d6eybtEtWnz1S4TI3WUKtqOOKr43zhdOA=;
 b=JvOmmlGWcSK+q0RfwjAYvJpeIiJ7THP1ivrRo8AN0XG8MM6ByUoecSU/07H0hbIdEH
 P9ArwN2H8wo18KmPlxr4OKDPXN5S1TAEDq4bXwrkDOsf4Mvnl3rvIDOPrDHt4RFwPlLc
 EVhPezweSWEHzeccxGhDIlXN2kua5kFRIzZz6Zv3FG02PmO/sLJ+S1+9FWQhqfd35c4o
 Peo0m6SiDdi+6VI+khGg6sX++ZXCBacDBIDmoDcDtd8D/vR0Gsk5TBexCHvZ3FyQoFI6
 9MvOZwKhGQdWfShu1DmpNYwqZ/OkvSpC+dzWkHYcaXXpjIrnwBPJi/ccz+1DsvyTAi2X
 q4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XLrIne4hR2d6eybtEtWnz1S4TI3WUKtqOOKr43zhdOA=;
 b=A/O9so6jJJoa8Yzgt5Saf0GEyoK2NwPww9jGeL+7W1qhGGtunbD6ZSoArwiYaBRJHT
 BSpcqy/JIBrR/qoRk6QiFfIlNnRwJ+S/hzUjaSIGWWLXqeuZuXFXWcsUBH4+p7VuZtZc
 hHgWl5+bV05YtHiHAqsZVR0u/s/EShR/gx0nj/TmxB9+eVln/VnA2qh3nC6fa/BbIShG
 HDYnQvkyIGGf8p5Ww8/rYYGG72HbTai0O70nsf6LJo+DFzoapwyx1/1QHrB+Ie2zPts3
 1mdSy8NGeg7s7D/Z4skdc1gbLuBHm1ub033+yKw10lnzTO1KxewLroRMD+aFQGyanMsg
 I7pg==
X-Gm-Message-State: APjAAAVXq0O6ZXOckfqW7kphrUIRaVwkfDyBK8EZTtG5PN7ukk3DrVKr
 gV4t65Z3bU2i0/5R6FNzJlafkar+z2aYcz9EekUSAg==
X-Google-Smtp-Source: APXvYqy+nMap6VFvTiob0IIwEQVfEuTHpB/dXJcRbS8HLd0+eDo/64ldoxY3Pb9ehvWezNH4kLE4YBszLjhisveRcWU=
X-Received: by 2002:a6b:7119:: with SMTP id q25mr22763038iog.148.1575956400162; 
 Mon, 09 Dec 2019 21:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20191203190716.18917-1-yuri.benditovich@daynix.com>
 <20191203190716.18917-2-yuri.benditovich@daynix.com>
 <20191209223152.GL498046@habkost.net>
In-Reply-To: <20191209223152.GL498046@habkost.net>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 10 Dec 2019 07:39:48 +0200
Message-ID: <CAOEp5Od9Xo=mz0PX6y9oj+mQCu27eC6jAu6y1womrTBsAZC82Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb-host: remove 'remote wakeup' flag from
 configuration descriptor
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Yan Vugenfirer <yan@daynix.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 12:32 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Tue, Dec 03, 2019 at 09:07:15PM +0200, Yuri Benditovich wrote:
> > If the redirected device has this capability, Windows guest may
> > place the device into D2 and expect it to wake when the device
> > becomes active, but this will never happen. For example, when
> > internal Bluetooth adapter is redirected, keyboards and mice
> > connected to it do not work. Current commit removes this
> > capability (starting from machine 4.2)
> > Set 'usb-host.suppress-remote-wake' property to 'off' to keep
> > 'remote wake' as is or to 'on' to remove 'remote wake' on
> > 4.1 or earlier.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  hw/core/machine.c    |  1 +
> >  hw/usb/host-libusb.c | 20 ++++++++++++++++++++
> >  hw/usb/trace-events  |  1 +
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 1689ad3bf8..8c0eaad091 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -29,6 +29,7 @@
> >
> >  GlobalProperty hw_compat_4_1[] = {
> >      { "virtio-pci", "x-pcie-flr-init", "off" },
> > +    { "usb-host", "suppress-remote-wake", "off" },
> >  };
> >  const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
>
> In case this doesn't get merged in QEMU 4.2.0, the patch needs to
> be updated to change hw_compat_4_2 instead (after applying the
> 5.0 machine type patch[1]).

Of course I will resubmit if needed.

>
> [1] https://patchew.org/QEMU/20191112104811.30323-1-cohuck@redhat.com/
>
> --
> Eduardo
>

