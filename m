Received: from eggs.gnu.org ([2001:4830:134:3::10]:55291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6IZO-0008Vl-TZ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6IZO-0006dd-0b
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:21:30 -0400
Date: Thu, 4 May 2017 17:21:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170504152121.GC5238@noname.redhat.com>
References: <20170503231120.23507-1-mreitz@redhat.com>
	<20170503231120.23507-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503231120.23507-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Extend test 066
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Am 04.05.2017 um 01:11 hat Max Reitz geschrieben:
> 066 was supposed to be a test "for discarding preallocated zero
> clusters", but it did so incompletely: While it did check the image
> file's integrity after the operation, it did not confirm that the
> clusters are indeed freed. This patch adds this test.
> 
> In addition, new cases for writing to preallocated zero clusters are
> added.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> +echo
> +echo '=== Writing to a snapshotted preallocated zero cluster ==='
> +echo
> +
> +_make_test_img 64k
> +
> +# Create a preallocated zero cluster
> +$QEMU_IO -c 'write -P 42 0 64k' -c 'write -z 0 64k' "$TEST_IMG" \
> +    | _filter_qemu_io
> +
> +# Snapshot it
> +$QEMU_IMG snapshot -c foo "$TEST_IMG"
> +
> +# Write to the cluster
> +$QEMU_IO -c 'write -P 23 0 64k' "$TEST_IMG" | _filter_qemu_io
> +
> +# Check metadata correctness
> +_check_test_img
> +
> +# Check data correctness
> +$QEMU_IO -c 'read -P 23 0 64k' "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IMG snapshot -a foo "$TEST_IMG"
> +$QEMU_IO -c 'read -P 0 0 64k' "$TEST_IMG" | _filter_qemu_io

This doesn't actually test that we allocated a new cluster, just that
the zero flag from the snapshot L2 table still takes effect. If we
wanted to test this, we could either add some more snapshotting and
writes in order to cause a second COW of the zero cluster, or at least
do a 'qemu-img map'.

Of course, all of this is perfectly fine as a follow-up.

Kevin
