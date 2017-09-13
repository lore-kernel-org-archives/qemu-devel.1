Received: from eggs.gnu.org ([2001:4830:134:3::10]:56132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsGrz-0000Q9-FT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsGrw-0003a1-8m
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dsGrv-0003ZL-W5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:14:56 -0400
References: <1504888905-22396-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504888905-22396-4-git-send-email-chugh.ishani@research.iiit.ac.in>
From: John Snow <jsnow@redhat.com>
Message-ID: <08f47a9b-b6f0-d35c-7d64-fe3a8b6b1989@redhat.com>
Date: Wed, 13 Sep 2017 19:14:48 -0400
MIME-Version: 1.0
In-Reply-To: <1504888905-22396-4-git-send-email-chugh.ishani@research.iiit.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/3] Test for full Backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com



On 09/08/2017 12:41 PM, Ishani Chugh wrote:
> This patch is the test for full backup implementation in Backup tool.
> The test employs two basic substests:
> 1) Backing up an empty guest and comparing it with base image.
> 2) Writing a pattern to the guest, creating backup and comparing
>    with the base image.
> 
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  tests/qemu-iotests/191     | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/191.out | 35 +++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 122 insertions(+)
>  create mode 100755 tests/qemu-iotests/191
>  create mode 100644 tests/qemu-iotests/191.out
> 
> diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
> new file mode 100755
> index 0000000..16988d8
> --- /dev/null
> +++ b/tests/qemu-iotests/191
> @@ -0,0 +1,86 @@
> +#!/bin/bash
> +#
> +# Test full backup functionality of qemu-backup tool
> +#
> +# Copyright (C) 2017 Ishani Chugh <chugh.ishani@research.iiit.ac.in>
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
> +owner=chugh.ishani@research.iiit.ac.in
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1	# failure is the default!
> +
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
> +_cleanup()
> +{
> +        rm -f "$TEST_DIR"/virtio0
> +        rm -f "$CONFIG_FILE"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +CONFIG_FILE="$TEST_DIR"/backup-config
> +SOCKET=unix:"$TEST_DIR"/backup_socket
> +size=128M
> +
> +_make_test_img "$size"
> +export QEMU_BACKUP_CONFIG="$CONFIG_FILE"
> +qemu_comm_method="monitor"
> +echo
> +_launch_qemu -drive if=virtio,file="$TEST_IMG" -qmp "$SOCKET",server,nowait

QEMU launch invocation is missing the format= parameter. This test fails
with the -raw format because of this.
