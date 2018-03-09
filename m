Received: from eggs.gnu.org ([2001:4830:134:3::10]:36888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euPvD-0002Oq-9R
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euPvC-0003F9-5t
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:51:27 -0500
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
	<20180308184636.178534-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc19fbc1-71b9-59cd-2556-3b388a886091@redhat.com>
Date: Fri, 9 Mar 2018 15:51:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180308184636.178534-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] nbd/server: fix: check client->closing
 before reply sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> It's like an RFC. I'm not sure, but this place looks like a bug. Shouldn't
> we chack client-closing even before nbd_client_receive_next_request() call?
> 
>   nbd/server.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index e0de431e10..97b45a21fa 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1547,10 +1547,6 @@ static coroutine_fn void nbd_trip(void *opaque)

More context:

     ret = nbd_co_receive_request(req, &request, &local_err);
     client->recv_coroutine = NULL;
     nbd_client_receive_next_request(client);
     if (ret == -EIO) {

>           goto disconnect;
>       }
>   

Calling nbd_client_receive_next_request() checks whether recv_coroutine 
is NULL (it is, because we just set it that way) and whether we are up 
to our maximum in parallel request handling; so it likely queues another 
coroutine to call nbd_trip() again.  However, when the next nbd_trip() 
is invoked, the first thing it does (after a trace call) is check 
client->closing, at which point it is a nop.

Your argument is that if ret was -EIO, we goto disconnect (which sets 
client->closing if it was not already set), and thus the just-scheduled 
next nbd_trip() will be a nop.  If ret was anything else, we used to try 
to reply to the client no matter what, which generally works; although 
if client->closing is already set, the attempt to reply is instead 
likely to fail and result in a later attempt to goto disconnect - but at 
that point disconnect is a nop since client->closing is already set. 
Whereas your patch skips the reply to the client if client->closing (and 
can't reach the disconnect code, but that doesn't matter as the 
disconnect attempt did nothing).  Swapping the check for client->closing 
to be earlier than the reply to the client thus looks safe.

Your RFC question is whether we can just check client->closing before 
checking ret, and skip nbd_client_receive_next_request() in that case 
(in other words, why even bother to queue up a coroutine that will do 
nothing, if we already know the client is going away).  And my answer is 
yes, I think that makes more sense.  So that would be:

diff --git c/nbd/server.c w/nbd/server.c
index 5f292064af0..b230ecb4fb8 100644
--- c/nbd/server.c
+++ w/nbd/server.c
@@ -1543,14 +1543,6 @@ static coroutine_fn void nbd_trip(void *opaque)
      req = nbd_request_get(client);
      ret = nbd_co_receive_request(req, &request, &local_err);
      client->recv_coroutine = NULL;
-    nbd_client_receive_next_request(client);
-    if (ret == -EIO) {
-        goto disconnect;
-    }
-
-    if (ret < 0) {
-        goto reply;
-    }

      if (client->closing) {
          /*
@@ -1560,6 +1552,15 @@ static coroutine_fn void nbd_trip(void *opaque)
          goto done;
      }

+    nbd_client_receive_next_request(client);
+    if (ret == -EIO) {
+        goto disconnect;
+    }
+
+    if (ret < 0) {
+        goto reply;
+    }
+
      switch (request.type) {
      case NBD_CMD_READ:
          /* XXX: NBD Protocol only documents use of FUA with WRITE */


Unless this revised form fails testing or gets any other review 
comments, I will go ahead and amend your commit in this manner.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
