Received: from eggs.gnu.org ([2001:4830:134:3::10]:57294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5ZHH-0005I4-D6
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5ZHG-00075j-AU
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:59:47 -0400
Date: Tue, 2 May 2017 16:59:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170502145936.GF5805@noname.redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
	<20170502081832.9546-22-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502081832.9546-22-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v16 21/22] qemu-iotests: Add test case 153
 for image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 02.05.2017 um 10:18 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/153     | 247 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/153.out | 390 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 638 insertions(+)
>  create mode 100755 tests/qemu-iotests/153
>  create mode 100644 tests/qemu-iotests/153.out
> 
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> new file mode 100755
> index 0000000..ed90f12
> --- /dev/null
> +++ b/tests/qemu-iotests/153
> @@ -0,0 +1,247 @@
> +#!/bin/bash
> +#
> +# Test image locking
> +#
> +# Copyright 2016, 2017 Red Hat, Inc.
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
> +owner=famz@redhat.com
> +
> +seq="$(basename $0)"
> +echo "QA output created by $seq"
> +
> +here="$PWD"
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_test_img
> +    rm -f "${TEST_IMG}.base"
> +    rm -f "${TEST_IMG}.convert"
> +    rm -f "${TEST_IMG}.a"
> +    rm -f "${TEST_IMG}.b"
> +    rm -f "${TEST_IMG}.lnk"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +. ./common.qemu
> +
> +_check_ofd()
> +{
> +    local test_source="${TEST_DIR}/ofd-test.c"
> +    local test_binary="${TEST_DIR}/ofd-test"
> +    cat > "$test_source" <<EOF
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +
> +int main(int argc, char *argv[])
> +{
> +    int fd = open(argv[0], O_RDONLY);
> +    struct flock fl = {
> +        .l_whence = SEEK_SET,
> +        .l_start  = 0,
> +        .l_len    = 1,
> +        .l_type   = F_RDLCK,
> +    };
> +    return !(fd >= 0 && fcntl(fd, F_OFD_SETLK, &fl) == 0);
> +}
> +EOF
> +    cc "$test_source" -o "$test_binary" 2>&1 && "$test_binary"
> +}

Hm. Not sure I like this. It requires that a compiler is even installed
on the test machine, it doesn't respect which compiler was selected in
configure, and if the libc version on test machine doesn't match the
build machine of the qemu binaries, it might not even give the right
result.

Wouldn't it be much easier to just start qemu-io with locking=on and
grep for the warning?

Kevin
