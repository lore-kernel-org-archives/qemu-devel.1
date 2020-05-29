Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B34C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E402073B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiLDcXyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E402073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefvi-0000J0-Fe
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jefVP-0008Un-8Y
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:57:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jefVM-0005In-Sy
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590760618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2zV8s9DcTKXPlyEtqz17+FmubGAgTISn2FF6Q+hY/Q=;
 b=fiLDcXyZGhfWF+LB9oYV4csBLeIxetKivRcnbF5E2Vh78Zsd5oWjaSLoq+bocVjOX1aZwe
 WIwrB12pS1vC4T033hRr665of7L0axL+LVEbjv3ylLy5BNbVW0RFRcpW5GrOj83ZbS0D+K
 qlGdnCzLxy+ejdQV+6NymDXV8/Y9oi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-aBeVhHbWMTmwU5ygrkyCDA-1; Fri, 29 May 2020 09:56:53 -0400
X-MC-Unique: aBeVhHbWMTmwU5ygrkyCDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7BF280183C;
 Fri, 29 May 2020 13:56:51 +0000 (UTC)
Received: from localhost (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4012B6F7;
 Fri, 29 May 2020 13:56:43 +0000 (UTC)
Date: Fri, 29 May 2020 14:56:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] vhost: involve device backends in feature negotiation
Message-ID: <20200529135641.GC367530@stefanha-x1.localdomain>
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-3-stefanha@redhat.com>
 <c99670df-8f73-2a13-1e41-0d0a3aac0133@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c99670df-8f73-2a13-1e41-0d0a3aac0133@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
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

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 03:04:54PM +0800, Jason Wang wrote:
>=20
> On 2020/5/23 =E4=B8=8A=E5=8D=881:17, Stefan Hajnoczi wrote:
> > Many vhost devices in QEMU currently do not involve the device backend
> > in feature negotiation. This seems fine at first glance for device type=
s
> > without their own feature bits (virtio-net has many but other device
> > types have none).
> >=20
> > This overlooks the fact that QEMU's virtqueue implementation and the
> > device backend's implementation may support different features.  QEMU
> > must not report features to the guest that the the device backend
> > doesn't support.
> >=20
> > For example, QEMU supports VIRTIO 1.1 packed virtqueues while many
> > existing vhost device backends do not. When the user sets packed=3Don t=
he
> > device backend breaks. This should have been handled gracefully by
> > feature negotiation instead.
> >=20
> > Introduce vhost_get_default_features() and update all vhost devices in
> > QEMU to involve the device backend in feature negotiation.
> >=20
> > This patch fixes the following error:
> >=20
> >    $ x86_64-softmmu/qemu-system-x86_64 \
> >        -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
> >        -chardev socket,path=3D/tmp/vhost-user-blk.sock,id=3Dchar0 \
> >        -device vhost-user-blk-pci,chardev=3Dchar0,packed=3Don \
> >        -object memory-backend-memfd,size=3D1G,share=3Don,id=3Dram0 \
> >        -M accel=3Dkvm,memory-backend=3Dram0
> >    qemu-system-x86_64: Failed to set msg fds.
> >    qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
>=20
>=20
> It looks to me this could be fixed simply by adding VIRTIO_F_RING_PACKED
> into user_feature_bits in vhost-user-blk.c.
>
> And for the rest, we need require them to call vhost_get_features() with =
the
> proper feature bits that needs to be acked by the backend.

There is a backwards-compatibility problem: we cannot call
vhost_get_features() with the full set of feature bits that each device
type supports because existing vhost-user backends don't advertise
features properly. QEMU disables features not advertised by the
vhost-user backend.

