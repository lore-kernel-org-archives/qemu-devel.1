Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88140C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4F32080C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzBd9qyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4F32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbTO-0002kM-B6
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jJbRJ-0000ik-2j
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jJbRG-00066H-Lq
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:21:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jJbRG-00064x-GL
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585740101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cyECR4aJG/7CeIBblQy9M1dejlYBqUo0wJPVJet5SNA=;
 b=BzBd9qyjXSCSyYBSOVL17iPRQtmQ6yg51F4L2Dn8mdK2T6w5BVcjpzvPzyRu+oEV5jb+0F
 dFh66EFDK+kWsmG1x25WRQWA5N9SJcebwuGpmFLQv6Ap0uZuRMmv3nU8shNsJedsT0hujQ
 KNQvAdLYOoyhgfVj21W+Ev3W8lBKRfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-QxhtB1ISNFmLfsksWmjf3w-1; Wed, 01 Apr 2020 07:21:39 -0400
X-MC-Unique: QxhtB1ISNFmLfsksWmjf3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8F0C8014D7;
 Wed,  1 Apr 2020 11:21:37 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA6E19C6A;
 Wed,  1 Apr 2020 11:21:29 +0000 (UTC)
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
To: Nadav Amit <namit@vmware.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <DD651B97-C7C2-4071-BD8D-EB5BC00A3A52@vmware.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <de0371da-3bf8-7873-559d-665a0e7c0fc5@redhat.com>
Date: Wed, 1 Apr 2020 13:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DD651B97-C7C2-4071-BD8D-EB5BC00A3A52@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "pagupta@redhat.com" <pagupta@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mojha@codeaurora.org" <mojha@codeaurora.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 LKML <linux-kernel@vger.kernel.org>, Hui Zhu <teawaterz@linux.alibaba.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31.03.20 18:27, Nadav Amit wrote:
>> On Mar 31, 2020, at 6:32 AM, David Hildenbrand <david@redhat.com> wrot=
e:
>>
>> On 31.03.20 15:24, Michael S. Tsirkin wrote:
>>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
>>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
>>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
>>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com=
>:
>>>>>>>
>>>>>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbr=
and wrote:
>>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wro=
te:
>>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the fast=
est
>>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't be ab=
le to make
>>>>>>>>>> use of THP where it previously was able to. I can imagine this=
 implies a
>>>>>>>>>> performance degradation for some workloads. This needs a prope=
r
>>>>>>>>>> performance evaluation.
>>>>>>>>>
>>>>>>>>> I think the problem is more with the alloc_pages API.
>>>>>>>>> That gives you exactly the given order, and if there's
>>>>>>>>> a larger chunk available, it will split it up.
>>>>>>>>>
>>>>>>>>> But for balloon - I suspect lots of other users,
>>>>>>>>> we do not want to stress the system but if a large
>>>>>>>>> chunk is available anyway, then we could handle
>>>>>>>>> that more optimally by getting it all in one go.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
>>>>>>>>> Along the lines of
>>>>>>>>>
>>>>>>>>>   struct page *alloc_page_range(gfp_t gfp, unsigned int min_ord=
er,
>>>>>>>>>                   unsigned int max_order, unsigned int *order)
>>>>>>>>>
>>>>>>>>> the idea would then be to return at a number of pages in the gi=
ven
>>>>>>>>> range.
>>>>>>>>>
>>>>>>>>> What do you think? Want to try implementing that?
>>>>>>>>
>>>>>>>> You can just start with the highest order and decrement the orde=
r until
>>>>>>>> your allocation succeeds using alloc_pages(), which would be eno=
ugh for
>>>>>>>> a first version. At least I don't see the immediate need for a n=
ew
>>>>>>>> kernel API.
>>>>>>>
>>>>>>> OK I remember now.  The problem is with reclaim. Unless reclaim i=
s
>>>>>>> completely disabled, any of these calls can sleep. After it wakes=
 up,
