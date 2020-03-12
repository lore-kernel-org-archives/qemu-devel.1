Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F06C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D45206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrF5OjFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D45206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJAL-0003eB-Jt
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCJ9e-00032D-Tv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCJ9d-0002vb-Hj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:25:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59820
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCJ9d-0002uR-Cb
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584001520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zc0zEWCa0mnKEHZsRJwYY6Q1eSEKb5q1SxC/YKAYrm4=;
 b=KrF5OjFa2UsuGedTzd08Dym6BxuOUBTBn0s0gUd3sHGHd1NZtGwkH2ikPjv6S/qy+4rRjv
 FP02NjLlOxRq2uOXOnEVkVTtenrmztgDcF9ByQfX4samAMRTLdbgys9HD8V169MBzvYQGt
 t/wBCcgwoqddRNT8WlmsBA2wFlSgbng=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-Pz4CvELlM06I-hKfQbNX_g-1; Thu, 12 Mar 2020 04:25:15 -0400
X-MC-Unique: Pz4CvELlM06I-hKfQbNX_g-1
Received: by mail-qk1-f197.google.com with SMTP id h6so3326776qkj.14
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 01:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UqiBqBozQZrKbpqb6fps1Ub+53xZKmdnmK5P35tZZ6M=;
 b=abXc14xUNKdKmreiLMziAd4/nHaVK58rjWagZ4nnyTm+DbDa9G+45N7OsNrXxOq/CV
 mJT1GWgaL1WueDZkeHvPOoF54iFx7fI2vetmzhvcw5Gs+GVBdECLVmWb3IZVpj5nP3SU
 QK5EJrjDRnrlTxQTcyQAocI1g3lDRZnvTC5bAB0H+nEeJRAPD0Kv2uR02BVrGxBn3ogV
 wfyxufk96g3qQHxE59ZRQSTp50S9iU1EB9TsYsSyd8VN+dQ97M23u4mByzXpQHiPYJr5
 JitVA1fQQ4FZDkEPfLSnFcjvhNPvuiB08GZPgwpb/xIKjaGwA3CkbpSKCche7IsGoUpI
 b2ow==
X-Gm-Message-State: ANhLgQ1dteS17J6kCwotvkW5/ePnXikqcr56uU60wqwUGhXT0XLcFlZB
 8MbWPYkv9HYG1rlrzMA2iHGOuJK/h+U0HdIR+pWkdbUyJvnQoOWmF1ZeozWBX3fFmZdc9Zgu2Wl
 cR+3SBdBH3AvcUlk=
X-Received: by 2002:a37:6215:: with SMTP id w21mr6548593qkb.149.1584001514428; 
 Thu, 12 Mar 2020 01:25:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vunTOq0UJjwugXSegnRqEyiS9dlQvVqcZDLsJQHR9PIHKEvp8WKkpEby0VCBTZybNkeotxyBA==
X-Received: by 2002:a37:6215:: with SMTP id w21mr6548575qkb.149.1584001514073; 
 Thu, 12 Mar 2020 01:25:14 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id 82sm10496917qkd.62.2020.03.12.01.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 01:25:13 -0700 (PDT)
Date: Thu, 12 Mar 2020 04:25:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hui Zhu <teawater@gmail.com>
Subject: Re: [RFC for QEMU] virtio-balloon: Add option thp-order to set
 VIRTIO_BALLOON_F_THP_ORDER
Message-ID: <20200312042340-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <1583999395-9131-2-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1583999395-9131-2-git-send-email-teawater@gmail.com>
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
Cc: pagupta@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 03:49:55PM +0800, Hui Zhu wrote:
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> Set option thp-order to on will open flags VIRTIO_BALLOON_F_THP_ORDER.
> It will set balloon size to THP size to handle the THP split issue.
>=20
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

What's wrong with just using the PartiallyBalloonedPage machinery
instead? That would make it guest transparent.

