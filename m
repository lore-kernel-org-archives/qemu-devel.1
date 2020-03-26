Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65676C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211AA20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ylc/aold"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211AA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMmw-0002qP-9C
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHMmG-0002QX-EW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHMmE-00049V-4n
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:18:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHMmD-00049F-Vm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585207085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGxoLgl2rYryv6W3IPICd/+Mxsy0ZeFvm6+k/9TnshY=;
 b=Ylc/aoldNCixPPd3R7p8p2bkAc///E1Ys8KZedhvpLeTOhT9+mEjkfLslpoJ1rbv6gjQIv
 2arxfcg/DgZdw+ORyRY3blQEtzO8NDWMSJj0DnfT+e7vPlo7AW0pxP++p53jAuv9UCUkNe
 fnNpSuEna8ZMzIBqz/caiXgl4a77eSQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-YPeyPYwKNlO03nKQ3Wubyw-1; Thu, 26 Mar 2020 03:18:01 -0400
X-MC-Unique: YPeyPYwKNlO03nKQ3Wubyw-1
Received: by mail-wm1-f72.google.com with SMTP id f8so2077660wmh.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 00:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uQp0K0jAaR+9l6rJiVimsB2GyRtRdq+1EsfqDIYov0g=;
 b=SjJikRmZGDAGtQj7wjqWOLvorfxKvwoD0IPjhD/N9OSvztCYQFxQTqwMREXD3TPUFy
 nzbcBCauFA+00mPilU/opiRP08BNNLcJITiOSuOCqMraGDJK2QK7Y4gEa8QQoCjR/NOo
 Dz5skpvObyVb6K/s7/FkBnZyHyx1GnDNG07o2tfWTGrTiQ1fXuf/FBCXsdvlL8ux+Wq5
 gRYe77/nwLpiiSFqBfFgLeaLoWgnF3G4Q05iy/xbPRilnBQ+UuaVwAmZbhoREsPuOYM0
 M+RbZvUAMO5CN3i5wKJa7kjKJKYJC0eFzXY/gD6pqAH7NISyeUQfBHacB/LcRk4qRjCs
 Nrgg==
X-Gm-Message-State: ANhLgQ3/ZGB42Wm4vcA4SIHSHKk5SXx+S6FPTQ1zMh7o/uhom00XZ9OR
 q+a+uj+kUd8v5fSMISwZMyzSytlobdTS+5jtRnC2Go3dpEaQF2Z75zihcbvUNlqDK/dILevfWwb
 gzpeBOQVXpsjeJrY=
X-Received: by 2002:a1c:5443:: with SMTP id p3mr1522463wmi.149.1585207079685; 
 Thu, 26 Mar 2020 00:17:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsV2ccS13lkeQxkkKN1HSUlNXfJOOUYxFAbUrNNXNsYZOEMMdTYL/3hvon4EOjuxEQsIlLk4w==
X-Received: by 2002:a1c:5443:: with SMTP id p3mr1522423wmi.149.1585207079260; 
 Thu, 26 Mar 2020 00:17:59 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
 by smtp.gmail.com with ESMTPSA id w11sm2306538wrv.86.2020.03.26.00.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 00:17:58 -0700 (PDT)
Date: Thu, 26 Mar 2020 03:17:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hui Zhu <teawater@gmail.com>
Subject: Re: [PATCH for Linux v2] virtio_balloon: Add
 VIRTIO_BALLOON_VQ_INFLATE_CONT to handle THP split issue
Message-ID: <20200326030318-mutt-send-email-mst@kernel.org>
References: <1584893097-12317-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1584893097-12317-1-git-send-email-teawater@gmail.com>
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
Cc: pagupta@redhat.com, aquini@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 namit@vmware.com, Hui Zhu <teawaterz@linux.alibaba.com>,
 akpm@linux-foundation.org, jasowang@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First, either QEMU or Linux version of any interface changes
should be copied to the virtio TC.

:


