Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A55C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D16120679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrs9Kh2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D16120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUeI-0002tm-Go
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jgUdN-0001cI-MN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:44:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38410
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jgUdL-0007LB-B1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591195486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c1bDfd4+QNXuTD/uFIs5tH25iJlRHhHR18/CkuVrCgc=;
 b=hrs9Kh2K0ylCi0RQMIsR6bQ241HEjGX4GHhdDwLMIi1YbJ2npXjQvwnLSqRYxlIq/QkhMM
 XsKtNmbqSiwVENGcZrjwcxq8UgmQrzReLTbchuzwIlouPFxZn1ySvA584WpYPAPco3kHQx
 wxZgMDqMk6lhbeRw+fPk92SvxE7IDc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-vYg1eWslMbehRJlPtb_TKg-1; Wed, 03 Jun 2020 10:44:41 -0400
X-MC-Unique: vYg1eWslMbehRJlPtb_TKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 931A1C745F;
 Wed,  3 Jun 2020 14:44:40 +0000 (UTC)
Received: from localhost (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27D59579A3;
 Wed,  3 Jun 2020 14:44:39 +0000 (UTC)
Date: Wed, 3 Jun 2020 15:44:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/5] vhost: involve device backends in feature negotiation
Message-ID: <20200603144438.GD29025@stefanha-x1.localdomain>
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-3-stefanha@redhat.com>
 <c99670df-8f73-2a13-1e41-0d0a3aac0133@redhat.com>
 <20200529135641.GC367530@stefanha-x1.localdomain>
 <20200529142913.GM2856@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200529142913.GM2856@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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
 Jason Wang <jasowang@redhat.com>, cohuck@redhat.com, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 03:29:13PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Fri, May 29, 2020 at 03:04:54PM +0800, Jason Wang wrote:
> > >=20
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
> > > >    $ x86_64-softmmu/qemu-system-x86_64 \
> > > >        -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
> > > >        -chardev socket,path=3D/tmp/vhost-user-blk.sock,id=3Dchar0 \
> > > >        -device vhost-user-blk-pci,chardev=3Dchar0,packed=3Don \
> > > >        -object memory-backend-memfd,size=3D1G,share=3Don,id=3Dram0 =
\
> > > >        -M accel=3Dkvm,memory-backend=3Dram0
> > > >    qemu-system-x86_64: Failed to set msg fds.
> > > >    qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success =
(0)
> > >=20
> > >=20
> > > It looks to me this could be fixed simply by adding VIRTIO_F_RING_PAC=
KED
> > > into user_feature_bits in vhost-user-blk.c.
> > >
> > > And for the rest, we need require them to call vhost_get_features() w=
ith the
> > > proper feature bits that needs to be acked by the backend.
> >=20
> > There is a backwards-compatibility problem: we cannot call
> > vhost_get_features() with the full set of feature bits that each device
> > type supports because existing vhost-user backends don't advertise
> > features properly. QEMU disables features not advertised by the
> > vhost-user backend.
> >=20
> > For example, if we add VIRTIO_RING_F_EVENT_IDX then it will always be
> > disabled for existing libvhost-user backends because they don't
> > advertise this bit :(.
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
>=20
> What about adding a VHOST_USER_PROTOCOL_F_BACKEND_F to indicate the
> backend knows how to advertise the backend features.
>=20
> (Although my understanding of virtio feature flags is thin)

Luckily the feature bits we've missed out on are mostly legacy features
or features we always want to enable, so I'm not sure a solution for
negotiating all feature bits is needed.

Not all features should be controlled by the backend since vhost devices
often are a strict subset of a VIRTIO device.

Documenting which feature bits are controlled by the backend seems like
a reasonable way of clarifying the current state and preventing similar
issues in the future.

Stefan

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7Xt1YACgkQnKSrs4Gr
c8g83wf9F9XrsAAdGMNFEOdtbTd2U67E8zIqanuJ86ZkYyZk6U9sjtrkMQO0jXeX
RPN6n5yORv9hULXGH4+Lo1++hiHiFWUCaGoPo3VkyaQrG9L0PnBM/OmVC1hCUpza
VAXSAoXWHUkLyig/Yr2IaQBlplt9mZH8chqm31EYnQU6lsAxvO2sOm1r97TDVjdD
SQiHzJRuk74HgYYUFZlADcv28Of4e/EqrZyjmWhkANYll6SPn9Q8dZ7eNwucZ9yK
x6qt56kT2Cs4/FIGQFKUBMy6ucS7NekPeKKDiwyScONrItBVc8P67DG0pjIhzapa
8nc9QA37ifvu2mAv2mtfXCTHXLKf8Q==
=jQ+6
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--


