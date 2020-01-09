Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026E3C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C47820661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtOEQNHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C47820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXwl-0004Ar-S7
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipXs1-00083w-0J
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipXrz-0004bX-MC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:29:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipXrz-0004YZ-Fq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578576543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E68TJ8rWITjjiaBJJc5XuslLPDBIEp5U0tkqgeeGKxQ=;
 b=VtOEQNHUGERX94Ow3Ahv2FT2o2i7BrCjR28fptmfVpi5mlekFGb7jEMu8jpkWsA96RdlBH
 b1kHqgNJM9AKotqrvmtwtBEZD6hv+0/vNZOVbhLM6TroKJf6yIB9Wt0BHtC50QXzfQjKiD
 m/5FEjYblxHL2kb4IYxPk/DeGHHghTY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-vfaqvg5KP-WHUuGtTHVJKQ-1; Thu, 09 Jan 2020 08:29:01 -0500
Received: by mail-qk1-f198.google.com with SMTP id l7so4135608qke.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 05:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sjmmxkvKxcjM6ok/EDV0lcsbkqIErywnQJzOv7IalM0=;
 b=Pg2OBGBk2mJwGHIwbGDOMaUnD5K86qhRJ1bwE6nCoEaNGQwiOV7JMUsLuJr0pQ6+Ti
 SSny5wBKrkyP+E7zZnJqX2syYZlqDXtXu5R4LVc809iHqOoOkLJXlQNc/0iulXrD2s4F
 akjZPAVbyWibhUW9M+Ff+Frby2Hq7RF4i//NGC8to8Rw7nGoq5R7xWVX/ZjIPq2yseKs
 kunyQyt9nnDND2Y5wP4EsOKdkbHvZAU3doGonyd2j1XtHjq4hsrFVV6DAoqOAhKInMzH
 sCbkbsR0gKCEAOsh1HS6npIfNYBULnp2VfcjtAo54Ok1ePqhvmWY2ZOE/cJztXUBrdGa
 nZlw==
X-Gm-Message-State: APjAAAXgG1Ly34hOky7HbqHXWwvz9bzbQFb36p12pFaxkUhPGeO1Ahxj
 oQrbChkFckiV0n6KJJfkbBsYc+JAjS4rTtzLJV22skR4Y5bZMQEYV+CBfgpo0XlImP/z+fkiw4v
 hzeZq/8dcoDjp5LY=
X-Received: by 2002:ae9:eb56:: with SMTP id b83mr9193385qkg.123.1578576540933; 
 Thu, 09 Jan 2020 05:29:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1xWlckw2Y/q0wvWQ08z+HEvijPyjHGgzdmcy87ohfGu5ykoieOGrmF6rYBLjmjTpTON/4qA==
X-Received: by 2002:ae9:eb56:: with SMTP id b83mr9193356qkg.123.1578576540701; 
 Thu, 09 Jan 2020 05:29:00 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id b42sm3385141qtb.36.2020.01.09.05.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 05:29:00 -0800 (PST)
Date: Thu, 9 Jan 2020 08:28:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109082810-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <20200109080412-mutt-send-email-mst@kernel.org>
 <20200109132242.GF6795@work-vm>
 <20200109082726-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200109082726-mutt-send-email-mst@kernel.org>
