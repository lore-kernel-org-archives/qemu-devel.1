Received: from eggs.gnu.org ([2001:4830:134:3::10]:57327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fE8YO-00044f-8v
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fE8YK-0006gL-4R
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:21:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fE8YJ-0006gF-VG
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:21:20 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-8-peterx@redhat.com>
	<df734575-d387-eec6-fd8a-ad66d31da95d@redhat.com>
	<20180503071041.GC2378@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <af0c6286-0551-9cf7-1546-3ec532518f54@redhat.com>
Date: Thu, 3 May 2018 15:21:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180503071041.GC2378@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/10] util: implement simple interval tree
 logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>



On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 15:10, Peter Xu wrote:
> On Fri, Apr 27, 2018 at 01:53:35PM +0800, Jason Wang wrote:
>
> [...]
>
>>> +int it_tree_remove(ITTree *tree, ITValue start, ITValue end)
>>> +{
>>> +    ITRange range =3D { .start =3D start, .end =3D end }, *overlap, =
and;
>>> +    GTree *gtree;
>>> +
>>> +    g_assert(tree);
>>> +
>>> +    gtree =3D tree->tree;
>>> +    while ((overlap =3D g_tree_lookup(gtree, &range))) {
>>> +        if (it_range_equal(overlap, &range)) {
>>> +            /* Exactly what we want to remove; done */
> [1]
>
>>> +            g_tree_remove(gtree, overlap);
>>> +            break;
>>> +        } else if (it_range_cover(overlap, &range)) {
> [2]
>
>>> +            /* Split existing range into two; done */
>>> +            it_tree_remove_subset(gtree, overlap, &range);
>>> +            break;
>>> +        } else if (it_range_cover(&range, overlap)) {
> [3]
>
>>> +            /* Drop this range and continue */
>>> +            g_tree_remove(gtree, overlap);
>>> +        } else {
> [4]
>
>>> +            /*
>>> +             * The range to remove has intersection with existing
>>> +             * ranges.  Remove part of the range and continue
>>> +             */
>>> +            it_range_and(&and, overlap, &range);
>>> +            g_assert(and.start <=3D and.end);
>>> +            it_tree_remove_subset(gtree, overlap, &and);
>>> +        }
>>> +    }
>>> +
>> Looks like what we need here is just calculate the intersection part t=
he
>> remove it.
> Here after a second thought, I am thining whether it'll be good I use
> a general routine in [4] to replace all [1-4].
>
> The problem is that if we do that we'll depend on the next
> g_tree_lookup() to detect case [1-2] (in that case we'll find nothing
> in the lookup, but still we'll need to walk the tree) to break the
> loop, while IMHO that sometimes can be more expensive than the if
> clauses, especially when the tree is a bit large (each branch needs a
> if clause actually) and also note that in our use case we really have
> lots of cases for [1] and [2].
>
> I think I can merge [3] into [4], but I might consider keeping [1] and
> [2] since I don't really know whether merging them would be better.
> Anyway we can do that as follow up enhancement after the series
> merged.  But I think we'll need some performance benchmarks.
>
> Jason, what do you think?
>
> Regards,
>

Sounds good (but I don't promise I won't have new comments :))

Thanks
