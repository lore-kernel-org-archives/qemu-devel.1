Received: from eggs.gnu.org ([2001:4830:134:3::10]:48045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0Rs2-00083i-2l
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0Rs0-0007IK-BQ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:04:34 -0400
Date: Tue, 18 Apr 2017 13:04:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170418120414.GF2205@work-vm>
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-4-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492104214-29994-4-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, quintela@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org

* Kevin Wolf (kwolf@redhat.com) wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/181     | 117 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/181.out |  38 +++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 156 insertions(+)
>  create mode 100755 tests/qemu-iotests/181
>  create mode 100644 tests/qemu-iotests/181.out
> 
> diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
> new file mode 100755
> index 0000000..563aee7
> --- /dev/null
> +++ b/tests/qemu-iotests/181
> @@ -0,0 +1,117 @@
> +#!/bin/bash
> +#
> +# Test postcopy live migration with shared storage
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
> +owner=kwolf@redhat.com
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1	# failure is the default!
> +
> +MIG_SOCKET="${TEST_DIR}/migrate"
> +
> +_cleanup()
> +{
> +    rm -f "${MIG_SOCKET}"
> +	_cleanup_test_img
> +    _cleanup_qemu
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +. ./common.qemu
> +
> +_supported_fmt generic
> +_supported_proto generic
> +_supported_os Linux
> +
> +size=64M
> +_make_test_img $size
> +
> +echo
> +echo === Starting VMs ===
> +echo
> +
> +qemu_comm_method="monitor"
> +
> +_launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},id=disk
> +src=$QEMU_HANDLE
> +
> +_launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},id=disk \
> +             -incoming "unix:${MIG_SOCKET}"
> +dest=$QEMU_HANDLE
> +
> +echo
> +echo === Write something on the source ===
> +echo
> +
> +silent=
> +_send_qemu_cmd $src 'qemu-io disk "write -P 0x55 0 64k"' "(qemu)"
> +_send_qemu_cmd $src "" "ops/sec"
> +_send_qemu_cmd $src 'qemu-io disk "read -P 0x55 0 64k"' "(qemu)"
> +_send_qemu_cmd $src "" "ops/sec"
> +
> +echo
> +echo === Do postcopy migration to destination ===
> +echo
> +
> +# Slow down migration so much that it definitely won't finish before we can
> +# switch to postcopy
> +silent=yes
> +_send_qemu_cmd $src 'migrate_set_speed 4k' "(qemu)"
> +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"

You should probably also set this on the destination as well;  we
do it in pretty much all the places where we use postcopy, but I think
it'll work without it.

However,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
> +_send_qemu_cmd $src 'migrate_start_postcopy' "(qemu)"
> +
> +QEMU_COMM_TIMEOUT=1 qemu_cmd_repeat=10 silent=yes \
> +    _send_qemu_cmd $src "info migrate" "completed\|failed"
> +silent=yes _send_qemu_cmd $src "" "(qemu)"
> +
> +echo
> +echo === Do some I/O on the destination ===
> +echo
> +
> +# It is important that we use the BlockBackend of the guest device here instead
> +# of the node name, which would create a new BlockBackend and not test whether
> +# the guest has the necessary permissions to access the image now
> +silent=
> +_send_qemu_cmd $dest 'qemu-io disk "read -P 0x55 0 64k"' "(qemu)"
> +_send_qemu_cmd $dest "" "ops/sec"
> +_send_qemu_cmd $dest 'qemu-io disk "write -P 0x66 1M 64k"' "(qemu)"
> +_send_qemu_cmd $dest "" "ops/sec"
> +
> +echo
> +echo === Shut down and check image ===
> +echo
> +
> +_send_qemu_cmd $src 'quit' ""
> +_send_qemu_cmd $dest 'quit' ""
> +wait=1 _cleanup_qemu
> +
> +_check_test_img
> +
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=0
> diff --git a/tests/qemu-iotests/181.out b/tests/qemu-iotests/181.out
> new file mode 100644
> index 0000000..6534ba2
> --- /dev/null
> +++ b/tests/qemu-iotests/181.out
> @@ -0,0 +1,38 @@
> +QA output created by 181
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +
> +=== Starting VMs ===
> +
> +
> +=== Write something on the source ===
> +
> +QEMU X.Y.Z monitor - type 'help' for more information
> +(qemu) qemu-io disk "write -P 0x55 0 64k"
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +(qemu) 
> +(qemu) qemu-io disk "read -P 0x55 0 64k"
> +read 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=== Do postcopy migration to destination ===
> +
> +
> +=== Do some I/O on the destination ===
> +
> +QEMU X.Y.Z monitor - type 'help' for more information
> +(qemu) qemu-io disk "read -P 0x55 0 64k"
> +read 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +(qemu) 
> +(qemu) qemu-io disk "write -P 0x66 1M 64k"
> +wrote 65536/65536 bytes at offset 1048576
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=== Shut down and check image ===
> +
> +(qemu) quit
> +(qemu) 
> +(qemu) quit
> +No errors were found on the image.
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 43142dd..893962d 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -169,3 +169,4 @@
>  174 auto
>  175 auto quick
>  176 rw auto backing
> +181 rw auto migration
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
