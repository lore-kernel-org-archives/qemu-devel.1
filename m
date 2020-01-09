Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA51C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B282072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWoyfZ+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B282072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWqV-0000GJ-8t
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipWpr-0008HT-DE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipWpq-00018y-6w
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:22:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipWpp-00015O-WE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578572565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5uGCmrazb5NhtNHdPjTTqR8GPLYmFi+F5u7uMvUv7wg=;
 b=QWoyfZ+0hMJx8qYWUM6DsAKrQAFWFWs/n1XYCC8+HA7nvuzcwgB+n/WKx9gMTRH7OwooVH
 huAykFgWHJpOJlxEEYkuODoS2OrxBNkvR1bIlPYiCpUW87h6cromoEnDvZUcWsKaDp8NWF
 UBKxc7cFuNGC46ZGTl0AU4kck4M79uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-MDWmkDESP3qPsyVbb-k-wg-1; Thu, 09 Jan 2020 07:22:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D4E801E6C
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 12:22:43 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B26660BE0;
 Thu,  9 Jan 2020 12:22:39 +0000 (UTC)
Date: Thu, 9 Jan 2020 12:22:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109122237.GD6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200109071454-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MDWmkDESP3qPsyVbb-k-wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, Jan 09, 2020 at 12:08:20PM +0000, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gilbert (git=
) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > >=20
> > > > Mark the synic pages as ram_device so that they won't be visible
> > > > to vhost.
> > > >=20
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > >=20
> > >=20
> > > I think I disagree with this one.
> > >  * A RAM device represents a mapping to a physical device, such as to=
 a PCI
> > >  * MMIO BAR of an vfio-pci assigned device.  The memory region may be=
 mapped
> > >  * into the VM address space and access to the region will modify mem=
ory
> > >  * directly.  However, the memory region should not be included in a =
memory
> > >  * dump (device may not be enabled/mapped at the time of the dump), a=
nd
> > >  * operations incompatible with manipulating MMIO should be avoided. =
 Replaces
> > >  * skip_dump flag.
> > >=20
> > > Looks like an abuse of notation.
> >=20
> > OK, it did feel a bit like that - any suggestions of another way to do
> > it?
> >   This clearly isn't normal RAM.
> >=20
> > Dave
>=20
> If it's just an optimization for vhost/postcopy/etc, then I think

Note it's not an optimisation; postcopy fails unless you can aggregate
the members of the hugepage.
And I think vhost-user will fail if you have too many sections - and
the 16 sections from synic I think will blow the slots available.

> an API that says how this isn't normal ram would be ok.
> E.g. it's not DMA'd into? Then maybe _nodma?

Do we want a new memory_region_init for that or just to be able to add
a flag?

Dave

> > >=20
> > >=20
> > > > ---
> > > >  hw/hyperv/hyperv.c | 14 ++++++++------
> > > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > > > index da8ce82725..4de3ec411d 100644
> > > > --- a/hw/hyperv/hyperv.c
> > > > +++ b/hw/hyperv/hyperv.c
> > > > @@ -95,12 +95,14 @@ static void synic_realize(DeviceState *dev, Err=
or **errp)
> > > >      msgp_name =3D g_strdup_printf("synic-%u-msg-page", vp_index);
> > > >      eventp_name =3D g_strdup_printf("synic-%u-event-page", vp_inde=
x);
> > > > =20
> > > > -    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
> > > > -                           sizeof(*synic->msg_page), &error_abort)=
;
> > > > -    memory_region_init_ram(&synic->event_page_mr, obj, eventp_name=
,
> > > > -                           sizeof(*synic->event_page), &error_abor=
t);
> > > > -    synic->msg_page =3D memory_region_get_ram_ptr(&synic->msg_page=
_mr);
> > > > -    synic->event_page =3D memory_region_get_ram_ptr(&synic->event_=
page_mr);
> > > > +    synic->msg_page =3D qemu_memalign(qemu_real_host_page_size,
> > > > +                                    sizeof(*synic->msg_page));
> > > > +    synic->event_page =3D qemu_memalign(qemu_real_host_page_size,
> > > > +                                      sizeof(*synic->event_page));
> > > > +    memory_region_init_ram_device_ptr(&synic->msg_page_mr, obj, ms=
gp_name,
> > > > +                           sizeof(*synic->msg_page), synic->msg_pa=
ge);
> > > > +    memory_region_init_ram_device_ptr(&synic->event_page_mr, obj, =
eventp_name,
> > > > +                           sizeof(*synic->event_page), synic->even=
t_page);
> > > > =20
> > > >      g_free(msgp_name);
> > > >      g_free(eventp_name);
> > > > --=20
> > > > 2.24.1
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


