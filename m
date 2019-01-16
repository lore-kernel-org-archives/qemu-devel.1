Received: from eggs.gnu.org ([209.51.188.92]:42960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjoWk-0007rW-CY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjoWi-00006V-UY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:58:54 -0500
Date: Wed, 16 Jan 2019 16:58:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116165837.GF20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-7-vsementsov@virtuozzo.com>
	<64d9a2e7-6dd9-d71b-b9bf-c476e9e218f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64d9a2e7-6dd9-d71b-b9bf-c476e9e218f8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 06/10] block/nbd-client: move from quit
 to state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On Wed, Jan 16, 2019 at 10:25:03AM -0600, Eric Blake wrote:
> [adding Dan]
> 
> On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> > To implement reconnect we need several states for the client:
> > CONNECTED, QUIT and two CONNECTING states. CONNECTING states will
> > be realized in the following patches. This patch implements CONNECTED
> > and QUIT.
> > 
> > QUIT means, that we should close the connection and fail all current
> > and further requests (like old quit = true).
> > 
> > CONNECTED means that connection is ok, we can send requests (like old
> > quit = false).
> > 
> > For receiving loop we use a comparison of the current state with QUIT,
> > because reconnect will be in the same loop, so it should be looping
> > until the end.
> > 
> > Opposite, for requests we use a comparison of the current state with
> > CONNECTED, as we don't want to send requests in CONNECTING states (
> > which are unreachable now, but will be reachable after the following
> > commits)
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >  block/nbd-client.h |  9 ++++++++-
> >  block/nbd-client.c | 55 ++++++++++++++++++++++++++++++++----------------------
> >  2 files changed, 41 insertions(+), 23 deletions(-)
> 
> Dan just recently proposed patches to SocketChardev in general to use a
> state machine that distinguishes between connecting and connected:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03339.html
> 
> I'm wondering how much of his work is related or can be reused to get
> restartable connections on NBD sockets?

There's nothing really special about what I did. Vladimir looks to
have basically done the same kind of approach, but I don't think
there's real scope for sharing with chardevs, as each care about
their own set of states.

> Remember, right now, the NBD code always starts in blocking mode, and
> does single-threaded handshaking until it is ready for transmission,
> then switches to non-blocking mode for all subsequent transmissions (so,
> for example, servicing a read request can assume that the socket is
> valid without further waiting).  But once we start allowing reconnects,
> a read request will need to detect when one socket has gone down, and
> wait for its replacement socket to come back up, in order to retry the
> request; this retry is in a context where we are in non-blocking
> context, but the retry must establish a new socket, and possibly convert
> the socket into TLS mode, all before being ready to retry the read request.

That makes it sound like the NBD handshake needs to be converted to
use entirely non-blocking I/O.

The TLS handshake already uses an asynchronous callback pattern and
to deal with that NBD had to create & run a private main loop to
complete the TLS handshake in its blocking code pattern.

You could potentially push this concept up to the top level. ie
implement the entire NBD handshake with async callbacks / non-blocking
I/O. Then simply use a private main loop to run that in a blocking
fashion for the initial connection. When you need to do re-connect
you now just run the async code without the extra main loop around
it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
