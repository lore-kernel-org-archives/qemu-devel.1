Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDFDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3E920665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="jeFIntyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3E920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZrtH-0001jd-Fj
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 02:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iZrsO-0001Hr-Mg
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iZrsM-0007wM-1h
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:36:40 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:34613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1iZrsK-0007tR-7U
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:36:36 -0500
Received: by mail-il1-x142.google.com with SMTP id p6so20190510ilp.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 23:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+E5Q+LxtfMagHCIM1BQKNFApTF6kS/XEaquYqNe2pV0=;
 b=jeFIntyn3vlghKdvnlW/haKW96tnMyZBnooiVP1z8px7BHtgLMelbkXJC7JUONhXg0
 NaNdwzroP9J7BSL8j1yoIDyvhlT/i5x58XnRVGUN/6Dj+j7Qo3z9QME03BL2TSq7d1YC
 BYZY9aFHttpfp1AnqYkw3zAb6HpjLo0aaYtkCyVlafxS4b4upJ3V8Tjr5kMe0QOdBPVw
 vf1eGSbmC3Xb5qC6ziqx62HL8ahXxyper8W+66CZyDQbL47qhgzhhUUCWn70TP3Kp4+a
 b5wTZ3n7qA0c1GqzJ25Yk2kOl5qmXdDSlIvNmTnW+Pi1E3t6C5ccuz4mJMJUjbXq7bqA
 2sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+E5Q+LxtfMagHCIM1BQKNFApTF6kS/XEaquYqNe2pV0=;
 b=GYuDgxsaqk1xIjQUsofIWd8vqlFrCoFnJIFSmaxI2/BHxB/2ZEXdlGVNyKc9oa3fKT
 hvDDqFRSLETp6uiDZW6n8cTMRETmwZe8jd51dUDN2uyoXtnNvImSrZwFjJMQxHoCagxy
 yX8Kv10HL/YHKFsay3lehXOIgZz/EmsEBzT4n8PFwJPiOFMwvV0faSLFeH6aLLhlE64Y
 +8prlwRSmodpqN93aLkTftsHnVjGgTPHajZaACRTn0m/IG5wQbecsbC99aAt0OG4Daqo
 yfUZ4tm/wvOUVu02UfkF47r2BeKELlyf0R9hsBIgFnF1eL+ogGB70+RlZYk4bXVv7El1
 Ad2Q==
X-Gm-Message-State: APjAAAVGF3ekmKij9BwnY7PKkuPcJ2+UnnlRpu8VDdHLwP+NEllgTEpQ
 bHO/jCN6nFoiw6/sAJB/JLfdlgsUeff08zHKz883/g==
X-Google-Smtp-Source: APXvYqytto19MNLfXMehomJ7vlvDw/9qvz4lrhsEqhRu4K5sI1e8OJfiG3lY0PC1Aqn+byJ2wUFkjWyrzfKHNJVg30k=
X-Received: by 2002:a92:10cb:: with SMTP id 72mr4252958ilq.17.1574840193908;
 Tue, 26 Nov 2019 23:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20191126212245.27735-1-yuri.benditovich@daynix.com>
 <87a78hltbq.fsf@dusky.pond.sub.org>
In-Reply-To: <87a78hltbq.fsf@dusky.pond.sub.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 27 Nov 2019 09:36:21 +0200
Message-ID: <CAOEp5OdsYhxD4LE9Qu981uiB+33Xc81z8H=cuwTS6tbU9x_UkA@mail.gmail.com>
Subject: Re: [PATCH] usbredir: remove 'remote wake' capability from
 configuration descriptor
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 8:36 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Yuri Benditovich <yuri.benditovich@daynix.com> writes:
>
> > If the redirected device has this capability, Windows guest may
> > place the device into D2 and expect it to wake when the device
> > becomes active, but this will never happen. For example, when
> > internal Bluetooth adapter is redirected, keyboards and mice
> > connected to it do not work. Setting global property
> > 'usb-redir.nowake=off' keeps 'remote wake' as is.
>
> "usb-redir.nowake=off" is a double negation.  Gets weirder when dusted
> with syntactic sugar: "usb-redir.nonowake".  Can we think of a better
> name?  Naming is hard...  What about "usb-redir.wakeup=on"?
'"wakeup" is good but "wakeup=on" makes an impression that we add the
capability to the device even if it does not have one.
disable_wake? suppress_wake? clear_wake? wake_allowed?

>
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  hw/usb/redirect.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> > index e0f5ca6f81..e95898fe80 100644
> > --- a/hw/usb/redirect.c
> > +++ b/hw/usb/redirect.c
> > @@ -113,6 +113,7 @@ struct USBRedirDevice {
> >      /* Properties */
> >      CharBackend cs;
> >      bool enable_streams;
> > +    bool suppress_remote_wake;
> >      uint8_t debug;
> >      int32_t bootindex;
> >      char *filter_str;
> > @@ -1989,6 +1990,23 @@ static void usbredir_control_packet(void *priv, uint64_t id,
> >              memcpy(dev->dev.data_buf, data, data_len);
> >          }
> >          p->actual_length = len;
> > +        /*
> > +         * If this is GET_DESCRIPTOR request for configuration descriptor,
> > +         * remove 'remote wakeup' flag from it to prevent idle power down
> > +         * in Windows guest
> > +         */
> > +        if (dev->suppress_remote_wake &&
> > +            control_packet->requesttype == USB_DIR_IN &&
> > +            control_packet->request == USB_REQ_GET_DESCRIPTOR &&
> > +            control_packet->value == (USB_DT_CONFIG << 8) &&
> > +            control_packet->index == 0 &&
> > +            /* bmAttributes field of config descriptor */
> > +            len > 7 && (dev->dev.data_buf[7] & USB_CFG_ATT_WAKEUP)) {
> > +                DPRINTF("Removed remote wake %04X:%04X\n",
> > +                    dev->device_info.vendor_id,
> > +                    dev->device_info.product_id);
> > +                dev->dev.data_buf[7] &= ~USB_CFG_ATT_WAKEUP;
> > +            }
> >          usb_generic_async_ctrl_complete(&dev->dev, p);
> >      }
> >      free(data);
> > @@ -2530,6 +2548,7 @@ static Property usbredir_properties[] = {
> >      DEFINE_PROP_UINT8("debug", USBRedirDevice, debug, usbredirparser_warning),
> >      DEFINE_PROP_STRING("filter", USBRedirDevice, filter_str),
> >      DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true),
> > +    DEFINE_PROP_BOOL("nowake", USBRedirDevice, suppress_remote_wake, true),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
>
> The default is .nowake=on.  Is that a guest-visible change?  Do we need
> compat properties to keep it off for existing machine types?

Guest will see the device as one without 'remote wake' capability.
IMO, in the worst case this does not change anything, in the best case
this will suppress device power transition to D2 and the device will
work.
Including existing machine types.
Probably I did not understand the idea of 'compat property', can you
please provide an example of some existing compat property?
And, of course, we can keep existing behavior by default and advise to
turn this property on to make these devices work.
>

