Received: from eggs.gnu.org ([2001:4830:134:3::10]:51588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnQCK-00062V-1K
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnQCG-0002oy-3c
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:28 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <350a86fa-5341-ddc2-e2c4-f75648830248@janustech.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-3-lbloch@janustech.com>
	<w51d0utt4kk.fsf@maestria.local.igalia.com>
	<f1197908-f00f-1c2b-b63c-3339e39488c5@janustech.com>
	<w517el1t0yd.fsf@maestria.local.igalia.com>
	<350a86fa-5341-ddc2-e2c4-f75648830248@janustech.com>
Date: Wed, 08 Aug 2018 17:16:19 +0200
Message-ID: <w511sb8ubwc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qcow2: Make the default L2 cache
 sufficient to cover the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 08 Aug 2018 04:35:19 PM CEST, Leonid Bloch wrote:
>>>> The way I see it: there are two simple changes from the user's point of
>>>> view (they can even be two separate patches).
>>>>
>>>> 1) The default l2-cache-size is now 32MB. DEFAULT_L2_CACHE_CLUSTERS is
>>>>      useless now and disappears.
>>> I don't think that it can be a separate patch, because unless the other
>>> logic is changed, the cache will occupy 32 MB *always*, regardless of
>>> the image size, and that's quite a big and unneeded overhead.
>> 
>> Change the order of both patches then :-)
>
> Do you really think it's necessary? The increase of the default max
> size is directly tied to the functionality change: it will be harmful
> to increase the maximum before the new functionality is implemented,
> and there is no need to change the functionality if the default max is
> not increased.

I think that we're looking at this from two different perspectives.

a) If I understand you correctly, you see this as a way to make the user
   forget about the L2 cache: we guarantee that it's going to be big
   enough for the entire image, so simply forget about it. Exception: if
   you're using very large images you will have to set its size
   manually, but for the vast majority of cases you'll be alright with
   the default (32MB).

b) The way I see it: setting the right L2 cache size is not trivial, it
   depends on the image and cluster sizes, and it involves a trade-off
   between how much memory you want to use and how much performance
   you're willing to sacrifice. QEMU has many use cases and there's no
   good default, you need to make the numbers yourself if you want to
   fine-tune it. Don't blindly trust the new default size (32MB) because
   it won't be enough for many cases. But we can promise you this: make
   l2-cache-size the maximum amount of memory you're willing to spend on
   this disk image's cache, and we guarantee that we'll only use the
   amount that we need to give you the best performance.

I hope (a) was a fair description of what you're trying to achieve with
these patches. But I also hope that you can see why making l2_cache_size
= MIN(l2_cache_size, virtual_disk_size / (s->cluster_size / 8)) is a
worthwhile change on its own, even if we didn't increase the default
cache size to 32MB.

Berto
