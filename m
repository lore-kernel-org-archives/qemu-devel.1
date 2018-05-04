Received: from eggs.gnu.org ([2001:4830:134:3::10]:32874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fEekP-0001Oa-DO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fEekO-0002OC-Dj
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:43:57 -0400
References: <20180504155014.10311-1-stefanha@redhat.com>
	<20180504155014.10311-2-stefanha@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <67aaa31e-c797-7b00-76da-8be6ca69517d@virtuozzo.com>
Date: Fri, 4 May 2018 20:43:43 +0300
MIME-Version: 1.0
In-Reply-To: <20180504155014.10311-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-iotests: reduce chance of races
 in 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

04.05.2018 18:50, Stefan Hajnoczi wrote:
> Commit 8565c3ab537e78f3e69977ec2c609dc9417a806e ("qemu-iotests: fix
> 185") identified a race condition in a sub-test.
>
> Similar issues also affect the other sub-tests.  If disk I/O completes
> quickly, it races with the QMP 'quit' command.  This causes spurious
> test failures because QMP events are emitted in an unpredictable order.
>
> This test relies on QEMU internals and there is no QMP API for getting
> deterministic behavior needed to make this test 100% reliable.  At the
> same time, the test is useful and it would be a shame to remove it.
>
> Add sleep 0.5 to reduce the chance of races.  This is not a real fix but
> appears to reduce spurious failures in practice.
>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/qemu-iotests/185     | 12 ++++++++++++
>   tests/qemu-iotests/185.out |  4 ++--
>   2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
> index 298d88d04e..975404c99d 100755
> --- a/tests/qemu-iotests/185
> +++ b/tests/qemu-iotests/185
> @@ -118,6 +118,9 @@ _send_qemu_cmd $h \
>                         'speed': 65536 } }" \
>       "return"
>   
> +# If we don't sleep here 'quit' command races with disk I/O
> +sleep 0.5
> +
>   _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
>   wait=1 _cleanup_qemu
>   
> @@ -137,6 +140,9 @@ _send_qemu_cmd $h \
>                         'speed': 65536 } }" \
>       "return"
>   
> +# If we don't sleep here 'quit' command races with disk I/O
> +sleep 0.5
> +
>   _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
>   wait=1 _cleanup_qemu
>   
> @@ -183,6 +189,9 @@ _send_qemu_cmd $h \
>                         'speed': 65536 } }" \
>       "return"
>   
> +# If we don't sleep here 'quit' command races with disk I/O
> +sleep 0.5
> +
>   _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
>   wait=1 _cleanup_qemu
>   
> @@ -201,6 +210,9 @@ _send_qemu_cmd $h \
>                         'speed': 65536 } }" \
>       "return"
>   
> +# If we don't sleep here 'quit' command races with disk I/O
> +sleep 0.5
> +
>   _send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
>   wait=1 _cleanup_qemu
>   
> diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
> index 2c4b04de73..1f21e79c13 100644
> --- a/tests/qemu-iotests/185.out
> +++ b/tests/qemu-iotests/185.out
> @@ -26,9 +26,9 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
>   
>   {"return": {}}
>   {"return": {}}
> -{"return": {}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
> +{"return": {}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
>   
>   === Start mirror job and exit qemu ===

Hm, it looks strange, that commit was done with such a small speed in 
0.5 seconds...

-- 
Best regards,
Vladimir
