Received: from eggs.gnu.org ([2001:4830:134:3::10]:56207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce1n9-0005QV-Tb
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce1n9-0006bI-6P
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:46:51 -0500
Date: Wed, 15 Feb 2017 16:46:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215154642.GC4935@noname.redhat.com>
References: <20170214192525.18624-1-eblake@redhat.com>
	<20170214192525.18624-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214192525.18624-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/7] qcow2: Discard/zero clusters by
 byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 14.02.2017 um 20:25 hat Eric Blake geschrieben:
> Passing a byte offset, but sector count, when we ultimately
> want to operate on cluster granularity, is madness.  Clean up
> the external interfaces to take both offset and count as bytes,
> while still keeping the assertion added previously that the
> caller must align the values to a cluster.  Then rename things
> to make sure backports don't get confused by changed units:
> instead of qcow2_discard_clusters() and qcow2_zero_clusters(),
> we now have qcow2_cluster_discard() and qcow2_cluster_zeroize().
> 
> The internal functions still operate on clusters at a time, and
> return an int for number of cleared clusters; but on an image
> with 2M clusters, a single L2 table holds 256k entries that each
> represent a 2M cluster, totalling well over INT_MAX bytes if we
> ever had a request for that many bytes at once.  All our callers
> currently limit themselves to 32-bit bytes (and therefore fewer
> clusters), but by making this function 64-bit clean, we have one
> less place to clean up if we later improve the block layer to
> support 64-bit bytes through all operations (with the block layer
> auto-fragmenting on behalf of more-limited drivers), rather than
> the current state where some interfaces are artificially limited
> to INT_MAX at a time.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