On Mon, Mar 23, 2020 at 12:04:56AM +0800, Hui Zhu wrote:
> The first version is in [1].
> According to the comments from Michael and David, I updated the patch.
> 1. Added a separate vq inflate_cont_vq to transport inflate continuous
>    pages.
> 2. Set all the pages in the continuous pages movable then they can be
>    compaction.
> 3. Added a new element pages_order to virtio_balloon_config.  It is the
>    inflate pages order that is set by the QEMU.
> 4. If the balloon cannot get any continuous pages from the system.
>    Go back to use the single page to fill the balloon.
> 5.  Use balloon_pages_alloc to allocate the single page and continuous
>     pages.  Replace __GFP_NORETRY with __GFP_RETRY_MAYFAIL when allocatin=
g
>     the continuous pages because it can increase the success rate of
>     allocating large chunks of memory.
>=20
> Following is the introduction of the function.
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> This is an example in a VM with 1G memory 1CPU:
> // This is the THP number before VM execution in the host.
> // None use THP.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
>=20
> // After VM start, use usemem
> // (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.gi=
t)
> // punch-holes function generates 400m fragmentation pages in the guest
> // kernel.
> usemem --punch-holes -s -1 800m &
>=20
> // This is the THP number after this command in the host.
> // Some THP is used by VM because usemem will access 800M memory
> // in the guest.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
>=20
> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> (qemu) device_add virtio-balloon-pci,id=3Dballoon1
> (qemu) info balloon
> balloon: actual=3D1024
> (qemu) balloon 600
> (qemu) info balloon
> balloon: actual=3D600
>=20
> // This is the THP number after inflate the balloon in the host.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    151552 kB
>=20
> THP number decreased more than 800M.
> The reason is usemem with punch-holes option will free every other
> page after allocation.  Then 400M free memory inside the guest kernel
> is fragmentation pages.
> The guest kernel will use them to inflate the balloon.  When these
> fragmentation pages are freed, THP will be split.
>=20
> This commit tries to handle this with add a new flag
> VIRTIO_BALLOON_VQ_INFLATE_CONT.
> When this flag is set, the balloon will try to use continuous pages
> inflate the balloon.  And the pages order is set to THP order.
> Then THP pages will be freed together in the host.
> This is an example in a VM with 1G memory 1CPU:
> // This is the THP number before VM execution in the host.
> // None use THP.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
>=20
> // After VM start, use usemem punch-holes function generates 400M
> // fragmentation pages in the guest kernel.
> usemem --punch-holes -s -1 800m &
>=20
> // This is the THP number after this command in the host.
> // Some THP is used by VM because usemem will access 800M memory
> // in the guest.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
>=20
> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> (qemu) device_add virtio-balloon-pci,id=3Dballoon1,cont-pages=3Don
> (qemu) info balloon
> balloon: actual=3D1024
> (qemu) balloon 600
> (qemu) info balloon
> balloon: actual=3D600
>=20
> // This is the THP number after inflate the balloon in the host.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    610304 kB
>=20
> The THP number decreases 358M.  This shows that
> VIRTIO_BALLOON_VQ_INFLATE_CONT can help handle the THP split issue.
>=20
> [1] https://lkml.org/lkml/2020/3/12/144
>=20
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

I'd like to repeat my original idea of doing large page allocations
unconditionally within guest.


