Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F85C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1462075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArNKFCZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1462075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipX9P-0000En-U3
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipX8k-0008GF-9B
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipX8i-00034f-TP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:42:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipX8i-00032L-LZ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578573736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlJm48xguv4dc8SGRiTkHWQvs1yInIM0nfKSbSGNT3Q=;
 b=ArNKFCZ7n5N4yVb0sGGse4dCCykmkFhbh6yPXPqVhhG0oX//Xqz4WCkeorCmHprGQK0z3g
 VL+0iBdc4PpdbiwwSpI/nEobaqnFXdy905ZKBl5MHap3woS78KXLzQWehmT++w0HIIqJcp
 hjATk6ex7hJYz0ENKxlVzPzc14JlyNw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-pRw58sRdNEW5p-ollOaDWQ-1; Thu, 09 Jan 2020 07:42:14 -0500
Received: by mail-qk1-f199.google.com with SMTP id w64so4078428qka.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fmYx+XR2RWwERXVJROcxr69bnCvflFiYm/fBv8yE0KA=;
 b=JMBEjdeTnANLYS2IUoC9tsx3tU+bgpjKVFcVAdhgZPUmph7qc5sRDzDNPVTZ6T5MOq
 uTWNugE8/1S2nbXE2M/1KWhngFgukvBs5Z5xzSH5xw2ChSL9ETRbEBAojMtvlve2Ix0O
 vdL/rR8+wg2v3GpUPSog+7dsfU83BSGsITtm8wtfz9CaEXRptAwWisZJ4kcbg5jGfyQY
 n9/LYSb7UtW6O1iVAKhSXWfBtzasatxyZJgB3fvL6xh9wN+A8vlyfh6+FbhBYtLDt2k2
 EyJ8O6Eq7nM2eGIJR1Zv+KZVu2vbtNPVy6+5urpm9nWTyvQosePf76BgPz+NIuO5+zwE
 d8wg==
X-Gm-Message-State: APjAAAWrlTA7up5k7h+8DV8D7lT0NgunjrLIEdgHyn8SMkRUor7gfq4V
 Odlt3IUD5Aq0vHcs+Fv4CmTFuElycvk5/IZEmo2LrKYDPQnkI6wJJ8urHPNlhMC6UACiTk3GbLy
 2UpOINx3nmmXj3cU=
X-Received: by 2002:ac8:6d33:: with SMTP id r19mr7761906qtu.296.1578573733533; 
 Thu, 09 Jan 2020 04:42:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNSCjGmgKkDjdGRIY5Du8VxHrmTDufnkCvdNZs1B/oVb0EwFQluXsAMUp0aZ1NKCLJa1KqkQ==
X-Received: by 2002:ac8:6d33:: with SMTP id r19mr7761895qtu.296.1578573733363; 
 Thu, 09 Jan 2020 04:42:13 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id e2sm2894695qkb.112.2020.01.09.04.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 04:42:12 -0800 (PST)
Date: Thu, 9 Jan 2020 07:42:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>,
 "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, vkuznets@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 1/2] vhost: Don't pass ram device sections
Message-ID: <20200109073934-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-2-dgilbert@redhat.com>
 <20200109123804.GB3147@rkaganb.sw.ru>
MIME-Version: 1.0
In-Reply-To: <20200109123804.GB3147@rkaganb.sw.ru>
X-MC-Unique: pRw58sRdNEW5p-ollOaDWQ-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 12:38:07PM +0000, Roman Kagan wrote:
> On Wed, Jan 08, 2020 at 01:53:52PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > Don't pass RAM blocks that are marked as ram devices to vhost.
> > There's normally something special about them and they're not
> > normally just shared memory.
>=20
> Does this something special about them, whatever it is, make them
> automatically ineligible for DMA?  Why should vhost ignore them?
> /me goes reading what ram_device memory regions are...
>=20
> Roman.

Well device RAM can be DMA'd into.

But vhost is a host side of virtio as opposed to a random device, we
know what it's doing, so skipping specific areas that we know are of no
interest to virtio devices for performance/internal implementation
reasons is OK.



>=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
> >=20
> >=20


