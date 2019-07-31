Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C547AC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 21:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956B22171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 21:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBx75VSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956B22171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvtl-0003Yg-RK
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 17:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hsvtD-000344-KW
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hsvtC-0002Cj-ML
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:12:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hsvtC-0002Be-Fu
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 17:12:02 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay6so31063563plb.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=05lfh1ZKY8ok3ugWt9c4Kmp9ztsQrnQqCUsxqatEO6Q=;
 b=uBx75VSmLkOzhe/htxxFNximRb5ObR10xmxlxlwOz75oQFrTeNbVq0g3aFJY4+nxzo
 W8aIHYTsot4+vEspHmYARrheGs+J8EeZU1UVgRVm61caPIfZBsYbmmt27XnPCZ5XgWqh
 TMaMlAfpnFM8ROdlVq81cmt2+ipnuc7Vp6BKkCFnOP6eViR28CcJ11izLZjHR+dYvXK6
 x1qldeYUrC0acVuikrhFAbjffmgNibgJN+idrouAimLL+HioNLmzyhzpVNcSn+VksCEB
 rZYO9u6aTujY98I6TVRycNRv6HEjIc2KuldxRxg8TJIlAAB5WkaCcszzG0RJvtJ9SodR
 /OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=05lfh1ZKY8ok3ugWt9c4Kmp9ztsQrnQqCUsxqatEO6Q=;
 b=WcWrTRnhK6Ty7pWiPVfckK0Kc4MSeB4n53GUbCNS1HdDOTZ2bSv6M2+ZRa4tLe96nJ
 qhixCOeNDceAxZ5Y235gma/1Y88Dq2mF7VUn66u/m7i5wBGXqhebRhPwocvEYlt9aetc
 OhtbOJiB6VbxtPHoEdn6qOcmcSLh9PoY5rRMUTdrzzhsG+LrdW7OGjlpQt724q4n5Imf
 ntAcz+MBLFeN0YFoxJ0K3QKvsCVLaCLmMkvu7tvUkr9Iw9aedfAEJcMx6B/oDEcIhqMW
 mmzBjFMyVvh857JnBhXmMHpmj280sQez/fSvypUSpIb+mB+xdVjUK93Qkaq8iy1dM2B1
 T2xw==
X-Gm-Message-State: APjAAAUDyOO0KH3A0MQqki4GNoiIZ/ZO5TiRfvlayGLROu/Kxl9b5JcL
 CFEht5oinsnKSEw3RUteR7U=
X-Google-Smtp-Source: APXvYqz0m8cTRd6gXgUfHd70RsAHL1mkW9pltsCZzoRmfWAHYoc1dzD6ds2k5gQYf0GSaFFyXYEMiw==
X-Received: by 2002:a17:902:7d8b:: with SMTP id
 a11mr68613775plm.306.1564607521038; 
 Wed, 31 Jul 2019 14:12:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id v184sm69226902pfb.82.2019.07.31.14.12.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 14:12:00 -0700 (PDT)
Date: Wed, 31 Jul 2019 14:11:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190731211159.GE15744@roeck-us.net>
References: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
 <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 01:08:50PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/30/19 7:45 PM, Guenter Roeck wrote:
> > The following assert is seen once in a while while resetting the
> > Linux kernel.
> > 
> > qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
> > 	Assertion `dev != NULL' failed.
> > 
> > The call to usb_ep_get() originates from ehci_execute().
> > Analysis and debugging shows that p->queue->dev can indeed be NULL
> > in this function. Add check for this condition and return an error
> > if it is seen.
> 
> Your patch is not wrong as it corrects your case, but I wonder why we
> get there. This assert seems to have catched a bug.
> 
> Gerd, shouldn't we call usb_packet_cleanup() in ehci_reset() rather than
> ehci_finalize()? Then we shouldn't need this patch.
> 


If you send me an alternate patch, I'll be happy to insert it
into my build to give it some test coverage.

Thanks,
Guenter

> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  hw/usb/hcd-ehci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> > index 62dab05..c759f3e 100644
> > --- a/hw/usb/hcd-ehci.c
> > +++ b/hw/usb/hcd-ehci.c
> > @@ -1348,6 +1348,11 @@ static int ehci_execute(EHCIPacket *p, const char *action)
> >          return -1;
> >      }
> >  
> > +    if (p->queue->dev == NULL) {
> > +        ehci_trace_guest_bug(p->queue->ehci, "No device attached to queue\n");
> > +        return -1;
> > +    }
> > +
> >      if (get_field(p->qtd.token, QTD_TOKEN_TBYTES) > BUFF_SIZE) {
> >          ehci_trace_guest_bug(p->queue->ehci,
> >                               "guest requested more bytes than allowed");
> > 