> ---
>  hw/virtio/virtio-balloon.c                      | 67 ++++++++++++++++---=
------
>  include/standard-headers/linux/virtio_balloon.h |  4 ++
>  2 files changed, 47 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7..cfe86b0 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -340,37 +340,49 @@ static void virtio_balloon_handle_output(VirtIODevi=
ce *vdev, VirtQueue *vq)
>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) =
=3D=3D 4) {
>              unsigned int p =3D virtio_ldl_p(vdev, &pfn);
>              hwaddr pa;
> +            size_t handle_size =3D BALLOON_PAGE_SIZE;
> =20
>              pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>              offset +=3D 4;
> =20
> -            section =3D memory_region_find(get_system_memory(), pa,
> -                                         BALLOON_PAGE_SIZE);
> -            if (!section.mr) {
> -                trace_virtio_balloon_bad_addr(pa);
> -                continue;
> -            }
> -            if (!memory_region_is_ram(section.mr) ||
> -                memory_region_is_rom(section.mr) ||
> -                memory_region_is_romd(section.mr)) {
> -                trace_virtio_balloon_bad_addr(pa);
> -                memory_region_unref(section.mr);
> -                continue;
> -            }
> +            if (virtio_has_feature(s->host_features,
> +                                   VIRTIO_BALLOON_F_THP_ORDER))
> +                handle_size =3D BALLOON_PAGE_SIZE << VIRTIO_BALLOON_THP_=
ORDER;
> +
> +            while (handle_size > 0) {
> +                section =3D memory_region_find(get_system_memory(), pa,
> +                                             BALLOON_PAGE_SIZE);
> +                if (!section.mr) {
> +                    trace_virtio_balloon_bad_addr(pa);
> +                    continue;
> +                }
> +                if (!memory_region_is_ram(section.mr) ||
> +                    memory_region_is_rom(section.mr) ||
> +                    memory_region_is_romd(section.mr)) {
> +                    trace_virtio_balloon_bad_addr(pa);
> +                    memory_region_unref(section.mr);
> +                    continue;
> +                }
> =20
> -            trace_virtio_balloon_handle_output(memory_region_name(sectio=
n.mr),
> -                                               pa);
> -            if (!qemu_balloon_is_inhibited()) {
> -                if (vq =3D=3D s->ivq) {
> -                    balloon_inflate_page(s, section.mr,
> -                                         section.offset_within_region, &=
pbp);
> -                } else if (vq =3D=3D s->dvq) {
> -                    balloon_deflate_page(s, section.mr, section.offset_w=
ithin_region);
> -                } else {
> -                    g_assert_not_reached();
> +                trace_virtio_balloon_handle_output(memory_region_name(se=
ction.mr),
> +                                                   pa);
> +                if (!qemu_balloon_is_inhibited()) {
> +                    if (vq =3D=3D s->ivq) {
> +                        balloon_inflate_page(s, section.mr,
> +                                             section.offset_within_regio=
n,
> +                                             &pbp);
> +                    } else if (vq =3D=3D s->dvq) {
> +                        balloon_deflate_page(s, section.mr,
> +                                             section.offset_within_regio=
n);
> +                    } else {
> +                        g_assert_not_reached();
> +                    }
>                  }
> +                memory_region_unref(section.mr);
> +
> +                pa +=3D BALLOON_PAGE_SIZE;
> +                handle_size -=3D BALLOON_PAGE_SIZE;
>              }
> -            memory_region_unref(section.mr);
>          }
> =20
>          virtqueue_push(vq, elem, offset);
> @@ -693,6 +705,8 @@ static void virtio_balloon_set_config(VirtIODevice *v=
dev,
> =20
>      memcpy(&config, config_data, virtio_balloon_config_size(dev));
>      dev->actual =3D le32_to_cpu(config.actual);
> +    if (virtio_has_feature(vdev->host_features, VIRTIO_BALLOON_F_THP_ORD=
ER))
> +        dev->actual <<=3D VIRTIO_BALLOON_THP_ORDER;
>      if (dev->actual !=3D oldactual) {
>          qapi_event_send_balloon_change(vm_ram_size -
>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_=
SHIFT));
> @@ -728,6 +742,9 @@ static void virtio_balloon_to_target(void *opaque, ra=
m_addr_t target)
>      }
>      if (target) {
>          dev->num_pages =3D (vm_ram_size - target) >> VIRTIO_BALLOON_PFN_=
SHIFT;
> +        if (virtio_has_feature(dev->host_features,
> +                               VIRTIO_BALLOON_F_THP_ORDER))
> +            dev->num_pages >>=3D VIRTIO_BALLOON_THP_ORDER;
>          virtio_notify_config(vdev);
>      }
>      trace_virtio_balloon_to_target(target, dev->num_pages);
> @@ -916,6 +933,8 @@ static Property virtio_balloon_properties[] =3D {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("thp-order", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_THP_ORDER, false),
>      /* QEMU 4.0 accidentally changed the config size even when free-page=
-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  Th=
is
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/st=
andard-headers/linux/virtio_balloon.h
> index 9375ca2..f54d613 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -36,10 +36,14 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM=092 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT=093 /* VQ to report free pages *=
/
>  #define VIRTIO_BALLOON_F_PAGE_POISON=094 /* Guest is using page poisonin=
g */
> +#define VIRTIO_BALLOON_F_THP_ORDER=095 /* Set balloon page order to thp =
order */
> =20
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> =20
> +/* The order of the balloon page */
> +#define VIRTIO_BALLOON_THP_ORDER 9
> +
>  #define VIRTIO_BALLOON_CMD_ID_STOP=090
>  #define VIRTIO_BALLOON_CMD_ID_DONE=091
>  struct virtio_balloon_config {
> --=20
> 2.7.4


