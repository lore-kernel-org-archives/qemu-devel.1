Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66DCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15E520679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdZ7NYKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15E520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUZa-0005Tq-U1
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jgUYV-000476-Uw
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:39:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jgUYT-00066L-Cw
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591195184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o55mgpJTNy+U9o2vkjc0xjPtiQTs56zp8NuqaIlJb18=;
 b=WdZ7NYKBqgNIGY4n4ykAKsYL5eSUYJiQ+jE4K6Kfq4MfpNhlraNYn+kdQF8mQ1TnS9nzAy
 jKrYhvK8X0BEqcVvnlh+gpD4Gbzcqsx3bIF0l/EMLqFFxVqFH7ShnUIPjYq8hRTYrcz/pa
 rR7Zmhb8cSEK+xOfJLp6/Ss8Y5XQCqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-YZSxZ1dNPWm-V4MwqDoGbQ-1; Wed, 03 Jun 2020 10:39:40 -0400
X-MC-Unique: YZSxZ1dNPWm-V4MwqDoGbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 212A4835B43;
 Wed,  3 Jun 2020 14:39:39 +0000 (UTC)
Received: from localhost (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E11410013D6;
 Wed,  3 Jun 2020 14:39:29 +0000 (UTC)
Date: Wed, 3 Jun 2020 15:39:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] vhost: involve device backends in feature negotiation
Message-ID: <20200603143928.GC29025@stefanha-x1.localdomain>
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-3-stefanha@redhat.com>
 <c99670df-8f73-2a13-1e41-0d0a3aac0133@redhat.com>
 <20200529135641.GC367530@stefanha-x1.localdomain>
 <2edb0864-723a-c8e5-7d49-a73540f9f069@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2edb0864-723a-c8e5-7d49-a73540f9f069@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 08:51:43PM +0800, Jason Wang wrote:
>=20
> On 2020/5/29 =E4=B8=8B=E5=8D=889:56, Stefan Hajnoczi wrote:
> > On Fri, May 29, 2020 at 03:04:54PM +0800, Jason Wang wrote:
> > > On 2020/5/23 =E4=B8=8A=E5=8D=881:17, Stefan Hajnoczi wrote:
> > > > Many vhost devices in QEMU currently do not involve the device back=
end
> > > > in feature negotiation. This seems fine at first glance for device =
types
> > > > without their own feature bits (virtio-net has many but other devic=
e
> > > > types have none).
> > > >=20
> > > > This overlooks the fact that QEMU's virtqueue implementation and th=
e
> > > > device backend's implementation may support different features.  QE=
MU
> > > > must not report features to the guest that the the device backend
> > > > doesn't support.
> > > >=20
> > > > For example, QEMU supports VIRTIO 1.1 packed virtqueues while many
> > > > existing vhost device backends do not. When the user sets packed=3D=
on the
> > > > device backend breaks. This should have been handled gracefully by
> > > > feature negotiation instead.
> > > >=20
> > > > Introduce vhost_get_default_features() and update all vhost devices=
 in
> > > > QEMU to involve the device backend in feature negotiation.
> > > >=20
> > > > This patch fixes the following error:
> > > >=20
> > > >     $ x86_64-softmmu/qemu-system-x86_64 \
> > > >         -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
> > > >         -chardev socket,path=3D/tmp/vhost-user-blk.sock,id=3Dchar0 =
\
> > > >         -device vhost-user-blk-pci,chardev=3Dchar0,packed=3Don \
> > > >         -object memory-backend-memfd,size=3D1G,share=3Don,id=3Dram0=
 \
> > > >         -M accel=3Dkvm,memory-backend=3Dram0
> > > >     qemu-system-x86_64: Failed to set msg fds.
> > > >     qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success=
 (0)
