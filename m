Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6CC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4042173E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nucwtV2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4042173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htbMS-0005eb-Vs
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 13:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50900)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1htbM4-0005Fp-Qi
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1htbM3-00046P-Km
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:28:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1htbM3-000463-F1
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:28:35 -0400
Received: by mail-pf1-x444.google.com with SMTP id b13so36370287pfo.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=JdTGFsT8S/miakjcwvlivkXPP/NE4ouWlNfCfUjZQ9k=;
 b=nucwtV2pF62tYyzC1YCGW/ercl6ktXvAJXHx+vKpSdcDUaLQ8QboSLeigHeGZ6IJ+j
 zalC/qeIT10NaSqm1gbYQhIubysjtd4HLGiMPv4xCCTEkvNDWWKxmiHp19KgwGbZZH2s
 IzQs4fmYnuKjmstS0vuVrFeuOPUZIeMl63L9qcTsMSssYOs97y4/5Hx7wbXb/I9Nu9HE
 ye4RSeo+8ucVIn5wJZ54E+SAPHKl5gzZKYKunHS7kTVqah7hEtDzxL0TOb7zRsrFy63Y
 SZCS79scXXF4rAskRNgFCLzZELUWJk99A0RiZpclrZJz8A/TUmWGrl+hoFwuAk4Wnn9+
 Ymjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=JdTGFsT8S/miakjcwvlivkXPP/NE4ouWlNfCfUjZQ9k=;
 b=h5a9OtECSIOO4Xl9vSyVVquknxjcwgCwcbqcYQ3DyWNW88i3aKCWEcKrDByM6KDt45
 uzJ1seNFB5FnyiIMjolGm1ksg70VgTiV14u38LyEdJOky4tP33wXW8/jsk9tyz4EsC/P
 NilpOMmALjxRh+zi6SraNmyy2IJorlQ+k3+sstMGZq+zkrEA8mjGOesSFK9AOaUuMrbq
 qho7FBp7ga70ROSSQ+JQ1tFFY01vNmhqx5K3YuqO1l4XtHvjk2BDmUSnqECuBtqJ4Hgw
 8mQh2I4WJupo8J6zhMpEzIb5yanCiSN+RIqs9IQW7Hh20bGvT7GXdTzH2k/GxgREw3Dx
 gvcw==
X-Gm-Message-State: APjAAAVtbSc548A9s7TS997yufPva4dnjdM/tL638zuqIS1Z8V2Y9KxY
 tRXav1gJtIv3mFWUBX2mjCM=
X-Google-Smtp-Source: APXvYqzD73HmucCJP9MpW+khKj7fd9zOx4NJ1T3jHkIQ4zKhKri9e6BzdEkgfeV5ra1xdfMNylxbIg==
X-Received: by 2002:a65:6709:: with SMTP id u9mr97252417pgf.58.1564766914217; 
 Fri, 02 Aug 2019 10:28:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id n128sm31440698pfn.46.2019.08.02.10.28.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 10:28:33 -0700 (PDT)
Date: Fri, 2 Aug 2019 10:28:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190802172831.GA3152@roeck-us.net>
References: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
 <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
 <20190802141149.dj7zv5p5wscftvnr@sirius.home.kraxel.org>
 <20190802164626.GA12934@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802164626.GA12934@roeck-us.net>
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

On Fri, Aug 02, 2019 at 09:46:26AM -0700, Guenter Roeck wrote:
> On Fri, Aug 02, 2019 at 04:11:49PM +0200, Gerd Hoffmann wrote:
> > On Wed, Jul 31, 2019 at 01:08:50PM +0200, Philippe Mathieu-Daudé wrote:
> > > On 7/30/19 7:45 PM, Guenter Roeck wrote:
> > > > The following assert is seen once in a while while resetting the
> > > > Linux kernel.
> > > > 
> > > > qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
> > > > 	Assertion `dev != NULL' failed.
> > > > 
> > > > The call to usb_ep_get() originates from ehci_execute().
> > > > Analysis and debugging shows that p->queue->dev can indeed be NULL
> > > > in this function. Add check for this condition and return an error
> > > > if it is seen.
> > > 
> > > Your patch is not wrong as it corrects your case, but I wonder why we
> > > get there. This assert seems to have catched a bug.
> > 
> > https://bugzilla.redhat.com//show_bug.cgi?id=1715801 maybe.
> > 
> > > Gerd, shouldn't we call usb_packet_cleanup() in ehci_reset() rather than
> > > ehci_finalize()? Then we shouldn't need this patch.
> > 
> > The two ehci_queues_rip_all() calls in ehci_reset() should clean up everything
> > properly.
> > 
> > Can you try the patch below to see whenever a ehci_find_device failure is the
> > root cause?
> > 
> > thanks,
> >   Gerd
> > 
> > diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> > index 62dab0592fa2..2b0a57772ed5 100644
> > --- a/hw/usb/hcd-ehci.c
> > +++ b/hw/usb/hcd-ehci.c
> > @@ -1644,6 +1644,10 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
> >          q->dev = ehci_find_device(q->ehci,
> >                                    get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
> >      }
> > +    if (q->dev == NULL) {
> > +        fprintf(stderr, "%s: device %d not found\n", __func__,
> > +                get_field(q->qh.epchar, QH_EPCHAR_DEVADDR));
> > +    }
> 
> I had tried that, but this does happen as standard behavior for some
> architectures (I didn't write down where exactly since I thought it
> must be normal). But, sure, I'll add a log message.
> 

With the log message added, I see it a lot when booting riscv64 images
from usb-ehci.

ehci_state_fetchqh: device 0 not found

It looks like this happens for each usb access (a whopping 800+ times
for a simple boot test). So it is definitely a very common condition.
The relevant qemu command line is something like

	-usb -device usb-ehci,id=ehci -device usb-storage,bus=ehci.0,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw

The image works fine otherwise, so I thought that the condition is normal.

Guenter

