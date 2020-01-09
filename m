Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5509C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A0C20661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eABk7xea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A0C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXs4-0007sm-KC
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipXr2-0006zM-PR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipXr1-0001IM-9h
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:28:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipXr1-0001Er-2z
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578576482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKFEEzYpbUIAPnzwJnkmWA2blY73X5r+jax/X8uc4bA=;
 b=eABk7xea9jOLh31S77tDALxn3F/hugh2A0nK65ltPwUQHiLsLQr92xuh0sWx5QjTNTZhfg
 Q2V7ef4p3WlFhHTEZrIy0javssF37/0/IE/bwKyutPwRdK3SycnWfj+xhRTra4Nca/PQ10
 iAUe/Nw84u79/rofVwCwriEY58Ue/zA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-ecKDAukoNYSz9bIpd6ps3A-1; Thu, 09 Jan 2020 08:28:00 -0500
Received: by mail-qt1-f198.google.com with SMTP id l1so4153405qtp.21
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 05:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a+rAzkv86txIxUnOnVVvHzV4YqkR4aOG+VxfiTMFHkA=;
 b=fbr4rINNWrNIRH1bwRrBG/M9QoUhUzK8dcNJoSm+aWkytIz/wObLKDZ1bjwRejI0AS
 bxlnMVKzMwQXw/hS+HdvGBg/y6JE3FlVsFSk0O+GfGptRfB6nIx05MKVhgtfMqeSBIr3
 6Nm+m5kzLCn5lce4QwFN9fZD3RExLPDB9TbOoWg1091pIBJ28v1UN4brnyedummc0Oyt
 ioflwro0shHbIcL0gSby1wDoHlX4G5H/skogMFGf+h2jjS2OI/pA0DnIQsK/06b1ue7U
 u4fUbloU2LORYgc1nDctdGnKu2g7WS+lSsfKbDoQRDl7CSeZLMFtymW0CZ/zZYV05lu8
 +bAQ==
X-Gm-Message-State: APjAAAV8ZTV8yUhGRCAOBCUTywflQ8KWG/En8f2t2ScR7xRikpqhmODU
 S0td9UCTnSsd4V2hMhEekTTDFt7bA0ZToqBR/Q4cBGKD9Gn7FaYvB7UhvLy6dHaNUx88zHlVpnZ
 lL2r3IuZEHZMPKDc=
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr9159286qkg.402.1578576480477; 
 Thu, 09 Jan 2020 05:28:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7ttLaazeEzAtEAleW8lWSJSRL0e1zE5it+IqO/UGvKbzIYjG5srm2+pr+VpMgbbmYfzYxGA==
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr9159260qkg.402.1578576480208; 
 Thu, 09 Jan 2020 05:28:00 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id x34sm3336144qtd.20.2020.01.09.05.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 05:27:59 -0800 (PST)
Date: Thu, 9 Jan 2020 08:27:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109082726-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <20200109080412-mutt-send-email-mst@kernel.org>
 <20200109132242.GF6795@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200109132242.GF6795@work-vm>
X-MC-Unique: ecKDAukoNYSz9bIpd6ps3A-1
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
Cc: jasowang@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 01:22:42PM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Thu, Jan 09, 2020 at 12:22:37PM +0000, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > On Thu, Jan 09, 2020 at 12:08:20PM +0000, Dr. David Alan Gilbert wr=
ote:
> > > > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > > > On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gilber=
t (git) wrote:
> > > > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > > >=20
> > > > > > > Mark the synic pages as ram_device so that they won't be visi=
ble
> > > > > > > to vhost.
> > > > > > >=20
> > > > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > >=20
> > > > > >=20
> > > > > > I think I disagree with this one.
> > > > > >  * A RAM device represents a mapping to a physical device, such=
 as to a PCI
> > > > > >  * MMIO BAR of an vfio-pci assigned device.  The memory region =
may be mapped
> > > > > >  * into the VM address space and access to the region will modi=
fy memory
> > > > > >  * directly.  However, the memory region should not be included=
 in a memory
