Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43992C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F35B2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBOjwW9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F35B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWdQ-00039T-2K
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipWc4-00025E-P8
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipWc2-0004hS-74
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:08:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipWc2-0004dG-23
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578571709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ED7XSBQ45eTsIGI8SCbNh0PxXfKdZEEwXOD4GbBljmg=;
 b=IBOjwW9/pX+liWQEuz947j3X4OO7pQJ+U1o8Mceus+/VYp3auRK3Q0lwmJtc5ApKZqUUaq
 jBRwbdDuRwMPoTnOrRQwiSAxUUDQ0b23ZcNyu1ZhVIANCkUiVVVTxgZFUtvheLtrsQK04o
 PrvAltB56Gf1CRhnj/G5bK1dncyyjUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-yFJaVQM8Np6Q3aNDPGRa7w-1; Thu, 09 Jan 2020 07:08:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B273581E62F
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 12:08:26 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABC875DA66;
 Thu,  9 Jan 2020 12:08:23 +0000 (UTC)
Date: Thu, 9 Jan 2020 12:08:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109120820.GB6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200109064527-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: yFJaVQM8Np6Q3aNDPGRa7w-1
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

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Mark the synic pages as ram_device so that they won't be visible
> > to vhost.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
>=20
> I think I disagree with this one.
>  * A RAM device represents a mapping to a physical device, such as to a P=
CI
>  * MMIO BAR of an vfio-pci assigned device.  The memory region may be map=
ped
>  * into the VM address space and access to the region will modify memory
>  * directly.  However, the memory region should not be included in a memo=
ry
>  * dump (device may not be enabled/mapped at the time of the dump), and
>  * operations incompatible with manipulating MMIO should be avoided.  Rep=
laces
>  * skip_dump flag.
>=20
> Looks like an abuse of notation.

OK, it did feel a bit like that - any suggestions of another way to do
it?
  This clearly isn't normal RAM.

Dave

>=20
>=20
> > ---
> >  hw/hyperv/hyperv.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > index da8ce82725..4de3ec411d 100644
> > --- a/hw/hyperv/hyperv.c
> > +++ b/hw/hyperv/hyperv.c
> > @@ -95,12 +95,14 @@ static void synic_realize(DeviceState *dev, Error *=
*errp)
> >      msgp_name =3D g_strdup_printf("synic-%u-msg-page", vp_index);
> >      eventp_name =3D g_strdup_printf("synic-%u-event-page", vp_index);
> > =20
> > -    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
> > -                           sizeof(*synic->msg_page), &error_abort);
> > -    memory_region_init_ram(&synic->event_page_mr, obj, eventp_name,
> > -                           sizeof(*synic->event_page), &error_abort);
> > -    synic->msg_page =3D memory_region_get_ram_ptr(&synic->msg_page_mr)=
;
> > -    synic->event_page =3D memory_region_get_ram_ptr(&synic->event_page=
_mr);
> > +    synic->msg_page =3D qemu_memalign(qemu_real_host_page_size,
> > +                                    sizeof(*synic->msg_page));
> > +    synic->event_page =3D qemu_memalign(qemu_real_host_page_size,
> > +                                      sizeof(*synic->event_page));
> > +    memory_region_init_ram_device_ptr(&synic->msg_page_mr, obj, msgp_n=
ame,
> > +                           sizeof(*synic->msg_page), synic->msg_page);
> > +    memory_region_init_ram_device_ptr(&synic->event_page_mr, obj, even=
tp_name,
> > +                           sizeof(*synic->event_page), synic->event_pa=
ge);
> > =20
> >      g_free(msgp_name);
> >      g_free(eventp_name);
> > --=20
> > 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


