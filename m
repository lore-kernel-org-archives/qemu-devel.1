Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EB9C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4582C206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzyA/d25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4582C206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJ49-0005d7-Em
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCJ3R-0005Dl-87
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCJ3O-0005qr-Px
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:18:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCJ3O-0005oQ-I4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584001133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OOKVIRRa8gaMVVPjVRwZ+aLrGlNXi+SMn3CGqSu5QY=;
 b=EzyA/d25BqKbIdWHScJMOC7V+aDZmCDt83QXTEs2W1bjO7eNxEPmcHbDjK+RyDjxT7C2X8
 FWdkFj8mBFvIxX64py6Cn3YDg6BNAOOvPcNjwPhJfva3Vh+Hw70AI1PZf6WpnGgjWjYWUp
 wGJ3g/80uhR6bWpcuQn2WjporXteW38=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-mflAchaeP5OZDXRCDFLw8Q-1; Thu, 12 Mar 2020 04:18:51 -0400
X-MC-Unique: mflAchaeP5OZDXRCDFLw8Q-1
Received: by mail-qv1-f71.google.com with SMTP id l16so3032370qvo.15
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 01:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ECz6jqsUX2fJctljHZocUDLIdEs+CqJTm8B47mMJp/Y=;
 b=hxojZaXl9iV7Vozwv4rl3vzGwANEUxLOTEh5qyS1Rokg0HPIDEEo+rA1hkIZMTHh34
 szxF1ntQpGAyVYyh6nwq9e9+Ux++ort+3rKRM+79o95JLRyeFylbQht9jFV5sklRVoKh
 YoMCSrW3GUv0fLDWoAI0O7dWb6uF6lFgUPoBl4wAUUi9jjqmW+bvkwmaWvYaZptgjSSN
 V2tzFfaB6mtOGAl6guqzk4xW34hgvsyvrguTNuWa8Y+OEAcB+NU7DuDXBoexDhrI+BYP
 ctR6+KmZ+xdKpMGaHdx9nzJjx9QU7zErWVfSY7J6jhj7zTfRQWsWmHbIHox28hvbx9Xj
 ce9w==
X-Gm-Message-State: ANhLgQ1PaaiGIpjxTDv34wg0qoCGCFquCB+XcEvZFehyjEuTmIvnRxdv
 KUm2TYU4cJApyXsoyeMRIy2RkCQA9aQnfjvntqzFkpixOWXmC3XrWY1xwrJwmEzCHtFvM2cmSRc
 NTjG7JYHc6SbOdeE=
X-Received: by 2002:a37:4d8b:: with SMTP id a133mr6433539qkb.14.1584001130740; 
 Thu, 12 Mar 2020 01:18:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvzuipv7MNWIWw8GBg2j8YXs2uFV9d2RfQtz+YW/0QQ7DHhdeJM89rGvpifj57HXkbwOfW+jQ==
X-Received: by 2002:a37:4d8b:: with SMTP id a133mr6433515qkb.14.1584001130263; 
 Thu, 12 Mar 2020 01:18:50 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id n46sm11539590qtb.48.2020.03.12.01.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 01:18:49 -0700 (PDT)
Date: Thu, 12 Mar 2020 04:18:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hui Zhu <teawater@gmail.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200312035345-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1583999395-9131-1-git-send-email-teawater@gmail.com>
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

