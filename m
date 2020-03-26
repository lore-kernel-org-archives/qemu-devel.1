Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B6C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4756120714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQt6r4mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4756120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMvU-0001zX-Jx
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHMtw-0000DP-7d
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHMtu-0008RV-LJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:26:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHMtu-0008RO-GT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585207562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgpP/2gbFa87I3ugA7pHc6Dg2Oij2fZIK8qbOlkH5E0=;
 b=gQt6r4mkPS2bGxzsGKV89niHa9f/Bh22HsWxSQPW0+nms7khRF8KdLg8dNBiB8BoT3IX3q
 zK2wjudTbPpWDDfLcwnDRJSbxgD+bLTt7aZ04rZji+uhSZ5pvuOZnEjML31NAVqP7h9l1Y
 HFzoil1bN6dy5jrabN5ymVFNoitOMrM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-dt1PXUVnNuimjaXOy2C0DA-1; Thu, 26 Mar 2020 03:25:57 -0400
X-MC-Unique: dt1PXUVnNuimjaXOy2C0DA-1
Received: by mail-wm1-f69.google.com with SMTP id p18so2076361wmk.9
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 00:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tmAet5y9Rsf9NYXP19teO+owPI4djxVX4/FYjX0fovI=;
 b=ocg09YfkiWGJiJBTd8LH2helpoSksxby8034LsI6nKT4H6FqDDK3g4pyquJw/T3qSf
 snOCpEfVTZ924WjDo4e0VwkK7vjK018mun3ovvUtm6Nu1PeY6qbwOoVoJHC5rxQWyGif
 Uz64H3xdVqgXKKVIkazIvWkEW2eVGWpEs2gyNuq3MTw98GX5yMFWQWMbVgjY4NFixrMV
 5+S447NORU2Serg1ZQ9kfMyn+wxBo+2ANz5ph86s/T/LWwzlk2VZQZPD7mpFhDxf0Sh4
 S0nxjQiwqPYcvcsY5YYceZAO6vjZXTqBwEnf0wEWRhK2UjXcTiMckXPkY1nAhfMMWlKY
 3Zeg==
X-Gm-Message-State: ANhLgQ0k6oDz8Q7eedBnvgjznztCdGnpyLSVL4aaitjECzNR42vaTh8k
 49yJhqZkA6Tuk5FTunePE0r+RgGSFrBAsZ2vQN3yIMIT6zdMmuQySoVw9b2GuYV/M/P91rMVGtb
 yaiw5fwWTJEQ+/SI=
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr1602185wmc.67.1585207555834;
 Thu, 26 Mar 2020 00:25:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtpEAwYXwXt7Kx4Cbwp2baZL8Nk8/DJVO/V8R9cbwVS/CVbXpyrfZI75a3gYBwC0lpw3ilwug==
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr1602148wmc.67.1585207555488;
 Thu, 26 Mar 2020 00:25:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
 by smtp.gmail.com with ESMTPSA id c189sm2274665wmd.12.2020.03.26.00.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 00:25:54 -0700 (PDT)
Date: Thu, 26 Mar 2020 03:25:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hui Zhu <teawater@gmail.com>
Subject: Re: [PATCH for QEMU v2] virtio-balloon: Add option cont-pages to set
 VIRTIO_BALLOON_VQ_INFLATE_CONT
