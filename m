Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685ABC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CFF206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCYxAaxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CFF206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkqB-0001XR-DO
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 04:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jHkpJ-0000hB-VS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jHkpI-0000Ro-Li
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:58:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jHkpI-0000RS-IH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585299532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fV6FcO2ocwek8/RaOJu7Voc0nCQlmIawMkkGM1jKSDI=;
 b=ZCYxAaxg06o8IafIfNpXVJtch00/tcnp4HkOKiBl24X7CLFiyj2xU+6WwIsFWn64uqSPHw
 DfRMJtPsx0rMR0BmWnr5yjl5M2UUWXMuAD2DCl7q2uX8LqyS+QGxORjrrMZW0b12FJU/tR
 mvHzIHLsRr9/7HeWpREU1znCW+jpNrY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-pFrmFK79PZu6MGj0UIVhhA-1; Fri, 27 Mar 2020 04:58:50 -0400
X-MC-Unique: pFrmFK79PZu6MGj0UIVhhA-1
Received: by mail-wr1-f72.google.com with SMTP id u18so4187348wrn.11
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 01:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bz63B557xxsw1NYGFECsstE5p1w7mT8NrZabh/O30VM=;
 b=emkb6zEOFK0VDKKXHFJ6UeVV5VqEtXmXJN44XIHg/q4Ewmp4jOqeOJGbvQaGnFi/DS
 9dT6p7cf5MxgRJslYURTtYZCd/Zd7EW2B3BDrdG3T1HE2yR9Guk8KKkDVjOI6Dwc3ciY
 x3zcwomfZ2Uiv5mAUd2PMKFHdWigAR4rsyCs51Ns/7WtDLe1TrRtVGAcTMjbt8UEA8iX
 U8u7WppFdGVPRC31Y5H7t6qwqcDCijORujI93LCuIjf8m5zEj5sfr9pIZK+N8/0gXRJX
 rrLgBP5etQ9VBsjdURkuP/B6cZwX2dZa2bQMZ1srMVOWOH/Ku6QQP5y2Ad9k04+x+sQV
 aXrg==
X-Gm-Message-State: ANhLgQ0d1T0+d+7wGDB/2PNhXG4qEhHTM6B1fl+5J6nn4CnyuV6BYZlO
 gaMafXzYCxSrwVlPdo3vkqNJ0jnBGIIZWgBFyR79eY7Mn5/K3va3PlOCVUca2GyLK24rK81fR73
 C25KuSrbbJJNob/8=
X-Received: by 2002:a05:600c:294:: with SMTP id
 20mr4300075wmk.30.1585299529491; 
 Fri, 27 Mar 2020 01:58:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuZ2WS7oeYtnrFQcQRrmWUiSCQnjo+ltQwMCt3TUJXDdAolr0jiK7DC1R/zOTg+qzV1jAAXeg==
X-Received: by 2002:a05:600c:294:: with SMTP id
 20mr4300048wmk.30.1585299529214; 
 Fri, 27 Mar 2020 01:58:49 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id 23sm6598920wmj.34.2020.03.27.01.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 01:58:48 -0700 (PDT)
Date: Fri, 27 Mar 2020 09:58:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v2 1/2] virtio-blk: delete vqs on the error path in
 realize()
Message-ID: <20200327085846.jxlgcaxvopytpbx2@steredhat>
References: <20200327045620.9082-1-pannengyuan@huawei.com>
 <20200327045620.9082-2-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200327045620.9082-2-pannengyuan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 12:56:19PM +0800, Pan Nengyuan wrote:
> virtio_vqs forgot to free on the error path in realize(). Fix that.
>=20
> The asan stack:
> Direct leak of 14336 byte(s) in 1 object(s) allocated from:
>     #0 0x7f58b93fd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
>     #1 0x7f58b858249d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x5562cc627f49 in virtio_add_queue /mnt/sdb/qemu/hw/virtio/virtio.=
c:2413
>     #3 0x5562cc4b524a in virtio_blk_device_realize /mnt/sdb/qemu/hw/block=
/virtio-blk.c:1202
>     #4 0x5562cc613050 in virtio_device_realize /mnt/sdb/qemu/hw/virtio/vi=
rtio.c:3615
>     #5 0x5562ccb7a568 in device_set_realized /mnt/sdb/qemu/hw/core/qdev.c=
:891
>     #6 0x5562cd39cd45 in property_set_bool /mnt/sdb/qemu/qom/object.c:223=
8
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> v2->v1:
> - Fix incorrect free in v1, it will cause a uaf.
> ---
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> ---
>  hw/block/virtio-blk.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 142863a3b2..97ba8a2187 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1204,6 +1204,9 @@ static void virtio_blk_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_blk_data_plane_create(vdev, conf, &s->dataplane, &err);
>      if (err !=3D NULL) {
>          error_propagate(errp, err);
> +        for (i =3D 0; i < conf->num_queues; i++) {
> +            virtio_del_queue(vdev, i);
> +        }
>          virtio_cleanup(vdev);
>          return;
>      }
> --=20
> 2.18.2
>=20
>=20


