Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F650C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EE12067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyqVy72p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EE12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWnC-00057h-D5
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipWmD-0004IG-Cl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipWm8-0003VH-1v
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:19:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipWm7-0003In-Ry
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578572327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ARbvq5wr38xNC46kub6l3CCjGb6VDq7WsqV0h95/EU=;
 b=NyqVy72pNOChjAkWgB+EvcahI4pNtilFZkeO5/L05+IX0qZJRpxr13v+rbkTVQMKEjMLml
 J8/rKd1X39+T4Di3bqB81iN+i0Vn9MxSDwxb/sDIUP/M3K0j7AgPf13+Z4IONYXYv1UG0s
 DiF1JKKZYz7B7xiHEySDBTFcgEZT67A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-zRWoMG06NmGfi9R2BImNxg-1; Thu, 09 Jan 2020 07:18:44 -0500
Received: by mail-qt1-f200.google.com with SMTP id m15so3423868qtc.18
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CG7nvEiVNNhnpwoKxyRwbejigqggW/6aFZWQMAaES7Q=;
 b=TtoJe65sV+Z8Jdxt4DXhEU83QDpf+bhJdHoSVnTJvXa46jURnqLMTT/0gZ+ALKDT6n
 B2HqVYfwxka4l1zUvINUCrxEccobXYH2v50zSFno12vdMx18TSLcglCR5MbyYmLfLndv
 KowMbnA7ULpi+o6D2KS2/GIox5IElkhJV6Akt/EYXRlvkWbyZd2+cLkc1QVerUbRLT9x
 vwhWQ4omcUL2Uf+G5xvrSeAOipOYqklucQ7OHBiHGrHkj5T6rw2Lbx5u0EYR+mESowmz
 H5XxR838glA7bNSFjD03KJEIKVgoA/+ApBEw38FqeZUxNAfFKbtU+cawvOV5pV5ciJA3
 d4MA==
X-Gm-Message-State: APjAAAVwbwf+V37slvWzPVnPlzCuM09fz3oZuFSQ3hU1BCghK+Cv2vDS
 PK79jXCTxZkaTniavG8K74IYZFmEUlqZTMoWUWx+w1T3eSUxJ8f7MOVVUEcewuIbSkT/2g77v7d
 459ls0Sy1hYi0abE=
X-Received: by 2002:a05:620a:1116:: with SMTP id
 o22mr9336461qkk.190.1578572324343; 
 Thu, 09 Jan 2020 04:18:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqy88TWofw5AHRezgYd6V9TIcvl5PnTuwQs8KDqB0D1iBdA13mUowr5/uVexa42tvZkpLy/I9w==
X-Received: by 2002:a05:620a:1116:: with SMTP id
 o22mr9336438qkk.190.1578572324093; 
 Thu, 09 Jan 2020 04:18:44 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id z12sm2431277qts.97.2020.01.09.04.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 04:18:43 -0800 (PST)
Date: Thu, 9 Jan 2020 07:18:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109071454-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200109120820.GB6795@work-vm>
X-MC-Unique: zRWoMG06NmGfi9R2BImNxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Thu, Jan 09, 2020 at 12:08:20PM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Wed, Jan 08, 2020 at 01:53:53PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > Mark the synic pages as ram_device so that they won't be visible
> > > to vhost.
> > >=20
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
> >=20
> > I think I disagree with this one.
> >  * A RAM device represents a mapping to a physical device, such as to a=
 PCI
> >  * MMIO BAR of an vfio-pci assigned device.  The memory region may be m=
apped
> >  * into the VM address space and access to the region will modify memor=
y
> >  * directly.  However, the memory region should not be included in a me=
mory
> >  * dump (device may not be enabled/mapped at the time of the dump), and
> >  * operations incompatible with manipulating MMIO should be avoided.  R=
eplaces
> >  * skip_dump flag.
> >=20
> > Looks like an abuse of notation.
>=20
> OK, it did feel a bit like that - any suggestions of another way to do
> it?
>   This clearly isn't normal RAM.
>=20
> Dave

If it's just an optimization for vhost/postcopy/etc, then I think
an API that says how this isn't normal ram would be ok.
E.g. it's not DMA'd into? Then maybe _nodma?

> >=20
> >=20
> > > ---
> > >  hw/hyperv/hyperv.c | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > > index da8ce82725..4de3ec411d 100644
> > > --- a/hw/hyperv/hyperv.c
> > > +++ b/hw/hyperv/hyperv.c
> > > @@ -95,12 +95,14 @@ static void synic_realize(DeviceState *dev, Error=
 **errp)
> > >      msgp_name =3D g_strdup_printf("synic-%u-msg-page", vp_index);
> > >      eventp_name =3D g_strdup_printf("synic-%u-event-page", vp_index)=
;
> > > =20
> > > -    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
> > > -                           sizeof(*synic->msg_page), &error_abort);
> > > -    memory_region_init_ram(&synic->event_page_mr, obj, eventp_name,
> > > -                           sizeof(*synic->event_page), &error_abort)=
;
> > > -    synic->msg_page =3D memory_region_get_ram_ptr(&synic->msg_page_m=
r);
> > > -    synic->event_page =3D memory_region_get_ram_ptr(&synic->event_pa=
ge_mr);
> > > +    synic->msg_page =3D qemu_memalign(qemu_real_host_page_size,
> > > +                                    sizeof(*synic->msg_page));
> > > +    synic->event_page =3D qemu_memalign(qemu_real_host_page_size,
> > > +                                      sizeof(*synic->event_page));
> > > +    memory_region_init_ram_device_ptr(&synic->msg_page_mr, obj, msgp=
_name,
> > > +                           sizeof(*synic->msg_page), synic->msg_page=
);
> > > +    memory_region_init_ram_device_ptr(&synic->event_page_mr, obj, ev=
entp_name,
> > > +                           sizeof(*synic->event_page), synic->event_=
page);
> > > =20
> > >      g_free(msgp_name);
> > >      g_free(eventp_name);
> > > --=20
> > > 2.24.1
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