>>>>>>> we would like to get the larger order that has become available
>>>>>>> meanwhile.
>>>>>>
>>>>>> Yes, but that=E2=80=98s a pure optimization IMHO.
>>>>>> So I think we should do a trivial implementation first and then se=
e what we gain from a new allocator API. Then we might also be able to ju=
stify it using real numbers.
>>>>>
>>>>> Well how do you propose implement the necessary semantics?
>>>>> I think we are both agreed that alloc_page_range is more or
>>>>> less what's necessary anyway - so how would you approximate it
>>>>> on top of existing APIs?
>>>>
>>>> Looking at drivers/misc/vmw_balloon.c:vmballoon_inflate(), it first
>>>> tries to allocate huge pages using
>>>>
>>>> 	alloc_pages(__GFP_HIGHMEM|__GFP_NOWARN| __GFP_NOMEMALLOC,=20
>>>>                    VMW_BALLOON_2M_ORDER)
>>>>
>>>> And then falls back to 4k allocations (balloon_page_alloc()) in case
>>>> allocation fails.
>>>>
>>>> I'm roughly thinking of something like the following, but with an
>>>> optimized reporting interface/bigger pfn array so we can report >
>>>> 1MB at a time. Also, it might make sense to remember the order that
>>>> succeeded across some fill_balloon() calls.
>>>>
>>>> Don't even expect it to compile ...
>>>>
>>>>
>>>>
>>>>> From 4305f989672ccca4be9293e6d4167e929f3e299b Mon Sep 17 00:00:00 2=
001
>>>> From: David Hildenbrand <david@redhat.com>
>>>> Date: Tue, 31 Mar 2020 12:28:07 +0200
>>>> Subject: [PATCH RFC] tmp
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>> drivers/virtio/virtio_balloon.c    | 38 ++++++++++++++++++--------
>>>> include/linux/balloon_compaction.h |  7 ++++-
>>>> mm/balloon_compaction.c            | 43 +++++++++++++++++++++++-----=
--
>>>> 3 files changed, 67 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio=
_balloon.c
>>>> index 8511d258dbb4..0660b1b988f0 100644
>>>> --- a/drivers/virtio/virtio_balloon.c
>>>> +++ b/drivers/virtio/virtio_balloon.c
>>>> @@ -187,7 +187,7 @@ int virtballoon_free_page_report(struct page_rep=
orting_dev_info *pr_dev_info,
>>>> }
>>>>
>>>> static void set_page_pfns(struct virtio_balloon *vb,
>>>> -			  __virtio32 pfns[], struct page *page)
>>>> +			  __virtio32 pfns[], struct page *page, int order)
>>>> {
>>>> 	unsigned int i;
>>>>
>>>> @@ -197,7 +197,7 @@ static void set_page_pfns(struct virtio_balloon =
*vb,
>>>> 	 * Set balloon pfns pointing at this page.
>>>> 	 * Note that the first pfn points at start of the page.
>>>> 	 */
>>>> -	for (i =3D 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE; i++)
>>>> +	for (i =3D 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order); i+=
+)
>>>> 		pfns[i] =3D cpu_to_virtio32(vb->vdev,
>>>> 					  page_to_balloon_pfn(page) + i);
>>>> }
>>>> @@ -205,6 +205,7 @@ static void set_page_pfns(struct virtio_balloon =
*vb,
>>>> static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>>>> {
>>>> 	unsigned num_allocated_pages;
>>>> +	int order =3D MAX_ORDER - 1;
>>>> 	unsigned num_pfns;
>>>> 	struct page *page;
>>>> 	LIST_HEAD(pages);
>>>> @@ -212,9 +213,20 @@ static unsigned fill_balloon(struct virtio_ball=
oon *vb, size_t num)
>>>> 	/* We can only do one array worth at a time. */
>>>> 	num =3D min(num, ARRAY_SIZE(vb->pfns));
>>>>
>>>> +	/*
>>>> +	 * Note: we will currently never allocate more than 1MB due to the
>>>> +	 * pfn array size, so we will not allocate MAX_ORDER - 1 ...
>>>> +	 */
>>>> +
>>>> 	for (num_pfns =3D 0; num_pfns < num;
>>>> -	     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE) {
>>>> -		struct page *page =3D balloon_page_alloc();
>>>> +	     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order)) {
>>>> +		const unsigned long remaining =3D num - num_pfns;
>>>> +
>>>> +		order =3D MIN(order,
>>>> +			    get_order(remaining << VIRTIO_BALLOON_PFN_SHIFT));
>>>> +		if ((1 << order) * VIRTIO_BALLOON_PAGES_PER_PAGE > remaining)
>>>> +			order--;
>>>> +		page =3D balloon_pages_alloc(order);
>>>>
>>>> 		if (!page) {
>>>> 			dev_info_ratelimited(&vb->vdev->dev,
>>>> @@ -225,6 +237,8 @@ static unsigned fill_balloon(struct virtio_ballo=
on *vb, size_t num)
>>>> 			break;
>>>> 		}
>>>>
>>>> +		/* Continue with the actual order that succeeded. */
>>>> +		order =3D page_private(page);
>>>> 		balloon_page_push(&pages, page);
>>>> 	}
>>>>
>>>> @@ -233,14 +247,16 @@ static unsigned fill_balloon(struct virtio_bal=
loon *vb, size_t num)
>>>> 	vb->num_pfns =3D 0;
>>>>
>>>> 	while ((page =3D balloon_page_pop(&pages))) {
>>>> +		order =3D page_order(page);
>>>> +		/* enqueuing will split the page and clear the order */
>>>> 		balloon_page_enqueue(&vb->vb_dev_info, page);
>>>>
>>>> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>>>> -		vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>>>> +		set_page_pfns(vb, vb->pfns + vb->num_pfns, page, order);
>>>> +		vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order);
>>>> 		if (!virtio_has_feature(vb->vdev,
>>>> 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>>>> -			adjust_managed_page_count(page, -1);
>>>> -		vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>>>> +			adjust_managed_page_count(page, -1 * (1 << order));
>>>> +		vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE * (1 << order);
>>>> 	}
>>>>
>>>> 	num_allocated_pages =3D vb->num_pfns;
>>>> @@ -284,7 +300,7 @@ static unsigned leak_balloon(struct virtio_ballo=
on *vb, size_t num)
>>>> 		page =3D balloon_page_dequeue(vb_dev_info);
>>>> 		if (!page)
>>>> 			break;
>>>> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>>>> +		set_page_pfns(vb, vb->pfns + vb->num_pfns, page, 0);
>>>> 		list_add(&page->lru, &pages);
>>>> 		vb->num_pages -=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>>>> 	}
>>>> @@ -786,7 +802,7 @@ static int virtballoon_migratepage(struct balloo=
n_dev_info *vb_dev_info,
>>>> 	__count_vm_event(BALLOON_MIGRATE);
>>>> 	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
>>>> 	vb->num_pfns =3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>>>> -	set_page_pfns(vb, vb->pfns, newpage);
>>>> +	set_page_pfns(vb, vb->pfns, newpage, 0);
>>>> 	tell_host(vb, vb->inflate_vq);
>>>>
>>>> 	/* balloon's page migration 2nd step -- deflate "page" */
>>>> @@ -794,7 +810,7 @@ static int virtballoon_migratepage(struct balloo=
n_dev_info *vb_dev_info,
>>>> 	balloon_page_delete(page);
>>>> 	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
>>>> 	vb->num_pfns =3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>>>> -	set_page_pfns(vb, vb->pfns, page);
>>>> +	set_page_pfns(vb, vb->pfns, page, 0);
>>>> 	tell_host(vb, vb->deflate_vq);
>>>>
>>>> 	mutex_unlock(&vb->balloon_lock);
>>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/ball=
oon_compaction.h
>>>> index 338aa27e4773..ed93fe5704d1 100644
>>>> --- a/include/linux/balloon_compaction.h
>>>> +++ b/include/linux/balloon_compaction.h
>>>> @@ -60,7 +60,7 @@ struct balloon_dev_info {
>>>> 	struct inode *inode;
>>>> };
>>>>
>>>> -extern struct page *balloon_page_alloc(void);
>>>> +extern struct page *balloon_pages_alloc(int order);
>>>> extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info=
,
>>>> 				 struct page *page);
>>>> extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_=
dev_info);
>>>> @@ -78,6 +78,11 @@ static inline void balloon_devinfo_init(struct ba=
lloon_dev_info *balloon)
>>>> 	balloon->inode =3D NULL;
>>>> }
>>>>
>>>> +static inline struct page *balloon_page_alloc(void)
>>>> +{
>>>> +	return balloon_pages_alloc(0);
>>>> +}
>>>> +
>>>> #ifdef CONFIG_BALLOON_COMPACTION
>>>> extern const struct address_space_operations balloon_aops;
>>>> extern bool balloon_page_isolate(struct page *page,
>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>>>> index 26de020aae7b..067810b32813 100644
>>>> --- a/mm/balloon_compaction.c
>>>> +++ b/mm/balloon_compaction.c
>>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloo=
n_dev_info *b_dev_info,
>>>> EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>>>>
>>>> /*
>>>> - * balloon_page_alloc - allocates a new page for insertion into the=
 balloon
>>>> - *			page list.
>>>> + * balloon_pages_alloc - allocates a new page (of at most the given=
 order)
>>>> + * 			 for insertion into the balloon page list.
>>>>  *
>>>>  * Driver must call this function to properly allocate a new balloon=
 page.
>>>>  * Driver must call balloon_page_enqueue before definitively removin=
g the page
>>>>  * from the guest system.
>>>>  *
>>>> + * Will fall back to smaller orders if allocation fails. The order =
of the
>>>> + * allocated page is stored in page->private.
>>>> + *
>>>>  * Return: struct page for the allocated page or NULL on allocation =
failure.
>>>>  */
>>>> -struct page *balloon_page_alloc(void)
>>>> +struct page *balloon_pages_alloc(int order)
>>>> {
>>>> -	struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
>>>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>> -				       __GFP_NOWARN);
>>>> -	return page;
>>>> +	struct page *page;
>>>> +
>>>> +	while (order >=3D 0) {
>>>> +		page =3D alloc_pages(balloon_mapping_gfp_mask() |
>>>> +				   __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>> +				   __GFP_NOWARN, order);
>>>> +		if (page) {
>>>> +			set_page_private(page, order);
>>>> +			return page;
>>>> +		}
>>>> +		order--;
>>>> +	}
>>>> +	return NULL;
>>>> }
>>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
>>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
>>>>
>>>> /*
>>>>  * balloon_page_enqueue - inserts a new page into the balloon page l=
ist.
>>>
>>>
>>> I think this will try to invoke direct reclaim from the first iterati=
on
>>> to free up the max order.
>>
>> %__GFP_NORETRY: The VM implementation will try only very lightweight
>> memory direct reclaim to get some memory under memory pressure (thus i=
t
>> can sleep). It will avoid disruptive actions like OOM killer.
>>
>> Certainly good enough for a first version I would say, no? Looking at
>> the vmware balloon, they don't even set __GFP_NORETRY.
>=20
> Yes, it does seem that we are missing __GFP_NORETRY. I really do not kn=
ow
> what I was thinking when I did not add it for huge-pages allocation. I =
will
> send a patch. Thanks for noticing :)
>=20
> In regard to your patch, I would be happy to consolidate the allocation
> mechanisms, so VMware balloon driver would also use your code. In gener=
al
> your code looks good, take-away some style issues.

Yeah, let's see in which direction we'll be bringing
balloon_page_alloc(), I think there are still some questions to be
answered (mostly performance implications).

Cheers!

--=20
Thanks,

David / dhildenb


