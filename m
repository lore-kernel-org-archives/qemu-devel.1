Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42F72071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5/mnofr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42F72071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJH66-0000k7-4s
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJH58-0007zj-GE
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJH56-0004gJ-Qt
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:37:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJH56-0004fv-M6
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585661847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7/lBvfZUgrMsHjskBGxb1fKghdPgh2bnzJ5nqKo5FE=;
 b=I5/mnofrIeoc531hx9FMLMTDSboMTSqccvjM+2M4NsFVOPs3Q7O9+e+ilY7VyYp8KYkykl
 v6SbLNgsERJC+vsHM5yaEuChfu0lN35BaUmQxbujkQscGjyk9JLxDKaTmZByts+O9EkCMa
 A64FxBv2UZC9E0IiZtnFnhYMXc5fLZQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-85t6oCvRNuKWLOpr8-FudA-1; Tue, 31 Mar 2020 09:37:24 -0400
X-MC-Unique: 85t6oCvRNuKWLOpr8-FudA-1
Received: by mail-wr1-f70.google.com with SMTP id u16so10017326wrp.14
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 06:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=14WjY7npFb95dfs4u91xTUnm/drEuiMIwCcYb9+aV0E=;
 b=XNMfczoJ3wjOGkWpE1sColZpdbkZmcuT0nyhlOAukJxzuDxz+UCmR65VsJ/Iw7AOak
 zKvJ3RyeR+vqs1tr0Wm7HVFhvjBSDLCIdgR5n9684MyN2bUCjVyOEz03GyRi1H6HESO+
 T6BwIJGz3uP7yWhh0S6nbKG1dKF+wG1t3qKc9jHxVxxhG4+MQsYj8JjU5KvNRo/MeZos
 r7w5DghrUWobnim/QHSrL2e1m+leu8gis5d2evpdCG6/TpbYh+1wDWyhaXjaMimb/b1G
 iNv38uGSjC6eLBvFGyWv/3zC47xFIuHHABk5gazFCgUH6PSGV8Qg7sJmY3/ZI5J6lT5e
 MAUg==
X-Gm-Message-State: AGi0PubnvNxpCl8rnfj6OOSY+UErwKpzVk4Qqf1IFfdQ7x0zURwgfVJP
 9dBF2NzZBWVrsqfhfFkOixDzjpdC2J992tEsZiOHrMA4dEe43sIOZtn22y67w5mg73emkdbv6I+
 +HOnYzbHw7G+I0LQ=
X-Received: by 2002:a05:600c:294d:: with SMTP id
 n13mr338177wmd.155.1585661843028; 
 Tue, 31 Mar 2020 06:37:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHOVQZvcKj5qnhJ3T+XcRb/jgIhPeq4jvZUSNB0Q2o5aF7+L0uVNJTtAjoRsYEjD9/meV5Hg==
X-Received: by 2002:a05:600c:294d:: with SMTP id
 n13mr338144wmd.155.1585661842712; 
 Tue, 31 Mar 2020 06:37:22 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id n2sm28124947wro.25.2020.03.31.06.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 06:37:22 -0700 (PDT)
Date: Tue, 31 Mar 2020 09:37:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200331093300-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
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

On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
> On 31.03.20 15:24, Michael S. Tsirkin wrote:
> > On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
> >> On 26.03.20 10:49, Michael S. Tsirkin wrote:
> >>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
> >>>>
> >>>>
> >>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
> >>>>>
> >>>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbran=
d wrote:
> >>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote=
:
> >>>>>>>> 2. You are essentially stealing THPs in the guest. So the fastes=
t
> >>>>>>>> mapping (THP in guest and host) is gone. The guest won't be able=
 to make
