Received: from eggs.gnu.org ([2001:4830:134:3::10]:59921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9Yo-00056z-9v
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9Yn-0007Wr-Ju
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:49:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170821161539.11066-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c0863edd-1675-8cf2-f5e5-1e1e4c1842e8@amsat.org>
Date: Tue, 22 Aug 2017 10:49:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170821161539.11066-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] nbd-client: fix hang after server closes
 connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

On 08/21/2017 01:15 PM, Stefan Hajnoczi wrote:
> Commit 72b6ffc76653214b69a94a7b1643ff80df134486 ("nbd-client: Fix
> regression when server sends garbage") improved NBD client behavior when
> the connection enters a broken state.
> 
> The following still does not behave as expected:
> 
>    $ qemu-nbd -p 1234 -x drive0 -f qcow2 test.qcow2
>    $ qemu-system-x86_64 -M accel=kvm -m 1G \
>          -drive if=virtio,id=drive0,file=nbd://localhost:1234/drive0,format=raw
>    $ pkill qemu-nbd
>    (qemu) quit
>    ...hang...
> 
> QEMU should be able to quit even when the connection was previously
> closed by the NBD server.  Currently the nbd_read_reply_entry()
> coroutine terminates without letting in-flight requests know that the
> connection is dead.
> 
> This patch flags the connection as dead so in-flight requests can
> complete.
> 
> Reported-by: Longxiang Lyu <lolyu@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   block/nbd-client.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 422ecb4307..5a5fe02015 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -80,6 +80,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>               error_report_err(local_err);
>           }
>           if (ret <= 0) {
> +            s->quit = true;
>               break;
>           }
>   
> @@ -107,9 +108,6 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>           qemu_coroutine_yield();
>       }
>   
> -    if (ret < 0) {
> -        s->quit = true;
> -    }
>       nbd_recv_coroutines_enter_all(s);
>       s->read_reply_co = NULL;
>   }
> 
