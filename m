Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832BC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE222080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bcm1s08g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE222080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybDw-0006X4-JL
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iybCN-0005LO-0r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iybCL-0005Hp-GU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:51:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iybCL-0005HR-C8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580734288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/47H+Vfavnn/3nU5B2iZ2ovOzeoGcOk/utJ0zBqcopA=;
 b=Bcm1s08gCfzfxxsPXvt+wUFekZ6nxjvYGl6RZeeqSG51ybgxI/OirryhpPleUYPkT0SynX
 Ap6e4OOsaiULq+NKJKgTEhGNA7J7dwNvSofiDXTeTPb2S0Frtf2+aBSWd5AD5xC9QqZWnW
 WQGyC3pWnMh04BrbYxrzcnzupYdaXeE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-8qlGkq8qM1SDnBjeuq_9yA-1; Mon, 03 Feb 2020 07:51:27 -0500
Received: by mail-qv1-f70.google.com with SMTP id f17so9361693qvi.6
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aLlgORxXW9Z3fkYP9HZlPq6IbanR8uG9t4QGCpd+sP8=;
 b=OWbIL4p1T7BEpyX/zooOsvWDG1k15hW+dJ+79rduqzf2fUBGGFaIsmZpYnjATCLkB9
 0IbIx/N/L07OOoARTglELcrATlcbxktLgWoK6wmXebgUNCLmfOmH6XmVF6/4I+z2aLTJ
 LkPzNXbsVJ7BAj/2vdJl/Byq8VDwWmIjcBeBusmLF6QFZ3QkTnG+F+5/eQmWlHM3LSm/
 2af/TCwLnlJ52ux3GYGkFt4uFCCNclWgACTKXekFKZ/iHIEAM1/kWOW1SwFJ98dl4seD
 z+4V1z0IMXZiWh1UzG8em/54DxXGzEw/nCFZ7+JMLezXolx+1f8x7esAr5LgfW+g7zBz
 PnNw==
X-Gm-Message-State: APjAAAXdM6TRZpWVXms6rj9w1Y+CuIoNnU1d8ibhpYXAnNSakvoBYG38
 7GuVoCgSMalFyq/k7+uyMY88uqF3MtinDNGW5jv3A3MfFe0lzNfE+xVxTP+lyMT0ZduNExnlN96
 a1C8o1XLoqfhSXNI=
X-Received: by 2002:a05:620a:b0f:: with SMTP id
 t15mr23004942qkg.135.1580734285438; 
 Mon, 03 Feb 2020 04:51:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoq76VXEqkqI6NN7fvOazOf9xGczU3KBLRPcuvxcMX8chMd8foOh4Whlyobiamsw06b4Wubw==
X-Received: by 2002:a05:620a:b0f:: with SMTP id
 t15mr23004921qkg.135.1580734285190; 
 Mon, 03 Feb 2020 04:51:25 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id r6sm9577717qtm.63.2020.02.03.04.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 04:51:24 -0800 (PST)
Date: Mon, 3 Feb 2020 07:51:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 1/4] virtio: introduce VIRTQUEUE_DEFUALT_SIZE instead
 of hardcoded constants
Message-ID: <20200203075041-mutt-send-email-mst@kernel.org>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-2-dplotnikov@virtuozzo.com>
 <20200130083800-mutt-send-email-mst@kernel.org>
 <ad737ab5-2931-0a56-20d2-abc2bbf1838a@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <ad737ab5-2931-0a56-20d2-abc2bbf1838a@virtuozzo.com>
X-MC-Unique: 8qlGkq8qM1SDnBjeuq_9yA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 03:17:07PM +0300, Denis Plotnikov wrote:
>=20
>=20
> On 30.01.2020 16:38, Michael S. Tsirkin wrote:
> > On Wed, Jan 29, 2020 at 05:06:59PM +0300, Denis Plotnikov wrote:
> > > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >=20
> > I'm not sure what the point is. It's more or less an accident that
> > these two devices share the queue size, this constance
> > makes no sense to me.
> Ok, then let's just make a separate queue length constant for each type.

it's just a number, I don't think we need a constant here.
If you feel it needs documentation, add a comment!

> (Will redo and send in the next series)
> Thanks!
>=20
> Denis
> >=20
> > > ---
> > >   hw/block/virtio-blk.c      | 6 ++++--
> > >   hw/scsi/virtio-scsi.c      | 5 +++--
> > >   include/hw/virtio/virtio.h | 1 +
> > >   3 files changed, 8 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index 09f46ed85f..72f935033f 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -914,7 +914,8 @@ static void virtio_blk_update_config(VirtIODevice=
 *vdev, uint8_t *config)
> > >       memset(&blkcfg, 0, sizeof(blkcfg));
> > >       virtio_stq_p(vdev, &blkcfg.capacity, capacity);
> > >       virtio_stl_p(vdev, &blkcfg.seg_max,
> > > -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 1=
28 - 2);
> > > +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 :
> > > +                                          VIRTQUEUE_DEFAULT_SIZE - 2=
);
> > >       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
> > >       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
> > >       virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk=
_size);
> > > @@ -1272,7 +1273,8 @@ static Property virtio_blk_properties[] =3D {
> > >       DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_me=
rging, 0,
> > >                       true),
> > >       DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, =
1),
> > > -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 1=
28),
> > > +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size,
> > > +                       VIRTQUEUE_DEFAULT_SIZE),
> > >       DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_ad=
just, true),
> > >       DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_I=
OTHREAD,
> > >                        IOThread *),
> > > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > > index 3b61563609..36f66046ae 100644
> > > --- a/hw/scsi/virtio-scsi.c
> > > +++ b/hw/scsi/virtio-scsi.c
> > > @@ -660,7 +660,8 @@ static void virtio_scsi_get_config(VirtIODevice *=
vdev,
> > >       virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
> > >       virtio_stl_p(vdev, &scsiconf->seg_max,
> > > -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2=
 : 128 - 2);
> > > +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2=
 :
> > > +                                          VIRTQUEUE_DEFAULT_SIZE - 2=
);
> > >       virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors)=
;
> > >       virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun)=
;
> > >       virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCS=
IEvent));
> > > @@ -965,7 +966,7 @@ static void virtio_scsi_device_unrealize(DeviceSt=
ate *dev, Error **errp)
> > >   static Property virtio_scsi_properties[] =3D {
> > >       DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.nu=
m_queues, 1),
> > >       DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
> > > -                                         parent_obj.conf.virtqueue_s=
ize, 128),
> > > +                       parent_obj.conf.virtqueue_size, VIRTQUEUE_DEF=
AULT_SIZE),
> > >       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
> > >                         parent_obj.conf.seg_max_adjust, true),
> > >       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.m=
ax_sectors,
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > index b69d517496..a66ea2368b 100644
> > > --- a/include/hw/virtio/virtio.h
> > > +++ b/include/hw/virtio/virtio.h
> > > @@ -48,6 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature=
 *features,
> > >   typedef struct VirtQueue VirtQueue;
> > >   #define VIRTQUEUE_MAX_SIZE 1024
> > > +#define VIRTQUEUE_DEFAULT_SIZE 128
> > >   typedef struct VirtQueueElement
> > >   {
> > > --=20
> > > 2.17.0


