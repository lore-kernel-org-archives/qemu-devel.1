Received: from eggs.gnu.org ([2001:4830:134:3::10]:41998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVqni-0000ki-J2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVqnc-0003nE-Gz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVqnc-0003n3-7c
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:57:48 -0400
Date: Fri, 14 Jul 2017 10:57:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714025742.GD27284@pxdev.xzpeter.org>
References: <20170704184915.31586-1-dgilbert@redhat.com>
	<20170704184915.31586-4-dgilbert@redhat.com>
	<20170712093233.GI29326@pxdev.xzpeter.org>
	<20170712123606.GB30658@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170712123606.GB30658@work-vm>
Subject: Re: [Qemu-devel] [PATCH 3/5] migration/rdma: Allow cancelling while
 waiting for wrid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, lvivier@redhat.com, berrange@redhat.com

On Wed, Jul 12, 2017 at 01:36:07PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Tue, Jul 04, 2017 at 07:49:13PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > When waiting for a WRID, if the other side dies we end up waiting
> > > for ever with no way to cancel the migration.
> > > Cure this by poll()ing the fd first with a timeout and checking
> > > error flags and migration state.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  migration/rdma.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 48 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/migration/rdma.c b/migration/rdma.c
> > > index 6111e10c70..7273ae9929 100644
> > > --- a/migration/rdma.c
> > > +++ b/migration/rdma.c
> > > @@ -1466,6 +1466,52 @@ static uint64_t qemu_rdma_poll(RDMAContext *rdma, uint64_t *wr_id_out,
> > >      return  0;
> > >  }
> > >  
> > > +/* Wait for activity on the completion channel.
> > > + * Returns 0 on success, none-0 on error.
> > > + */
> > > +static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
> > > +{
> > > +    /*
> > > +     * Coroutine doesn't start until migration_fd_process_incoming()
> > > +     * so don't yield unless we know we're running inside of a coroutine.
> > > +     */
> > > +    if (rdma->migration_started_on_destination) {
> > > +        yield_until_fd_readable(rdma->comp_channel->fd);
> > > +    } else {
> > > +        /* This is the source side, we're in a separate thread
> > > +         * or destination prior to migration_fd_process_incoming()
> > > +         * we can't yield; so we have to poll the fd.
> > > +         * But we need to be able to handle 'cancel' or an error
> > > +         * without hanging forever.
> > > +         */
> > > +        while (!rdma->error_state && !rdma->error_reported &&
> > > +               !rdma->received_error) {
> > 
> > Should we just check rdma->error_state? Since iiuc error_reported only
> > means whether error is reported (set to 1 if reported), and
> > received_error means whether we got explicit error from peer (I think
> > only via a RDMA_CONTROL_ERROR message), and it's 1 if received. IIUC
> > either error_reported or received_error will mean that error_state be
> > set already.
> 
> I think I agree we don't need to check both error_state and
> error_reported; I think it's best to check received_error since if
> the other end fails we want this end to stop waiting for anything else.
> I've not convinced myself that every path from receiving that error
> till this point would have set the error_state (although it probably
> has);  so I suggest:
>    while (!rdma->error_state && !rdma->received_error) {

qemu_rdma_exchange_get_response() is the only place I see to set the
received_error. And when that is triggered, the stack would be:

   qemu_rdma_exchange_get_response() set received_error=true, ret -EIO
     <-- qemu_rdma_exchange_recv() return the -EIO
       <-- qio_channel_rdma_readv() pass the -EIO to error_state, or
       <-- qemu_rdma_registration_handle() pass the -EIO to error_state

But even so, I'm totally fine that we check both.

> 
> > > +            GPollFD pfds[1];
> > > +            pfds[0].fd = rdma->comp_channel->fd;
> > > +            pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> > > +            /* 0.5s timeout, should be fine for a 'cancel' */
> > > +            switch (qemu_poll_ns(pfds, 1, 500 * 1000 * 1000)) {
> > 
> > (I would be more aggresive, say, 100ms, or even less, for better UI
> >  response with merely nothing lost. But 500ms is okay as well to me)
> 
> Yes, it felt fairly arbitrary here.
> 
> > > +            case 1: /* fd active */
> > > +                return 0;
> > > +
> > > +            case 0: /* Timeout, go around again */
> > > +                break;
> > > +
> > > +            default: /* Error of some type */
> > > +                return -1;
> > > +            }
> > > +
> > > +            if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
> > > +                /* Bail out and let the cancellation happen */
> > > +                return -EPIPE;
> > > +            }
> > > +        }
> > > +    }
> > > +
> > > +    return rdma->error_state || rdma->error_reported ||
> > > +           rdma->received_error;
> > 
> > Similar question here. Maybe just return rdma->error_state?
> 
> As above, I could just drop the error_reported part.

Sure. Will reply on the new version.

-- 
Peter Xu
