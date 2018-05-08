Received: from eggs.gnu.org ([2001:4830:134:3::10]:40804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG3ZO-0004NV-C2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG3ZK-0004cw-64
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:26:22 -0400
References: <20180508135436.30140-1-stefanha@redhat.com>
	<20180508135436.30140-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa220f7d-9aa1-f32d-14f0-35d6a8161032@redhat.com>
Date: Tue, 8 May 2018 09:26:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180508135436.30140-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

On 05/08/2018 08:54 AM, Stefan Hajnoczi wrote:
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
>   tests/qemu-iotests/185 | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

I'm not opposed to this patch, but is there any way to write the test to 
take both events in either order, without logging the events as they 
arrive, but instead summarizing in a deterministic order which events 
were received after the fact?  That way, no matter which way the race is 
won, we merely log that we got two expected events, and could avoid the 
extra sleep.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
