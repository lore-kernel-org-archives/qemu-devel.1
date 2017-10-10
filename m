Received: from eggs.gnu.org ([2001:4830:134:3::10]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1q5x-0004cP-4G
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1q5t-0000Mt-UI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:40:57 -0400
Date: Tue, 10 Oct 2017 09:40:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171010084035.GB30015@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-9-vsementsov@virtuozzo.com>
	<5c57b76e-eb34-7825-9c8b-9ee5bd909b02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c57b76e-eb34-7825-9c8b-9ee5bd909b02@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/10] nbd-server: refactor simple reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On Mon, Oct 09, 2017 at 02:18:10PM -0500, Eric Blake wrote:
> [adding Dan for a qio question - search for your name below]
> 
> On 10/09/2017 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> > Get rid of calculating structure fields offsets by hand and set_cork,
> > rename nbd_co_send_reply to nbd_co_send_simple_reply. Do not use
> > NBDReply which will be upgraded in future patches to handle both simple
> > and structured replies and will be used only in the client.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >  include/block/nbd.h |  6 ++++
> >  nbd/nbd-internal.h  |  9 +++++
> >  nbd/server.c        | 97 ++++++++++++++++++++++-------------------------------
> >  3 files changed, 56 insertions(+), 56 deletions(-)

> > -static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
> > -                             Error **errp)
> > +static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
> > +                                        unsigned niov, Error **errp)
> >  {
> > -    NBDClient *client = req->client;
> >      int ret;
> >  
> >      g_assert(qemu_in_coroutine());
> > -
> > -    trace_nbd_co_send_reply(reply->handle, reply->error, len);
> > -
> >      qemu_co_mutex_lock(&client->send_lock);
> >      client->send_coroutine = qemu_coroutine_self();
> >  
> > -    if (!len) {
> > -        ret = nbd_send_reply(client->ioc, reply, errp);
> > -    } else {
> > -        qio_channel_set_cork(client->ioc, true);
> > -        ret = nbd_send_reply(client->ioc, reply, errp);
> > -        if (ret == 0) {
> > -            ret = nbd_write(client->ioc, req->data, len, errp);
> > -            if (ret < 0) {
> > -                ret = -EIO;
> > -            }
> > -        }
> > -        qio_channel_set_cork(client->ioc, false);
> > -    }
> > +    ret = nbd_writev(client->ioc, iov, niov, errp);
> 
> ...the transmission is now done via iov so that you can send two buffers
> at once without having to play with the cork,...
> 
> Dan - are we guaranteed that qio_channel_writev_all() with a multi-iov
> argument called by one thread will send all its data in order, without
> being interleaved with any other parallel coroutine also calling
> qio_channel_writev_all()?  In other words, it looks like the NBD code
> was previously using manual cork changes to ensure that two halves of a
> message were sent without interleave, but Vladimir is now relying on the
> qio code to do that under the hood.

The I/O channels code does not make guarantees wrt concurrent usage of
threads or coroutines. It is the callers responsibility to avoid any
concurrent usage for all APIs. With coroutines you are at least avoiding
the danger of corrupting memory state, but you still have risk of unexpected
data ordering.

IOW, if you have 2 coroutines each doing a series writes on the same QIOChannel
object, and one does a yield, I/O can certainly be interleaved between the two.
This is true whether doing multiple qio_channel_writev() calls directly, or
whether using qio_channel_writev_all().

Unless I'm misunderstanding though, cork did not offer you protection in
this scenario either. cork just prevents the data being transmitted onto
the wire immediately - ie it ensures that if you do 2 writes, they get
sent in 1 TCP packet instead of many TCP packets.

If you have multiple coroutines writing to the channel at the same time
and one yielded in its series of writes, the I/O from multiple coroutines
will get merged into that 1 single TCP packet when uncorked.

So if this concurrent usage is a problem NBD was already broken AFAICT.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
