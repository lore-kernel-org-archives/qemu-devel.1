Received: from eggs.gnu.org ([2001:4830:134:3::10]:42661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faIFz-0005HM-NG
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faIFy-0005Sq-Lh
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:09:59 -0400
References: <20180702191458.28741-1-eblake@redhat.com>
	<20180702191458.28741-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2e8ffc72-6487-79ef-7ce5-e18c712c4bd4@virtuozzo.com>
Date: Tue, 3 Jul 2018 13:09:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180702191458.28741-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

02.07.2018 22:14, Eric Blake wrote:
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
>   tests/qemu-iotests/223     | 138 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/223.out |  49 ++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 188 insertions(+)
>   create mode 100755 tests/qemu-iotests/223
>   create mode 100644 tests/qemu-iotests/223.out
>
> diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
> new file mode 100755
> index 00000000000..b63b7a4f9e1
> --- /dev/null
> +++ b/tests/qemu-iotests/223
> @@ -0,0 +1,138 @@
> +#!/bin/bash

[...]

> +
> +echo
> +echo "=== End NBD server ==="
> +echo
> +
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
> +  "arguments":{"name":"n"}}' "return"
> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"

blockdev-del is not necessary?

with or without:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
