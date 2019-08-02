Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C025C32753
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D312087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K995KB2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D312087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htahs-0005Ew-Gz
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41792)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1htahQ-0004o5-H7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1htahP-0007ci-HB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:46:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1htahN-0007SL-4n
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:46:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id u14so36336350pfn.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=aSXiimJLhxE1jb4ItJreJmuBsnATmXIuu/2Hib6QDMc=;
 b=K995KB2Df8XV4eTlrnsGjgPUS6U2WoKJCBxtUni4mD+3BW0n4FuS8at9YIuO3/2S8c
 PZ4okg6+Qm9HsnooPju/z1pVFYgAvoetSszOdlLWkBFkC6Ost+dkyGoAZt8r3sMvVWIL
 zWkCJZto8gFa4vIKEtzb+hlY91JoKbUrLtuNwQijur2RSQufxmfxpAYw31bE5DAFttsl
 +WlQiIqA3lFcVCxJM3sQvLSNzWgxyEDetfCk+b6YOy5qXMIEDG2V+C0uBxVsXoe1pX22
 Cyubs1S0NyVDWLlViHxpnDelFQMak09tM1ASx4pT2dYJnv/gaJhs8Do8LIb2BBsFYbF/
 Bo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=aSXiimJLhxE1jb4ItJreJmuBsnATmXIuu/2Hib6QDMc=;
 b=lphs2lZslBj2bzPNS/eYZ9sR+ek0M8Oynp3FSOn+H3gIn3iOEWf1VqBa3LUW8oZ6bB
 rfp0dC9I4Q0vD63zRbdMixOwPpAnEhRum4GYoF9xP7jiDxsaVwnRoG/mBEFp+xHqnPkz
 2jQ/Fo+dOQPnlyb9jQOVYp4Rne2PbI38Lp0m7cQwJ5YM6ff56JENUVDyTsogp4mGNjTa
 44swWADz8rGWqqX8TItZfoAMcXKqRR+7FT3Sw9HcBNCd7KAMOH9nXastjKSxmW+IcFal
 2CzZuvF9T6NccU5D4iiLMQYM/FP4jM45ElU/TALPyO95Wa/aZuvpsKrN4ccktN6lf/jl
 6F+g==
X-Gm-Message-State: APjAAAW0fWaKiCWB5gL15aqJQLPLb+zLjPcrXLhaAWlQpOFDgD20LMzu
 HoYdQRcdzFMqPHEQ0YfL4tA=
X-Google-Smtp-Source: APXvYqyzCIPV2Wk/auibPQcDIy0b3e+c0E5f8HFUWvR9GqHya+fQEB7J7DAKYJeAKcpDeGWv6YRY2g==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr13947920pgt.337.1564764388211; 
 Fri, 02 Aug 2019 09:46:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id b24sm48104556pfd.91.2019.08.02.09.46.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:46:27 -0700 (PDT)
Date: Fri, 2 Aug 2019 09:46:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190802164626.GA12934@roeck-us.net>
References: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
 <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
 <20190802141149.dj7zv5p5wscftvnr@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802141149.dj7zv5p5wscftvnr@sirius.home.kraxel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] ehci: Ensure that device is not NULL
 before calling usb_ep_get
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 04:11:49PM +0200, Gerd Hoffmann wrote:
> On Wed, Jul 31, 2019 at 01:08:50PM +0200, Philippe Mathieu-Daudé wrote:
> > On 7/30/19 7:45 PM, Guenter Roeck wrote:
> > > The following assert is seen once in a while while resetting the
> > > Linux kernel.
> > > 
> > > qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
> > > 	Assertion `dev != NULL' failed.
> > > 
> > > The call to usb_ep_get() originates from ehci_execute().
> > > Analysis and debugging shows that p->queue->dev can indeed be NULL
> > > in this function. Add check for this condition and return an error
> > > if it is seen.
> > 
> > Your patch is not wrong as it corrects your case, but I wonder why we
> > get there. This assert seems to have catched a bug.
> 
> https://bugzilla.redhat.com//show_bug.cgi?id=1715801 maybe.
> 
> > Gerd, shouldn't we call usb_packet_cleanup() in ehci_reset() rather than
> > ehci_finalize()? Then we shouldn't need this patch.
> 
> The two ehci_queues_rip_all() calls in ehci_reset() should clean up everything
> properly.
> 
> Can you try the patch below to see whenever a ehci_find_device failure is the
> root cause?
> 
> thanks,
>   Gerd
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 62dab0592fa2..2b0a57772ed5 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1644,6 +1644,10 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>          q->dev = ehci_find_device(q->ehci,
>                                    get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
>      }
> +    if (q->dev == NULL) {
> +        fprintf(stderr, "%s: device %d not found\n", __func__,
> +                get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
> +    }

I had tried that, but this does happen as standard behavior for some
architectures (I didn't write down where exactly since I thought it
must be normal). But, sure, I'll add a log message.

Guenter

>  
>      if (async && (q->qh.epchar & QH_EPCHAR_H)) {
>  

