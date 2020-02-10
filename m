Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B2C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21AB420733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC6gXCP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AB420733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CFU-0000Vg-3u
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1CEq-0008Sn-9G
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1CEp-00054y-4o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:48:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1CEp-000547-1A
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581353326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1vT7iDzp+N4qrYfTKdhYCOm3Fo8J0+gxRH4P3qKCj4=;
 b=AC6gXCP46eUORolq/KgEZBonHK4OF+F1PQEYMfX+WAerCXl6oxTfSBGdjTrlx8NAt280HK
 oTbljykuPbE7kcSpWx5odZAPAiv2gxNTwtF2ZizTGyuzUUO/37RV/nN+000DFBbOxccM+K
 0aL1NT/nrGvT4skUM/KJDYm3DHkmqeQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-3gXVVYanMlCEmdOZR-bY6A-1; Mon, 10 Feb 2020 11:48:19 -0500
Received: by mail-qv1-f69.google.com with SMTP id z9so5311392qvo.10
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 08:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Pi4YybGUTTc+BjimB7b1zIGQESShXY5/8aaRQ8nPS/Q=;
 b=CoNdh8k7vhQbac9EQiine25j2wtHpFwP1jVCzygUpoAKLYxqe2Pg0cVGgmeb/yo3IO
 4+gBayZ+trVWrGlupn8wb/mQ9vsiE/32Wp4+aa9OgZ/HHuktLhru/dxykFlHZQ9h9Or1
 aFp9lvSyYxUnj0h2yK65sYrrYZ/MGu9DiG6VeQrmcyGxz2csnvaJ9m5dABJMf4P2WyDQ
 t8zLSUZAaIyFnWTcBPBE/StDYqR/CsuxaDDXj1Ra8yIbh/R7+7jJPvtytXjq4uGrGdEe
 /b/nafiFgJPhxXOjJIp+I11QRD7ncu5LLmg3RknLHqpXqMbiMmQd6C7lmhaqcxUVfOEC
 E1nw==
X-Gm-Message-State: APjAAAXfOrlu7hY/vB8EL9zeFcr80FvyuOYuKkeboRM+VR+wrhJhcymx
 IddmwbsNrQL31KK+fQnHFqVVvdulGjeApIplywoa39E263DeQUwu+AylM7Azx1KTPB7wxTGBs+s
 HdDGZnrKsZXwLNm8=
X-Received: by 2002:a37:a8ca:: with SMTP id r193mr2160502qke.335.1581353298537; 
 Mon, 10 Feb 2020 08:48:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhpx3K/ySBGyo4sJZFrlWNquVDCFgcCEHTQ8ytQ2q2dxOXL6lYWCID1Vbj7GQyNOUXQ+wxaA==
X-Received: by 2002:a37:a8ca:: with SMTP id r193mr2160472qke.335.1581353298244; 
 Mon, 10 Feb 2020 08:48:18 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id x197sm401422qkb.28.2020.02.10.08.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 08:48:17 -0800 (PST)
Date: Mon, 10 Feb 2020 11:48:14 -0500
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
Message-ID: <20200210164814.GB964285@xz-x1>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207100540.GA1999431@myrica>
 <20200207052405-mutt-send-email-mst@kernel.org>
 <20200207230405.GJ720553@xz-x1>
 <20200209155639-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200209155639-mutt-send-email-mst@kernel.org>
X-MC-Unique: 3gXVVYanMlCEmdOZR-bY6A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, Eric Auger <eric.auger@redhat.com>,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 09, 2020 at 03:58:57PM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 07, 2020 at 06:04:05PM -0500, Peter Xu wrote:
> > On Fri, Feb 07, 2020 at 05:24:54AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Feb 07, 2020 at 11:05:40AM +0100, Jean-Philippe Brucker wrote=
:
> > > > Hi Eric,
> > > >=20
> > > > On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
> > > > > At the moment, the kernel only supports device tree
> > > > > integration of the virtio-iommu. DT bindings between the
> > > > > PCI root complex and the IOMMU must be created by the machine
> > > > > in conformance to:
> > > > >=20
> > > > > Documentation/devicetree/bindings/virtio/iommu.txt.
> > > > >=20
> > > > > To make sure the end-user is aware of this, force him to use the
> > > > > temporary device option "x-dt-binding" and also double check the
> > > > > machine has a hotplug handler for the virtio-iommu-pci device.
> > > > > This hotplug handler is in charge of creating those DT bindings.
> > > > >=20
> > > > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > [...]
> > > > > @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCI=
Proxy *vpci_dev, Error **errp)
> > > > >      VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
> > > > >      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > > > =20
> > > > > +    if (!dev->dt_binding) {
> > > > > +        error_setg(errp,
> > > > > +                   "Instantiation currently only is possible if =
the machine "
> > > > > +                   "creates device tree iommu-map bindings, ie. =
ACPI is not "
> > > > > +                   "yet supported");
> > > > > +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-bind=
ing\n");
> > > >=20
> > > > "use -device virtio-iommu-pci,x-dt-binding"?
> > > >=20
> > > > Can the option be safely removed as soon as we implement a topology
> > > > description for the remaining platforms?  Or will we need to carry =
it
> > > > forever for backward-compatibility (ie. ensure that an old command-=
line
> > > > invocation that contains this option still works)?
> > > >=20
> > > > Thanks,
> > > > Jean
> > >=20
> > > I'd worry that if we actually document it then users will come to
> > > depend on it for sure, even though it starts with x-.
> >=20
> > I thought x- parameters can be dropped directly with totally no
> > grarantee...  Otherwise how do we differenciate x- with the common
> > parameters, and how do we introduce remove-prone parameters?
> >=20
> > Thanks,
>=20
> It's all about not breaking users. Yes we document that x-
> interfaces are unstable. But that documentation is only=20
> good for well-behaved users such as libvirt. End-users
> tend not to read the docs and the subtleties of
> stable/unstable interface are lost on them, so we really must never
> actively ask end users to set an x- flag.

Ah I see the point.  Yes we should never suggest that, or at least
also mention that it's experimental and prone to change.  Thanks,

--=20
Peter Xu