> >>>>>>>> use of THP where it previously was able to. I can imagine this i=
mplies a
> >>>>>>>> performance degradation for some workloads. This needs a proper
> >>>>>>>> performance evaluation.
> >>>>>>>
> >>>>>>> I think the problem is more with the alloc_pages API.
> >>>>>>> That gives you exactly the given order, and if there's
> >>>>>>> a larger chunk available, it will split it up.
> >>>>>>>
> >>>>>>> But for balloon - I suspect lots of other users,
> >>>>>>> we do not want to stress the system but if a large
> >>>>>>> chunk is available anyway, then we could handle
> >>>>>>> that more optimally by getting it all in one go.
> >>>>>>>
> >>>>>>>
> >>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>> Along the lines of
> >>>>>>>
> >>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_orde=
r,
> >>>>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>>>
> >>>>>>> the idea would then be to return at a number of pages in the give=
n
> >>>>>>> range.
> >>>>>>>
> >>>>>>> What do you think? Want to try implementing that?
> >>>>>>
> >>>>>> You can just start with the highest order and decrement the order =
until
> >>>>>> your allocation succeeds using alloc_pages(), which would be enoug=
h for
> >>>>>> a first version. At least I don't see the immediate need for a new
> >>>>>> kernel API.
> >>>>>
> >>>>> OK I remember now.  The problem is with reclaim. Unless reclaim is
> >>>>> completely disabled, any of these calls can sleep. After it wakes u=
p,
> >>>>> we would like to get the larger order that has become available
> >>>>> meanwhile.
> >>>>>
> >>>>
> >>>> Yes, but that=E2=80=98s a pure optimization IMHO.
> >>>> So I think we should do a trivial implementation first and then see =
what we gain from a new allocator API. Then we might also be able to justif=
y it using real numbers.
> >>>>
> >>>
> >>> Well how do you propose implement the necessary semantics?
> >>> I think we are both agreed that alloc_page_range is more or
> >>> less what's necessary anyway - so how would you approximate it
> >>> on top of existing APIs?
> >> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloo=
n_compaction.h

.....


> >> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> >> index 26de020aae7b..067810b32813 100644
> >> --- a/mm/balloon_compaction.c
> >> +++ b/mm/balloon_compaction.c
> >> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloon_=
dev_info *b_dev_info,
> >>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> >> =20
> >>  /*
> >> - * balloon_page_alloc - allocates a new page for insertion into the b=
alloon
> >> - *=09=09=09page list.
> >> + * balloon_pages_alloc - allocates a new page (of at most the given o=
rder)
> >> + * =09=09=09 for insertion into the balloon page list.
> >>   *
> >>   * Driver must call this function to properly allocate a new balloon =
page.
> >>   * Driver must call balloon_page_enqueue before definitively removing=
 the page
> >>   * from the guest system.
> >>   *
> >> + * Will fall back to smaller orders if allocation fails. The order of=
 the
> >> + * allocated page is stored in page->private.
> >> + *
> >>   * Return: struct page for the allocated page or NULL on allocation f=
ailure.
> >>   */
> >> -struct page *balloon_page_alloc(void)
> >> +struct page *balloon_pages_alloc(int order)
> >>  {
> >> -=09struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
> >> -=09=09=09=09       __GFP_NOMEMALLOC | __GFP_NORETRY |
> >> -=09=09=09=09       __GFP_NOWARN);
> >> -=09return page;
> >> +=09struct page *page;
> >> +
> >> +=09while (order >=3D 0) {
> >> +=09=09page =3D alloc_pages(balloon_mapping_gfp_mask() |
> >> +=09=09=09=09   __GFP_NOMEMALLOC | __GFP_NORETRY |
> >> +=09=09=09=09   __GFP_NOWARN, order);
> >> +=09=09if (page) {
> >> +=09=09=09set_page_private(page, order);
> >> +=09=09=09return page;
> >> +=09=09}
> >> +=09=09order--;
> >> +=09}
> >> +=09return NULL;
> >>  }
> >> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> >> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> >> =20
> >>  /*
> >>   * balloon_page_enqueue - inserts a new page into the balloon page li=
st.
> >=20
> >=20
> > I think this will try to invoke direct reclaim from the first iteration
> > to free up the max order.
>=20
> %__GFP_NORETRY: The VM implementation will try only very lightweight
> memory direct reclaim to get some memory under memory pressure (thus it
> can sleep). It will avoid disruptive actions like OOM killer.
>=20
> Certainly good enough for a first version I would say, no?

Frankly how well that behaves would depend a lot on the workload.
Can regress just as well.

For the 1st version I'd prefer something that is the least disruptive,
and that IMHO means we only trigger reclaim at all in the same configuratio=
n
as now - when we can't satisfy the lowest order allocation.

Anything else would be a huge amount of testing with all kind of
workloads.

--=20
MST


