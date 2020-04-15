Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAECC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521072051A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSQ8QxDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521072051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOd7m-0005Eo-HY
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jOd6Q-0003dM-2A
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jOd6O-0006J0-K9
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:08:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jOd6O-0006Ik-GN
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586938135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kFIDMmS0V+vHoRxJmDqhJOL9LNFqJPHzLRIQJXvX3rs=;
 b=fSQ8QxDNpBalWKZPavTH7SlLm2DvGe2zdYMSXoDfbxZ4MZXgNa6U20/lf6/Vuz3dzwpPNL
 KAqgtLez1NVmEBadN9mOp3UVsmOGA2wtqoyvHlQSeGWr6JY34uzGifK1XsaPcJ628//qOn
 LAmDlQVhZ2YYCvepRDyvLKCGjD4+CbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-97OaqWjjNPy9phP3eWJ_9g-1; Wed, 15 Apr 2020 04:08:52 -0400
X-MC-Unique: 97OaqWjjNPy9phP3eWJ_9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E28E107ACC4;
 Wed, 15 Apr 2020 08:08:51 +0000 (UTC)
Received: from [10.36.114.144] (ovpn-114-144.ams2.redhat.com [10.36.114.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5F8899DEE;
 Wed, 15 Apr 2020 08:08:47 +0000 (UTC)
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
To: Alexander Duyck <alexander.duyck@gmail.com>, pbonzini@redhat.com,
 mst@redhat.com
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034129.24738.36022.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <b6f97131-89dc-064a-5b87-2bf68437176d@redhat.com>
Date: Wed, 15 Apr 2020 10:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410034129.24738.36022.stgit@localhost.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.04.20 05:41, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> We need to make certain to advertise support for page poison tracking if
> we want to actually get data on if the guest will be poisoning pages. So
> if free page hinting is active we should add page poisoning support and
> let the guest disable it if it isn't using it.
>=20
> Page poisoning will result in a page being dirtied on free. As such we
> cannot really avoid having to copy the page at least one more time since
> we will need to write the poison value to the destination. As such we can
> just ignore free page hinting if page poisoning is enabled as it will
> actually reduce the work we have to do.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  hw/virtio/virtio-balloon.c         |   26 ++++++++++++++++++++++----
>  include/hw/virtio/virtio-balloon.h |    1 +
>  2 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7fc930..1c6d36a29a04 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -531,6 +531,15 @@ static void virtio_balloon_free_page_start(VirtIOBal=
loon *s)
>          return;
>      }
> =20
> +    /*
> +     * If page poisoning is enabled then we probably shouldn't bother wi=
th
> +     * the hinting since the poisoning will dirty the page and invalidat=
e
> +     * the work we are doing anyway.
> +     */
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {

Why not check for the poison value instead? (as you do in patch #3) ?

> +        return;
> +    }
> +
>      if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
>          s->free_page_report_cmd_id =3D
>                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;

We should rename all "free_page_report" stuff we can to
"free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
side :) ) before adding free page reporting .

(looking at the virtio-balloon linux header, it's also confusing but
we're stuck with that - maybe we should add better comments)


> @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(VirtIOBall=
oon *s)
>      if (s->qemu_4_0_config_size) {
>          return sizeof(struct virtio_balloon_config);
>      }
> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON) ||
> +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          return sizeof(struct virtio_balloon_config);
>      }
> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> -        return offsetof(struct virtio_balloon_config, poison_val);
> -    }

I am not sure this change is completely sane. Why is that necessary at all?

>      return offsetof(struct virtio_balloon_config, free_page_report_cmd_i=
d);
>  }
> =20
> @@ -634,6 +641,7 @@ static void virtio_balloon_get_config(VirtIODevice *v=
dev, uint8_t *config_data)
> =20
>      config.num_pages =3D cpu_to_le32(dev->num_pages);
>      config.actual =3D cpu_to_le32(dev->actual);
> +    config.poison_val =3D cpu_to_le32(dev->poison_val);
> =20
>      if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_REQUESTED=
) {
>          config.free_page_report_cmd_id =3D
> @@ -697,6 +705,9 @@ static void virtio_balloon_set_config(VirtIODevice *v=
dev,
>          qapi_event_send_balloon_change(vm_ram_size -
>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_=
SHIFT));
>      }
> +    dev->poison_val =3D virtio_vdev_has_feature(vdev,
> +                                              VIRTIO_BALLOON_F_PAGE_POIS=
ON) ?
> +                      le32_to_cpu(config.poison_val) : 0;

Can we just do a


dev->poison_val =3D 0;
if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
=09dev->poison_val =3D le32_to_cpu(config.poison_val);
}

instead?


>      trace_virtio_balloon_set_config(dev->actual, oldactual);
>  }
> =20
> @@ -706,6 +717,9 @@ static uint64_t virtio_balloon_get_features(VirtIODev=
ice *vdev, uint64_t f,
>      VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
>      f |=3D dev->host_features;
>      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> +    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> +        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
> +    }
> =20
>      return f;
>  }
> @@ -854,6 +868,8 @@ static void virtio_balloon_device_reset(VirtIODevice =
*vdev)
>          g_free(s->stats_vq_elem);
>          s->stats_vq_elem =3D NULL;
>      }
> +
> +    s->poison_val =3D 0;
>  }
> =20
>  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status=
)
> @@ -916,6 +932,8 @@ static Property virtio_balloon_properties[] =3D {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("x-page-poison", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_PAGE_POISON, false),

Just curious, why an x- feature?


--=20
Thanks,

David / dhildenb


