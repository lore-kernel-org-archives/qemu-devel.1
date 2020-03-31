Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F24C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEBA2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2K+isIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEBA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGyW-0006Fz-Hw
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJGst-0004gv-2H
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJGsq-0007MO-PL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:24:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46218
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJGsq-0007M1-IX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585661088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYaghUfS6LZsYVGX7siHCasPhc0AigLi0OTvZq1nPEg=;
 b=L2K+isIkfWq4gSH/FE5eza1VTLqEvI51KD+jRm2WH1xwL3kHYENfOh8/Z3s9IlNhj1oYCt
 +FCyrVQP/tpw3r+Nwc/4CcpNrCt9mMlZz1h9EX9k6Gffk8FPYI9fdaAASIfLDmYvfYjeyB
 XoWjA48+OIhqwDmnCAhpxWCZbvFos/4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-dpKNPmxyMem_vDAczD5fHQ-1; Tue, 31 Mar 2020 09:24:46 -0400
X-MC-Unique: dpKNPmxyMem_vDAczD5fHQ-1
Received: by mail-wm1-f69.google.com with SMTP id t22so693882wmt.4
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 06:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Jw0nVbBv0FETBp7dw512h5tWtdfOySkR2Wz/CAg+zzM=;
 b=Q9JVghubRqEd0TR7gCnuk2iJ+9FWC40NdQ8yZCD4PldrwsXuvg3r6zonPxfa+Yd7en
 rbsC71al0udbOkk8w4rBkReUx7ZQQvdRfAEw6bTW8lzp6lbcvhRt/0wXAVEXzARdE6ag
 1GaQ0bxbmxDNIn7Dr/EzPkqH2hN+9UGcRCxb2q0iZvM8ZrgLdvFad+zlhHcgVVi6C5I+
 q4f1f2jhp5oyxxAI1i/RiCQ+T6cKu7ym+IVRghGeNdJmrBFiVxD1PgHBhZCULvJgkt/P
 ou7nsbrYsSRsjI97JG4qlZkUiFNsG14zf4iHIegPJDhN+TuhHVr+6WSdDjZxvwLtaVlG
 BpIQ==
X-Gm-Message-State: ANhLgQ1Kl9+lY5diaKRJvbg+az5YEIHAaUFImjlGABuqm9yYoj+MmXhP
 ZNiiWGaGAq+eP09qmd+Z7qzKqF3YM826JYr29rsMicm3BtbNxT73R667t1aOXnI5cWqQbsO9JLB
 0B5En1QuXzGN/6y8=
X-Received: by 2002:a7b:c252:: with SMTP id b18mr3403593wmj.2.1585661082436;
 Tue, 31 Mar 2020 06:24:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vueGTo4Ef5rfIWPa4rYbmXOXg2dHEafCnE+5sFNPgsm8xhuhqsFd64QYZSAHkmDonQf6kjs/g==
X-Received: by 2002:a7b:c252:: with SMTP id b18mr3403562wmj.2.1585661082107;
 Tue, 31 Mar 2020 06:24:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id b199sm4202969wme.23.2020.03.31.06.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 06:24:40 -0700 (PDT)
