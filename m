Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEEEC2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE353206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0kHYrU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE353206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJMa-0002lp-UN
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jCJLw-0002M6-Al
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jCJLt-0001iz-A7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:38:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23994
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jCJLs-0001g7-UI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584002280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mx1leOjTNR8FYx8qJWBeI/9aTN1gnOw5M28KCVuuEBo=;
 b=Y0kHYrU4tUbu6SivPkVOtRSICVXyiSCXkPxhtHMkRuh9QQOb0h5x/OZBPyUlpeOwylCGqi
 3Hh0eOLaTCJ49jrjBjkJK/xMHfygIxh4xnM8O92x97yowWpb7lW/pawinZbeTN6wtCmKTF
 X5yTHUrm2cr+ed5g2iaEfMJGlhMZUB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-RG2gu1JiNFe3x6howx2dtw-1; Thu, 12 Mar 2020 04:37:55 -0400
X-MC-Unique: RG2gu1JiNFe3x6howx2dtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C181913F5;
 Thu, 12 Mar 2020 08:37:53 +0000 (UTC)
Received: from [10.36.117.247] (ovpn-117-247.ams2.redhat.com [10.36.117.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D090D10013A1;
 Thu, 12 Mar 2020 08:37:34 +0000 (UTC)
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
To: Hui Zhu <teawater@gmail.com>, mst@redhat.com, jasowang@redhat.com,
 akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org,
 namit@vmware.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
Date: Thu, 12 Mar 2020 09:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583999395-9131-1-git-send-email-teawater@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
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
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Hui Zhu <teawaterz@linux.alibaba.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12.03.20 08:49, Hui Zhu wrote:
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
> When this flag is set, the balloon page order will be set to the THP or=
der.
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
> The THP number decreases 384M.  This shows that VIRTIO_BALLOON_F_THP_OR=
DER
> can help handle the THP split issue.


Multiple things:

I recently had a similar discussion with Alex [1] and I think this needs
more thought.

My thoughts:

1. You most certainly want to fallback to allocating pages in a smaller
granularity once you run out of bigger allocations. Sacrifice
performance for memory inflation, which has always been the case and
which is what people expect to happen. (e.g., to shrink the page cache
properly)

2. You are essentially stealing THPs in the guest. So the fastest
mapping (THP in guest and host) is gone. The guest won't be able to make
use of THP where it previously was able to. I can imagine this implies a
performance degradation for some workloads. This needs a proper
performance evaluation.

3. The pages you allocate are not migrateable, e.g., for memory
offlining or alloc_contig_range() users like gigantic pages or soon
virtio-mem. I strongly dislike that. This is IMHO a step backwards. We
want to be able to migrate or even split-up and migrate such pages.

Assume the guest could make good use of a THP somewhere. Who says it
wouldn't be better to sacrifice a huge balloon page to be able to use
THP both in the guest and the host for that mapping? I am not convinced
stealing possible THPs in the guest and not being able to split them up
is really what we want performance wise.


4. I think we also want a better mechanism to directly inflate/deflate
higher/order pages and not reuse the 4k inflate/deflate queues.

5. I think we don't want to hard code such THP values but let the host
tell us the THP size instead, which can easily differ between guest and
host.

Also, I do wonder if balloon compaction in the guest will already result
in more THP getting used again long term. Assume the guest compacts
balloon pages into a single THP again. This will result in a bunch of
DONTNEED/WILLNEED in the hypervisor due to inflation/deflation. I wonder
if the WILLNEED on the sub-pages of a candidate THP in the host will
allow to use a THP in the host again.


[1]
https://lore.kernel.org/linux-mm/939de9de-d82a-aed2-6a51-57a55d81cbff@red=
hat.com/

>=20
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 57 ++++++++++++++++++++++++++---=
--------
>  include/linux/balloon_compaction.h  | 14 ++++++---
>  include/uapi/linux/virtio_balloon.h |  4 +++
>  3 files changed, 54 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> index 7bfe365..1e1dc76 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -175,18 +175,31 @@ static unsigned fill_balloon(struct virtio_balloo=
n *vb, size_t num)
>  	unsigned num_pfns;
>  	struct page *page;
>  	LIST_HEAD(pages);
> +	int page_order =3D 0;
> =20
>  	/* We can only do one array worth at a time. */
>  	num =3D min(num, ARRAY_SIZE(vb->pfns));
> =20
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
> +		page_order =3D VIRTIO_BALLOON_THP_ORDER;
> +
>  	for (num_pfns =3D 0; num_pfns < num;
>  	     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page =3D balloon_page_alloc();
> +		struct page *page;
> +
> +		if (page_order)
> +			page =3D alloc_pages(__GFP_HIGHMEM |
> +					   __GFP_KSWAPD_RECLAIM |
> +					   __GFP_RETRY_MAYFAIL |
> +					   __GFP_NOWARN | __GFP_NOMEMALLOC,
> +					   page_order);
> +		else
> +			page =3D balloon_page_alloc();
> =20
>  		if (!page) {
>  			dev_info_ratelimited(&vb->vdev->dev,
> -					     "Out of puff! Can't get %u pages\n",
> -					     VIRTIO_BALLOON_PAGES_PER_PAGE);
> +				"Out of puff! Can't get %u pages\n",
> +				VIRTIO_BALLOON_PAGES_PER_PAGE << page_order);
>  			/* Sleep for at least 1/5 of a second before retry. */
>  			msleep(200);
>  			break;
> @@ -206,7 +219,7 @@ static unsigned fill_balloon(struct virtio_balloon =
*vb, size_t num)
>  		vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, -1);
> +			adjust_managed_page_count(page, -(1 << page_order));
>  		vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
> =20
> @@ -223,13 +236,20 @@ static void release_pages_balloon(struct virtio_b=
alloon *vb,
>  				 struct list_head *pages)
>  {
>  	struct page *page, *next;
> +	int page_order =3D 0;
> +
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
> +		page_order =3D VIRTIO_BALLOON_THP_ORDER;
> =20
>  	list_for_each_entry_safe(page, next, pages, lru) {
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, 1);
> +			adjust_managed_page_count(page, 1 << page_order);
>  		list_del(&page->lru);
> -		put_page(page); /* balloon reference */
> +		if (page_order)
> +			__free_pages(page, page_order);
> +		else
> +			put_page(page); /* balloon reference */
>  	}
>  }
> =20
> @@ -893,19 +913,21 @@ static int virtballoon_probe(struct virtio_device=
 *vdev)
>  		goto out_free_vb;
> =20
>  #ifdef CONFIG_BALLOON_COMPACTION
> -	balloon_mnt =3D kern_mount(&balloon_fs);
> -	if (IS_ERR(balloon_mnt)) {
> -		err =3D PTR_ERR(balloon_mnt);
> -		goto out_del_vqs;
> -	}
> +	if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_THP_ORDER)) {
> +		balloon_mnt =3D kern_mount(&balloon_fs);
> +		if (IS_ERR(balloon_mnt)) {
> +			err =3D PTR_ERR(balloon_mnt);
> +			goto out_del_vqs;
> +		}
> =20
> -	vb->vb_dev_info.migratepage =3D virtballoon_migratepage;
> -	vb->vb_dev_info.inode =3D alloc_anon_inode(balloon_mnt->mnt_sb);
> -	if (IS_ERR(vb->vb_dev_info.inode)) {
> -		err =3D PTR_ERR(vb->vb_dev_info.inode);
> -		goto out_kern_unmount;
> +		vb->vb_dev_info.migratepage =3D virtballoon_migratepage;
> +		vb->vb_dev_info.inode =3D alloc_anon_inode(balloon_mnt->mnt_sb);
> +		if (IS_ERR(vb->vb_dev_info.inode)) {
> +			err =3D PTR_ERR(vb->vb_dev_info.inode);
> +			goto out_kern_unmount;
> +		}
> +		vb->vb_dev_info.inode->i_mapping->a_ops =3D &balloon_aops;
>  	}
> -	vb->vb_dev_info.inode->i_mapping->a_ops =3D &balloon_aops;
>  #endif
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>  		/*
> @@ -1058,6 +1080,7 @@ static unsigned int features[] =3D {
>  	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
>  	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  	VIRTIO_BALLOON_F_PAGE_POISON,
> +	VIRTIO_BALLOON_F_THP_ORDER,
>  };
> =20
>  static struct virtio_driver virtio_balloon_driver =3D {
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon=
_compaction.h
> index 338aa27..4c9164e 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -100,8 +100,12 @@ static inline void balloon_page_insert(struct ball=
oon_dev_info *balloon,
>  				       struct page *page)
>  {
>  	__SetPageOffline(page);
> -	__SetPageMovable(page, balloon->inode->i_mapping);
> -	set_page_private(page, (unsigned long)balloon);
> +	if (balloon->inode) {
> +		__SetPageMovable(page, balloon->inode->i_mapping);
> +		set_page_private(page, (unsigned long)balloon);
> +	} else {
> +		set_page_private(page, 0);
> +	}
>  	list_add(&page->lru, &balloon->pages);
>  }
> =20
> @@ -116,8 +120,10 @@ static inline void balloon_page_insert(struct ball=
oon_dev_info *balloon,
>  static inline void balloon_page_delete(struct page *page)
>  {
>  	__ClearPageOffline(page);
> -	__ClearPageMovable(page);
> -	set_page_private(page, 0);
> +	if (page_private(page)) {
> +		__ClearPageMovable(page);
> +		set_page_private(page, 0);
> +	}
>  	/*
>  	 * No touch page.lru field once @page has been isolated
>  	 * because VM is using the field.
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/v=
irtio_balloon.h
> index a1966cd7..a2998a9 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -36,10 +36,14 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages *=
/
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisonin=
g */
> +#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Balloon page order to thp orde=
r */
> =20
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> =20
> +/* The order of the balloon page */
> +#define VIRTIO_BALLOON_THP_ORDER 9
> +
>  #define VIRTIO_BALLOON_CMD_ID_STOP	0
>  #define VIRTIO_BALLOON_CMD_ID_DONE	1
>  struct virtio_balloon_config {
>=20


--=20
Thanks,

David / dhildenb


