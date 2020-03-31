Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E538AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DB720658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOFJFa7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DB720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHaD-0006lf-Qv
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJHY0-0002zI-E6
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJHXy-00081U-TE
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJHXy-00081E-OI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585663638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EF6IXr1eWegUsFOgvOq8hWc7/VEhsR9VF0oJ3L+PKzM=;
 b=aOFJFa7u2FEDRpcFIs3ybdsw1rQ2KiKto+gFhnkibXM7x+KJ+ebpI0rK/rfXJbzyQRkPvb
 ADbjEIwxP+iekGj0rtjXgtwLmcU88ciW5RBbUUcLVPaBHzd+Ni2mv+9N0+UZbJMbdyRv1a
 id9Zb1nSB94ZcGd4wINgNNHC88bXLq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-0xILW2U4MF624T1qpdXitw-1; Tue, 31 Mar 2020 10:07:15 -0400
X-MC-Unique: 0xILW2U4MF624T1qpdXitw-1
Received: by mail-wr1-f71.google.com with SMTP id h14so13004692wrr.12
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mtErzcoM7afpPuWAmYNyKjwkbHkmP1wrlJah8ZVehyM=;
 b=eKNSqMeNe131nIohFcg2qGNz93cIUfKQlNz2rQLyvu1gg4yH8vsFgyOkxKqEW5pcVP
 ZvtotJAN1OmsyFebYxldtnRROSGV5tGcvG3LN+HOhfdLZKF9O5oDVUluv978BLsomKhS
 0QWd43WjDpIjWBHbD+J7ULkcjaeRdUs4iWqUuPVttKsvz78kiOPq8bsPv/I576faC/Dx
 92Jgh4Td4n8o8ule5buofUzEDQNj3bMvL71nRST/au6Eg8L8bfEq3og7aMWgbgIiSnHo
 zPvUDfu3HIkfwHjyL6e3S+QwpFDaWA43OqFpkR1OIXrvDUjJdC1tJQFRi/LrggRStTOR
 I4KA==
X-Gm-Message-State: ANhLgQ37yUvvPv8fPvjKiFrtggifnmV/mF+i6ZHz0TVZKhJlBrlAc292
 YynZSIhFg2MjNZMAzYKFqgQz63srebwHcC3Q/yqKUOFcAeMbSghTa4cZ3Ru0JW/HFazaxPdv1h8
 fAwfKOUfItWi3gx4=
X-Received: by 2002:a1c:c246:: with SMTP id s67mr3712846wmf.160.1585663634563; 
 Tue, 31 Mar 2020 07:07:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvunAjTTWpk3eEB7o8y8hawt8FeOLm0WnVg1qsVj8zmmbE1v+hESAXRtWS1ID2NUECm449Ccw==
X-Received: by 2002:a1c:c246:: with SMTP id s67mr3712744wmf.160.1585663633292; 
 Tue, 31 Mar 2020 07:07:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id w9sm29228802wrk.18.2020.03.31.07.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:07:09 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:07:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200331100359-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 qemu-devel@nongnu.org, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
> On 31.03.20 15:37, Michael S. Tsirkin wrote:
> > On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
> >> On 31.03.20 15:24, Michael S. Tsirkin wrote:
> >>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
> >>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
> >>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
> >>>>>>
> >>>>>>
> >>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com=
>:
> >>>>>>>
> >>>>>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbr=
and wrote:
> >>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wro=
te:
> >>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the fast=
est
> >>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't be ab=
le to make
> >>>>>>>>>> use of THP where it previously was able to. I can imagine this=
 implies a
> >>>>>>>>>> performance degradation for some workloads. This needs a prope=
r
> >>>>>>>>>> performance evaluation.
> >>>>>>>>>
> >>>>>>>>> I think the problem is more with the alloc_pages API.
> >>>>>>>>> That gives you exactly the given order, and if there's
> >>>>>>>>> a larger chunk available, it will split it up.
> >>>>>>>>>
> >>>>>>>>> But for balloon - I suspect lots of other users,
> >>>>>>>>> we do not want to stress the system but if a large
> >>>>>>>>> chunk is available anyway, then we could handle
> >>>>>>>>> that more optimally by getting it all in one go.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>> Along the lines of
> >>>>>>>>>
> >>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_or=
der,
> >>>>>>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>>>>>
> >>>>>>>>> the idea would then be to return at a number of pages in the gi=
ven
> >>>>>>>>> range.
> >>>>>>>>>
> >>>>>>>>> What do you think? Want to try implementing that?
> >>>>>>>>
> >>>>>>>> You can just start with the highest order and decrement the orde=
r until
> >>>>>>>> your allocation succeeds using alloc_pages(), which would be eno=
ugh for
> >>>>>>>> a first version. At least I don't see the immediate need for a n=
ew
> >>>>>>>> kernel API.
> >>>>>>>
> >>>>>>> OK I remember now.  The problem is with reclaim. Unless reclaim i=
s
> >>>>>>> completely disabled, any of these calls can sleep. After it wakes=
 up,
