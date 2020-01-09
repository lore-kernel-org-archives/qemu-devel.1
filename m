Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547C2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA5520661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BV9jFkni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA5520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipY47-0005Oe-4J
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipY3K-0004Zu-S9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipY3I-0004Yy-AV
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51407
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipY3H-0004Vy-1W
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578577241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eeEwmEw42dqTy8R+7InpdtRvVQ9bBEs/nK5IY/kQ7TM=;
 b=BV9jFkniIoLMuZBL1CbOn9++kFjt4zaatWqe1MrynL3YL/u2rOP8JwxFeaVEufmVajwIcm
 VPLv0y2LhcMZl2t+dc2Dv4+c9bQNUBKbjXKEhZSY9fSsgcjExn3KC1HpjmY927qhPKcrC8
 Vqs4j+v2Tc4Su8nu0CKs590s1OaIJzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-rDXvTp8GMk2y8T9r5rj8pg-1; Thu, 09 Jan 2020 08:40:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5A1C10054E3
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 13:40:39 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 850EE1000322;
 Thu,  9 Jan 2020 13:40:35 +0000 (UTC)
Date: Thu, 9 Jan 2020 13:40:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109134033.GH6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <20200109080412-mutt-send-email-mst@kernel.org>
 <20200109132242.GF6795@work-vm>
 <20200109082726-mutt-send-email-mst@kernel.org>
 <20200109082810-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200109082810-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rDXvTp8GMk2y8T9r5rj8pg-1
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

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, Jan 09, 2020 at 08:28:00AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2020 at 01:22:42PM +0000, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > On Thu, Jan 09, 2020 at 12:22:37PM +0000, Dr. David Alan Gilbert wr=
ote:
> > > > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > > > On Thu, Jan 09, 2020 at 12:08:20PM +0000, Dr. David Alan Gilber=
t wrote:
> > > > > > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > > > > > On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gi=
lbert (git) wrote:
> > > > > > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > > > > >=20
> > > > > > > > > Mark the synic pages as ram_device so that they won't be =
visible
> > > > > > > > > to vhost.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.co=
m>
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I think I disagree with this one.
> > > > > > > >  * A RAM device represents a mapping to a physical device, =
such as to a PCI
> > > > > > > >  * MMIO BAR of an vfio-pci assigned device.  The memory reg=
ion may be mapped
> > > > > > > >  * into the VM address space and access to the region will =
modify memory
> > > > > > > >  * directly.  However, the memory region should not be incl=
uded in a memory
> > > > > > > >  * dump (device may not be enabled/mapped at the time of th=
e dump), and
> > > > > > > >  * operations incompatible with manipulating MMIO should be=
 avoided.  Replaces
> > > > > > > >  * skip_dump flag.
> > > > > > > >=20
> > > > > > > > Looks like an abuse of notation.
> > > > > > >=20
> > > > > > > OK, it did feel a bit like that - any suggestions of another =
way to do
> > > > > > > it?
> > > > > > >   This clearly isn't normal RAM.
> > > > > > >=20
> > > > > > > Dave
> > > > > >=20
> > > > > > If it's just an optimization for vhost/postcopy/etc, then I thi=
nk
> > > > >=20
> > > > > Note it's not an optimisation; postcopy fails unless you can aggr=
egate
> > > > > the members of the hugepage.
> > > > > And I think vhost-user will fail if you have too many sections - =
and
> > > > > the 16 sections from synic I think will blow the slots available.
> > > >=20
> > > > Right, so both are internal reasons.
> > > >=20
> > > > > > an API that says how this isn't normal ram would be ok.
> > > > > > E.g. it's not DMA'd into? Then maybe _nodma?
> > > > >=20
> > > > > Do we want a new memory_region_init for that or just to be able t=
o add
> > > > > a flag?
> > > > >=20
> > > > > Dave
> > > >=20
> > > > I think a flag API is preferable since this can apply to any kind o=
f
> > > > region. But can go either way, Paolo's the maintainer there.
> > >=20
> > > (Copying Paolo in)
> > > So what exactly does this flag mean; to me it's 'no vhost' - but is i=
t
> > > actually more general?
> > >=20
> > > Dave
> >=20
> > I think it's also handy for VFIO, that should skip it too.
>=20
> BTW if it's "per cpu" then that is another way to put it.
> Neither vfio nor vhost have a concept of cpu so neither
> can support accessing per cpu things.

In this case it's not really per-cpu in that sense; there's one of these
regions per cpu, but I think each region is mapped by all cpus.

Dave

> >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > ---
> > > > > > > > >  hw/hyperv/hyperv.c | 14 ++++++++------
> > > > > > > > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > > > > > > > > index da8ce82725..4de3ec411d 100644
> > > > > > > > > --- a/hw/hyperv/hyperv.c
> > > > > > > > > +++ b/hw/hyperv/hyperv.c
> > > > > > > > > @@ -95,12 +95,14 @@ static void synic_realize(DeviceState=
 *dev, Error **errp)
> > > > > > > > >      msgp_name =3D g_strdup_printf("synic-%u-msg-page", v=
p_index);
> > > > > > > > >      eventp_name =3D g_strdup_printf("synic-%u-event-page=
", vp_index);
> > > > > > > > > =20
> > > > > > > > > -    memory_region_init_ram(&synic->msg_page_mr, obj, msg=
p_name,
> > > > > > > > > -                           sizeof(*synic->msg_page), &er=
ror_abort);
> > > > > > > > > -    memory_region_init_ram(&synic->event_page_mr, obj, e=
ventp_name,
> > > > > > > > > -                           sizeof(*synic->event_page), &=
error_abort);
> > > > > > > > > -    synic->msg_page =3D memory_region_get_ram_ptr(&synic=
->msg_page_mr);
> > > > > > > > > -    synic->event_page =3D memory_region_get_ram_ptr(&syn=
ic->event_page_mr);
> > > > > > > > > +    synic->msg_page =3D qemu_memalign(qemu_real_host_pag=
e_size,
> > > > > > > > > +                                    sizeof(*synic->msg_p=
age));
> > > > > > > > > +    synic->event_page =3D qemu_memalign(qemu_real_host_p=
age_size,
> > > > > > > > > +                                      sizeof(*synic->eve=
nt_page));
> > > > > > > > > +    memory_region_init_ram_device_ptr(&synic->msg_page_m=
r, obj, msgp_name,
> > > > > > > > > +                           sizeof(*synic->msg_page), syn=
ic->msg_page);
> > > > > > > > > +    memory_region_init_ram_device_ptr(&synic->event_page=
_mr, obj, eventp_name,
> > > > > > > > > +                           sizeof(*synic->event_page), s=
ynic->event_page);
> > > > > > > > > =20
> > > > > > > > >      g_free(msgp_name);
> > > > > > > > >      g_free(eventp_name);
> > > > > > > > > --=20
> > > > > > > > > 2.24.1
> > > > > > > >=20
> > > > > > > --
> > > > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > > > >=20
> > > > > --
> > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


