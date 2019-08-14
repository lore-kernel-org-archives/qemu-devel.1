Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAB3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3EB20665
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE/90/DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3EB20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxuTM-0003Tm-PY
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 10:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1hxuSh-00033k-5Y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hxuSf-0001Fb-QK
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:41:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hxuSf-0001EX-Jn
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:41:13 -0400
Received: by mail-pg1-x544.google.com with SMTP id n9so46972508pgc.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=N9cOcv1BVXJcJQ7QJfM1M9xy2CTQ5s9kJ2wj+tITcQY=;
 b=kE/90/DVSr4GlkuljAx2MaO6Pi/RYDAjNQ0iKr8rbw3Xg+gC7K1qbDReU5kCYDKulk
 S6b0yEag53nARBXxwMFV1b6Zb50WPCQYu/+nc2kk6flm12WSU8FhjxLjbNMj0yDke7Kz
 58mSrG5OmAiMCYGo5BgzjePW+ZFM1IHGJrVLW5y2EBXBW6812l67yxlrLmrt+Qdv1ovR
 AoLDvyY62u22USnzGfA9KVwKw+m4UsfGfdtI5oCRw7mTD2sLZ+qgj21fnDmbztQJ3TtT
 5SDi2BK64mJ0R0cuj89qm8I24Gu02mCEAbuNdkHghytSM4TEROpP1wcMA98lG3eG87tj
 dVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=N9cOcv1BVXJcJQ7QJfM1M9xy2CTQ5s9kJ2wj+tITcQY=;
 b=O0I4CJsGD21mhQbPhGsKlcQdBnUiYo3z0aOvDxqDDzKQfQJDzMUaz5iCC8bJwmVkpJ
 z7Qw0DIJQk4u7uhvpxY99ddxCFzAS1M+ZBX5INSPr8oppC8E3F5hOkgpnnHNWKaUg3dN
 CARr563MG4ZaQDvhI6usJbRNSZJyzCbpA3dx86NHLR+ZHcbnD7SX77KHUm5DHvJbI/qn
 vZqizSi6wRfM3peHVhIAwnXo3YN1WdPodCWfgKVgWeWpreKjiUdEbQJzhNuLGA35TdrG
 QRgTojNgmbexcgLJ0WMvfnfawm8BQkGgLKHxXSryyS7ujRclq1/92zxbXj4oQyvh8l/c
 RUdA==
X-Gm-Message-State: APjAAAW6YnNf+9rHcAlqT5IOnSr9/HrD4e05GwAix4c3BVZtclq+oL6g
 NzhNJj4ZH9opM2mw+4JaUDg=
X-Google-Smtp-Source: APXvYqw52HXvRcV7lVxfWExg8QeH604PX2EYFypNyJLTjNdh4FrI+ouX4pWPcoLEbtJzzjQ8/JR+Fw==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr39807927pgi.70.1565793668875; 
 Wed, 14 Aug 2019 07:41:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id t6sm37231362pgu.23.2019.08.14.07.41.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 07:41:08 -0700 (PDT)
Date: Wed, 14 Aug 2019 07:41:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190814144107.GB30613@roeck-us.net>
References: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
 <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
 <20190802141149.dj7zv5p5wscftvnr@sirius.home.kraxel.org>
 <14dfe5ce-d74c-dccd-a62b-753b2efa924b@roeck-us.net>
 <20190813114203.z62dgyyneqcp3mru@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813114203.z62dgyyneqcp3mru@sirius.home.kraxel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On Tue, Aug 13, 2019 at 01:42:03PM +0200, Gerd Hoffmann wrote:
> On Tue, Aug 06, 2019 at 06:23:38AM -0700, Guenter Roeck wrote:
> > On 8/2/19 7:11 AM, Gerd Hoffmann wrote:
> > > On Wed, Jul 31, 2019 at 01:08:50PM +0200, Philippe Mathieu-Daudé wrote:
> > > > On 7/30/19 7:45 PM, Guenter Roeck wrote:
> > > > > The following assert is seen once in a while while resetting the
> > > > > Linux kernel.
> > > > > 
> > > > > qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
> > > > > 	Assertion `dev != NULL' failed.
> > > > > 
> > > > > The call to usb_ep_get() originates from ehci_execute().
> > > > > Analysis and debugging shows that p->queue->dev can indeed be NULL
> > > > > in this function. Add check for this condition and return an error
> > > > > if it is seen.
> > > > 
> > > > Your patch is not wrong as it corrects your case, but I wonder why we
> > > > get there. This assert seems to have catched a bug.
> > > 
> > > https://bugzilla.redhat.com//show_bug.cgi?id=1715801 maybe.
> > > 
> > > > Gerd, shouldn't we call usb_packet_cleanup() in ehci_reset() rather than
> > > > ehci_finalize()? Then we shouldn't need this patch.
> > > 
> > > The two ehci_queues_rip_all() calls in ehci_reset() should clean up everything
> > > properly.
> > > 
> > > Can you try the patch below to see whenever a ehci_find_device failure is the
> > > root cause?
> > > 
> > > thanks,
> > >    Gerd
> > > 
> > > diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> > > index 62dab0592fa2..2b0a57772ed5 100644
> > > --- a/hw/usb/hcd-ehci.c
> > > +++ b/hw/usb/hcd-ehci.c
> > > @@ -1644,6 +1644,10 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
> > >           q->dev = ehci_find_device(q->ehci,
> > >                                     get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
> > >       }
> > > +    if (q->dev == NULL) {
> > > +        fprintf(stderr, "%s: device %d not found\n", __func__,
> > > +                get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
> > > +    }
> > Turns out I end up seeing that message hundreds of times early on each boot,
> > no matter which architecture. It is quite obviously a normal operating condition.
> 
> Yep, as long as the queue is not active this is completely harmless.
> So we need to check a bit later.  In execute() looks a bit too late
> though, we don't have a good backup plan then.
> 
> Does the patch below solve the problem without bad side effects?
> 
I reverted my patch and applied the patch below to my builds of qemu, for both
v4.0 and v4.1, and installed it in my test bed. I'll let you know how it goes.

Thanks,
Guenter

> thanks,
>   Gerd
> 
> From 5980eaad23f675a2d509d0c55e288793619761bc Mon Sep 17 00:00:00 2001
> From: Gerd Hoffmann <kraxel@redhat.com>
> Date: Tue, 13 Aug 2019 13:37:09 +0200
> Subject: [PATCH] ehci: try fix queue->dev null ptr dereference
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/hcd-ehci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 62dab0592fa2..5f089f30054b 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1834,6 +1834,9 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
>              ehci_set_state(q->ehci, q->async, EST_EXECUTING);
>              break;
>          }
> +    } else if (q->dev == NULL) {
> +        ehci_trace_guest_bug(q->ehci, "no device attached to queue");
> +        ehci_set_state(q->ehci, q->async, EST_HORIZONTALQH);
>      } else {
>          p = ehci_alloc_packet(q);
>          p->qtdaddr = q->qtdaddr;
> -- 
> 2.18.1
> 