> >>>>>>> we would like to get the larger order that has become available
> >>>>>>> meanwhile.
> >>>>>>>
> >>>>>>
> >>>>>> Yes, but that=E2=80=98s a pure optimization IMHO.
> >>>>>> So I think we should do a trivial implementation first and then se=
e what we gain from a new allocator API. Then we might also be able to just=
ify it using real numbers.
> >>>>>>
> >>>>>
> >>>>> Well how do you propose implement the necessary semantics?
> >>>>> I think we are both agreed that alloc_page_range is more or
> >>>>> less what's necessary anyway - so how would you approximate it
> >>>>> on top of existing APIs?
> >>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/ball=
oon_compaction.h
> >=20
> > .....
> >=20
> >=20
> >>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> >>>> index 26de020aae7b..067810b32813 100644
> >>>> --- a/mm/balloon_compaction.c
> >>>> +++ b/mm/balloon_compaction.c
> >>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloo=
n_dev_info *b_dev_info,
> >>>>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> >>>> =20
> >>>>  /*
> >>>> - * balloon_page_alloc - allocates a new page for insertion into the=
 balloon
> >>>> - *=09=09=09page list.
> >>>> + * balloon_pages_alloc - allocates a new page (of at most the given=
 order)
> >>>> + * =09=09=09 for insertion into the balloon page list.
> >>>>   *
> >>>>   * Driver must call this function to properly allocate a new balloo=
n page.
> >>>>   * Driver must call balloon_page_enqueue before definitively removi=
ng the page
> >>>>   * from the guest system.
> >>>>   *
> >>>> + * Will fall back to smaller orders if allocation fails. The order =
of the
> >>>> + * allocated page is stored in page->private.
> >>>> + *
> >>>>   * Return: struct page for the allocated page or NULL on allocation=
 failure.
> >>>>   */
> >>>> -struct page *balloon_page_alloc(void)
> >>>> +struct page *balloon_pages_alloc(int order)
> >>>>  {
> >>>> -=09struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
> >>>> -=09=09=09=09       __GFP_NOMEMALLOC | __GFP_NORETRY |
> >>>> -=09=09=09=09       __GFP_NOWARN);
> >>>> -=09return page;
> >>>> +=09struct page *page;
> >>>> +
> >>>> +=09while (order >=3D 0) {
> >>>> +=09=09page =3D alloc_pages(balloon_mapping_gfp_mask() |
> >>>> +=09=09=09=09   __GFP_NOMEMALLOC | __GFP_NORETRY |
> >>>> +=09=09=09=09   __GFP_NOWARN, order);
> >>>> +=09=09if (page) {
> >>>> +=09=09=09set_page_private(page, order);
> >>>> +=09=09=09return page;
> >>>> +=09=09}
> >>>> +=09=09order--;
> >>>> +=09}
> >>>> +=09return NULL;
> >>>>  }
> >>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> >>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> >>>> =20
> >>>>  /*
> >>>>   * balloon_page_enqueue - inserts a new page into the balloon page =
list.
> >>>
> >>>
> >>> I think this will try to invoke direct reclaim from the first iterati=
on
> >>> to free up the max order.
> >>
> >> %__GFP_NORETRY: The VM implementation will try only very lightweight
> >> memory direct reclaim to get some memory under memory pressure (thus i=
t
> >> can sleep). It will avoid disruptive actions like OOM killer.
> >>
> >> Certainly good enough for a first version I would say, no?
> >=20
> > Frankly how well that behaves would depend a lot on the workload.
> > Can regress just as well.
> >=20
> > For the 1st version I'd prefer something that is the least disruptive,
> > and that IMHO means we only trigger reclaim at all in the same configur=
ation
> > as now - when we can't satisfy the lowest order allocation.
>=20
> Agreed.
>=20
> >=20
> > Anything else would be a huge amount of testing with all kind of
> > workloads.
> >=20
>=20
> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
> GFP_TRANSHUGE_LIGHT)

That will improve the situation when reclaim is not needed, but leave
the problem in place for when it's needed: if reclaim does trigger, we
can get a huge free page and immediately break it up.

So it's ok as a first step but it will make the second step harder as
we'll need to test with reclaim :).


> --=20
> Thanks,
>=20
> David / dhildenb


