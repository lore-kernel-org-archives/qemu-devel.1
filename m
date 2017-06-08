Received: from eggs.gnu.org ([2001:4830:134:3::10]:37770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIx8o-0008Nx-HE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIx8i-0006Lx-Cj
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:06:21 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <5be69f00-7630-bdb1-70a8-02a078798f15@redhat.com>
References: <cover.1496844254.git.berto@igalia.com>
	<2ddc2703be89a250994478c92ca7695b4b88791b.1496844254.git.berto@igalia.com>
	<5be69f00-7630-bdb1-70a8-02a078798f15@redhat.com>
Date: Thu, 08 Jun 2017 15:06:10 +0200
Message-ID: <w51efuuochp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/7] qcow2: Use unsigned int for both
 members of Qcow2COWRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed 07 Jun 2017 06:02:06 PM CEST, Eric Blake wrote:

>> - The offset of the COW region from the start of the first cluster
>>   touched by the I/O request. Since it's always going to be positive
>>   and the maximum request size is at most INT_MAX, we can use a
>>   regular unsigned int to store this offset.
>
> I don't know if we will ever get to the point that we allow a 64-bit
> request at the block layer (and then the block layer guarantees it is
> split down to the driver's limits, which works when a driver is still
> bound by 32-bit limits).  But we ALSO know that a cluster is at most
> 2M (in our current implementation of qcow2), so the offset of where
> the COW region starts in relation to the start of a cluster is < 2M.

That's correct for the offset of the first region (m->cow_start),
however m->cow_end is also relative to the offset of the first allocated
cluster, so it can be > 2M if the requests spans several clusters.

So I guess the maximum theoretical offset would be something like
INT_MAX + 2*cluster_size (a bit below that actually).

>> - The size of the COW region in bytes. This is guaranteed to be >= 0,
>>   so we should use an unsigned type instead.
>
> And likewise, since a COW region is a sub-cluster, and clusters are
> bounded at 2M, we also have a sub-int upper bound on the size of the
> region.

That's correct.

Berto
