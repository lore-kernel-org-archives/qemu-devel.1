Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0981C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8961824688
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMh3kD+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8961824688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MgZ-0000Uh-Ql
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7Mfn-0008Nb-Vm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7Mfm-0002NB-Iq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:10:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55381
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7Mfm-0002N2-El
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582823405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEYk2/dbUdT3xIinsoxoEKMLfiNgu+B1rBwjY1EWgZc=;
 b=DMh3kD+3NFgs4/K16yx35Zngt+bAA0+4aNPk58Q1JviqZt5PupJMZid3um4FVJrR3ImDCK
 wWQlRjMV22UvVT6u9Z6bNxkQW1x6QCBqvkFP7sYTRORg4zJNuW+ZpFtd/eAx/JWA3yienN
 UjphwuqqypS+MZ5pv2rLfQ4kHaSZKAA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-LFWjHvcOOYuvWu79djcytg-1; Thu, 27 Feb 2020 12:10:03 -0500
X-MC-Unique: LFWjHvcOOYuvWu79djcytg-1
Received: by mail-qt1-f198.google.com with SMTP id p12so7186qtu.6
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2vbdWQapmZamSeF+bJL8aB7iMEyP5e3Iv1xyHMVrcOM=;
 b=kvurKSDPnYJbmXejgY2ALnrvy1469WxIXdAnEKAYNMdPJegAt/V4vPf17dgZC+zQGw
 Yt9Rpo5s99rWTg2JbctDj2m+Lrs7BhF6hn099cqakz7NyxW2D6L3JHcIlfLqNM3i2+l1
 amklCC4lpAY9edbBbT0qnCFLJeBJU+2tOihYhTNAvVYfmzz5bKJ5SFfOEVtywqtuEaN2
 buFrcDRdmASKoaHETqeRCxzIXllmYQA8258ef4HQbDOugkDSqtnkTIRB6VBMe5O+JIaQ
 KyKECZBh4cqS9QBE7ZfNRGfQ5JQc4KeH31R9wRPWYIwQkol5iQRz7QQkuN5A14WkhYoC
 IA+g==
X-Gm-Message-State: APjAAAWQFnQinhGE6rzCu46lzp5Q6FDz/6OBmFJ3k/jN7MBkZFztRlC/
 qTJlF+yex8YE/QZYxn6tiXZV1UEysxfrCGwngxK1geaSB6MYkuc9MDeIhQRTbu+LEz8gvr+iWmv
 rFU2m1h/DreXx4js=
X-Received: by 2002:a05:620a:2103:: with SMTP id
 l3mr267578qkl.90.1582823403027; 
 Thu, 27 Feb 2020 09:10:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/v6ssdiNhxeOfyTr1qqMPtkqxdnPTkVXMHAabIgGT+YBOTsCr//LsNdDejSggKqWyXUU81A==
X-Received: by 2002:a05:620a:2103:: with SMTP id
 l3mr267553qkl.90.1582823402768; 
 Thu, 27 Feb 2020 09:10:02 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id j30sm3368229qki.96.2020.02.27.09.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 09:10:02 -0800 (PST)
Date: Thu, 27 Feb 2020 12:10:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 1/5] vfio/pci: Disable INTx fast path if using split
 irqchip
Message-ID: <20200227171001.GH180973@xz-x1>
References: <20200226225048.216508-1-peterx@redhat.com>
 <20200226225048.216508-2-peterx@redhat.com>
 <59815cf7-7fb8-faf6-4bb8-5376c87aa684@redhat.com>
MIME-Version: 1.0
In-Reply-To: <59815cf7-7fb8-faf6-4bb8-5376c87aa684@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 05:53:32PM +0100, Auger Eric wrote:
> Hi Peter,
>=20
> On 2/26/20 11:50 PM, Peter Xu wrote:
> > It's currently broken.  Let's use the slow path to at least make it
> > functional.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> > ---
> >  hw/vfio/pci.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 5e75a95129..98e0e0c994 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -128,6 +128,18 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vd=
ev, Error **errp)
> >          return;
> >      }
> > =20
> > +    if (kvm_irqchip_is_split()) {
> > +        /*
> > +         * VFIO INTx is currently not working with split kernel
> > +         * irqchip for level triggered interrupts.  Go the slow path
> > +         * as long as split is enabled so we can be at least
> > +         * functional (even with poor performance).
> > +         *
> > +         * TODO: Remove this after all things fixed up.
> If this patch were to be applied sooner than the other patches as
> suggested in the cover letter, We may emit a warning message saying that
> slow path is selected due to split irqchip and this will induce perf
> downgrade

Yes we can.  Here I followed the rest of the cases where we'll
silently fallback to slow path if e.g. we used an even older kernel
that does not support resamplefd at all.  IMHO it's the same as that
(feature not supported yet, silent fallback, just in case it scares
the user a bit, which makes some sense).

> > +         */
> > +        return;
> > +    }
> > +
> >      /* Get to a known interrupt state */
> >      qemu_set_fd_handler(irqfd.fd, NULL, NULL, vdev);
> >      vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX=
);
> >=20
>=20
>=20
> Tested with a 5.2-rc1 kernel with reverted "654f1f13ea56  kvm: Check
> irqchip mode before assign irqfd" and guest booting with nomsi.
>=20
> Without this patch the assigned NIC does not work. This patch fixes the
> issue.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks Eric!

--=20
Peter Xu


