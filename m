Received: from eggs.gnu.org ([2001:4830:134:3::10]:40328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa6Ls-0000Sl-3h
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa6Lq-00070y-2e
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:27:16 -0400
References: <20180702191458.28741-1-eblake@redhat.com>
	<20180702191458.28741-3-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2f27c085-5942-c562-375e-2ed557968ff0@redhat.com>
Date: Mon, 2 Jul 2018 17:27:07 -0400
MIME-Version: 1.0
In-Reply-To: <20180702191458.28741-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: New test 223 for exporting
 dirty bitmap over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/02/2018 03:14 PM, Eric Blake wrote:
> Although this test is NOT a full test of image fleecing (as it
> intentionally uses just a single block device directly exported
> over NBD, rather than trying to set up a blockdev-backup job with
> multiple BDS involved), it DOES prove that qemu as a server is
> able to properly expose a dirty bitmap over NBD.
> 
> When coupled with image fleecing, it is then possible for a
> third-party client to do an incremental backup by using
> qemu-img map with the x-dirty-bitmap option to learn which parts
> of the file are dirty (perhaps confusingly, they are the portions
> mapped as "data":false - which is part of the reason this is
> still in the x- experimental namespace), along with another
> normal client (perhaps 'qemu-nbd -c' to expose the server over
> /dev/nbd0 and then just use normal I/O on that block device) to
> read the dirty sections.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/223     | 138 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/223.out |  49 ++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 188 insertions(+)
>  create mode 100755 tests/qemu-iotests/223
>  create mode 100644 tests/qemu-iotests/223.out
> 
> diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
> new file mode 100755
> index 00000000000..b63b7a4f9e1
> --- /dev/null
> +++ b/tests/qemu-iotests/223
> @@ -0,0 +1,138 @@
> +#!/bin/bash
> +#
> +# Test reading dirty bitmap over NBD
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
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
> +seq="$(basename $0)"
> +echo "QA output created by $seq"
> +
> +here="$PWD"
> +status=1 # failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_test_img
> +    _cleanup_qemu
> +    rm -f "$TEST_DIR/nbd"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +. ./common.qemu
> +
> +_supported_fmt qcow2
> +_supported_proto file # uses NBD as well
> +_supported_os Linux
> +
> +function do_run_qemu()
> +{
> +    echo Testing: "$@"
> +    $QEMU -nographic -qmp stdio -serial none "$@"
> +    echo
> +}
> +
> +function run_qemu()
> +{
> +    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
> +                          | _filter_qemu | _filter_imgfmt \
> +                          | _filter_actual_image_size
> +}
> +
> +echo
> +echo "=== Create partially sparse image, then add dirty bitmap ==="
> +echo
> +
> +_make_test_img 4M
> +$QEMU_IO -c 'w -P 0x11 1M 2M' "$TEST_IMG" | _filter_qemu_io

- Write 0x11 from [1M, 3M), not recorded by a bitmap.

> +run_qemu <<EOF
> +{ "execute": "qmp_capabilities" }
> +{ "execute": "blockdev-add",
> +  "arguments": {
> +    "driver": "$IMGFMT",
> +    "node-name": "n",
> +    "file": {
> +      "driver": "file",
> +      "filename": "$TEST_IMG"
> +    }
> +  }
> +}
> +{ "execute": "block-dirty-bitmap-add",
> +  "arguments": {
> +    "node": "n",
> +    "name": "b",

Saving a few precious bytes.

> +    "persistent": true
> +  }
> +}
> +{ "execute": "quit" }
> +EOF
> +
> +echo
> +echo "=== Write part of the file under active bitmap ==="
> +echo
> +
> +$QEMU_IO -c 'w -P 0x22 2M 2M' "$TEST_IMG" | _filter_qemu_io
> +

- Write 0x22 to [2M, 4M) recorded by the bitmap.

> +echo
> +echo "=== End dirty bitmap, and start serving image over NBD ==="
> +echo
> +
> +_launch_qemu 2> >(_filter_nbd)
> +
> +silent=
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabilities"}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
> +  "arguments":{"driver":"qcow2", "node-name":"n",
> +    "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
> +  "arguments":{"node":"n", "name":"b"}}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
> +  "arguments":{"addr":{"type":"unix",
> +    "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
> +  "arguments":{"device":"n"}}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
> +  "arguments":{"name":"n", "bitmap":"b"}}' "return"
> +

So far, so good.

> +echo
> +echo "=== Contrast normal status with dirty-bitmap status ==="
> +echo
> +
> +QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
> +IMG="driver=nbd,export=n,server.type=unix,server.path=$TEST_DIR/nbd"
> +$QEMU_IO -r -c 'r -P 0 0 1m' -c 'r -P 0x11 1m 1m' \
> +  -c 'r -P 0x22 2m 2m' --image-opts "$IMG" | _filter_qemu_io

Confirming that we've got 0x11 from [1M, 2M) and 0x22 from [2M, 4M).

> +$QEMU_IMG map --output=json --image-opts \
> +  "$IMG" | _filter_qemu_img_map

Normal allocation map. Ought to show [1M, 4M).

> +$QEMU_IMG map --output=json --image-opts \
> +  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b" | _filter_qemu_img_map

Hacked bitmap allocation map. Ought to show [2M, 4M).

> +
> +echo
> +echo "=== End NBD server ==="
> +echo
> +
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
> +  "arguments":{"name":"n"}}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"
> +
> +# success, all done
> +echo '*** done'
> +rm -f $seq.full
> +status=0
> diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
> new file mode 100644
> index 00000000000..33021c8e6a1
> --- /dev/null
> +++ b/tests/qemu-iotests/223.out
> @@ -0,0 +1,49 @@
> +QA output created by 223
> +
> +=== Create partially sparse image, then add dirty bitmap ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
> +wrote 2097152/2097152 bytes at offset 1048576
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Testing:
> +QMP_VERSION
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
> +
> +
> +=== Write part of the file under active bitmap ===
> +
> +wrote 2097152/2097152 bytes at offset 2097152
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=== End dirty bitmap, and start serving image over NBD ===
> +
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +
> +=== Contrast normal status with dirty-bitmap status ===
> +
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 2097152/2097152 bytes at offset 2097152
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false},
> +{ "start": 1048576, "length": 3145728, "depth": 0, "zero": false, "data": true}]

