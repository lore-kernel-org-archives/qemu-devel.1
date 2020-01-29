Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD85206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6+BRca2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD85206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqoh-0005Tu-LZ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 12:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwqju-0001El-Fm
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwqjr-0000MB-5G
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:02:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwqjr-0000KY-1j
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580317369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRuO0QIwwShWfyZnToG5Tfi4DKZojx5okFgJzW9Cxuk=;
 b=f6+BRca28AwOfJxXPt/TQc25aQhhRTtap5iDH9TqrhTFBurmZoK6gRAsm3yTkXRt0HoGUo
 W42VvKpcl9PZzlMP5j+ehULto5jbnjNl1C6XtMk6YPBgw8yGe/ZwjhbAtAXH/o1nh62WwQ
 zGZ9wbwazy8jnMaeQXuEgMMxDHeRHz0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-MKT13_aTMpiNbN5KkI-ADA-1; Wed, 29 Jan 2020 12:02:48 -0500
Received: by mail-wr1-f71.google.com with SMTP id z14so124826wrs.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 09:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZRTKiIzIWhYy26bQjiBl0ByPw6WmgJ/wAYWZtVVOehI=;
 b=VhhJzmsMZpzTKURIOyjbSyFKnQKvaq6ZzQ4PYBOg0hFzhwn2kVEuYtemjKPakBjQtp
 dPOE0Q0WTcRvXWAMHSrQaslg7AZkoGuc9SWYRKXSKlGqsAveUjLRRXc6dgWErgu1jja6
 3zy/UoPpH9YvuFGDMkKinfoGzRbjk+iu7HA5IZiiaZ6frnTkVl0LvTR3PbIzYVkS6KoM
 H1/HifrDt6UBa1N8ESgoNpGUtbPVvI2vrPbSr87SXXbCJuCDsKB1GrnfGGGlHgO/OwJj
 Wf2NoGn5lZSpa3h2/PyZn02I2xmxaSlMZkRP2n4RC7PDRkYxemqOrcRjB0ueMpuD2sdr
 N8hA==
X-Gm-Message-State: APjAAAW3nZYFjRsYvzxqmGTJd5b6hYVvcMgAK+vUHEPtxhmILX6psV1L
 mKrd+i+8+o0ZOh58TtXv3LtntmSP+ZeyShEaz3F+o8aqWFEK8fTaYNqIBl7sm4kH9StmGHiLcF9
 GxeEHxtBSrkbcvF8=
X-Received: by 2002:adf:fd84:: with SMTP id d4mr35916165wrr.211.1580317365629; 
 Wed, 29 Jan 2020 09:02:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxiq7ZxLYnlSLBjL0pnEXnXvkt064Gfyxh+Mngd7NuwB6RLGlharXlfzsiJyMbGmKbAGvY0ZQ==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr35916112wrr.211.1580317365114; 
 Wed, 29 Jan 2020 09:02:45 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 124sm3044489wmc.29.2020.01.29.09.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 09:02:44 -0800 (PST)
Subject: Re: [PATCH v1 1/4] virtio: introduce VIRTQUEUE_DEFUALT_SIZE instead
 of hardcoded constants
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-2-dplotnikov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <31265bbb-e8b2-d78f-2caa-f1909a755291@redhat.com>
Date: Wed, 29 Jan 2020 18:02:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129140702.5411-2-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: MKT13_aTMpiNbN5KkI-ADA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 3:06 PM, Denis Plotnikov wrote:
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

typo VIRTQUEUE_DEFUALT_SIZE -> VIRTQUEUE_DEFAULT_SIZE in subject

With subject fixed:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/block/virtio-blk.c      | 6 ++++--
>   hw/scsi/virtio-scsi.c      | 5 +++--
>   include/hw/virtio/virtio.h | 1 +
>   3 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 09f46ed85f..72f935033f 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -914,7 +914,8 @@ static void virtio_blk_update_config(VirtIODevice *vd=
ev, uint8_t *config)
>       memset(&blkcfg, 0, sizeof(blkcfg));
>       virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>       virtio_stl_p(vdev, &blkcfg.seg_max,
> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 -=
 2);
> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 :
> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>       virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_siz=
e);
> @@ -1272,7 +1273,8 @@ static Property virtio_blk_properties[] =3D {
>       DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_mergin=
g, 0,
>                       true),
>       DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
> +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size,
> +                       VIRTQUEUE_DEFAULT_SIZE),
>       DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust=
, true),
>       DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHR=
EAD,
>                        IOThread *),
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 3b61563609..36f66046ae 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -660,7 +660,8 @@ static void virtio_scsi_get_config(VirtIODevice *vdev=
,
>  =20
>       virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
>       virtio_stl_p(vdev, &scsiconf->seg_max,
> -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 1=
28 - 2);
> +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 :
> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>       virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>       virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>       virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEve=
nt));
> @@ -965,7 +966,7 @@ static void virtio_scsi_device_unrealize(DeviceState =
*dev, Error **errp)
>   static Property virtio_scsi_properties[] =3D {
>       DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_qu=
eues, 1),
>       DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
> -                                         parent_obj.conf.virtqueue_size,=
 128),
> +                       parent_obj.conf.virtqueue_size, VIRTQUEUE_DEFAULT=
_SIZE),
>       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>                         parent_obj.conf.seg_max_adjust, true),
>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_s=
ectors,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b69d517496..a66ea2368b 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -48,6 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature *fe=
atures,
>   typedef struct VirtQueue VirtQueue;
>  =20
>   #define VIRTQUEUE_MAX_SIZE 1024
> +#define VIRTQUEUE_DEFAULT_SIZE 128
>  =20
>   typedef struct VirtQueueElement
>   {
>=20


