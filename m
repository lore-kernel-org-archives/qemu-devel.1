Received: from eggs.gnu.org ([2001:4830:134:3::10]:52014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dFjSG-0005TF-5H
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dFjSE-0003bp-8F
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:53:08 -0400
Date: Tue, 30 May 2017 11:52:57 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170530155257.GD2665@localhost.localdomain>
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
	<1496157773-10779-5-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496157773-10779-5-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/4] qemu-iotests: Block
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, May 30, 2017 at 05:22:53PM +0200, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/183     | 143 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/183.out |  46 +++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 190 insertions(+)
>  create mode 100755 tests/qemu-iotests/183
>  create mode 100644 tests/qemu-iotests/183.out
> 
> diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
> new file mode 100755
> index 0000000..5eda0e9
> --- /dev/null
> +++ b/tests/qemu-iotests/183
> @@ -0,0 +1,143 @@
> +#!/bin/bash
> +#
> +# Test old-style block migration (migrate -b)
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
> +    rm -f "${TEST_IMG}.dest"
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

Not sure to what extent we are really keeping the _supported_fmt up to date,
but this test will only work on qcow2 and raw, right?

I'd recommend changing this to:

+ _supported_fmt qcow2 raw

(that can probably be done when applying, however).


> +_supported_proto file
> +_supported_os Linux
> +
> +size=64M
> +_make_test_img $size
> +TEST_IMG="${TEST_IMG}.dest" _make_test_img $size
> +
> +echo
> +echo === Starting VMs ===
> +echo
> +
> +qemu_comm_method="qmp"
> +
> +_launch_qemu \
> +    -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk
> +src=$QEMU_HANDLE
> +_send_qemu_cmd $src "{ 'execute': 'qmp_capabilities' }" 'return'
> +
> +_launch_qemu \
> +    -drive file="${TEST_IMG}.dest",cache=${CACHEMODE},driver=$IMGFMT,id=disk \
> +    -incoming "unix:${MIG_SOCKET}"
> +dest=$QEMU_HANDLE
> +_send_qemu_cmd $dest "{ 'execute': 'qmp_capabilities' }" 'return'
> +
> +echo
> +echo === Write something on the source ===
> +echo
> +
> +_send_qemu_cmd $src \
> +    "{ 'execute': 'human-monitor-command',
> +       'arguments': { 'command-line':
> +                      'qemu-io disk \"write -P 0x55 0 64k\"' } }" \
> +    'return'
> +_send_qemu_cmd $src \
> +    "{ 'execute': 'human-monitor-command',
> +       'arguments': { 'command-line':
> +                      'qemu-io disk \"read -P 0x55 0 64k\"' } }" \
> +    'return'
> +
> +echo
> +echo === Do block migration to destination ===
> +echo
> +
> +reply="$(_send_qemu_cmd $src \
> +    "{ 'execute': 'migrate',
> +       'arguments': { 'uri': 'unix:${MIG_SOCKET}', 'blk': true } }" \
> +    'return\|error')"
> +echo "$reply"
> +if echo "$reply" | grep "compiled without old-style" > /dev/null; then
> +    _notrun "migrate -b support not compiled in"
> +fi
> +
> +while _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" "return"  |
> +      grep '"status": "active"' > /dev/null
> +do
> +    sleep 0.1

Would it make sense here to add a timeout?  It would be nice to be able to
reply on scripts always failing for git-bisect (rather than potentially
hanging at a spot).

> +done

Modulo the updated _supported_fmt line:

Reviewed-by: Jeff Cody <jcody@redhat.com>


> +_send_qemu_cmd $src "{ 'execute': 'query-status' }" "return"
> +
> +echo
> +echo === Do some I/O on the destination ===
> +echo
> +
> +# It is important that we use the BlockBackend of the guest device here instead
> +# of the node name, which would create a new BlockBackend and not test whether
> +# the guest has the necessary permissions to access the image now
> +silent=yes _send_qemu_cmd $dest "" "100 %"
> +_send_qemu_cmd $dest "{ 'execute': 'query-status' }" "return"
> +_send_qemu_cmd $dest \
> +    "{ 'execute': 'human-monitor-command',
> +       'arguments': { 'command-line':
> +                      'qemu-io disk \"read -P 0x55 0 64k\"' } }" \
> +    'return'
> +_send_qemu_cmd $dest \
> +    "{ 'execute': 'human-monitor-command',
> +       'arguments': { 'command-line':
> +                      'qemu-io disk \"write -P 0x66 1M 64k\"' } }" \
> +    'return'
> +
> +echo
> +echo === Shut down and check image ===
> +echo
> +
> +_send_qemu_cmd $src '{"execute":"quit"}' 'return'
> +_send_qemu_cmd $dest '{"execute":"quit"}' 'return'
> +wait=1 _cleanup_qemu
> +
> +_check_test_img
> +TEST_IMG="${TEST_IMG}.dest" _check_test_img
> +
> +$QEMU_IO -c 'write -P 0x66 1M 64k' "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IMG compare "$TEST_IMG.dest" "$TEST_IMG"
> +
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=0
> diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
> new file mode 100644
> index 0000000..6647488
> --- /dev/null
> +++ b/tests/qemu-iotests/183.out
> @@ -0,0 +1,46 @@
> +QA output created by 183
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +Formatting 'TEST_DIR/t.IMGFMT.dest', fmt=IMGFMT size=67108864
> +
> +=== Starting VMs ===
> +
> +{"return": {}}
> +{"return": {}}
> +
> +=== Write something on the source ===
> +
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +{"return": ""}
> +read 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +{"return": ""}
> +
> +=== Do block migration to destination ===
> +
> +{"return": {}}
> +{"return": {"status": "postmigrate", "singlestep": false, "running": false}}
> +
> +=== Do some I/O on the destination ===
> +
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
> +{"return": {"status": "running", "singlestep": false, "running": true}}
> +read 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +{"return": ""}
> +wrote 65536/65536 bytes at offset 1048576
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +{"return": ""}
> +
> +=== Shut down and check image ===
> +
> +{"return": {}}
> +{"return": {}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
> +No errors were found on the image.
> +No errors were found on the image.
> +wrote 65536/65536 bytes at offset 1048576
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Images are identical.
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 5c8ea0f..a6acaff 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -174,3 +174,4 @@
>  179 rw auto quick
>  181 rw auto migration
>  182 rw auto quick
> +183 rw auto migration
> -- 
> 1.8.3.1
> 
> 
