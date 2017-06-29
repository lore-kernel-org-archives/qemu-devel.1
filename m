Received: from eggs.gnu.org ([2001:4830:134:3::10]:41215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQWOz-0007NP-Hc
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQWOv-0005MF-CN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:10:21 -0400
Date: Thu, 29 Jun 2017 12:10:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170629101008.GB4618@noname.redhat.com>
References: <20170628232315.22777-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628232315.22777-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Add test for dataplane mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 29.06.2017 um 01:23 hat Max Reitz geschrieben:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Depends on Stefan's "virtio: use ioeventfd in TCG and qtest mode" series
> to work at all, and on "mirror: Fix inconsistent backing AioContext for
> after mirroring" (in my block branch) so it does not fail.
> ---
>  tests/qemu-iotests/106     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/106.out | 14 +++++++

Your initiative to fill up the numbering hole is laudable, but are you
intentionally using 106 for multiple patches of yours? ;-)

>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 112 insertions(+)
>  create mode 100755 tests/qemu-iotests/106
>  create mode 100644 tests/qemu-iotests/106.out
> 
> diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
> new file mode 100755
> index 0000000..ad438b5
> --- /dev/null
> +++ b/tests/qemu-iotests/106
> @@ -0,0 +1,97 @@
> +#!/bin/bash
> +#
> +# Test case for mirroring with dataplane
> +#
> +# Copyright (C) 2017 Red Hat, Inc.
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
> +owner=mreitz@redhat.com
> +
> +seq=$(basename $0)
> +echo "QA output created by $seq"
> +
> +here=$PWD
> +status=1    # failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_qemu
> +    _cleanup_test_img
> +    _rm_test_img "$TEST_IMG.overlay0"
> +    _rm_test_img "$TEST_IMG.overlay1"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and qemu instance handling
> +. ./common.rc
> +. ./common.filter
> +. ./common.qemu
> +
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux
> +
> +IMG_SIZE=64K
> +
> +_make_test_img $IMG_SIZE
> +TEST_IMG="$TEST_IMG.overlay0" _make_test_img -b "$TEST_IMG" $IMG_SIZE
> +TEST_IMG="$TEST_IMG.overlay1" _make_test_img -b "$TEST_IMG" $IMG_SIZE
> +
> +# So that we actually have something to mirror and the job does not return
> +# immediately (which may be bad because then we cannot know whether the
> +# 'return' or the 'BLOCK_JOB_READY' comes first).
> +$QEMU_IO -c 'write 0 64' "$TEST_IMG.overlay0" | _filter_qemu_io

64 bytes? Unusual, but yes, why not. We probably don't test this too
often. :-)

> +# We cannot use virtio-blk here because that does not actually set the attached
> +# BB's AioContext in qtest mode

Why that? I don't see any qtest special casing in the virtio-blk code,
so is this intentional?

> +_launch_qemu \
> +    -object iothread,id=iothr \
> +    -blockdev node-name=source,driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG.overlay0" \
> +    -device virtio-scsi,id=scsi-bus,iothread=iothr \
> +    -device scsi-hd,bus=scsi-bus.0,drive=source
> +
> +_send_qemu_cmd $QEMU_HANDLE \
> +    "{ 'execute': 'qmp_capabilities' }" \
> +    'return'
> +
> +_send_qemu_cmd $QEMU_HANDLE \
> +    "{ 'execute': 'drive-mirror',
> +       'arguments': {
> +           'job-id': 'mirror',
> +           'device': 'source',
> +           'target': '$TEST_IMG.overlay1',
> +           'mode':   'existing',
> +           'sync':   'top'
> +       } }" \
> +    'BLOCK_JOB_READY'
> +
> +# The backing BDS should be assigned the overlay's AioContext
> +_send_qemu_cmd $QEMU_HANDLE \
> +    "{ 'execute': 'block-job-complete',
> +       'arguments': { 'device': 'mirror' } }" \
> +    'BLOCK_JOB_COMPLETED'
> +
> +_send_qemu_cmd $QEMU_HANDLE \
> +    "{ 'execute': 'quit' }" \
> +    'return'
> +
> +wait=yes _cleanup_qemu
> +
> +# success, all done
> +echo '*** done'
> +rm -f $seq.full
> +status=0

The actual test looks good to me.

Kevin