For example, if we add VIRTIO_RING_F_EVENT_IDX then it will always be
disabled for existing libvhost-user backends because they don't
advertise this bit :(.

The reason I introduced vhost_get_default_features() is to at least
salvage VIRTIO_F_IOMMU_PLATFORM and VIRTIO_F_RING_PACKED. These bits can
be safely negotiated for all devices.

Any new transport/vring VIRTIO feature bits can also be added to
vhost_get_default_features() safely.

If a vhost-user device wants to use device type-specific feature bits
then it really needs to call vhost_get_features() directly as you
suggest. But it's important to check whether existing vhost-user
backends actually advertise them - because if they don't advertise them
but rely on them then we'll break existing backends.

Would you prefer a different approach?

> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index aff98a0ede..f8a144dcd0 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -48,6 +48,23 @@ static unsigned int used_memslots;
> >   static QLIST_HEAD(, vhost_dev) vhost_devices =3D
> >       QLIST_HEAD_INITIALIZER(vhost_devices);
> > +/*
> > + * Feature bits that device backends must explicitly report. Feature b=
its not
> > + * listed here maybe set by QEMU without checking with the device back=
end.
> > + * Ideally all feature bits would be listed here but existing vhost de=
vice
> > + * implementations do not explicitly report bits like VIRTIO_F_VERSION=
_1, so we
> > + * can only assume they are supported.
>=20
>=20
> For most backends, we care about the features for datapath. So this is no=
t
> true at least for networking device, since VIRTIO_F_VERSION_1 have impact=
 on
> the length of vnet header length.

The net device is in good shape and doesn't use vhost_default_feature_bits[=
].

vhost_default_feature_bits[] is for devices that haven't been
negotiating feature bits properly. The goal is start involving them in
feature negotiation without breaking existing backends.

Would you like me to rephrase this comment in some way?

> > + *
> > + * New feature bits added to the VIRTIO spec should usually be include=
d here
> > + * so that existing vhost device backends that do not support them yet=
 continue
> > + * to work.
>=20
>=20
> It actually depends on the type of backend.
>=20
> Kernel vhost-net does not validate GSO features since qemu can talk direc=
tly
> to TAP and vhost doesn't report those features. But for vhost-user GSO
> features must be validated by qemu since qemu can't see what is behind
> vhost-user.

Maybe the comment should say "New transport/vring feature bits". I'm
thinking about things like VIRTIO_F_RING_PACKED that are not
device-specific but require backend support.

The GSO features you mentioned are device-specific. Devices that want to
let the backend advertise device-specific features cannot use
vhost_default_feature_bits[].

> > + */
> > +static const int vhost_default_feature_bits[] =3D {
> > +    VIRTIO_F_IOMMU_PLATFORM,
> > +    VIRTIO_F_RING_PACKED,
> > +    VHOST_INVALID_FEATURE_BIT
> > +};
> > +
> >   bool vhost_has_free_slot(void)
> >   {
> >       unsigned int slots_limit =3D ~0U;
> > @@ -1468,6 +1485,11 @@ uint64_t vhost_get_features(struct vhost_dev *hd=
ev, const int *feature_bits,
> >       return features;
> >   }
> > +uint64_t vhost_get_default_features(struct vhost_dev *hdev, uint64_t f=
eatures)
> > +{
> > +    return vhost_get_features(hdev, vhost_default_feature_bits, featur=
es);
> > +}
>=20
>=20
> There's probably no need for a new helper, we can do all these inside
> vhost_get_features().

Would you prefer:

  extern const int vhost_default_feature_bits[];

And then callers do:

  vhost_get_features(hdev, vhost_default_feature_bits, features);

?

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7RFJkACgkQnKSrs4Gr
c8h+qwf+OcVO255iZvt/alI9phd4NDzpeylgwi2+ZIUtS4TWwbpnqHAD/z8mYiNe
dNmpMhU/EnfF4BUWoFRnkkAqTmPsP83RtiNbSGJuqaJkzhEC54E/TCgsz0j0lsAT
L0m1BwzjWwRKd3M6yWjmvXdeYFqblkXLXNKPbfyZhHV3JVkC/XF9Kkh12L0Sg0qd
4/nZybk40Q8wLZbvQpieVaj2uzhAjPyi3J/V7FQ6znPF7rdZctq/276LFFOi3Lge
FyMW8RlKKnihNkccNV9aAgfO5wzMFNffbtjE3ZxPHfhq9EVjytZFp65EADoufZK/
Nm44Lhq891ibEfPmlLIw6ecucHr/jQ==
=Xzwn
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--


