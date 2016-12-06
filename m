Received: from eggs.gnu.org ([2001:4830:134:3::10]:50027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEGvo-0005RN-HW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEGvn-00067a-Lh
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:41:20 -0500
Date: Tue, 6 Dec 2016 15:41:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161206144110.GE4990@noname.str.redhat.com>
References: <20161205154934.24999-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161205154934.24999-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8 v2] qcow2: Don't strand clusters
 near 2G intervals during commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

Am 05.12.2016 um 16:49 hat Eric Blake geschrieben:
> The qcow2_make_empty() function is reached during 'qemu-img commit',
> in order to clear out ALL clusters of an image.  However, if the
> image cannot use the fast code path (true if the image is format
> 0.10, or if the image contains a snapshot), the cluster size is
> larger than 512, and the image is larger than 2G in size, then our
> choice of sector_step causes problems.  Since it is not cluster
> aligned, but qcow2_discard_clusters() silently ignores an unaligned
> head or tail, we are leaving clusters allocated.
> 
> Enhance the testsuite to expose the flaw, and patch the problem by
> ensuring our step size is aligned.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
