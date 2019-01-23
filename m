Received: from eggs.gnu.org ([209.51.188.92]:54871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmIcU-0007Dg-Rr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmIcT-0007oZ-29
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:31:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53898
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gmIcS-0007o3-8i
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:31:04 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0NDUSHw094379
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 08:31:03 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q6r0hkcjj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 08:31:03 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 23 Jan 2019 13:30:57 -0000
Date: Wed, 23 Jan 2019 14:30:51 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190123112112.7822b237.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190122193346.4e23e018@oc2783563651>
	<20190123112112.7822b237.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190123143051.2610e590@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Wed, 23 Jan 2019 11:21:12 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 22 Jan 2019 19:33:46 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 21 Jan 2019 12:03:51 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > --- a/drivers/s390/cio/vfio_ccw_private.h
> > > +++ b/drivers/s390/cio/vfio_ccw_private.h
> > > @@ -28,6 +28,7 @@
> > >   * @mdev: pointer to the mediated device
> > >   * @nb: notifier for vfio events
> > >   * @io_region: MMIO region to input/output I/O arguments/results
> > > + * @io_mutex: protect against concurrent update of I/O structures  
> > 
> > We could be a bit more specific about what does this mutex guard.
> > Is it only io_region, or cp, irb and the new regions a well? ->state does
> > not seem to be covered, but should need some sort of synchronisation
> > too, or?
> 
> I'm not sure. IIRC Pierre had some ideas about locking in the fsm?
> 

Yes there was something. I usually do review by sanity checking the
resulting code. IMHO the fsm stuff is broken now and differently broken
after this series. If we don't want to fix what we are touching, maybe a
pointing out ignored problems in patch descriptions and a
minimal-invasive approach could help ease review.

Regards,
Halil

> > 
> > >   * @cp: channel program for the current I/O operation
> > >   * @irb: irb info received from interrupt
> > >   * @scsw: scsw info
> > > @@ -42,6 +43,7 @@ struct vfio_ccw_private {
> > >  	struct mdev_device	*mdev;
> > >  	struct notifier_block	nb;
> > >  	struct ccw_io_region	*io_region;
> > > +	struct mutex		io_mutex;
> > >  
> > >  	struct channel_program	cp;
> > >  	struct irb		irb;
> > > --   
> > 
> 
> 
