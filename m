Received: from eggs.gnu.org ([2001:4830:134:3::10]:59466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cGmc9-0008Nh-C2
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cGmc5-0001pN-Dn
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:55:25 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <756cfb05-61e1-7ee3-435b-93759438a52d@redhat.com>
References: <cover.1481290956.git.berto@igalia.com>
	<468dbeb8-5b1b-669f-f7e5-0d24a4308da8@redhat.com>
	<w51bmwhck1c.fsf@maestria.local.igalia.com>
	<756cfb05-61e1-7ee3-435b-93759438a52d@redhat.com>
Date: Tue, 13 Dec 2016 13:55:18 +0100
Message-ID: <w51k2b4htu1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 0/1] Allow storing the qcow2 L2 cache
 in disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Tue 13 Dec 2016 09:02:34 AM CET, Max Reitz wrote:

> I definitely like how simple your approach is, but from a design
> standpoint it is not exactly optimal, because O(n) for a cluster
> lookup is simply worse than O(1).

It's actually not O(n) anymore since I rewrote that code last year.

When I changed the algorithm to use LRU for cache eviction I also
optimized the lookup:

 1) qcow2_cache_put() simply divides the table offset by the cluster
    size and it immediately obtains the index.

 2) qcow2_cache_get() hashes the offset to do the lookup. In my tests
    doing random I/O and a 2048 entry cache the average number of
    comparisons was 2.5 (430 before the rewrite).

The cache was ~13% faster after the rewrite, but the results in terms of
actual disk I/O improvements were negligible, because that's not where
the bottleneck is. We even discussed how the hash function that I was
using was weak, but we decided not to touch it because it was not worth
the effort.

>> But leaving that aside, would that improve anything? I don't think
>> the cache itself adds any significant overhead here, IIRC even in
>> your presentation at KVM Forum 2015 qcow2 was comparable to raw as
>> long as all L2 tables were cached in memory.
>
> I haven't compared CPU usage, though. That may have gone up quite a
> bit, I don't know. For large enough images, it may even become a
> bottleneck.

I don't know, I don't have any data to suggest that there's a problem
there, particularly after the rewrite from last year I think the cache
is reasonably fast (as long as the cache is big enough; and if it's not
big enough the problem is going to be in the extra I/O).

Berto
