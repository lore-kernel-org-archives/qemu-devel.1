Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473F3206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMEx/x2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473F3206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvd9-0005DN-Ho
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juvcI-0004iW-7z
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:23:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36363
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juvcG-0006tm-64
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594635799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=doNLK45oL7Oj0/W43KozYwT6JjYjHO02eLKhQUgRoDg=;
 b=RMEx/x2kTKBadIY+AqO/d1ybO+XzLki4ydivaOOtKGAGTAhKQRy+MqdvxtC0ivv9NJu+Bn
 GizYjI100a6438avbaZkIdYJXSqkuqCi3vNrfig5U+wGKISqQnxKwHDZcecwPLYaVvbrcq
 LoynrEt8t8kUivB5YE03q6dI9o4YwCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-NrmS-x3pPUuC27OrpEIS0w-1; Mon, 13 Jul 2020 06:23:16 -0400
X-MC-Unique: NrmS-x3pPUuC27OrpEIS0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D7880B713;
 Mon, 13 Jul 2020 10:23:14 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E63986149D;
 Mon, 13 Jul 2020 10:22:53 +0000 (UTC)
Date: Mon, 13 Jul 2020 11:22:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200713102252.GF28639@stefanha-x1.localdomain>
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-4-stefanha@redhat.com>
 <20200707174453.50c3ec85.cohuck@redhat.com>
 <20200708130526.GD487183@stefanha-x1.localdomain>
 <20200708185012.470125bb.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200708185012.470125bb.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 06:50:12PM +0200, Cornelia Huck wrote:
> On Wed, 8 Jul 2020 14:05:26 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Tue, Jul 07, 2020 at 05:44:53PM +0200, Cornelia Huck wrote:
> > > On Mon,  6 Jul 2020 14:56:48 +0100
> > > Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > > > diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pc=
i.c
> > > > index 3ff9eb7ef6..fa4b3bfb50 100644
> > > > --- a/hw/virtio/virtio-scsi-pci.c
> > > > +++ b/hw/virtio/virtio-scsi-pci.c
> > > > @@ -46,13 +46,17 @@ static void virtio_scsi_pci_realize(VirtIOPCIPr=
oxy *vpci_dev, Error **errp)
> > > >  {
> > > >      VirtIOSCSIPCI *dev =3D VIRTIO_SCSI_PCI(vpci_dev);
> > > >      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > > -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > > >      DeviceState *proxy =3D DEVICE(vpci_dev);
> > > > +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.conf;
> > > >      char *bus_name;
> > > > =20
> > > > +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > > > +        conf->num_queues =3D
> > > > +            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED=
);
> > > > +    }
> > > > +
> > > >      if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> > > > -        vpci_dev->nvectors =3D vs->conf.num_queues +
> > > > -                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
> > > > +        vpci_dev->nvectors =3D conf->num_queues + VIRTIO_SCSI_VQ_N=
UM_FIXED + 1;
> > > >      }
> > > > =20
> > > >      /* =20
> > >=20
> > > One corner case where the setup may end up being a bit odd is a
> > > situation where nvectors was specified, but num_queues was not, and t=
he
> > > device suddenly ends up with more queues than vectors. But I don't se=
e
> > > a reason why you would want to specify nvectors but not num_queues in=
 a
> > > real word scenario, so I think we can ignore that corner case. =20
> >=20
> > I agree, I've ignored that case. Other options include printing a
> > warning or even an error when num_queues disagrees with nvectors.
>=20
> I think an error would be too harsh, but a warning sounds useful.

I'll send this as a separate patch because at least virtio-serial is
also affected.

Stefan

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8MNfwACgkQnKSrs4Gr
c8h+fgf9HcG/hdStDn1snAk3gPe+Ox1TSVoGxXprmPDWbILvTXLC9kLl1lzKC+Hq
KAB946Rj1ThKKn5x6Ko1cZz03nhEZiNwgxFAAg3+xDpc48p01nmFqVb7qxmr5V3L
WetIsCAK98wihbGQHVwA7p4ewZgfwYNSIuR7sitVyuxwmCS602D9MOl9kgfhE1PU
oSI0o/zyWCzGNnzmmHFVgSTM0HX6SJWX88ooN+Z3rtUiqgcYtAxX4a0Ue0EMwAuV
VLSntjei6EZXmEEbHkSX14hCzi+ETAhJosBatsVDTF5pyp+jqzPHhBGmdn+UbxS1
DBRxX8XKKtAFcSRsjNHYd9X5X7nMaA==
=zF0X
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--


