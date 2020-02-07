Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0563C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 23:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B0521741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 23:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyW4qco6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B0521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0CgA-0005fj-T7
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 18:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j0CfY-0004hs-2M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 18:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j0CfV-0006ne-UO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 18:04:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j0CfV-0006lB-J1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 18:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581116652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbIFO7Oxc9JmMQe9oFXeh2qJJYelsG+d0X1l7OckJLI=;
 b=cyW4qco6j1BgYAMjAOC6H29MMMH1tGktCeephT+Nxv2XCOlaKSZffGIUKtUihABCQ5B9Dv
 LFB5PZ0Aa5gMq4fveHHavsyu1DVqXM3/UsPmNVWOonzpvH5GWRKIo1MoNjUFoX4tdtvOMK
 Y7UUVDyQH5Q3xza4RuG5cRWBQ0thnxw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-KU0Es1abMii62AwmKbqOdw-1; Fri, 07 Feb 2020 18:04:08 -0500
Received: by mail-qk1-f199.google.com with SMTP id a23so529304qkl.7
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 15:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aXUqDz/U9ZcLQH+8OSUrnfufM7Gxds5/ddEtUUb4k3w=;
 b=fnOGO1XYXaoiHwUy7IhdrpIWWUkeIaSAX/FMHD8wSt4GF9gscJ9JT0c1uYP+8kUsUx
 rAe4OltIG5Ja1epQu2C7LZl+4YUwCXcH2SgfSBfrQqGL9ajvcDkS5DSpSjrAVz4TIORL
 6Vf7uGcYGzUpcfK4EgTeqrm0S8smI1Ccm+mW8nPUQxhjFQ4RLjUZ94gGUX+XhxMMqqNh
 lu6R7w+MahpUxFno99P6bhDWDfELyETD4aljFDDloxQ+arJRIo4k3QGbD9jZSx/7wOe/
 pHmofpRwcaLiD+0WwskrRZsYabuQdFfp+asaE6SAnWy+P0LDxPEWOsr/kQ6d4S2pJ8tu
 ctfQ==
X-Gm-Message-State: APjAAAXdl+OSmxFQVFgugtI/GdnlfaWiBYuk9j8eHIDBWLvnWSVBbrZo
 LEoL8VRaz6jWT7Bm+9jFTDvvFZV/B4uHekjSQdzRoTsLbtRgLtplFzIADJG6i2jIAJYNW3s6LYa
 9zQfZOwbiwbuvInw=
X-Received: by 2002:a37:47c4:: with SMTP id u187mr1248011qka.165.1581116647919; 
 Fri, 07 Feb 2020 15:04:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEcxy9tJ+LIBzeRRHCghalmREfh/Uul9tIJP1AJEr7MqA/baZTV6bsgIbSXV+ZhJVvuujKzQ==
X-Received: by 2002:a37:47c4:: with SMTP id u187mr1247994qka.165.1581116647667; 
 Fri, 07 Feb 2020 15:04:07 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id k29sm2093779qtu.54.2020.02.07.15.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 15:04:06 -0800 (PST)
Date: Fri, 7 Feb 2020 18:04:05 -0500
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
Message-ID: <20200207230405.GJ720553@xz-x1>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207100540.GA1999431@myrica>
 <20200207052405-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200207052405-mutt-send-email-mst@kernel.org>
X-MC-Unique: KU0Es1abMii62AwmKbqOdw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, Eric Auger <eric.auger@redhat.com>,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 05:24:54AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 07, 2020 at 11:05:40AM +0100, Jean-Philippe Brucker wrote:
> > Hi Eric,
> >=20
> > On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
> > > At the moment, the kernel only supports device tree
> > > integration of the virtio-iommu. DT bindings between the
> > > PCI root complex and the IOMMU must be created by the machine
> > > in conformance to:
> > >=20
> > > Documentation/devicetree/bindings/virtio/iommu.txt.
> > >=20
> > > To make sure the end-user is aware of this, force him to use the
> > > temporary device option "x-dt-binding" and also double check the
> > > machine has a hotplug handler for the virtio-iommu-pci device.
> > > This hotplug handler is in charge of creating those DT bindings.
> > >=20
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > [...]
> > > @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProx=
y *vpci_dev, Error **errp)
> > >      VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
> > >      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > =20
> > > +    if (!dev->dt_binding) {
> > > +        error_setg(errp,
> > > +                   "Instantiation currently only is possible if the =
machine "
> > > +                   "creates device tree iommu-map bindings, ie. ACPI=
 is not "
> > > +                   "yet supported");
> > > +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\=
n");
> >=20
> > "use -device virtio-iommu-pci,x-dt-binding"?
> >=20
> > Can the option be safely removed as soon as we implement a topology
> > description for the remaining platforms?  Or will we need to carry it
> > forever for backward-compatibility (ie. ensure that an old command-line
> > invocation that contains this option still works)?
> >=20
> > Thanks,
> > Jean
>=20
> I'd worry that if we actually document it then users will come to
> depend on it for sure, even though it starts with x-.

I thought x- parameters can be dropped directly with totally no
grarantee...  Otherwise how do we differenciate x- with the common
parameters, and how do we introduce remove-prone parameters?

Thanks,

--=20
Peter Xu


