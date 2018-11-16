Received: from eggs.gnu.org ([2001:4830:134:3::10]:55264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNgTS-0004FU-55
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNgTQ-0001j7-2b
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:56:01 -0500
Date: Fri, 16 Nov 2018 16:55:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181116155520.GE5066@localhost.localdomain>
References: <20181115183408.1240762-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115183408.1240762-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 3.1 v9] qcow2: Document some maximum
 size constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berto@igalia.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 15.11.2018 um 19:34 hat Eric Blake geschrieben:
> Although off_t permits up to 63 bits (8EB) of file offsets, in
> practice, we're going to hit other limits first.  Document some
> of those limits in the qcow2 spec (some are inherent, others are
> implementation choices of qemu), and how choice of cluster size
> can influence some of the limits.
> 
> While we cannot map any uncompressed virtual cluster to any
> address higher than 64 PB (56 bits) (due to the current L1/L2
> field encoding stopping at bit 55), qemu's cap of 8M for the
> refcount table can still access larger host addresses for some
> combinations of large clusters and small refcount_order.  For
> comparison, ext4 with 4k blocks caps files at 16PB.
> 
> Another interesting limit: for compressed clusters, the L2 layout
> requires an ever-smaller maximum host offset as cluster size gets
> larger, down to a 512 TB maximum with 2M clusters.  In particular,
> note that with a cluster size of 8k or smaller, the L2 entry for
> a compressed cluster could technically point beyond the 64PB mark,
> but when you consider that with 8k clusters and refcount_order = 0,
> you cannot access beyond 512T without exceeding qemu's limit of an
> 8M cap on the refcount table, it is unlikely that any image in the
> wild has attempted to do so.  To be safe, let's document that bits
> beyond 55 in a compressed cluster must be 0.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v9: Yet more wording tweaks, to call out the difference between
> inherent (L2 reserved bit) and implementation (qemu's 32M L1 and
> 8M refcount) limits.
> 
> Designed to replace commit 1da4dc02 on Kevin's block branch.

Thanks, replaced the commit.

Kevin