Date: Tue, 31 Mar 2020 09:24:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200331091718-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
> On 26.03.20 10:49, Michael S. Tsirkin wrote:
> > On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
> >>
> >>
> >>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
> >>>
> >>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand =
wrote:
> >>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >>>>>> 2. You are essentially stealing THPs in the guest. So the fastest
> >>>>>> mapping (THP in guest and host) is gone. The guest won't be able t=
o make
> >>>>>> use of THP where it previously was able to. I can imagine this imp=
lies a
> >>>>>> performance degradation for some workloads. This needs a proper
> >>>>>> performance evaluation.
> >>>>>
> >>>>> I think the problem is more with the alloc_pages API.
> >>>>> That gives you exactly the given order, and if there's
> >>>>> a larger chunk available, it will split it up.
> >>>>>
> >>>>> But for balloon - I suspect lots of other users,
> >>>>> we do not want to stress the system but if a large
> >>>>> chunk is available anyway, then we could handle
> >>>>> that more optimally by getting it all in one go.
> >>>>>
> >>>>>
> >>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>> Along the lines of
> >>>>>
> >>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>
> >>>>> the idea would then be to return at a number of pages in the given
> >>>>> range.
> >>>>>
> >>>>> What do you think? Want to try implementing that?
> >>>>
> >>>> You can just start with the highest order and decrement the order un=
til
> >>>> your allocation succeeds using alloc_pages(), which would be enough =
for
> >>>> a first version. At least I don't see the immediate need for a new
> >>>> kernel API.
> >>>
> >>> OK I remember now.  The problem is with reclaim. Unless reclaim is
> >>> completely disabled, any of these calls can sleep. After it wakes up,
> >>> we would like to get the larger order that has become available
> >>> meanwhile.
> >>>
> >>
> >> Yes, but that=E2=80=98s a pure optimization IMHO.
> >> So I think we should do a trivial implementation first and then see wh=
at we gain from a new allocator API. Then we might also be able to justify =
it using real numbers.
> >>
> >=20
> > Well how do you propose implement the necessary semantics?
> > I think we are both agreed that alloc_page_range is more or
> > less what's necessary anyway - so how would you approximate it
> > on top of existing APIs?
>=20
> Looking at drivers/misc/vmw_balloon.c:vmballoon_inflate(), it first
> tries to allocate huge pages using
>=20
> =09alloc_pages(__GFP_HIGHMEM|__GFP_NOWARN| __GFP_NOMEMALLOC,=20
>                     VMW_BALLOON_2M_ORDER)
>=20
> And then falls back to 4k allocations (balloon_page_alloc()) in case
> allocation fails.
>=20
> I'm roughly thinking of something like the following, but with an
> optimized reporting interface/bigger pfn array so we can report >
> 1MB at a time. Also, it might make sense to remember the order that
> succeeded across some fill_balloon() calls.
>=20
> Don't even expect it to compile ...
>=20
>=20
>=20
> >From 4305f989672ccca4be9293e6d4167e929f3e299b Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 31 Mar 2020 12:28:07 +0200
> Subject: [PATCH RFC] tmp
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c    | 38 ++++++++++++++++++--------
>  include/linux/balloon_compaction.h |  7 ++++-
>  mm/balloon_compaction.c            | 43 +++++++++++++++++++++++-------
>  3 files changed, 67 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 8511d258dbb4..0660b1b988f0 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -187,7 +187,7 @@ int virtballoon_free_page_report(struct page_reportin=
g_dev_info *pr_dev_info,
>  }
> =20
>  static void set_page_pfns(struct virtio_balloon *vb,
> -=09=09=09  __virtio32 pfns[], struct page *page)
> +=09=09=09  __virtio32 pfns[], struct page *page, int order)
>  {
>  =09unsigned int i;
> =20
> @@ -197,7 +197,7 @@ static void set_page_pfns(struct virtio_balloon *vb,
>  =09 * Set balloon pfns pointing at this page.
>  =09 * Note that the first pfn points at start of the page.
>  =09 */
> -=09for (i =3D 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE; i++)
> +=09for (i =3D 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order); i++)
>  =09=09pfns[i] =3D cpu_to_virtio32(vb->vdev,
>  =09=09=09=09=09  page_to_balloon_pfn(page) + i);
>  }
> @@ -205,6 +205,7 @@ static void set_page_pfns(struct virtio_balloon *vb,
>  static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  {
>  =09unsigned num_allocated_pages;
> +=09int order =3D MAX_ORDER - 1;
>  =09unsigned num_pfns;
>  =09struct page *page;
>  =09LIST_HEAD(pages);
> @@ -212,9 +213,20 @@ static unsigned fill_balloon(struct virtio_balloon *=
vb, size_t num)
>  =09/* We can only do one array worth at a time. */
>  =09num =3D min(num, ARRAY_SIZE(vb->pfns));
> =20
> +=09/*
> +=09 * Note: we will currently never allocate more than 1MB due to the
> +=09 * pfn array size, so we will not allocate MAX_ORDER - 1 ...
> +=09 */
> +
>  =09for (num_pfns =3D 0; num_pfns < num;
> -=09     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -=09=09struct page *page =3D balloon_page_alloc();
> +=09     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order)) {
> +=09=09const unsigned long remaining =3D num - num_pfns;
> +
> +=09=09order =3D MIN(order,
> +=09=09=09    get_order(remaining << VIRTIO_BALLOON_PFN_SHIFT));
> +=09=09if ((1 << order) * VIRTIO_BALLOON_PAGES_PER_PAGE > remaining)
> +=09=09=09order--;
> +=09=09page =3D balloon_pages_alloc(order);
> =20
>  =09=09if (!page) {
>  =09=09=09dev_info_ratelimited(&vb->vdev->dev,
> @@ -225,6 +237,8 @@ static unsigned fill_balloon(struct virtio_balloon *v=
b, size_t num)
>  =09=09=09break;
>  =09=09}
> =20
> +=09=09/* Continue with the actual order that succeeded. */
> +=09=09order =3D page_private(page);
>  =09=09balloon_page_push(&pages, page);
>  =09}
> =20
> @@ -233,14 +247,16 @@ static unsigned fill_balloon(struct virtio_balloon =
*vb, size_t num)
>  =09vb->num_pfns =3D 0;
> =20
>  =09while ((page =3D balloon_page_pop(&pages))) {
> +=09=09order =3D page_order(page);
> +=09=09/* enqueuing will split the page and clear the order */
>  =09=09balloon_page_enqueue(&vb->vb_dev_info, page);
> =20
> -=09=09set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> -=09=09vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
> +=09=09set_page_pfns(vb, vb->pfns + vb->num_pfns, page, order);
> +=09=09vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order);
>  =09=09if (!virtio_has_feature(vb->vdev,
>  =09=09=09=09=09VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -=09=09=09adjust_managed_page_count(page, -1);
> -=09=09vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
> +=09=09=09adjust_managed_page_count(page, -1 * (1 << order));
> +=09=09vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order);
>  =09}
> =20
>  =09num_allocated_pages =3D vb->num_pfns;
> @@ -284,7 +300,7 @@ static unsigned leak_balloon(struct virtio_balloon *v=
b, size_t num)
>  =09=09page =3D balloon_page_dequeue(vb_dev_info);
>  =09=09if (!page)
>  =09=09=09break;
> -=09=09set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> +=09=09set_page_pfns(vb, vb->pfns + vb->num_pfns, page, 0);
>  =09=09list_add(&page->lru, &pages);
>  =09=09vb->num_pages -=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>  =09}
> @@ -786,7 +802,7 @@ static int virtballoon_migratepage(struct balloon_dev=
_info *vb_dev_info,
>  =09__count_vm_event(BALLOON_MIGRATE);
>  =09spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
>  =09vb->num_pfns =3D VIRTIO_BALLOON_PAGES_PER_PAGE;
> -=09set_page_pfns(vb, vb->pfns, newpage);
> +=09set_page_pfns(vb, vb->pfns, newpage, 0);
>  =09tell_host(vb, vb->inflate_vq);
> =20
>  =09/* balloon's page migration 2nd step -- deflate "page" */
> @@ -794,7 +810,7 @@ static int virtballoon_migratepage(struct balloon_dev=
_info *vb_dev_info,
>  =09balloon_page_delete(page);
>  =09spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
>  =09vb->num_pfns =3D VIRTIO_BALLOON_PAGES_PER_PAGE;
> -=09set_page_pfns(vb, vb->pfns, page);
> +=09set_page_pfns(vb, vb->pfns, page, 0);
>  =09tell_host(vb, vb->deflate_vq);
> =20
>  =09mutex_unlock(&vb->balloon_lock);
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_c=
ompaction.h
> index 338aa27e4773..ed93fe5704d1 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -60,7 +60,7 @@ struct balloon_dev_info {
>  =09struct inode *inode;
>  };
> =20
> -extern struct page *balloon_page_alloc(void);
> +extern struct page *balloon_pages_alloc(int order);
>  extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  =09=09=09=09 struct page *page);
>  extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_=
info);
> @@ -78,6 +78,11 @@ static inline void balloon_devinfo_init(struct balloon=
_dev_info *balloon)
>  =09balloon->inode =3D NULL;
>  }
> =20
> +static inline struct page *balloon_page_alloc(void)
> +{
> +=09return balloon_pages_alloc(0);
> +}
> +
>  #ifdef CONFIG_BALLOON_COMPACTION
>  extern const struct address_space_operations balloon_aops;
>  extern bool balloon_page_isolate(struct page *page,
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 26de020aae7b..067810b32813 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloon_dev=
_info *b_dev_info,
>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> =20
>  /*
> - * balloon_page_alloc - allocates a new page for insertion into the ball=
oon
> - *=09=09=09page list.
> + * balloon_pages_alloc - allocates a new page (of at most the given orde=
r)
> + * =09=09=09 for insertion into the balloon page list.
>   *
>   * Driver must call this function to properly allocate a new balloon pag=
e.
>   * Driver must call balloon_page_enqueue before definitively removing th=
e page
>   * from the guest system.
>   *
> + * Will fall back to smaller orders if allocation fails. The order of th=
e
> + * allocated page is stored in page->private.
> + *
>   * Return: struct page for the allocated page or NULL on allocation fail=
ure.
>   */
> -struct page *balloon_page_alloc(void)
> +struct page *balloon_pages_alloc(int order)
>  {
> -=09struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
> -=09=09=09=09       __GFP_NOMEMALLOC | __GFP_NORETRY |
> -=09=09=09=09       __GFP_NOWARN);
> -=09return page;
> +=09struct page *page;
> +
> +=09while (order >=3D 0) {
> +=09=09page =3D alloc_pages(balloon_mapping_gfp_mask() |
> +=09=09=09=09   __GFP_NOMEMALLOC | __GFP_NORETRY |
> +=09=09=09=09   __GFP_NOWARN, order);
> +=09=09if (page) {
> +=09=09=09set_page_private(page, order);
> +=09=09=09return page;
> +=09=09}
> +=09=09order--;
> +=09}
> +=09return NULL;
>  }
> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> =20
>  /*
>   * balloon_page_enqueue - inserts a new page into the balloon page list.


I think this will try to invoke direct reclaim from the first iteration
to free up the max order.

> @@ -146,10 +158,23 @@ EXPORT_SYMBOL_GPL(balloon_page_alloc);
>  void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  =09=09=09  struct page *page)
>  {
> +=09const int order =3D page_private(page);
>  =09unsigned long flags;
> +=09int i;
> +
> +=09/*
> +=09 * We can only migrate single pages - and even if we could migrate
> +=09 * bigger ones, we would want to split them on demand instead of
> +=09 * trying to move around big chunks.
> +=09 */
> +=09if (order > 0)
> +=09=09split_page(page, order);
> +=09set_page_private(page, order);
> =20
>  =09spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> -=09balloon_page_enqueue_one(b_dev_info, page);
> +=09for (i =3D 0; i < (1 << order); i++)
> +=09=09balloon_page_enqueue_one(b_dev_info, page + i);
> +
>  =09spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_enqueue);
> --=20
> 2.25.1
>=20
> --=20
> Thanks,
>=20
> David / dhildenb


