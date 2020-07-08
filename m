Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAA9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F0220772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gktkyhqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F0220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIZy-00032w-OS
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIEm-0007XF-Iz
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:08:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIEk-0007XO-LM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+ttr32z6Bgh0aepTpDFjD/3vB8/iYZZG1FyuCX/euQ=;
 b=GktkyhqipZYP1sEbQ/S38vJ+EZ+Hs42oFFR6tgvs14mfkQbZJbStxy+W0U3F7r5L+jRAmc
 nI5sW33xk7uFWxOBXjbSNbwoa6xB2/jZEhzniuxhVy/qnPx9A9iEXsep4pe+qIGB9n0YKi
 YUZ2ySwHd8x/Wxjr1oYDt/+cNu6ber8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-eEnMhgpJPku_t1HFa_bYNg-1; Wed, 08 Jul 2020 09:05:32 -0400
X-MC-Unique: eEnMhgpJPku_t1HFa_bYNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC55788C797;
 Wed,  8 Jul 2020 13:05:30 +0000 (UTC)
Received: from localhost (ovpn-115-17.ams2.redhat.com [10.36.115.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C86D7846C;
 Wed,  8 Jul 2020 13:05:27 +0000 (UTC)
Date: Wed, 8 Jul 2020 14:05:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200708130526.GD487183@stefanha-x1.localdomain>
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-4-stefanha@redhat.com>
 <20200707174453.50c3ec85.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200707174453.50c3ec85.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
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

--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2020 at 05:44:53PM +0200, Cornelia Huck wrote:
> On Mon,  6 Jul 2020 14:56:48 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> Maybe mention 'pci' in the subject as well?

I think this patch does too many things. I'll split up the generic and
PCI parts so that the commit message is more accurate.

> > Automatically size the number of virtio-scsi-pci, vhost-scsi-pci, and
> > vhost-user-scsi-pci request virtqueues to match the number of vCPUs.
> > Other transports continue to default to 1 request virtqueue.
> >=20
> > A 1:1 virtqueue:vCPU mapping ensures that completion interrupts are
> > handled on the same vCPU that submitted the request.  No IPI is
> > necessary to complete an I/O request and performance is improved.  The
> > maximum number of MSI-X vectors and virtqueues limit are respected.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/hw/virtio/virtio-scsi.h |  2 ++
> >  hw/core/machine.c               |  3 +++
> >  hw/scsi/vhost-scsi.c            |  3 ++-
> >  hw/scsi/vhost-user-scsi.c       |  3 ++-
> >  hw/scsi/virtio-scsi.c           |  6 +++++-
> >  hw/virtio/vhost-scsi-pci.c      | 10 +++++++---
> >  hw/virtio/vhost-user-scsi-pci.c | 10 +++++++---
> >  hw/virtio/virtio-scsi-pci.c     | 10 +++++++---
> >  8 files changed, 35 insertions(+), 12 deletions(-)
>=20
> (...)
>=20
> > diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
> > index 3ff9eb7ef6..fa4b3bfb50 100644
> > --- a/hw/virtio/virtio-scsi-pci.c
> > +++ b/hw/virtio/virtio-scsi-pci.c
> > @@ -46,13 +46,17 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy =
*vpci_dev, Error **errp)
> >  {
> >      VirtIOSCSIPCI *dev =3D VIRTIO_SCSI_PCI(vpci_dev);
> >      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> >      DeviceState *proxy =3D DEVICE(vpci_dev);
> > +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.conf;
> >      char *bus_name;
> > =20
> > +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > +        conf->num_queues =3D
> > +            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
> > +    }
> > +
> >      if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> > -        vpci_dev->nvectors =3D vs->conf.num_queues +
> > -                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
> > +        vpci_dev->nvectors =3D conf->num_queues + VIRTIO_SCSI_VQ_NUM_F=
IXED + 1;
> >      }
> > =20
> >      /*
>=20
> One corner case where the setup may end up being a bit odd is a
> situation where nvectors was specified, but num_queues was not, and the
> device suddenly ends up with more queues than vectors. But I don't see
> a reason why you would want to specify nvectors but not num_queues in a
> real word scenario, so I think we can ignore that corner case.

I agree, I've ignored that case. Other options include printing a
warning or even an error when num_queues disagrees with nvectors.

> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8FxJYACgkQnKSrs4Gr
c8hm3Af/UZ8zREP+OtdcXNPkzTW0qtTrWNA0n03akdKUDtrydgriLIzou1etv+Aa
PPpfi+7J1UD2QiNaTBxmqM+MQnpEEOtcdlbfB0EcDC0yx7czzqBNbMn8nuL18//+
jwpBHbLRbjmItf+lU+3WSu7CYTa4EAeTPYmjgXGwAlxYeYchDDikVHWMl89oG+3I
VdfSncSKD+/d3YJ/uIbp2ydc8MVrWDITW/q3cvaOqs3D1xAowLav20WpNtKo8cga
ssrqySJAEsqpJDY4/IXlG92m78nSOMj83auZCP6CxY2IrBsmELwlsvsNjSIGteRw
5a5zU3LZiX9uwH9PvvY4/rusAxWUGA==
=DREa
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--