> ---
>  drivers/virtio/virtio_balloon.c     | 78 ++++++++++++++++++++++++++++++-=
------
>  include/linux/balloon_compaction.h  |  9 ++++-
>  include/uapi/linux/virtio_balloon.h |  3 ++
>  mm/balloon_compaction.c             | 40 +++++++++++++++----
>  4 files changed, 109 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 341458f..fbd2b02f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -47,6 +47,7 @@ enum virtio_balloon_vq {
>  =09VIRTIO_BALLOON_VQ_DEFLATE,
>  =09VIRTIO_BALLOON_VQ_STATS,
>  =09VIRTIO_BALLOON_VQ_FREE_PAGE,
> +=09VIRTIO_BALLOON_VQ_INFLATE_CONT,
>  =09VIRTIO_BALLOON_VQ_MAX
>  };
> =20
> @@ -56,7 +57,8 @@ enum virtio_balloon_config_read {
> =20
>  struct virtio_balloon {
>  =09struct virtio_device *vdev;
> -=09struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
> +=09struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq,
> +=09=09=09 *inflate_cont_vq;
> =20
>  =09/* Balloon's own wq for cpu-intensive work items */
>  =09struct workqueue_struct *balloon_wq;
> @@ -114,6 +116,12 @@ struct virtio_balloon {
> =20
>  =09/* To register a shrinker to shrink memory upon memory pressure */
>  =09struct shrinker shrinker;
> +
> +=09/* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set.
> +=09 * if VIRTIO_BALLOON_F_CONT_PAGES is not set,
> +=09 * pages_order will be set to 0.
> +=09 */
> +=09__u32 pages_order;
>  };
> =20
>  static struct virtio_device_id id_table[] =3D {
> @@ -169,10 +177,11 @@ static void set_page_pfns(struct virtio_balloon *vb=
,
>  =09=09=09=09=09  page_to_balloon_pfn(page) + i);
>  }
> =20
> -static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
> +static unsigned int fill_balloon_order(struct virtio_balloon *vb, size_t=
 num,
> +=09=09=09=09       unsigned int order)
>  {
> -=09unsigned num_allocated_pages;
> -=09unsigned num_pfns;
> +=09unsigned int num_allocated_pages;
> +=09unsigned int num_pfns;
>  =09struct page *page;
>  =09LIST_HEAD(pages);
> =20
> @@ -181,12 +190,12 @@ static unsigned fill_balloon(struct virtio_balloon =
*vb, size_t num)
> =20
>  =09for (num_pfns =3D 0; num_pfns < num;
>  =09     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -=09=09struct page *page =3D balloon_page_alloc();
> +=09=09struct page *page =3D balloon_pages_alloc(order);
> =20
>  =09=09if (!page) {
>  =09=09=09dev_info_ratelimited(&vb->vdev->dev,
> -=09=09=09=09=09     "Out of puff! Can't get %u pages\n",
> -=09=09=09=09=09     VIRTIO_BALLOON_PAGES_PER_PAGE);
> +=09=09=09=09"Out of puff! Can't get %u pages\n",
> +=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE << order);
>  =09=09=09/* Sleep for at least 1/5 of a second before retry. */
>  =09=09=09msleep(200);
>  =09=09=09break;
> @@ -200,25 +209,48 @@ static unsigned fill_balloon(struct virtio_balloon =
*vb, size_t num)
>  =09vb->num_pfns =3D 0;
> =20
>  =09while ((page =3D balloon_page_pop(&pages))) {
> -=09=09balloon_page_enqueue(&vb->vb_dev_info, page);
> +=09=09balloon_pages_enqueue(&vb->vb_dev_info, page, order);
> =20
>  =09=09set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> -=09=09vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
> +=09=09vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE << order;
>  =09=09if (!virtio_has_feature(vb->vdev,
>  =09=09=09=09=09VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -=09=09=09adjust_managed_page_count(page, -1);
> +=09=09=09adjust_managed_page_count(page, -(1 << order));
>  =09=09vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>  =09}
> =20
> -=09num_allocated_pages =3D vb->num_pfns;
> +=09num_allocated_pages =3D vb->num_pfns << order;
>  =09/* Did we get any? */
> -=09if (vb->num_pfns !=3D 0)
> -=09=09tell_host(vb, vb->inflate_vq);
> +=09if (vb->num_pfns !=3D 0) {
> +=09=09if (order)
> +=09=09=09tell_host(vb, vb->inflate_cont_vq);
> +=09=09else
> +=09=09=09tell_host(vb, vb->inflate_vq);
> +=09}
>  =09mutex_unlock(&vb->balloon_lock);
> =20
>  =09return num_allocated_pages;
>  }
> =20
> +static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
> +{
> +=09unsigned int num_allocated_pages =3D 0;
> +
> +=09if (vb->pages_order) {
> +=09=09num_allocated_pages =3D fill_balloon_order(vb, num,
> +=09=09=09=09=09=09=09 vb->pages_order);
> +=09=09if (!num_allocated_pages)
> +=09=09=09dev_info_ratelimited(&vb->vdev->dev,
> +=09=09=09=09"Fail get any continuous pages in order %u\n",
> +=09=09=09=09vb->pages_order);
> +=09}
> +
> +=09if (!num_allocated_pages)
> +=09=09num_allocated_pages =3D fill_balloon_order(vb, num, 0);
> +
> +=09return num_allocated_pages;
> +}
> +
>  static void release_pages_balloon(struct virtio_balloon *vb,
>  =09=09=09=09 struct list_head *pages)
>  {


Hmm no this is not what was previously suggested. David Hildenbrand propose=
d
starting with highest order and iterating until we reach 0.
And I proposed a new API to allocate some memory between min and max
orders.


> @@ -481,6 +513,8 @@ static int init_vqs(struct virtio_balloon *vb)
>  =09names[VIRTIO_BALLOON_VQ_STATS] =3D NULL;
>  =09callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
>  =09names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
> +=09callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] =3D NULL;
> +=09names[VIRTIO_BALLOON_VQ_INFLATE_CONT] =3D NULL;
> =20
>  =09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>  =09=09names[VIRTIO_BALLOON_VQ_STATS] =3D "stats";
> @@ -492,6 +526,11 @@ static int init_vqs(struct virtio_balloon *vb)
>  =09=09callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
>  =09}
> =20
> +=09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
> +=09=09names[VIRTIO_BALLOON_VQ_INFLATE_CONT] =3D "inflate_cont";
> +=09=09callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] =3D balloon_ack;
> +=09}
> +
>  =09err =3D vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>  =09=09=09=09=09 vqs, callbacks, names, NULL, NULL);
>  =09if (err)
> @@ -524,6 +563,10 @@ static int init_vqs(struct virtio_balloon *vb)
>  =09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  =09=09vb->free_page_vq =3D vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
> =20
> +=09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
> +=09=09vb->inflate_cont_vq
> +=09=09=09=3D vqs[VIRTIO_BALLOON_VQ_INFLATE_CONT];
> +
>  =09return 0;
>  }
> =20
> @@ -945,6 +988,14 @@ static int virtballoon_probe(struct virtio_device *v=
dev)
>  =09=09if (err)
>  =09=09=09goto out_del_balloon_wq;
>  =09}
> +=09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
> +=09=09virtio_cread(vb->vdev, struct virtio_balloon_config,
> +=09=09=09     pages_order, &vb->pages_order);
> +=09=09if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
> +=09=09=09vb->pages_order
> +=09=09=09=09=3D le32_to_cpu((__force __le32)vb->pages_order);
> +=09} else
> +=09=09vb->pages_order =3D 0;
>  =09virtio_device_ready(vdev);
> =20
>  =09if (towards_target(vb))
> @@ -1058,6 +1109,7 @@ static unsigned int features[] =3D {
>  =09VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
>  =09VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  =09VIRTIO_BALLOON_F_PAGE_POISON,
> +=09VIRTIO_BALLOON_F_CONT_PAGES,
>  };
> =20
>  static struct virtio_driver virtio_balloon_driver =3D {
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_c=
ompaction.h
> index 338aa27..8180bbf 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -60,15 +60,22 @@ struct balloon_dev_info {
>  =09struct inode *inode;
>  };
> =20
> -extern struct page *balloon_page_alloc(void);
> +extern struct page *balloon_pages_alloc(unsigned int order);
>  extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  =09=09=09=09 struct page *page);
> +extern void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
> +=09=09=09=09  struct page *page, unsigned int order);
>  extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_=
info);
>  extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_i=
nfo,
>  =09=09=09=09      struct list_head *pages);
>  extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_i=
nfo,
>  =09=09=09=09     struct list_head *pages, size_t n_req_pages);
> =20
> +static inline struct page *balloon_page_alloc(void)
> +{
> +=09return balloon_pages_alloc(0);
> +}
> +
>  static inline void balloon_devinfo_init(struct balloon_dev_info *balloon=
)
>  {
>  =09balloon->isolated_pages =3D 0;
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/vir=
tio_balloon.h
> index a1966cd7..e21b0aa 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -36,6 +36,7 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM=092 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT=093 /* VQ to report free pages *=
/
>  #define VIRTIO_BALLOON_F_PAGE_POISON=094 /* Guest is using page poisonin=
g */
> +#define VIRTIO_BALLOON_F_CONT_PAGES=095 /* VQ to report continuous pages=
 */
> =20
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -51,6 +52,8 @@ struct virtio_balloon_config {
>  =09__u32 free_page_report_cmd_id;
>  =09/* Stores PAGE_POISON if page poisoning is in use */
>  =09__u32 poison_val;
> +=09/* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
> +=09__u32 pages_order;
>  };
> =20
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 26de020..87df4b2 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -112,8 +112,8 @@ size_t balloon_page_list_dequeue(struct balloon_dev_i=
nfo *b_dev_info,
>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> =20
>  /*
> - * balloon_page_alloc - allocates a new page for insertion into the ball=
oon
> - *=09=09=09page list.
> + * balloon_pages_alloc - allocates a new page for insertion into the bal=
loon
> + *=09=09=09 page list.
>   *
>   * Driver must call this function to properly allocate a new balloon pag=
e.
>   * Driver must call balloon_page_enqueue before definitively removing th=
e page
> @@ -121,14 +121,21 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>   *
>   * Return: struct page for the allocated page or NULL on allocation fail=
ure.
>   */
> -struct page *balloon_page_alloc(void)
> +struct page *balloon_pages_alloc(unsigned int order)
>  {
> -=09struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
> -=09=09=09=09       __GFP_NOMEMALLOC | __GFP_NORETRY |
> -=09=09=09=09       __GFP_NOWARN);
> +=09gfp_t gfp_mask;
> +
> +=09if (order > 1)
> +=09=09gfp_mask =3D __GFP_RETRY_MAYFAIL;
> +=09else
> +=09=09gfp_mask =3D __GFP_NORETRY;
> +
> +=09struct page *page =3D alloc_pages(balloon_mapping_gfp_mask() |
> +=09=09=09=09=09gfp_mask | __GFP_NOMEMALLOC |
> +=09=09=09=09=09__GFP_NOWARN, order);
>  =09return page;
>  }
> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> =20
>  /*
>   * balloon_page_enqueue - inserts a new page into the balloon page list.
> @@ -155,6 +162,25 @@ void balloon_page_enqueue(struct balloon_dev_info *b=
_dev_info,
>  EXPORT_SYMBOL_GPL(balloon_page_enqueue);
> =20
>  /*
> + * balloon_pages_enqueue - inserts continuous pages into the balloon pag=
e list.
> + */
> +void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
> +=09=09=09   struct page *page, unsigned int order)
> +{
> +=09unsigned long flags;
> +=09unsigned long pfn =3D page_to_pfn(page);
> +=09unsigned long last_pfn =3D pfn + (1 << order) - 1;
> +
> +=09spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +=09for (; pfn <=3D last_pfn; pfn++) {
> +=09=09page =3D pfn_to_page(pfn);
> +=09=09balloon_page_enqueue_one(b_dev_info, page);
> +=09}
> +=09spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(balloon_pages_enqueue);
> +
> +/*
>   * balloon_page_dequeue - removes a page from balloon's page list and re=
turns
>   *=09=09=09  its address to allow the driver to release the page.
>   * @b_dev_info: balloon device decriptor where we will grab a page from.
> --=20
> 2.7.4


