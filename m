Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10288C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCF2218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QStekn1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCF2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvVp-0004wL-A4
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihuu1-0003h6-Hy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihutz-0002u2-Ja
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:27:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihutz-0002qv-Ad
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5C7QphVUaIbUFjXQN3OkjmPailuVPiOvXc/TAy/Ydlc=;
 b=QStekn1WZ8njQ12Xfhfx/tF34HhJ3N3NyjYneNZPGszGsPRfOlP5aza4PFvmtgcv3IBp/D
 AgGICGrwOh/+foDhLz8kUzvlLPr6OuGVc6q1v2bhcrENSDc/WW4Q5pIZZiiecc7sMuvdO8
 nIOt9j/R3qmx/bbSuP/gKn8qzm1r3Aw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-irL4ZCEwPGKTrel2NSfM5Q-1; Thu, 19 Dec 2019 07:27:32 -0500
Received: by mail-qt1-f200.google.com with SMTP id 69so3546793qtb.15
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p4olYuUtDS2uS84RVZcHbV8OmtQVV8X41cOMgowNCcc=;
 b=IcrCtsNRkb3ezp++PyajZ+GGLVabtNZjZtm5wxM6mTcC5Ij5YH25ppxAEFj5wy2ZCH
 wXoKuAl+K9sniUyD2Ehkwa7/Vyg3+D4RuCNXdFbnNrwzXXshj8jr+A7AAuZGYPTBaBeS
 J9sg7blNC6QyiCBg0h55Ub00RU6Cj4QRX+HqU4ZfhZu90d0m28CNxVQLGptsTsudQlcT
 XWgi5OKUi3oMXNdidc2CcSfz86H+yazqFKibkkSyDnKrwZCR6OYw0wcHO9/zkW9vDt/k
 ewpRr9WYOZy4POqXiAh7aF1wrheg6Sj1cKCxYJOibmDmOb25EHdb4bioHKJbwmzXF6Kb
 jr+Q==
X-Gm-Message-State: APjAAAV3Ru9RO77VcTio1D8TPIP6rAF3HpA4Yu7q0juJGdwZRW2w+y3V
 QhaUkIBXrx8cSnCz5eDsxxln77kVLHc1tmaa0oD/19qaMX9vG6k3yIzERxUnTsu6ZqU7b1BQQHc
 D7nokDFOvag/26+c=
X-Received: by 2002:a0c:a998:: with SMTP id a24mr963155qvb.11.1576758452101;
 Thu, 19 Dec 2019 04:27:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxlqz0QRYcuzsLh3ZnnfaFY31uoMAll3746OInCjzdwoQXL7fk1Wr/XmXdSjFmabzLLPaXwA==
X-Received: by 2002:a0c:a998:: with SMTP id a24mr963128qvb.11.1576758451735;
 Thu, 19 Dec 2019 04:27:31 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id u57sm1822551qth.68.2019.12.19.04.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 04:27:30 -0800 (PST)
Date: Thu, 19 Dec 2019 07:27:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v4 1/2] virtio: make seg_max virtqueue size dependent
Message-ID: <20191219072648-mutt-send-email-mst@kernel.org>
References: <20191216100451.28060-1-dplotnikov@virtuozzo.com>
 <20191216100451.28060-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191216100451.28060-2-dplotnikov@virtuozzo.com>
X-MC-Unique: irL4ZCEwPGKTrel2NSfM5Q-1
X-Mimecast-Spam-Score: 0
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 16, 2019 at 01:04:50PM +0300, Denis Plotnikov wrote:
> Before the patch, seg_max parameter was immutable and hardcoded
> to 126 (128 - 2) without respect to queue size. This has two negative eff=
ects:
>=20
> 1. when queue size is < 128, we have Virtio 1.1 specfication violation:
>    (2.6.5.3.1 Driver Requirements) seq_max must be <=3D queue_size.
>    This violation affects the old Linux guests (ver < 4.14). These guests
>    crash on these queue_size setups.
>=20
> 2. when queue_size > 128, as was pointed out by Denis Lunev <den@virtuozz=
o.com>,
>    seg_max restrics guest's block request length which affects guests'
>    performance making them issues more block request than needed.
>    https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>=20
> To mitigate this two effects, the patch adds the property adjusting seg_m=
ax
> to queue size automaticaly. Since seg_max is a guest visible parameter,
> the property is machine type managable and allows to choose between
> old (seg_max =3D 126 always) and new (seg_max =3D queue_size - 2) behavio=
rs.
>=20
> Not to change the behavior of the older VMs, prevent setting the default
> seg_max_adjust value for older machine types.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

Stefan I think you acked this already? Could you ack?

Denis could you rebase on latest master pls so I can apply?

Thanks!