Looks right.

> +[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true},
> +{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": false}]

Also looks right.

> +
> +=== End NBD server ===
> +
> +{"return": {}}
> +{"return": {}}
> +{"return": {}}
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index eea75819d2a..a446476583e 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -220,3 +220,4 @@
>  218 rw auto quick
>  219 rw auto
>  221 rw auto quick
> +223 rw auto quick
> 

It Works!:

Tested-by: John Snow <jsnow@redhat.com>

Tests what it aims to:

Reviewed-by: John Snow <jsnow@redhat.com>


I think the trick will be combining 222 and 223 into one workflow. I
think we might be missing a piece.

Consider this:

- We have some image which has a bitmap 'B' tracking writes since the
last incremental backup was made or fleeced, using the traditional "one
bitmap per backup regimen" strategy.

- We prepare to fleece by creating a new temporary store for fleecing,
and add the target drive as a backing node.

At this point, there's no point-in-time established just yet; we're
still "live" and so is the bitmap.

- We run blockdev-backup sync=none to start achieving PIT semantics for
the fleecing node.

- We start the NBD server, and add the fleecing node export.

- We attempt to link the bitmap to the NBD export, but we can't! It's
still active, and we never froze it for the PIT.



We need a way to freeze this bitmap manually like in sync=incremental,
to associate it with this PIT... or, we need to allow the "merge"
command to operate under the transaction so we can copy a bitmap out at
that PIT, e.g.

- Create bitmap "foo"
- Disable bitmap "foo"
Transaction {
  - blockdev-backup sync=none
  - merge "B" into "foo"
}
- NBD start, export, add bitmap "foo"



I think there's no escaping that we need at least one of the following:

- Merge (or copy) in transactions
- Manual bitmap freeze/thaw commands (transactionable)
- blockdev-fleece job & QMP command that does the following items:
	- Handles the creating of a temporary fleecing node
	- Establishes the blockdev-backup semantics for PIT export
	- Accepts a bitmap and forks it just like blockdev-backup does

In the case of the block job, we don't need to tie it to NBD
necessarily; we can leave it as the creation of the node. This would
allow us to export it over a different transport later.

The "add bitmap to NBD server" mechanism would then change to accept
either a disabled OR frozen bitmap.

Canceling/completing the job manually dictates if we clear the bitmap or
merge in the new changes, just like blockdev-backup.

The job could be implemented as a form of blockdev-backup with most of
the same code, but some new setup/teardown code.

That's a fanciful operation though, and too late for 3.0.