> > > > > >  * dump (device may not be enabled/mapped at the time of the du=
mp), and
> > > > > >  * operations incompatible with manipulating MMIO should be avo=
ided.  Replaces
> > > > > >  * skip_dump flag.
> > > > > >=20
> > > > > > Looks like an abuse of notation.
> > > > >=20
> > > > > OK, it did feel a bit like that - any suggestions of another way =
to do
> > > > > it?
> > > > >   This clearly isn't normal RAM.
> > > > >=20
> > > > > Dave
> > > >=20
> > > > If it's just an optimization for vhost/postcopy/etc, then I think
> > >=20
> > > Note it's not an optimisation; postcopy fails unless you can aggregat=
e
> > > the members of the hugepage.
> > > And I think vhost-user will fail if you have too many sections - and
> > > the 16 sections from synic I think will blow the slots available.
> >=20
> > Right, so both are internal reasons.
> >=20
> > > > an API that says how this isn't normal ram would be ok.
> > > > E.g. it's not DMA'd into? Then maybe _nodma?
> > >=20
> > > Do we want a new memory_region_init for that or just to be able to ad=
d
> > > a flag?
> > >=20
> > > Dave
> >=20
> > I think a flag API is preferable since this can apply to any kind of
> > region. But can go either way, Paolo's the maintainer there.
>=20
> (Copying Paolo in)
> So what exactly does this flag mean; to me it's 'no vhost' - but is it
> actually more general?
>=20
> Dave

I think it's also handy for VFIO, that should skip it too.


> > > > > >=20
> > > > > >=20
> > > > > > > ---
> > > > > > >  hw/hyperv/hyperv.c | 14 ++++++++------
> > > > > > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > > > > > > index da8ce82725..4de3ec411d 100644
> > > > > > > --- a/hw/hyperv/hyperv.c
> > > > > > > +++ b/hw/hyperv/hyperv.c
> > > > > > > @@ -95,12 +95,14 @@ static void synic_realize(DeviceState *de=
v, Error **errp)
> > > > > > >      msgp_name =3D g_strdup_printf("synic-%u-msg-page", vp_in=
dex);
> > > > > > >      eventp_name =3D g_strdup_printf("synic-%u-event-page", v=
p_index);
> > > > > > > =20
> > > > > > > -    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_na=
me,
> > > > > > > -                           sizeof(*synic->msg_page), &error_=
abort);
> > > > > > > -    memory_region_init_ram(&synic->event_page_mr, obj, event=
p_name,
> > > > > > > -                           sizeof(*synic->event_page), &erro=
r_abort);
> > > > > > > -    synic->msg_page =3D memory_region_get_ram_ptr(&synic->ms=
g_page_mr);
> > > > > > > -    synic->event_page =3D memory_region_get_ram_ptr(&synic->=
event_page_mr);
> > > > > > > +    synic->msg_page =3D qemu_memalign(qemu_real_host_page_si=
ze,
> > > > > > > +                                    sizeof(*synic->msg_page)=
);
> > > > > > > +    synic->event_page =3D qemu_memalign(qemu_real_host_page_=
size,
> > > > > > > +                                      sizeof(*synic->event_p=
age));
> > > > > > > +    memory_region_init_ram_device_ptr(&synic->msg_page_mr, o=
bj, msgp_name,
> > > > > > > +                           sizeof(*synic->msg_page), synic->=
msg_page);
> > > > > > > +    memory_region_init_ram_device_ptr(&synic->event_page_mr,=
 obj, eventp_name,
> > > > > > > +                           sizeof(*synic->event_page), synic=
->event_page);
> > > > > > > =20
> > > > > > >      g_free(msgp_name);
> > > > > > >      g_free(eventp_name);
> > > > > > > --=20
> > > > > > > 2.24.1
> > > > > >=20
> > > > > --
> > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