Message-ID: <20200326032101-mutt-send-email-mst@kernel.org>
References: <1584893097-12317-1-git-send-email-teawater@gmail.com>
 <1584893097-12317-2-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1584893097-12317-2-git-send-email-teawater@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: pagupta@redhat.com, aquini@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 namit@vmware.com, Hui Zhu <teawaterz@linux.alibaba.com>,
 akpm@linux-foundation.org, jasowang@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 12:04:57AM +0800, Hui Zhu wrote:
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> Set option cont-pages to on will open flags VIRTIO_BALLOON_VQ_INFLATE_CON=
T
> and set continuous pages order to THP order.
> Then It will get continuous pages PFN from VQ icvq use use madvise
> MADV_DONTNEED release the THP page.
> This will handle the THP split issue.
>=20
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  hw/virtio/virtio-balloon.c                      | 32 +++++++++++++++++++=
++----
>  include/hw/virtio/virtio-balloon.h              |  4 +++-
>  include/standard-headers/linux/virtio_balloon.h |  4 ++++
>  3 files changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7..88bdaca 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -34,6 +34,7 @@
>  #include "hw/virtio/virtio-access.h"
> =20
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> +#define CONT_PAGES_ORDER   9
> =20
>  typedef struct PartiallyBalloonedPage {
>      ram_addr_t base_gpa;

This doesn't look right to me. I suspect this is different between
different hosts. Fixing this would also be tricky as we
might need to migrate beween two hosts with different
huge page sizes.

My proposal is to instead enhance the PartiallyBalloonedPage
machinery, teaching it to handle the case where host page
size is smaller than the supported number of subpages.


> @@ -65,7 +66,8 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloon=
edPage *pbp,
> =20
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
>                                   MemoryRegion *mr, hwaddr mr_offset,
> -                                 PartiallyBalloonedPage *pbp)
> +                                 PartiallyBalloonedPage *pbp,=20
> +                                 bool is_cont_pages)
>  {
>      void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
>      ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
> @@ -76,6 +78,13 @@ static void balloon_inflate_page(VirtIOBalloon *balloo=
n,
>      /* XXX is there a better way to get to the RAMBlock than via a
>       * host address? */
>      rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
> +
> +    if (is_cont_pages) {
> +        ram_block_discard_range(rb, rb_offset,
> +                                BALLOON_PAGE_SIZE << CONT_PAGES_ORDER);
> +        return;
> +    }
> +
>      rb_page_size =3D qemu_ram_pagesize(rb);
> =20
>      if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
> @@ -361,9 +370,10 @@ static void virtio_balloon_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
>              trace_virtio_balloon_handle_output(memory_region_name(sectio=
n.mr),
>                                                 pa);
>              if (!qemu_balloon_is_inhibited()) {
> -                if (vq =3D=3D s->ivq) {
> +                if (vq =3D=3D s->ivq || vq =3D=3D s->icvq) {
>                      balloon_inflate_page(s, section.mr,
> -                                         section.offset_within_region, &=
pbp);
> +                                         section.offset_within_region, &=
pbp,
> +                                         vq =3D=3D s->icvq);
>                  } else if (vq =3D=3D s->dvq) {
>                      balloon_deflate_page(s, section.mr, section.offset_w=
ithin_region);
>                  } else {
> @@ -618,9 +628,12 @@ static size_t virtio_balloon_config_size(VirtIOBallo=
on *s)
>      if (s->qemu_4_0_config_size) {
>          return sizeof(struct virtio_balloon_config);
>      }
> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES=
)) {
>          return sizeof(struct virtio_balloon_config);
>      }
> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +        return offsetof(struct virtio_balloon_config, pages_order);
> +    }
>      if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          return offsetof(struct virtio_balloon_config, poison_val);
>      }
> @@ -646,6 +659,10 @@ static void virtio_balloon_get_config(VirtIODevice *=
vdev, uint8_t *config_data)
>                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
>      }
> =20
> +    if (virtio_has_feature(dev->host_features, VIRTIO_BALLOON_F_CONT_PAG=
ES)) {
> +        config.pages_order =3D cpu_to_le32(CONT_PAGES_ORDER);
> +    }
> +
>      trace_virtio_balloon_get_config(config.num_pages, config.actual);
>      memcpy(config_data, &config, virtio_balloon_config_size(dev));
>  }
> @@ -816,6 +833,11 @@ static void virtio_balloon_device_realize(DeviceStat=
e *dev, Error **errp)
>              virtio_error(vdev, "iothread is missing");
>          }
>      }
> +
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES=
)) {
> +        s->icvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_ou=
tput);
> +    }
> +
>      reset_stats(s);
>  }
> =20
> @@ -916,6 +938,8 @@ static Property virtio_balloon_properties[] =3D {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_CONT_PAGES, false),
>      /* QEMU 4.0 accidentally changed the config size even when free-page=
-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  Th=
is
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
> index d1c968d..61d2419 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
> =20
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
>      uint32_t free_page_report_status;
>      uint32_t num_pages;
>      uint32_t actual;
> @@ -70,6 +70,8 @@ typedef struct VirtIOBalloon {
>      uint32_t host_features;
> =20
>      bool qemu_4_0_config_size;
> +
> +    uint32_t pages_order;
>  } VirtIOBalloon;
> =20
>  #endif
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/st=
andard-headers/linux/virtio_balloon.h
> index 9375ca2..ee18be7 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -36,6 +36,8 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM=092 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT=093 /* VQ to report free pages *=
/
>  #define VIRTIO_BALLOON_F_PAGE_POISON=094 /* Guest is using page poisonin=
g */
> +#define VIRTIO_BALLOON_F_CONT_PAGES=095 /* VQ to report continuous pages=
 */
> +
> =20
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -51,6 +53,8 @@ struct virtio_balloon_config {
>  =09uint32_t free_page_report_cmd_id;
>  =09/* Stores PAGE_POISON if page poisoning is in use */
>  =09uint32_t poison_val;
> +=09/* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
> +=09uint32_t pages_order;
>  };
> =20
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> --=20
> 2.7.4


