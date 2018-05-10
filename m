Received: from eggs.gnu.org ([2001:4830:134:3::10]:54500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fGm90-0004n8-C3
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fGm8u-0007BI-GH
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:02:06 -0400
References: <20180508135436.30140-1-stefanha@redhat.com>
	<20180508135436.30140-2-stefanha@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c3830b07-f09b-b7b8-d08c-cffdf2e32797@virtuozzo.com>
Date: Thu, 10 May 2018 17:01:42 +0300
MIME-Version: 1.0
In-Reply-To: <20180508135436.30140-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qemu-iotests: reduce chance of
 races in 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

08.05.2018 16:54, Stefan Hajnoczi wrote:
> Commit 8565c3ab537e78f3e69977ec2c609dc9417a806e ("qemu-iotests: fix
> 185") identified a race condition in a sub-test.
>
> Similar issues also affect the other sub-tests.  If disk I/O completes
> quickly, it races with the QMP 'quit' command.  This causes spurious
> test failures because QMP events are emitted in an unpredictable order.

Hmm, can you give an example? I'm looking at 8565c3ab537. and
it's not similar.

If disk I/O completes quickly, it will have large final offset, and test 
will
fail. And pause of 0.5 will not help.

My case was that quit is handled before the first iteration of mirror.

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
>   tests/qemu-iotests/185 | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
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
>

-- 
Best regards,
Vladimir
