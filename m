Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93237C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F57020719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APNJoQ14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F57020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMd1-0007o1-Js
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHMcQ-0007Nj-7i
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHMcO-0004kA-8C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:07:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHMcO-0004jY-2n
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585206475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxQ4KchenEW9LpYJUcFs/mEfMO2Y8QehZeixdOSZER8=;
 b=APNJoQ14OIOo7TqasoNwW8D36ahUbrkas8pZ0C9n+HQdnQE8hk1kNLPFH6oYjqS8c3QGGG
 GOP2Df+DlNTj3U2hHxYviA1arym6uC1zlXs5xX+TgfcsLYeW9JICWr74qBAwO6IQu8eiXX
 ZWmlhiRaUG/XeZszfu6eIqL0DBqMWzw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-ynHK0KebNZ6cNNY1UtN8HQ-1; Thu, 26 Mar 2020 03:07:50 -0400
X-MC-Unique: ynHK0KebNZ6cNNY1UtN8HQ-1
Received: by mail-wr1-f72.google.com with SMTP id o9so2574471wrw.14
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 00:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HcclFoRcUMXAmqI5wWRUbmFwT+7W1c3+/OsDIjflcfA=;
 b=YEdh+CsXVmtMHteR3F+SSlwQjteMRka916AtbuX/mdRBvuz6SLLbdj34oNXgRnYVRW
 skh1PmiRSi3HUH9F9Nllb+sNO1VVZhIIaSR5/HI/yMCv34OJDfySGMaJU0jF7K+rrEzl
 ZANioYvIgYzLq70RVknM8b0U5qcTtvvW8jFs1GdSH2sBadDDf7PDjbGMnXENirXEH4GE
 Nvm95iPezW0zVRn/wk6lnahI64Psdd45sOPR9w5/rVL3JjYkVn4eO/UWA85fSdLJ6DmA
 wVdri886JrTdaAzYrQ51kLRA5vOxdXl5nZpQy/gYVj2g3FnY3MsPRq/79hL4ZlK7uJK8
 c4HQ==
X-Gm-Message-State: ANhLgQ0C1vjstvS1GrrNC0StIq4zk0l91e1GB5Zo3yojjvMldnYReFnh
 p48KaZ9GkLm7mb2y3O8mPYAzj2A3H5AoPBzAsHzb27mctoeETjyP/5fL70Jx6Ysfo0OA9tzPdkT
 RyqhtCQmNP8qZhpM=
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr7335575wrw.133.1585206469561; 
 Thu, 26 Mar 2020 00:07:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtyd/EPOwcyQHG07tKxst9zHxndG/LnYfA/RKr4oJerYtEj2yvFk8Wke9pviMCzagX64P7J3Q==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr7335547wrw.133.1585206469208; 
 Thu, 26 Mar 2020 00:07:49 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
 by smtp.gmail.com with ESMTPSA id t2sm2145055wml.30.2020.03.26.00.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 00:07:48 -0700 (PDT)
Date: Thu, 26 Mar 2020 03:07:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: teawater <teawaterz@linux.alibaba.com>
Subject: Re: [RFC for QEMU] virtio-balloon: Add option thp-order to set
 VIRTIO_BALLOON_F_THP_ORDER
Message-ID: <20200326030636-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <1583999395-9131-2-git-send-email-teawater@gmail.com>
 <20200312042340-mutt-send-email-mst@kernel.org>
 <C9436807-D9CA-49FD-AEE3-3B7CE4BBB711@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <C9436807-D9CA-49FD-AEE3-3B7CE4BBB711@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: pagupta@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 akpm@linux-foundation.org, jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 06:13:32PM +0800, teawater wrote:
