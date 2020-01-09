Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F5C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64D720656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXLe4m1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64D720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWQx-0007Aq-QE
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipWQM-0006kq-L7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipWQK-0006kM-DE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:56:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54373
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipWQJ-0006dX-Tl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578570982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gr7Zu57W7vw7syJ/SYOw3sC+LRcrtqM+Z4fZCFOx98Q=;
 b=aXLe4m1zbSopbd2EYUYUmPXsew4XyzeXtabUKfRaf6msDkZcS/+fDvBJDHuL+uWRPatQkS
 NqaX4jSi6zZC0FYPqJPAgypMn9TqSGeaI/6LSY/YclMirwMaRyEKBEkAheiR3ggBfPnclp
 QXXjHu2bep+jnrGqSc3P74Zc61a3snI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-jYJ1BXx_M6yR3ECEREALsA-1; Thu, 09 Jan 2020 06:56:21 -0500
Received: by mail-qv1-f69.google.com with SMTP id u11so3947192qvo.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dzykgoKa+jCMwIc4a2Dj7KCnwh6lV0TwHchGPdYnZSg=;
 b=ndtfqlNEAF7qMGNifAoh2rkBArb8ZMHe1w7f4yPVbOwQvNQiGiAolPsc4mciC7wlZv
 tzBGMWeVr2Jk8HrdpKBL6aNS4uhjEKtxDXHpmgknnDZm24AXK0z8y3X2bs74/iRjF307
 QuuN3TqTv10eHw2WTlvNYbct4vt9lYjXDypF/Vz/HPdolho5UvdMUy+VQVWLyb1RkYq/
 o23AMdBNe/cn67SEDP5AiXYUqowj30I1VfQlhInMtutR/Mv+4MfABROU4O0E9tkpP/HR
 iNnm0cYJ0rJ6DtC8h03F15/MjBBAyvWdPwgQydvMcxkoZECastbXOWy3g7e3ffXI6sY0
 LcQg==
X-Gm-Message-State: APjAAAUanMZjPSg52fgkhGHeIMIRToR2kIMNc9AXRxcqNKa4LqgYUzZk
 3V3y2oLKp5n4x2CYp7uc4N2jcnq9TLSQIRROuWBNvteRhm5+tqLUKS+ZHVOvaBZtP42gVqnHrC4
 6g7Bm0uC46o4ls2A=
X-Received: by 2002:ac8:33ab:: with SMTP id c40mr7704868qtb.250.1578570981210; 
 Thu, 09 Jan 2020 03:56:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVzXjAkD5ECSUDt70KwcQtSnkj+tfUfskjwukHTzYK7HpNRPisRtv686ljOCeqvEI9DNA5bw==
X-Received: by 2002:ac8:33ab:: with SMTP id c40mr7704856qtb.250.1578570981044; 
 Thu, 09 Jan 2020 03:56:21 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id i28sm3244846qtc.57.2020.01.09.03.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:56:20 -0800 (PST)
Date: Thu, 9 Jan 2020 06:56:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] vhost: Don't pass ram device sections
Message-ID: <20200109064815-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-2-dgilbert@redhat.com>
 <20200109064425-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200109064425-mutt-send-email-mst@kernel.org>
X-MC-Unique: jYJ1BXx_M6yR3ECEREALsA-1
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

On Thu, Jan 09, 2020 at 06:45:24AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 08, 2020 at 01:53:52PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Don't pass RAM blocks that are marked as ram devices to vhost.
> > There's normally something special about them and they're not
> > normally just shared memory.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> So I think this is good by itself.

Hmm second thoughts.
vhost kernel can handle any pointer.
And what we care about for vhost-user is that
memory_region_get_fd
gives us an fd.

So why does it matter that there's something special
about it? I worry that this will break things like
pass through of virtio-pmem for nested virt.


> > ---
> >  hw/virtio/vhost.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 4da0d5a6c5..c81f0be71b 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -402,6 +402,7 @@ static bool vhost_section(struct vhost_dev *dev, Me=
moryRegionSection *section)
> >      bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
> >                       ~(1 << DIRTY_MEMORY_MIGRATION);
> >      result =3D memory_region_is_ram(section->mr) &&
> > +        !memory_region_is_ram_device(section->mr) &&
> >          !memory_region_is_rom(section->mr);
> > =20
> >      /* Vhost doesn't handle any block which is doing dirty-tracking ot=
her
> > --=20
> > 2.24.1


