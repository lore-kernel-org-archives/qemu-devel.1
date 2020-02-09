Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EF2C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 20:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB15020733
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 20:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8ZuSnCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB15020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0tgE-00066o-Sm
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 15:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j0tfZ-0005GT-5d
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 15:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j0tfX-0001er-G0
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 15:59:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38289
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j0tfX-0001eW-Ci
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 15:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581281947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TgsTYlq2uWpX5l3dOcoMSrO707rEi65LVX3fRa5d4g=;
 b=g8ZuSnCboqB1QRrMYtTCpLGRs60vlSKcve8LhptpxT6REkXUvwVOKnFNklNqzrGiGX7rZK
 zjj373CuNpkIy0SLn6wPFuOv+dVBp7fretCVikLLxhwjfVmFsDTNabW8Q18PFS2RvfIarX
 mqKGf+Cv8B0tqhm5avibxjsLdkqmOk4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-H20WUhj8ON6ybmID9SKh7g-1; Sun, 09 Feb 2020 15:59:03 -0500
Received: by mail-qk1-f197.google.com with SMTP id i11so3508325qki.12
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 12:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b8IZa3WqHO9P3WUfVwvQeYuuFSFdaUexg28Zj2YYOh4=;
 b=tYODguxufG3noMfMm3xjrsU1MMey2To2dQQsO31+ReoHOr1dykoCTkg5gBIaTk/6x/
 lBVZUB5e5+VRnJyiwFMpSvxoE/b2S6ixP1K+23FpzgNT6ADrIUohgAvuAvA9fiyBeUaE
 NXQSHswKqsIhIiiFYOXxqtUhQKZHIxuwpmouD/cleksJjI3isdIF98rE4Tg8vN/V8mEr
 0LUtu1HAwkpmRai8J06mpBJ7bspaWDEKaqohXMznUFVDo2bxpddDUO5zcMcSsGQfe8DQ
 9i84dUz+uej6JdeelBidTQtlraiQ3A9pZAPHmhRuGb9qvicM+WgN6pWSjrVe3XRivzxD
 /zLA==
X-Gm-Message-State: APjAAAWw3KrND6Min8BmCHHoTG3Tl3TqeuTyph14ghZLIcrFfjXweGmc
 NXEVO3vC8NxicW3N63VNfQi6NDlzFRhjmvFkitFMwxjFeHuc6HQnx4ZOxIZvo48xClANCwmZt2N
 XT5WpfGKedXYl0ZY=
X-Received: by 2002:a05:620a:6d4:: with SMTP id
 20mr7988850qky.81.1581281942809; 
 Sun, 09 Feb 2020 12:59:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqySBNwoTD2v6qnoYc3haWDuIEiwfdm0Rz7BJ4Y1iM2CClMHbLfkWaJ0Q8fuJrjv9QAH1/1xAA==
X-Received: by 2002:a05:620a:6d4:: with SMTP id
 20mr7988840qky.81.1581281942562; 
 Sun, 09 Feb 2020 12:59:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id h8sm4997217qtm.51.2020.02.09.12.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2020 12:59:01 -0800 (PST)
Date: Sun, 9 Feb 2020 15:58:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
Message-ID: <20200209155639-mutt-send-email-mst@kernel.org>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207100540.GA1999431@myrica>
 <20200207052405-mutt-send-email-mst@kernel.org>
 <20200207230405.GJ720553@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200207230405.GJ720553@xz-x1>
X-MC-Unique: H20WUhj8ON6ybmID9SKh7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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

On Fri, Feb 07, 2020 at 06:04:05PM -0500, Peter Xu wrote:
> On Fri, Feb 07, 2020 at 05:24:54AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Feb 07, 2020 at 11:05:40AM +0100, Jean-Philippe Brucker wrote:
> > > Hi Eric,
> > >=20
> > > On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
> > > > At the moment, the kernel only supports device tree
> > > > integration of the virtio-iommu. DT bindings between the
> > > > PCI root complex and the IOMMU must be created by the machine
> > > > in conformance to:
> > > >=20
> > > > Documentation/devicetree/bindings/virtio/iommu.txt.
> > > >=20
> > > > To make sure the end-user is aware of this, force him to use the
> > > > temporary device option "x-dt-binding" and also double check the
> > > > machine has a hotplug handler for the virtio-iommu-pci device.
> > > > This hotplug handler is in charge of creating those DT bindings.
> > > >=20
> > > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > [...]
> > > > @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIPr=
oxy *vpci_dev, Error **errp)
> > > >      VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
> > > >      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > > =20
> > > > +    if (!dev->dt_binding) {
> > > > +        error_setg(errp,
> > > > +                   "Instantiation currently only is possible if th=
e machine "
> > > > +                   "creates device tree iommu-map bindings, ie. AC=
PI is not "
> > > > +                   "yet supported");
> > > > +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-bindin=
g\n");
> > >=20
> > > "use -device virtio-iommu-pci,x-dt-binding"?
> > >=20
> > > Can the option be safely removed as soon as we implement a topology
> > > description for the remaining platforms?  Or will we need to carry it
> > > forever for backward-compatibility (ie. ensure that an old command-li=
ne
> > > invocation that contains this option still works)?
> > >=20
> > > Thanks,
> > > Jean
> >=20
> > I'd worry that if we actually document it then users will come to
> > depend on it for sure, even though it starts with x-.
>=20
> I thought x- parameters can be dropped directly with totally no
> grarantee...  Otherwise how do we differenciate x- with the common
> parameters, and how do we introduce remove-prone parameters?
>=20
> Thanks,

It's all about not breaking users. Yes we document that x-
interfaces are unstable. But that documentation is only=20
good for well-behaved users such as libvirt. End-users
tend not to read the docs and the subtleties of
stable/unstable interface are lost on them, so we really must never
actively ask end users to set an x- flag.


> --=20
> Peter Xu


