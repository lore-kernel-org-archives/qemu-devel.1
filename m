Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE5AC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383C52073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7RynTkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383C52073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1uBh-0005Jz-Bw
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 10:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j1uAw-0004Xd-Ga
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j1uAu-0001HQ-TV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:43:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j1uAu-0001Gt-MM; Wed, 12 Feb 2020 10:43:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so2959501wru.3;
 Wed, 12 Feb 2020 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sk32ayHX+ikTxsYcTip/rlVp7dhTAj/JE7Z9lTTAc5o=;
 b=N7RynTkXgkpNOZ3bdGTyMlAX6xWBlyaSuj9s0/YTRxhy3yheeXkuWBrSqbJe7iuctu
 PtmuwR+3J17fW0pUbCQfn8JTT5JuERfXdF0N7ZQ2BgfwyqzeCTnIMl56EWRINhLYkhS5
 pWrpAOke3ZOUeidtBYrOKHym8RmH+0g0DLptBA4zFq5/oQOJO6wXgEYQOFzwvYZG4pBF
 WwQ4m5JM36fNbV220cUBilzbodWw5t8DA1gjWBwdRmaBHGzhCVHqYiIndhDMT9FYiix/
 W12lSQok1MZgvn90vPsntEastaQUeiMCW+b34p3gF8CerGo+8aaS31qODcygxV717pjm
 t+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sk32ayHX+ikTxsYcTip/rlVp7dhTAj/JE7Z9lTTAc5o=;
 b=SaoSwfzLioy9nQKLaHZdEyfJgtPRDY/jotvjKXdnoM48WXcPEUYGxurjKFn5uEl0EY
 NTozStAm4gtYmWQgRRNeFcUTiEDgQ00rntxyHczRkoCvrB2zW1JR+HAqBtKPj/rpLxG5
 8G/Dbp3SYsk54CFiL/8ddq1TlP6zV8mjLSoYUf5Ol8o265YUqwaEhguIG0FPBdUBmxZ6
 XcsUGOA6i5KCZidaMd6FSyfk8c3s2lSQY+cndkGatMF5m/7p65OF4VKK/I2xe8LcCVPU
 2e3alUMpKUvtUTU+qhhrkX9uU1CF/yWOwdljv9DsZxlyW+/8W8BacpE87ZAKBHkgVFi1
 XNcQ==
X-Gm-Message-State: APjAAAWmxUmWyhvDFilP/RffFnwmj4Pz1uoOFiX3jbT+9fqeEUglhVBD
 KnsPPK9FNho8hxMava5Ibh0=
X-Google-Smtp-Source: APXvYqwfhODxlH98XRV8cKW7IrzWMC2J47dZ08jhdpIYWGfp/WwG9pCBu5f2VZOSdf3j1viOsfDFGA==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr15252316wro.375.1581522219443; 
 Wed, 12 Feb 2020 07:43:39 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t9sm1161659wrv.63.2020.02.12.07.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 07:43:38 -0800 (PST)
Date: Wed, 12 Feb 2020 15:43:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
Message-ID: <20200212154337.GG432724@stefanha-x1.localdomain>
References: <20200211141414.12149-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <20200211141414.12149-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 05:14:14PM +0300, Denis Plotnikov wrote:
> The goal is to reduce the amount of requests issued by a guest on
> 1M reads/writes. This rises the performance up to 4% on that kind of
> disk access pattern.
>=20
> The maximum chunk size to be used for the guest disk accessing is
> limited with seg_max parameter, which represents the max amount of
> pices in the scatter-geather list in one guest disk request.
>=20
> Since seg_max is virqueue_size dependent, increasing the virtqueue
> size increases seg_max, which, in turn, increases the maximum size
> of data to be read/write from a guest disk.
>=20
> More details in the original problem statment:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/block/virtio-blk.c | 4 ++--
>  hw/core/machine.c     | 2 ++
>  hw/scsi/virtio-scsi.c | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 09f46ed85f..6df3a7a6df 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -914,7 +914,7 @@ static void virtio_blk_update_config(VirtIODevice *vd=
ev, uint8_t *config)
>      memset(&blkcfg, 0, sizeof(blkcfg));
>      virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>      virtio_stl_p(vdev, &blkcfg.seg_max,
> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 -=
 2);
> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 256 -=
 2);

This value must not change on older machine types.  So does this patch
need to turn seg-max-adjust *on* in hw_compat_4_2 so that old machine
types get 126 instead of 254?

>      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>      virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size=
);
> @@ -1272,7 +1272,7 @@ static Property virtio_blk_properties[] =3D {
>      DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging=
, 0,
>                      true),
>      DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
> +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 256),
>      DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust,=
 true),
>      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHRE=
AD,
>                       IOThread *),
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2501b540ec..3427d6cf4c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,8 @@
>  #include "hw/mem/nvdimm.h"
> =20
>  GlobalProperty hw_compat_4_2[] =3D {
> +    { "virtio-blk-device", "queue-size", "128"},
> +    { "virtio-scsi-device", "virtqueue_size", "128"},
>      { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
>      { "virtio-blk-device", "seg-max-adjust", "off"},
>      { "virtio-scsi-device", "seg_max_adjust", "off"},
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 3b61563609..b38f50a429 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -660,7 +660,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
> =20
>      virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
>      virtio_stl_p(vdev, &scsiconf->seg_max,
> -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 1=
28 - 2);
> +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 2=
56 - 2);
>      virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>      virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>      virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEven=
t));
> @@ -965,7 +965,7 @@ static void virtio_scsi_device_unrealize(DeviceState =
*dev, Error **errp)
>  static Property virtio_scsi_properties[] =3D {
>      DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_que=
ues, 1),
>      DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
> -                                         parent_obj.conf.virtqueue_size,=
 128),
> +                                         parent_obj.conf.virtqueue_size,=
 256),
>      DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>                        parent_obj.conf.seg_max_adjust, true),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_se=
ctors,
> --=20
> 2.17.0
>=20
>=20

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5EHSkACgkQnKSrs4Gr
c8i+mwf9Fw2ohz88+ykReSJWb+/Bcq/HLTFJvNQBKvsvyZ/CM7zZV6rWEoiUcr9e
n6SurT51ROQpiHrmxGULSCRtS6zNAd75cFXCx4eunabOTD3U7FNQag6MX2Q/F/Ql
hNL0yOUIgShIQypJ2bluPV/QfStZvHM2y+7XYSXAC38sATUpoR830MmvmWRK3wfJ
BiMl8GVbh5wssVDN95wme/cbTEce9Mnsuo08sOnSMBwe+MlouuR4ztMj3eSrrhxY
S55yGaP9NvFfs03g0DFW04TCZLSI0PhmQ2RRRpXYo8OSLiyE+PNUbu3+X2IM8/Pl
54TaEjQM6AccITIudV7FYDi6nlr/7g==
=yTrC
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--

