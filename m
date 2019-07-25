Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584E4C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302CC20840
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302CC20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaXV-00088d-Hz
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqaXL-0007kD-UH
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqaXK-0003NQ-RG
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:59:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqaXK-0003NJ-Ne
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:59:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so35930733qkl.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fiy0NLQy2/WDN9kcMtV2H9/OxpWSLCZqjaNvDKa5rfQ=;
 b=D1qU1HrrJKOU/QRvqAaT3PxtffnhkWk+8F/JyYwfV41qRCpjyZ1fJaM/xo8TPej4LL
 Z8E5ifYloKwMPgGZVZGjzg3s9A0q4jMTTP4jE4VGh9/0TQYXNoDIfXfNF3n8h5+I6BOK
 iLBf38nziNhlQKR13a33MJ65Xr8TDvfLu9EJA6cQIjbmJAZfiozyUfOeOGLr8Wltdl1K
 +Ozi1GJFXbaDx4CnqJfbu40ifgHjzPdfPQQM/fUVW5KjWRV29M2+3lUMq5xbUoTX//4s
 eGxc75YOLb2kNlySbHUEICD7OlhQVmL5j8hOcNvtso3NGYY8MxaDrfw0XkjW9V4iSx3+
 wd3A==
X-Gm-Message-State: APjAAAXQgvP/32vw+kqHupInRQvhiLCAAikzE+YuOZ9LGdkkXr1CgTl1
 aqiAgt7LQ5t1xTAvNBQiXWeGSw==
X-Google-Smtp-Source: APXvYqxPq4EryaOOQ3V80rKQKaIjVjose+y38M8Dxc2Eq4rRQxHU7SFrPr2r2myUDqTSFzwhaY6kEw==
X-Received: by 2002:a05:620a:14a1:: with SMTP id
 x1mr60088116qkj.164.1564048786257; 
 Thu, 25 Jul 2019 02:59:46 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 o71sm20544312qke.18.2019.07.25.02.59.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 02:59:45 -0700 (PDT)
Date: Thu, 25 Jul 2019 05:59:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190725055908-mutt-send-email-mst@kernel.org>
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702220400.GA13923@localhost>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, maran.wilson@oracle.com,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 12:04:00AM +0200, Sergio Lopez wrote:
> On Tue, Jul 02, 2019 at 07:04:15PM +0100, Peter Maydell wrote:
> > On Tue, 2 Jul 2019 at 18:34, Sergio Lopez <slp@redhat.com> wrote:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > Could we use virtio-pci instead of virtio-mmio? virtio-mmio is
> > > > a bit deprecated and tends not to support all the features that
> > > > virtio-pci does. It was introduced mostly as a stopgap while we
> > > > didn't have pci support in the aarch64 virt machine, and remains
> > > > for legacy "we don't like to break existing working setups" rather
> > > > than as a recommended config for new systems.
> > >
> > > Using virtio-pci implies keeping PCI and ACPI support, defeating a
> > > significant part of microvm's purpose.
> > >
> > > What are the issues with the current state of virtio-mmio? Is there a
> > > way I can help to improve the situation?
> > 
> > Off the top of my head:
> >  * limitations on numbers of devices
> >  * no hotplug support
> >  * unlike PCI, it's not probeable, so you have to tell the
> >    guest where all the transports are using device tree or
> >    some similar mechanism
> >  * you need one IRQ line per transport, which restricts how
> >    many you can have
> >  * it's only virtio-0.9, it doesn't support any of the new
> >    virtio-1.0 functionality
> >  * it is broadly not really maintained in QEMU (and I think
> >    not really in the kernel either? not sure), because we'd
> >    rather not have to maintain two mechanisms for doing virtio
> >    when virtio-pci is clearly better than virtio-mmio
> 
> Some of these are design issues, but others can be improved with a bit
> of work.
> 
> As for the maintenance burden, I volunteer myself to help with that, so
> it won't have an impact on other developers and/or projects.
> 
> Sergio.

OK so please start with adding virtio 1 support. Guest bits
have been ready for years now.

-- 
MST