On Thu, Mar 12, 2020 at 03:49:54PM +0800, Hui Zhu wrote:
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> This is an example in a VM with 1G memory 1CPU:
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
>=20
> usemem --punch-holes -s -1 800m &
>=20
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
>=20
> (qemu) device_add virtio-balloon-pci,id=3Dballoon1
> (qemu) info balloon
> balloon: actual=3D1024
> (qemu) balloon 624
> (qemu) info balloon
> balloon: actual=3D624
>=20
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    153600 kB
>=20
> THP number decreased more than 800M.
> The reason is usemem with punch-holes option will free every other page
> after allocation.  Then 400M free memory inside the guest kernel is
> fragmentation pages.
> The guest kernel will use them to inflate the balloon.  When these
> fragmentation pages are freed, THP will be split.
>=20
> This commit tries to handle this with add a new flag
> VIRTIO_BALLOON_F_THP_ORDER.
> When this flag is set, the balloon page order will be set to the THP orde=
r.
> Then THP pages will be freed together in the host.
> This is an example in a VM with 1G memory 1CPU:
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
>=20
> usemem --punch-holes -s -1 800m &
>=20
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
>=20
> (qemu) device_add virtio-balloon-pci,id=3Dballoon1,thp-order=3Don
> (qemu) info balloon
> balloon: actual=3D1024
> (qemu) balloon 624
> (qemu) info balloon
> balloon: actual=3D624
>=20
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    583680 kB
>=20
> The THP number decreases 384M.  This shows that VIRTIO_BALLOON_F_THP_ORDE=
R
> can help handle the THP split issue.
>=20
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 57 ++++++++++++++++++++++++++-----=
------
>  include/linux/balloon_compaction.h  | 14 ++++++---
>  include/uapi/linux/virtio_balloon.h |  4 +++
>  3 files changed, 54 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 7bfe365..1e1dc76 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -175,18 +175,31 @@ static unsigned fill_balloon(struct virtio_balloon =
*vb, size_t num)
>  =09unsigned num_pfns;
>  =09struct page *page;
>  =09LIST_HEAD(pages);
> +=09int page_order =3D 0;
> =20
>  =09/* We can only do one array worth at a time. */
>  =09num =3D min(num, ARRAY_SIZE(vb->pfns));
> =20
> +=09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
> +=09=09page_order =3D VIRTIO_BALLOON_THP_ORDER;
> +
>  =09for (num_pfns =3D 0; num_pfns < num;
>  =09     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -=09=09struct page *page =3D balloon_page_alloc();
> +=09=09struct page *page;
> +
> +=09=09if (page_order)
> +=09=09=09page =3D alloc_pages(__GFP_HIGHMEM |
> +=09=09=09=09=09   __GFP_KSWAPD_RECLAIM |
> +=09=09=09=09=09   __GFP_RETRY_MAYFAIL |
> +=09=09=09=09=09   __GFP_NOWARN | __GFP_NOMEMALLOC,

The set of flags is inconsistent with balloon_page_alloc.
Pls extend that do not bypass it.


> +=09=09=09=09=09   page_order);
> +=09=09else
> +=09=09=09page =3D balloon_page_alloc();
> =20
>  =09=09if (!page) {
>  =09=09=09dev_info_ratelimited(&vb->vdev->dev,
> -=09=09=09=09=09     "Out of puff! Can't get %u pages\n",
> -=09=09=09=09=09     VIRTIO_BALLOON_PAGES_PER_PAGE);
> +=09=09=09=09"Out of puff! Can't get %u pages\n",
> +=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE << page_order);
>  =09=09=09/* Sleep for at least 1/5 of a second before retry. */
>  =09=09=09msleep(200);
>  =09=09=09break;

I suggest we do something guest side only for starters: if we need a
power of two pages, try to get them in a single chunk, with no retrying.
If that fails go back to a single page.


> @@ -206,7 +219,7 @@ static unsigned fill_balloon(struct virtio_balloon *v=
b, size_t num)
>  =09=09vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>  =09=09if (!virtio_has_feature(vb->vdev,
>  =09=09=09=09=09VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -=09=09=09adjust_managed_page_count(page, -1);
> +=09=09=09adjust_managed_page_count(page, -(1 << page_order));
>  =09=09vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>  =09}
> =20
> @@ -223,13 +236,20 @@ static void release_pages_balloon(struct virtio_bal=
loon *vb,
>  =09=09=09=09 struct list_head *pages)
>  {
>  =09struct page *page, *next;
> +=09int page_order =3D 0;
> +
> +=09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
> +=09=09page_order =3D VIRTIO_BALLOON_THP_ORDER;
> =20
>  =09list_for_each_entry_safe(page, next, pages, lru) {
>  =09=09if (!virtio_has_feature(vb->vdev,
>  =09=09=09=09=09VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -=09=09=09adjust_managed_page_count(page, 1);
> +=09=09=09adjust_managed_page_count(page, 1 << page_order);
>  =09=09list_del(&page->lru);
> -=09=09put_page(page); /* balloon reference */
> +=09=09if (page_order)
> +=09=09=09__free_pages(page, page_order);
> +=09=09else
> +=09=09=09put_page(page); /* balloon reference */
>  =09}
>  }
> =20
> @@ -893,19 +913,21 @@ static int virtballoon_probe(struct virtio_device *=
vdev)
>  =09=09goto out_free_vb;
> =20
>  #ifdef CONFIG_BALLOON_COMPACTION
> -=09balloon_mnt =3D kern_mount(&balloon_fs);
> -=09if (IS_ERR(balloon_mnt)) {
> -=09=09err =3D PTR_ERR(balloon_mnt);
> -=09=09goto out_del_vqs;
> -=09}
> +=09if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_THP_ORDER)) {
> +=09=09balloon_mnt =3D kern_mount(&balloon_fs);
> +=09=09if (IS_ERR(balloon_mnt)) {
> +=09=09=09err =3D PTR_ERR(balloon_mnt);
> +=09=09=09goto out_del_vqs;
> +=09=09}
> =20
> -=09vb->vb_dev_info.migratepage =3D virtballoon_migratepage;
> -=09vb->vb_dev_info.inode =3D alloc_anon_inode(balloon_mnt->mnt_sb);
> -=09if (IS_ERR(vb->vb_dev_info.inode)) {
> -=09=09err =3D PTR_ERR(vb->vb_dev_info.inode);
> -=09=09goto out_kern_unmount;
> +=09=09vb->vb_dev_info.migratepage =3D virtballoon_migratepage;
> +=09=09vb->vb_dev_info.inode =3D alloc_anon_inode(balloon_mnt->mnt_sb);
> +=09=09if (IS_ERR(vb->vb_dev_info.inode)) {
> +=09=09=09err =3D PTR_ERR(vb->vb_dev_info.inode);
> +=09=09=09goto out_kern_unmount;
> +=09=09}
> +=09=09vb->vb_dev_info.inode->i_mapping->a_ops =3D &balloon_aops;
>  =09}
> -=09vb->vb_dev_info.inode->i_mapping->a_ops =3D &balloon_aops;
>  #endif
>  =09if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>  =09=09/*


I doubt this fixed all code. Anything using VIRTIO_BALLOON_PAGES_PER_PAGE
would be suspect. Also, the result might not fit in the pfns array.




> @@ -1058,6 +1080,7 @@ static unsigned int features[] =3D {
>  =09VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
>  =09VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  =09VIRTIO_BALLOON_F_PAGE_POISON,
> +=09VIRTIO_BALLOON_F_THP_ORDER,
>  };
> =20
>  static struct virtio_driver virtio_balloon_driver =3D {
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_c=
ompaction.h
> index 338aa27..4c9164e 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -100,8 +100,12 @@ static inline void balloon_page_insert(struct balloo=
n_dev_info *balloon,
>  =09=09=09=09       struct page *page)
>  {
>  =09__SetPageOffline(page);
> -=09__SetPageMovable(page, balloon->inode->i_mapping);
> -=09set_page_private(page, (unsigned long)balloon);
> +=09if (balloon->inode) {
> +=09=09__SetPageMovable(page, balloon->inode->i_mapping);
> +=09=09set_page_private(page, (unsigned long)balloon);
> +=09} else {
> +=09=09set_page_private(page, 0);
> +=09}
>  =09list_add(&page->lru, &balloon->pages);
>  }
> =20
> @@ -116,8 +120,10 @@ static inline void balloon_page_insert(struct balloo=
n_dev_info *balloon,
>  static inline void balloon_page_delete(struct page *page)
>  {
>  =09__ClearPageOffline(page);
> -=09__ClearPageMovable(page);
> -=09set_page_private(page, 0);
> +=09if (page_private(page)) {
> +=09=09__ClearPageMovable(page);
> +=09=09set_page_private(page, 0);
> +=09}
>  =09/*
>  =09 * No touch page.lru field once @page has been isolated
>  =09 * because VM is using the field.
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/vir=
tio_balloon.h
> index a1966cd7..a2998a9 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -36,10 +36,14 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM=092 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT=093 /* VQ to report free pages *=
/
>  #define VIRTIO_BALLOON_F_PAGE_POISON=094 /* Guest is using page poisonin=
g */
> +#define VIRTIO_BALLOON_F_THP_ORDER=095 /* Balloon page order to thp orde=
r */
> =20
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> =20
> +/* The order of the balloon page */
> +#define VIRTIO_BALLOON_THP_ORDER 9
> +

Why 9?

>  #define VIRTIO_BALLOON_CMD_ID_STOP=090
>  #define VIRTIO_BALLOON_CMD_ID_DONE=091
>  struct virtio_balloon_config {


Assuming the idea is to also allow passing larger chunks to host,
I think we need to switch to using regular virtio S/G for starters.
That involves spec work though.



> --=20
> 2.7.4


