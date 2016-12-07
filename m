Received: from eggs.gnu.org ([2001:4830:134:3::10]:51231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEeu6-0007uc-5x
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEeu4-0001MF-U8
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:17:10 -0500
Date: Wed, 7 Dec 2016 17:16:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207161659.GG4773@noname.str.redhat.com>
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202192223.15153-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add coverage for recent
 block geometry fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

Am 02.12.2016 um 20:22 hat Eric Blake geschrieben:
> Use blkdebug's new geometry constraints to emulate setups that
> have caused recent regression fixes: write zeroes asserting
> when running through a loopback block device with max-transfer
> smaller than cluster size, and discard rounding away portions
> of requests not aligned to preferred boundaries.  Also, add
> coverage that the block layer is honoring max transfer limits.
> 
> For now, a single iotest performs all actions, with the idea
> that we can add future blkdebug constraint test cases in the
> same file; but it can be split into multiple iotests if we find
> reason to run one portion of the test in more setups than what
> are possible in the other.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v3: make comments tied more to test at hand, rather than the
> particular hardware that led to the earlier patches being tested
> v2: new patch
> ---
>  tests/qemu-iotests/173     | 115 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/173.out |  49 +++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 165 insertions(+)
>  create mode 100755 tests/qemu-iotests/173
>  create mode 100644 tests/qemu-iotests/173.out
> 
> diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
> new file mode 100755
> index 0000000..fd421fc
> --- /dev/null
> +++ b/tests/qemu-iotests/173
> @@ -0,0 +1,115 @@
> +#!/bin/bash
> +#
> +# Test corner cases with unusual block geometries
> +#
> +# Copyright (C) 2016 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +# creator
> +owner=eblake@redhat.com
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1	# failure is the default!
> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto file
> +
> +CLUSTER_SIZE=1M
> +size=128M
> +options=driver=blkdebug,image.driver=qcow2
> +
> +echo
> +echo "== setting up files =="
> +
> +_make_test_img $size
> +$QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG" | _filter_qemu_io
> +mv "$TEST_IMG" "$TEST_IMG.base"

I know that you declared "_supported_proto file", but if you don't use
mv after creating the image, it might actually work with other
protocols.

Most other tests use something like this:

    TEST_IMG="$TEST_IMG.base" _make_test_img $size

And for the qemu-io invocation you can just use the right filename.

> +_make_test_img -b "$TEST_IMG.base"
> +$QEMU_IO -c "write -P 22 0 $size" "$TEST_IMG" | _filter_qemu_io
> +
> +# Limited to 64k max-transfer
> +echo
> +echo "== constrained alignment and max-transfer =="
> +limits=align=4k,max-transfer=64k
> +$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
> +         -c "write -P 33 1000 128k" -c "read -P 33 1000 128k" | _filter_qemu_io
> +
> +echo
> +echo "== write zero with constrained max-transfer =="
> +limits=align=512,max-transfer=64k,opt-write-zero=$CLUSTER_SIZE
> +$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
> +         -c "write -z 8003584 2093056" | _filter_qemu_io
> +
> +# non-power-of-2 write-zero/discard alignments
> +echo
> +echo "== non-power-of-2 write zeroes =="

"non-power-of-2 write zeroes _limits_". The request offset/size is a
power of two.

> +limits=align=512,opt-write-zero=15M,max-write-zero=15M,opt-discard=15M,max-discard=15M
> +$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
> +         -c "write -z 32M 32M" | _filter_qemu_io
> +
> +echo
> +echo "== non-power-of-2 discard =="

Here limits, too.

> +limits=align=512,opt-write-zero=15M,max-write-zero=15M,opt-discard=15M,max-discard=15M
> +$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
> +         -c "discard 80000001 30M" | _filter_qemu_io
> +
> +echo
> +echo "== verify image content =="
> +
> +function verify_io()
> +{
> +    if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" |
> +	    grep "compat: 0.10" > /dev/null); then
> +        # For v2 images, discarded clusters are read from the backing file
> +        discarded=11
> +    else
> +        # Discarded clusters are zeroed for v3 or later
> +        discarded=0
> +    fi
> +
> +    echo read -P 22 0 1000
> +    echo read -P 33 1000 128k
> +    echo read -P 22 132072 7871512
> +    echo read -P 0 8003584 2093056
> +    echo read -P 22 10096640 23457792
> +    echo read -P 0 32M 32M
> +    echo read -P 22 64M 13M
> +    echo read -P $discarded 77M 29M

Hm, why is this exactly 77M?

The original request starts at 80000001, 77M is 80740352. We have a
discard limit of 15M, but that is only used for splitting the request
(and wouldn't match 77M anyway). We still pass the partial requests at
the head and the tail to the driver, and what it enforces is align, i.e.
512. The next 512 byte boundary from 80000001 would be 80000512.

I'm almost sure that the patch is correct and I'm just missing a piece,
but what is it?

> +    echo read -P 22 106M 22M
> +}
> +
> +verify_io | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
> +
> +_check_test_img
> +
> +# success, all done
> +echo "*** done"
> +status=0

Kevin
