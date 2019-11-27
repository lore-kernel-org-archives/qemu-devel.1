Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B53C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 10:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDF52070A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 10:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="m95fnOvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDF52070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZuuP-0005Rc-EW
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 05:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iZusr-0004FW-8y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iZusp-0002Wv-Ao
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:49:21 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:47019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1iZusl-0002Tl-TP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:49:17 -0500
Received: by mail-io1-xd41.google.com with SMTP id i11so24251930iol.13
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 02:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y9qMqRXbq24usfDvLDvWDee+4o5R5T5kCDh9h35dmCg=;
 b=m95fnOvv18axMw8xyYNUDbXwnPpnzs68VsEGarxXSSVsR3ruhxXb8OXNQO3dbwFCQx
 +ums09Sv9vB+9PchasA+zMp8tY8FTVOV1v0Bnt9mvGe6I7hntZWQP8zvuF/vC+S4vx53
 lji0RiWmcCOzWKr0T2l9PAdtdW1NbYsj5N6kH2ELN51CkVRzyIgZO+QcV2qdRUKJ0v2B
 wczTFbLPsllWwR6+0I8sd4HK4j2rNXF0PtaOV3oknSgkzTaFTNrmAM7AGSG0XB9E739I
 GbjlsUcHc8+1NUcciMBlL+r50VUnSzVYZHNLiGuWX+84l0FZHPYf5JxZZXGDXqcHansH
 CcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y9qMqRXbq24usfDvLDvWDee+4o5R5T5kCDh9h35dmCg=;
 b=PGNAYBy92ZboPSFLrNRTX5qVL6T6jwZQCxAfqnBvxYalprRvVeFkAwTuE1DZ1HZ3cC
 MTPRq6eSNYOA08+yQ8T7Wj+qWnEGg8rryuEfxXBIW9ikprCHnZ8OA65OXRYO37ucQpYp
 sXmMtSyuJKO1GeATmQkbMP3acSWcTgwiQugvwlzfEM0AW9sZGVL8ahviv8rev9e9PQcH
 YZymUxsZ7Tew6a8J63bHR7uJHydjIkZcV97oX8m7XMCeepo8d3FBF809LCN1XbVI4L2k
 xH61O7EbZ8myaTSy7Ae65BMZ0NIs9weQOzI2+hRkTV8b7W9qSfXHmF0An8MGePrBTTe8
 u3hg==
X-Gm-Message-State: APjAAAVPheSG7aGR4DAC9C/uEglp6C7j/7L7UzTiv4LZioBDcY561w9b
 UzRqnJbqKEBMNIh9VknlVHoDDVEjK1PUH2TpWgt5Vw==
X-Google-Smtp-Source: APXvYqwbYhOFeAjESWW0K2UQ9b2QclsA4OjtjgHdxzHLR2bITaYglTuql7UAHWAaL+GLL/m3VdJJAU5wgyON21wejrs=
X-Received: by 2002:a5d:8592:: with SMTP id f18mr19818505ioj.230.1574851754594; 
 Wed, 27 Nov 2019 02:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20191126212245.27735-1-yuri.benditovich@daynix.com>
 <87a78hltbq.fsf@dusky.pond.sub.org>
 <CAOEp5OdsYhxD4LE9Qu981uiB+33Xc81z8H=cuwTS6tbU9x_UkA@mail.gmail.com>
 <20191127094012.vgpckaztez77dsgz@sirius.home.kraxel.org>
In-Reply-To: <20191127094012.vgpckaztez77dsgz@sirius.home.kraxel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 27 Nov 2019 12:49:01 +0200
Message-ID: <CAOEp5Ocit+8tXxP1873YBD=mMQTeZNcr7pMezw_PU6vMFrg2bA@mail.gmail.com>
Subject: Re: [PATCH] usbredir: remove 'remote wake' capability from
 configuration descriptor
To: Gerd Hoffmann <kraxel@redhat.com>
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
Cc: Yan Vugenfirer <yan@daynix.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 11:40 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Nov 27, 2019 at 09:36:21AM +0200, Yuri Benditovich wrote:
> > On Wed, Nov 27, 2019 at 8:36 AM Markus Armbruster <armbru@redhat.com> wrote:
> > >
> > > Yuri Benditovich <yuri.benditovich@daynix.com> writes:
> > >
> > > > If the redirected device has this capability, Windows guest may
> > > > place the device into D2 and expect it to wake when the device
> > > > becomes active, but this will never happen. For example, when
> > > > internal Bluetooth adapter is redirected, keyboards and mice
> > > > connected to it do not work. Setting global property
> > > > 'usb-redir.nowake=off' keeps 'remote wake' as is.
> > >
> > > "usb-redir.nowake=off" is a double negation.  Gets weirder when dusted
> > > with syntactic sugar: "usb-redir.nonowake".  Can we think of a better
> > > name?  Naming is hard...  What about "usb-redir.wakeup=on"?
> > '"wakeup" is good but "wakeup=on" makes an impression that we add the
> > capability to the device even if it does not have one.
> > disable_wake? suppress_wake? clear_wake? wake_allowed?
>
> remote-wakeup=on,off ?

This is like wakeup=on, suggesting that we turn wake on even if it is
not supported.
Anyway, I agree with any name.

>
> > > > +    DEFINE_PROP_BOOL("nowake", USBRedirDevice, suppress_remote_wake, true),
> > > >      DEFINE_PROP_END_OF_LIST(),
> > > >  };
> > >
> > > The default is .nowake=on.  Is that a guest-visible change?
>
> Yes, usb descriptors change, which the guest can see.
>
> > And, of course, we can keep existing behavior by default and advise to
> > turn this property on to make these devices work.
>
> In that case a compat property would not be needed.
>
> But, after all the question is whenever that is the best way to solve
> the problem.  Most likely there is just a usb_wakeup() call missing
> somewhere ...
>

Indeed, it would be good to call usb_wakeup(), but ... there is no
trigger to do that.

When the guest places the device to D2, it cancels all the urbs that
were pending, so there are no request that will be completed on spice
client side that can call usb_wakeup on qemu side.
The device on spice client side is powered up without any active
request so the device will not produce wake up event.
Usb-redir protocol, and client-side libusb and its kernel partner of
libusb (in case of Windows client - UsbDk/winusb) can't process such
flow correctly.
Of course, AFAIK.

Similar problem happens with local redirection, BTW. But this is for
another patch.

> cheers,
>   Gerd
>

