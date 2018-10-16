Received: from eggs.gnu.org ([2001:4830:134:3::10]:37646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCTl3-00033O-Hu
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCTkw-0007z9-24
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:07:48 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b208ed10-5763-23a1-c576-23aaa4fa22b2@redhat.com>
Date: Tue, 16 Oct 2018 13:07:20 -0500
MIME-Version: 1.0
In-Reply-To: <20181015141453.32632-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] iotests: Make nbd-fault-injector flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 10/15/18 9:14 AM, Max Reitz wrote:
> When closing a connection, make the nbd-fault-injector flush the socket.
> Without this, the output is a bit unreliable with Python 3.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/083.out               | 9 +++++++++
>   tests/qemu-iotests/nbd-fault-injector.py | 1 +
>   2 files changed, 10 insertions(+)

I already had a complaint that the error message in 083.out should NOT 
be printing a message (whether the server is python 2 and auto-flushes, 
or python 3 and needs an explicit flush, the message itself is 
pointless, and the test is racy as a result).  We may need to revisit 
this patch when that thread is resolved.

https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg01041.html

That said, I'm not opposed to this patch, if it gets iotests to be more 
useful in the meantime.

> 
> diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
> index be6079d27e..f9af8bb691 100644
> --- a/tests/qemu-iotests/083.out
> +++ b/tests/qemu-iotests/083.out
> @@ -41,6 +41,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo
>   
>   === Check disconnect after neg2 ===
>   
> +Unable to read from socket: Connection reset by peer
>   Connection closed
>   read failed: Input/output error
>   
> @@ -54,6 +55,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo
>   
>   === Check disconnect before request ===
>   
> +Unable to read from socket: Connection reset by peer
>   Connection closed
>   read failed: Input/output error
>   
> @@ -116,6 +118,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/
>   
>   === Check disconnect after neg-classic ===
>   
> +Unable to read from socket: Connection reset by peer
>   Connection closed
>   read failed: Input/output error
>   
> @@ -161,6 +164,8 @@ can't open device nbd+unix:///foo?socket=TEST_DIR/nbd.sock
>   
>   === Check disconnect after neg2 ===
>   
> +Unable to read from socket: Connection reset by peer
> +Connection closed
>   read failed: Input/output error
>   
>   === Check disconnect 8 neg2 ===
> @@ -173,6 +178,8 @@ can't open device nbd+unix:///foo?socket=TEST_DIR/nbd.sock
>   
>   === Check disconnect before request ===
>   
> +Unable to read from socket: Connection reset by peer
> +Connection closed
>   read failed: Input/output error
>   
>   === Check disconnect after request ===
> @@ -234,6 +241,8 @@ can't open device nbd+unix:///?socket=TEST_DIR/nbd.sock
>   
>   === Check disconnect after neg-classic ===
>   
> +Unable to read from socket: Connection reset by peer
> +Connection closed
>   read failed: Input/output error
>   
>   *** done
> diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
> index f9193c0fae..439a090eb6 100755
> --- a/tests/qemu-iotests/nbd-fault-injector.py
> +++ b/tests/qemu-iotests/nbd-fault-injector.py
> @@ -112,6 +112,7 @@ class FaultInjectionSocket(object):
>               if rule.match(event, io):
>                   if rule.when == 0 or bufsize is None:
>                       print('Closing connection on rule match %s' % rule.name)
> +                    self.sock.flush()
>                       sys.exit(0)
>                   if rule.when != -1:
>                       return rule.when
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
