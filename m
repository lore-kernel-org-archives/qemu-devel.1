Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD38C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6966206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTegNK//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6966206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBFc-0004gs-UU
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixBF3-00049z-IF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixBF2-0003Oo-E5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:56:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixBF2-0003OL-A5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580396183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M88F4fkd9U+zCQu69rBJqXzO41z6vEzgJlJNs7zQOMw=;
 b=GTegNK//eXvz3RCOT6gNARrBghlMDGpIK4ZGhBkcdyaRNwYbFJiVWoFKwDvSbXoc2Rq1Zh
 ABcj5a2RhgP9pcCtYAYLE8/w2Y/gbLhH0lnPpXE1PHuqivqetcv5lwIrPrpo7zbd6QGLUi
 uMH2FqBVYoME5POEyzlifABD0bbnBKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-3QjkBPQbO4itBn6bOFn-1g-1; Thu, 30 Jan 2020 09:56:19 -0500
X-MC-Unique: 3QjkBPQbO4itBn6bOFn-1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2363B8010CB;
 Thu, 30 Jan 2020 14:56:18 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FF725C1B2;
 Thu, 30 Jan 2020 14:56:14 +0000 (UTC)
Date: Thu, 30 Jan 2020 14:56:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 1/4] virtio: introduce VIRTQUEUE_DEFUALT_SIZE instead
 of hardcoded constants
Message-ID: <20200130145613.GG180311@stefanha-x1.localdomain>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-2-dplotnikov@virtuozzo.com>
 <20200129185518.5c7216be.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200129185518.5c7216be.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 06:55:18PM +0100, Cornelia Huck wrote:
> On Wed, 29 Jan 2020 17:06:59 +0300
> Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:
>=20
> > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > ---
> >  hw/block/virtio-blk.c      | 6 ++++--
> >  hw/scsi/virtio-scsi.c      | 5 +++--
> >  include/hw/virtio/virtio.h | 1 +
> >  3 files changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 09f46ed85f..72f935033f 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -914,7 +914,8 @@ static void virtio_blk_update_config(VirtIODevice *=
vdev, uint8_t *config)
> >      memset(&blkcfg, 0, sizeof(blkcfg));
> >      virtio_stq_p(vdev, &blkcfg.capacity, capacity);
> >      virtio_stl_p(vdev, &blkcfg.seg_max,
> > -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128=
 - 2);
> > +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 :
> > +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
> >      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
> >      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
> >      virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_si=
ze);
> > @@ -1272,7 +1273,8 @@ static Property virtio_blk_properties[] =3D {
> >      DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_mergi=
ng, 0,
> >                      true),
> >      DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> > -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128=
),
> > +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size,
> > +                       VIRTQUEUE_DEFAULT_SIZE),
> >      DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjus=
t, true),
> >      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTH=
READ,
> >                       IOThread *),
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index 3b61563609..36f66046ae 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -660,7 +660,8 @@ static void virtio_scsi_get_config(VirtIODevice *vd=
ev,
> > =20
> >      virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
> >      virtio_stl_p(vdev, &scsiconf->seg_max,
> > -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 :=
 128 - 2);
> > +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 :
> > +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
> >      virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
> >      virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
> >      virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEv=
ent));
> > @@ -965,7 +966,7 @@ static void virtio_scsi_device_unrealize(DeviceStat=
e *dev, Error **errp)
> >  static Property virtio_scsi_properties[] =3D {
> >      DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_q=
ueues, 1),
> >      DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
> > -                                         parent_obj.conf.virtqueue_siz=
e, 128),
> > +                       parent_obj.conf.virtqueue_size, VIRTQUEUE_DEFAU=
LT_SIZE),
> >      DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
> >                        parent_obj.conf.seg_max_adjust, true),
> >      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_=
sectors,
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index b69d517496..a66ea2368b 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -48,6 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature *=
features,
> >  typedef struct VirtQueue VirtQueue;
> > =20
> >  #define VIRTQUEUE_MAX_SIZE 1024
> > +#define VIRTQUEUE_DEFAULT_SIZE 128
>=20
> Going from the header only, this looks like a value that is supposed to
> be used for every virtqueue... but from the users, this is only for blk
> and scsi.
>=20
> I don't think adding a default for everything makes sense, even if the
> same value makes sense for blk and scsi.

Agreed, this value is too general.  VIRTIO_BLK_VQ_DEFAULT_SIZE and
VIRTIO_SCSI_VQ_DEFAULT_SIZE would make sense to me.

Stefan

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4y7o0ACgkQnKSrs4Gr
c8g1aQf+OMOVAdRWEZ/3hsy/fBrgrPCm3MWnRjwG1L42b+rhy0IYi3HZ6E1QJijW
RSRWlDaShnshx/AyZOZlTPJZJZl87ofqGxdDqovabF1N3OlR+05SMnh5U9LTedD6
kUhQAftLnbO98Fh72ZLvoeyaZxsrbsVT6cleriGOLVaRDwTE5bBiQF/mIvE+9kFb
sQQqM18YYDfASLU0VxNp+YK91SpzrmapptUfFocBgN25YvLF42kBpxjRUKXiYY+h
35KRsLa5wpZ3RYGCOYqpHYsuFDjYXJg4jk15mU4gR8CKTSBCHV0/v9adfys4GEqQ
ybV8Yn8yIutXqa8wsYKJCMOMyd6uzA==
=D+GJ
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--


