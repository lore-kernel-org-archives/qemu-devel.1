Received: from eggs.gnu.org ([2001:4830:134:3::10]:42524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSnux-0005Pe-L7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSnut-0004dM-KU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dSnut-0004cU-Eo
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:43 -0400
Date: Wed, 5 Jul 2017 18:16:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170705171617.GD2284@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-26-dgilbert@redhat.com>
	<20170705005657-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705005657-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC 25/29] vhu: enable = false on get_vring_base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Wed, Jun 28, 2017 at 08:00:43PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > When we receive a GET_VRING_BASE message set enable = false
> > to stop any new received packets modifying the ring.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> I think I already reviewed a similar patch.

Yes you replied to my off-list mail; I hadn't got
around to fixing it yet.

> Spec says:
> Client must only process each ring when it is started.

but in that reply you said the spec said 

  Client must only pass data between the ring and the
  backend, when the ring is enabled.

So does the spec say 'started' or 'enabled'
(Pointer to the spec?)

> IMHO the real fix is to fix client to check the started
> flag before processing the ring.

Yep I can do that.  I was curious however whether it was
specified as 'started' or 'enabled' or both.

Dave

> > ---
> >  contrib/libvhost-user/libvhost-user.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> > index ceddeac74f..d37052b7b0 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -652,6 +652,7 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
> >      vmsg->size = sizeof(vmsg->payload.state);
> >  
> >      dev->vq[index].started = false;
> > +    dev->vq[index].enable = false;
> >      if (dev->iface->queue_set_started) {
> >          dev->iface->queue_set_started(dev, index, false);
> >      }
> > -- 
> > 2.13.0
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