> ---
>  hw/block/virtio-blk.c           |  9 ++++++++-
>  hw/core/machine.c               |  3 +++
>  hw/scsi/vhost-scsi.c            |  2 ++
>  hw/scsi/virtio-scsi.c           | 10 +++++++++-
>  include/hw/virtio/virtio-blk.h  |  1 +
>  include/hw/virtio/virtio-scsi.h |  1 +
>  6 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index d62e6377c2..0f6f8113b7 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -908,7 +908,8 @@ static void virtio_blk_update_config(VirtIODevice *vd=
ev, uint8_t *config)
>      blk_get_geometry(s->blk, &capacity);
>      memset(&blkcfg, 0, sizeof(blkcfg));
>      virtio_stq_p(vdev, &blkcfg.capacity, capacity);
> -    virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
> +    virtio_stl_p(vdev, &blkcfg.seg_max,
> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 -=
 2);
>      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>      virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size=
);
> @@ -1133,6 +1134,11 @@ static void virtio_blk_device_realize(DeviceState =
*dev, Error **errp)
>          error_setg(errp, "num-queues property must be larger than 0");
>          return;
>      }
> +    if (conf->queue_size <=3D 2) {
> +        error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
> +                   "must be > 2", conf->queue_size);
> +        return;
> +    }
>      if (!is_power_of_2(conf->queue_size) ||
>          conf->queue_size > VIRTQUEUE_MAX_SIZE) {
>          error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
> @@ -1262,6 +1268,7 @@ static Property virtio_blk_properties[] =3D {
>                      true),
>      DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
>      DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
> +    DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust,=
 true),
>      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHRE=
AD,
>                       IOThread *),
>      DEFINE_PROP_BIT64("discard", VirtIOBlock, host_features,
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 023548b4f3..bfa320387e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -29,6 +29,9 @@
> =20
>  GlobalProperty hw_compat_4_2[] =3D {
>      { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
> +    { "virtio-blk-device", "seg-max-adjust", "off"},
> +    { "virtio-scsi-device", "seg_max_adjust", "off"},
> +    { "vhost-blk-device", "seg_max_adjust", "off"},
>  };
>  const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
> =20
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index c693fc748a..26f710d3ec 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -275,6 +275,8 @@ static Property vhost_scsi_properties[] =3D {
>      DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, =
1),
>      DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueu=
e_size,
>                         128),
> +    DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_ad=
just,
> +                      true),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors=
,
>                         0xFFFF),
>      DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun=
, 128),
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index e8b2b64d09..405cb6c953 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -654,7 +654,8 @@ static void virtio_scsi_get_config(VirtIODevice *vdev=
,
>      VirtIOSCSICommon *s =3D VIRTIO_SCSI_COMMON(vdev);
> =20
>      virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
> -    virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
> +    virtio_stl_p(vdev, &scsiconf->seg_max,
> +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 1=
28 - 2);
>      virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>      virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>      virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEven=
t));
> @@ -893,6 +894,11 @@ void virtio_scsi_common_realize(DeviceState *dev,
>          virtio_cleanup(vdev);
>          return;
>      }
> +    if (s->conf.virtqueue_size <=3D 2) {
> +        error_setg(errp, "invalid virtqueue_size property (=3D %" PRIu16=
 "), "
> +                   "must be > 2", s->conf.virtqueue_size);
> +        return;
> +    }
>      s->cmd_vqs =3D g_new0(VirtQueue *, s->conf.num_queues);
>      s->sense_size =3D VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
>      s->cdb_size =3D VIRTIO_SCSI_CDB_DEFAULT_SIZE;
> @@ -949,6 +955,8 @@ static Property virtio_scsi_properties[] =3D {
>      DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_que=
ues, 1),
>      DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
>                                           parent_obj.conf.virtqueue_size,=
 128),
> +    DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
> +                      parent_obj.conf.seg_max_adjust, true),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_se=
ctors,
>                                                    0xFFFF),
>      DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_pe=
r_lun,
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
> index 9c19f5b634..1e62f869b2 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -38,6 +38,7 @@ struct VirtIOBlkConf
>      uint32_t request_merging;
>      uint16_t num_queues;
>      uint16_t queue_size;
> +    bool seg_max_adjust;
>      uint32_t max_discard_sectors;
>      uint32_t max_write_zeroes_sectors;
>      bool x_enable_wce_if_config_wce;
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-s=
csi.h
> index 122f7c4b6f..24e768909d 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -48,6 +48,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
>  struct VirtIOSCSIConf {
>      uint32_t num_queues;
>      uint32_t virtqueue_size;
> +    bool seg_max_adjust;
>      uint32_t max_sectors;
>      uint32_t cmd_per_lun;
>  #ifdef CONFIG_VHOST_SCSI
> --=20
> 2.17.0