> > >=20
> > > It looks to me this could be fixed simply by adding VIRTIO_F_RING_PAC=
KED
> > > into user_feature_bits in vhost-user-blk.c.
> > >=20
> > > And for the rest, we need require them to call vhost_get_features() w=
ith the
> > > proper feature bits that needs to be acked by the backend.
> > There is a backwards-compatibility problem: we cannot call
> > vhost_get_features() with the full set of feature bits that each device
> > type supports because existing vhost-user backends don't advertise
> > features properly. QEMU disables features not advertised by the
> > vhost-user backend.
> >=20
> > For example, if we add VIRTIO_RING_F_EVENT_IDX then it will always be
> > disabled for existing libvhost-user backends because they don't
> > advertise this bit :(.
>=20
>=20
> Agree.
>=20
>=20
> >=20
> > The reason I introduced vhost_get_default_features() is to at least
> > salvage VIRTIO_F_IOMMU_PLATFORM and VIRTIO_F_RING_PACKED. These bits ca=
n
> > be safely negotiated for all devices.
> >=20
> > Any new transport/vring VIRTIO feature bits can also be added to
> > vhost_get_default_features() safely.
> >=20
> > If a vhost-user device wants to use device type-specific feature bits
> > then it really needs to call vhost_get_features() directly as you
> > suggest. But it's important to check whether existing vhost-user
> > backends actually advertise them - because if they don't advertise them
> > but rely on them then we'll break existing backends.
> >=20
> > Would you prefer a different approach?
>=20
>=20
> I get you now so I think not.
>=20
> Maybe we need document the expected behavior of VHOST_USER_GET_FEATURES e=
.g
> which set of features that must be advertised explicitly.

Good idea. I'll update the vhost-user spec.

> And for the set you mention here, we probably need to add:
>=20
> VIRTIO_F_ORDER_PLATFORM,
> VIRTIO_F_ANY_LAYOUT (not sure if it was too late).
>=20
> And
>=20
> VIRTIO_F_IN_ORDER

Thanks, will check them and add them if possible.

>=20
>=20
> >=20
> > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > index aff98a0ede..f8a144dcd0 100644
> > > > --- a/hw/virtio/vhost.c
> > > > +++ b/hw/virtio/vhost.c
> > > > @@ -48,6 +48,23 @@ static unsigned int used_memslots;
> > > >    static QLIST_HEAD(, vhost_dev) vhost_devices =3D
> > > >        QLIST_HEAD_INITIALIZER(vhost_devices);
> > > > +/*
> > > > + * Feature bits that device backends must explicitly report. Featu=
re bits not
> > > > + * listed here maybe set by QEMU without checking with the device =
backend.
> > > > + * Ideally all feature bits would be listed here but existing vhos=
t device
> > > > + * implementations do not explicitly report bits like VIRTIO_F_VER=
SION_1, so we
> > > > + * can only assume they are supported.
> > >=20
> > > For most backends, we care about the features for datapath. So this i=
s not
> > > true at least for networking device, since VIRTIO_F_VERSION_1 have im=
pact on
> > > the length of vnet header length.
> > The net device is in good shape and doesn't use vhost_default_feature_b=
its[].
> >=20
> > vhost_default_feature_bits[] is for devices that haven't been
> > negotiating feature bits properly. The goal is start involving them in
> > feature negotiation without breaking existing backends.
> >=20
> > Would you like me to rephrase this comment in some way?
>=20
>=20
> That will be better.

Will fix.

>=20
>=20
> >=20
> > > > + *
> > > > + * New feature bits added to the VIRTIO spec should usually be inc=
luded here
> > > > + * so that existing vhost device backends that do not support them=
 yet continue
> > > > + * to work.
> > >=20
> > > It actually depends on the type of backend.
> > >=20
> > > Kernel vhost-net does not validate GSO features since qemu can talk d=
irectly
> > > to TAP and vhost doesn't report those features. But for vhost-user GS=
O
> > > features must be validated by qemu since qemu can't see what is behin=
d
> > > vhost-user.
> > Maybe the comment should say "New transport/vring feature bits". I'm
> > thinking about things like VIRTIO_F_RING_PACKED that are not
> > device-specific but require backend support.
> >=20
> > The GSO features you mentioned are device-specific. Devices that want t=
o
> > let the backend advertise device-specific features cannot use
> > vhost_default_feature_bits[].
> >=20
> > > > + */
> > > > +static const int vhost_default_feature_bits[] =3D {
> > > > +    VIRTIO_F_IOMMU_PLATFORM,
> > > > +    VIRTIO_F_RING_PACKED,
> > > > +    VHOST_INVALID_FEATURE_BIT
> > > > +};
> > > > +
> > > >    bool vhost_has_free_slot(void)
> > > >    {
> > > >        unsigned int slots_limit =3D ~0U;
> > > > @@ -1468,6 +1485,11 @@ uint64_t vhost_get_features(struct vhost_dev=
 *hdev, const int *feature_bits,
> > > >        return features;
> > > >    }
> > > > +uint64_t vhost_get_default_features(struct vhost_dev *hdev, uint64=
_t features)
> > > > +{
> > > > +    return vhost_get_features(hdev, vhost_default_feature_bits, fe=
atures);
> > > > +}
> > >=20
> > > There's probably no need for a new helper, we can do all these inside
> > > vhost_get_features().
> > Would you prefer:
> >=20
> >    extern const int vhost_default_feature_bits[];
> >=20
> > And then callers do:
> >=20
> >    vhost_get_features(hdev, vhost_default_feature_bits, features);
> >=20
> > ?
>=20
>=20
> That's fine or maybe just do features |=3D vhost_default_feature_bits ins=
ide
> vhost_get_features().

Will fix.

Stefan

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7XtiAACgkQnKSrs4Gr
c8gWrAf+PPDC9cH4R/waDcwYKdw5/PplAe2vwL/73jWWtgSREp5ndUB2+X5sTkhf
S5ZduCPn1SMCBgwYCsVt0AnW1GONcEZUt9H8N856saJFfWXVyX7xxh5Gyqbq1uOT
Ugtd4cZydCpXmnBVvOMHVAPX8KimWsJr5JGpX9OI5GWaaikNrLu2ku24AlbDoa8q
5tHRMfLRcJ8z65hO/hZ17Ijly3T7RbHHNUa8C1YfSuCcfjDzcjvESfM2F7ckwMZl
I2syByPRX14aEvmcY4Sc++x9bVcwLEaQU/yKf2UzMKkviTRovySFJLENZ5zeUdp9
uEITww5c2o3dDJxcsFy/+Y21B6nTmw==
=0gs1
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--