X-MC-Unique: vfaqvg5KP-WHUuGtTHVJKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Thu, Jan 09, 2020 at 08:28:00AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2020 at 01:22:42PM +0000, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Thu, Jan 09, 2020 at 12:22:37PM +0000, Dr. David Alan Gilbert wrot=
e:
> > > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > > On Thu, Jan 09, 2020 at 12:08:20PM +0000, Dr. David Alan Gilbert =
wrote:
> > > > > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > > > > On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gilb=
ert (git) wrote:
> > > > > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > > > >=20
> > > > > > > > Mark the synic pages as ram_device so that they won't be vi=
sible
> > > > > > > > to vhost.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > > >=20
> > > > > > >=20
> > > > > > > I think I disagree with this one.
> > > > > > >  * A RAM device represents a mapping to a physical device, su=
ch as to a PCI
> > > > > > >  * MMIO BAR of an vfio-pci assigned device.  The memory regio=
n may be mapped
> > > > > > >  * into the VM address space and access to the region will mo=
dify memory
> > > > > > >  * directly.  However, the memory region should not be includ=
ed in a memory
> > > > > > >  * dump (device may not be enabled/mapped at the time of the =
dump), and
> > > > > > >  * operations incompatible with manipulating MMIO should be a=
voided.  Replaces
> > > > > > >  * skip_dump flag.
> > > > > > >=20
> > > > > > > Looks like an abuse of notation.
> > > > > >=20
> > > > > > OK, it did feel a bit like that - any suggestions of another wa=
y to do
> > > > > > it?
> > > > > >   This clearly isn't normal RAM.
> > > > > >=20
> > > > > > Dave
> > > > >=20
> > > > > If it's just an optimization for vhost/postcopy/etc, then I think
> > > >=20
> > > > Note it's not an optimisation; postcopy fails unless you can aggreg=
ate
> > > > the members of the hugepage.
> > > > And I think vhost-user will fail if you have too many sections - an=
d
> > > > the 16 sections from synic I think will blow the slots available.
> > >=20
> > > Right, so both are internal reasons.
> > >=20
> > > > > an API that says how this isn't normal ram would be ok.
> > > > > E.g. it's not DMA'd into? Then maybe _nodma?
> > > >=20
> > > > Do we want a new memory_region_init for that or just to be able to =
add
> > > > a flag?
> > > >=20
> > > > Dave
> > >=20
> > > I think a flag API is preferable since this can apply to any kind of
> > > region. But can go either way, Paolo's the maintainer there.
> >=20
> > (Copying Paolo in)
> > So what exactly does this flag mean; to me it's 'no vhost' - but is it
> > actually more general?
> >=20
> > Dave
>=20
> I think it's also handy for VFIO, that should skip it too.

BTW if it's "per cpu" then that is another way to put it.
Neither vfio nor vhost have a concept of cpu so neither
can support accessing per cpu things.

>=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > > ---
> > > > > > > >  hw/hyperv/hyperv.c | 14 ++++++++------
> > > > > > > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > > > > > > > index da8ce82725..4de3ec411d 100644
> > > > > > > > --- a/hw/hyperv/hyperv.c
> > > > > > > > +++ b/hw/hyperv/hyperv.c
> > > > > > > > @@ -95,12 +95,14 @@ static void synic_realize(DeviceState *=
dev, Error **errp)
> > > > > > > >      msgp_name =3D g_strdup_printf("synic-%u-msg-page", vp_=
index);
> > > > > > > >      eventp_name =3D g_strdup_printf("synic-%u-event-page",=
 vp_index);
> > > > > > > > =20
> > > > > > > > -    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_=
name,
> > > > > > > > -                           sizeof(*synic->msg_page), &erro=
r_abort);
> > > > > > > > -    memory_region_init_ram(&synic->event_page_mr, obj, eve=
ntp_name,
> > > > > > > > -                           sizeof(*synic->event_page), &er=
ror_abort);
> > > > > > > > -    synic->msg_page =3D memory_region_get_ram_ptr(&synic->=
msg_page_mr);
> > > > > > > > -    synic->event_page =3D memory_region_get_ram_ptr(&synic=
->event_page_mr);
> > > > > > > > +    synic->msg_page =3D qemu_memalign(qemu_real_host_page_=
size,
> > > > > > > > +                                    sizeof(*synic->msg_pag=
e));
> > > > > > > > +    synic->event_page =3D qemu_memalign(qemu_real_host_pag=
e_size,
> > > > > > > > +                                      sizeof(*synic->event=
_page));
> > > > > > > > +    memory_region_init_ram_device_ptr(&synic->msg_page_mr,=
 obj, msgp_name,
> > > > > > > > +                           sizeof(*synic->msg_page), synic=
->msg_page);
> > > > > > > > +    memory_region_init_ram_device_ptr(&synic->event_page_m=
r, obj, eventp_name,
> > > > > > > > +                           sizeof(*synic->event_page), syn=
ic->event_page);
> > > > > > > > =20
> > > > > > > >      g_free(msgp_name);
> > > > > > > >      g_free(eventp_name);
> > > > > > > > --=20
> > > > > > > > 2.24.1
> > > > > > >=20
> > > > > > --
> > > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > > >=20
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


