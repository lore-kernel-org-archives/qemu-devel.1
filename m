Received: from eggs.gnu.org ([209.51.188.92]:36125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmFez-00063W-GC
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmFet-0001iv-CB
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:21:27 -0500
Date: Wed, 23 Jan 2019 11:21:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190123112112.7822b237.cohuck@redhat.com>
In-Reply-To: <20190122193346.4e23e018@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190122193346.4e23e018@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 22 Jan 2019 19:33:46 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 21 Jan 2019 12:03:51 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > --- a/drivers/s390/cio/vfio_ccw_private.h
> > +++ b/drivers/s390/cio/vfio_ccw_private.h
> > @@ -28,6 +28,7 @@
> >   * @mdev: pointer to the mediated device
> >   * @nb: notifier for vfio events
> >   * @io_region: MMIO region to input/output I/O arguments/results
> > + * @io_mutex: protect against concurrent update of I/O structures  
> 
> We could be a bit more specific about what does this mutex guard.
> Is it only io_region, or cp, irb and the new regions a well? ->state does
> not seem to be covered, but should need some sort of synchronisation
> too, or?

I'm not sure. IIRC Pierre had some ideas about locking in the fsm?

> 
> >   * @cp: channel program for the current I/O operation
> >   * @irb: irb info received from interrupt
> >   * @scsw: scsw info
> > @@ -42,6 +43,7 @@ struct vfio_ccw_private {
> >  	struct mdev_device	*mdev;
> >  	struct notifier_block	nb;
> >  	struct ccw_io_region	*io_region;
> > +	struct mutex		io_mutex;
> >  
> >  	struct channel_program	cp;
> >  	struct irb		irb;
> > --   
> 
