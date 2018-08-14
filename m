Received: from eggs.gnu.org ([2001:4830:134:3::10]:48784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fpQAp-0004CQ-KZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fpQAo-00058L-OM
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:39:11 -0400
Date: Mon, 13 Aug 2018 23:39:00 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180814033900.GB3254@localhost.localdomain>
References: <20180813022006.7216-1-mreitz@redhat.com>
	<20180813022006.7216-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813022006.7216-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/17] iotests: Try reading while mirroring
 in 156
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On Mon, Aug 13, 2018 at 04:19:50AM +0200, Max Reitz wrote:
> Currently, we never test whether we can read from the source while
> mirroring (that means, whether we can read from the mirror BDS).  Add
> such a test to 156 because it fits well.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  tests/qemu-iotests/156     | 7 +++++++
>  tests/qemu-iotests/156.out | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
> index 0a9a09802e..99f7326158 100755
> --- a/tests/qemu-iotests/156
> +++ b/tests/qemu-iotests/156
> @@ -106,6 +106,13 @@ _send_qemu_cmd $QEMU_HANDLE \
>                        'qemu-io source \"write -P 4 192k 64k\"' } }" \
>      'return'
>  
> +# Read it back (proving that we can read while mirroring)
> +_send_qemu_cmd $QEMU_HANDLE \
> +    "{ 'execute': 'human-monitor-command',
> +       'arguments': { 'command-line':
> +                      'qemu-io source \"read -P 4 192k 64k\"' } }" \
> +    'return'
> +
>  # Copy source backing chain to the target before completing the job
>  cp "$TEST_IMG.backing" "$TEST_IMG.target.backing"
>  cp "$TEST_IMG" "$TEST_IMG.target"
> diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
> index 34c057b626..a591bd3a1e 100644
> --- a/tests/qemu-iotests/156.out
> +++ b/tests/qemu-iotests/156.out
> @@ -20,6 +20,9 @@ Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=IMGFMT size=1048576 backing_f
>  wrote 65536/65536 bytes at offset 196608
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  {"return": ""}
> +read 65536/65536 bytes at offset 196608
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +{"return": ""}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "source"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "source"}}
> -- 
> 2.17.1
> 
