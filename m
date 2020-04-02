Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A5C2D0F4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F52C20757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FusEvIbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F52C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJz6t-0002YE-Hs
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJz64-00027o-EZ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJz62-0004yt-SV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:37:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJz62-0004yW-Nx
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585831041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwEfL7hjUmH+D1QfQMX/lWWgneZeqzM5uKhlnZP9EKQ=;
 b=FusEvIbo21n8LadyLHwpkTGxqoVxIqGObxp923nOrinhlusmD9vsbbOgeUn/oDumWJFs5p
 fDtFDJJ/D1koLXmHpiw9AIL+3kWyiXpSz1SsMRRjIqFljABGcL6iGs2KBuDp97FI+i9tHM
 k7PlxhofzNHdYjSXymaU/gchKCOqgu4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-VWbGefUrOmmcufvVrRO0ew-1; Thu, 02 Apr 2020 08:37:20 -0400
X-MC-Unique: VWbGefUrOmmcufvVrRO0ew-1
Received: by mail-qt1-f197.google.com with SMTP id d18so2964083qtq.16
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 05:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=z83ZFN7U6iOT0EPOREo66Rtq033CFmiu/su55XugOps=;
 b=OHThvDZhwbGlA8i/TsOnHvC9mJc4GVUrDdK5re1zwP0i6UXKGAoU6Z7xkaUKuG/VpO
 prvr2MXYQvAIpGYpHnTFUw9AaZ7DrsFv6C3eupJI14mF7MEeoG/SOMpHE3rgIFYkmM43
 CDZWN1Yw0UAwYcZ4lvRj1XOFVuP05F6dGcc2ZzVaUXFZdrdHMnYf/xXb5NM5aAMliC5X
 0yFFgR53pT9w6NLwLJfvs4l+jlgLE6N12qkbsezVCYK43uxbsYfgE14G+WSdl4R11Jq5
 ZFLsvaHc+nqIbNLfeFU2ZIMOj4XZMPqfhn6AyylK516nM50jCL6b0MbYy6fPr1cv9w1c
 Er0Q==
X-Gm-Message-State: AGi0PuZk4fvIgiiI2VbG4J7yYyO1UMjfbQp4rHSH7T38w5gDO88NvPmY
 jIoA7kgBvvBep+vUxRvU0K0BA9mYNZmzFMsKTvQtpeUiglhY7thl+oLpSwqGsq0uO+tcgj7ZzLR
 /SS1b+C3NiITxWP4=
X-Received: by 2002:a37:a7cd:: with SMTP id q196mr2960683qke.447.1585831039544; 
 Thu, 02 Apr 2020 05:37:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ0I00cVKswz3vNdf6Dr0WhRrTlZgEbT2Br3s+aMGt4SrYp5fv90+mvLN93pvzAK4++FO8L4w==
X-Received: by 2002:a37:a7cd:: with SMTP id q196mr2960665qke.447.1585831039221; 
 Thu, 02 Apr 2020 05:37:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id 68sm3343978qkh.75.2020.04.02.05.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 05:37:17 -0700 (PDT)
Date: Thu, 2 Apr 2020 08:37:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: teawater <teawaterz@linux.alibaba.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200402083630-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <02745FD3-E30D-453B-8664-94B8EBF3B313@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <02745FD3-E30D-453B-8664-94B8EBF3B313@linux.alibaba.com>
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
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Andrew Morton <akpm@linux-foundation.org>, Jason Wang <jasowang@redhat.com>,
 Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 04:00:05PM +0800, teawater wrote:
>=20
>=20
> > 2020=E5=B9=B43=E6=9C=8831=E6=97=A5 22:07=EF=BC=8CMichael S. Tsirkin <ms=
t@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
> >> On 31.03.20 15:37, Michael S. Tsirkin wrote:
> >>> On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
> >>>> On 31.03.20 15:24, Michael S. Tsirkin wrote:
> >>>>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
> >>>>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
> >>>>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote=
:
> >>>>>>>>=20
> >>>>>>>>=20
> >>>>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.c=
om>:
> >>>>>>>>>=20
> >>>>>>>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hilden=
brand wrote:
> >>>>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>>>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand w=
rote:
> >>>>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the fa=
stest
> >>>>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't be =
able to make
> >>>>>>>>>>>> use of THP where it previously was able to. I can imagine th=
is implies a
> >>>>>>>>>>>> performance degradation for some workloads. This needs a pro=
per
> >>>>>>>>>>>> performance evaluation.
> >>>>>>>>>>>=20
> >>>>>>>>>>> I think the problem is more with the alloc_pages API.
> >>>>>>>>>>> That gives you exactly the given order, and if there's
> >>>>>>>>>>> a larger chunk available, it will split it up.
> >>>>>>>>>>>=20
> >>>>>>>>>>> But for balloon - I suspect lots of other users,
> >>>>>>>>>>> we do not want to stress the system but if a large
> >>>>>>>>>>> chunk is available anyway, then we could handle
> >>>>>>>>>>> that more optimally by getting it all in one go.
> >>>>>>>>>>>=20
> >>>>>>>>>>>=20
> >>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>>>> Along the lines of
> >>>>>>>>>>>=20
> >>>>>>>>>>> struct page *alloc_page_range(gfp_t gfp, unsigned int min_ord=
er,
> >>>>>>>>>>>                 unsigned int max_order, unsigned int *order)
> >>>>>>>>>>>=20
> >>>>>>>>>>> the idea would then be to return at a number of pages in the =
given
> >>>>>>>>>>> range.
> >>>>>>>>>>>=20
> >>>>>>>>>>> What do you think? Want to try implementing that?
> >>>>>>>>>>=20
> >>>>>>>>>> You can just start with the highest order and decrement the or=
der until
> >>>>>>>>>> your allocation succeeds using alloc_pages(), which would be e=
nough for
> >>>>>>>>>> a first version. At least I don't see the immediate need for a=
 new
