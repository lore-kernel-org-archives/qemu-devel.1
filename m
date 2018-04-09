Received: from eggs.gnu.org ([2001:4830:134:3::10]:47520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f5WQV-0000Jy-Qt
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f5WQN-0002fe-W7
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:01:39 -0400
Received: from mail-eopbgr30130.outbound.protection.outlook.com
	([40.107.3.130]:30164
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1f5WQN-0002dq-B9
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:01:31 -0400
References: <20180404103440.19546-1-stefanha@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <008ac6e8-1e68-b0f6-7e75-77453721d031@virtuozzo.com>
Date: Mon, 9 Apr 2018 16:01:24 +0300
MIME-Version: 1.0
In-Reply-To: <20180404103440.19546-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] scripts/qemugdb: support coroutine
 backtrace in coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

04.04.2018 13:34, Stefan Hajnoczi wrote:
> Use the 'select-frame' GDB command to switch stacks instead of manually
> setting the debugged thread's registers (this only works when debugging
> a live process, not in a coredump).
>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Vladimir: Does this work for you?
>
>   scripts/qemugdb/coroutine.py | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
> index ab699794ab..ed96434aee 100644
> --- a/scripts/qemugdb/coroutine.py
> +++ b/scripts/qemugdb/coroutine.py
> @@ -77,13 +77,11 @@ def bt_jmpbuf(jmpbuf):
>       for i in regs:
>           old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
>   
> -    for i in regs:
> -        gdb.execute('set $%s = %s' % (i, regs[i]))
> +    gdb.execute('select-frame %s %s' % (regs['rsp'], regs['rip']))
>   
>       gdb.execute('bt')
>   
> -    for i in regs:
> -        gdb.execute('set $%s = %s' % (i, old[i]))
> +    gdb.execute('select-frame %s %s' % (old['rsp'], old['rip']))
>   
>   def coroutine_to_jmpbuf(co):
>       coroutine_pointer = co.cast(gdb.lookup_type('CoroutineUContext').pointer())

strange, but it doesn't work. it prints the same backtrace, as if I just 
call bt.
(I applied it onto "[PATCH 2/4] scripts/qemugdb: improve "qemu 
coroutine" command")

also, I can just call select-frame with zeros or any garbage in gdb, 
with same effect:
(gdb) select-frame 0 0
(gdb) bt

and get same backtrace.

so, bt command not related to selected frame. also, up and down commands 
don't help too, they go to frames in current bt, instead of moving 
relatively to selected frame.

-- 
Best regards,
Vladimir
