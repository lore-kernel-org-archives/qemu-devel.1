Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B2BC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9254B2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2gC1D6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9254B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXd6-0002cV-Cd
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipXWH-0001le-Kt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipXWF-0003eQ-8R
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:06:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35407
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipXWF-0003aR-3B
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578575194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQ3iBfzzFtNgzmr8w83LD5zgKQuTWC39bW6H8yDBJec=;
 b=h2gC1D6nI4Ok1kutZBfCvehdJqBbtYkSgor35HvJukkSPePs1orb960AbmlCKrvLnb8QkP
 u2veJ4W6+mnYFeatjdP5FiX9twIiYhX5+s5sFXIlH9GqbGXtTTbQBjJTE8cj15j5n/eIgc
 LLeSwnePiBGKSsuGitwPTo9j9bH+9D4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-DMNQZ7m8NEKlAuTNWaZu7g-1; Thu, 09 Jan 2020 08:06:33 -0500
Received: by mail-qk1-f200.google.com with SMTP id 11so4093701qkk.11
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 05:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fMaimLdHxqlseHLioKEUJlgcikBSeqO5dHG6UZaqkzI=;
 b=Wria37nZ2IC/A09JuGpid0ejSI+MtQqk3TMMS1/B8lImgT5jkzYqolvfRTYpju5Yyd
 cmSOq32BdXH8DKYdzEpP8rHREZCm3coxBZaQTXj9WXnzgqawiWDcxxttJqwclJGuGt8v
 Et0VhGXF+CcWSSSingvAM6dIBbePBQk14WLXPe2bH4nvmY6z1K5zpY+w/vidgL7DuOse
 A6jWhGvBFP2Vi8n6e/+s8K5ro8qlO3DHo74rD8Cns2uOGwCYKeEluZra8abcHIHE2H6p
 +i+/gVnrpCOYSMu9MhQCm28qsQ3vcdXioOQhPw0Hz4Drhkm7BGeN+Zvm9+/V3Zw544i1
 8cAw==
X-Gm-Message-State: APjAAAUDgxQlwG8bRfAhivDjT8HuuHbLtyoXOPP8vNmY6JaHuaXFgLw9
 Yob3qtMKpCXNNkYG1vCR76gSsgqmmrV3k2H4QiBneUJHP5yVb9gyOjjIJI71dd4R5ZtVFB5IX4c
 Nw41boYUYHKZcnf0=
X-Received: by 2002:a0c:a563:: with SMTP id y90mr8452197qvy.78.1578575192560; 
 Thu, 09 Jan 2020 05:06:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuTkxHL5dzFV+VIFWlkGB8sUn9Aml7iarNpz8cEAzLwfI3a+YZHHioBo92C1jsOI3HEDWAoA==
X-Received: by 2002:a0c:a563:: with SMTP id y90mr8452174qvy.78.1578575192309; 
 Thu, 09 Jan 2020 05:06:32 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id q5sm2936471qkf.14.2020.01.09.05.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 05:06:31 -0800 (PST)
Date: Thu, 9 Jan 2020 08:06:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109080412-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200109122237.GD6795@work-vm>
X-MC-Unique: DMNQZ7m8NEKlAuTNWaZu7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: jasowang@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 12:22:37PM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Thu, Jan 09, 2020 at 12:08:20PM +0000, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gilbert (g=
it) wrote:
> > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > >=20
> > > > > Mark the synic pages as ram_device so that they won't be visible
> > > > > to vhost.
> > > > >=20
> > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > >=20
> > > >=20
> > > > I think I disagree with this one.
> > > >  * A RAM device represents a mapping to a physical device, such as =
to a PCI
> > > >  * MMIO BAR of an vfio-pci assigned device.  The memory region may =
be mapped
> > > >  * into the VM address space and access to the region will modify m=
emory
> > > >  * directly.  However, the memory region should not be included in =
a memory
> > > >  * dump (device may not be enabled/mapped at the time of the dump),=
 and
> > > >  * operations incompatible with manipulating MMIO should be avoided=
.  Replaces
> > > >  * skip_dump flag.
> > > >=20
> > > > Looks like an abuse of notation.
> > >=20
> > > OK, it did feel a bit like that - any suggestions of another way to d=
o
> > > it?
> > >   This clearly isn't normal RAM.
> > >=20
> > > Dave
> >=20
> > If it's just an optimization for vhost/postcopy/etc, then I think
>=20
> Note it's not an optimisation; postcopy fails unless you can aggregate
> the members of the hugepage.
> And I think vhost-user will fail if you have too many sections - and
> the 16 sections from synic I think will blow the slots available.

Right, so both are internal reasons.

> > an API that says how this isn't normal ram would be ok.
> > E.g. it's not DMA'd into? Then maybe _nodma?
>=20
> Do we want a new memory_region_init for that or just to be able to add
> a flag?
>=20
> Dave

I think a flag API is preferable since this can apply to any kind of
region. But can go either way, Paolo's the maintainer there.

> > > >=20
> > > >=20
> > > > > ---
> > > > >  hw/hyperv/hyperv.c | 14 ++++++++------
> > > > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > > > > index da8ce82725..4de3ec411d 100644
> > > > > --- a/hw/hyperv/hyperv.c
> > > > > +++ b/hw/hyperv/hyperv.c
> > > > > @@ -95,12 +95,14 @@ static void synic_realize(DeviceState *dev, E=
rror **errp)
> > > > >      msgp_name =3D g_strdup_printf("synic-%u-msg-page", vp_index)=
;
> > > > >      eventp_name =3D g_strdup_printf("synic-%u-event-page", vp_in=
dex);
> > > > > =20
> > > > > -    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
> > > > > -                           sizeof(*synic->msg_page), &error_abor=
t);
> > > > > -    memory_region_init_ram(&synic->event_page_mr, obj, eventp_na=
me,
> > > > > -                           sizeof(*synic->event_page), &error_ab=
ort);
> > > > > -    synic->msg_page =3D memory_region_get_ram_ptr(&synic->msg_pa=
ge_mr);
> > > > > -    synic->event_page =3D memory_region_get_ram_ptr(&synic->even=
t_page_mr);
> > > > > +    synic->msg_page =3D qemu_memalign(qemu_real_host_page_size,
> > > > > +                                    sizeof(*synic->msg_page));
> > > > > +    synic->event_page =3D qemu_memalign(qemu_real_host_page_size=
,
> > > > > +                                      sizeof(*synic->event_page)=
);
> > > > > +    memory_region_init_ram_device_ptr(&synic->msg_page_mr, obj, =
msgp_name,
> > > > > +                           sizeof(*synic->msg_page), synic->msg_=
page);
> > > > > +    memory_region_init_ram_device_ptr(&synic->event_page_mr, obj=
, eventp_name,
> > > > > +                           sizeof(*synic->event_page), synic->ev=
ent_page);
> > > > > =20
> > > > >      g_free(msgp_name);
> > > > >      g_free(eventp_name);
> > > > > --=20
> > > > > 2.24.1
> > > >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