>=20
>=20
> > 2020=E5=B9=B43=E6=9C=8812=E6=97=A5 16:25=EF=BC=8CMichael S. Tsirkin <ms=
t@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > On Thu, Mar 12, 2020 at 03:49:55PM +0800, Hui Zhu wrote:
> >> If the guest kernel has many fragmentation pages, use virtio_balloon
> >> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> >> the balloon pages.
> >> Set option thp-order to on will open flags VIRTIO_BALLOON_F_THP_ORDER.
> >> It will set balloon size to THP size to handle the THP split issue.
> >>=20
> >> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> >=20
> > What's wrong with just using the PartiallyBalloonedPage machinery
> > instead? That would make it guest transparent.
>=20
> In balloon_inflate_page:
>     rb_page_size =3D qemu_ram_pagesize(rb);
>=20
>     if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
>         /* Easy case */
>=20
> It seems that PartiallyBalloonedPage is only used when rb_page_size is gr=
eater than BALLOON_PAGE_SIZE.
> Do you mean I should modify the working mechanism of balloon_inflate_page=
 function?
>=20
> Thanks,
> Hui

Yes, we can tweak it to unconditionally combine pages to
a huge page.


> >=20
> >> ---
> >> hw/virtio/virtio-balloon.c                      | 67 ++++++++++++++++-=
--------
> >> include/standard-headers/linux/virtio_balloon.h |  4 ++
> >> 2 files changed, 47 insertions(+), 24 deletions(-)
> >>=20
> >> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >> index a4729f7..cfe86b0 100644
> >> --- a/hw/virtio/virtio-balloon.c
> >> +++ b/hw/virtio/virtio-balloon.c
> >> @@ -340,37 +340,49 @@ static void virtio_balloon_handle_output(VirtIOD=
evice *vdev, VirtQueue *vq)
> >>         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4=
) =3D=3D 4) {
> >>             unsigned int p =3D virtio_ldl_p(vdev, &pfn);
> >>             hwaddr pa;
> >> +            size_t handle_size =3D BALLOON_PAGE_SIZE;
> >>=20
> >>             pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> >>             offset +=3D 4;
> >>=20
> >> -            section =3D memory_region_find(get_system_memory(), pa,
> >> -                                         BALLOON_PAGE_SIZE);
> >> -            if (!section.mr) {
> >> -                trace_virtio_balloon_bad_addr(pa);
> >> -                continue;
> >> -            }
> >> -            if (!memory_region_is_ram(section.mr) ||
> >> -                memory_region_is_rom(section.mr) ||
> >> -                memory_region_is_romd(section.mr)) {
> >> -                trace_virtio_balloon_bad_addr(pa);
> >> -                memory_region_unref(section.mr);
> >> -                continue;
> >> -            }
> >> +            if (virtio_has_feature(s->host_features,
> >> +                                   VIRTIO_BALLOON_F_THP_ORDER))
> >> +                handle_size =3D BALLOON_PAGE_SIZE << VIRTIO_BALLOON_T=
HP_ORDER;
> >> +
> >> +            while (handle_size > 0) {
> >> +                section =3D memory_region_find(get_system_memory(), p=
a,
> >> +                                             BALLOON_PAGE_SIZE);
> >> +                if (!section.mr) {
> >> +                    trace_virtio_balloon_bad_addr(pa);
> >> +                    continue;
> >> +                }
> >> +                if (!memory_region_is_ram(section.mr) ||
> >> +                    memory_region_is_rom(section.mr) ||
> >> +                    memory_region_is_romd(section.mr)) {
> >> +                    trace_virtio_balloon_bad_addr(pa);
> >> +                    memory_region_unref(section.mr);
> >> +                    continue;
> >> +                }
> >>=20
> >> -            trace_virtio_balloon_handle_output(memory_region_name(sec=
tion.mr),
> >> -                                               pa);
> >> -            if (!qemu_balloon_is_inhibited()) {
> >> -                if (vq =3D=3D s->ivq) {
> >> -                    balloon_inflate_page(s, section.mr,
> >> -                                         section.offset_within_region=
, &pbp);
> >> -                } else if (vq =3D=3D s->dvq) {
> >> -                    balloon_deflate_page(s, section.mr, section.offse=
t_within_region);
> >> -                } else {
> >> -                    g_assert_not_reached();
> >> +                trace_virtio_balloon_handle_output(memory_region_name=
(section.mr),
> >> +                                                   pa);
> >> +                if (!qemu_balloon_is_inhibited()) {
> >> +                    if (vq =3D=3D s->ivq) {
> >> +                        balloon_inflate_page(s, section.mr,
> >> +                                             section.offset_within_re=
gion,
> >> +                                             &pbp);
> >> +                    } else if (vq =3D=3D s->dvq) {
> >> +                        balloon_deflate_page(s, section.mr,
> >> +                                             section.offset_within_re=
gion);
> >> +                    } else {
> >> +                        g_assert_not_reached();
> >> +                    }
> >>                 }
> >> +                memory_region_unref(section.mr);
> >> +
> >> +                pa +=3D BALLOON_PAGE_SIZE;
> >> +                handle_size -=3D BALLOON_PAGE_SIZE;
> >>             }
> >> -            memory_region_unref(section.mr);
> >>         }
> >>=20
> >>         virtqueue_push(vq, elem, offset);
> >> @@ -693,6 +705,8 @@ static void virtio_balloon_set_config(VirtIODevice=
 *vdev,
> >>=20
> >>     memcpy(&config, config_data, virtio_balloon_config_size(dev));
> >>     dev->actual =3D le32_to_cpu(config.actual);
> >> +    if (virtio_has_feature(vdev->host_features, VIRTIO_BALLOON_F_THP_=
ORDER))
> >> +        dev->actual <<=3D VIRTIO_BALLOON_THP_ORDER;
> >>     if (dev->actual !=3D oldactual) {
> >>         qapi_event_send_balloon_change(vm_ram_size -
> >>                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PF=
N_SHIFT));
> >> @@ -728,6 +742,9 @@ static void virtio_balloon_to_target(void *opaque,=
 ram_addr_t target)
> >>     }
> >>     if (target) {
> >>         dev->num_pages =3D (vm_ram_size - target) >> VIRTIO_BALLOON_PF=
N_SHIFT;
> >> +        if (virtio_has_feature(dev->host_features,
> >> +                               VIRTIO_BALLOON_F_THP_ORDER))
> >> +            dev->num_pages >>=3D VIRTIO_BALLOON_THP_ORDER;
> >>         virtio_notify_config(vdev);
> >>     }
> >>     trace_virtio_balloon_to_target(target, dev->num_pages);
> >> @@ -916,6 +933,8 @@ static Property virtio_balloon_properties[] =3D {
> >>                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> >>     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
> >>                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> >> +    DEFINE_PROP_BIT("thp-order", VirtIOBalloon, host_features,
> >> +                    VIRTIO_BALLOON_F_THP_ORDER, false),
> >>     /* QEMU 4.0 accidentally changed the config size even when free-pa=
ge-hint
> >>      * is disabled, resulting in QEMU 3.1 migration incompatibility.  =
This
> >>      * property retains this quirk for QEMU 4.1 machine types.
> >> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include=
/standard-headers/linux/virtio_balloon.h
> >> index 9375ca2..f54d613 100644
> >> --- a/include/standard-headers/linux/virtio_balloon.h
> >> +++ b/include/standard-headers/linux/virtio_balloon.h
> >> @@ -36,10 +36,14 @@
> >> #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM=092 /* Deflate balloon on OOM =
*/
> >> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT=093 /* VQ to report free pages=
 */
> >> #define VIRTIO_BALLOON_F_PAGE_POISON=094 /* Guest is using page poison=
ing */
> >> +#define VIRTIO_BALLOON_F_THP_ORDER=095 /* Set balloon page order to t=
hp order */
> >>=20
> >> /* Size of a PFN in the balloon interface. */
> >> #define VIRTIO_BALLOON_PFN_SHIFT 12
> >>=20
> >> +/* The order of the balloon page */
> >> +#define VIRTIO_BALLOON_THP_ORDER 9
> >> +
> >> #define VIRTIO_BALLOON_CMD_ID_STOP=090
> >> #define VIRTIO_BALLOON_CMD_ID_DONE=091
> >> struct virtio_balloon_config {
> >> --=20
> >> 2.7.4


