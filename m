Received: from eggs.gnu.org ([2001:4830:134:3::10]:36977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8mJG-0000Yb-A8
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8mJE-0005Tu-Uw
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:31:06 -0400
Date: Thu, 11 May 2017 19:30:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170511113053.GA31287@lemon.lan>
References: <20170502163558.7611-1-famz@redhat.com>
	<20170502163558.7611-24-famz@redhat.com>
	<20170511100809.GC4235@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511100809.GC4235@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v17 23/23] tests: Add POSIX image locking
 test case 182
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

On Thu, 05/11 12:08, Kevin Wolf wrote:
> Am 02.05.2017 um 18:35 hat Fam Zheng geschrieben:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/qemu-iotests/182     | 73 ++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/182.out |  8 +++++
> >  tests/qemu-iotests/group   |  1 +
> >  3 files changed, 82 insertions(+)
> >  create mode 100755 tests/qemu-iotests/182
> >  create mode 100644 tests/qemu-iotests/182.out
> > 
> > diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
> > new file mode 100755
> > index 0000000..ddc2f18
> > --- /dev/null
> > +++ b/tests/qemu-iotests/182
> > @@ -0,0 +1,73 @@
> > +#!/bin/bash
> > +#
> > +# Test image locking for POSIX locks
> > +#
> > +# Copyright 2017 Red Hat, Inc.
> > +#
> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation; either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > +#
> > +
> > +# creator
> > +owner=famz@redhat.com
> > +
> > +seq="$(basename $0)"
> > +echo "QA output created by $seq"
> > +
> > +here="$PWD"
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +
> > +_cleanup()
> > +{
> > +    _cleanup_test_img
> > +}
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +# get standard environment, filters and checks
> > +. ./common.rc
> > +. ./common.filter
> > +. ./common.qemu
> > +
> > +_supported_fmt qcow2
> > +_supported_proto file
> > +_supported_os Linux
> > +
> > +size=32M
> > +
> > +_make_test_img $size
> > +
> > +_run_cmd()
> > +{
> > +    echo
> > +    (echo "$@"; "$@" 1>/dev/null) >&2 | _filter_testdir
> > +}
> > +
> > +echo "Starting QEMU"
> > +_launch_qemu -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
> > +    -device virtio-blk-pci,drive=drive0
> > +
> > +echo
> > +echo "Starting a second QEMU using the same image should fail"
> > +echo 'quit' | $QEMU -monitor stdio \
> > +    -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
> > +    -device virtio-blk-pci,drive=drive0 2>&1 | _filter_testdir 2>&1 |
> > +    sed -e '/falling back to POSIX file/d' \
> > +        -e '/locks can be lost unexpectedly/d'
> > +
> > +_cleanup_qemu
> 
> The error message contains the name of the QEMU binary which made the
> test fail for me. Also, _run_cmd is unused. I'm squashing in the
> following patch.
> 
> Kevin
> 
> diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
> index ddc2f18..7ecbb22 100755
> --- a/tests/qemu-iotests/182
> +++ b/tests/qemu-iotests/182
> @@ -47,12 +47,6 @@ size=32M
>  
>  _make_test_img $size
>  
> -_run_cmd()
> -{
> -    echo
> -    (echo "$@"; "$@" 1>/dev/null) >&2 | _filter_testdir
> -}
> -
>  echo "Starting QEMU"
>  _launch_qemu -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
>      -device virtio-blk-pci,drive=drive0
> @@ -62,6 +56,7 @@ echo "Starting a second QEMU using the same image should fail"
>  echo 'quit' | $QEMU -monitor stdio \
>      -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
>      -device virtio-blk-pci,drive=drive0 2>&1 | _filter_testdir 2>&1 |
> +    _filter_qemu |
>      sed -e '/falling back to POSIX file/d' \
>          -e '/locks can be lost unexpectedly/d'
>  
> diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
> index b4b8f77..23a4dbf 100644
> --- a/tests/qemu-iotests/182.out
> +++ b/tests/qemu-iotests/182.out
> @@ -3,6 +3,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432
>  Starting QEMU
>  
>  Starting a second QEMU using the same image should fail
> -qemu-system-x86_64: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0,file.locking=on: Failed to get "write" lock
> +QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0,file.locking=on: Failed to get "write" lock
>  Is another process using the image?
>  *** done

Looks good, thanks!

Fam
