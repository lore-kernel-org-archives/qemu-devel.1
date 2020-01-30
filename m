Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36247C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054542082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClGB7r53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054542082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixA34-0004XQ-50
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ixA27-0003VU-9R
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ixA26-0000To-3I
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:38:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58054
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ixA25-0000RU-Uo
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580391537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApvsHQ46Z4leAMYdyTfd91cqsfgfCIbzOR9iSXX5oU0=;
 b=ClGB7r5312Hff4rTtRaDIBJu+C9zs7aUWXqO5yl36mqnly1mr7K8ESD5y+os8Ta/wvdKvw
 Kc+bQwpD9WtWZtjmlRUGs4VHj6c1YDLyvP3QBpofKUUxFpD2A+FPPPufiaOqdRLUz4I5gq
 JeQ83K/yX2YzHKfx97luirSt9IQGSTE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-l53CCl_CPQKBGL6eWpUQig-1; Thu, 30 Jan 2020 08:38:55 -0500
Received: by mail-wr1-f70.google.com with SMTP id f10so1729019wro.14
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Eh1tJCW7UJpAe8VpCuZzDiweV5bTarAjItj41HZHN2g=;
 b=AJP6I77uPXt6wgmVfdue5eOX9Ry0OB/sEk+kXoYHoc8N5ImQVjYXYxfxLsvOxFg/61
 2ThLf1Bg1t/Juwr0d6eJFjfGEjKhdKeCOfbciQWAdX67jFV99JL1w+/0e2l3D22sv9Rb
 R8eH6xbNlivVbfRHFlLqIAqtaRC+hWQifxfr37BRshB3U3Ud8MXM4+iQd2kSBJT3IlKv
 +uLMRzeyiyVQLawru4qKpsJaTR6lsNE6MQMw37zST5g5d8tbW7eOn06Jaf8yF6a2i4a0
 KRmTUmBzTFdRc/LVJiwDSKaY8AY8IvD9ExwT7tukYrjXWdYSOW9Ejm35gGByJX/Dkv/i
 BAIw==
X-Gm-Message-State: APjAAAW7rUIQaZnYDAyY13lTgYirx/jdD/oKHiXjKZW/orY0e8HTSM4j
 C8dQx+BDgA/0sVZoKhi5l/JIMzMWfL9w2mKB+AL8vjAMCpyedLihOYGKuCHSddm6qaLWpscTtwd
 naRQT9lsDCSw+byY=
X-Received: by 2002:a1c:4857:: with SMTP id v84mr5763132wma.8.1580391532527;
 Thu, 30 Jan 2020 05:38:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2NHJQdKTP0N6Ml7YeiFLxT7w3lA/J/nc4VWSEvskVmOnrrcCKbYycmGR7VtUaNLF/dcM+7g==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr5763108wma.8.1580391532281;
 Thu, 30 Jan 2020 05:38:52 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id y139sm6489280wmd.24.2020.01.30.05.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 05:38:51 -0800 (PST)
Date: Thu, 30 Jan 2020 08:38:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 1/4] virtio: introduce VIRTQUEUE_DEFUALT_SIZE instead
 of hardcoded constants
Message-ID: <20200130083800-mutt-send-email-mst@kernel.org>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200129140702.5411-2-dplotnikov@virtuozzo.com>
X-MC-Unique: l53CCl_CPQKBGL6eWpUQig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Wed, Jan 29, 2020 at 05:06:59PM +0300, Denis Plotnikov wrote:
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>


I'm not sure what the point is. It's more or less an accident that
these two devices share the queue size, this constance
makes no sense to me.

> ---
>  hw/block/virtio-blk.c      | 6 ++++--
>  hw/scsi/virtio-scsi.c      | 5 +++--
>  include/hw/virtio/virtio.h | 1 +
>  3 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 09f46ed85f..72f935033f 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -914,7 +914,8 @@ static void virtio_blk_update_config(VirtIODevice *vd=
ev, uint8_t *config)
>      memset(&blkcfg, 0, sizeof(blkcfg));
>      virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>      virtio_stl_p(vdev, &blkcfg.seg_max,
> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 -=
 2);
> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 :
> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>      virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size=
);
> @@ -1272,7 +1273,8 @@ static Property virtio_blk_properties[] =3D {
>      DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging=
, 0,
>                      true),
>      DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
> +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size,
> +                       VIRTQUEUE_DEFAULT_SIZE),
>      DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust,=
 true),
>      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHRE=
AD,
>                       IOThread *),
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 3b61563609..36f66046ae 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -660,7 +660,8 @@ static void virtio_scsi_get_config(VirtIODevice *vdev=
,
> =20
>      virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
>      virtio_stl_p(vdev, &scsiconf->seg_max,
> -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 1=
28 - 2);
> +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 :
> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>      virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>      virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>      virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEven=
t));
> @@ -965,7 +966,7 @@ static void virtio_scsi_device_unrealize(DeviceState =
*dev, Error **errp)
>  static Property virtio_scsi_properties[] =3D {
>      DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_que=
ues, 1),
>      DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
> -                                         parent_obj.conf.virtqueue_size,=
 128),
> +                       parent_obj.conf.virtqueue_size, VIRTQUEUE_DEFAULT=
_SIZE),
>      DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>                        parent_obj.conf.seg_max_adjust, true),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_se=
ctors,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b69d517496..a66ea2368b 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -48,6 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature *fe=
atures,
>  typedef struct VirtQueue VirtQueue;
> =20
>  #define VIRTQUEUE_MAX_SIZE 1024
> +#define VIRTQUEUE_DEFAULT_SIZE 128
> =20
>  typedef struct VirtQueueElement
>  {
> --=20
> 2.17.0


