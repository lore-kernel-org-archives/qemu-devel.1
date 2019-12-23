Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC97C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 14:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4741C20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 14:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKDTVig2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4741C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijOlC-0005A5-BQ
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 09:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijOkV-0004lM-UA
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijOkU-0001jC-7u
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:31:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijOkU-0001iq-2v
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 09:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577111513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjEbrkq5I7AwCTV0MjTeCwGunEyLiEosU8Gf9OG35qQ=;
 b=RKDTVig2OCR6JsxgpP5TntjPgv22oDCo/k6peXKiDkAX4xmUo+qJxvMzNlojf9NUzoaXrk
 LpqWd15g+9xEJfzBiTL9MAZnpmwKzUXwVfSnNotY7Tv+/RxsZFPvQzBqw+A3Gm0IIfSSJn
 hbAI9PYA/MAcO+GtdiU6+9scOXzc020=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-mibXu-xFOw6oK7prMr3jEg-1; Mon, 23 Dec 2019 09:31:51 -0500
Received: by mail-qt1-f198.google.com with SMTP id c8so11218256qte.22
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 06:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5Ye6Pr+cgU47B05imQ4UXVHRSegsM7Acrwn7R3odUfI=;
 b=H52JWBKg+aqusE0lJCtg7Ldz0nUaekjB+4oY5pUnI8jYGBx2r35z9ipOz0qjxp4dsU
 Akc4uG67MsWuQRBBG/XUzb4aYJE+nOyAGqEmqWvJ5bpsL+lmWxML5Utxio5ktU0mm2KQ
 sHNO/nhtQ9DbN/+vphrjSoZUGj+PgZAPzyXK1ygKhKVckm9KntgcemBCblyi5NLgTwJp
 oliAwcnXpgqM4dF5eg9f4c7Bw4n3jzYJXjj3sIarWgj1oZh3TnGwutj+x2g1tygh712K
 9nVYfDBPhAjh7EEAp+gmBAKRQkOhxqEFEpd2GbkvayLffsN9qug32sPpQOY9HMTzKlTK
 0Cog==
X-Gm-Message-State: APjAAAWhm/jST/ypyu5+A5thc4UC0Yi0pi4bajGa+/FtifLV3i/geMvr
 D+xtJM5xZRb3fvAd/EPVqNs3h8kqi81G3cNyh84Nv+XLeQXcQBfKqRrgFgwAj7ygJclVNyxzMky
 JMks5k7MG0sreXsI=
X-Received: by 2002:ac8:1851:: with SMTP id n17mr23979351qtk.305.1577111511008; 
 Mon, 23 Dec 2019 06:31:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoiVYfxXfj52xZffKyWPByRp4IEhc16yTVh1ZoqdUs9sGegq984b9+dqjheuzSLFuPLnJeZA==
X-Received: by 2002:ac8:1851:: with SMTP id n17mr23979331qtk.305.1577111510761; 
 Mon, 23 Dec 2019 06:31:50 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 u7sm3576435qtg.13.2019.12.23.06.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 06:31:49 -0800 (PST)
Date: Mon, 23 Dec 2019 09:31:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1] virtio-pci: store virtqueue size directly to a device
Message-ID: <20191223093029-mutt-send-email-mst@kernel.org>
References: <20191223113758.11951-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191223113758.11951-1-dplotnikov@virtuozzo.com>
X-MC-Unique: mibXu-xFOw6oK7prMr3jEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: den@virtuozzo.com, qemu-devel@nongnu.org, rkagan@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 23, 2019 at 02:37:58PM +0300, Denis Plotnikov wrote:
> Currenly, the virtqueue size is saved to the proxy on pci writing and
> is read from the device pci reading.
> The virtqueue size is propagated later on form the proxy to the device
> on virqueue enabling stage.
>=20
> This could be a problem, if a guest, on the virtqueue configuration, sets
> the size and then re-read it immediatly before the queue enabling
> in order to check if the desiged size has been set.
>=20
> This happens in seabios: (sebios snippet)
>=20
> vp_find_vq()
> {
>     ...
>     /* check if the queue is available */
>     if (vp->use_modern) {
>         num =3D vp_read(&vp->common, virtio_pci_common_cfg, queue_size);
>         if (num > MAX_QUEUE_NUM) {
>             vp_write(&vp->common, virtio_pci_common_cfg, queue_size,
>                      MAX_QUEUE_NUM);
>             num =3D vp_read(&vp->common, virtio_pci_common_cfg, queue_siz=
e);
>         }
>     } else {
>         num =3D vp_read(&vp->legacy, virtio_pci_legacy, queue_num);
>     }
>     if (!num) {
>         dprintf(1, "ERROR: queue size is 0\n");
>         goto fail;
>     }
>     if (num > MAX_QUEUE_NUM) {
>         dprintf(1, "ERROR: queue size %d > %d\n", num, MAX_QUEUE_NUM);
>         goto fail;
>     }
>     ...
> }
>=20
> If the device queue num is greater then the max queue size supported by s=
eabios,
> seabios tries to reduce the queue size, then re-read it again, I suppose =
to
> check if the setting actually happens, and then checks the virtqueue size=
 again,
> to deside whether it is satisfied with the vaule.
> In this case, if device's virtqueue size is 512 and seabios max supported=
 queue
> size is 256, seabios tries to set 256 but than read 512 again and can't p=
roceed
> with that vaule, preventing the guest from successful booting.
> The root case was investigated by Roman Kagan <rkagan@virtuozzo.com>
>=20
> The patch fixes the problem, by propagating the queue size to the device =
right
> away, so the written value could be read on the next step, if the value w=
as
> ok for the device.
>=20
> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

Thanks, I already have this queued as:

commit 8aabbbd9d04f95d5581d2275362996ecb5516dd9
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Fri Dec 13 09:22:48 2019 -0500

    virtio: update queue size on guest write
   =20
    Some guests read back queue size after writing it.
    Update the size immediatly upon write otherwise
    they get confused.
   =20
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I would appreciate checking other transports, they likely
need the same fix.


> ---
>  hw/virtio/virtio-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c6b47a9c73..e5c759e19e 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1256,6 +1256,8 @@ static void virtio_pci_common_write(void *opaque, h=
waddr addr,
>          break;
>      case VIRTIO_PCI_COMMON_Q_SIZE:
>          proxy->vqs[vdev->queue_sel].num =3D val;
> +        virtio_queue_set_num(vdev, vdev->queue_sel,
> +                             proxy->vqs[vdev->queue_sel].num);
>          break;
>      case VIRTIO_PCI_COMMON_Q_MSIX:
>          msix_vector_unuse(&proxy->pci_dev,
> --=20
> 2.17.0


