Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22639C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DD12082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4GWs76R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DD12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00pk-0005FL-4j
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j00or-0003js-Ig
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j00oq-00052h-Dd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:25:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56463
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j00oq-00051v-9O
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581071103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfrfUu7V3V/FOij6s8JiSmeD5eRiBLXYQoPDS4gYMVA=;
 b=M4GWs76RJK6v4RzZ9eDuhrv1+MpJlGUpehtdC9eTUfQ9TVTji7+JZ6mPD7QWd7ijbVZJ0L
 81dK9/QfJvKYbEPuLzjCFl3ydp6rkb+RVHOVRAL20O7tTaqZrVjXhLcC8ekFNAxPtVYpfN
 b9gTwtzZoZuKuqMJk6AhZQznUO2aKjU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-WmmggItEMOy7sASqfkpUHQ-1; Fri, 07 Feb 2020 05:25:00 -0500
Received: by mail-qt1-f198.google.com with SMTP id g26so1331940qts.16
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 02:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KkfgzxJ5hnk0K/gG/Ng4whBs+Zv4G8xFGcL8nZlr36A=;
 b=iQeZbuWVa80/IKd43FPrdZN8Fo79D6Epl7ir9kH4Sgy3RTJ+gUtBj/zviXhAMSOaJE
 WdqhVI66apMcT/5zqerw65cbv3UQSv7wWDpLGWONOA8OdnIFk/hGOu9VTxVyNWYFBZZp
 JUQpcwWYoYRqq/C8xI37sC8ZD7DhzxVJTuzGgAqoWh3xxHnyTCCM9JjwR6GYlDWRCvWv
 OgfDXSYPVbCvP6OoRX4Grv8Kar721jHh79zfVU2MzSDsiNkd8pazn9blA95fA1SOqZLv
 nf1PmCIjZ9aF7zM60/ndsaIGFEJbqHk3CobhaqWoqDTIk37ffiASYBGWpLfLbfpfOJMQ
 FoKQ==
X-Gm-Message-State: APjAAAUwp9ZYt16+YYgYAmJxxPn0l+U8JGRmPi2lVqzr/O80997PMC/k
 RutV3mOvHs0g37lXiFxMexNkkSCbM+JBGCAGeYQ8BWF/yCwGFLcSqimSJKm6fM8d70aKPKJkIl4
 DSLDpUnV3hXClK4s=
X-Received: by 2002:a0c:ef0f:: with SMTP id t15mr6209961qvr.123.1581071099998; 
 Fri, 07 Feb 2020 02:24:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTViu1+hHob/UL7twQm0vLblvDJ0tMlanc1HgncESFxbJCB02tH+O2JtXxIc4A7KuiFWG0Yw==
X-Received: by 2002:a0c:ef0f:: with SMTP id t15mr6209941qvr.123.1581071099781; 
 Fri, 07 Feb 2020 02:24:59 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id q7sm1069328qkc.43.2020.02.07.02.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 02:24:59 -0800 (PST)
Date: Fri, 7 Feb 2020 05:24:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
Message-ID: <20200207052405-mutt-send-email-mst@kernel.org>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207100540.GA1999431@myrica>
MIME-Version: 1.0
In-Reply-To: <20200207100540.GA1999431@myrica>
X-MC-Unique: WmmggItEMOy7sASqfkpUHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, Eric Auger <eric.auger@redhat.com>,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 11:05:40AM +0100, Jean-Philippe Brucker wrote:
> Hi Eric,
>=20
> On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
> > At the moment, the kernel only supports device tree
> > integration of the virtio-iommu. DT bindings between the
> > PCI root complex and the IOMMU must be created by the machine
> > in conformance to:
> >=20
> > Documentation/devicetree/bindings/virtio/iommu.txt.
> >=20
> > To make sure the end-user is aware of this, force him to use the
> > temporary device option "x-dt-binding" and also double check the
> > machine has a hotplug handler for the virtio-iommu-pci device.
> > This hotplug handler is in charge of creating those DT bindings.
> >=20
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> [...]
> > @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy =
*vpci_dev, Error **errp)
> >      VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
> >      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > =20
> > +    if (!dev->dt_binding) {
> > +        error_setg(errp,
> > +                   "Instantiation currently only is possible if the ma=
chine "
> > +                   "creates device tree iommu-map bindings, ie. ACPI i=
s not "
> > +                   "yet supported");
> > +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n"=
);
>=20
> "use -device virtio-iommu-pci,x-dt-binding"?
>=20
> Can the option be safely removed as soon as we implement a topology
> description for the remaining platforms?  Or will we need to carry it
> forever for backward-compatibility (ie. ensure that an old command-line
> invocation that contains this option still works)?
>=20
> Thanks,
> Jean

I'd worry that if we actually document it then users will come to
depend on it for sure, even though it starts with x-.

--=20
MST