> >>>>>>>>>> kernel API.
> >>>>>>>>>=20
> >>>>>>>>> OK I remember now.  The problem is with reclaim. Unless reclaim=
 is
> >>>>>>>>> completely disabled, any of these calls can sleep. After it wak=
es up,
> >>>>>>>>> we would like to get the larger order that has become available
> >>>>>>>>> meanwhile.
> >>>>>>>>>=20
> >>>>>>>>=20
> >>>>>>>> Yes, but that=E2=80=98s a pure optimization IMHO.
> >>>>>>>> So I think we should do a trivial implementation first and then =
see what we gain from a new allocator API. Then we might also be able to ju=
stify it using real numbers.
> >>>>>>>>=20
> >>>>>>>=20
> >>>>>>> Well how do you propose implement the necessary semantics?
> >>>>>>> I think we are both agreed that alloc_page_range is more or
> >>>>>>> less what's necessary anyway - so how would you approximate it
> >>>>>>> on top of existing APIs?
> >>>>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/ba=
lloon_compaction.h
> >>>=20
> >>> .....
> >>>=20
> >>>=20
> >>>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> >>>>>> index 26de020aae7b..067810b32813 100644
> >>>>>> --- a/mm/balloon_compaction.c
> >>>>>> +++ b/mm/balloon_compaction.c
> >>>>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct ball=
oon_dev_info *b_dev_info,
> >>>>>> EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> >>>>>>=20
> >>>>>> /*
> >>>>>> - * balloon_page_alloc - allocates a new page for insertion into t=
he balloon
> >>>>>> - *=09=09=09page list.
> >>>>>> + * balloon_pages_alloc - allocates a new page (of at most the giv=
en order)
> >>>>>> + * =09=09=09 for insertion into the balloon page list.
> >>>>>> *
> >>>>>> * Driver must call this function to properly allocate a new balloo=
n page.
> >>>>>> * Driver must call balloon_page_enqueue before definitively removi=
ng the page
> >>>>>> * from the guest system.
> >>>>>> *
> >>>>>> + * Will fall back to smaller orders if allocation fails. The orde=
r of the
> >>>>>> + * allocated page is stored in page->private.
> >>>>>> + *
> >>>>>> * Return: struct page for the allocated page or NULL on allocation=
 failure.
> >>>>>> */
> >>>>>> -struct page *balloon_page_alloc(void)
> >>>>>> +struct page *balloon_pages_alloc(int order)
> >>>>>> {
> >>>>>> -=09struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
> >>>>>> -=09=09=09=09       __GFP_NOMEMALLOC | __GFP_NORETRY |
> >>>>>> -=09=09=09=09       __GFP_NOWARN);
> >>>>>> -=09return page;
> >>>>>> +=09struct page *page;
> >>>>>> +
> >>>>>> +=09while (order >=3D 0) {
> >>>>>> +=09=09page =3D alloc_pages(balloon_mapping_gfp_mask() |
> >>>>>> +=09=09=09=09   __GFP_NOMEMALLOC | __GFP_NORETRY |
> >>>>>> +=09=09=09=09   __GFP_NOWARN, order);
> >>>>>> +=09=09if (page) {
> >>>>>> +=09=09=09set_page_private(page, order);
> >>>>>> +=09=09=09return page;
> >>>>>> +=09=09}
> >>>>>> +=09=09order--;
> >>>>>> +=09}
> >>>>>> +=09return NULL;
> >>>>>> }
> >>>>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> >>>>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> >>>>>>=20
> >>>>>> /*
> >>>>>> * balloon_page_enqueue - inserts a new page into the balloon page =
list.
> >>>>>=20
> >>>>>=20
> >>>>> I think this will try to invoke direct reclaim from the first itera=
tion
> >>>>> to free up the max order.
> >>>>=20
> >>>> %__GFP_NORETRY: The VM implementation will try only very lightweight
> >>>> memory direct reclaim to get some memory under memory pressure (thus=
 it
> >>>> can sleep). It will avoid disruptive actions like OOM killer.
> >>>>=20
> >>>> Certainly good enough for a first version I would say, no?
> >>>=20
> >>> Frankly how well that behaves would depend a lot on the workload.
> >>> Can regress just as well.
> >>>=20
> >>> For the 1st version I'd prefer something that is the least disruptive=
,
> >>> and that IMHO means we only trigger reclaim at all in the same config=
uration
> >>> as now - when we can't satisfy the lowest order allocation.
> >>=20
> >> Agreed.
> >>=20
> >>>=20
> >>> Anything else would be a huge amount of testing with all kind of
> >>> workloads.
> >>>=20
> >>=20
> >> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
> >> GFP_TRANSHUGE_LIGHT)
> >=20
> > That will improve the situation when reclaim is not needed, but leave
> > the problem in place for when it's needed: if reclaim does trigger, we
> > can get a huge free page and immediately break it up.
> >=20
> > So it's ok as a first step but it will make the second step harder as
> > we'll need to test with reclaim :).
>=20
>=20
> I worry that will increases the allocation failure rate for large pages.
>=20
> I tried alloc 2M memory without __GFP_RECLAIM when I wrote the VIRTIO_BAL=
LOON_F_THP_ORDER first version.
> It will fail when I use usemem punch-holes function generates 400m fragme=
ntation pages in the guest kernel.
>=20
> What about add another option to balloon to control with __GFP_RECLAIM or=
 without it?
>=20
> Best,
> Hui

That is why I suggested a new API so we do not fragment memory.

> >=20
> >=20
> >> --=20
> >> Thanks,
> >>=20
> >> David / dhildenb


