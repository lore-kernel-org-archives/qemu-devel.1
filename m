Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ACDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6FA206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuRj3yk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6FA206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegxU-0004EK-BM
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jegwc-0003iY-Uf
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:29:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jegwa-00019A-Jx
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590766150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bIZ9p/xe7PjgB5Wp57zxSUR4OMgKTUH6eLZx+xpIFAY=;
 b=cuRj3yk68QXhWqp8cNj6sVhxQunb8rggbR4vkXrKITkEt5SL7Ow0Ti07oRsmO7gaMHRdLS
 5sGOKZunCutoSiH8rLXKrZZXCGe8pNx4eAdJRL0elrfHFGkjcGGJDuR2xe9rgiLvZAeKy4
 JkrAqSg4rmoK0Um7yIoIV7PEpeC7kyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-LVZNjbOTPJ2UwgcyzqS59Q-1; Fri, 29 May 2020 11:29:07 -0400
X-MC-Unique: LVZNjbOTPJ2UwgcyzqS59Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0A56EC1AF;
 Fri, 29 May 2020 15:29:05 +0000 (UTC)
Received: from localhost (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64F245C1B5;
 Fri, 29 May 2020 15:28:56 +0000 (UTC)
Date: Fri, 29 May 2020 16:28:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/5] virtio: enable VIRTIO_F_RING_PACKED for all devices
Message-ID: <20200529152855.GE367530@stefanha-x1.localdomain>
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-6-stefanha@redhat.com>
 <8e3a0ac5-9294-ca7e-071e-3074c43204c3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8e3a0ac5-9294-ca7e-071e-3074c43204c3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 03:15:59PM +0800, Jason Wang wrote:
>=20
> On 2020/5/23 =E4=B8=8A=E5=8D=881:17, Stefan Hajnoczi wrote:
> > The packed virtqueue layout was introduced in VIRTIO 1.1. It is a singl=
e
> > ring instead of a split avail/used ring design. There are CPU cache
> > advantages to this layout and it is also suited better to hardware
> > implementation.
> >=20
> > The vhost-net backend has already supported packed virtqueues for some
> > time. Performance benchmarks show that virtio-blk performance on NVMe
> > drives is also improved.
> >=20
> > Go ahead and enable this feature for all VIRTIO devices. Keep it
> > disabled for QEMU 5.0 and earlier machine types.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   include/hw/virtio/virtio.h |  2 +-
> >   hw/core/machine.c          | 18 +++++++++++++++++-
> >   2 files changed, 18 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index b69d517496..fd5b4a2044 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -292,7 +292,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> >       DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> >                         VIRTIO_F_IOMMU_PLATFORM, false), \
> >       DEFINE_PROP_BIT64("packed", _state, _field, \
> > -                      VIRTIO_F_RING_PACKED, false)
> > +                      VIRTIO_F_RING_PACKED, true)
> >   hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> >   bool virtio_queue_enabled(VirtIODevice *vdev, int n);
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index bb3a7b18b1..3598c3c825 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -28,7 +28,23 @@
> >   #include "hw/mem/nvdimm.h"
> >   #include "migration/vmstate.h"
> > -GlobalProperty hw_compat_5_0[] =3D {};
> > +GlobalProperty hw_compat_5_0[] =3D {
> > +    { "vhost-user-blk", "packed", "off" },
> > +    { "vhost-user-fs-device", "packed", "off" },
> > +    { "vhost-vsock-device", "packed", "off" },
> > +    { "virtio-9p-device", "packed", "off" },
> > +    { "virtio-balloon-device", "packed", "off" },
> > +    { "virtio-blk-device", "packed", "off" },
> > +    { "virtio-crypto-device", "packed", "off" },
> > +    { "virtio-gpu-device", "packed", "off" },
> > +    { "virtio-input-device", "packed", "off" },
> > +    { "virtio-iommu-device", "packed", "off" },
> > +    { "virtio-net-device", "packed", "off" },
> > +    { "virtio-pmem", "packed", "off" },
> > +    { "virtio-rng-device", "packed", "off" },
> > +    { "virtio-scsi-common", "packed", "off" },
> > +    { "virtio-serial-device", "packed", "off" },
>=20
>=20
> Missing "vhost-user-gpu" here?

Thanks, you're right.

I'll see if virtio-gpu-base works. If not it will be necessary to add
all the derived classes. The same is true for virtio-scsi-common, I'd
better check it works correctly!

Stefan

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7RKjcACgkQnKSrs4Gr
c8h/pwf+MXyj4Sc0yGVl7xAD5sYbeJZHWM9O0TSJd7JasvaFYvXvN6Ia8qjpb4BB
46ARIqaDVtHe0WxVTq2IKI5r6I9RnAxRICx8I9vuIMhib6txVmMplnw1cu49s3fS
xS/QlmlYsCZYy3xnH64j4hbs2uNytensCXqnAIXQBRFlFht1r+1jnn2SOA9GDnMD
FPWiteViNv1DgMn3ISKOhqeAOoJYPnAvzKajL54CF8Qx5BUB5QO5ezsbMpnM1b1a
6iABiQ4fbdC+7lUAiUTxzPTdouezmZPWV61RMaChrV4pD5Yf2tEA2xiRCGw6rUjj
qq7bZG8nDUBqd5LvGBH7nZ/ZEQxNfw==
=G1dd
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--


