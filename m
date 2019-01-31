Received: from eggs.gnu.org ([209.51.188.92]:49717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gp1yh-0005cS-Kk
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gp1yg-0003FM-Fd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:21:19 -0500
References: <20190130235251.17911-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2a6ece79-0e51-4707-2427-57825f957990@redhat.com>
Date: Wed, 30 Jan 2019 21:21:12 -0500
MIME-Version: 1.0
In-Reply-To: <20190130235251.17911-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Filter second
 BLOCK_JOB_ERROR from 229
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>



On 1/30/19 6:52 PM, Max Reitz wrote:
> Without this filter, this test sometimes fails.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> I intended to send this as part of my iotest fixes series, but it ended
> up on the wrong branch...  Doesn't really matter, though, as there is no
> functional dependency.
> ---
>  tests/qemu-iotests/229     | 6 +++++-
>  tests/qemu-iotests/229.out | 1 -
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
> index 893d098ad2..b0d4885fa6 100755
> --- a/tests/qemu-iotests/229
> +++ b/tests/qemu-iotests/229
> @@ -81,11 +81,15 @@ echo
>  echo '=== Force cancel job paused in error state  ==='
>  echo
>  
> +# Filter out BLOCK_JOB_ERROR events because they may or may not occur.
> +# Cancelling the job means resuming it for a bit before it is actually
> +# aborted, and in that time it may or may not re-encounter the error.

Oh, because the job is "paused" and cancelling it involves job_enter,
which we then allow the job to gracefully fail through it's own pathways
-- but depending on where it failed originally, it may-or-may-not wind
up trying something else that fails before it finds the "exit
gracefully" signal, is that right?

I guess there's no real way to adjust that behavior.

>  success_or_failure="y" _send_qemu_cmd $QEMU_HANDLE \
>      "{'execute': 'block-job-cancel',
>                   'arguments': { 'device': 'testdisk',
>                                  'force': true}}" \
> -     "BLOCK_JOB_CANCELLED" "Assertion"
> +     "BLOCK_JOB_CANCELLED" "Assertion" \
> +    | grep -v '"BLOCK_JOB_ERROR"'
>  
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
> index 4c4112805f..a3eb33788a 100644
> --- a/tests/qemu-iotests/229.out
> +++ b/tests/qemu-iotests/229.out
> @@ -17,7 +17,6 @@ wrote 2097152/2097152 bytes at offset 0
>  
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
>  {"return": {}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "testdisk", "operation": "write", "action": "stop"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdisk"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 2097152, "offset": 1048576, "speed": 0, "type": "mirror"}}
>  *** done
> 

I think this is fine, if we cannot help to make this any more
deterministic, so I'm fine with:

Reviewed-by: John Snow <jsnow@redhat.com>

but I am curious to know if this poses any theoretical problems for
libvirt having to deal with possibly an extra hiccup before the cancel
registers.
